#!/usr/bin/perl -w
#Author: ikatsarov
#Date: 24.12.2021
#Purpose: Demonstrate basic file I/O capabilities

$fullname = "Iliyan Katsarov";
$min = 1;
$max = 20;

open (OUTFILE, ">data2") || die "Error opening $!";


  for ("$min" .. "$max") {print OUTFILE "$fullname\n";}


#end
