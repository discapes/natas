#!/bin/perl
# Frequency Analysis
use strict;
use warnings;
use v5.30;
use autodie;
use Data::Dump qw(dump);
use List::UtilsBy qw(max_by);
use List::MoreUtils qw(natatime);

my $sample = do {
	open my $f, "sample.txt";
	local $/;<$f>
};
$sample =~ tr/ //ds;
my @sample = split //, $sample;

my (%monograms, %bigrams, %trigrams, %quadgrams);
for (0 .. $#sample) {
	my $mg = $sample[$_];
	my $bg = join "", @sample[$_ .. $_+1] if $_ <= $#sample - 1;
	my $tg = join "", @sample[$_ .. $_+2] if $_ <= $#sample - 2;
	my $qg = join "", @sample[$_ .. $_+3] if $_ <= $#sample - 3;

	$monograms{$mg}++;
	$bigrams{$bg}++ if $bg;
	$trigrams{$tg}++ if $tg;
	$quadgrams{$qg}++ if $qg;
}

my @monograms = sort { $monograms{$b} <=> $monograms{$a} } keys %monograms;
my @bigrams = sort { $bigrams{$b} <=> $bigrams{$a} } keys %bigrams;
my @trigrams = sort { $trigrams{$b} <=> $trigrams{$a} } keys %trigrams;
my @quadgrams = sort { $quadgrams{$b} <=> $quadgrams{$a} } keys %quadgrams;

open my $col, q?| column -s $'\t' -t | sed -e 's/[[:blank:]]\+$//'?;
select $col;
say join "\t", qw(monograms bigrams trigrams quadgrams);
for (0..15) {
	say join "\t", 
		"$monograms[$_] $monograms{$monograms[$_]}",
		"$bigrams[$_] $bigrams{$bigrams[$_]}",
		"$trigrams[$_] $trigrams{$trigrams[$_]}",
		"$quadgrams[$_] $quadgrams{$quadgrams[$_]}",
}

open my $out, ">out.txt";
$sample =~ tr/JDS QGWNCEBUXZYLMAVFTKHORIP/the andrigosfcpyublkmwqxjvz/;
#$sample =~ s/(.{1,5})/$1 /gs;
$sample =~ s/(.{1,60})/$1\n/gs;
print $out $sample;