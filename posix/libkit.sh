#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

ESC="$(printf '\033')"
BOLD="${ESC}[1m"
RED="${ESC}[31m"
YELLOW="${ESC}[33m"
GREEN="${ESC}[32m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
RESET="${ESC}[0m"

die()
{
	printf "${BOLD}${RED}fatal:${RESET} %s\n" "$@" >&2
	exit 128
}

error()
{
	printf "${BOLD}${RED}error:${RESET} %s\n" "$@" >&2
	return 1
}

warn()
{
	printf "${BOLD}${YELLOW}warning:${RESET} %s\n" "$@" >&2
	return 1
}

note()
{
	printf "${BOLD}${CYAN}note:${RESET} %s\n" "$@"
}

log()
{
	printf "${BOLD}${GREEN}[$(current)]${RESET} %s\n" "$@"
}

getchar()
{
	if [ -t 0 ]; then
		saved=$(stty -g)

		stty -icanon min 1 time 0
	fi

	eval "$1="

	while true; do
		c=$(dd bs=1 count=1 2>/dev/null; echo .)
		c=${c%.}

		if [ -z "$c" ]; then
			break;
		fi

		eval "$1=\${$1}$c"

		if eval '[ "$(($(printf %s "\${$1}" | wc -m)))" -ne 0 ]'; then
			break;
		fi
	done

	if [ -t 0 ]; then
		stty "$saved"
	fi
}

confirm()
{
	printf '%s [y/N] ' "$1" >&2
	getchar select
	printf '\n'

	case "$select" in
	[yY][eE][sS] | [yY])
		return 0
		;;
	*)
		return 1
		;;
	esac
}

readlower()
{
	tr [:upper:] [:lower:]
}

readupper()
{
	tr [:lower:] [:upper:]
}

v1()
{
	grep $2 $1 | awk -F'\t+' '{print $2}'
}

v2()
{
	grep $2 $1 | awk -F'\t+' '{print $3}'
}

v3()
{
	grep $2 $1 | awk -F'\t+' '{print $4}'
}

v4()
{
	grep $2 $1 | awk -F'\t+' '{print $5}'
}


r1()
{
	printf %s "$1" | awk -F'\t+' '{print $1}'
}

r2()
{
	printf %s "$1" | awk -F'\t+' '{print $2}'
}

r3()
{
	printf %s "$1" | awk -F'\t+' '{print $3}'
}

r4()
{
	printf %s "$1" | awk -F'\t+' '{print $4}'
}

line_need_skip()
{
	case "$1" in
	'' | \#*)
		# weird, but works
		return 0
		;;
	*)
		return 1
	esac
}

ini_section()
{
	perl -ne "print if /^\[$1\]$/ .. /^\[end$1\]$/ and !/^\[.*\]$/" $2
}

ini_section_st()
{
	ret=$(ini_section $1 $2)

	if [ -z "$ret" ]; then
		die "no matching section $1 found in $2"
	fi

	printf '%s\n' "$ret"
}
