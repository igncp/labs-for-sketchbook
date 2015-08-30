UTILITIES=/_common/install-scripts/_utilities/
RUN(){ sh "$UTILITIES"run.sh "$@"; }
CLONE(){ sh "$UTILITIES"git-clone.sh "$@"; }
INSTALL_PYTHON_SETUP(){ sh "$UTILITIES"install-python-setup.sh "$@"; }

REPO_DIR="scikit-learn"

RUN common

RUN languages/python/python2
RUN languages/python/python2-packages

CLONE "$REPO_DIR" https://github.com/scikit-learn/scikit-learn 0.16.1

INSTALL_PYTHON_SETUP "$REPO_DIR" sklearn
