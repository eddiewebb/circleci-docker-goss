#!/usr/bin/env bash

# NOTE: this is not intented to test the logic of schdule.txt, only the interaction with other aspects of wholistic system.


CURRENT_HOUR=$(date +"%H") # 0-23
CURRENT_DAY=$(date +"%u") # 1-7

cat >/schedule.txt <<EOL
# Minimum Preallocation scheduling
# Day: Numeric ID of day, week starts on Monday (1-7), w= weekdays (1-5)
#Day #hour #desired #type(docker or machine) #comments(optional)
$CURRENT_DAY     $CURRENT_HOUR     5        docker
$CURRENT_DAY     $CURRENT_HOUR     5        machine
EOL

/entrypoint.sh /config.txt /schedule.txt
