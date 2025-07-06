/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

export default function TheFuckingContent({ length = 1,
					    items = 1,
					    className = '' })
{
	className += ' invisible'

	const content = '.'.repeat(length)
	const lines = Array(items).fill(content)

return (
<>
  {lines.map((line, i) => (
  <span key={ i } className={ className }>{ line }</span>
  ))}
</>
) /* return */
}
