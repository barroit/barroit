/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 *
 * PAIN!
 */

/*
 * FIXME: modify elements directly
 */

import isspace from './isspace.js'
import chopstr from './chopstr.js'
import { useEffect, useMemo, useRef, useState } from 'react'

function map_index(chars)
{
	let index = 0
	const map = []

	for (const item of chars) {
		if (typeof item === 'object')
			map.push(item.map(() => index++))
		else
			map.push(null)
	}

	return map
}

function map_wave(chars, offset)
{
	const idxs = map_index(chars)
	const ret = []

	for (const row of idxs) {
		if (!row) {
			ret.push(null)
			continue
		}

		const marks = row.map(index =>
		{
			const angle = (index + offset) / 3
			const dist = Math.sin(angle)
			const opacity = (dist + 1) / 2

			return opacity
		})

		ret.push(marks)
	}

	return [ ret, idxs ]
}

function format_word(char, idx)
{
	const [ [ raw_marks, imap ], raw_mark_idx ] = this
	const marks = raw_marks[raw_mark_idx]

	const key = imap[raw_mark_idx][idx]
	const delay = Math.trunc(marks[idx] * 400)

return (
<span key={ key }
      style={{ '--delay': `${delay}ms` }}
      className='transition-opacity delay-(--delay) opacity-(--opacity)'>
  { char }
</span>
) /* return */
}

function wave_chars(item, idx)
{
	if (typeof item != 'object')
		return <span key={ idx }>{ item }</span>

	return item.map(format_word, [ this, idx ])
}

function rand_wave(chars)
{
	const now = performance.now()
	const marks = map_wave(chars, now)
	const waves = chars.map(wave_chars, marks)

	return waves
}

function call_wave(waving, chars, wave, active)
{
	if (waving.current)
		return

	const waves = rand_wave(chars)

	wave(waves)
	waving.current = 1

	setTimeout(() => {
		active(0)
	}, 400)

	setTimeout(() => {
		waving.current = 0
	}, 1000)
}

export default function Wave({ children })
{
	const chars = useMemo(() => chopstr(children), [])

	const [ waves, wave ] = useState(() => rand_wave(chars))
	const [ enabled, enable ] = useState(0)
	const waving = useRef(0)

	useEffect(() =>
	{
		if (waving.current)
			requestAnimationFrame(enable)
	}, [ waves ])

return (
<span onMouseEnter={ () => call_wave(waving, chars, wave, enable) }
      style={{ '--opacity': enabled ? 0.2 : 1 }}>
  { waves }
</span>
) /* return */
}
