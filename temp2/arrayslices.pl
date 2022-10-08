#!/usr/bin/perl -w
#Author: Iliyan Katsarov
#Date: 07.04.2021
#Purpose: Explain Lists, Slices, Ranges, etc.
#Scalars(single values), Arrays(lists), Hashes(key/value pairs)
use strict;
	
	print (qw(Boston Charlotte Newark Miami) [0,1]);
       	print (qw(Sofia Varna Burgas Dobrich) [1..3]); #that's a range

my @uscities = qw(New York Los Angeles Las Vegas Austin Dallas Houston Columbia Atlanta);

print "\n@uscities[0,1]\n";
print "\nSome cities: ","@uscities[0..2,7,8]\n";
print "\n@uscities[0..$#uscities]\n"; # prints all values in the array

my @eastcoastcities = @uscities[6..$#uscities]; #that's an array slice - slice of the main array @uscities.
print "@eastcoastcities\n";
#end
