```bash
wget -O- https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -

echo "deb https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" | sudo tee /etc/apt/sources.list.d/saltstack.list
```{{execute}}

`apt update`{{execute}}

`apt -y install salt-api salt-cloud salt-master salt-ssh salt-syndic`{{execute}}

`apt -y install salt-minion`{{execute}}
