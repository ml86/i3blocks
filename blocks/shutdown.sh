#!/bin/bash

STATE_FILE="/tmp/i3block_shutdown_state"
declare -A STATE_MAP
STATE_MAP[1]=":"
STATE_MAP[1]="Shutdown:systemctl shutdown"
STATE_MAP[2]="Suspend:systemctl suspend"
STATE_MAP[3]="Logout:i3-msg exit"
STATE_NUM=4

STATE=$(cat $STATE_FILE)

if [[ $STATE -le 0 ]] || [[ $STATE -ge $STATE_NUM ]]; then
  STATE=0
fi

case $BLOCK_BUTTON in
  1)
    let STATE=STATE+1
    ;;
  3)
    EXECUTE=true
    ;;
  4)
    let STATE=STATE-1
    ;;
  5)
    let STATE=STATE+1
    ;;
esac

if [[ $EXECUTE ]]; then
  eval $(echo ${STATE_MAP[$STATE]} | cut -d ":" -f2)
  STATE=0
else
  if [[ $STATE -lt 0 ]]; then
    let STATE=$STATE_NUM-1
  elif [[ $STATE -ge $STATE_NUM ]]; then
    let STATE=0
  fi
fi

echo $STATE > $STATE_FILE
STATE_STR=$(echo ${STATE_MAP[$STATE]} | cut -d ":" -f1)
echo -e "<span font='FontAwesome'>\uf011 $STATE_STR</span>"
