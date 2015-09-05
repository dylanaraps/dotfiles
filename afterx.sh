#!/bin/bash
# This script runs after boot

# Mount hard drives
sudo mount UUID="CC361E7E361E69AA" /home/dyl/Stuff &
sudo mount UUID="B62A12862A124431" /home/dyl/Videos &

# Connect to Internet
sudo dhcpcd enp5s0


