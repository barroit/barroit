#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! exec_is_force && setup_is_done; then
	log 'Installing helper scripts ... Skipped'
	exit
fi

while read line; do
	if line_need_skip "$line"; then
		continue
	fi

	ln -sf $SCRIPT_ROOT/$line $(userbin)/$line
done <$CONFIG_ROOT/helper.list

setup_done
log 'Installing helper scripts ... OK'
