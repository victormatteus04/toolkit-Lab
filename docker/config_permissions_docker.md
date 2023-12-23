# Config Permissions of Docker

Create a systemd Service File. Open a Terminal and switch to root or use sudo to create a new service file:

```sh
sudo nano /etc/systemd/system/docker-sock-permission.service
```
Add the Following Content to the file:

```
[Unit]
Description=Set full permissions to Docker socket

[Service]
Type=oneshot
ExecStart=/bin/chmod 666 /var/run/docker.sock

[Install]
WantedBy=multi-user.target

```

Save and Exit: Press Ctrl+O to save and Ctrl+X to exit the editor.


Reload Systemd and Enable the Service. Reload Systemd to recognize the new service:

```sh
sudo systemctl daemon-reload
```

Enable the Service to run at startup:

```sh
    sudo systemctl enable docker-sock-permission.service
```

Reboot and Verify. Reboot Your System. Verify that the permissions have been set correctly:

```bash
ls -l /var/run/docker.sock
```

The permissions should now be srw-rw-rw-.

```bash

sudo usermod -aG docker your_username
```
Replace your_username with your actual username. You will need to log out and back in for this change to take effect.