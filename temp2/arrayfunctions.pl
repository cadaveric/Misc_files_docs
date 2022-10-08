#!/usr/bin/perl -w
#Author: Iliyan Katsarov
#Date: 09.04.2021
#Purpose: Demonstrate common array functions

use strict;

my $firstname = "Iliyan";
my $middlename = "Emilov";
my $lastname = "Katsarov";
my @array1 = ("1","2","3");

	print "\n@array1\n";
	print "$array1[0]\n";

# pop function removes the last element of an array
	
my $ppop = pop @array1;

	print "@array1\n"; # now this should remove the last element of the array
	print "$ppop\n";

push @array1, $ppop;
	print "The array now contains: @array1\n\n"; #brings back the value stored in the $ppop function
push @array1, $firstname;
	print "@array1\n";

###use of shift & unshift

unshift @array1, $firstname, $lastname; #push the contents of $firstname and $lastname to the beginning of @array1
	print "\n@array1\n";

#shift totally removes the first element

shift @array1; #remove the value from the first element from the array
	print "After using Shift: @array1\n";

#end
