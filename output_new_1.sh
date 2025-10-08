#!/bin/bash

# Output file
output_file="os_info_1.html"

# Get OS information
os_name=$(uname -o)
kernel_version=$(uname -r)
architecture=$(uname -m)
hostname=$(hostname)
uptime=$(uptime -p)
os_version=$(lsb_release -d | cut -f2)

# Get installed packages (for Debian/Ubuntu-based systems)
if command -v dpkg > /dev/null; then
    installed_packages=$(dpkg --get-selections | grep -v deinstall | wc -l)
elif command -v rpm > /dev/null; then
    installed_packages=$(rpm -qa | wc -l)
else
    installed_packages="N/A"
fi

# Get running processes
running_processes=$(ps -e --format=pid,cmd | wc -l)

# Get network information
network_info=$(ip addr show | grep 'inet ' | awk '{print $2 " - " $NF}' | tr '\n' ', ')
network_info=${network_info%, }  # Remove trailing comma

# Get disk usage
disk_usage=$(df -h --output=source,size,used,avail,pcent | sed '1d' | tr '\n' '<br>')

# Get mounted filesystems
mounted_filesystems=$(mount | awk '{print $1 " on " $3 " (" $5 ")"}' | tr '\n' '<br>')

# Create HTML output
cat << EOF > $output_file
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Linux OS Information</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }
        .container { width: 80%; margin: auto; padding: 20px; background: white; border-radius: 5px; }
        h1 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

<div class="container">
    <h1>Linux OS Information</h1>
    <table>
        <tr>
            <th>Parameter</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>OS Name</td>
            <td>$os_name</td>
        </tr>
        <tr>
            <td>Kernel Version</td>
            <td>$kernel_version</td>
        </tr>
        <tr>
            <td>Architecture</td>
            <td>$architecture</td>
        </tr>
        <tr>
            <td>Hostname</td>
            <td>$hostname</td>
        </tr>
        <tr>
            <td>Uptime</td>
            <td>$uptime</td>
        </tr>
        <tr>
            <td>OS Version</td>
            <td>$os_version</td>
        </tr>
        <tr>
            <td>Installed Packages</td>
            <td>$installed_packages</td>
        </tr>
        <tr>
            <td>Running Processes</td>
            <td>$running_processes</td>
        </tr>
        <tr>
            <td>Network Information</td>
            <td>$network_info</td>
        </tr>
        <tr>
            <td>Disk Usage</td>
            <td><pre>$disk_usage</pre></td>
        </tr>
        <tr>
            <td>Mounted Filesystems</td>
            <td><pre>$mounted_filesystems</pre></td>
        </tr>
    </table>
</div>

</body>
</html>
EOF

# Print message
echo "OS information has been written to $output_file."

