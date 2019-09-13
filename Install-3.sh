#!/usr/bin/env bash

domain=$(cat domain.txt)
ownerpublickey=$(cat ownerpublickey.txt)
requestpublickey=$(head -n 2 key2 | tail -1)
transferpublickey=$(head -n 2 key3 | tail -1)
produceraccountname=$(cat produceraccountname.txt)
remcli system regproducer $produceraccountname $requestpublickey $domain
remcli set account permission $produceraccountname safemode $ownerpublickey owner -p $produceraccountname@owner
remcli set account permission $produceraccountname vote $requestpublickey active -p $produceraccountname@active
remcli set account permission $produceraccountname claim $requestpublickey active -p $produceraccountname@active
remcli set account permission $produceraccountname stake $requestpublickey active -p $produceraccountname@active
remcli set account permission $produceraccountname transfer $transferpublickey active -p $produceraccountname@active
rm -f ./Install-3.sh
