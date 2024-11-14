# Ansible

## Run playbook

```
ansible-playbook -i inventory/inventory playbook.yml 
```

## How configure Proxmox host
### Run for specific host
```
ansible-playbook -i inventory/inventory proxmox_host_setup.yml --ask-vault-pass
```

### Run with vault password file
```
ansible-playbook -i inventory/inventory proxmox_host_setup.yml --vault-password-file ~/.vault_pass.txt
```

## Vault
### Create new vault file

```
ansible-vault create roles/proxmox_host_setup/vars/vault.yml
```
or
```
ansible-vault encrypt_string 'secret_value' --name 'secret_name'
```


### Edit vault file
```
ansible-vault edit roles/proxmox_host_setup/vars/vault.yml
```
### Rekey vault file
```
ansible-vault rekey roles/proxmox_host_setup/vars/vault.yml
```
