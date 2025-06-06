#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

mkdir -p .github/workflows
mkdir -p LICENSES

cp -f ../barroit/sphinx/workflow.yml .github/workflows/docs.yml

if [ ! -f LICENSES/0BSD ]; then
	cp ../barroit/LICENSES/0BSD LICENSES/0BSD
fi

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
