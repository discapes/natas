#!/usr/bin/perl
use warnings;
use strict;
use v5.36;

my $fd;

# reads from pipe
# outputs xdiamond.plx\nxone.plx\nxperlunderground5.plx\nxpipes.plx
open($fd, "ls |");
while (<$fd>) { chomp; say "x" . $_ . "x"; }

# writes to pipe
# outputs diamond.pl  one.pl  perlunderground5.pl  pipes.pl
# because stdout isn't captured
open($fd, "| ls");
while (<$fd>) { chomp; say "x" . $_ . "x"; }