.. SPDX-License-Identifier: GPL-3.0-or-later

=========
Sync Repo
=========

Symlinking this file is okay.

This script is not for you. You must do lots of stuff and align with barroit's
workflow to make it work for you.

Your cwd must be repo root.

SYNOPSIS
========

::

	sync-repo.sh

DESCRIPTION
===========

This script pushes local commits of current branch to its tracking branch, and
transfers changes from index and worktree to same branch on another device. It
only supports two devices:

   - dev.macos
   - dev.ubuntu

Let's call current device 'A' and the other 'B'. ``${PWD#$HOME/}`` must exist
on B. B must have a branch with same name as the current branch on A. You must
have some changes on A, or this script panics. It also force resets that branch
on B to its tracking branch. You should keep branch state clean, or you lose
commits silently.

.. FIXME: Add 'SEE ALSO' after you write ssh (/etc/hosts) config guide.
