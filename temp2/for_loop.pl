#!/usr/bin/perl -w
#Author: ikatsarov
#Date: 13.04.2021
#Purpose: For Loop 1

	##### C style for loop
	for ($i=1;$i<=10;$i++) {
		print "$i\n"; # you can print it without the quotes here because it's an integer
	
	}
	
	for ($i=10;$i<=20;$i++) {print "$i\n";} # this is how to do it in 1 line

$min = 20;
$max = 30;
$PRODNAME = "LinuxCBT Scripting Edition";

@array1 = ("Dean","Linuxcbt","Scripting","Debian","RedHat");

#	for ($i=$min;$i<=$max;$i++) {print "$i\n";} # this is how to do it with vars

#	for ($min..$max){print "$PRODNAME\n";}	# another shorter quick and dirty way

			############## foreach - works exclusively with arrays
	foreach (@array1) {
		print "$_\n"; #this will print the current value of the array, prints one at a time the values that we have in the array.
	}
		$#array1 +=1;
		print "Total Array Elements = $#array1\n";




#end
