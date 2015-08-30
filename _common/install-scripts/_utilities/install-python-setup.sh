if [ ! -d /usr/local/lib/python2.7/dist-packages/"$2" ]; then
  cd /project/repositories/"$1"
  sudo python setup.py install > /dev/null
  cd
  echo "$1 was installed using setup.py as $2"
else
  echo "$1 was not installed using setup.py because $2 already exists"
fi