# Netplan for bridge

[Article](https://fabianlee.org/2022/09/20/kvm-creating-a-bridged-network-with-netplan-on-ubuntu-22-04/)

```sh
sudo apt-get update
sudo apt install bridge-utils netplan.io -y
```

Get your ethernet interface (altname) with :

```sh
ip addr show
```

```console
sudo nvim /etc/netplan/00-bridge.yml
```

Specify the parameters like :

```yaml
network:
  version: 2
  renderer: networkd

  ethernets:
    eno1:
      dhcp4: false
      dhcp6: false

  bridges:
    br0:
      interfaces: [eno1]
      addresses: [192.168.1.200/24]
      routes:
      - to: default
        via: 192.168.1.254
        metric: 100
        on-link: true
      mtu: 1500
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
      parameters:
        stp: true
        forward-delay: 4
      dhcp4: no
      dhcp6: no
```

Apply configuration :

```sh
sudo netplan generate
sudo netplan --debug apply
```

Configure libvirt (virsh) to use the bridge. 

Create a xml file : 

```xml
<network>
  <name>host-bridge</name>
  <forward mode="bridge"/>
  <bridge name="br0"/>
</network>
```

And add it to virsh :

```sh
# current list of libvirt networks
virsh net-list

# create libvirt network using existing host bridge
virsh net-define host-bridge.xml
virsh net-start host-bridge
virsh net-autostart host-bridge

# state should be active, autostart, and persistent
virsh net-list --all
```