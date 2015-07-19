if [ ! -d /usr/local/dart-sdk ]; then
  curl -s -O https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip  > /dev/null
  unzip dartsdk-linux-x64-release.zip > /dev/null
  mv dart-sdk /usr/local/
  chown -R vagrant:vagrant /usr/local/dart-sdk
  rm dartsdk-linux-x64-release.zip
fi

echo  >> /home/vagrant/.bashrc
echo "export DART_EDITOR_DIR='/usr/local/'" >> /home/vagrant/.bashrc
echo "export DART_SDK='/usr/local/dart-sdk/'" >> /home/vagrant/.bashrc
echo 'export PATH=$PATH:"$DART_SDK"/bin' >> /home/vagrant/.bashrc