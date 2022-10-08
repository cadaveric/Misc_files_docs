#!/usr/bin/perl -w
#Author: ikatsarov
#Date: 04.01.2022
#Purpose: Demonstrate Dir listings

$DIR = "/home/ilkatsarov/temp2";
$DIRHANDLE = "HANDLE";

      opendir ($DIRHANDLE, "$DIR") || die "Error opening $DIR: $!";
      @dirlist = readdir ($DIRHANDLE);
      foreach (@dirlist) {
          
              print "$_\n";
      
      }



#end
