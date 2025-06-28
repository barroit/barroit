/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

import isspace from './isspace.js'

export default function chop(str)
{
	const raw = [...str]
	const ret = [[]]
	let i = 0
	
	for (const char of raw) {
		if (!isspace(char)) {
			ret[i].push(char)
	
		} else {
			ret.push(char, [])
			i += 2
		}
	}

	return ret
}
