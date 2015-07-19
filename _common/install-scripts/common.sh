if ! type "tmux" > /dev/null; then
  apt-get update
  
  apt-get install -y git unzip tmux
fi

rm /home/vagrant/.bashrc
cp /_common/install-scripts/dot-files/.bashrc /home/vagrant/.bashrc
