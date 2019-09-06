#!/usr/bin/env bash

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
remvault &
sleep 10
remcli wallet create --file walletpass
remcli create key --file requestkey
remcli create key --file producerkey
cat ./requestkey
cat ./producerkey
remcli wallet import
remcli wallet import
rm -f ./Install-2.sh Install-3.sh
