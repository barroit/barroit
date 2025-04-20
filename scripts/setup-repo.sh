#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

ln -sf ../../hooks/pre-commit.sh .git/hooks/pre-commit
ln -sf ../../hooks/prepare-commit-msg.sh .git/hooks/prepare-commit-msg
