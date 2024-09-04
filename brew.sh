#!/bin/bash

# Function to show a progress bar
show_progress() {
  local duration=$1
  while [ $duration -gt 0 ]; do
    echo -n "#"
    sleep 0.1
    duration=$((duration - 1))
  done
  echo ""
}

# Step 1: Install curl
echo "Installing curl..."
sudo apt install -y curl &> /dev/null &
pid=$!
show_progress 100
wait $pid
echo "curl installed."

# Step 2: Download Brave keyring
echo "Downloading Brave browser keyring..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg &> /dev/null &
pid=$!
show_progress 50
wait $pid
echo "Keyring downloaded."

# Step 3: Add Brave repository to sources list
echo "Adding Brave browser repository..."
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list &> /dev/null
show_progress 20
echo "Repository added."

# Step 4: Update package list
echo "Updating package list..."
sudo apt update &> /dev/null &
pid=$!
show_progress 100
wait $pid
echo "Package list updated."

# Step 5: Install Brave browser
echo "Installing Brave browser..."
sudo apt install -y brave-browser &> /dev/null &
pid=$!
show_progress 100
wait $pid
echo "Brave browser installed."

echo "All tasks completed successfully!"
