# Kubernetes Development Environment Setup

This repository contains Vagrantfiles and a script for setting up a basic Debian VM environment, intended for Kubernetes cluster deployment via Kubespray. The setup facilitates the creation of a local Kubernetes development environment on Debian 12 servers.

## Prerequisites

- Vagrant >= 2.0.4
- Virtualization provider (e.g., libvirt or VirtualBox)
- SSH client
- Kubespray (for deploying Kubernetes clusters)

## Repository Contents

- `Vagrantfile`: Configuration files for setting up Debian VMs.
- `setup_kubeconfig.sh`: Script for configuring `kubectl` to interact with the newly created Kubernetes cluster.

## Setup Overview

1. **VM Creation**: The Vagrantfiles are used to create and configure two Debian VMs with predefined network settings, serving as the base for the Kubernetes cluster.

2. **Kubernetes Cluster**: After VM setup, Kubespray is used to deploy a Kubernetes cluster onto these VMs.

3. **Kubeconfig Setup**: The provided script configures `kubectl` on your local machine to interact with the Kubernetes cluster.

## Quick Start Guide

### Step 1: VM Setup

1. Ensure Vagrant and your virtualization provider are installed and configured.
2. Clone this repository to your local machine.
3. Navigate to the repository directory.
4. Run `vagrant up` to create and start the VMs.

### Step 2: Deploy Kubernetes with Kubespray

1. Follow Kubespray's documentation to deploy Kubernetes onto the VMs created in Step 1.

### Step 3: Configure Kubectl

1. Execute the `getKubeConfig.sh` script to configure `kubectl` on your local machine:
   ```bash
   ./getKubeConfig.sh
   ```
2. Verify `kubectl` is correctly configured by running:
   ```bash
   kubectl cluster-info
   ```

## Network Configuration

- **Public Network**: Each VM is assigned a unique IP in the `192.168.1.19x` range, allowing external access.
- **Private Network**: An internal network on the `192.168.10.6x` range is configured for inter-VM communication.

## VM Specifications

- **Operating System**: Debian 12
- **Memory**: 8192 MB
- **CPUs**: 2

## Additional Information

- It's recommended to review and adjust the Vagrantfile and script as per your specific network and development requirements.
- For detailed Kubespray usage and Kubernetes cluster configuration, refer to the official Kubespray documentation.

## Support

For issues or questions regarding the setup, please open an issue in this repository.