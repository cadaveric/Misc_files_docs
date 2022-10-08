#!/usr/bin/perl -w
#Author:
#Purpose: explain Sub-routines
use strict;

#my $firstname = "Iliyan";
#my @array1 = ("Dean","Andrew","Davis", "George", "Michael");

testsub1(); #second subroutine, you can inverse the order in which they appear. This one will be processed first.
testsub(); #Default way to call a sub-routine
testsub3("Koki","Iliyanov");

sub testsub {
	my $name = "Dean Davis";
	print "Hello, $name\n";

}

sub testsub1 {
	my $name = "Iliyan Katsarov";
	print "Hello, $name from testsub1\n";

}

sub testsub3 {

	#print "Hello, ","$_[0]\n"; #prints the first element of the list
	#foreach(@_) {
	#	print "Hello $_\n"; #prints each element of the list
	#}
	print "Hello, @_\n"; #prints all elements together
}





#end
