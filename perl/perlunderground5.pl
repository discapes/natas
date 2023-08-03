
#!/usr/bin/perl
# usage: own-kyx.pl narc1.txt
#
# this TEAM #PHRACK script will extract the email addresses 
# out of the narc*.txt files, enumerate the primary MX and NS 
# for each domain, and grab the SSHD and APACHE server version
# from each of these hosts (if possible). 
#
# For educational purposes only. Do not use.

use strict;
use warnings;
use v5.36;
use IO::Socket;

my $fname = shift or die "no filename";
open $if, $fname or die $!;
my $re = qr/\w*@[\w]*.[\w*]/

while (<$if>) {
    my $victim = m/$re/;
    next if (!$victim);

    print "=====\t$victim \t=====\n";
	my ($user, $domain) = split(/@/, $victim);

	$smtphost = `host -tMX $domn |cut -d\" \" -f7 | head -1`;
	$smtphost =~  s/[\r\n]+$//;
    say ":: Primary MX located at $smtphost";
    sshcheq $smtphost;
    apachecheq $smtphost;
    
    $nshost = `host -tNS $domn |cut -d\" \" -f4 | head -1`;
    $nshost =~  s/[\r\n]+$//ge;
    say ":: Primary NS located at $nshost";
    sshcheq $nshost ;
	apachecheq $nshost ;
    
    say say;
}

sub sshcheq {
# I think someone is confused about where his paren is supposed to go!
	(my $sshost) = @_;
        print ":: Testing $sshost for sshd version\n";
# not a single good variable name in this script 
        $g = inet_aton($sshost); my $prot = 22;
        socket(S,PF_INET,SOCK_STREAM,getprotobyname('tcp')) or die "$!\n";
        if(connect(S,pack "SnA4x8",2,$prot,$g)) {
# omg this line isn't too bad
        	my @in;
	        select(S); $|=1; print "\n";
        	while(<S>){ push @in, $_;}
# @in = <S>; # lawl
# Parse while reading the file
	        select(STDOUT); close(S); 
# man this is old school..
                foreach $res (@in) {
	                if ($res =~ /SSH/) {
# MOST COMPLEX YOUR PROGRAM IS
			chomp $res; print ":: SSHD version - $res\n";
                        }
		}        
	} else { return 0; } # coulda done this first and saved some
					# in-den-tation
}

# same shit different subroutine, maybe you could have made them into one
# with a pair of parameters HMM?
sub apachecheq {
        (my $whost) = @_;
        print ":: Testing $whost for Apache version\n";
        $g = inet_aton($whost); my $prot = 80;
        socket(S,PF_INET,SOCK_STREAM,getprotobyname('tcp')) or die "$!\n";
        if(connect(S,pack "SnA4x8",2,$prot,$g)) {
                my @in;
                select(S); $|=1; print "HEAD / HTTP/1.0\r\n\r\n";
                while(<S>){ push @in, $_;}
                select(STDOUT); close(S);
                foreach $res (@in) {
                        if ($res =~ /ache/) {
                        chomp $res; print ":: HTTPD version - $res\n";
                        }
                }
        } else { return 0; }
}
