#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! exec_is_force && setup_is_done; then
	log 'Configuring Zsh auto completion ... Skipped'
	exit
fi

read -d '' lines <<EOF
autoload -Uz compinit
compinit
EOF

if ! grep -Fxq "$lines" ~/.zshrc; then
	printf '\n%s\n' "$lines" >> ~/.zshrc
fi

setup_done
log 'Configuring Zsh auto completion ... OK'
