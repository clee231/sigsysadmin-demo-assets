#!/usr/bin/env bash

programs=( ansible vim htop cmake node nginx httpd docker cowsay )

while true; do
        echo `date` " - " `hostname`
        for i in "${programs[@]}"; do
                if hash $i 2>/dev/null; then
                echo -e $i  "    \t \e[32mInstalled\e[0m"
                else
                echo -e $i  "    \t \e[31mNot Installed\e[0m"
                fi
        done
        sleep 1
        clear
done
