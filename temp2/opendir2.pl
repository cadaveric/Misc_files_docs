#!/usr/bin/perl -w
#Author: ikatsarov
#Date: 04.01.2022
#Purpose: Demonstrate Dir listings. If you want the code to be portable, use perl's built-in functions in the previous example, like opendir and readdir

$DIR = "/home/ilkatsarov/temp2";
@dirlist = `ls -A $DIR`;      

              foreach (@dirlist) {
          
                      print "$_";
      
              }



#end
