// SPDX-License-Identifier: GPL-3.0-or-later
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

#include "calc.h"
#include "compiler.h"
#include "iter.h"

#include "rand.h"

#define FNDATA(x) { .func = x, .name = STRINGIFY(x) }

struct func_data {
	napi_callback func;
	const char *name;
};

struct func_data func_list[] = {
	FNDATA(addon_rand),
	FNDATA(addon_rand_n),
};

napi_value Init(napi_env env, napi_value mod)
{
	unsigned i;

	idx_for_each(i, sizeof_array(func_list)) {
		napi_value node_func;
		struct func_data *data = &func_list[i];

		napi_create_function(env, NULL, 0,
				     data->func, NULL, &node_func);
		napi_set_named_property(env, mod, data->name, node_func);
	}

	return mod;
}

NAPI_MODULE(barroit, Init)
