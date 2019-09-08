#!/usr/bin/env bash
su $username
remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
remvault &
sleep 4
remcli wallet create --file walletpass
echo " "
echo " "
echo "COPY AND PASTE YOUR TELEGRAM PRIVATE KEY (OWNER KEY):"
remcli wallet import
echo " "
echo " "
echo "TAKE NOTE OF YOUR ACTIVE KEYS:"
remcli create key --to-console
echo "Copy and paste your active private key:"
remcli wallet import
echo " "
remcli create key --file producerkeys
echo " "
echo "TAKE NOTE OF YOUR PRODUCER KEYS:"
cat ./producerkeys
echo "Copy and paste your producer private key:"
remcli wallet import
echo " "
remcli create key --file requestkeys
echo " "
echo "TAKE NOTE OF YOUR REQUEST KEYS:"
cat ./requestkeys
echo "Copy and paste your request private key:"
remcli wallet import
echo " "
echo "What's your active public key?"
read -e activepublickey
echo " "
echo "What's your producer private key?"
read -e producerprivatekey
echo " "
echo "What's your producer public key?"
read -e producerpublickey
echo " "
echo "What's your request public key?"
read -e requestpublickey
echo " "
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
rm -f ./Install-2.sh Install-3.sh
