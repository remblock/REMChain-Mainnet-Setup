#!/usr/bin/env bash

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
sleep 1
remvault &
sleep 4
remcli wallet create --file walletpass
