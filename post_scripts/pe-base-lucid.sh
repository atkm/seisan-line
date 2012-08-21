#!/bin/bash
## Add repos to install emacs and git
echo "deb http://us.archive.ubuntu.com/ubuntu lucid main restricted universe" >> /etc/apt/sources.list
echo "deb-src http://us.archive.ubuntu.com/ubuntu lucid main restricted universe" >> /etc/apt/sources.list
apt-get update
apt-get -y install sysstat emacs git-core

