# SPDX-License-Identifier: GPL-3.0-or-later

$BOLD	= "`e[1m"
$RED	= "`e[31m"
$YELLOW	= "`e[33m"
$GREEN	= "`e[32m"
$CYAN	= "`e[36m"
$WHITE	= "`e[37m"
$RESET	= "`e[0m"

function current
{
	$prev = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
	$next = Get-Date
	$uptime = $next - $prev

	return '{0:F2}' -f $uptime.TotalSeconds
}

function die
{
	Write-Output "${BOLD}${RED}fatal:${RESET} $args"
	exit 128
}

function error
{
	Write-Output "${BOLD}${RED}error:${RESET} $args"
}

function warn
{
	Write-Output "${BOLD}${YELLOW}warn:${RESET} $args"
}

function note
{
	Write-Output "${BOLD}${CYAN}note:${RESET} $args"
}

function log
{
	Write-Output "${BOLD}${GREEN}[$(current)]${RESET} $args"
}

function confirm
{
	Write-Host -NoNewline "$($args[0]) [y/N] "

	do {
		$yn = $Host.UI.RawUI.ReadKey().Character
	} while (-not $yn)

	Write-Host ''
	return $yn -match '^(y|yes)$'
}

function skip_line
{
	return -not $args[0] -or ($args[0] -match '^#')
}

function virt
{
	$info = Get-WmiObject Win32_ComputerSystem

	return $info.Manufacturer -eq 'VMware, Inc.'
}

function laptop
{
	return Get-CimInstance Win32_Battery
}

function c1
{
	Select-String ^$($args[0]) $args[1] | ForEach-Object {
		($_ -split '\t+')[1]
	}
}

function c2
{
	Select-String ^$($args[0]) $args[1] | ForEach-Object {
		($_ -split '\t+')[2]
	}
}

function c3
{
	Select-String ^$($args[0]) $args[1] | ForEach-Object {
		($_ -split '\t+')[3]
	}
}

function c4
{
	Select-String ^$($args[0]) $args[1] | ForEach-Object {
		($_ -split '\t+')[4]
	}
}

function is_admin
{
	$user = [Security.Principal.WindowsIdentity]::GetCurrent()
	$user = [Security.Principal.WindowsPrincipal]$user
	$admin = [Security.Principal.WindowsBuiltInRole]::Administrator

	return $user.IsInRole($admin)
}

function admin_exec
{
	$letter = $PSScriptRoot[0]
	$drive = Get-PSDrive $letter

	if ($drive.DisplayRoot) {
		$root = $drive.DisplayRoot.TrimEnd([char]0)
		$cmd += "New-PSDrive $letter FileSystem '$root'; "
	}

	$cmd += "& $PSScriptRoot\setup.ps1 $($args[0])"

	$Env:IN_ADMIN_EXEC = 1

	Start-Process -Verb RunAs -Wait pwsh '-Command', $cmd
}

function in_admin_exec
{
	return $Env:IN_ADMIN_EXEC
}

function __getenv
{
	[Environment]::GetEnvironmentVariable($args[0], $args[1])
}

function __setenv
{
	[Environment]::SetEnvironmentVariable($args[0], $args[1], $args[2])
}

function getenv
{
	__getenv $args[0] 'User'
}

function setenv
{
	__setenv $args[0] $args[1] 'User'
}

function sync_path
{
	$user = getenv 'PATH'
	$sys = __getenv 'PATH' 'Machine'

	$Env:PATH = "$user;$sys"
}

function push_path
{
	$name = $args[0]
	$old = getenv 'PATH'

	$new = "$old;$name"
	$seen = $old -split ';' | Where-Object { $_ -eq $name }

	if (-not $seen) {
		setenv 'PATH' $new
	}

	sync_path
}

function split_column
{
	@($args[0] -split '\t+')
}
