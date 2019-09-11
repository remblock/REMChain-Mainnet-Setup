#!/usr/bin/env bash

domain=$(cat domain.txt)
produceraccountname=$(cat produceraccountname.txt)
producerpublickey=$(head -n 2 key3 | tail -1)
remcli system regproducer $produceraccountname $producerpublickey $domain
