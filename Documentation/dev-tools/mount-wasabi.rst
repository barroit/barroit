.. SPDX-License-Identifier: GPL-3.0-or-later

===================
Mount Wasabi Bucket
===================

Symlinking this file is okay.

Don't run this manually unless you know what you're doing.

You must set up Wasabi via ``./<os>/setup.sh wasabi`` in this repo.

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

.. FIXME: Add 'SEE ALSO' after you write Wasabi config guide.
..
.. - You must set up Wasabi via ``./<os>/setup.sh wasabi`` before running this.
.. + You must set up Wasabi. See <link>
