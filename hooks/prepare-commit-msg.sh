#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

sed '/^. Please enter the commit message/,/^#$/d' $1 > $1.tmp
mv $1.tmp $1
