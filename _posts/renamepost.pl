#!/usr/bin/perl

# $intent: add the date in filename (in post-slug format)$
# $birth: 1614236749 $

our $dbug = 1;
my $_1yrs = 365.25 * 24 * 3600;

my $postf = shift;
my @times = (lstat($postf))[8,9,10]; # atime, mtime,ctime

my $birth = &get_birth($postf);
my $vtime = (sort { $a <=> $b } @times[1,2])[-1];
my ($etime,$ltime) = (sort { $a <=> $b } @times)[0,-1];
my $age = ( $ltime - $birth ) / $_1yrs; # using 'late-time'
my ($fpath,$fname,$slug,$ext) = &fname($postf);
printf "--- # %s\n",(&fname($0))[1];
printf "fname: %s\n",$fname;
printf "birth: %s # %s\n",$birth, &hdate($birth);
printf "mtime: %s # %s\n",$times[1], &sdate($times[1]);
printf "vtime: %s # %s\n",$vtime, &sdate($vtime);
printf "etime: %s # %s\n",$etime, &sdate($etime);
printf "ltime: %s # %s\n",$ltime, &sdate($ltime);
printf "age: %s # %.2fm\n",$age,($ltime - $birth)/60;

my $ptime = ($etime < $birth) ? $etime : $birth;
my ($sec,$min,$hour,$mday,$mon,$yy) = (localtime($ptime))[0..5];
my $date = sprintf '%04d-%02d-%02d',1900+$yy,$mon+1,$mday;
my $rname = $slug; $rname =~ s/^[\d-]+//;

printf "slug: %s\n",$slug;
printf "date: %s\n",$date;
printf "ptime: %s\n",$ptime;
printf "rname: %s\n",$rname;
my $pname = sprintf '%s-%s.%s',$date,$rname,$ext;
printf "pname: %s\n",$pname;
if ($fname ne $pname) {
   link $postf, $pname;
   unlink $postf if (-f $pname);
}

printf "undo: |-\n mv %s %s\n",$pname,$postf;


# -----------------------------------------------------------------------
sub get_birth { # extract birth time from file
  local *F; open F,'<',$_[0];
  my $btic = 0;
  while (<F>) {
    if (m/\b\$?[bB]irth: (\d+)\s?\$/) { $btic = $1; last; }
    if (m/^birth: (\d+)$/) { $btic = $1; last; }
  }
  if ($btic == 0) { # try to see if there is a first git version ..
    my ($fpath,$fname,undef,undef) = &fname($_[0]);
    my $gitcmd = sprintf('git -C "%s" log --reverse --format="%%at" --all --full-history "%s"',$fpath,$fname);
    printf "info: %s\n", $gitcmd if $dbug;
    local *EXEC; open EXEC,"$gitcmd 2>/dev/null |" or warn $!;
    local $/ = "\n";
    $btic = <EXEC>; chomp($btic); close EXEC;
  }
  close F;
  if (! $btic) {
   $btic = (sort { $a <=> $b } (lstat($_[0]))[8,9,10])[0]; # smallest one !
  }
  printf "btic: %s\n",$btic if $dbug;
  return $btic;
}
# -----------------------------------------------------------------------
sub fname { # extract filename etc : returns ($fpath,$fname,$rname,$ext);
  my $f = shift;
  $f =~ s,\\,/,g; # *nix style !
  my $s = rindex($f,'/');
  my $fpath = '.';
  if ($s > 0) {
    $fpath = substr($f,0,$s);
  } else {
    use Cwd;
    $fpath = Cwd::getcwd();
  }
  my $fname = substr($f,$s+1); # filename (basename) including extension
  if (-d $f) {
    return ($fpath,$fname);
  } else {
  my $rname; # rootname
  my $ext; # extension
  my $p = rindex($fname,'.');
     $ext = lc substr($fname,$p+1);
     $ext =~ s/\~$//;
  if ($p > 0) {
    $rname = substr($fname,0,$p);
    $ext = lc substr($fname,$p+1);
    $ext =~ s/\~$//;
  } else {
    $rname = $fname;
    $ext = undef;
  }
  $rname =~ s/\s+\(\d+\)$//; # remove (1) in names ...

  return ($fpath,$fname,$rname,$ext);

  }
}
# -----------------------------------------------------------------------
sub hdate { # return HTTP date (RFC-1123, RFC-2822) 
  my ($time,$delta) = @_;
  my $stamp = $time+$delta;
  my $tic = int($stamp);
  #my $ms = ($stamp - $tic)*1000;
  my $DoW = [qw( Sun Mon Tue Wed Thu Fri Sat )];
  my $MoY = [qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec )];
  my ($sec,$min,$hour,$mday,$mon,$yy,$wday) = (gmtime($tic))[0..6];
  my ($yr4,$yr2) =($yy+1900,$yy%100);

  # Mon, 01 Jan 2010 00:00:00 GMT
  my $date = sprintf '%3s, %02d %3s %04u %02u:%02u:%02u GMT',
             $DoW->[$wday],$mday,$MoY->[$mon],$yr4, $hour,$min,$sec;
  return $date;
}
# -----------------------------------------------------------------------
sub sdate { # return a human readable date ... but still sortable ...
  my $tic = int ($_[0]);
  my $ms = ($_[0] - $tic) * 1000;
     $ms = ($ms) ? sprintf('%04u',$ms) : '____';
  my ($sec,$min,$hour,$mday,$mon,$yy) = (localtime($tic))[0..5];
  my ($yr4,$yr2) =($yy+1900,$yy%100);
  my $date = sprintf '%04u-%02u-%02u %02u.%02u.%02u',
             $yr4,$mon+1,$mday, $hour,$min,$sec;
  return $date;
}
# -----------------------------------------------------------------------

1;

