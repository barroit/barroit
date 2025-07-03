/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

import { useRef } from 'react'

import isspace from './isspace.js'
import shuffle from './shuffle.js'

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

function make_span(c, i)
{
return (
<span key={i} className='duration-120'>{ c }</span>
) /* return */
}

function make_span_list(str)
{
	const chars = [ ...str ]

	return chars.map(make_span)
}

function flicker_on(box, enabled, imap)
{
	if (enabled.current)
		return

	enabled.current = 1

	const spans = Array.from(box.current.children)
	let delay = 0

	const shuffled = shuffle(imap)
	const picked = pds_1d(shuffled, shuffled.length / 2, 2)

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
			init--;
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

export default function Flicker({ children })
{
	const box = useRef()
	const enabled = useRef(0)

	const spans = make_span_list(children)

	const imap = []
	let i

	for (i = 0; i < children.length; i++) {
		if (isspace(children[i]))
			continue

		imap.push(i)
	}

return (
<span ref={box}
      onMouseEnter={() => flicker_on(box, enabled, imap)}>
  { spans }
</span>
) /* return */
}
