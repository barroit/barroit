.. SPDX-License-Identifier: GPL-3.0-or-later

============
Add Platform
============

This document describes how to add a new platform. It has two parts. One is
adding a provider, which serves as a brand-new platform. Another is adding a
consumer, which must be backed by a provider.

This document only describes barroit's practice, which splits provider and
consumer into two directories. But again, this framework is flexible. You're
free to place them in one or multiple directories.

You must read the code. This document doesn't repeat implementation details or
explain how they're done. It only tells you what scripts do and where to put
them.

Add provider
============

You must give this provider a nice name. Common choice is OS family name, like
``linux``, ``bsd``, or ``darwin``.

A provider must contain these scripts:

   - exec.sh
   - libkit.sh
   - libsetup.sh
   - libsetup-rt.sh

``exec.sh`` is like a header. It sources the library scripts and your script.
``setup.sh`` executes this file directly.

``libsetup.sh`` must be a symlink to ``posix/libsetup.sh``.

``libsetup-rt.sh`` contains platform-specific functions. These print runtime
data. You must provide them. Otherwise framework malfunctions. ``libsetup.sh``
sources ``libsetup-rt.sh`` and handles whitespace in output correctly. Look at
``linux/libsetup-rt.sh`` for a list of required functions.

See :ref:`Extend Platform for libkit<extend_libkit>` for how to extend libkit.

Add consumer
============

You must give this consumer a nice name. Common choice is OS name, like
``ubuntu``, ``freebsd``, or ``macos``.

A consumer must contain these scripts:

   - exec.sh
   - setup.sh

``exec.sh`` must be a symlink to ``<provider>/exec.sh``. 

``setup.sh`` must be a symlink to ``posix/setup.sh``.

Now you can consume the provider. Add scripts like:

   - 00-__power-mode.sh
   - 30-vim.sh
   - 80-power-saver.sh
   - 99-power-mode.sh

``setup.sh`` will execute them in order, from 00 to 99.
