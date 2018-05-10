
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
docker build $DIR/.. -t my-image:test
export GOSS_FILES_PATH=test
export GOSS_OPTS="--max-concurrent=1"

case $1 in
  junit)
    mkdir -p ./reports/goss
    export GOSS_OPTS="$GOSS_OPTS --format junit"
    dgoss run --entrypoint=/test/gossEntrypoint.sh my-image:test > ./goss/report.xml
    ;;
  *)
    dgoss run --entrypoint=/test/gossEntrypoint.sh my-image:test
    ;;
esac
