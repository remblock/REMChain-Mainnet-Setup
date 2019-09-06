#!/usr/bin/env bash

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
remvault &
sleep 4
remcli wallet create --file walletpass
echo "Copy and paste your telegram private key (owner key):"
remcli wallet import
echo "Take note of your active keys:"
remcli create key --to-console activekeys
echo "Copy and paste your active private key:"
remcli wallet import
remcli create key --file producerkeys
cat ./producerkeys
echo "Copy and paste your producer private key:"
remcli wallet import
remcli create key --file requestkeys
cat ./requestkeys
echo "Copy and paste your request private key:"
remcli wallet import
echo "What's your producer account name?"
read -e produceraccountname
echo "What's your active public key?"
read -e activepublickey
echo "What's your request public key?"
read -e requestpublickey
echo "What's your producer public key?"
read -e producerpublickey
echo "What's your producer private key?"
read -e producerprivatekey
echo "What's your producer domain address?"
read -e domain
echo -e "plugin = eosio::chain_api_plugin\n\nplugin = eosio::net_api_plugin\n\nhttp-server-address = 0.0.0.0:8888\n\np2p-listen-endpoint = 0.0.0.0:9876\n\np2p-peer-address = 167.71.88.152:9877\n\nverbose-http-errors = true\n\nproducer-name = $produceraccountname\n\nsignature-provider = $producerpublickey=KEY:$producerprivatekey" > ./config/config.ini
remcli set account permission $produceraccountname active activepublickey owner -p produceraccountname@owner
remcli system regproducer $produceraccountname $producerpublickey $domain
remcli set account permission $produceraccountname vote $requestpublickey active -p $produceraccountname@active
remcli set action permission $produceraccountname rem voteproducer vote -p $produceraccountname@active
remcli system voteproducer prods $produceraccountname $requestpublickey -p $produceraccountname@vote
remcli set account permission $produceraccountname claim $requestpublickey active -p $produceraccountname@active
remcli set action permission $produceraccountname rem claimrewards claim -p $produceraccountname@active
remcli set account permission $produceraccountname stake $requestpublickey active -p $produceraccountname@active
remcli set action permission $produceraccountname rem delegatebw stake -p $produceraccountname@active
remcli set account permission $produceraccountname transfer $requestpublickey active -p $produceraccountname@active
remcli set action permission $produceraccountname rem transfer transfer -p $produceraccountname@active
rm -f ./Install-2.sh Install-3.sh
