#!/usr/bin/env bash

sudo killall remnode
sudo remnode --config-dir ./config/ --data-dir ./data/ --fix-reversible-blocks --force-all-checks --genesis-json genesis.json
sudo remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
rm -f ./Install-5.sh
