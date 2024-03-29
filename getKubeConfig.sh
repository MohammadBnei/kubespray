#!/bin/bash


ssh vagrant@192.168.1.181 'sudo bash -c "mkdir /home/vagrant/.kube; cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config && sudo chown -R vagrant /home/vagrant/.kube"'

scp vagrant@192.168.1.181:~/.kube/config ~/.kube/config
sed -i "s/127.0.0.1/192.168.1.181/" ~/.kube/config
