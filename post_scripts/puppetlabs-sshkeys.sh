echo "hey there."
cd
if [ ! -d ".ssh" ]; then
  mkdir .ssh
fi
touch .ssh/authorized_keys
git clone git://github.com/puppetlabs/puppetlabs-sshkeys.git
cat puppetlabs-sshkeys/templates/ssh/authorized_keys >> .ssh/authorized_keys
