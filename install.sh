#!/usr/bin/env bash

# Check if the script is being run as root
# If not, exit with error code 1
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# Clean up
sudo rm -rf /opt/marshall-prevent-standby

# Create a directory to store the script and audio file
sudo mkdir -p /opt/marshall-prevent-standby

# Copy the script and audio file to the directory
sudo cp silent_audio.wav /opt/marshall-prevent-standby/silent_audio.wav
sudo cp marshall-prevent-standby.timer /opt/marshall-prevent-standby/marshall-prevent-standby.timer
sudo cp marshall-prevent-standby.service /etc/systemd/system/marshall-prevent-standby.service
sudo cp play_audio.sh /opt/marshall-prevent-standby/play_audio.sh
sudo chmod +x /opt/marshall-prevent-standby/play_audio.sh

# Reload systemd to read the new service file
# Enable the timer to start on boot
sudo cp marshall-prevent-standby.timer /etc/systemd/system/marshall-prevent-standby.timer
sudo cp marshall-prevent-standby.service /etc/systemd/system/marshall-prevent-standby.service
sudo systemctl daemon-reload
sudo systemctl enable marshall-prevent-standby.timer
sudo systemctl start marshall-prevent-standby.timer
