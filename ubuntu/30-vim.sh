#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if ! exec_is_force && [[ $(which vim) == $HOME* ]]; then
	log 'Compiling Vim ... Skipped'
	exit
fi

mkdir -p git
cd git

if [[ ! -d vim ]]; then
	git clone $(v1 $CONFIG_ROOT/urlmap vim)
fi

cd vim/src

make distclean

CFLAGS='-O2' ./configure --prefix=$HOME/.local

make -j

make install

log 'Compiling Vim ... OK'
