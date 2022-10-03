for i in {1..25}
do
          useradd -m "sysadmin$i" -s /bin/bash
    done

    apt-get update
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    apt install terraform
    apt install ansible
    apt install python3