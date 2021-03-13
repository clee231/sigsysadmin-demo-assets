#!/bin/bash

# Assuming root privileges

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

for i in {1..25}
do
  useradd -m "user$i"
  echo "user$i:simpleACMPassword$i!" | chpasswd
  echo "export DO_PAT=\"bd56c4930b515b061f5a6aba7071a184de44dd017b251669795041c4aea153ab\"" >> /home/user$i/.bashrc
  echo "export CLOUDFLARE_API_TOKEN=\"E-JvtrX_gYgHRToYt7OSVG9-H39PoR7sy4qv9qkw\"" >> /home/user$i/.bashrc
  echo "export SPACES_ACCESS_KEY_ID=\"N3HT7KV7IGMWZRLCK4J6\"" >> /home/user$i/.bashrc
  echo "export SPACES_SECRET_ACCESS_KEY=\"JCzyOOHH9usjn6yRWp8yt72eGroW5MLuD+7mZQ4005g\"" >> /home/user$i/.bashrc
done

apt-get update
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt install terraform
apt install vim
