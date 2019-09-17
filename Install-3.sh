#!/usr/bin/env bash

domain=$(cat domain.txt)
ownerpublickey=$(cat ownerpublickey.txt)
owneraccountname=$(cat owneraccountname.txt)
requestpublickey=$(head -n 2 key2 | tail -1)
transferpublickey=$(head -n 2 key5 | tail -1)
remcli system regproducer $owneraccountname $requestpublickey $domain
remcli set account permission $owneraccountname safemode $ownerpublickey owner -p $owneraccountname@owner
remcli set account permission $owneraccountname vote $requestpublickey active -p $owneraccountname@active
remcli set account permission $owneraccountname claim $requestpublickey active -p $owneraccountname@active
remcli set account permission $owneraccountname stake $requestpublickey active -p $owneraccountname@active
remcli set account permission $owneraccountname transfer $transferpublickey active -p $owneraccountname@active
