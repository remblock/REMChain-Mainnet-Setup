#!/usr/bin/env bash

function pause(){
   read -p "$*"
}

domain=$(cat domain.txt)
produceraccountname=$(cat produceraccountname.txt)
activepublickey=$(head -n 2 key1 | tail -1)
requestpublickey=$(head -n 2 key2 | tail -1)
producerpublickey=$(head -n 2 key3 | tail -1)
remcli system regproducer $produceraccountname $producerpublickey $domain
remcli set account permission $produceraccountname vote $requestpublickey active -p $produceraccountname@active
remcli set account permission $produceraccountname claim $requestpublickey active -p $produceraccountname@active
remcli set account permission $produceraccountname stake $requestpublickey active -p $produceraccountname@active
#remcli set account permission $produceraccountname transfer $requestpublickey active -p $produceraccountname@active
remcli set action permission $produceraccountname rem voteproducer vote -p $produceraccountname@active
remcli set action permission $produceraccountname rem claimrewards claim -p $produceraccountname@active
remcli set action permission $produceraccountname rem delegatebw stake -p $produceraccountname@active
#remcli set action permission $produceraccountname rem.token transfer transfer -p $produceraccountname@active
remcli system voteproducer prods $produceraccountname $produceraccountname -p $produceraccountname@vote
walletpassword=$(cat walletpass)
echo $walletpassword > producerwalletpass.txt
producerwalletpass=$(cat producerwalletpass.txt)
remcli wallet remove_key $activepublickey --password=$producerwalletpass
rm key1 key2 key3 activekeys domain.txt produceraccountname.txt producerwalletpass.txt
rm -f ./Install-3.sh
