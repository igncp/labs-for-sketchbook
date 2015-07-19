UTILITIES=/_common/install-scripts/_utilities/
RUN(){ sh "$UTILITIES"run.sh "$@"; }
CLONE(){ sh "$UTILITIES"git-clone.sh "$@"; }

RUN common

RUN languages/node/node
RUN languages/node/typescript
RUN languages/dart

CLONE angular https://github.com/angular/angular.git

if [ ! -d /project/repositories/angular/node_modules ]; then
  git checkout 2.0.0-alpha.31
  source /home/vagrant/.bashrc
  cd /project/repositories/angular
  npm install
fi