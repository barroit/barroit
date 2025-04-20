#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

this=$(perl -e 'use Cwd "abs_path"; print abs_path(shift); "\n"' $0)
root=$(dirname $this)/..

. $root/posix/libkit.sh

invalid=$(git diff-index --cached --name-only \
	  --diff-filter=A -z HEAD | LC_ALL=C tr '[ -~]\0' '\0\n')

if [ -n "$invalid" ]; then
	lines=$(printf '\n  %s' $invalid)

	die "non-ascii file name%s\n" "$lines" >&2
fi

files=$(git diff-index --cached --name-only HEAD)

if [ -z "$files" ]; then
	exit 0
fi

printf '%s\n' "$files" | xargs -P$(nproc) -n1 codespell

if [ $? -ne 0 ]; then
	exit 1
fi
