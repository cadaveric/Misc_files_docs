#!/usr/bin/perl -w
#Author: ikatsarov
#Date: 24.12.2021
#Purpose: Demonstrate basic file I/O capabilities

#$fullname = "Iliyan Katsarov";
#$min = 1;
#$max = 20;

$IN = "INFILE";
$OUT = "OUTFILE";
$filenamein = "data1";
$filenameout = "data2";


open ($IN, "$filenamein") || die "Error opening $!";
open ($OUT, ">$filenameout") || die "Problems writing data to file: $!";

  @data1contents = <$IN>;
  foreach (@data1contents) {
  print $_; #prints each line
    if (/Iliyan/) {    #checks if it contains the given string. In this case "Iliyan"
     s/Iliyan/Kosi/; # if the line contains Iliyan, substitute it with Kosi
     print $OUT $_; # writes to data2 file
    }
}


#using a while loop 
#while (<INFILE>) {
# print "$_\n" #this variable is always available when looping through files. Contains each line of input from the file.
#}




#open (OUTFILE, ">data2") || die "Error opening $!";

#for ("$min" .. "$max") {print OUTFILE "$fullname\n";}


#end
