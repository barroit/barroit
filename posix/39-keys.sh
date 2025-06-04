#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! exec_is_force && setup_is_done; then
	log 'Deploying keys ... Skipped'
	exit
fi

key_dir=$(secstor)
dst_dir=$HOME/.ssh

if [ ! -d $key_dir ]; then
	die "missing mount point on '$key_dir'"
fi

mkdir -p $dst_dir

for key in $(ls $key_dir); do
	case $key in
	pg_*.gpg)
		if ! confirm "import $key?"; then
			continue
		fi

		gpg --import $key_dir/$key

		if [ $? -ne 0 ]; then
			error "Importing $key ... Failed"
			continue
		fi
		;;

	id_*.gpg)
		dst=$dst_dir/${key%.gpg}

		if ! confirm "decrypt $key to $dst_dir?"; then
			log "Importing $key ... Skipped"
			continue
		fi

		gpg --yes -o $dst -d $key_dir/$key

		if [ $? -ne 0 ]; then
			error "Importing $key ... Failed"
			continue
		fi

		chmod 0600 $dst
		;;
	*)
		continue
	esac

	log "Importing $key ... DONE"
done

setup_done
log 'Deploying keys ... OK'
