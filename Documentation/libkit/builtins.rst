.. SPDX-License-Identifier: GPL-3.0-or-later

=================
Builtin Functions
=================

This document describes builtins of libkit. If you prefer Microsoft's
babysitter-style docs and don't read the code, do not touch this part. It's for
experienced developers, not dumbasses.

Standard output builtins
========================

   - log
   - note
   - warn
   - error
   - die

``log`` and ``note`` output messages to stdout. The rest output to stderr.

``die`` terminates calling process.

Standard input builtins
=======================

   - getchar
   - confirm

``getchar`` reads exactly one character from stdin. It handles variable-width
encoded characters.

Don't use ``confirm`` like::

	while read; do
		# ...
		confirm xxx
	done <file

This input redirection prevents ``getchar`` from reading user input and fucks
up ``confirm``.

Table content extraction builtins
=================================

   - v1 <file> <name>
   - v2 <file> <name>
   - v3 <file> <name>
   - v4 <file> <name>
   - r1 <str>
   - r2 <str>
   - r3 <str>
   - r4 <str>

These builtins only accept tabs as column separator.

``v*`` family greps ``name`` in ``file`` and gets the ``*``-th column of that
line.

``r*`` family gets the ``*``-th column of ``str``.

INI parsers
===========

   - ini_section <name> <file>
   - ini_section_st <name> <file>

These functions use ``perl``

The dotini section format is::

	[$name]
	...
	[end$name]

You must end your section with ``[end$name]``, and there's no whitespace
between ``end`` and ``$name``.

``ini_section`` reads ``file`` and finds the first matching section by
``name``. It outputs empty if nothing is found.

``ini_section_st`` is similar to ``ini_section``, except it ``die``\ s if
nothing is found.
