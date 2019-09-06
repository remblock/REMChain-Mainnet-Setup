# Guide to creating a producer node on the REMChain testnet
**Installation Steps**

**Step 1:**

`sudo wget https://github.com/SooSDExZ/Installation-Scripts/raw/master/Install-1.sh && sudo chmod u+x Install-1.sh && sudo ./Install-1.sh`

* Update and upgrade system
* Set new root password
* Disable root access
* Change port number
* New user account

`sudo wget https://github.com/SooSDExZ/Installation-Scripts/raw/master/Install-2.sh && sudo wget https://github.com/SooSDExZ/Installation-Scripts/raw/master/Install-3.sh && sudo chmod u+x Install-2.sh && sudo chmod u+x Install-3.sh && sudo ./Install-2.sh`

* Download and install remnode binaries
* Download and install the genesis file
* Create and adjust the config.ini file
* First run of the remnode

`sudo ./Install-3.sh`

* Run remnode in the background
* Create a new remnode wallet account
* Create 3 new keys, active, request and producer keys
* Import your owner, active, request and producer keys
* Provide your active, request and producer public keys
* Provide your account name, producer private key and domain
* Setup key management for better security, request and producer keys
* Request key will be used for claiming, voting, transfer and restaking
* Producer key will be used for signing blocks as a block producer on the network
