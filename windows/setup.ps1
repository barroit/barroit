# SPDX-License-Identifier: GPL-3.0-or-later

#requires -version 7

. $PSScriptRoot\libkit.ps1

$scripts = Get-ChildItem -Name -Filter ??-*.ps1 $PSScriptRoot

if ($args.Length) {
	$name = $args[0]

	if ($name[0] -eq '+') {
		$force = 1
		$name = $name.Substring(1);
	}

	if ($name -notmatch '^\d\d-.+\.ps1$') {
		$script = $scripts | Where-Object {
			$_ -match "^\d\d-$name.*\.ps1$"
		}

		if ($script -is [array]) {
			$ambig = $script | ForEach-Object { "`n  $_" }

			die "ambiguous script ``$name'; could be:$ambig"
		} elseif ($script -isnot [string]) {
			die "unknown script ``$name'"
		}
	} elseif (-not (Test-Path $PSScriptRoot\$name)) {
		die "unknown script ``$name'"
	} else {
		$script = $name
	}

	$cmd = "& '$PSScriptRoot\$script'"

	if ($force) {
		$cmd += " Force=1"
	}

	log "Executing $PSScriptRoot\$script"

	pwsh -Command ". '$PSScriptRoot\libkit.ps1'; sync-env-path; $cmd"
	exit
}

foreach ($script in $scripts) {
	pwsh -Command ". '$PSScriptRoot\libkit.ps1'; `
		       sync-env-path; & '$PSScriptRoot\$script'"

	if (-not $?) {
		warn "$PSScriptRoot\$script interrupted"
	}
}
