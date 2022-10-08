#!/bin/bash
#Date - 04.10.2020	
#Author - ikatsarov
#Purpose - Function definition
#Created - 04.10.2020
#Modified - 

function showdate() {
	date +%F



}

function showtime() {
	date +%r

}

function mailadmin() {
	echo success | mail -s "Successfull script execution" root

}

showdate
showtime
#mailadmin



#end
