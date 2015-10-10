#!/bin/bash
# This script runs after boot

# Set cpu to run at max speed
sudo cpupower frequency-set -g performance &

# Mount hard drives
sudo mount UUID="CC361E7E361E69AA" /home/dyl/Stuff &
sudo mount UUID="B62A12862A124431" /home/dyl/Videos &

# Connect to Internet
sudo dhcpcd enp5s0 &

pulseaudio --start &


