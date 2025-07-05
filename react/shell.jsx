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

export default function Shell({ children, left, right, color })
{
	const shell = useRef()

return (
<div className='relative inline-block cursor-pointer'
     onClick={ event => handle_event(event, shell) }
     onMouseEnter={ event => handle_event(event, shell) }>
  <ShellContext value={ shell }>
    <div className='shell'
         data-left={ left } data-right={ right }
	 style={ { '--shell-color': color ?? '#ff2222' } }>
      { children }
    </div>
  </ShellContext>
</div>
) /* return */
}
