.. SPDX-License-Identifier: GPL-3.0-or-later

=========
Use Setup
=========

You must be the root of this repo.

SYNOPSIS
========

::

	./<consumer>/setup.sh [name]

DESCRIPTION
===========

Executes setup scripts with filenames starting with ``name``. If you omit this
argument, ``setup.sh`` executes all setup scripts under that consumer. If
``name`` is ambiguous, pass the full filename without the ``NN-`` prefix.

After a successful execution, libsetup caches this and skips that script on
future runs. To force execution, prefix the name with ``+``. This bypasses
libsetup cache.
