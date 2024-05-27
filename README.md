# Setup

1 - Run:
```
ssh-keygen -t ed25519 -C "ansible"
```
2 - Add key name ansible e.g. (/home/user/.ssh/ansible)
```
ssh-copy-id -i ~/.ssh/ansible.pub root@10.27.27.121
```