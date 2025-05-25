.. SPDX-License-Identifier: GPL-3.0-or-later

=============
Group History
=============

Symlinking this file is okay.

SYNOPSIS
========

::

	group-history.py

DESCRIPTION
===========

This script reads commit titles from stdin and formats a list of commit titles
into grouped and semantic-order-sorted changelog blocks.

It only serves as a suggestion. You should check its output. If you follow the
linux commit style, it works well for you.

Each line must follow this format::

	<prefix>: <subject>

If a line includes multiple ``:`` separators, this script marks the last prefix
as group, all previous parts as type, and treats nested types as one.

DEPRIORITIZATION
================

This script reads ``.lowprior`` files. It pushes certain groups and types to
bottom of changelog based on these low priority definitions.

It ignores blank lines and ``#`` comments, and reads ``.lowprior`` in the
following order:

   - $HOME/.lowprior
   - $(pwd)/.lowprior

Each line in ``.lowprior`` must be:

   - group name
   - type name with ``+`` suffix

Group name matches exact group. With ``+`` suffix, it matches prefix of types.
