#!/usr/bin/perl -w
#Author:
#Purpose: Illustrate arrays of arrays and growing of arrays from a file

@array1 = (["1","2"],["3","4"],["5","6"]); #multidiminsional array
$array1ref = [["1","2"],["3","4"],["5","6"]]; #multidiminsional array reference


print "$array1[0][0]\n"; #prints first element of the first array which is in this case 1
print "$array1[2][1]\n"; #prints second element of the third array

print "$array1ref->[0][0]","\n";


#end
