// SPDX-License-Identifier: GPL-3.0-or-later
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

#include "shuffle.h"

#include "bug.h"
#include "rand.h"

napi_value addon_shuffle(napi_env env, napi_callback_info info)
{
	napi_status err;
	size_t argc = 1;
	napi_value argv[1];

	err = napi_get_cb_info(env, info, &argc, argv, NULL, NULL);
	WARN_ON_NAPI(env, err);

	uint32_t len;
	napi_value arr = argv[0];

	err = napi_get_array_length(env, arr, &len); 
	WARN_ON_NAPI(env, err);

	uint32_t i;

	for (i = len - 1; i > 0; i--) {
		uint32_t j = rand_within(i + 1);
		napi_value item1;
		napi_value item2;

		napi_get_element(env, arr, i, &item1);
		napi_get_element(env, arr, j, &item2);

		napi_set_element(env, arr, i, item2);
		napi_set_element(env, arr, j, item1);
	}

	return arr;
}
