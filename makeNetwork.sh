#!/bin/bash

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <list of integers>"
    exit 1
fi

for i in "$@"; do
    # Check if the argument is an integer
    if ! [[ $i =~ ^-?[0-9]+$ ]]; then
        echo "Error: Argument must be an integer."
        exit 2
    fi

    # Use SSH to run commands on the remote machine
    ssh core@192.168.1.$i "sudo bash -c 'cat > /etc/systemd/network/00-eth1.network' << EOF
[Match]
Name=eth1

[Network]
Address=192.168.1.$i/24
Gateway=192.168.1.254

EOF"
    ssh core@192.168.1.$i "sudo bash -c 'systemctl restart systemd-networkd'"
done