#!/bin/bash

ask_yes_no() {
  while true; do
  read -p "$1 (y/n) " yn
  case $yn in
  [Yy]*)
    break
    ;;
  [Nn]*)
    echo "You chose no."
    exit
    ;;
  *) echo "Please answer yes or no." ;;
  esac
done
}

sudo apt install cpu-checker -y
sudo kvm-ok

ask_yes_no "Do you wish to continue?"

sudo apt-get install libvirt-clients libvirt-daemon-system qemu-kvm bridge-utils dnsmasq virt-manager -y

sudo usermod -a -G libvirt $(whoami)

read -p "Uncomment the line: uri_default = \"qemu:///system\". The file will open after you press a key." nil

sudo nvim /etc/libvirt/libvirt.conf

ask_yes_no "Install Vagrant ?"

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update && sudo apt install vagrant

vagrant version

ask_yes_no "Install libvirt ?"

sudo apt-get build-dep vagrant ruby-libvirt
sudo apt-get install -y qemu libvirt-daemon-system ebtables libguestfs-tools \
  libxslt-dev libxml2-dev zlib1g-dev ruby-dev
vagrant plugin install vagrant-libvirt


