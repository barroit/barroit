#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

invalid=$(git diff-index --cached --name-only \
	  --diff-filter=A -z HEAD | LC_ALL=C tr '[ -~]\0' '\0\n')

if [ -n "$invalid" ]; then
	lines=$(printf '\n  %s' $invalid)

	printf 'non-ascii file name%s\n' "$lines" >&2
	exit 1
fi

files=$(git diff-index --cached --name-only HEAD)

if [ -z "$files" ]; then
	printf 'Already up to date\n'
	exit 1
fi

git diff --cached --check

printf '%s\n' "$files" | xargs -P$(nproc) -n1 -- \
codespell --config $HOME/.codespellrc --config $(pwd)/.codespellrc
