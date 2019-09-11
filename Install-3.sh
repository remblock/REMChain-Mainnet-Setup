#!/usr/bin/env bash

domain=$(cat domain.txt)
producerpublickey=$(head -n 2 key3 | tail -1)
produceraccountname=$(cat produceraccountname.txt)
remcli system regproducer $produceraccountname $producerpublickey $domain
rm -f ./Install-3.sh
