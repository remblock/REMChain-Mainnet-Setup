#!/usr/bin/env bash

#**********************************************#
#                INSTALL-2.SH                  #
#**********************************************#

domain=$(cat domain.txt)
ownerpublickey=$(cat ownerpublickey.txt)
owneraccountname=$(cat owneraccountname.txt)
requestpublickey=$(head -n 2 key4 | tail -1)
transferpublickey=$(head -n 2 key5 | tail -1)

#----------------------------------------------
# REGISTERING AS NEW BLOCK PRODUCER 
#----------------------------------------------

remcli system regproducer $owneraccountname $requestpublickey $domain

#----------------------------------------------
# CREATING YOUR REMCHAIN ACCOUNT PERMISSIONS 
#----------------------------------------------

remcli set account permission $owneraccountname safemode $ownerpublickey owner -p $owneraccountname@owner
remcli set account permission $owneraccountname vote $requestpublickey active -p $owneraccountname@active
remcli set account permission $owneraccountname claim $requestpublickey active -p $owneraccountname@active
remcli set account permission $owneraccountname stake $requestpublickey active -p $owneraccountname@active
remcli set account permission $owneraccountname transfer $transferpublickey active -p $owneraccountname@active
