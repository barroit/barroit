# SPDX-License-Identifier: GPL-3.0-or-later

$fs_rule = [System.Security.AccessControl.FileSystemAccessRule]

if (-not (force_exec) -and (setup_done)) {
	log 'Copying private keys ... Skipped'
	exit
}

$src_dir = 'S:\'
$ssh_dir = "$HOME\.ssh"

New-Item -ItemType Directory $ssh_dir

if (-not (Test-Path $src_dir)) {
	die "missing secstor mount point on '$src_dir'"
}

$rule = New-Object $fs_rule($env:USERNAME, 'Read', 'Allow')

:dumbass foreach ($name in (Get-ChildItem -Filter *.gpg -Name $src_dir)) {
	$key = "$src_dir\$name"

	log "Importing $name ..."

	switch -Regex ($name) {
	'^pg' {
		gpg --import $key

		if (-not $?) {
			error "failed to import $name"
			continue dumbass
		}
	}
	'^id' {
		$name = (Get-Item $key).BaseName
		$dst = "$ssh_dir\$name"

		if (Test-Path $dst) {
			Remove-Item $dst
		}

		gpg -o $dst -d $key

		if (-not $?) {
			error "failed to import $name"
			continue dumbass
		}

		$acl = Get-Acl $dst

		$acl.SetAccessRuleProtection($true, $false)

		$acl.Access | ForEach-Object {
			$acl.RemoveAccessRule($_)
		}

		$acl.AddAccessRule($rule)
		Set-Acl $dst $acl
	}
	default {
		continue dumbass
	}
	}

	log "Importing $name ... DONE"
}

mark_setup_done
log 'Copying private keys ... OK'
