#!/usr/bin/env bash

sudo wget https://github.com/SooSDExZ/Installation-Scripts/raw/master/Install-2.sh
sudo wget https://github.com/SooSDExZ/Installation-Scripts/raw/master/Install-3.sh
chmod u+x Install-2.sh && chmod u+x Install-3.sh
sudo apt update && sudo apt upgrade
passwd root
sed -i '/^#Port 22/s/#Port 22/Port 3984/' /etc/ssh/sshd_config && sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
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
sudo service sshd restart
adduser admin
usermod -aG sudo admin
su - admin
