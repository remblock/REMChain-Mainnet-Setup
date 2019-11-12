#
# **REMChain-Testnet-V2 - Ubuntu 18.04 Installation Steps**
<br>

**The REMME [Faucet Bot](https://t.me/RemmeProtocolTestnetFaucetBot) helps you with getting set up and creating an account with some tokens in it. With the help of this bot you will get the following data about your testnet account:**

* **Account name**
* **Public and private keys to be able to create transactions.**

***
# Block Producer Setup

<br>

```
sudo wget https://github.com/SooSDExZ/REMChain-Testnet-V2/raw/master/producer && sudo chmod u+x producer
```

<br>

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
# Additional Setup Information
<br>

**Setup canonical livepatch service**

**This service will apply critical kernel security fixes to your ubuntu server automatically without the need of you rebooting the server, therefore reducing the downtime of the server.**

```
https://auth.livepatch.canonical.com
```

> **Visit the site, register for an account and generate your live patch key. Via the canonical livepatch portal.**

```
sudo canonical-livepatch enable YOURLIVEPATCHKEY
```

> **Enable the canonical livepatch on your ubuntu server.**

```
canonical-livepatch status —verbose
```

> **This will allow you to check your live patch status, fixes, uptime, boot time and last check time.** 

***

# Important REMCLI Command Lines
<br>

```
remcli wallet unlock
```

> **This command line will unlock your wallet.**

```
remcli system claimrewards YOURACCOUNTNAME -p YOURACCOUNTNAME@claim
```

> **This command line will be used for claiming your rewards, make sure that your wallet is unlocked before making a claim.**

```
remcli system voteproducer prods YOURACCOUNTNAME YOURACCOUNTNAME -p YOURACCOUNTNAME@vote
```

> **This command line is used for voting for voting for yourself.**

```
remcli system voteproducer prods YOURACCOUNTNAME BP_ACCOUNT_NAME1 BP_ACCOUNCT_NAME2 -p YOURACCOUNTNAME@vote
```

> **This command line is used for voting for multiple block producers.**

```
remcli system voteproducer approve BPACCOUNTNAME -p YOURACCOUNTNAME@vote
```

> **This command line is used for adding a new block producer to your list of voted producers.**

```
remcli system voteproducer unapprove BPACCOUNTNAME -p YOURACCOUNTNAME@vote
```

> **This command line is used for removing a block producer from your list of voted producers.**

```
remcli system delegatebw YOURACCOUNTNAME YOURACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@stake
```

> **This command line is used for staking your block rewards to yourself, make sure that your wallet is unlocked before restaking your rewards.**

```
remcli system delegatebw YOURACCOUNTNAME BPACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@stake
```

> **This command line is used for staking your block rewards to another block producer, make sure that your wallet is unlocked before restaking your rewards to another block producer.**

```
remcli system undelegatebw YOURACCOUNTNAME BPACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@stake
```

> **This command line is used for taking back your stake from a block producer, make sure that your wallet is unlocked before taking back your stake.**

```
remcli transfer YOURACCOUNTNAME RECEIVERSACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@transfer
```

> **This command line is used for making transfers, make sure that your wallet is unlocked before making any transfers.**

#
# Additional REMCLI Command Lines
<br>

```
remcli get info
```

> **This command line is used for getting the current state of the blockchain.**

```
remcli version client
```

> **This command line is used for retrieving the current client version.**

```
tail -n 1 remnode.log
```

> **This command line will output the last produced block.**

```
remcli wallet lock
```

> **This command line is used for locking your default wallet.**

```
remcli wallet lock_all
```

> **This command line is used for locking all wallets.**

```
remcli wallet lock -n YOURWALLETNAME
```

> **This command line is used for locking a specific wallet.**

```
remcli wallet list
```

> **This command line is used for listsing opened wallets, * = unlocked.**

```
remcli wallet keys
```

> **This command line is used for listing your public keys from all your unlocked wallets.**

```
remcli wallet remove_key YOURPUBLICKEY
```

> **This command line is used for removing a key from your wallet.**

```
remcli get account BPACCOUNTNAME
```

> **This command line is used for retrieving information on an account.**

```
remcli system listproducers
```

> **This command line will return a list of all block producers.**

```
remcli system unregprod YOURACCOUNTNAME
```

> **This command line is used to unregister you as a block producer.**
