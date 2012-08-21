#!/bin/bash
# Install git from source. An alternative
# way to install git is from EPEL.

wget http://download.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
rpm -Uvh ./epel-release-5-4.noarch.rpm
yum -y --nogpgcheck install git

# yum -y install gcc zlib-devel openssl-devel cpio expat-devel gettext-devel
# cd /usr/local/src
# echo "cd /usr/local/src"
# if [ -a git-1.7.9.tar.gz ]
#     then
#     echo "git source tarball already exists"
#     else
#     wget http://git-core.googlecode.com/files/git-1.7.9.tar.gz
# fi
# tar xvzf git-1.7.9.tar.gz
# cd git-1.7.9
# ./configure
# make
# make install
# 
