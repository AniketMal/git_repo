#!/bin/bash

# Check if curl is installed
if ! command -v curl &> /dev/null
then
    echo "curl is not installed. Installing..."
    # Update package lists and install curl
    sudo apt update
    sudo apt install -y curl
    # Check if installation was successful
    if [ $? -eq 0 ]; then
        echo "curl has been successfully installed."
    else
        echo "Failed to install curl. Please check your internet connection and try again."
        exit 1
    fi
else
    echo "curl is already installed."
fi
