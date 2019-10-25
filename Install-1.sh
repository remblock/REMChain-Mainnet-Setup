#!/usr/bin/env bash

#**********************************************#
#                INSTALL-1.SH                  #
#**********************************************#

conf_path="/root/remblock/autobot/config"

function pause(){
   read -p "$*"
}

#----------------------------------------------
# UPDATING AND UPGRADING PACKAGE DATABASE 
#----------------------------------------------

sudo -S apt update && sudo -S apt upgrade
echo " "
echo "SET YOUR NEW ROOT PASSWORD:"
passwd root

#----------------------------------------------
# CHANGING DEFAULT SSH PORT NUMBER
#----------------------------------------------

echo " "
echo "CHOOSE A RANDOM 5 DIGIT PORT NUMBER (IF UNSURE USE 39844):"
read -n 5 portnumber
sudo -S sed -i "/^#Port 22/s/#Port 22/Port $portnumber/" /etc/ssh/sshd_config && sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config

#----------------------------------------------
# INSTALLING UNCOMPLICATED FIREWALL
#----------------------------------------------

sudo -S apt-get install ufw -y
sudo -S ufw allow ssh/tcp
sudo -S ufw limit ssh/tcp
sudo -S ufw allow $portnumber/tcp
sudo -S ufw allow 8888/tcp
sudo -S ufw allow 9877/tcp
sudo -S ufw logging on
sudo -S ufw enable

#----------------------------------------------
# INSTALLING FAIL2BAN
#----------------------------------------------

sudo -S apt -y install fail2ban
sudo -S systemctl enable fail2ban
sudo -S systemctl start fail2ban
sudo -S service sshd restart

#----------------------------------------------
# CREATING NEW USER ACCOUNT
#----------------------------------------------

echo " "
echo " "
echo "CREATING YOUR NEW USER ACCOUNT"
echo "SET YOUR USERNAME:"
read username
sudo adduser $username
sudo usermod -aG sudo $username

#----------------------------------------------
# INSTALLING SSH KEY PIRE FOR NEW USER 
#----------------------------------------------

su  $username -c ssh-keygen 

sudo sed -i ‘s/PasswordAuthentication yes/PasswordAuthentication no/’ /etc/ssh/sshd_config

echo " " 
echo "TAKE NOTE OF YOUR SSH PRIVATE KEY:" 
echo " " 
sudo cat /home/$username/.ssh/id_rsa 
echo " " 
pause 'Press [Enter] key to continue...' 
echo " " 

#----------------------------------------------
#COPY SSH KEY TO LOCAL MACHINE  
#----------------------------------------------

echo " let's copy the key file "

echo $SSH_CLIENT | awk '{ print $1}' 
ip_ssh=$(echo $SSH_CLIENT | awk '{ print $1}')
echo " "
echo "Enter" $ip_ssh" User Name "
read -e ssh_host_user
echo " "
sudo ssh-copy-id -i /home/$username/.ssh/id_rsa $ssh_host_user@$ip_ssh
echo " "
echo "********************** Done ************************"

#----------------------------------------------
# INSTALLING CANONICAL LIVEPATCH SERVICE
#----------------------------------------------

sudo snap install canonical-livepatch

#----------------------------------------------
# INSTALLING REM PROTOCOL BINARIES
#----------------------------------------------

wget https://github.com/Remmeauth/remprotocol/releases/download/0.1.0/remprotocol_0.1.0-ubuntu-18.04_amd64.deb && sudo apt install ./remprotocol_0.1.0-ubuntu-18.04_amd64.deb

#----------------------------------------------
# BOOTING REMNODE AND WALLET
#----------------------------------------------

wget https://testchain.remme.io/genesis.json

#----------------------------------------------
# CREATING A CONFIG AND DATA DIRECTORIES
#----------------------------------------------

mkdir data && mkdir config

#----------------------------------------------
# CONFIGURATION FILE (CONFIG/CONFIG.INI)
#----------------------------------------------

echo -e "plugin = eosio::chain_api_plugin\n\nplugin = eosio::net_api_plugin\n\nhttp-server-address = 0.0.0.0:8888\n\np2p-listen-endpoint = 0.0.0.0:9876\n\np2p-peer-address = 167.71.88.152:9877\n\nverbose-http-errors = true" > ./config/config.ini

#----------------------------------------------
# THE INITIAL RUN OF THE REMNODE
#----------------------------------------------

nohup remnode --config-dir ./config/ --data-dir ./data/ --delete-all-blocks --genesis-json genesis.json  2>&1 | tee remnode_sync.log &>/dev/null &

t1=""
t2=""
to_date=$(date '+%Y-%m-%d')
tail -n 3 -f  remnode_sync.log |  while read LINE0 
do 
t1=$(echo $LINE0 | cut -d'@' -f2 )
t2=$(echo $t1 | cut -d'T' -f1)
#echo $LINE0 
if [[ $to_date == $t2 ]]; then 

ps -ef | grep remnode | grep -v grep | awk '{print $2}' | xargs kill

fi 
echo "fetching blocks....."
done

#----------------------------------------------
# RUNNING REMNODE IN THE BACKGROUND 
#----------------------------------------------

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
sleep 1

#----------------------------------------------
# RUNNING THE WALLET DAEMON 
#----------------------------------------------

remvault &
sleep 2

#----------------------------------------------
# CREATING THE REMCLI WALLET
#----------------------------------------------

remcli wallet create --file walletpass
walletpassword=$(cat walletpass)
echo $walletpassword > producerwalletpass.txt
sudo echo "owneraccountname="$username >>$conf_path
sudo echo "walletpassword="$walletpassword >>$conf_path
echo " "

#----------------------------------------------
# ASKING FOR USER DETAILS 
#----------------------------------------------

echo " "
echo "WHATS YOUR PRODUCER DOMAIN ADDRESS?"
read -e domain
echo $domain > domain.txt
echo " "
echo "COPY AND PASTE YOUR TELEGRAM PUBLIC KEY:"
read -e ownerpublickey
echo $ownerpublickey > ownerpublickey.txt
echo " "
echo "COPY AND PASTE YOUR TELEGRAM PRIVATE KEY:"
read -e ownerprivatekey
remcli wallet import --private-key=$ownerprivatekey
echo " "
echo "COPY AND PASTE YOUR TESTNET ACCOUNT NAME:"
read -e owneraccountname
echo $owneraccountname > owneraccountname.txt
owneraccountname=$(cat owneraccountname.txt)

#----------------------------------------------
# YOUR REMNODE WALLET PASSWORD 
#----------------------------------------------

echo " "
echo "TAKE NOTE OF YOUR WALLET PASSWORD:"
cat ./walletpass
echo " "
pause 'Press [Enter] key to continue...'
echo " "

#----------------------------------------------
# CREATING YOUR REMNODE ACTIVE KEY 1 
#----------------------------------------------

remcli create key --file key1
cp key1 activekeys1
sudo -S sed -i "/^Private key: /s/Private key: //" key1 && sudo -S sed -i "/^Public key: /s/Public key: //" key1
activepublickey1=$(head -n 2 key1 | tail -1)
activeprivatekey1=$(head -n 1 key1 | tail -1)
activeproducername1=$(cat /dev/urandom | tr -dc 'a-z1-5' | fold -w 12 | head -n 1 |  grep -o . | sort |tr -d "\n")
echo $activeproducername1 > activeproducername1.txt
activeproducername1=$(cat activeproducername1.txt)
remcli wallet import --private-key=$activeprivatekey1
echo " "
echo "TAKE NOTE OF YOUR ACTIVE KEY 1:"
echo "Account Name:" $activeproducername1
cat ./activekeys1
echo " "
pause 'Press [Enter] key to continue...'
echo " "

#----------------------------------------------
# CREATING YOUR REMNODE ACTIVE KEY 2
#----------------------------------------------

remcli create key --file key2
cp key2 activekeys2
sudo -S sed -i "/^Private key: /s/Private key: //" key2 && sudo -S sed -i "/^Public key: /s/Public key: //" key2
activepublickey2=$(head -n 2 key2 | tail -1)
activeprivatekey2=$(head -n 1 key2 | tail -1)
activeproducername2=$(cat /dev/urandom | tr -dc 'a-z1-5' | fold -w 12 | head -n 1 | grep -o . | sort |tr -d "\n")
echo $activeproducername2 > activeproducername2.txt
activeproducername2=$(cat activeproducername2.txt)
remcli wallet import --private-key=$activeprivatekey2
echo " "
echo "TAKE NOTE OF YOUR ACTIVE KEY 2:"
echo "Account Name:" $activeproducername2
cat ./activekeys2
echo " "
pause 'Press [Enter] key to continue...'
echo " "

#----------------------------------------------
# CREATING YOUR REMNODE ACTIVE KEY 3 
#----------------------------------------------

remcli create key --file key3
cp key3 activekeys3
sudo -S sed -i "/^Private key: /s/Private key: //" key3 && sudo -S sed -i "/^Public key: /s/Public key: //" key3
activepublickey3=$(head -n 2 key3 | tail -1)
activeprivatekey3=$(head -n 1 key3 | tail -1)
activeproducername3=$(cat /dev/urandom | tr -dc 'a-z1-5' | fold -w 12 | head -n 1 |  grep -o . | sort |tr -d "\n")
echo $activeproducername3 > activeproducername3.txt
activeproducername3=$(cat activeproducername3.txt)
remcli wallet import --private-key=$activeprivatekey3
echo " "
echo "TAKE NOTE OF YOUR ACTIVE KEY 3:"
echo "Account Name:" $activeproducername3
cat ./activekeys3
echo " "
pause 'Press [Enter] key to continue...'
echo " "

#----------------------------------------------
# CREATING YOUR REMNODE REQUEST KEY 
#----------------------------------------------

remcli create key --file key4
cp key4 requestkeys
sudo -S sed -i "/^Private key: /s/Private key: //" key4 && sudo -S sed -i "/^Public key: /s/Public key: //" key4
requestpublickey=$(head -n 2 key4 | tail -1)
requestprivatekey=$(head -n 1 key4 | tail -1)
remcli wallet import --private-key=$requestprivatekey
echo -e "plugin = eosio::chain_api_plugin\n\nplugin = eosio::net_api_plugin\n\nhttp-server-address = 0.0.0.0:8888\n\np2p-listen-endpoint = 0.0.0.0:9876\n\np2p-peer-address = 167.71.88.152:9877\n\nverbose-http-errors = true\n\nplugin = eosio::producer_plugin\n\nplugin = eosio::producer_api_plugin\n\nproducer-name = $owneraccountname\n\nsignature-provider = $requestpublickey=KEY:$requestprivatekey" > ./config/config.ini
echo " "
echo "TAKE NOTE OF YOUR REQUEST KEYS:"
cat ./requestkeys
echo " "
pause 'Press [Enter] key to continue...'
echo " "

#----------------------------------------------
# CREATING YOUR REMNODE TRANSFER KEY  
#----------------------------------------------

remcli create key --file key5
cp key5 transferkeys
sudo -S sed -i "/^Private key: /s/Private key: //" key5 && sudo -S sed -i "/^Public key: /s/Public key: //" key5
transferprivatekey=$(head -n 1 key5 | tail -1)
remcli wallet import --private-key=$transferprivatekey
echo " "
echo "TAKE NOTE OF YOUR TRANSFER KEYS:"
cat ./transferkeys
echo " "
pause 'Press [Enter] key to continue...'

#----------------------------------------------
# CREATING YOUR REMCHAIN ACCOUNTS
#----------------------------------------------

remcli system newaccount $owneraccountname $activeproducername1 $activepublickey1 $activepublickey1 -x 120 --transfer --stake "100.0000 REM" -p $owneraccountname@owner
pause 'Press [Enter] key to continue...'
remcli system newaccount $owneraccountname $activeproducername2 $activepublickey2 $activepublickey2 -x 120 --transfer --stake "100.0000 REM" -p $owneraccountname@owner
pause 'Press [Enter] key to continue...'
remcli system newaccount $owneraccountname $activeproducername3 $activepublickey3 $activepublickey3 -x 120 --transfer --stake "100.0000 REM" -p $owneraccountname@owner
sleep 2
sudo ./countdown.sh -m 1

#----------------------------------------------
# CREATING YOUR MULTISIG PERMISSIONS
#----------------------------------------------

remcli set account permission $owneraccountname active '{"threshold":2,"keys":[],"accounts":[{"permission":{"actor":"'$activeproducername1'","permission":"active"},"weight":1},{"permission":{"actor":"'$activeproducername2'","permission":"active"},"weight":1},{"permission":{"actor":"'$activeproducername3'","permission":"active"},"weight":1}],"waits":[]}' owner -p $owneraccountname@owner
