.. SPDX-License-Identifier: GPL-3.0-or-later

=====================
Unmount Wasabi Bucket
=====================

Symlinking this file is okay.

Don't run this manually unless you know what you're doing.

You must set up Wasabi via ``./<consumer>/setup.sh wasabi`` in this repo. See
:ref:`sysinit_setup_usage`.

SYNOPSIS
========

::

	umount-wasabi.sh

DESCRIPTION
===========

This script unmounts Wasabi buckets under $HOME. Bucket names are hardcoded. It
unmounts the following mount points:

   - $HOME/barroit
   - $HOME/cred
