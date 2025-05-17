.. SPDX-License-Identifier: GPL-3.0-or-later

============
Bump Version
============

Symlinking this file is okay.

Your cwd must contain ``NAME`` and ``VERSION``.

You can't use newlines or whitespaces in ``NAME`` or ``VERSION``.

You must have a valid GPG key and ensure git uses this key by default.

SYNOPSIS
========

::

	bump-version.sh

DESCRIPTION
===========

This script commits a version change in ``VERSION`` and makes a GPG-signed tag.
Commit title is::

	printf("%s v%s\n", name, version)

And tag name is::

	printf("v%s", version)

Both commit and tag contain a trailing ``Signed-off-by`` line.
