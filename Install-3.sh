#!/usr/bin/env bash

echo "YOUR USERNAME:"
read username
rm -f ./Install-3.sh
sudo su "$username" sh -c "sudo -S wget https://github.com/SooSDExZ/REMChain-Testnet-Guide/raw/master/Install-4.sh && sudo -S chmod u+x Install-4.sh && sudo -S ./Install-4.sh"
