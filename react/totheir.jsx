/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

export default function Totheir({ children, ...props })
{
return (
<a target='_blank' rel='noopener noreferrer' { ...props }>
  { children }
</a>
) /* return */
}
