#!/bin/bash

# Output file
output_file="os_info.html"

# Get OS information
os_name=$(uname -o)
kernel_version=$(uname -r)
architecture=$(uname -m)
hostname=$(hostname)
uptime=$(uptime -p)
os_version=$(lsb_release -d | cut -f2)

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
    </table>
</div>

</body>
</html>
EOF

# Print message
echo "OS information has been written to $output_file."

