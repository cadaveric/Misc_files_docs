#!/bin/bash

zone=("" "laptops_home" "laptops_home_2")

read -p "What do you wnat to do (1:update, 2:autoclean, 3:sophos) : " todo
read -p """In which zone do you want to make the changes?
1: laptops_home
2: laptops_home_2

Please select zone: """ zn

if [[ $todo -eq 1 ]]
then
read -p "Updating..." update
ansible-playbook --user root -e "pchosts=${zone[$zn]}" -i inventory.laptops playbook_laptops.yml --tags "update"
fi

if [[ $todo -eq 2 ]]
then
read -p "Autoclean?: " autoclean
ansible-playbook --user root -e "pchosts=${zone[$zn]}" -i inventory.laptops playbook_laptops.yml --tags "autoclean"
fi

if [[ $todo -eq 3 ]]
then
echo -e  "Installing sophos\n"
ansible-playbook --user root -e "pchosts=${zone[$zn]}" -i inventory.laptops playbook_laptops.yml --tags "sophos"
fi
