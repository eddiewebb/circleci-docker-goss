#!/usr/bin/env bash

touch /schedule.txt #we cant ensure test order, and previous test may hvae created this
rm /schedule.txt


/entrypoint.sh /config.txt /schedule.txt
