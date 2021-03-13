#!/bin/bash

# Assuming root privileges

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

for i in {1..25}
do
  useradd -m "user$i"
  echo "user$i:rujokinmeritemeow$i?" | chpasswd
done

apt-get update
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt install terraform
