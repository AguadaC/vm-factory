# How to create a virtual machine

Once you've [prepared the cloud image](how_to_download_a_cloud_image.md)
and [generated the cloud-init ISO](how_to_create_the_cloud_init_iso.md),
you're ready to create and launch your virtual machine.

[[_TOC_]]

##  Using a Backing File (Linked Disk Setup)

In this configuration, the virtual disk references a base image (backing_file).
This setup saves disk space and speeds up provisioning but introduces a
dependency on the base image.

### Prepare the VM disk

- Create a new QCOW2 disk based on the cloud image

For example:

```bash
qemu-img create -f qcow2 \
  -o backing_file=</path/to/cloud-image.img>,backing_fmt=qcow2 \
  </path/to/vm-disk.qcow2>
```
  >
  > The backing_file must point to a cloud image previously downloaded, such as
  > Ubuntu or Debian cloud images.
  > Do not delete or move the cloud image after creating the new disk — it acts
  > as a base layer. The VM disk depends on it.
  >

- Resize the disk to provide enough space (e.g., 10 GB)

```bash
qemu-img resize </path/to/vm-disk.qcow2> 10G
```
  >
  > The resize command is important because most cloud images are minimal and
  > offer very limited disk space by default.
  >

### Launch the VM with virt-install

```bash
virt-install \
  --connect qemu:///system \
  --virt-type kvm \
  --name <your-vm-name> \
  --ram 2048 \
  --vcpus=1 \
  --os-variant <your-os-variant> \
  --disk path=</path/to/vm-disk.qcow2>,format=qcow2 \
  --disk </path/to/cloud-init.iso>,device=cdrom \
  --import \
  --network network=default \
  --noautoconsole
```

**--import**: Boot the virtual machine directly from an existing image without
running a traditional OS installer.

**--disk**: Attaches both the virtual disk and the cloud-init ISO to the VM.

**--network network=default**: Connects the VM to the default NAT network
managed by libvirt.

**--noautoconsole**: Skips opening the VM console automatically (you can connect
later using virsh console).

## Using an Independent Disk (Full Image Copy)

This method copies the full cloud image into the disk, creating a standalone
volume with no dependency on a backing file. This is a safer option for
long-term stability and portability, especially in production environments.

Follow [this documentation](how_to_use_virsh_vol.md)

After creating the new volume, you are ready to create the VM.

```bash
virt-install \
  --connect qemu:///system \
  --virt-type kvm \
  --name <your-vm-name> \
  --ram 2048 \
  --vcpus=1 \
  --os-variant <your-os-variant> \
  --disk vol=<pool_name>/<volume_name> \
  --disk </path/to/cloud-init.iso>,device=cdrom \
  --import \
  --network network=default \
  --noautoconsole
```

Note the use of the new `--disk vol=...` flag, which allows you to attach a
volume from a specific storage pool.
