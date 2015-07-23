UTILITIES=/_common/install-scripts/_utilities/
RUN(){ sh "$UTILITIES"run.sh "$@"; }
CLONE(){ sh "$UTILITIES"git-clone.sh "$@"; }

RUN common

RUN languages/node/node

CLONE rxjs https://github.com/Reactive-Extensions/RxJS.git

if [ ! -d /project/repositories/rxjs/node_modules ]; then
  cd /project/repositories/rxjs
  source /home/vagrant/.bashrc
  npm install
fi