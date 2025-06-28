# How to install dependencies for libvirt

[[_TOC_]]

## Install the required packages

```bash
# Update the package list
sudo apt update

# qemu-kvm: hardware-based virtualization engine (KVM)
sudo apt install qemu-kvm

# libvirt-daemon-system: daemon that manages virtual machines
sudo apt install libvirt-daemon-system

# libvirt-clients: command-line tools like 'virsh'
sudo apt install libvirt-clients

# virtinst: provides the 'virt-install' tool
sudo apt install virtinst

# bridge-utils: used to create network bridges (e.g., 'br0')
sudo apt install bridge-utils

# genisoimage: tool to create ISO 9660 images (e.g., for cloud-init ISOs)
sudo apt install genisoimage

# libguestfs-tools: tools to inspect and modify VM disk images (includes
#guestmount and guestunmount)
sudo apt install libguestfs-tools
```

## Verify that your user is in the libvirt group

```bash
sudo usermod -aG libvirt $(whoami)

newgrp libvirt
```

>
> **Note:** When a user is added to a group with usermod, the change does not
> affect the current session right away. The newgrp libvirt command starts a new
> shell session with libvirt as the primary group.
> So, The libvirt group permissions are immediately active in the terminal from
> that moment forward.
>

## Confirming That KVM Is Enabled

To check whether KVM (Kernel-based Virtual Machine) is enabled and available on
your system, run: `ls /dev/kvm`

`/dev/kvm` is a device file representing the interface between the operating
system and the KVM virtualization module in the Linux kernel.

If the /dev/kvm file exists, it means:
- The KVM module is loaded in the kernel.
- Your CPU supports hardware virtualization (Intel VT-x or AMD-V).
- Hardware virtualization is enabled in BIOS/UEFI.
    
If the file does NOT exist, it may indicate one or more of the following:
- The kvm module (and its variant kvm_intel or kvm_amd) is not loaded.
- The CPU does not support hardware virtualization.
- Virtualization is disabled in BIOS/UEFI.
