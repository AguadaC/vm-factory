# How to manage a VM

[[_TOC_]]

## Virsh

```bash
# List all defined VMs (running and stopped)
virsh list --all

# Start a virtual machine
virsh start <vm-name>

# Shutdown a virtual machine cleanly
virsh shutdown <vm-name>

# Forcefully stop (power off) a VM
virsh destroy <vm-name>

# Reboot a VM
virsh reboot <vm-name>

# Undefine (delete the VM definition, not the disk)
virsh undefine <vm-name>

# Attach to the serial console (if enabled)
virsh console <vm-name>

# Show network info including VM IP addresses
virsh domifaddr <vm-name>
```

## Linux tools

```bash
# Once you have the IP and assuming your cloud-init added the SSH key properly.
ssh <user in user-data>@<virtual machine's IP>

# -------
# If you're done and want to clean up the VM and its disk
# Shutdown the VM (if it is still running)
virsh shutdown <vm-name>

# Undefine the VM (remove from libvirt)
virsh undefine <vm-name>

# Remove the disk file (adjust the path accordingly)
rm </path/to/vm-disk.qcow2>
```

> </path/to/vm-disk.qcow2> comes from
[here](how_to_create_a_virtual_machine.md)