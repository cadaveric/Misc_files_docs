#!/usr/bin/perl -w
#Author:
#Purpose: Illustrate arrays of arrays and growing of arrays from a file

	open(HAN1, "data4") || die "Errors opening data1: $!";

	while (<HAN1>) {
		push @array1, [ split ]; # $_ => that's the default variable that the loop will operate on, unless you specify a var explicitly	
	}
	
	print "\nPrinting all elements of the array with \"foreach\"\n\n";

	foreach (@array1) {
		print "@$_\n"; # we use @ because it's a multidimensional array. If it was normal, we would use just $_
	}

	print "\n\nPrinting indvidual elements:\n\n$array1[3][2]\n\n"; # here we print the third element of 4th row
	print "\n\n$array1[4][1]\n\n"; # here we print the 2nd element ot the 5th row


#end
