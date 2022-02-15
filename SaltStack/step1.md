`wget -O- https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -`{{execute}}

`echo "deb https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" | sudo tee /etc/apt/sources.list.d/saltstack.list`{{execute}}

`apt update`{{execute}}

`apt -y install salt-api salt-cloud salt-master salt-ssh salt-syndic`{{execute}}

`sed -i "s/#auto_accept: False/auto_accept: True/g" /etc/salt/master`{{execute}}

`systemctl restart salt-master`{{execute}}

`LOCAL_IP=$(ifconfig ens3 |grep "inet "| awk '{print $2}') && echo "$LOCAL_IP"`{{execute}}

`apt -y install salt-minion`{{execute}}

`sed -i "s/#master: salt/master: $LOCAL_IP/g" /etc/salt/minion`{{execute}}

`systemctl restart salt-minion`{{execute}}

`salt \* test.ping`{{execute}}
