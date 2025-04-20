#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

name=$(basename $LIBKIT_ROOT)

if ! exec_is_force && setup_is_done; then
	log "Linking \`$name' to 'current' ... Skipped"
	exit
fi

ln -snf $name current

setup_done
log "Linking \`$name' to 'current' ... OK"
