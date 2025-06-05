# SPDX-License-Identifier: GPL-3.0-or-later

# FIXME: this script broken on arm64.

if (-not (force_exec) -and (setup_done)) {
	log 'Installing BuildTools ... Skipped'
	exit
}

$id = 'Microsoft.VisualStudio.2022.BuildTools'

if ($Env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
	$vctool = 'Microsoft.VisualStudio.Component.VC.Tools.ARM64'
} else {
	$vctool = 'Microsoft.VisualStudio.Component.VC.Tools.x86.x64'
}

$sdk = 'Microsoft.VisualStudio.Component.Windows11SDK.26100'
$asan = 'Microsoft.VisualStudio.Component.VC.ASAN'

winget install --id=$id --custom="`"--add $vctool --add $sdk --add $asan`""

push_path "${Env:PROGRAMFILES(x86)}\Microsoft Visual Studio\Installer"

$root = & vswhere.exe -products * -requires *.ASAN -property installationPath
$msvc = (Get-ChildItem "$root\VC\Tools\MSVC").FullName

push_path "$msvc\bin\Hostx64\x64"

mark_setup_done
log 'Installing BuildTools ... OK'
