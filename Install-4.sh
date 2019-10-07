#!/usr/bin/env bash

#**************************************#
#            INSTALL-4.SH              #
#**************************************#

domain=$(cat domain.txt)
ownerpublickey=$(cat ownerpublickey.txt)
owneraccountname=$(cat owneraccountname.txt)
producerwalletpass=$(cat producerwalletpass.txt)
activepublickey1=$(head -n 2 key1 | tail -1)
activepublickey2=$(head -n 2 key2 | tail -1)
activepublickey3=$(head -n 2 key3 | tail -1)
requestpublickey=$(head -n 2 key4 | tail -1)
remcli set action permission $owneraccountname rem regproducer safemode -p $owneraccountname@owner
remcli set action permission $owneraccountname rem unregprod safemode -p $owneraccountname@owner
remcli set action permission $owneraccountname rem voteproducer vote -p $owneraccountname@active
remcli set action permission $owneraccountname rem claimrewards claim -p $owneraccountname@active
remcli set action permission $owneraccountname rem delegatebw stake -p $owneraccountname@active
remcli set action permission $owneraccountname rem.token transfer transfer -p $owneraccountname@active
remcli system voteproducer prods $owneraccountname $owneraccountname -p $owneraccountname@vote
remcli wallet remove_key $ownerpublickey --password=$producerwalletpass
remcli wallet remove_key $activepublickey1 --password=$producerwalletpass
remcli wallet remove_key $activepublickey2 --password=$producerwalletpass
remcli wallet remove_key $activepublickey3 --password=$producerwalletpass
sudo killall remnode
sudo remnode --config-dir ./config/ --data-dir ./data/ --fix-reversible-blocks --force-all-checks --genesis-json genesis.json
sudo remnode --config-dir ./config/ --data-dir ./data/ >> remnode.log 2>&1 &
rm key1 key2 key3 key4 key5 activekeys1 activekeys2 activekeys3 walletpass requestkeys transferkeys countdown.sh Install-1.sh Install-2.sh Install-3.sh Install-4.sh domain.txt ownerpublickey.txt owneraccountname.txt activeproducername1.txt activeproducername2.txt activeproducername3.txt producerwalletpass.txt
