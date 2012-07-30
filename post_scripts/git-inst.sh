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

echo "git-inst.sh:"
echo "This script is meant for installing git from source."
echo "However things are commented out b/c I don't need git for the time being."
echo "See git-inst.sh for instructions."
