#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

function datadir()
{
	printf %s $HOME/.local/share/barroit
}

mkdir -p $(datadir)
