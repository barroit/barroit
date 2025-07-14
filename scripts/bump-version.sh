#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

script_path=$(perl -e 'use Cwd "abs_path"; print abs_path(shift); "\n"' $0)
script_root=$(dirname $script_path)

. $script_root/../posix/libkit.sh

if [ ! -f NAME ]; then
	die 'missing NAME'
fi

if [ -n "$1" ]; then
	pathspec=$1
elif [ -f VERSION ]; then
	pathspec=VERSION
else
	die 'missing version source'
fi

if [ -n "$TAG_PREFIX" ]; then
	prefix="$TAG_PREFIX-"
fi

if git diff --quiet $pathspec &&
   git diff --quiet --staged $pathspec &&
   [ -n "$(git ls-files $pathspec)" ]; then
	die "no changes in $pathspec"
fi

git add $pathspec

name=$(cat NAME)
version=$(cat $pathspec)

git commit -m "$name $version"

git tag -sm "$name $version" "${prefix}v$version"
