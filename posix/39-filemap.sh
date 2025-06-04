#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

if ! exec_is_force && setup_is_done; then
	log 'Mapping files ... Skipped'
	exit
fi

while read line; do
	if line_need_skip "$line"; then
		continue
	fi

	name=$(r1 "$line")
	dst_dir=$(r2 "$line")

	if [ -z "$dst_dir" ] || [ "$dst_dir" = - ]; then
		dst_dir=$(r2 "$(grep $name $CONFIG_ROOT/filemap)")
	fi

	if [ -z "$dst_dir" ]; then
		warn "skipping '$name' as you fucked up '$CONFIG_ROOT/filemap'"
		continue
	fi

	dst_dir=$(eval "printf '%s\n' \"$dst_dir\"")
	mode=$(r3 "$line")

	src=$ASSETS_ROOT/$name
	dst=$dst_dir/$(basename $name)
	cmd='ln -sf'

	if printf "%s\n" $mode | grep -q copy; then
		cmd=cp
	fi

	if printf '%s\n' $mode | grep -q sudo; then
		cmd="sudo $cmd"
	fi

	mkdir -p "$dst_dir"
	eval "$cmd $src \"$dst\""

	if [ $? -eq 1 ]; then
		fmt="${CYAN}%-25s${RESET} -> ${RED}%s${RESET}\n"
	else
		fmt="${CYAN}%-25s${RESET} -> ${GREEN}%s${RESET}\n"
	fi

	printf "$fmt" $name "$dst"

done <$CONFIG_ROOT/filemap-$(os_name $0)

setup_done
log 'Mapping files ... OK'
