#!/usr/bin/env bash

domain=$(cat domain.txt)
produceraccountname=$(cat produceraccountname.txt)
requestpublickey=$(head -n 2 key2 | tail -1)
producerpublickey=$(head -n 2 key3 | tail -1)
remcli system regproducer $produceraccountname $producerpublickey $domain
remcli set account permission $produceraccountname produce $producerpublickey active -p $produceraccountname@active
remcli set account permission $produceraccountname vote $requestpublickey active -p $produceraccountname@active
remcli set account permission $produceraccountname claim $requestpublickey active -p $produceraccountname@active
remcli set account permission $produceraccountname stake $requestpublickey active -p $produceraccountname@active
remcli set account permission $produceraccountname transfer $requestpublickey active -p $produceraccountname@active
rm -f ./Install-3.sh
