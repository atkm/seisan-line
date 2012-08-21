#!/bin/bash
## Install vmware tools
zypper --non-interactive install kernel-source binutils make gcc gcc-c++
cd
mount -o loop linux.iso /mnt
cp /mnt/VMwareTools* .
tar xvzf VMwareTools* && rm VMwareTools*.tar.gz
cd vmware-tools-distrib
./vmware-install.pl -d
