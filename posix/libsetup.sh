#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

if [ ! $LIBKIT_ROOT ]; then
	exit 128
fi

__repo_root=$(dirname $0)/..

export SCRIPT_NAME=$1
export ASSETS_ROOT=$__repo_root/assets
export SCRIPT_ROOT=$__repo_root/scripts
export CONFIG_ROOT=$__repo_root/config

. $LIBKIT_ROOT/libsetup-rt.sh

mkdir -p "$(datadir)"

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

# Only use this in consumer scripts.
os_name()
{
	basename $(dirname $1)
}
