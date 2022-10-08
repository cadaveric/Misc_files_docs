#!/usr/bin/perl
#Author:
#Purpose: explain Sub-routines
use warnings;
use strict;

open (han1, ">> logfile.sub") || die "Errors opening file: $!";

my $etc_dir = `ls -l /etc/passwd`;
chomp $etc_dir;
my $message = "Launching subroutine2.pl";

log_message("$message");
log_message("$etc_dir");

sub log_message {
	my $current_time = localtime;
	#print "$current_time - @_\n";
	print han1 "$current_time - $_[0]","\n";
}



#end
