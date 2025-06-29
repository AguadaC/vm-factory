# How to use Virsh Vol

Managing Virtual Machine Storage Volumes with Libvirt

This tutorial explains how to use `virsh vol` to manage
**virtual machine disk volumes** within **libvirt storage pools**. These volumes
are typically disk image files (`.qcow2`, `.img`, etc.) and are essential for
virtual machine storage.

Libvirt organizes storage using **storage pools** (directories or devices where
volumes are stored), and `virsh vol` allows you to manage the contents of those
pools.

Whether you're creating, inspecting, deleting, or cloning virtual disks, this
guide will help you understand the most important `virsh vol` commands and their
usage.

[[_TOC_]]

## Storage Pool

### Create a Storage Pool

- Choose or Create a Directory for the Pool. This folder will hold your `.qcow2`
or `.img` files.
- Define the Pool. This creates the pool definition, but does not start it yet.

```bash
virsh pool-define-as \
  --name <mypool_name> \
  --type dir \
  --target <my_chosen_directory_path>
```

- Start the Pool with `virsh pool-start <mypool_name>`
- Set the Pool to autostart on boot `virsh pool-autostart mypool`
- Verify the Pool is Running `virsh pool-list`

### Remuve a Storage Pool

```bash
# Stops the pool
virsh pool-destroy mypool

# Removes the definition
virsh pool-undefine mypool
```

### List Storage Pools and Volumes

```bash
# List all available storage pools (enabled and inactive)
virsh pool-list --all

# List volumes inside the 'default' pool
virsh vol-list default
```

### Inspect a Volume

```bash
# Show detailed information about a volume
virsh vol-info --pool default mydisk.qcow2

# Get the full path to the volume file
virsh vol-path --pool default mydisk.qcow2
```

### Create and Remove Volumes

```bash
# Create a 10G qcow2 volume named 'newdisk.qcow2' in the 'default' pool
virsh vol-create-as default newdisk.qcow2 10G --format qcow2

# Permanently delete a volume from the 'default' pool
virsh vol-delete --pool default olddisk.qcow2
```

### Clone or Rename Volumes

```bash
# Clone a volume inside the same pool
virsh vol-clone --pool default original.qcow2 cloned.qcow2

# Rename an existing volume
virsh vol-rename --pool default oldname.qcow2 newname.qcow2
```

## VMs and Storage Pool integration

### Create an independent image

This process copies the cloud image directly into the target disk, allowing the
disk to operate independently without requiring a backing file. This avoids the
risks associated with backing file dependencies, such as data inconsistency or
corruption if the base image is modified or lost.

It is highly recommended to create the new disk in the directory pointed to by
the storage pool that will be used in the integration.

```bash
sudo qemu-img convert -f qcow2 -O qcow2 <cloud_image_path> <new_disk_path>
```

i.e:

```bash
# If the storage pool points to /mnt/vmstorage.
sudo qemu-img convert -f qcow2 -O qcow2 jammy-server-cloudimg-amd64-disk-kvm.img /mnt/vmstorage/ubuntu-cloud.img
```

### Upload the image to the pool

```bash
virsh vol-upload --pool default /mnt/vmstorage/ubuntu-cloud.img ubuntu-cloud.img
```
This registers the file in libvirt without recreating it.

### Use the new volume

To define this disk when creating the VM, you must use the flag
`--disk vol=<pool_name>/<volume_name>`

i.e:

```bash
--disk vol=default/ubuntu-cloud.img
```
