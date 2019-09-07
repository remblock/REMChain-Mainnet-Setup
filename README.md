#
# **Installation Steps**

__Step 1:__

The [Faucet Bot](https://t.me/RemmeProtocolTestnetFaucetBot) helps you with getting set up and creating an account with some tokens in it.<br>With the help of this bot you will get the following data about your testnet account:

* Account name
* Public and private keys to be able to create transactions.

#

__Step 2:__

```sudo wget https://github.com/SooSDExZ/Installation-Scripts/raw/master/Install-1.sh && sudo chmod u+x Install-1.sh && sudo ./Install-1.sh```

* **Update and upgrade**
* **Change root password**
* **Setup new user account**
* **Disable SSH root access**
* **Change SSH port number**
* **Setup a firewall with UFW**
* **Protect SSH with Fail2Ban**

#

__Step 3:__

```sudo wget https://github.com/SooSDExZ/Installation-Scripts/raw/master/Install-2.sh && sudo wget https://github.com/SooSDExZ/Installation-Scripts/raw/master/Install-3.sh && sudo chmod u+x Install-2.sh && sudo chmod u+x Install-3.sh && sudo ./Install-2.sh```

* **Download and install remnode binaries**
* **Download and install the genesis file**
* **Create and adjust the config.ini file**
* **Install canonical livepatch service**
* **First run of the remnode**

> Wait for the two dates shown on each block to be in sync with one another before proceeding onto the next step. It can usually take a few hours for your node to be in sync with the REMME blockchain. Once it has synchronised you can then exit back to the command line by pressing control + c. Now if your using a VPS take a snapshot of your remnode, so that in the future it can be restored from this point without the need of redoing the second and third steps again.

#

__Step 4:__

```sudo ./Install-3.sh```

* **Run remnode in the background**
* **Create a new remnode wallet file**
* **Create 3 new keys, active, request and producer keys**
* **Import your owner, active, request and producer keys**
* **Input your new active, request and producer public keys**
* **Input your account name, producer private key and domain**
* **Setup key permissions for better security, request and producer keys**
* **Request key will be used for claiming, voting, transfering and restaking**
* **Producer key will be used for signing blocks as a block producer on the network**

#
# Additional Steps

__Step 1:__

**Setup canonical livepatch service**

This service will apply critical kernel security fixes to your ubuntu server automatically without the need of you rebooting the server. Therefore this livepatch will reduce your server downtime while it maintains compliance and security.

`https://auth.livepatch.canonical.com`

> Visit the site, register for an account and generate your live patch key. Via the canonical livepatch portal.

`sudo canonical-livepatch enable YOURLIVEPATCHKEY`

> Enable the canonical livepatch on your ubuntu server.

`canonical-livepatch status —verbose`

> This will allow you to check your live patch status, fixes, uptime, boot time and last check time. 

#

__Step 2:__

**Creating and installing SSH keys**

`ssh-keygen -t rsa -b 4096`

> Generate your new SSH keys in your OS terminal (Ubuntu App or MacOS).

**Enter file in which to save the key** `enter`

> Hit enter to have the SSH keys saved at the default location.

**Enter passphrase (empty for no passphrase):** `SETYOURPASSPHRASE`

> Having a passphrase provides an extra level of protection if you happen to lose your device, however if you don't wish to set a passphrase just hit enter.

`ssh-copy-id YOURUSERNAME@YOURIPADDRESS -p YOURPORTNUMBER`

> Your SSH keys will now be copied over to your remnode.

`sudo sed -i ‘s/PasswordAuthentication yes/PasswordAuthentication no/’ /etc/ssh/sshd_config`

`sudo service sshd restart`

> Copy and paste the above codes into your remnode terminal.

#
# Important REMCLI Command Lines

`remcli wallet unlock < walletpass`

> This command line will unlock your wallet.

`remcli system claimrewards YOUR_ACCOUNT_NAME -p YOUR_ACCOUNT_NAME@claim`

> This command line is used for claiming your rewards, make sure that your wallet is unlocked before claiming your rewards.

`remcli system voteproducer prods YOUR_ACCOUNT_NAME BP_ACCOUNT_NAME1 BP_ACCOUNCT_NAME2 -p YOUR_ACCOUNT_NAME@vote`

> This command line is used for voting for more block producers.

`remcli system voteproducer approve BP_ACCOUNT_NAME -p YOUR_ACCOUNT_NAME@vote`

> This command line is used for adding a new block producer to your list of voted producers.

`remcli system voteproducer unapprove BP_ACCOUNT_NAME -p YOUR_ACCOUNT_NAME@vote`

> This command line is used for removing a block producer from your list of voted producers.

`remcli system delegatebw YOUR_ACCOUNT_NAME YOUR_ACCOUNT_NAME "AMOUNT REM" -p YOUR_ACCOUNT_NAME@stake`

> This command line is used for staking your block rewards to yourself, make sure that your wallet is unlocked before restaking your rewards.

`remcli system delegatebw YOUR_ACCOUNT_NAME BP_ACCOUNT_NAME "AMOUNT REM" -p YOUR_ACCOUNT_NAME@stake`

> This command line is used for staking your block rewards to another block producer, make sure that your wallet is unlocked before restaking your rewards to another block producer.

`remcli system undelegatebw YOUR_ACCOUNT_NAME BP_ACCOUNT_NAME "AMOUNT REM" -p YOUR_ACCOUNT_NAME@stake`

> This command line is used for taking back your stake from a block producer, make sure that your wallet is unlocked before taking back your stake.

`remcli transfer YOUR_ACCOUNT_NAME RECEIVERS_ACCOUNT_NAME "AMOUNT REM" -p YOUR_ACCOUNT_NAME@transfer`

> This command line is used for making transfers, make sure that your wallet is unlocked before transferring your rewards.
