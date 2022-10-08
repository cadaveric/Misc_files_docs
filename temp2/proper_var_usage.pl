#!/usr/bin/perl -w
#Author:
#Date:
#Purpose: Demonstrate proper var declaration techniquies
use strict;


#global and lexical vars
my $firstname = "Iliyan"; #lexical
my $age = "32"; #lexical
our $count = "1"; #global
#variables in perl must begin with (aA_)
#can't define var with a numeric, e.g. $101Park
#if you define var, starting with _ it will work
my $_101Park = 101;


	print "$firstname is $age years young", "\n";
	print "Count is set to ", "$count\n";
	print "$_101Park", "\n";

#Block definition - we can define variable with the same names, but within the block they are different. That's because we used "my" and "use strict"
# $count is global because we used our
{
my $firstname = "Jeko";
my $age = "5 months old";

print "$firstname is $age", "\n";
print "Count is $count\n";
}

#outside of the block $firstname will result to Iliyan

print "Proving that outside of the block the var is: $firstname\n";

#read vars from Standard Input

my $lastname = <STDIN>;

print "Your last name is : $lastname", "\n";

#end
