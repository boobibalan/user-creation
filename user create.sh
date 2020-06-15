#!/bin/bash
#this script will create a new user and prompted the details

if [[ "${UID}" -ne 0 ]]
then
echo 'please run with root or suderos'
exit 1
fi

read -p 'enter the username to create: ' user_name
read -p 'enter the purpose of this user: ' comment
read -p 'enter the password: ' password

useradd -c "${comment}" -m ${user_name}

if [["${?}" -ne 0 ]]
then
echo 'the account could not be created'
exit 1
fi

#set password
echo ${password} | passwd --stdin ${user_name}

if [[ "${?}" -ne 0 ]]
then
echo 'the password has not be set'
exit 1
fi

#force password change for first time login
passwd -e ${user_name}

echo
echo 'username: '
echo "${user_name}"
echo
echo 'password: '
echo "${password}"
echo
echo 'host: '
echo "${HOSTNAME}"
exit 0
