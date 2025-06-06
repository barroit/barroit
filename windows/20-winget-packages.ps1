# SPDX-License-Identifier: GPL-3.0-or-later

if (-not (force_exec) -and (setup_done)) {
	log 'Installing winget packages ... Skipped'
	exit
}

if (virt) {
	$in_virt = 1
}

foreach ($line in Get-Content $INIT_D_DIR\winget.list) {
	if (skip_line $line) {
		continue
	}

	$skip = 0
	$cols = split_column $line

	$name = $cols[0]
	$type = $cols[1]
	$path = $cols[2]

	if (skip_package $type) {
		continue
	}

	if ($path) {
		push_path (Invoke-Expression "`"$path`"")
	}

	winget install --id=$name
}

mark_setup_done
log 'Installing winget packages ... OK'
