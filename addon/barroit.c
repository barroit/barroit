// SPDX-License-Identifier: GPL-3.0-or-later
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

#include "bug.h"
#include "calc.h"
#include "iter.h"

#include "rand.h"
#include "shuffle.h"

#define FN(x) { .fn = addon_ ## x, .name = __stringify(x) }

struct fn {
	napi_callback fn;
	const char *name;
};

struct fn fns[] = {
	FN(rand_once),
	FN(rand_within),
	FN(shuffle),
};

napi_value Init(napi_env env, napi_value mod)
{
	unsigned i;

	idx_for_each(i, sizeof_array(fns)) {
		napi_value fn;
		struct fn *info = &fns[i];

		napi_create_function(env, NULL, 0, info->fn, NULL, &fn);
		napi_set_named_property(env, mod, info->name, fn);
	}

	return mod;
}

NAPI_MODULE(barroit, Init)
