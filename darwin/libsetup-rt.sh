#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

function datadir()
{
	printf %s "$HOME/Library/Application Support/barroit"
}

mkdir -p "$(datadir)"
