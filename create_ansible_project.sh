#!/bin/bash

# Define variables
PROJECT_NAME="ansible-ssh-user-deploy"
USERNAME="ansible_user"
SSH_PUBLIC_KEY="your_ssh_public_key"
SSH_USER="your_ssh_user"
VM_IP_OR_HOSTNAME="your_vm_ip_or_hostname"
PRIVATE_KEY_FILE="path_to_your_private_key"

# Create directory structure
mkdir -p $PROJECT_NAME/{inventory,group_vars,host_vars,roles/ssh_user/{tasks,files,templates,vars},playbooks}

# Create inventory file
cat <<EOL > $PROJECT_NAME/inventory/hosts
[ubuntu_vms]
$VM_IP_OR_HOSTNAME ansible_user=$SSH_USER
EOL

# Create role tasks file
cat <<EOL > $PROJECT_NAME/roles/ssh_user/tasks/main.yml
---
- name: Ensure user "{{ username }}" is present
  ansible.builtin.user:
    name: "{{ username }}"
    state: present
    shell: /bin/bash
    groups: sudo

- name: Add authorized key for "{{ username }}"
  ansible.builtin.authorized_key:
    user: "{{ username }}"
    state: present
    key: "{{ ssh_public_key }}"
EOL

# Create role vars file
cat <<EOL > $PROJECT_NAME/roles/ssh_user/vars/main.yml
---
username: $USERNAME
ssh_public_key: "$SSH_PUBLIC_KEY"
EOL

# Create playbook
cat <<EOL > $PROJECT_NAME/playbooks/deploy_ssh_user.yml
---
- name: Deploy SSH User
  hosts: ubuntu_vms
  become: yes
  roles:
    - ssh_user
EOL

# Create ansible.cfg file
cat <<EOL > $PROJECT_NAME/ansible.cfg
[defaults]
inventory = inventory/hosts
remote_user = $SSH_USER
private_key_file = $PRIVATE_KEY_FILE
host_key_checking = False
retry_files_enabled = False
EOL

echo "Ansible project structure created successfully in the $PROJECT_NAME directory."
