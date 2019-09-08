#!/usr/bin/env bash

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
remvault &
sleep 4
remcli wallet create --file walletpass
echo " "
echo " "
echo "COPY AND PASTE YOUR TELEGRAM PRIVATE KEY (OWNER KEY):"
remcli wallet import
echo " "
remcli create key --file key1
cp key1 activekeys
echo " "
echo "TAKE NOTE OF YOUR ACTIVE KEYS:"
cat ./key1
echo "Copy and paste your active private key:"
remcli wallet import
echo " "
remcli create key --file key2
cp key2 requestkeys
echo " "
echo "TAKE NOTE OF YOUR REQUEST KEYS:"
cat ./key2
echo "Copy and paste your request private key:"
remcli wallet import
echo " "
remcli create key --file key3
cp key3 producerkeys
echo " "
echo "TAKE NOTE OF YOUR PRODUCER KEYS:"
cat ./key3
echo "Copy and paste your producer private key:"
remcli wallet import
echo " "
sudo -S sed -i "/^Private key: /s/Private key: //" key1 && sudo -S sed -i "/^Public key: /s/Public key: //" key1
sudo -S sed -i "/^Private key: /s/Private key: //" key2 && sudo -S sed -i "/^Public key: /s/Public key: //" key2
sudo -S sed -i "/^Private key: /s/Private key: //" key3 && sudo -S sed -i "/^Public key: /s/Public key: //" key3
activepublickey=$(head -n 2 key1)
requestpublickey=$(head -n 2 key2)
producerprivatekey=$(head -n 1 key3)
producerpublickey=$(head -n 2 key3)
echo "What's your producer account name?"
read -e produceraccountname
echo " "
echo "What's your producer domain address?"
read -e domain
echo -e "plugin = eosio::chain_api_plugin\n\nplugin = eosio::net_api_plugin\n\nhttp-server-address = 0.0.0.0:8888\n\np2p-listen-endpoint = 0.0.0.0:9876\n\np2p-peer-address = 167.71.88.152:9877\n\nverbose-http-errors = true\n\nproducer-name = $produceraccountname\n\nsignature-provider = $producerpublickey=KEY:$producerprivatekey" > ./config/config.ini
remcli set account permission $produceraccountname active $activepublickey owner -p produceraccountname@owner
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
rm keys1 key2 key3 activekeys
rm -f ./Install-2.sh Install-3.sh
