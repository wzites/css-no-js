#

git log -1 \
--pretty=format:'--- # git-commit-data%ncommit: "%H"%nauthor: "%an <%ae>"%ndate: "%ad"%nmessage: "%s"%n...' > _data/git-info.yml
jekyll build --draft --trace

