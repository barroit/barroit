/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Copyright 2025 Jiamu Sun <barroit@linux.com>
 */

#ifndef FUNCDEF_H
#define FUNCDEF_H

#include <node_api.h>

uint32_t rand_once(void);

uint32_t rand_within(uint32_t s);

napi_value addon_rand_once(napi_env env, napi_callback_info info);

napi_value addon_rand_within(napi_env env, napi_callback_info info);

#endif /* FUNCDEF_H */
