.. SPDX-License-Identifier: GPL-3.0-or-later

===============
Libkit Overview
===============

Libkit is a shell scripting library made to keep things portable, reusable, and
extendable. By using this, you avoid reimplementing the same functionality in
every repository. It provides general-purpose ``functions`` and ``hooks``.

``functions`` are well-defined shell builtins. You can use them out of the box.

``hooks`` are undefined functions. You must define these yourself. Otherwise,
some builtins won't work.

The core of libkit lives in ``posix/libkit.sh``. Stuff in this file is
POSIX-compliant. But compatibility here only means the syntax follows POSIX.
If a function needs external programs, like ``perl``, you'll see that in its
document.

You can extend it to any Unix-like OS with a shell, like bash, dash, or zsh,
but not pwsh :). You can also override functions or hooks. Just make sure you
don't break builtins that use them.
