# Not working yet

if ! type "node" > /dev/null; then
  sudo HOME=/home/vagrant -u vagrant sh -c "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash"
  sudo NVM_DIR="/home/vagrant/.nvm" HOME=/home/vagrant -u vagrant bash -c  '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh";  nvm install iojs'
fi
