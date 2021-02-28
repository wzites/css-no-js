#

git log -1 \
--pretty=format:'--- # git-commit-data%ncommit: "%H"%nauthor: "%an <%ae>"%ndate: "%ad"%nmessage: "%s"%n' > _data/git-info.yml

git remote get-url github | sed -e 's,git@github.com:,git_url: https://github.com/,' >> _data/git-info.yml
git remote get-url origin | sed -e 's,^,origin_url: ,' >> _data/git-info.yml

version=$(version --time RELEASE.md)
tags=$(version --tags RELEASE.md)

# get github statuses :
curl -sL https://api.github.com/users/Organic-Technology/events | tee _data/git-events.json | json_xs -t yaml | grep -v -e '---' > _data/git-events.yml
curl -sL https://api.github.com/users/Mychelium/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/blockRing/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/michel47/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/willforge/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/fork42/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/wzites/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/200tm/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/crypthium/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/ColoredZone/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/PurpleZone/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/EO-Labs/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/GI-Labs/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/QIGQ/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/QIGW/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/Quantum-IO/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/GradualQuanta/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/jsdiscovr/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/holoSphereOS/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/MiscOldProjects/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml
curl -sL https://api.github.com/users/retired-code/events | json_xs -t yaml | grep -v -e '---' >> _data/git-events.yml

USER_NAME=$(git config user.name)
COMMITER_NAME=$(git config committer.name)
AUTHOR_NAME=$(git config author.name)

USER_NAME=${USER_NAME:-michelc}
COMMITER_NAME=${COMMITER_NAME:-iglake}
AUTHOR_NAME=${AUTHOR_NAME:-michel47}

GIT_USER_NAME=${GIT_USER_NAME:-$USER_NAME}
GIT_COMMITER_NAME=${GIT_COMMITER_NAME:-$COMMITER_NAME}
GIT_AUTHOR_NAME=${GIT_AUTHOR_NAME:-$AUTHOR_NAME}

rm -f __config.yml
cp -p _config.yml __config.yml
sed -e "s/user-name: .*/user-name: $GIT_USER_NAME/" \
    -e "s/commiter-name: .*/commiter-name: $GIT_COMMITER_NAME/" \
    -e "s/author-name: .*/author-name: $GIT_AUTHOR_NAME/" __config.yml | tee  _config.yml

jekyll build --draft --trace

exit $?;


true;
