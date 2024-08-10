# SSH Configuration Guide

## Summary
1. Install and enable SSH on the server.
2. Optionally configure the SSH server by editing `/etc/ssh/sshd_config`.
3. Set up SSH key-based authentication for more secure access.
4. Ensure your firewall is configured to allow SSH connections.
5. Use the `ssh` command to connect to the server.


## 1. Install SSH (if not already installed)

### On the Server:
```bash
sudo apt-get update
sudo apt-get install openssh-server
```

### On the Client (if you need an SSH client):
```bash
sudo apt-get install openssh-client
```

## 2. Start and Enable the SSH Service (Server Side)

- Start the SSH service:
```bash
sudo systemctl start ssh
```

- Enable SSH to start on boot:
```bash
sudo systemctl enable ssh
```

- Check the status to ensure SSH is running:
```bash
sudo systemctl status ssh
```

## 3. Configure SSH Server Settings (Optional)

- The SSH configuration file is located at `/etc/ssh/sshd_config`.
  - You can open it with your favorite text editor, for example:
    ```bash
    sudo nano /etc/ssh/sshd_config
    ```

### Common Configurations:
- **Change the SSH port (optional for security):**
    ```bash
    Port 22
    ```
    Replace `22` with your desired port number, then ensure the firewall allows traffic on this port.
  
- **Permit Root Login (optional):**
    ```bash
    PermitRootLogin yes  # Or 'no' to disable root login via SSH
    ```

- **Disable Password Authentication (for key-based authentication only):**
    ```bash
    PasswordAuthentication no
    ```

- **Restrict Users (optional):**
    ```bash
    AllowUsers your_username
    ```

- After making changes, restart the SSH service:
    ```bash
    sudo systemctl restart ssh
    ```

## 4. Set Up SSH Key-Based Authentication (Recommended)

### On the Client Side:
- Generate SSH keys:
    ```bash
    ssh-keygen -t rsa -b 4096
    ```
    - This command will generate a key pair (private and public). You can press `Enter` to accept the default file location.
    - Set a passphrase for extra security, or leave it empty for no passphrase.

- **Copy the Public Key to the Server:**
    - Use the `ssh-copy-id` command to copy your public key to the server:
      ```bash
      ssh-copy-id username@server_ip
      ```
    - Replace `username` with your server username and `server_ip` with your server's IP address.
    - If `ssh-copy-id` is not available, you can manually copy the key:
      ```bash
      cat ~/.ssh/id_rsa.pub | ssh username@server_ip 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
      ```

## 5. Connecting to the Server

- Now, you can connect to your server using:
    ```bash
    ssh username@server_ip
    ```

- If you’ve changed the port number:
    ```bash
    ssh -p your_port_number username@server_ip
    ```

## 6. Troubleshooting Common Issues

### Firewall Configuration:
- Ensure that the firewall on the server allows incoming SSH connections on the port you're using:
    ```bash
    sudo ufw allow 22  # If using the default port
    sudo ufw allow your_port_number/tcp  # If using a custom port
    ```

### SELinux/AppArmor Considerations:
- If you’re using SELinux or AppArmor, you may need additional configuration to allow SSH connections on a non-standard port.

