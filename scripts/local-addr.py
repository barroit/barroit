#!/usr/bin/python3
# SPDX-License-Identifier: GPL-3.0-or-later

import psutil
import socket

maps = psutil.net_if_addrs()

for name in maps:
	info = maps[name][0]

	if info.family == socket.AF_INET and info.broadcast:
		print(info.address)
		break
