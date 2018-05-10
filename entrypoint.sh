#!/bin/bash
#
# Any changes are written to the SCALING_FILE
#
set -euo pipefail

SCALING_FILE=$1
SCHEDULE_FILE=$2
CURRENT_HOUR=$(date +"%H") # 0-23
CURRENT_DAY=$(date +"%u") # 1-7

function update_scale_config(){
  # doesnt update actual scale, but adjusts number in config file.
  # Config file is read every minute by scaler entrypoint
  cp ${SCALING_FILE} ${SCALING_FILE}.mod
  if [ "$4" == docker ];then
    sed -i.bak 's/\(l1.medium default true\).*/\1 '$3'/' ${SCALING_FILE}.mod
    echo -e "\tUpdated docker preallocation count to $3"
  elif [ "$4" == machine ];then
    sed -i.bak 's/\(l1.medium default false\).*/\1 '$3'/' ${SCALING_FILE}.mod
    echo -e "\tUpdated machine preallocation count to $3"
  fi
  cat ${SCALING_FILE}.mod > ${SCALING_FILE}
  rm ${SCALING_FILE}.mod
}

cat "$SCHEDULE_FILE" | grep -v -e '^ *$' | grep -v -e '^#' | while read line 
  do
    tokens=( $line )
    if [[ "${tokens[0]}" == "w" && ${CURRENT_DAY} -ge 6 ]];then
      #echo -e "\tSkip weekday rule"
      continue; #rule is weekday, its the weekend, do nothing
    elif [[ "${tokens[0]}" != "w" && "${tokens[0]}" != "${CURRENT_DAY}" ]];then
      #echo -e "\tSkip non-matching day"
      continue; #days don' match
    fi
    if [ "${tokens[1]}" != "${CURRENT_HOUR}" ];then
      #echo -e "\tSkip non-matching hour"
      continue; #days don' match
    fi
    echo -e "\tMatching rule - Day: ${tokens[0]}, Hour: ${tokens[1]}, Type : ${tokens[3]}, Count: ${tokens[2]}"
    update_scale_config ${tokens[*]}
  done

echo "schedule updated"
