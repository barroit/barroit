# SPDX-License-Identifier: GPL-3.0-or-later

if (-not (force_exec) -and (Get-Command sshd 2>NUL)) {
	log 'Installing openssh ... Skipped'
	exit
}

if (-not (is_admin)) {
	admin_exec $SCRIPT_PATH

	note "you must run 'sshd' once as administrator after setup"
	log 'Installing openssh ... OK'
	exit
}

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

Start-Service sshd
Set-Service sshd -StartupType Automatic

New-ItemProperty -PropertyType String -Force `
		 -Value (Get-Command pwsh).Source `
		 'HKLM:\SOFTWARE\OpenSSH' DefaultShell

# User pwsh is already admin and admin_exec $SCRIPT_PATH skipped.
if (-not (in_admin_exec)) {
	note "you must run 'sshd' once as administrator after setup"
	log 'Installing openssh ... OK'
}
