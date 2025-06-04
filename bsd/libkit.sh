#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

if [ -z "$LIBKIT_ROOT" ]; then
	exit 128
fi

. $LIBKIT_ROOT/../posix/libkit.sh

current()
{
	perl -MTime::HiRes=time -E 'printf "%.2f\n", time'
}

virt()
{
	test 1 -eq 1
}

laptop()
{
	test 1 -eq 0
}
