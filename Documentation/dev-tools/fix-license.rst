.. SPDX-License-Identifier: GPL-3.0-or-later

===========
Fix License
===========

Symlinking this file is okay.

SYNOPSIS
========

::

	fix-license.sh <old> <new> [file]

DESCRIPTION
===========

Head ``file``, update SPDX license ID to ``new`` if current ID is ``old``.
Otherwise, no-op.

If you omit ``file``, this script lists files from index and worktree, and
keeps calling itself with ``file`` filled until it processes all files.
