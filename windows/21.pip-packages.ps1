# SPDX-License-Identifier: GPL-3.0-or-later

if (-not (force_exec) -and (setup_done)) {
	log 'Installing pip packages ... Skipped'
	exit
}

foreach ($name in Get-Content $INIT_D_DIR\pip.list.win) {
	if (skip_line $name) {
		continue
	}

	pip install $name
}

mark_setup_done
log 'Installing pip packages ... OK'
