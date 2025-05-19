.. SPDX-License-Identifier: GPL-3.0-or-later

.. _extend_libkit:

===============
Extend Platform
===============

This part describes documents for extending platforms. To extend a platform,
implement hooks for it. Here's a list of hooks you should implement:

   - current()

	This function prints a timestamp used for measuring time. A reliable
	source is system uptime. It's better to make the format look like
	``1168719.16``, to provide a better visual experience.

	And what it outputs is up to you. You can even make it print a PID if
	you want.

If you don't implement these hooks, you can't use the following builtins:

.. list-table::
   :header-rows: 1
   :widths: 25 25

   * - builtin
     - relies on
   * - log()
     - current()

You can place hooks anywhere. Just make sure builtins can see those hooks
before calling them.

In practice, I place hook implementations in ``linux/libkit.sh`` and source
``posix/libkit.sh``. This setup works on every Linux-based distribution. Same
approach also works on macOS.
