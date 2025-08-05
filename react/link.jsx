/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

import { useContext, useEffect, useRef } from 'react'

import { shell_ctx } from './shell.jsx'

export function ToOurs({ children, ...props })
{
	const shell = useContext(shell_ctx)
	const link = useRef()

	const cb = () => link.current.click()

	useEffect(() =>
	{
		if (shell) {
			shell.current ??= {}
			shell.current.tolink = { type: 'click', cb }
		}
	}, [])

return (
<a ref={ link } { ...props }>
  { children }
</a>
) /* return */
}

export function ToTheirs({ children, ...props })
{
return (
<ToOurs target='_blank' rel='noopener noreferrer' { ...props }>
  { children }
</ToOurs>
) /* return */
}
