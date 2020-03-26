#!/bin/bash

#################################################
# This Scripts add user to the local host       #
#################################################

################################
# AUTHOR: GURPREET SINGH THIND #
# EMAIL: Thind.cse@gmail.com   #
################################


# Make sure the script is being executed with superuser privileges.
USER_ID=$(id -u)

if [[ "${USER_ID}" -ne 0  ]]
then
  echo "Please run the script with Superuser Permisssions"
else
  echo "Please answer the following questions to continue User Creation on this host" 
fi


# Get the username (login).
read -p "Enter the username for login : " USER_NAME


# Get the real name (contents for the description field).
read -p "Enter the Full Name of the user : " COMMENT

# Get the password.
read -p "Enter the password for the user : " PASSWORD

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "Unsuccessly execution of Adding User to local System"
  echo "Exit statu is ${?}"
  exit 1
else
  echo "Successly execution of Adding User to local System"
fi

# Set the password.
echo ${PASSWORD}| passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "Unsuccessly execution of setting Password"
  echo "Exit statu is ${?}"
  exit 1
else
  echo "Successly execution of setting password"
fi


# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.`
HOSTNAME=$(hostname -f)
echo "User name is ${USER_NAME}, Password for first Login is ${PASSWORD} and Machine to Login is ${HOSTNAME}"
