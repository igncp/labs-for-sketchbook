if ! type "python" > /dev/null; then
  sudo apt-get install -y python-numpy python-scipy libatlas-dev libatlas3gf-base
  sudo apt-get install -y python-matplotlib
fi
