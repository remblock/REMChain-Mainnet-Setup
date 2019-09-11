#
# **Ubuntu 18.04 - Installation Steps**
<br>

__Step 1:__

The [Faucet Bot](https://t.me/RemmeProtocolTestnetFaucetBot) helps you with getting set up and creating an account with some tokens in it. With the help of this bot you will get the following data about your testnet account:

* Account name
* Public and private keys to be able to create transactions.

#

__Step 2:__

```
sudo wget https://github.com/SooSDExZ/REMChain-Testnet-Guide/raw/master/Install-1.sh && sudo chmod u+x Install-1.sh && sudo ./Install-1.sh
```

* **Change root password**
* **Change SSH port number**
* **Setup a new user account**
* **Setup a firewall with UFW**
* **Protect SSH with Fail2Ban**
* **Update and upgrade the server**
* **Install canonical livepatch service**
* **Create and adjust the config.ini file**
* **Download and install the genesis file**
* **Download and install remnode binaries**
* **Initialised the first run of your remnode**

![image](https://i.imgur.com/omiCyUr.png)

> Wait for the two dates shown on each block to be in sync with one another before proceeding onto the next step. It usually takes a few hours for your node to be in sync with the REMME blockchain. Once it has synchronised you can then exit back to the command line by pressing control + c.

#

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
* **Creating two additional keys producer and request**
* **Setting up multiple key permissions for your account**
* **Changing your active key so that its not directly linked to your owner key**
* **Your request key will be used for claiming, voting, transfering and restaking**
* **Your producer key will be used for signing blocks as a block producer on the network**
* **If your server is compromised, the hacker only gets access to your rewards and not your locked stake**
* **When accessing your server you will need to login using your username and portnumber. Once in you will need to log into your root directory** `su - root`

#
# Optional Steps
<br>

__Step 4:__

**Setup canonical livepatch service**

This service will apply critical kernel security fixes to your ubuntu server automatically without the need of you rebooting the server. Therefore this livepatch will reduce your server downtime while it maintains compliance and security.

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

#

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

> Your SSH keys will now be copied over to your remnode.

```
sudo sed -i ‘s/PasswordAuthentication yes/PasswordAuthentication no/’ /etc/ssh/sshd_config
```

```
sudo service sshd restart
```

> Copy and paste the above two lines of code into your remnode terminal.

#
# Important REMCLI Command Lines
<br>

```
remcli wallet unlock < walletpass
```

> This command line will unlock your wallet.

```
remcli system claimrewards YOURACCOUNTNAME -p YOURACCOUNTNAME@claim
```

> This command line is used for claiming your rewards, make sure that your wallet is unlocked before claiming your rewards.

```
remcli system voteproducer prods YOURACCOUNTNAME BP_ACCOUNT_NAME1 BP_ACCOUNCT_NAME2 -p YOURACCOUNTNAME@vote
```

> This command line is used for voting for more block producers.

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

> This command line is used for making transfers, make sure that your wallet is unlocked before transferring your rewards.

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
remcli wallet lock -n YOUR_WALLET_NAME
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
echo $(cat walletpass)
```

```
remcli wallet remove_key YOURKEY
```

> This command line is used for removing a key from your wallet. Each time you remove a key from your wallet, remnode will ask you for your default wallet password.

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

> This command line is used to unregister as a block producer.
