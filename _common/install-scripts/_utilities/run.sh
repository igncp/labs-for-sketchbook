# This script accepts an argument like `languages/node`

ROOT=$(dirname "$0")/..

echo "$1 started."
cd ~
sh "$ROOT"/"$1".sh > /dev/null
echo "$1 completed."