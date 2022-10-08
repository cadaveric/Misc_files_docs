#!/usr/bin/perl -w
#Author:
#Date: 12.04.2021
#Purpose: Demonstrate conditionals	
# ==, <=, >=, <, > -  These are all operators to test integers
#
# gt, ge, lt, le, etc. - this way you test strings
	
$value1 = 1;
$value2 = 2;
$firstname = "Iliyan";
$nickname = "Dean";

	if ($value1 == $value2) {
		print "\n$value1 is equal to $value2\n";
	}
	elsif ($value1 < $value2) {
		print "$value1 is less than $value2\n\n";
		$itworked = "yes, it worked";
		print "$itworked\n\n";
	}
	##	
	if ($firstname eq $nickname) {
		print "$firstname is equal to $nickname\n";
	}
	else {
		print "$firstname is not equal to $nickname\n";
	}	
	###
	unless ($firstname eq $nickname) {
		print "$firstname is NOT equal to $nickname\n";

	}

	print "this is a one liner\n\n" if $value1 <= $value2;
#end

