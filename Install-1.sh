#!/usr/bin/env bash
sudo apt update && sudo apt upgrade
passwd root
sed -i '/^#Port 22/s/#Port 22/Port 3984/' /etc/ssh/sshd_config && sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
adduser admin
usermod -aG sudo admin
sudo service sshd restart
sudo apt-get install ufw -y
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw allow 3984/tcp
sudo ufw allow 8888/tcp
sudo ufw logging on
sudo ufw enable
sudo apt -y install fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
cd
wget https://github.com/Remmeauth/remprotocol/releases/download/0.1.0/remprotocol_0.1.0-ubuntu-18.04_amd64.deb && sudo apt install ./remprotocol_0.1.0-ubuntu-18.04_amd64.deb
wget https://testchain.remme.io/genesis.json
mkdir data && mkdir config
echo -e "plugin = eosio::chain_api_plugin\n\nplugin = eosio::net_api_plugin\n\nhttp-server-address = 0.0.0.0:8888\n\np2p-listen-endpoint = 0.0.0.0:9876\n\np2p-peer-address = 167.71.88.152:9877\n\nverbose-http-errors = true" > ./config/config.ini
remnode --config-dir ./config/ --data-dir ./data/ --delete-all-blocks --genesis-json genesis.json
