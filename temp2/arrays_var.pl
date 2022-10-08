#!/usr/bin/perl -w
#Author:
#Purpose: explain arrays

#There are 3 types of variables in perl: Scalars, Arrays and Hashes

#Scalars = single value = $
#Arrays = lists of scalars or single values = @
#Hashes = key/value pairs = %

#YOU can have the same name for an array and for a scalar for an example.


$firstname = "Iliyan";
@carmanufacturers = ("Honda","Toyota","Nissan","Lexus","BMW","Skoda");

	print "Hello $firstname, please choose a car manufacturer.\n";
	print "$carmanufacturers[0]\t";
	print "$carmanufacturers[1]\t";
	print "$carmanufacturers[2]\t";
	print "$carmanufacturers[3]\n";
	print "This array contains $#carmanufacturers elements.\n";
	print "Another way of listing elements in an array is: @carmanufacturers[0,1,2,3,4,5]\n\n";
	print "And yet another way of listing elements in an array is: @carmanufacturers[0..5]\n";
#end
