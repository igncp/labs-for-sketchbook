# This an initial file. Not intended to be linked.
# cp ../_common/files/provisioner.sh

UTILITIES=/_common/install-scripts/_utilities/
RUN(){ sh "$UTILITIES"run.sh "$@"; }
CLONE(){ sh "$UTILITIES"git-clone.sh "$@"; }

RUN common

RUN languages/node/node
# RUN languages/node/io

CLONE react https://github.com/facebook/react.git v0.13.3