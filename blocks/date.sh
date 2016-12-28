#!/bin/bash

date '+%Y-%m-%d %H:%M:%S'

case $BLOCK_BUTTON in
  1)
    gsimplecal&
    disown -1
    ;;
esac
