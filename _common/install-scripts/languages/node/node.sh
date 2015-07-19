if ! type "node" > /dev/null; then
  curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
  apt-get install -y nodejs
  npm install -g bower gulp http-server
fi
