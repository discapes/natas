#!/bin/perl
use strict;
use warnings;
use v5.30;
use autodie;

my @f = <>;
my $str = substr $f[0], 0, 100;
say "Ciphertext: " . $str;

$_ = $str;
for my $i (1 .. 26) {
	tr/A-Z/B-ZA/;
	say "ROT$i: $_";
}

#for my $next ("A" .. "Y") {
#	my $c = $next++;
#	my $de = $str;
#	eval "\$de =~ tr/A-Z/${next}-ZA-${c}/";
#	say $de;
#}
