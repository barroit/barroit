#!/usr/bin/perl
# SPDX-License-Identifier: GPL-3.0-or-later

use File::Spec::Functions "abs2rel";
use Cwd "abs_path";
use File::Basename "dirname";

my $a = abs_path(shift);
my $b = abs_path(shift);

if (! -d $a) {
	$a = dirname($a);
}

if (! -d $b) {
	$b = dirname($b);
}

printf "%s\n", abs2rel($a, $b);
