# SPDX-License-Identifier: GPL-3.0-or-later

$dst_dir = "$HOME\vimfiles\autoload"
$dst = "$dst_dir\plug.vim"

if ((Test-Path $dst) -and -not (sr_is_force $args)) {
	log 'Installing vim plug ... Skipped'
	exit
}

if (-not (Test-Path $dst_dir)) {
	New-Item -ItemType Directory $dst_dir >NUL
}

$url = c1 $PSScriptRoot\..\config\urlmap vimplug

curl -o $dst $url

log 'Installing vim plug ... OK'
