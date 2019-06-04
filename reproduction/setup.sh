DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}/..

echo "Pulling submodules"
git submodule update --init --recursive

echo "Making ccp"
make

echo "Enabling ccp"
./scripts/setup.sh ipc=0
