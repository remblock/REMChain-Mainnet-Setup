#!/usr/bin/env bash

sudo apt update && sudo apt upgrade
echo " "
echo "SET YOUR NEW ROOT PASSWORD:"
passwd root
echo " "
echo "SET YOUR RANDOM 5 DIGIT PORT NUMBER (USE 39844 IF UNSURE):"
read -e portnumber
sed -i '/^#Port 22/s/#Port 22/Port $portnumber/' /etc/ssh/sshd_config && sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
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
echo " "
echo " "
echo "CREATING YOUR NEW USER ACCOUNT"
echo "SET YOUR USERNAME:"
read -e username
adduser $username
usermod -aG sudo $username
rm -f ./Install-1.sh 
su - $username
