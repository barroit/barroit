.. SPDX-License-Identifier: GPL-3.0-or-later

==================
Libkit Python Port
==================

At commit ``76ef582da88f``, this repo introduced a Python port of libkit. It's
a mock of ``libkit.sh`` with some differences:

1.	Python is already portable enough, so no need to split platforms for
	it (actually needed, but that makes importing suck, so I dropped it).

2.	All platform directories, like ``ubuntu`` and ``darwin``, contain a
	``libkit.py`` symlink to ``posix/libkit.py``. This is by design, for
	better consistency with ``libkit.sh``.

3.	No platform-dependent work. If you want to do that, go the fuck use
	``libkit.sh``. Python doesn't suit you.

4.	Provides shell function aliases.

To use this port, symlink ``libkit.py`` in the same directory as your script
importing it, to ``this/repo/current/libkit.py``.

You must set up ``current/`` via ``./<consumer>/setup.sh set-current``. See
:ref:`sysinit_setup_usage` for script usage.
