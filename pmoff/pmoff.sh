#!/bin/sh
#turn off onboard wifi
sudo ifconfig wlan0 down 
#set max wifi power
sudo iwconfig wlan1 power off
