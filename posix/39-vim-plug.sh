#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! exec_is_force && setup_is_done; then
	log 'Installing vim plug ... Skipped'
	exit
fi

dst=$HOME/.vim/autoload/plug.vim

if [ ! -f $dst ]; then
	mkdir -p $(dirname $dst)
fi

curl -Lo $dst $(v1 $CONFIG_ROOT/urlmap vimplug)

setup_done
log 'Installing vim plug ... OK'
