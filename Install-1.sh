#!/usr/bin/env bash

sudo -S apt update && sudo -S apt upgrade
echo " "
echo "SET YOUR NEW ROOT PASSWORD:"
passwd root
echo " "
echo "CHOOSE A RANDOM 5 DIGIT PORT NUMBER (IF UNSURE USE 39844):"
read -n 5 portnumber
sudo -S sed -i "/^#Port 22/s/#Port 22/Port $portnumber/" /etc/ssh/sshd_config && sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
sudo -S apt-get install ufw -y
sudo -S ufw allow ssh/tcp
sudo -S ufw limit ssh/tcp
sudo -S ufw allow 3984/tcp
sudo -S ufw allow 8888/tcp
sudo -S ufw logging on
sudo -S ufw enable
sudo -S apt -y install fail2ban
sudo -S systemctl enable fail2ban
sudo -S systemctl start fail2ban
sudo -S service sshd restart
echo " "
echo " "
echo "CREATING YOUR NEW USER ACCOUNT"
echo "SET YOUR USERNAME:"
read username
adduser $username
usermod -aG sudo $username
sudo -S wget https://github.com/SooSDExZ/REMChain-Testnet-Guide/raw/master/Install-2.sh && sudo -S chmod u+x Install-2.sh
sudo snap install canonical-livepatch
wget https://github.com/Remmeauth/remprotocol/releases/download/0.1.0/remprotocol_0.1.0-ubuntu-18.04_amd64.deb && sudo apt install ./remprotocol_0.1.0-ubuntu-18.04_amd64.deb
wget https://testchain.remme.io/genesis.json
mkdir data && mkdir config
echo -e "plugin = eosio::chain_api_plugin\n\nplugin = eosio::net_api_plugin\n\nhttp-server-address = 0.0.0.0:8888\n\np2p-listen-endpoint = 0.0.0.0:9876\n\np2p-peer-address = 167.71.88.152:9877\n\nverbose-http-errors = true" > ./config/config.ini
rm -f ./Install-1.sh
remnode --config-dir ./config/ --data-dir ./data/ --delete-all-blocks --genesis-json genesis.json
