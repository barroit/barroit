.. SPDX-License-Identifier: GPL-3.0-or-later

.. _config_ssh:

=============
Configure SSH
=============

This document guides you in configuring ssh with barroit's setup. It assumes
you executed ``./<consumer>/setup.sh file-map``. See :ref:`sysinit_setup_usage`
for script usage.

In this document, when talking about hosts in ssh config, it only refers to
host entries relevant to devices and local virtual machines.

This setup doesn't hardcode host aliases. It's the most portable and flexible
way to version-control a config file in practice.

This setup doesn't use any external program or script. It relies on hostname
resolution. This is the easiest way to get correct IP for a hostname across
different platforms.

In ssh config, host aliases are reversed domain names, like ``dev.macos`` and
``lvm.noble``. For virtual machine hosts, it doesn't duplicate host entries
with different aliases for same OS. You're not expected to connect to multiple
guests of same OS at once.

In host entries, hostnames are domain names, like ``macos.dev`` and
``noble.lvm``.

To map hostname to IP, edit ``/etc/hosts`` and add lines like::

	192.168.137.130 noble.lvm
	192.168.50.246  ubuntu.dev
	192.168.137.129 windows.lvm
	192.168.137.133 windows.lvm

This is a real ``/etc/hosts`` segment taken from ``dev.macos``:

``noble.lvm``
	Refers to virtual machine "Ubuntu Server 24.04" in VMware Fusion.

``ubuntu.dev``
	Refers to desktop "Ubuntu 24.04", barroit's PC.

``windows.lvm``
	Refers to two Windows guests in VMware Fusion.
