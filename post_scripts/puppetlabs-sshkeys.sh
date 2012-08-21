echo "Getting authorized keys for puppetlabs people."
cd
if [ ! -d ".ssh" ]; then
  mkdir .ssh
fi
touch .ssh/authorized_keys
git clone git://github.com/puppetlabs/puppetlabs-sshkeys.git
cat puppetlabs-sshkeys/templates/ssh/authorized_keys >> .ssh/authorized_keys
echo "The pubkeys are stored in ~/.ssh/authorized_keys"
