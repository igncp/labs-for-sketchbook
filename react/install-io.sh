# This should be temporal, till the provision file works

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash
. ~/.bashrc; nvm install iojs
# nvm use iojs-v3.3.0 # Fix to use current version
