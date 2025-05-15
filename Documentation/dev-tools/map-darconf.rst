.. SPDX-License-Identifier: GPL-3.0-or-later

===========
Map Darconf
===========

Symlinking this file is okay.

Your cwd must be path/to/this/doc/dir/../..

SYNOPSIS
========

::

	map-darconf.sh

DESCRIPTION
===========

Add a worktree at ../barroit-macos and symlink worktree-modified files to
destination, which is read from config/file-map-macos.

This script only creates worktree ../barroit-macos if it doesn't exist. It
never updates that worktree.
