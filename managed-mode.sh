#! /bin/bash

ifconfig wlan0 down && iw dev wlan0 set type managed && ifconfig wlan0 up

echo -e "\n\nYou're back to Managed Mode on wlan0"
