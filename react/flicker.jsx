/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

import chop from './chop.js'

export default function Flicker({ children })
{
	const chars = chop(children)

	console.log(chars)
return (
<span>{ children }</span>
) /* return */
}
