#!/usr/bin/perl -w
#Author: ikatsarov
#Date: 24.12.2021
#Purpose: Demonstrate basic file I/O capabilities

$FILEHANDLE = "FILEREADWRITE";
#$filename = "data1";
#$appendtofile = "Append";
                    # +>>$filename - this will append to the file  
                    # +>$filename - clobbers the file, deletes its contents

        open ($FILEHANDLE, "netstat -ant |") || die "Error opening $!"; # +<$filename - open the file for reading as well as appending
        @data1contents = <$FILEHANDLE>;
  
        foreach (@data1contents) {
            if (/80/) {
                 print  $_;
            }
        } 


#end
