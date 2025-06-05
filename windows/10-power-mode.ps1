# SPDX-License-Identifier: GPL-3.0-or-later

$seen = powercfg /list | Where-Object { $_ -match '\(Barroit-[\w-]+\)( \*)?$' }

if ($seen -and -not (force_exec)) {
	log 'Adjusting power mode ... Skipped'
	exit
}

$mode = 'power-saver'
$default = 'a1841308-3541-4fab-bc81-f71556f20b4a'
$blank = c1 desk_blank $INIT_D_DIR\power-mode
$suspend = c1 desk_suspend $INIT_D_DIR\power-mode

if (laptop) {
	$blank = c1 lap_blank $INIT_D_DIR\power-mode
	$suspend = c1 lap_suspend $INIT_D_DIR\power-mode
}

if (virt) {
	$mode = 'balanced'
	$default = '381b4222-f694-41f0-9685-ff5bb260df2e'
	$blank = 0
	$suspend = 0
}

if ($seen) {
	$guid = [regex]::Match($seen, '[a-fA-F0-9-]{36}').Value

	powercfg /setactive $default
	powercfg /delete $guid
}

$ret = powercfg /duplicatescheme $default
$guid = [regex]::Match($ret, '[a-fA-F0-9\-]{36}').Value

powercfg /setactive $guid
powercfg /changename $guid Barroit-$mode

powercfg /change monitor-timeout-ac $blank
powercfg /change monitor-timeout-dc $blank
powercfg /change standby-timeout-ac $suspend
powercfg /change standby-timeout-dc $suspend

log 'Adjusting power mode ... OK'
