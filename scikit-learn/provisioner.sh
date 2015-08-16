UTILITIES=/_common/install-scripts/_utilities/
RUN(){ sh "$UTILITIES"run.sh "$@"; }
CLONE(){ sh "$UTILITIES"git-clone.sh "$@"; }

RUN common

RUN languages/python/python2
RUN languages/python/python2-packages

CLONE scikit-learn https://github.com/scikit-learn/scikit-learn 0.16.1