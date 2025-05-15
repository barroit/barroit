.. SPDX-License-Identifier: GPL-3.0-or-later

============
Bump Version
============

Symlinking this file is okay.

SYNOPSIS
========

::

	bump-version.sh

DESCRIPTION
===========

Commit a version change in VERSION and make a GPG-signed tag.

Commit title is '$name v$version'. *name* is read from NAME, *version* from
VERSION. Make sure these files exist in repo root.
