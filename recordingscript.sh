#!/bin/bash

# Function to install curl if not installed
install_curl() {
    if ! command -v curl &> /dev/null; then
        echo "Installing curl..."
        sudo apt update
        sudo apt install -y curl
        echo "curl installed successfully."
    fi
}

# Function to install pip3 if not installed
install_pip3() {
    if ! command -v pip3 &> /dev/null; then
        echo "Installing pip3..."
        sudo apt update
        sudo apt install -y python3-pip
        echo "pip3 installed successfully."
    fi
}

# Function to install pv_recorder_demo if not installed
install_pv_recorder_demo() {
    if ! command -v pv_recorder_demo &> /dev/null; then
        echo "Installing pv_recorder_demo..."
        sudo pip3 install pvrecorderdemo
        echo "pv_recorder_demo installed successfully."
    fi
}

# Function to create a new .wav file name
create_wav_file() {
    timestamp=$(date +"%Y%m%d_%H%M%S")
    wav_file="/var/www/html/test_$timestamp.wav"
    echo "$wav_file"
}

# Function to show audio devices and wait for user input
show_audio_devices() {
    echo "Showing audio devices..."
    pv_recorder_demo --show_audio_devices
    echo "Press Enter to continue..."
#    read -r
}

# Main function
main() {
    install_curl
    install_pip3
    install_pv_recorder_demo
    
    show_audio_devices
    
   # Prompt the user to enter the audio device index
    read -p "Enter audio device index: " AUDIO_DEVICE_INDEX
    
    # Create a new .wav file
    wav_file=$(create_wav_file)
    
    # Run the pv_recorder_demo command with the specified parameters
    echo "Running pv_recorder_demo..."
    pv_recorder_demo --audio_device_index "$AUDIO_DEVICE_INDEX" --output_wav_path "$wav_file"
    
    echo "Recording saved as $wav_file"
}

# Run main function
main
