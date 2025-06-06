# SPDX-License-Identifier: GPL-3.0-or-later

#requires -version 7

$script_root = $PSScriptRoot
$libkit_root = "$script_root\..\nt"

. $libkit_root\libkit.ps1

if ($args.Length) {
	$name = $args[0]

	if ($name[0] -eq '+') {
		$force = 1
		$name = $name.Substring(1);
	}

	if ($name -match '^\d\d-') {
		$scripts = Get-ChildItem -Name -Filter $name $script_root
	} else {
		$scripts = Get-ChildItem -Name `
					 -Filter ??-$name*.ps1 $script_root
	}

	if (-not $scripts) {
		die "unknown script '$name'"
	}

	if ($scripts -is [array]) {
		$lines = $scripts | ForEach-Object { "`n  $_" }

		die "ambiguous name '$name'; could be:$lines"
	}
}

if (-not $scripts) {
	$scripts = Get-ChildItem -Name -Filter ??-*.ps1 $script_root
}

foreach ($name in $scripts) {
	$script = "$script_root\$name"

	if (-not $force) {
		pwsh $script_root\exec.ps1 $script
	} else {
		pwsh $script_root\exec.ps1 -__force $script
	}

	if (-not $?) {
		warn "$script interrupted"
	}
}
