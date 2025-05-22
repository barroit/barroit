.. SPDX-License-Identifier: GPL-3.0-or-later

.. _switch_mutt_users:

=================
Switch Mutt Users
=================

Symlinking this file is okay.

You must read :ref:`mutt_user_config`.

SYNOPSIS
========

::

	mutt-use.sh <name>

DESCRIPTION
===========

This script finds consumer with ``name``. It supports abbreviation on ``name``.
If you abbreviate it, the script matches ``name`` before ``@`` in filename.

You can check which consumer mutt uses via::

	readlink $HOME/.mutt/current
