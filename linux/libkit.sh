#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if [[ ! $LIBKIT_ROOT ]]; then
	exit 128
fi

source $LIBKIT_ROOT/../posix/libkit.sh

function current()
{
	cut -d' ' -f2 /proc/uptime
}

function virt()
{
	test $(systemd-detect-virt) != none
}

function laptop()
{
	ls /sys/class/power_supply/BAT* >/dev/null 2>&1
}
