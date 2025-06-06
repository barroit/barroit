# SPDX-License-Identifier: GPL-3.0-or-later

if (-not (force_exec) -and (setup_done)) {
	log 'Installing vcpkg packages ... Skipped'
	exit
}

if (virt) {
	$in_virt = 1
}

foreach ($name in Get-Content $INIT_D_DIR\vcpkg.list) {
	if (skip_line $name) {
		continue
	}

	$cols = split_column $line

	$name = $cols[0]
	$type = $cols[1]

	if (skip_package $type) {
		continue
	}

	vcpkg install $name
}

$cols = vcpkg list $name | ForEach-Object { $_ -split ' ' }
$cols = $cols[0] -split ':'
$triplet = $cols[1]

setenv VCPKG_PACKAGE_PREFIX "$Env:VCPKG_PREFIX\installed\$triplet"

mark_setup_done
log 'Installing vcpkg packages ... OK'
