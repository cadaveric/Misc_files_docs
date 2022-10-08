#!/usr/bin/perl -w
#Author: ikatsarov
#Date: 12.04.2021
#Purpose: how to extract command line args or so called positional parameters

#Scalars, Arrays, Hashes - @ARGV

#	print "$ARGV[0]\n"; #prints the first positional element
#	$0 prints the script name
# 	perldoc -f exit - finds info about "exit" function. Thus you can find info on any other function.

	$REQPARAM = 3;
	$BADARGS = 165;
	$#ARGV +=1;
	unless($#ARGV==$REQPARAM) {
		print "$0 requires $REQPARAM arguments\n\n\n";
		exit $BADARGS;
	}
	print "\n@ARGV[0..2]\n";
	print "This script has accepted $#ARGV positional parameters.\n\n"; #prints the number of the array elements




#end

