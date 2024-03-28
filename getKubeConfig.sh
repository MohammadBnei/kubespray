#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 last part of the master node ip"
    exit 1
fi

ssh core@192.168.1.$1 'sudo bash -c "mkdir /home/core/.kube; cp /etc/kubernetes/admin.conf /home/core/.kube/config && sudo chown -R core ~/.kube"'

scp core@192.168.1.$1:~/.kube/config ~/.kube/config
sed -i "s/127.0.0.1/192.168.1.$1/" ~/.kube/config
