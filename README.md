#
# **REMChain-Mainnet-Setup | (Ubuntu 18.04)**


***
### SSH Keys Setup

```
sudo wget https://github.com/remblock/REMChain-Mainnet-Setup/raw/master/sshkeysetup && sudo chmod u+x sshkeysetup && sudo ./sshkeysetup
```

***
### Guardian Setup

```
sudo wget https://github.com/remblock/REMChain-Mainnet-Setup/raw/master/guardiansetup && sudo chmod u+x guardiansetup && sudo ./guardiansetup
```

***
### Block Producer Setup

<br>

```
sudo wget https://github.com/remblock/REMChain-Mainnet-Setup/raw/master/producersetup && sudo chmod u+x producersetup && sudo ./producersetup
```

***
### Remblock Producer Setup

<br>

```
sudo wget https://github.com/remblock/REMChain-Mainnet-Setup/raw/master/remblock1-setup && sudo chmod u+x remblock1-setup && sudo ./remblock1-setup
```

***
### Remblock Backup Producer Setup

<br>

```
sudo wget https://github.com/remblock/REMChain-Mainnet-Setup/raw/master/remblock2-setup && sudo chmod u+x remblock2-setup && sudo ./remblock2-setup
```
<br>

* **Setup a firewall with UFW**
* **SSH port number is changed**
* **Protected SSH with Fail2Ban**
* **Updated and upgraded the server**
* **Installed canonical livepatch service**
* **Download and installed the genesis file**
* **Created and adjusted your config.ini file**
* **Download and installed remnode binaries**
* **Initialised the first execution of remnode**
* **Create four active multisignature accounts**
* **Create two permission keys producer and transfer**
* **Setting up multiple key permissions for these two keys**
* **Created two safemode permissions for regprod and unregprod** 
* **Your producer key will be used for claiming, voting and restaking**
* **Your transfer key will be used for making transfers on the REMChain**
* **Four active keys will be created so that its not directly linked to the owner key**
* **When accessing your server you will need to login using your SSH Key which was copied over by the SSH script.** 

***
# Additional Setup Information
<br>

**(SETUP CANONICAL LIVEPATCH SERVICE)**

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
remcli system claimrewards YOURACCOUNTNAME -p YOURACCOUNTNAME@producer
```

> **This command line will be used for claiming your rewards, make sure that your wallet is unlocked before making a claim.**

```
remcli system voteproducer prods YOURACCOUNTNAME YOURACCOUNTNAME -p YOURACCOUNTNAME@producer
```

> **This command line is used for voting for voting for yourself.**

```
remcli system voteproducer prods YOURACCOUNTNAME BP_ACCOUNT_NAME1 BP_ACCOUNCT_NAME2 -p YOURACCOUNTNAME@producer
```

> **This command line is used for voting for multiple block producers.**

```
remcli system voteproducer approve BPACCOUNTNAME -p YOURACCOUNTNAME@producer
```

> **This command line is used for adding a new block producer to your list of voted producers.**

```
remcli system voteproducer unapprove BPACCOUNTNAME -p YOURACCOUNTNAME@producer
```

> **This command line is used for removing a block producer from your list of voted producers.**

```
remcli system delegatebw YOURACCOUNTNAME YOURACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@producer
```

> **This command line is used for staking your block rewards to yourself, make sure that your wallet is unlocked before restaking your rewards.**

```
remcli system delegatebw YOURACCOUNTNAME BPACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@producer
```

> **This command line is used for staking your block rewards to another block producer, make sure that your wallet is unlocked before restaking your rewards to another block producer.**

```
remcli system undelegatebw YOURACCOUNTNAME BPACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@owner
```

> **This command line is used for taking back your stake from a block producer, make sure that your wallet is unlocked before taking back your stake.**

```
remcli transfer YOURACCOUNTNAME RECEIVERSACCOUNTNAME "AMOUNT REM" -p YOURACCOUNTNAME@transfer
```

> **This command line is used for making transfers, make sure that your wallet is unlocked before making any transfers.**

***
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
remcli system unregprod YOURACCOUNTNAME -p YOURACCOUNTNAME@owner
```

> **This command line is used to unregister you as a block producer.**
