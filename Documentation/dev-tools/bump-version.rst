.. SPDX-License-Identifier: GPL-3.0-or-later

============
Bump Version
============

Symlinking this file is okay.

Your cwd must be repo root.

SYNOPSIS
========

::

	bump-version.sh

DESCRIPTION
===========

Commit a version change in VERSION and make a GPG-signed tag.

Commit title format is '$name v$version'. ``$name`` is read from ./NAME, and
``$version`` from ./VERSION. You must also have a valid GPG key and ensure git
uses this key by default.
