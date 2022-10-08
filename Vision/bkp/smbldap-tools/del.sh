#!/bin/bash
for i in $@
do 
	/usr/local/smbldap-tools/owlbg_usermgnt -d $i
done
