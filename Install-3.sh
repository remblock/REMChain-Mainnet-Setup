#!/usr/bin/env bash

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
remvault &
sleep 10
remcli wallet create --file walletpass
remcli create key --file producerkey
cat ./producerkey
remcli wallet import
remcli create key --file requestkey
cat ./requestkey
remcli wallet import
echo "What's your account name?"
read -e produceraccountname
echo "What's your producer private key?"
read -e producerprivatekey
echo "What's your producer public key?"
read -e producerpublickey
echo -e "plugin = eosio::chain_api_plugin\n\nplugin = eosio::net_api_plugin\n\nhttp-server-address = 0.0.0.0:8888\n\np2p-listen-endpoint = 0.0.0.0:9876\n\np2p-peer-address = 167.71.88.152:9877\n\nverbose-http-errors = true\n\nproducer-name = $produceraccountname\n\nsignature-provider = $producerpublickey=KEY:$producerprivatekey" > ./config/config.ini
rm -f ./Install-2.sh Install-3.sh
