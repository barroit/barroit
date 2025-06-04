#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

if ! exec_is_force && setup_is_done; then
	log 'Generating command alias map ... Skipped'
	exit
fi

dst=$HOME/.aliases

touch $(shrc)
touch $dst

while read line; do
	if skip_line "$line"; then
		continue
	fi

	name=$(r1 "$line")
	cmd=$(r2 "$line")
	prefix="alias $name"

	if grep -q "$prefix=" $dst; then
		sed "s|^$prefix='.*'$|$prefix='$cmd'|" $dst >$dst.$$
		mv $dst.$$ $dst
	else
		printf '\n%s\n' "$prefix='$cmd'" >>$dst
	fi

done < $CONFIG_ROOT/aliasmap

line='[ -f $HOME/.aliases ] && . $HOME/.aliases'

if ! grep -Fq "$line" $(shrc); then
	printf '\n# %s\n%s\n' $SCRIPT_NAME "$line" >>$(shrc)
fi

setup_done
log 'Generating command alias map ... OK'
