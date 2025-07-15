#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

script_path=$(perl -e 'use Cwd "abs_path"; print abs_path(shift); "\n"' $0)
script_root=$(dirname $script_path)

. $script_root/../posix/libkit.sh

if [ -z "$1" ]; then
	die 'missing ref'
fi

if ! git rev-parse --verify --quiet $1 >/dev/null; then
	die "invalid ref '$1'"
fi

if [ -n "$(git status --short)" ]; then
	die 'stash your worktree and index'
fi

that=$(git rev-parse --symbolic-full-name $1)
that_remote=$(git for-each-ref --format='%(upstream:remotename)' $that)

if [ -z "$that_remote" ]; then
	name=$(git for-each-ref --format='%(refname:rstrip=-2)' $that)

	if [ $name = refs/remotes ]; then
		name=$(git for-each-ref --format='%(refname:rstrip=-3)' $that)
		that_remote=${name##*/}
	fi
fi

if [ -z "$that_remote" ]; then
	that_remote_line='That-remote: NULL'
else
	that_remtoe_url=$(git remote get-url $that_remote)
	that_remote_line="That-remote: $that_remtoe_url ($that_remote)"
fi

this=$(git branch --show-current)
base=$(git merge-base $this $that)

this_ref=$(git rev-parse --symbolic-full-name $this)
this_remote=$(git for-each-ref --format='%(upstream:remotename)' $this_ref)

if [ -z "$this_remote" ]; then
	this_remote_line='This-remote: NULL'
else
	this_remtoe_url=$(git remote get-url $this_remote)
	this_remote_line="This-remote: $this_remtoe_url ($this_remote)"
fi

if [ -z "$this_remote" ]; then
	this_remote=NULL
fi

if [ $base = $(git rev-parse $that^{commit}) ]; then
	printf 'nothing to merge\n'
	exit
fi

top=$(git log --pretty='%h' -1 $this)
history=$(git log --format='%s' $base..$that | grep :)
gitdir=$(git rev-parse --git-dir)

cat <<EOF > $gitdir/MERGE_MSG.1
Merge $1 into $this

This commit merges ${that#*/} at $top.

======== CHANGELOG ========

$(printf '%s\n' "$history" | $script_root/group-history.py)

$that_remote_line
$this_remote_line
Signed-off-by: $(git var GIT_AUTHOR_IDENT | cut -d' ' -f-3)
EOF

cp $gitdir/MERGE_MSG.1 $gitdir/MERGE_MSG

if git merge --no-ff --no-commit --no-edit $that; then
	do_ff=1
elif [ -f .pickignore ]; then
	for file in $(cat .pickignore); do
		if [ -f $file ]; then
			git rm $file
		fi
	done
fi

if [ -f .licensefix ]; then
	new=$(v1 .licensefix new)
	old=$(v1 .licensefix old)

	$script_root/../scripts/fix-license.sh "$old" "$new"
fi

if [ -f ./scripts/merge-fix.sh ] && [ -x ./scripts/merge-fix.sh ]; then
	./scripts/merge-fix.sh
fi

cp $gitdir/MERGE_MSG.1 $gitdir/MERGE_MSG

if [ -z "$(git diff --name-only --diff-filter=U)" ] || [ $do_ff ]; then
	git add .
	git merge --continue
fi
