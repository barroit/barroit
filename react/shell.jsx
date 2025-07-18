/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

import { createContext, useRef } from 'react'

export const shell_ctx = createContext(undefined)
const ShellContext = shell_ctx

function handle_event(event, shell)
{
	if (!shell.current)
		return

	const fns = Object.values(shell.current)

	for (const fn of fns) {
		if (event.nativeEvent instanceof fn.type)
			fn.cb(event)
	}
}

export default function Shell({ children, color,
				left, right, padding, offset, move })
{
	const shell = useRef()

return (
<div className='relative inline-block cursor-pointer'
     onClick={ event => handle_event(event, shell) }
     onMouseEnter={ event => handle_event(event, shell) }>
  <ShellContext value={ shell }>
    <div className='shell'
         data-left={ left ?? '[' } data-right={ right ?? ']' }
	 style={ {
		'--shell-color': color ?? '#ff2222',
		'--shell-padding': padding ?? '0.8rem',
		'--shell-offset': offset ?? '0.1rem',
		'--shell-move':move ?? '0.5rem',
	} }>
      { children }
    </div>
  </ShellContext>
</div>
) /* return */
}
