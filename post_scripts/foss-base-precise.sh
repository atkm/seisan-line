#!/bin/bash
## install emacs, git and ruby
echo "deb http://us.archive.ubuntu.com/ubuntu precise main restricted universe" >> /etc/apt/sources.list
echo "deb-src http://us.archive.ubuntu.com/ubuntu precise main restricted universe" >> /etc/apt/sources.list
apt-get update
apt-get -y install sysstat emacs git-core ruby
