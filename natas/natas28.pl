#!/bin/perl
use strict;
use warnings;
use v5.36;
use autodie;

use HTTP::Request;
use LWP::UserAgent;
use URI::Escape;
use Data::Dump qw(dump);
use MIME::Base64;

sub encrypt {
    my $req = HTTP::Request->new(
        POST => "http://natas28.natas.labs.overthewire.org/index.php",
        [
            authorization => "Basic bmF0YXMyODpza3J3eGNpQWU2RG5iMFZmRkR6REVIY0N6UW12M0dkNA==",
            "content-type" => "application/x-www-form-urlencoded"
        ],
        "query=" . uri_escape($_[0])
        );
    my $loc = LWP::UserAgent->new()->request($req)->headers->{location};
    my (undef, $query) = split /=/, $loc;
    decode_base64(uri_unescape($query));
}

dump encrypt "foo"