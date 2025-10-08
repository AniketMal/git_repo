#!/bin/bash

# Script to gather Linux server OS and configuration details and save them as an HTML file

# Output file
OUTPUT="os_details.html"

# Function to print headers for each section in HTML
print_header() {
    echo "<h2>$1</h2>" >> $OUTPUT
}

# Function to print preformatted content
print_preformatted() {
    echo "<pre>$1</pre>" >> $OUTPUT
}

# Start HTML document
echo "<html>" > $OUTPUT
echo "<head><title>Linux OS and System Configuration Details</title></head>" >> $OUTPUT
echo "<body>" >> $OUTPUT
echo "<h1>Linux OS and System Configuration Details</h1>" >> $OUTPUT

# OS and Kernel information
get_os_info() {
    print_header "OS AND KERNEL INFORMATION"
    os_info="OS: $(grep -w "PRETTY_NAME" /etc/os-release | cut -d '=' -f2 | tr -d '\"')\n"
    os_info+="Kernel Version: $(uname -r)\n"
    os_info+="Hostname: $(hostname)\n"
    os_info+="Architecture: $(uname -m)"
    print_preformatted "$os_info"
}

# Uptime and Load Average
get_uptime() {
    print_header "SYSTEM UPTIME AND LOAD AVERAGE"
    uptime_info="Uptime: $(uptime -p)\n"
    uptime_info+="Current Time: $(date)\n"
    uptime_info+="Load Average: $(uptime | awk -F'load average:' '{ print \$2 }')"
    print_preformatted "$uptime_info"
}

# Memory and Swap usage
get_memory_info() {
    print_header "MEMORY INFORMATION"
    memory_info=$(free -h)
    print_preformatted "$memory_info"
}

# CPU Information
get_cpu_info() {
    print_header "CPU INFORMATION"
    cpu_info="Model Name: $(grep 'model name' /proc/cpuinfo | uniq | cut -d ':' -f2 | sed 's/^ //')\n"
    cpu_info+="CPU Cores: $(nproc)\n"
    cpu_info+="CPU Speed: $(lscpu | grep 'MHz' | awk '{print \$3 " MHz"}')"
    print_preformatted "$cpu_info"
}

# Disk Usage and Mounted Filesystems
get_disk_info() {
    print_header "DISK USAGE AND MOUNTED FILESYSTEMS"
    disk_info=$(df -h)
    print_preformatted "$disk_info"
    print_header "Mounted Filesystems"
    mount_info=$(lsblk)
    print_preformatted "$mount_info"
}

# Network Configuration
get_network_info() {
    print_header "NETWORK CONFIGURATION"
    network_info="IP Addresses:\n$(ip addr show | grep inet)\n"
    network_info+="\nRouting Table:\n$(ip route show)\n"
    network_info+="\nListening Ports:\n$(ss -tuln)"
    print_preformatted "$network_info"
}

# Active services and their statuses
get_service_status() {
    print_header "ACTIVE SERVICES AND THEIR STATUSES"
    if command -v systemctl >/dev/null; then
        service_status=$(systemctl list-units --type=service --state=running)
    elif command -v service >/dev/null; then
        service_status=$(service --status-all | grep "+")
    else
        service_status="No service manager found."
    fi
    print_preformatted "$service_status"
}

# Installed Packages
get_installed_packages() {
    print_header "INSTALLED PACKAGES"
    if command -v dpkg >/dev/null; then
        package_list=$(dpkg -l)
    elif command -v rpm >/dev/null; then
        package_list=$(rpm -qa)
    else
        package_list="No package manager found."
    fi
    print_preformatted "$package_list"
}

# Kernel Modules
get_kernel_modules() {
    print_header "LOADED KERNEL MODULES"
    kernel_modules=$(lsmod)
    print_preformatted "$kernel_modules"
}

# Environment Variables
get_environment_variables() {
    print_header "ENVIRONMENT VARIABLES"
    env_variables=$(printenv)
    print_preformatted "$env_variables"
}

# Users and Groups
get_users_and_groups() {
    print_header "USERS AND GROUPS"
    users_info="Logged-in Users:\n$(who)\n"
    users_info+="\nAll Users:\n$(cut -d: -f1 /etc/passwd)\n"
    users_info+="\nGroups:\n$(cut -d: -f1 /etc/group)"
    print_preformatted "$users_info"
}

# Security Configurations (e.g., SELinux, Firewall)
get_security_info() {
    print_header "SECURITY CONFIGURATION"
    
    # Check SELinux status
    if command -v sestatus >/dev/null; then
        selinux_status=$(sestatus)
    else
        selinux_status="SELinux is not installed or active."
    fi
    firewall_status=""
    # Check firewall status
    if command -v firewall-cmd >/dev/null; then
        firewall_status=$(firewall-cmd --state)
    elif command -v ufw >/dev/null; then
        firewall_status=$(ufw status)
    else
        firewall_status="No firewall service detected."
    fi
    print_preformatted "SELinux Status:\n$selinux_status\n\nFirewall Status:\n$firewall_status"
}

# Run all the functions and write to HTML
get_os_info
get_uptime
get_memory_info
get_cpu_info
get_disk_info
get_network_info
get_service_status
get_installed_packages
get_kernel_modules
get_environment_variables
get_users_and_groups
get_security_info

# End HTML document
echo "</body>" >> $OUTPUT
echo "</html>" >> $OUTPUT

echo "System details collected and saved to $OUTPUT"
