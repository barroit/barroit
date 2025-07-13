#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

this=$(perl -e 'use Cwd "abs_path"; print abs_path(shift); "\n"' $0)
root=$(dirname $this)/..

. $root/posix/libkit.sh

if [ -z "$1" ]; then
	die 'missing old license'
elif [ -z "$2" ]; then
	die 'missing replacement'
elif [ -z "$3" ]; then
	git ls-files | xargs -n1 -P$(nproc) sh $0 "$1" "$2"
	exit
fi

old=$1
new=$2
file=$3
rep="SPDX-License-Identifier: $2"

if [ ! -f $file ] || ! perl -ne 'exit 1 if /\0/' $file; then
	exit
fi

lines=$(head -n+2 $file)
tmp=$file~
pos=2
rep="SPDX-License-Identifier: $new"

if ! printf %s "$lines" | grep -q "$old"; then
	exit
fi

>$tmp
exec >> $tmp
trap 'rm -f $tmp' EXIT

case $lines in
'// '*)
	printf '%s\n' "// $rep"
	;;
'/* '*)
	printf '%s\n' "/* $rep */"
	;;
'#!'*)
	printf '%s\n%s\n' "$(head -n1 $file)" "# $rep"
	pos=3
	;;
'# '*)
	printf '%s\n' "# $rep"
	;;
'.. '*)
	printf '%s\n' ".. $rep"
	;;
*)
	if [ $file = .licensefix ]; then
		exit
	fi

	die "unknown line format in $file"
esac

tail -n+$pos $file

perm=$(perl -e 'printf "%o\n", (stat shift)[2] & 07777' $file)

mv $tmp $file
chmod $perm $file
