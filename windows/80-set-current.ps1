# SPDX-License-Identifier: GPL-3.0-or-later
# NO MORE SYMLINKS ON WINDOWS. THE DEFAULT FILE SYSTEM FUCKED ME UP :(

if (-not (sr_is_force $args) -and (sr_is_done (script_name))) {
	log 'Symlinking current/ ... Skipped'
	exit
}

New-Item -ItemType SymbolicLink -Force -Target posix\ current

sr_done (script_name)
log 'Symlinking current/ ... OK'
