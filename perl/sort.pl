#!/bin/perl
# parses an irssi log
# sorts output of /list by usercount
use strict;
use warnings;
use v5.36;
use autodie;
#use Data::Dump qw(dump);

my $fname = shift or die "no filename";
my $server = shift;
my $descsize = 100;

my $re = $server ? 
	qr/..:.. \[$server\] -!- #(\w*) (\d*) (.{0,$descsize})/
	: qr/..:.. -!- #(\w*) (\d*) (.{0,$descsize})/;
my @chans = ();

open my $logh, '<', $fname;
while (<$logh>) {
	push @chans, {
		name => $1,
		users => $2,
		desc => $3,
	} if m/$re/;
}

my @sorted = sort { $a->{users} <=> $b->{users} } @chans;
#dump @sorted;
# sed because for some reason `column` outputs trailing whitespace that causes the line to wrap
open my $col, q?| column -s $'\t' -t | sed -e 's/[[:blank:]]\+$//'?;
say $col "$_->{name}\t$_->{users}\t$_->{desc}" for @sorted;
