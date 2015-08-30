if [ ! -d /usr/lib/python2.7/dist-packages/scipy ]; then
  sudo apt-get install -y python-numpy libatlas-dev libatlas3gf-base
  sudo apt-get install -y python-matplotlib python-scipy

  sudo sed -i 's/TkAgg/Agg/g' /etc/matplotlibrc # As the VM is headless, matplotlib needs another backend
fi
