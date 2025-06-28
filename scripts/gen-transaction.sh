#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

find -type d -not -name out -not -name . | while read dir; do
	cd $dir

	ls | sort -n | while read file; do
		jq .[0].result.transList[] $file
	done | jq -s . >../out/$dir.tx

	cd ..
done

cd out
>tx.csv

for file in *.tx; do
	jq -r '.[] | [
		.acntType,
		.dealDt,
		.checkDt,
		.dealCardId[-4:],
		.balCnt,
		.dealDesc
	] | @csv' $file >>tx.csv
done
