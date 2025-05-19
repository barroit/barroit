#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

export LIBKIT_ROOT=$(dirname $(readlink -f $0))

source $LIBKIT_ROOT/libkit.sh
source $LIBKIT_ROOT/libsetup.sh

source $1
