# SPDX-License-Identifier: GPL-3.0-or-later

if (Test-Path $HOME/vcpkg) {
	log 'Deploying vcpkg ... Skipped'
	exit
}

cd $HOME
git clone https://github.com/microsoft/vcpkg.git

cd vcpkg
& .\bootstrap-vcpkg.bat

push_path $PWD
setenv VCPKG_PREFIX $PWD

log 'Deploying vcpkg ... OK'
