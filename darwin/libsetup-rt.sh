#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

datadir()
{
	printf '%s\n' "$HOME/Library/Application Support/barroit"
}

userbin()
{
	printf '%s\n' "$HOME/.local/bin"
}
