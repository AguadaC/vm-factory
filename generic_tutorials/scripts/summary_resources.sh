#!/bin/bash

echo "=== CPU Model ==="
lscpu | grep 'Model name'

echo "=== CPU Cores ==="
lscpu | grep 'Core(s) per socket:'

echo "=== Virtualization Support ==="
virt_support=$(lscpu | grep 'Virtualization:')
if [ -z "$virt_support" ]; then
  echo "Virtualization info not found"
else
  echo "$virt_support"
fi

echo
echo "=== RAM ==="
free -h

echo
echo "=== Disks and Partitions ==="
lsblk
