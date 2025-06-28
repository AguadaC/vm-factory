# Virtual Machine Automation Lab

This repository is used to document and store everything related to the
**creation and provisioning of virtual machines**.

Tools and technologies used include:

- `virt-install` for VM creation from the command line  
- `virsh` for virtual machine management and administration  
- `qemu` as the hypervisor  
- `cloud-init` for automated instance configuration on first boot

The goal is to simplify and standardize the process of spinning up VMs through
automation, allowing fast and reproducible environments.

[[_TOC_]]

## Purpose

This project is driven by the need to build a personal virtual lab environment
for the deployment and testing of observability services. It serves as a
flexible foundation to develop, configure, and evaluate monitoring stacks and
other infrastructure components in a controlled and reproducible way.
