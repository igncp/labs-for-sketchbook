UTILITIES=/_common/install-scripts/_utilities/
RUN(){ sh "$UTILITIES"run.sh "$@"; }
CLONE(){ sh "$UTILITIES"git-clone.sh "$@"; }

RUN common

RUN languages/node/node

CLONE ramda https://github.com/ramda/ramda.git v0.17.1