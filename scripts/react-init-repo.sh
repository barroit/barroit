#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later
# If you use this wrong, it fails silently.

set -e

test -d $(pwd)/../../barroit

ln -snf ../../barroit/addon addon
ln -snf ../../barroit/react react
ln -sf ../build/styles/index.css index.css

cd ..

ln -snf ../barroit/styles ../styles

mkdir -p scripts
ln -sf ../../barroit/scripts/styles-fix.sh scripts/styles-fix.sh
