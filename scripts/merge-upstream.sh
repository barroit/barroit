#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

script_path=$(perl -e 'use Cwd "abs_path"; print abs_path(shift); "\n"' $0)
script_root=$(dirname $script_path)

. $script_root/../posix/libkit.sh

if [ -z "$1" ]; then
	die 'missing ref'
fi

if [ -n "$(git status --short)" ]; then
	die "stash your worktree and index"
fi

ref=$1
branch=$(git branch --show-current)
base=$(git merge-base $branch $ref)

if [ $base = $(git rev-parse $ref) ]; then
	printf 'nothing to merge.\n'
	exit
fi

top=$(git log --pretty='%h' -1 $ref)
history=$(git log --format='%s' $base..$ref | grep :)
gitdir=$(git rev-parse --git-dir)

cat <<EOF > $gitdir/MERGE_MSG.1
Merge upstream $ref

This commit merges upstream $ref at $top.

======== CHANGELOG ========

$(printf '%s\n' "$history" | $script_root/group-history.py)

Signed-off-by: $(git var GIT_AUTHOR_IDENT | cut -d' ' -f-3)
EOF

cp $gitdir/MERGE_MSG.1 $gitdir/MERGE_MSG

if git merge --no-ff --no-commit --no-edit $ref; then
	do_ff=1
elif [ -f .pickignore ]; then
	for file in $(cat .pickignore); do
		if [ -f $file ]; then
			git rm $file
		fi
	done
fi

if [ -f .licensefix ]; then
	new=$(v2 .licensefix new)
	old=$(v2 .licensefix old)

	$root/scripts/fix-license.sh "$old" "$new"
fi

cp $gitdir/MERGE_MSG.1 $gitdir/MERGE_MSG

if [ -z "$(git diff --name-only --diff-filter=U)" ] || [ $do_ff ]; then
	git add .
	git merge --continue
fi
