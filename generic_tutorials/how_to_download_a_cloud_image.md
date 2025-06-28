# How to download a cloud image

Cloud images are pre-built, minimal operating system disk images specifically
designed for cloud and virtual machine environments. They come with essential
packages installed and are configured to work seamlessly with automated
provisioning tools like cloud-init.

Advantages of Using Cloud Images:

- Fast Deployment: Since they are minimal and pre-configured, cloud images
significantly reduce the time needed to spin up new virtual machines.
- Consistency: They provide a standardized base system, ensuring consistency
across multiple deployments.
- Customization: Through tools like cloud-init, cloud images can be customized
at first boot, such as setting users, SSH keys, networking, and installing
packages, without modifying the original image.
- Optimized for Virtualization: These images often have drivers and
configurations optimized for virtualized environments, improving performance
and compatibility.
- Lightweight: They avoid unnecessary software, making them smaller in size
compared to full OS installers, saving storage and bandwidth.

Download the cloud image of your choice from the official distribution source.

- https://cloud-images.ubuntu.com/
- https://cdimage.debian.org/images/cloud/
- https://cdimage.debian.org/images/cloud/

Example (Ubuntu 18.04 Bionic):

```bash
wget https://cloud-images.ubuntu.com/noble/20250516/noble-server-cloudimg-amd64.img
```
