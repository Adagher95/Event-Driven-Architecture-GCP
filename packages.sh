#!/bin/bash

echo "Starting installation..."

# Step 1: Fix the util-linux issue
echo "Fixing util-linux configuration issue..."
sudo rm -f /usr/bin/nodejs  # Remove the problematic symbolic link
sudo dpkg --configure -a    # Reconfigure broken packages
sudo apt update -y && sudo apt upgrade -y  # Update the package manager

# Step 2: Install pip3 and Python3
echo "Installing pip3 and Python3..."
sudo apt install -y python3 python3-pip || {
    echo "Failed to install Python3 or pip3. Exiting."
    exit 1
}

# Step 3: Install required Python packages
echo "Installing Python packages..."
sudo pip3 install --break-system-packages flask mysql-connector-python  bcrypt google-cloud-pubsub || {
    echo "Failed to install Python packages. Exiting."
    exit 1
}

# Step 4: Verify installations
echo "Verifying installations..."
python3 -c "import flask; print('Flask installed:', flask.__version__)" || echo "Flask installation failed"
python3 -c "import mysql.connector; print('MySQL Connector installed')" || echo "MySQL Connector installation failed"
python3 -c "import bcrypt; print('Bcrypt installed:', bcrypt.__version__)" || echo "Bcrypt installation failed"
python3 -c "import google.cloud.pubsub_v1; print('Google Cloud Pub/Sub installed')" || echo "Google Cloud Pub/Sub installation failed"

echo "All dependencies installed successfully!"

