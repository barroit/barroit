#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

mkdir -p build

# PostCSS follows symlinks by their *smart* design, so use hardlink to
# block that dumb behavior.
find -L styles -type f | while read name; do
	mkdir -p build/$(dirname $name)
	ln -f $name build/$name
done
