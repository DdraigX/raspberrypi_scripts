#!/bin/sh 

sudo apt update 
sudo apt -y dist-update 
sudo apt -y upgrade
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/' /etc/dphys-swapfile

sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start
sudo apt install -y ufw neofetch cpufetch tmux
