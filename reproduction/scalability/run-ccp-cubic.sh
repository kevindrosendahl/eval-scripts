set -eu

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
${DIR}/run-ccp.sh ${1} ${2} ${3} ${4} 'cubic'

