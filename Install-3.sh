#!/usr/bin/env bash

domain=$(cat domain.txt)
ownerpublickey=$(cat ownerpublickey.txt)
owneraccountname=$(cat owneraccountname.txt)
activeproducername1=$(cat activeproducername1.txt)
activeproducername2=$(cat activeproducername2.txt)
activeproducername3=$(cat activeproducername3.txt)
requestpublickey=$(head -n 2 key2 | tail -1)
transferpublickey=$(head -n 2 key3 | tail -1)
remcli system regproducer $owneraccountname $requestpublickey $domain
remcli set account permission $owneraccountname active '''{"threshold":2,"keys":[],"accounts":[{"permission":{"actor":"$activeproducername1","permission":"active"},"weight":1},{"permission":{"actor":"$activeproducername2","permission":"active"},"weight":1},{"permission":{"actor":"$activeproducername3","permission":"active"},"weight":1}],"waits":[]}''' owner -p $owneraccountname@owner
remcli set account permission $owneraccountname safemode $ownerpublickey owner -p $owneraccountname@owner
remcli set account permission $owneraccountname vote $requestpublickey active -p $owneraccountname@active
remcli set account permission $owneraccountname claim $requestpublickey active -p $owneraccountname@active
remcli set account permission $owneraccountname stake $requestpublickey active -p $owneraccountname@active
remcli set account permission $owneraccountname transfer $transferpublickey active -p $owneraccountname@active
rm -f ./Install-3.sh
