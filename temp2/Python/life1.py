#!/usr/bin/python2.7
#Author: Iliyan Katsarov
#Date: 13.02.2022
#Purpose: illustrate input functions

print "-----------------------Life Expectancy v0.99-----------------------------------------"
name = raw_input("What is your name? ")
print name + ',', 
age = input("What is your age? ")
print name + ',',
expect = input("To what age do you expect to live? ")
print name + ',',
print "based on our calculations, you will live for", expect - age, "more years."
print "Thank you for using v0.99"
#end
