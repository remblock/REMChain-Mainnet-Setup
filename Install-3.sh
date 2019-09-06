#!/usr/bin/env bash

remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
remvault &
sleep 10
remcli wallet create --file walletpass
remcli create key --to-console --file requestkey
remcli create key --to-console --file producerkey
remcli wallet import
remcli wallet import
