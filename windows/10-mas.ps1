# SPDX-License-Identifier: GPL-3.0-or-later

function activated
{
	$ret = Get-CimInstance -Query "SELECT LicenseStatus `
				       FROM SoftwareLicensingProduct `
				       WHERE PartialProductKey IS NOT NULL"

	return $ret.LicenseStatus -eq 1
}

if (activated) {
	log 'Activating Windows ... Skipped'
	exit
}

$domain = c1 mas $INIT_D_DIR\urlmap

Invoke-RestMethod $domain | Invoke-Expression

if (-not (activated)) {
	die 'failed to activate Windows'
}

log 'Activating Windows ... OK'
