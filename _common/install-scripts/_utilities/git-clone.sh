if [ ! -d /project/repositories/"$1" ]; then
  mkdir -p /project/repositories
  cd /project/repositories
  git clone $2 $1
  cd
else
  echo "$1 ($2) was not cloned because it already existed"
fi