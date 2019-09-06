#!/usr/bin/env bash

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
remvault &
sleep 10
remcli wallet create --file walletpass
remcli create key --file requestkey
remcli create key --file producerkey
cat ./requestkey
remcli wallet import
cat ./producerkey
remcli wallet import
echo "What's your account name?"
read -e produceraccountname
echo "What's your producer private key?"
read -e producerprivatekey
echo "What's your producer public key?"
read -e producerpublickey
echo -e "producer-name = $produceraccountname\n\nsignature-provider = $producerpublickey=KEY:$producerprivatekey" > ./config/config.ini
rm -f ./Install-2.sh Install-3.sh
