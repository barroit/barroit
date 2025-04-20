#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

setup_is_done()
{
	touch "$(datadir)/done"

	grep -q $SCRIPT_NAME "$(datadir)/done"
}

setup_done()
{
	if ! setup_is_done; then
		printf '%s\n' $SCRIPT_NAME >> "$(datadir)/done"
	fi
}

exec_is_force()
{
	test $SCRIPT_NAME = "$FORCE_EXEC"
}
