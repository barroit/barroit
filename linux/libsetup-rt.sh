#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

datadir()
{
	printf '%s\n' $HOME/.local/share/barroit
}

userbin()
{
	printf '%s\n' $HOME/.local/bin
}

secstor()
{
	printf '%s\n' /media/$(whoami)/secret
}

shrc()
{
	printf '%s\n' $HOME/.bashrc
}
