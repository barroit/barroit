/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

import { useContext, useEffect, useRef } from 'react'

import isspace from './isspace.js'
import shuffle from './shuffle.js'
import { shell_ctx } from './shell.jsx'

function pds_1d(arr, size, min)
{
	const ret = []
	let i

	for (i = 0; i < size; i++) {
		let j

		for (j = 0; j < ret.length; j++) {
			if (Math.abs(arr[i] - arr[j]) >= min)
				continue

			j = -1
			break
		}

		if (j != -1)
			ret.push(arr[i])
	}

	return ret
}

function flicker_on(box, enabled, imap)
{
	if (enabled.current)
		return

	enabled.current = 1

	const spans = Array.from(box.current.children)
	let delay = 0

	const shuffled = shuffle(imap)
	let picked = pds_1d(shuffled, shuffled.length / 2, 2)

	if (!picked.length)
		picked = [ shuffled[0] ]

	let on_i = 0
	const on_id = setInterval(() =>
	{
		spans[picked[on_i]].style.opacity = 0.1

		on_i++
		if (on_i == picked.length)
			clearInterval(on_id)
	}, 40)

	let off_i = 0
	let init = 3
	const off_id = setInterval(() =>
	{
		if (init) {
			init--
			return
		}

		spans[picked[off_i]].style.opacity = 1

		off_i++
		if (off_i == picked.length) {
			clearInterval(off_id)
			enabled.current = 0
		}
	}, 40)
}

export default function Flicker({ children, className })
{
	const box = useRef()
	const enabled = useRef(0)
	const shell = useContext(shell_ctx)

	const chars = [ ...children ]
	const imap = []
	let i

	for (i = 0; i < chars.length; i++) {
		if (isspace(chars[i]))
			continue

		imap.push(i)
	}

	const cb = () => flicker_on(box, enabled, imap)
	const matcher = window.matchMedia('(prefers-reduced-motion: reduce)')
	const reduced = matcher.matches

	useEffect(() =>
	{
		if (!reduced && shell) {
			shell.current ??= {}
			shell.current.flicker = { type: 'pointerenter', cb }
		}
	}, [])

return (
reduced ? (
<span className={ className }>
{chars.map((c, i) => (
  <span key={ i }>{ c }</span>
))}
</span>
) : (
<span ref={ box } className={ className }
      onPointerEnter={ shell ? undefined : cb }>
{chars.map((c, i) => (
  <span key={ i } className='duration-120'>{ c }</span>
))}
</span>
)
) /* return */
}
