#
# **Ubuntu 18.04 - Installation Steps**
<br>

__Step 1:__

The [Faucet Bot](https://t.me/RemmeProtocolTestnetFaucetBot) helps you with getting set up and creating an account with some tokens in it. With the help of this bot you will get the following data about your testnet account:

* Account name
* Public and private keys to be able to create transactions.

***

__Step 2:__

```
sudo wget https://github.com/SooSDExZ/REMChain-Testnet-Guide/raw/master/Install-1.sh && sudo wget https://github.com/SooSDExZ/REMChain-Testnet-Guide/raw/master/Install-2.sh && sudo wget https://github.com/SooSDExZ/REMChain-Testnet-Guide/raw/master/Install-3.sh && sudo wget https://github.com/SooSDExZ/REMChain-Testnet-Guide/raw/master/Install-4.sh && sudo wget https://github.com/SooSDExZ/REMChain-Testnet-Scripts/raw/master/countdown.sh && sudo chmod u+x Install-1.sh && sudo chmod u+x Install-2.sh && sudo chmod u+x Install-3.sh && sudo chmod u+x Install-4.sh && sudo chmod u+x countdown.sh && sudo ./Install-1.sh
```

* **Root password changed**
* **Setup a firewall with UFW**
* **New user account created**
* **SSH port number changed**
* **Protected SSH with Fail2Ban**
* **Updated and upgraded the server**
* **Installed canonical livepatch service**
* **Created and adjusted the config.ini file**
* **Initialised the first run of your remnode**
* **Downloaded and installed the genesis file**
* **Downloaded and installed remnode binaries**

![image](https://i.imgur.com/omiCyUr.png)

> The dates shown on each block must be in sync with one another before proceeding onto the next step, it usually takes a couple of hours for the node to be in sync. Once synchronised you can then exit back to the command line by pressing control + c.

***

__Step 3:__

```
sudo ./Install-2.sh
```
```
sudo ./Install-3.sh
```
```
sudo ./Install-4.sh
```

* **Running remnode in the background**
* **Created three active multisignature keys**
* **Created two additional keys producer and request**
* **Setting up multiple key permissions for your account**
* **Created two safemode permissions for regprod and unregprod** 
* **Your request key will be used for claiming, voting and restaking**
* **Your transfer key will be used for making transfers on the REMChain**
* **Your active key has been changed so that its not directly linked with the owner key**
* **If your server is compromised, the hacker only has access to your rewards and not your locked stake**
* **When accessing your server you will need to login using your username and port number. Once in you will need to log into your root directory to use the remcli commands** `su - root`

#
# Optional Steps
<br>

__Step 4:__

**Setup canonical livepatch service**

This service will apply critical kernel security fixes to your ubuntu server automatically without the need of you rebooting the server, therefore reducing the downtime of the server.

```
https://auth.livepatch.canonical.com
```

> Visit the site, register for an account and generate your live patch key. Via the canonical livepatch portal.

```
sudo canonical-livepatch enable YOURLIVEPATCHKEY
```

> Enable the canonical livepatch on your ubuntu server.

```
canonical-livepatch status —verbose
```

> This will allow you to check your live patch status, fixes, uptime, boot time and last check time. 

***

__Step 5:__

**Creating and installing SSH keys**

```
ssh-keygen -t rsa -b 4096
```

> Generate your new SSH keys on your OS terminal (MacOS or Ubuntu App).

**Enter file in which to save the key** `enter`

> Hit enter to have the SSH keys saved at the default location.

**Enter passphrase (empty for no passphrase):** `SETYOURPASSPHRASE`

> Having a passphrase provides an extra level of protection if you happen to lose your device, however if you don't wish to set a passphrase just hit enter.

```
ssh-copy-id YOURUSERNAME@YOURIPADDRESS -p YOURPORTNUMBER
```

> Your SSH keys will now be copied over to your ubuntu server.

```
sudo sed -i ‘s/PasswordAuthentication yes/PasswordAuthentication no/’ /etc/ssh/sshd_config
```

```
sudo service sshd restart
```

> Copy and paste the above two lines of code into your ubuntu server terminal.

#
# Important REMCLI Command Lines
<br>

```
remcli wallet unlock
```

> This command line will unlock your wallet.

```
remcli system claimrewards YOURACCOUNTNAME -p YOURACCOUNTNAME@claim
```

> This command line will be used for claiming your rewards, make sure that your wallet is unlocked before making a claim.

```
remcli system voteproducer prods YOURACCOUNTNAME BP_ACCOUNT_NAME1 BP_ACCOUNCT_NAME2 -p YOURACCOUNTNAME@vote
```

> This command line is used for voting for multiple block producers.

```
remcli system voteproducer approve BPACCOUNTNAME -p YOURACCOUNTNAME@vote
```

> This command line is used for adding a new block producer to your list of voted producers.

```
remcli system voteproducer unapprove BPACCOUNTNAME -p YOURACCOUNTNAME@vote
```

> This command line is used for removing a block producer from your list of voted producers.

```
remcli system delegatebw YOURACCOUNTNAME YOURACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@stake
```

> This command line is used for staking your block rewards to yourself, make sure that your wallet is unlocked before restaking your rewards.

```
remcli system delegatebw YOURACCOUNTNAME BPACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@stake
```

> This command line is used for staking your block rewards to another block producer, make sure that your wallet is unlocked before restaking your rewards to another block producer.

```
remcli system undelegatebw YOURACCOUNTNAME BPACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@stake
```

> This command line is used for taking back your stake from a block producer, make sure that your wallet is unlocked before taking back your stake.

```
remcli transfer YOURACCOUNTNAME RECEIVERSACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@transfer
```

> This command line is used for making transfers, make sure that your wallet is unlocked before making any transfers.

#
# Additional REMCLI Command Lines
<br>

```
remcli get info
```

> This command line is used for getting the current state of the blockchain.

```
remcli version client
```

> This command line is used for obtaining the current client version.

```
tail -n 1 remnode.log
```

> This command line will output the last produced block.

```
remcli wallet lock
```

> This command line is used for locking the default wallet.

```
remcli wallet lock_all
```

> This command line is used for locking all wallets.

```
remcli wallet lock -n YOURWALLETNAME
```

> This command line is used for locking a specific wallet.

```
remcli wallet list
```

> This command line is used for listsing opened wallets, * = unlocked.

```
remcli wallet keys
```

> This command line is used for listing your public keys from all your unlocked wallets.

```
remcli wallet remove_key YOURPUBLICKEY
```

> This command line is used for removing a key from your wallet. Each time you remove a key from your wallet, you will be promted for your wallet password.

```
remcli get account BPACCOUNTNAME
```

> This command line is used for retrieving information on an account.

```
remcli system listproducers
```

> This command line is used to return a list of producers.

```
remcli system unregprod YOURACCOUNTNAME
```

> This command line is used to unregister you as a block producer.
