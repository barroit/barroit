#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

libkit=scripts/libkit.sh
libkit=$(perl -e 'use Cwd "abs_path"; print abs_path(shift); "\n"' $libkit)
LIBKIT_ROOT=$(dirname $libkit)

. $libkit
