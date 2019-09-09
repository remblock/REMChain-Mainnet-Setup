#!/usr/bin/env bash

function pause(){
   read -p "$*"
}

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
remvault &
sleep 4
remcli wallet create --file walletpass
echo " "
echo " "
echo "COPY AND PASTE YOUR TELEGRAM PUBLIC KEY (OWNER KEY):"
read -e ownerpublickey
echo " "
echo "COPY AND PASTE YOUR TELEGRAM PRIVATE KEY (OWNER KEY):"
read -e ownerprivatekey
remcli wallet import --private-key=$ownerprivatekey
echo " "
remcli create key --file key1
cp key1 activekeys
sudo -S sed -i "/^Private key: /s/Private key: //" key1 && sudo -S sed -i "/^Public key: /s/Public key: //" key1
activeprivatekey=$(head -n 1 key1)
activepublickey=$(head -n 2 key1)
echo " "
echo "TAKE NOTE OF YOUR ACTIVE KEYS:"
cat ./activekeys
echo " "
pause 'Press [Enter] key to continue...'
remcli wallet import --private-key=$activeprivatekey
echo " "
remcli create key --file key2
cp key2 requestkeys
sudo -S sed -i "/^Private key: /s/Private key: //" key2 && sudo -S sed -i "/^Public key: /s/Public key: //" key2
requestprivatekey=$(head -n 1 key2)
requestpublickey=$(head -n 2 key2)
remcli wallet import --private-key=$requestprivatekey
echo " "
remcli create key --file key3
cp key3 producerkeys
sudo -S sed -i "/^Private key: /s/Private key: //" key3 && sudo -S sed -i "/^Public key: /s/Public key: //" key3
producerprivatekey=$(head -n 1 key3)
producerpublickey=$(head -n 2 key3)
remcli wallet import --private-key=$producerprivatekey
echo " "
echo "WHATS YOUR PRODUCER ACCOUNT NAME?"
read -e produceraccountname
echo $produceraccountname > produceraccountname.txt
produceraccountname=$(cat produceraccountname.txt)
echo " "
echo "WHATS YOUR PRODUCER DOMAIN ADDRESS?"
read -e domain
echo -e "plugin = eosio::chain_api_plugin\n\nplugin = eosio::net_api_plugin\n\nhttp-server-address = 0.0.0.0:8888\n\np2p-listen-endpoint = 0.0.0.0:9876\n\np2p-peer-address = 167.71.88.152:9877\n\nverbose-http-errors = true\n\nproducer-name = $produceraccountname\n\nsignature-provider = $producerpublickey=KEY:$producerprivatekey" > ./config/config.ini
remcli set account permission $produceraccountname active $activepublickey owner -p $produceraccountname@owner
remcli system regproducer $produceraccountname $producerpublickey $domain
remcli set account permission $produceraccountname vote $requestpublickey active -p $produceraccountname@active
remcli set action permission $produceraccountname rem voteproducer vote -p $produceraccountname@active
remcli set account permission $produceraccountname claim $requestpublickey active -p $produceraccountname@active
remcli set action permission $produceraccountname rem claimrewards claim -p $produceraccountname@active
remcli set account permission $produceraccountname stake $requestpublickey active -p $produceraccountname@active
remcli set action permission $produceraccountname rem delegatebw stake -p $produceraccountname@active
remcli set account permission $produceraccountname transfer $requestpublickey active -p $produceraccountname@active
remcli set action permission $produceraccountname rem transfer transfer -p $produceraccountname@active
remcli system voteproducer prods $produceraccountname $requestpublickey -p $produceraccountname@vote
walletpassword=$(cat walletpass)
remcli wallet remove_key $ownerpublickey --password=$walletpassword && remcli wallet remove_key $activepublickey --password=$walletpassword
rm key1 key2 key3 activekeys produceraccountname.txt
rm -f ./Install-4.sh
