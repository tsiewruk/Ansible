# K3S Cluster Deployment with Ansible

This repository contains Ansible playbooks for deploying and managing a K3s cluster on Proxmox virtual machines.

## Repository Structure

```
.
├── inventory/          # Inventory definitions
├── roles/             # Role definitions
│   ├── common/        # Common server setup
│   ├── k3s/          # K3s cluster configuration
│   └── proxmox_host_setup/  # Proxmox VM provisioning
└── playbooks/         # Main playbooks
```

## Prerequisites

- Ansible 2.9 or higher
- Access to a Proxmox server
- Vault password for encrypted variables

## Playbooks

### 1. Common Server Setup
```bash
ansible-playbook -i inventory/inventory common-setup-hosts.yml
```
Configures basic server settings including:
- System packages
- Firewall rules
- SSH security
- Fail2ban
- Time synchronization

### 2. K3s Cluster Deployment
```bash
ansible-playbook -i inventory/inventory k3s-setup.yml
```
Deploys K3s cluster with:
- Master node configuration
- Worker node configuration
- Network policies
- Storage configuration

### 3. Proxmox VM Provisioning
```bash
# Deploy with vault password prompt
ansible-playbook -i inventory/inventory proxmox_host_setup.yml --ask-vault-pass

# Deploy with vault password file
ansible-playbook -i inventory/inventory proxmox_host_setup.yml --vault-password-file ~/.vault_pass.txt
```

## Vault Management

### Creating Encrypted Variables
```bash
# Create new vault file
ansible-vault create roles/proxmox_host_setup/vars/vault.yml

# Encrypt single string
ansible-vault encrypt_string 'secret_value' --name 'secret_name'
```

### Managing Vault Files
```bash
# Edit vault file
ansible-vault edit roles/proxmox_host_setup/vars/vault.yml

# Change vault password
ansible-vault rekey roles/proxmox_host_setup/vars/vault.yml
```

## Inventory Configuration

The inventory file (`inventory/inventory`) defines the following node groups:
- `master-node`: K3s master nodes
- `worker-node`: K3s worker nodes
- `llm`: Machine learning nodes (optional)
