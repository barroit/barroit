/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

#ifndef BUG_H
#define BUG_H

#include <node_api.h>
#include <stdio.h>

#ifndef __stringify
# define __stringify(x) ___stringify(x)
# define ___stringify(x)  #x
#endif

#define ____fmt_err(file, line, s) ("BUG:" file ":" #line ":" __func__ ":" #s)

#define __fmt_err(x) \
	("BUG:" __FILE__ ":" __stringify(__LINE__) ":" __stringify(x))

#define WARN_ON(condition)					\
({								\
	int __ret_err = !!(condition);				\
								\
	if (__ret_err)						\
		fputs(__fmt_err(!!(condition)), stderr);	\
								\
	__ret_err;						\
})

#define WARN_ON_NAPI(env, condition)					\
do {									\
	if (!!(condition)) {						\
		napi_throw_error(env, "39", __fmt_err(!!(condition)));	\
		return NULL;						\
	}								\
} while (0)

#endif /* BUG_H */
