#!/usr/bin/perl -w
#Author:
#Purpose: Explain escaping and quoting

$name = Dean;

print "$name\n","\t";
print "Aren't you happy?\n","\n\n\n";
print "c:\\windows","\n";
print "c:\\Documents and settings\n";
print q {' ' " " ; : $ \\},"\n";
print '$name\n'; #- this will be treated literally and the variable won't be expanded




#end
