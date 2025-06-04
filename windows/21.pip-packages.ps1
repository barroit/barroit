# SPDX-License-Identifier: GPL-3.0-or-later

if (-not (sr_is_force $args) -and (sr_is_done (script_name))) {
	log 'Installing pip packages ... Skipped'
	exit
}

$lines = read-line $PSScriptRoot\..\config\pip.list.win

foreach ($line in $lines) {
	if (-not $line -or $line -match '^#') {
		continue
	}

	pip install $line
}

sr_done (script_name)
log 'Installing pip packages ... OK'
