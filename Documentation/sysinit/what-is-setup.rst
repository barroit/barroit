.. SPDX-License-Identifier: GPL-3.0-or-later

.. _sysinit_basic:

==================
The Setup Concepts
==================

This document describes the setup framework, the core of sysinit functionality.
It's meant to provide a way to consistently initialize your environment on new
systems. And it's easy to extend for new systems.

This framework, like libkit, has its core scripts under ``posix/``. This
directory contains the entry point ``setup.sh`` along with ``libsetup.sh``.
Platform-specific implementation providers live in ``linux`` and ``darwin``.
Platform-specific consumers live in ``ubuntu`` and ``macos``. This structure
is not mandatory, but it's the most flexible one in practice.

Setup scripts are like system.d config files. Their names follow a special
pattern ``NN-xxx.sh``. ``setup.sh`` only executes files with names in that
form. ``NN`` serves as priority. Higher numbers result in later execution.
