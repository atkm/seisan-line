#!/bin/bash
# install VMwareTools. 
# Move the packages to pkgs.yml if you want to fetch
# those from ISO.
mount -o loop ~/linux.iso /mnt
cp /mnt/VMwareTools* .
tar xvzf VMwareTools* && rm VMwareTools*.tar.gz
cd vmware-tools-distrib
yum -y install gcc kernel-devel
./vmware-install.pl -d
