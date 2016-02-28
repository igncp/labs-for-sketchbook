# This an initial file. Not intended to be linked.
# cp ../_common/files/provisioner.sh

UTILITIES=/_common/install-scripts/_utilities/
RUN(){ sh "$UTILITIES"run.sh "$@"; }
CLONE(){ sh "$UTILITIES"git-clone.sh "$@"; }

RUN common

RUN languages/go

CLONE prometheus https://github.com/prometheus/prometheus.git 0.17.0rc2