#!/bin/bash

zone=("" "all" "ws_ext_16" "ws_ext_17" "ws_ext_21" "ws_ext_22" "ws_ext_23")

read -p "What do you wnat to do (1:update, 2:install, 3:remove, 4:custom_script) : " todo
read -p """In which zone do you want to make the changes?
1: all
2: ws-ext-16
3: ws-ext-17
4: ws_ext_21
5: ws-ext-22
6: ws-ext-23

Please select zone: """ zn

if [[ $todo -eq 1 ]]
then
read -p "What do you wnat to upgrade: (* = will you upgrade all packages or write the exact name of the package):" update
ansible-playbook --user root -e "pchosts=${zone[$zn]}" -i inventory playbook.yml --tags "Update"
fi

if [[ $todo -eq 2 ]]
then
read -p "What do you want to install: " install
ansible-playbook --user root -e "pchosts=${zone[$zn]} pkgname=$install" -i inventory playbook.yml --tags "Install"
fi

if [[ $todo -eq 3 ]]
then
read -p "What do you want to remove: " remove
ansible-playbook --user root -e "pchosts=${zone[$zn]} pkgname=$remove" -i inventory playbook.yml --tags "Remove"
fi

if [[ $todo -eq 4 ]]
then
ansible-playbook --user root -e "pchosts=${zone[$zn]}" -i inventory playbook.yml --tags "obs_updates"
fi
