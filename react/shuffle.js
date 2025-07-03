/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

import { rand_within } from './rand.js'

export default function shuffle(arr)
{
	let i

	for (i = arr.length - 1; i > 0; i--) {
		const j = rand_within(i + 1)
		const tmp = arr[i]

		arr[i] = arr[j]
		arr[j] = tmp
	}

	return arr
}
