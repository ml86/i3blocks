#!/bin/bash

ACPI=$(acpi)
PARTS=$(echo $ACPI | sed 's/.*: \(.*\), \(.*\)%, \([0-9:]*\).*/\1 \2 \3/')
PARTS_ARRAY=($PARTS)


LOAD=${PARTS_ARRAY[1]}
LOAD_COLOR='white'
if [[ $LOAD -ge 0 ]] && [[ $LOAD -le 10 ]]; then
  LOAD_COLOR='#FF0000'
elif [[ $LOAD -ge 80 ]]; then
  LOAD_COLOR='#00FF00'
fi

if [[ $LOAD -ge 0 ]] && [[ $LOAD -le 10 ]]; then
  BATTERY='\uf244'
elif [[ $LOAD -le 25 ]]; then
  BATTERY='\uf243'
elif [[ $LOAD -le 50 ]]; then
  BATTERY='\uf242'
elif [[ $LOAD -le 75 ]]; then
  BATTERY='\uf241'
else
  BATTERY='\uf240'
fi


if [[ ${PARTS_ARRAY[0]} == "Charging" ]]; then
  CHARGING='\uf1e6'
fi

TIME_REMAINING=${PARTS_ARRAY[2]}
echo -e "<span font='FontAwesome'>$BATTERY $CHARGING <span color=\"$LOAD_COLOR\">$LOAD%</span> ($TIME_REMAINING)</span>"


