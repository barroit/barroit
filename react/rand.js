/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

export function rand_once()
{
	const buf = new Uint32Array(1);

	window.crypto.getRandomValues(buf);

	return buf[0]
}

export function rand_within(raw_s)
{
	const raw_x = rand_once()

	const s = raw_s >>> 0
	const x = BigInt(raw_x)
	const t = (-s >>> 0) % s
	let m, l

	do {
		m = x * BigInt(s)
		l = Number(m & 0xffffffffn) >>> 0
	} while (l < t)

	return Number((m >> 32n))
}
