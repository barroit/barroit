#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

export LIBKIT_ROOT=$(dirname $(readlink -f $0))

. $LIBKIT_ROOT/libkit.sh
. $LIBKIT_ROOT/libsetup.sh

. $1
