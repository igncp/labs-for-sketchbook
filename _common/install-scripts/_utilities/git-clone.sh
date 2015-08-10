if [ ! -d /project/repositories/"$1" ]; then
  mkdir -p /project/repositories
  cd /project/repositories
  git clone $2 $1
  if [ ! -z "$3" ]; then
    cd "$1"
    git checkout -b "$3"
  fi
  cd
else
  echo "$1 ($2) was not cloned because it already existed"
fi