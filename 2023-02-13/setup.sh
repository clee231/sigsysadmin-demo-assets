#!/bin/bash

for i in {1..25}
do
          useradd -m "sysadmin$i" -s /bin/bash
          mkdir -p /home/sysadmin$i/.ssh
          echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+mvOZP0URI/X2YoBv2YIRbXX69Tnz9yhhgp0PaGTJTJNHOlYnaCuKCrtrkyoKxGg7Xk+i/eiwwxnS1LEIMnkglR+fwPp1cxRJqTe+jPzB59YlxgeHtAHibhjbEQgLix8Bk+w8F5QVnX4AcRK2SBycmoduriUnkHCiDCcCuTTnMVl6S7JCE/b55yJ/BzAXk1qrIyjHpMxcHxUpJ4IvKyeBN0pm9Pz/dPJnxXY7E0LNkSzrM1Qk19mAiE2jCqpbjFnP59z3IBicwBk0CWxq1rwxnZy7D4d22O3w7qZ/edVt9xqsK+rmWzOIi27VC2T4oe1FMBZJ/SAnV4f7t8p5r/cqNK9ZzMyjRvn9+9IWP5J+hJ4RqqoLqUov/LVG9CR7nqrAOSY1oj6E18+oSPMXu6VvESnYwgu77JF1zhK0Im8/iX6HDYRY3Pc6NBBJ55DeVURbFMuKD0v3f+sh5gxR94EJwVh8AzsZhkyZmRw2rpdfJzG60NzQaiP2vyED7wuwECc= sysadmin@meeting" > /home/sysadmin$i/.ssh/authorized_keys
          chmod 700 /home/sysadmin$i/.ssh
          chmod 600 /home/sysadmin$i/.ssh/authorized_keys
          chown -R sysadmin$i:sysadmin$i /home/sysadmin$i/.ssh
    done

    apt-get update
    apt install ansible
    apt install python3
