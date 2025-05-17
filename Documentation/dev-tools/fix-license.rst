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

This script heads ``file`` and updates the SPDX license ID to ``new`` if the
current ID found in the header is ``old``. Otherwise, it's a no-op.

If you omit ``file``, it lists files from the index and worktree, and keeps
calling itself with ``file`` filled until it processes all files. In this case,
you must be at the root of your repo.
