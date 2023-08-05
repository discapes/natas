#!/usr/bin/perl
use warnings;
use strict;
use v5.36;

print "Hello world\n";


# doesnt work
#my $s = chomp(<STDIN>);

if (0) {
    my $s;
    chomp($s = <STDIN>);
    print $s;
} else {
    my $s = <STDIN>;
    chomp($s);
    print $s;
}