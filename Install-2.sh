#!/usr/bin/env bash

function pause(){
   read -p "$*"
}

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
sleep 1
remvault &
sleep 4
sudo wget https://github.com/SooSDExZ/REMChain-Testnet-Scripts/raw/master/countdown.sh && sudo chmod u+x countdown.sh
remcli wallet create --file walletpass
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
echo " "
echo "TAKE NOTE OF YOUR WALLET PASSWORD:"
cat ./walletpass
echo " "
pause 'Press [Enter] key to continue...'
echo " "
remcli create key --file key1
cp key1 activekeys1
sudo -S sed -i "/^Private key: /s/Private key: //" key1 && sudo -S sed -i "/^Public key: /s/Public key: //" key1
activepublickey1=$(head -n 2 key1 | tail -1)
activeprivatekey1=$(head -n 1 key1 | tail -1)
activeproducername1=a$(cat /dev/urandom | tr -dc 'a-z1-5' | fold -w 11 | head -n 1)
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
remcli create key --file key2
cp key2 activekeys2
sudo -S sed -i "/^Private key: /s/Private key: //" key2 && sudo -S sed -i "/^Public key: /s/Public key: //" key2
activepublickey2=$(head -n 2 key2 | tail -1)
activeprivatekey2=$(head -n 1 key2 | tail -1)
activeproducername2=b$(cat /dev/urandom | tr -dc 'a-z1-5' | fold -w 11 | head -n 1)
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
remcli create key --file key3
cp key3 activekeys3
sudo -S sed -i "/^Private key: /s/Private key: //" key3 && sudo -S sed -i "/^Public key: /s/Public key: //" key3
activepublickey3=$(head -n 2 key3 | tail -1)
activeprivatekey3=$(head -n 1 key3 | tail -1)
activeproducername3=c$(cat /dev/urandom | tr -dc 'a-z1-5' | fold -w 11 | head -n 1)
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
remcli system newaccount $owneraccountname $activeproducername1 $activepublickey1 $activepublickey1 --transfer --stake -x 120 "100.0000 REM" -p $owneraccountname@owner
pause 'Press [Enter] key to continue...'
remcli system newaccount $owneraccountname $activeproducername2 $activepublickey2 $activepublickey2 --transfer --stake -x 120 "100.0000 REM" -p $owneraccountname@owner
pause 'Press [Enter] key to continue...'
remcli system newaccount $owneraccountname $activeproducername3 $activepublickey3 $activepublickey3 --transfer --stake -x 120 "100.0000 REM" -p $owneraccountname@owner
pause 'Press [Enter] key to continue...'
sudo ./countdown.sh -m 2
remcli set account permission $owneraccountname active '{"threshold":2,"keys":[],"accounts":[{"permission":{"actor":"'$activeproducername1'","permission":"active"},"weight":1},{"permission":{"actor":"'$activeproducername2'","permission":"active"},"weight":1},{"permission":{"actor":"'$activeproducername3'","permission":"active"},"weight":1}],"waits":[]}' owner -p $owneraccountname@owner
