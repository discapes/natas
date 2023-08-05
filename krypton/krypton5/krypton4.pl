#!/bin/perl
use strict;
use warnings;
use v5.30;
use autodie;
use Data::Dump qw(dump);

sub top5;
sub rotn;

my $sample = do {
	local $/;<>
};
$sample =~ tr/ //ds;
my @sample = split //, $sample;

my $kl = 9;

my @slots = ("") x $kl;

for (0 .. $#sample) {
	$slots[$_ % $kl] .= $sample[$_];
}

for (@slots) {
	state $i;
	say "Slot " . $i++;
	for my $i (1 .. 26) {
		tr/A-Z/B-ZA/;
		my @top = top5 split //, $_;
		say "ROT$i: " . join ", ", @top if "E" ~~ @top and "T" ~~ @top;
	}
}

$slots[0] = rotn $slots[0], 16;
$slots[1] = rotn $slots[1], 22;
$slots[2] = rotn $slots[2], 2;
$slots[3] = rotn $slots[3], 15;
$slots[4] = rotn $slots[4], 22;
$slots[5] = rotn $slots[5], 13;
$slots[6] = rotn $slots[6], 20;
$slots[7] = rotn $slots[7], 7;
$slots[8] = rotn $slots[8], 19;

for (0 .. $#sample) {
	print substr $slots[$_ % $kl], int($_/$kl), 1;
}

sub rotn {
	my ($str, $n) = @_;
	for my $i (1 .. $n) {
		$str =~ tr/A-Z/B-ZA/;
	}
	$str;
}

sub top5 {
	my (@arr) = @_;
	my %monograms;
	for (0 .. $#arr) {
		$monograms{$arr[$_]}++;
	}
	my @monograms = sort { $monograms{$b} <=> $monograms{$a} } keys %monograms;
	@monograms[0..6];
}