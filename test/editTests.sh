
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build $DIR/.. -t my-image:test
export GOSS_FILES_PATH=test
export GOSS_OPTS="--max-concurrent=1"


dgoss edit --entrypoint=/test/gossEntrypoint.sh my-image:test
