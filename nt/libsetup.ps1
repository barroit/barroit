# SPDX-License-Identifier: GPL-3.0-or-later

$setup_cache = 'HKCU:\Software\Barroit\Barroit'

function mark_setup_done
{
	if (-not (Test-Path $setup_cache)) {
		New-Item $setup_cache >nul
	}

	Set-ItemProperty -Type DWord $setup_cache $SCRIPT_NAME 1
}

function setup_done
{
	# We can't catch missing $setup_cache exception as it's non-terminating
	# error.
	if (-not (Test-Path $setup_cache)) {
		return $false
	}

	try {
		$ret = Get-ItemPropertyValue $setup_cache $SCRIPT_NAME
	} catch {
		return $false
	}

	return $ret -eq 1
}

function force_exec
{
	return $FORCE_EXEC
}
