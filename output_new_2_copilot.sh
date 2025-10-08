#!/bin/bash

# Output file
OUTPUT="/home/neosoft/Desktop/script/system_info.html"

# HTML header
echo "<html><head><title>System Information</title></head><body>" > $OUTPUT
echo "<h1>System Information</h1>" >> $OUTPUT

# OS and Kernel Info
echo "<h2>OS and Kernel Info</h2>" >> $OUTPUT
echo "<pre>$(uname -a)</pre>" >> $OUTPUT

# System Uptime
echo "<h2>System Uptime</h2>" >> $OUTPUT
echo "<pre>$(uptime)</pre>" >> $OUTPUT

# Memory Information
echo "<h2>Memory Information</h2>" >> $OUTPUT
echo "<pre>$(free -h)</pre>" >> $OUTPUT

# CPU Information
echo "<h2>CPU Information</h2>" >> $OUTPUT
echo "<pre>$(lscpu)</pre>" >> $OUTPUT

# Disk Usage and Mounted Filesystems
echo "<h2>Disk Usage and Mounted Filesystems</h2>" >> $OUTPUT
echo "<pre>$(df -h)</pre>" >> $OUTPUT

# Network Configuration
echo "<h2>Network Configuration</h2>" >> $OUTPUT
echo "<pre>$(ip a)</pre>" >> $OUTPUT

# Active Services and Their Statuses
echo "<h2>Active Services and Their Statuses</h2>" >> $OUTPUT
echo "<pre>$(systemctl list-units --type=service --state=active)</pre>" >> $OUTPUT

# Installed Packages
echo "<h2>Installed Packages</h2>" >> $OUTPUT
echo "<pre>$(dpkg -l)</pre>" >> $OUTPUT

# Loaded Kernel Modules
echo "<h2>Loaded Kernel Modules</h2>" >> $OUTPUT
echo "<pre>$(lsmod)</pre>" >> $OUTPUT

# Security Configuration
echo "<h2>Security Configuration</h2>" >> $OUTPUT
echo "<pre>$(sudo ufw status)</pre>" >> $OUTPUT

# HTML footer
echo "</body></html>" >> $OUTPUT

# Open the HTML file in the default web browser
xdg-open $OUTPUT
