.. SPDX-License-Identifier: GPL-3.0-or-later

===================
Mount Wasabi Bucket
===================

Don't run this manually unless you know what you're doing.

You must set up Wasabi via ``./<os>/setup.sh wasabi`` before running this.

SYNOPSIS
========

::

	mount-wasabi.sh

DESCRIPTION
===========

This script mounts Wasabi buckets under $HOME. Bucket names are hardcoded.
After mounting, you get the following mount points:

   - $HOME/barroit
   - $HOME/cred
