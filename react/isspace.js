/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

const _whitespace = new Set([
	0x09,    /* CHARACTER TABULATION */
	0x0A,    /* LINE FEED */
	0x0B,    /* VERTICAL TAB */
	0x0C,    /* FORM FEED */
	0x0D,    /* CARRIAGE RETURN */
	0x20,    /* SPACE */
	0x85,    /* NEXT LINE (NEL) */
	0xA0,    /* NO-BREAK SPACE */
	0x1680,  /* OGHAM SPACE MARK */
	0x2000,  /* EN QUAD */
	0x2001,  /* EM QUAD */
	0x2002,  /* EN SPACE */
	0x2003,  /* EM SPACE */
	0x2004,  /* THREE-PER-EM SPACE */
	0x2005,  /* FOUR-PER-EM SPACE */
	0x2006,  /* SIX-PER-EM SPACE */
	0x2007,  /* FIGURE SPACE */
	0x2008,  /* PUNCTUATION SPACE */
	0x2009,  /* THIN SPACE */
	0x200A,  /* HAIR SPACE */
	0x2028,  /* LINE SEPARATOR */
	0x2029,  /* PARAGRAPH SEPARATOR */
	0x202F,  /* NARROW NO-BREAK SPACE */
	0x205F,  /* MEDIUM MATHEMATICAL SPACE */
	0x3000,  /* IDEOGRAPHIC SPACE */
])

export default function isspace(c)
{
	/*
	 * JavaScript uses utf-16.
	 */
	const hi = c.codePointAt(0)

	return _whitespace.has(hi)
}
