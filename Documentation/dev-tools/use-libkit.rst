.. SPDX-License-Identifier: GPL-3.0-or-later

==========
Use libkit
==========

Symlinking this file is okay.

Your cwd must contain ``scripts/libkit.sh``.

You must symlink ``scripts/libkit.sh`` to ``this/repo/current/libkit.sh``.

You must set up ``current/`` in this repo via ``./<os>/setup.sh set-current``.

SYNOPSIS
========

::

	. use-libkit.sh

DESCRIPTION
===========

This script extracts non-trivial setup of libkit. It uses ``current/`` to
dynamically detect platform, use correct ``libkit.sh`` implementation, and fill
necessary environment variables.

This script has a ``use-posix-libkit.sh`` variant. It's useful when you want to
use libkit in a POSIX-compliant manner, but it lacks hook implementations.

To use libkit, just source ``use-libkit.sh`` in your script.
