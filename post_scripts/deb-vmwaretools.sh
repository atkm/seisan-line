#!/bin/bash
# install VMwareTools. Should be executed after [pe|foss]-base-[lucid|precise].sh
# move the packages to pkgs.yml if you want to fetch packages from the ISO
mount -o loop ~/linux.iso /mnt
cp /mnt/VMwareTools* .
tar xvzf VMwareTools* && rm VMwareTools*.tar.gz
cd vmware-tools-distrib
apt-get update
apt-get -y install psmisc gcc make linux-headers-`uname -r`
./vmware-install.pl -d
