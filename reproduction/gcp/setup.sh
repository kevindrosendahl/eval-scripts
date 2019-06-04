DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

${DIR}/ccp-system-setup.sh
source ~/.cargo/env
${DIR}/../setup.sh

