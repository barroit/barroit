#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

mkdir -p build

# PostCSS follows symlinks by their *smart* design, so use hardlink to
# block that dumb behavior.
cp -RL react/styles/. build/styles

ln -sf ../build/styles/index.css $1/index.css
ln -snf ../react $1/react
