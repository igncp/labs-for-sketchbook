if ! type "unzip" > /dev/null; then
  apt-get update
  
  apt-get install -y git unzip tmux chromium-browser xvfb
fi

rm /home/vagrant/.bashrc
cp /_common/install-scripts/dot-files/.bashrc /home/vagrant/.bashrc

if ! type "entr" > /dev/null; then
  cd ~
  git clone https://github.com/clibs/entr.git
  cd entr
  ./configure
  sudo make install
  cd ..
  sudo rm -r entr
fi
