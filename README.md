[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/detperalta)

# Setup

#### 1 - Run:
```
ssh-keygen -t ed25519 -C "ansible"
```
#### 2 - Add key name ansible e.g. (/home/user/.ssh/ansible)

#### 3 - Copy to server
```
ssh-copy-id -i ~/.ssh/ansible.pub root@10.27.27.121
```