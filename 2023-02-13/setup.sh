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

ufw disable
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport ssh -j ACCEPT
iptables --policy INPUT DROP
iptables-save > /etc/iptables.rules

 systemctl disable systemd-resolved
 systemctl stop systemd-resolved

curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install confettysh
# confettysh --port 4336 --metrics-port 9224
# confettysh --port 2222
# confettysh --port 1336 --metrics-port 9223
# ./clidle -serve 0.0.0.0:4321
# ./clidle -serve 0.0.0.0:1234
# ./clidle -serve 0.0.0.0:4321
# ./clidle -serve 0.0.0.0:8889
# ./clidle -serve 0.0.0.0:8888
