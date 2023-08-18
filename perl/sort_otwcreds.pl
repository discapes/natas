#!/bin/perl
use strict;
use warnings;
use v5.36;
use autodie;

sub fun {
	my ($aname, $anum) = $a =~ /([a-z]+)(\d+)/;
	my ($bname, $bnum) = $b =~ /([a-z]+)(\d+)/;
	return $aname cmp $bname unless $aname eq $bname;
	return $anum <=> $bnum;
}

chomp (my @lines = <>);
my @sortedlines = sort fun grep { /([a-z]+)(\d+)/ } @lines;


open my $col, q?| column -t | sed -e 's/[[:blank:]]\+$//'?;
select $col;

for (0 .. $#sortedlines) {
	my ($thisname) = $sortedlines[$_] =~ /([a-z]+)(\d+)/;
	my ($nextname) = $sortedlines[$_+1] =~ /([a-z]+)(\d+)/ if $_ != $#sortedlines;

	say uc "--$thisname--" if $_ == 0;
	say $sortedlines[$_];
	say uc "-\n--$nextname--" if $nextname and $thisname ne $nextname;
}
