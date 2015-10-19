# This an initial file. Not intended to be linked.
# cp ../_common/files/provisioner.sh

UTILITIES=/_common/install-scripts/_utilities/
RUN(){ sh "$UTILITIES"run.sh "$@"; }
CLONE(){ sh "$UTILITIES"git-clone.sh "$@"; }

RUN common

RUN languages/node/node

CLONE jscodeshift https://github.com/facebook/jscodeshift.git v0.3.7