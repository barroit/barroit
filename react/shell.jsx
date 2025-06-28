/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

function click_inner(ref)
{
	if (!ref)
		return

	if (ref.current instanceof HTMLAnchorElement)
		ref.current.click()
}

export default function Shell({ children, left, right, ref })
{
return (
<div className='group relative inline-block cursor-pointer'
     onClick={() => click_inner(ref)}>
  <div className='shell' data-left={left} data-right={right}>
    {children}
  </div>
</div>
) /* return */
}
