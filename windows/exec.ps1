# SPDX-License-Identifier: GPL-3.0-or-later

param (
	[switch]$__force,
	[string]$__script
)

$ErrorActionPreference = 'Stop'

$__repo_root = "$PSScriptRoot\.."
$__libkit_root = "$__repo_root\nt"

. $__libkit_root\libkit.ps1
. $__libkit_root\libsetup.ps1

. $__libkit_root\libstrutil.ps1
. $__libkit_root\libsyscall.ps1

$SCRIPT_NAME = (Split-Path -Leaf $__script)
$SCRIPT_PATH = $__script
$ASSETS_DIR = "$__repo_root\assets"
$SCRIPT_DIR = "$__repo_root\scripts"
$INIT_D_DIR = "$__repo_root\sysinit.d"

if ($__force) {
	$FORCE_EXEC = 1
}

sync_path

. $__script
