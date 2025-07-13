.. SPDX-License-Identifier: GPL-3.0-or-later

==============
Merge Upstream
==============

Symlinking this file is okay.

SYNOPSIS
========

::

	merge-upstream.sh <ref>

DESCRIPTION
===========

This script merges upstream ``ref`` into current branch and generates a pretty
commit message with changelog.

It dumps commit message in git directory as ``MERGE_MSG.1``. You can check git
directory location with::

	git rev-parse --git-dir

Don't assume it's under ``.git/``. Worktree gitdirs live in subdirectories.

This script also fixes licenses if you provide a ``.licensefix`` file in your
cwd. The file must follow this format::

	new	<license>
	old	<license>

See :ref:`fix_license` for how licenses are fixed up.
