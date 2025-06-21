#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

branch=$(git branch --show-current)

if [ -z "$(git for-each-ref --format '%(upstream:short)' $branch)" ]; then
	git push --set-upstream origin $branch
else
	git push
fi

git add .
git commit -smTMP

trap 'git reset HEAD^' EXIT

if [ $(uname -o) = GNU/Linux ]; then
	host=dev.macos
else
	host=dev.ubuntu
fi

upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
remote=${upstream%%/*}
branch=${upstream#*/}
remote_url=$(git remote get-url $remote)

git format-patch HEAD~1 --stdout | ssh $host "
set -e

cd \$HOME/${PWD#$HOME/}
export PATH=\$HOME/.local/bin:\$PATH

git remote add move-wip $remote_url

git fetch move-wip $branch
git switch -C $branch
git reset --hard move-wip/$branch

git am -

git reset HEAD^
git remote remove move-wip
"

trap 'git reset --hard HEAD^' EXIT
