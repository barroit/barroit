#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

this=$(perl -e 'use Cwd "abs_path"; print abs_path(shift); "\n"' $0)
root=$(dirname $this)/..
hooks=$(git rev-parse --git-dir)/hooks

src=$(cat <<-EOF | perl -l - $root $hooks
	require File::Spec;
	print File::Spec->abs2rel(shift, shift);
EOF
)/hooks

ln -sf $src/pre-commit.sh $hooks/pre-commit
ln -sf $src/prepare-commit-msg.sh $hooks/prepare-commit-msg
