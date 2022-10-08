#!/usr/bin/perl -w
#Author: ikatsarov
#Date: 24.12.2021
#Purpose: While & Until Loop

#                       while (condition) {

#                            body
                                      #}

$value1 = 1;
$value2 = 20;
$firstname = "Iliyan";
$lastname = "Katsarov";

#        while ($value1 <= $value2) {
#
#        print "$firstname $lastname\n";
#       $value1 +=1;

#}

###infinite loop - value2 keeps incrementing. Comment the first loop to make this one work.
#        while ($value2 > $value1) {

#        print "$value2\n";
#        $value2 +=1;

#}

## Until loop

        until ($value2 <= $value1) {
        print "$value2\n";
        $value2 -=1;
}


#end
