#!/bin/perl
use strict;
use warnings;
use v5.30;
use autodie;
use Data::Dump qw(dump);

my $sample = do {
	local $/;<>
};
$sample =~ tr/ //ds;
my @sample = split //, $sample;

my (%septagrams, %octagrams, %ninegrams);
for (0 .. $#sample) {
	my $sg = join "", @sample[$_ .. $_+6] if $_ <= $#sample - 6;
	my $og = join "", @sample[$_ .. $_+7] if $_ <= $#sample - 7;
	my $hg = join "", @sample[$_ .. $_+8] if $_ <= $#sample - 8;
	$septagrams{$sg}++ if $sg;
	$octagrams{$og}++ if $og;
	$ninegrams{$hg}++ if $hg;
}

my @septagrams = sort { $septagrams{$b} <=> $septagrams{$a} } keys %septagrams;
my @octagrams = sort { $octagrams{$b} <=> $octagrams{$a} } keys %octagrams;
my @ninegrams = sort { $ninegrams{$b} <=> $ninegrams{$a} } keys %ninegrams;

open my $col, q?| column -s $'\t' -t | sed -e 's/[[:blank:]]\+$//'?;
select $col;
say join "\t", qw(septagrams octagrams ninegrams);
for (0..15) {
	say join "\t", 
		"$septagrams[$_] $septagrams{$septagrams[$_]}",
		"$octagrams[$_] $octagrams{$octagrams[$_]}",
		"$ninegrams[$_] $ninegrams{$ninegrams[$_]}",
}