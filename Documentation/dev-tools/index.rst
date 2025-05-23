.. SPDX-License-Identifier: GPL-3.0-or-later

=================
Development Tools
=================

This part describes documents for development tools. These scripts can save
your life, but only if you use them correctly and follow the workflows.
Otherwise, they may mess things up.

If a script supports symlink, it says so after the title. If not, just don't
symlink it. Script that allows symlinking may require Perl in PATH. Check its
content to confirm.

Some scripts are platform-specific. Use them only on the right platform. And
the most important thing: none of these scripts support dumbass Windows. No
one wants to develop on Windows and eat their piece of shit scripting quirks.

.. toctree::
   :maxdepth: 1

   bump-version
   fix-license
   map-darconf
   mount-wasabi
   mutt-use
   setup-repo
   sphinx-init
   move-wip
   umount-wasabi
   use-libkit
   vmksign
