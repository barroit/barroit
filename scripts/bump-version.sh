#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

script_path=$(perl -e 'use Cwd "abs_path"; print abs_path(shift); "\n"' $0)
script_root=$(dirname $script_path)

. $script_root/../posix/libkit.sh

if [ ! -f NAME ]; then
	die 'missing NAME file'
fi

if [ -n "$1" ]; then
	versrc=$1
elif [ -f VERSION ]; then
	versrc=VERSION
else
	die 'missing version source'
fi

if [ ! "$(git diff $versrc)" ] &&
   [ ! "$(git diff --staged $versrc)" ] &&
   [ $(git ls-files $versrc) ]; then
	die "no changes in $versrc"
fi

git add $versrc

name=$(cat NAME)
version=$(cat $versrc)

git commit -m "$name $version"

git tag -sm "$name $version" "v$version"
