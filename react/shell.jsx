/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

import clsx from 'clsx'
import { createContext, useRef } from 'react'

export const shell_ctx = createContext(undefined)
const ShellContext = shell_ctx

function handle_event(event, shell)
{
	if (!shell.current)
		return

	const fns = Object.values(shell.current)

	for (const fn of fns) {
		if (event.type == fn.type)
			fn.cb(event)
	}
}

export default function Shell({ children, color, left, right, className })
{
	const shell = useRef()

	if (!className) {
		className = 'before:left-[0.1rem] after:right-[0.1rem] ' +
			    'hover:before:-translate-x-[0.5rem] ' +
			    'hover:after:translate-x-[0.5rem] ' +
			    '*:px-[0.8rem]'
	}

return (
<div className='relative inline-block cursor-pointer'
     onClick={ event => handle_event(event, shell) }
     onPointerEnter={ event => handle_event(event, shell) }>
  <ShellContext value={ shell }>
    <div className={ clsx('shell group/shell', className) }
         data-left={ left ?? '[' } data-right={ right ?? ']' }
	 style={ { '--shell-color': color ?? '#ff2222' } }>
      { children }
    </div>
  </ShellContext>
</div>
) /* return */
}
