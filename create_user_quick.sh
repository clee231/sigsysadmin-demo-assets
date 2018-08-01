#!/bin/bash

if [ -z $1 ]; then
  echo "No user specified"
  exit; 
fi

adduser $1
mkdir -p /home/$1/.ssh
cp /home/sig1/.ssh/* /home/$1/.ssh
chown -R $1:$1 /home/$1/.ssh
chmod 500 /home/$1/.ssh
