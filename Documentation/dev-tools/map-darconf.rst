.. SPDX-License-Identifier: GPL-3.0-or-later

===========
Map Darconf
===========

Symlinking this file is okay.

You must be at the root of this repo.

SYNOPSIS
========

::

	map-darconf.sh

DESCRIPTION
===========

This script adds a worktree at ``../barroit-macos`` and makes symlinks
from that worktree to destination files. It greps destinations from
``sysinit.d/filemap-macos``. The list of symlink sources is hardcoded.
Currently, they are:

   - code/settings.json

This script only creates worktree if it doesn't exist. It never updates that
worktree.
