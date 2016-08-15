#! /bin/bash

ifconfig wlan0 down && iw dev wlan0 set type monitor && ifconfig wlan0 up

echo "You're entering Monitor Mode on wlan0"

while [ 1 ]; do
  for CHANUM in {1..11}; do
    iwconfig wlan0 channel $CHANUM
    sleep 1
  done
done
