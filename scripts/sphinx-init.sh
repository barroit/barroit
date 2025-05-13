#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

script_path=$(perl -e 'use Cwd "abs_path"; print abs_path(shift); "\n"' $0)
script_root=$(dirname $script_path)
sphinx_root=$script_root/../sphinx

mkdir -p .github/workflows
ln -sf ../../../barroit/sphinx/workflow.yml .github/workflows/docs.yml

mkdir -p Documentation
cd Documentation

ln -sf ../../barroit/sphinx/Makefile
ln -sf ../../barroit/sphinx/conf.py

mkdir -p sphinx
cd sphinx

ln -sf ../../../barroit/sphinx/static
ln -sf ../../../barroit/sphinx/templates

cd ../..

if ! grep -q /Documentation/build .gitignore; then
	printf '\n%s\n' /Documentation/build >>.gitignore
fi
