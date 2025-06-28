# How to create the cloud-init.iso

[Cloud Init Documentation](https://cloudinit.readthedocs.io/en/latest/index.html)

[[_TOC_]]

## Create the data file

### user-data file

It is used to define custom configuration instructions that are executed when a
cloud image boots for the first time.

It allows you to automate tasks such as:

- Creating users and setting passwords or SSH keys
- Installing packages
- Running shell scripts or commands
- Setting up networking
- Configuring services (e.g., Docker, Nginx)
- Enabling or disabling system behaviors

>
> [!WARNING]
> Do NOT remove or modify the first line: '#cloud-config'
> This line is required for cloud-init to detect and process the configuration.
> If it's missing or changed, cloud-init will ignore the entire file.
>

```yml
#cloud-config
users:
  - name: cloud
    ssh_authorized_keys:
      - # Paste here your public ssh key.
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    groups: ["users"]
    shell: /bin/bash

runcmd:
  - sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin yes/' /etc/ssh/sshd_config
  - sed -i -e '/^PasswordAuthentication/s/^.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config
  - sed -i -e '/^PubkeyAuthentication/s/^.*$/PubkeyAuthentication yes/' /etc/ssh/sshd_config
  - sed -i -e '$aAllowUsers cloud' /etc/ssh/sshd_config
  - systemctl restart ssh
```

For more details, refer to
[this documentation](https://cloudinit.readthedocs.io/en/latest/explanation/format.html)

### meta-data file

This file provides instance-level metadata to the virtual machine.
It is typically used together with `user-data` during cloud-init provisioning.

```yml
instance-id: payrus113
local-hostname: payrus113
```

Customization:

- instance-id: A unique identifier for the VM instance.
You can use any string you like here (e.g., vm1, lab-node, etc.).

- local-hostname: The hostname that will be set on the virtual machine.
Choose any valid hostname according to your naming conventions
(e.g., node1, monitor-host, hal9000, etc.).

## Create the iso image

Once the data files are created, generate the ISO image with this command.

```bash
genisoimage -output cidata.iso -V cidata -r -J user-data meta-data
```

The `genisoimage` command is used to create an ISO image that contains the
`user-data` and `meta-data` files required by cloud-init for automatic
provisioning of a virtual machine.

Cloud-init expects to find these files in a disk labeled `cidata`, which mimics
the behavior of a cloud provider's configuration drive.
