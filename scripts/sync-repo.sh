#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

branch=$(git branch --show-current)

git push

git add .
git commit -smTMP

trap 'git reset --hard HEAD^' EXIT

if [ "$(uname -o)" = 'GNU/Linux' ]; then
	host=dev.macos
else
	host=dev.ubuntu
fi

git format-patch HEAD~1 --stdout | ssh $host "
set -e

cd ~/${PWD#$HOME/}
export PATH=\$HOME/.local/bin:\$PATH

git switch $branch

track=\$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
remote=\${track%%/*}

git fetch \$remote
git reset --hard \$track

git am -
git reset HEAD^
"
