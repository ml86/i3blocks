#!/bin/bash

INTERFACE=$(ip route | awk '/default/{print $5;exit}')
#INTERFACE="en"

if [[ $INTERFACE == wl* ]]; then
  ICON='\uf1eb'
  WIFI_STRENGTH=$(iw dev $INTERFACE link | grep signal | cut -d " " -f2)
  SSID=$(iw dev $INTERFACE link |grep SSID | cut -d  " " -f2)
  echo -e "<span font='FontAwesome'>$ICON $SSID $WIFI_STRENGTH dBm</span>"
elif [[ $INTERFACE == en* ]]; then
  ICON='\uf0ec'
  echo -e "<span font='FontAwesome'>$ICON up</span>"
else
  ICON='\uf0ec'
  echo -e "<span font='FontAwesome'>$ICON down</span>"
fi


