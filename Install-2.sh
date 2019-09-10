#!/usr/bin/env bash

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
sleep 1
remvault &
sleep 4
remcli wallet create --file walletpass
sudo -S wget https://github.com/SooSDExZ/REMChain-Testnet-Guide/raw/master/Install-3.sh && sudo -S chmod u+x Install-3.sh
sudo ./Install-3.sh
