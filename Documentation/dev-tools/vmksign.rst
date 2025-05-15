.. SPDX-License-Identifier: GPL-3.0-or-later

=========================
Sign VMware Kernel Module
=========================

Symlinking this file is okay.

Use this only on Linux-based distributions.

SYNOPSIS
========

::

	vmksign.sh

DESCRIPTION
===========

This script signs ``vmmon`` and ``vmnet``. You must have a MOK under
``~/.mok``, named ``vmware``, or it prompts you to enroll the key first.
After enrollment, run this script again to sign those modules.
