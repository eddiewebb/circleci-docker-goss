#!/usr/bin/env sh
# entrypoint.sh expects 2 key files mounted by orchestrator and since they are no mounted causes container to fail.
# Since our goss tests exercise the entrypoint interactively, we must override with this file
#

cat >/config.txt <<EOL
l1.medium default true 0
l1.medium default false 0
EOL


sleep 600 # should be long enough to run tests or add new ones
