#!/usr/bin/env bash

domain=$(cat domain.txt)
ownerpublickey=$(cat ownerpublickey.txt)
activepublickey=$(head -n 2 key1 | tail -1)
requestpublickey=$(head -n 2 key2 | tail -1)
produceraccountname=$(cat produceraccountname.txt)
remcli system regproducer $produceraccountname $requestpublickey $domain
remcli set action permission $produceraccountname rem regproducer safemode -p $produceraccountname@owner
remcli set action permission $produceraccountname rem unregprod safemode -p $produceraccountname@owner
remcli set action permission $produceraccountname rem voteproducer vote -p $produceraccountname@active
remcli set action permission $produceraccountname rem claimrewards claim -p $produceraccountname@active
remcli set action permission $produceraccountname rem delegatebw stake -p $produceraccountname@active
remcli set action permission $produceraccountname rem.token transfer transfer -p $produceraccountname@active
remcli system voteproducer prods $produceraccountname $produceraccountname -p $produceraccountname@vote
walletpassword=$(cat walletpass)
echo $walletpassword > producerwalletpass.txt
producerwalletpass=$(cat producerwalletpass.txt)
remcli wallet remove_key $ownerpublickey --password=$producerwalletpass
remcli wallet remove_key $activepublickey --password=$producerwalletpass
sudo killall remnode
sudo remnode --config-dir ./config/ --data-dir ./data/ --fix-reversible-blocks --force-all-checks --genesis-json genesis.json
sudo remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
rm key1 key2 key3 activekeys Install-4.sh domain.txt ownerpublickey.txt produceraccountname.txt producerwalletpass.txt 
