# How to know the resources of a machine

To check your machine’s physical resources before virtualizing, you can use the
following commands.

[[_TOC_]]

## CPU

### lscpu

To see CPU information (model, cores, architecture, virtualization support).

```bash
@masterhost:~$ lscpu
​￼Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          48 bits physical, 48 bits virtual
  Byte Order:             Little Endian
​￼CPU(s):                   6
  On-line CPU(s) list:    0-5
​￼Vendor ID:                AuthenticAMD
  ​￼Model name:             AMD Phenom(tm) II X6 1100T Processor
    CPU family:           16
    Model:                10
    Thread(s) per core:   1
    Core(s) per socket:   6
    Socket(s):            1
    Stepping:             0
    Frequency boost:      enabled
    CPU(s) scaling MHz:   24%
    CPU max MHz:          3300.0000
    CPU min MHz:          800.0000
    BogoMIPS:             6622.21
    ​￼Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good no
                          pl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_p
                          state vmmcall npt lbrv svm_lock nrip_save pausefilter
​￼Virtualization features:  
  Virtualization:         AMD-V
​￼Caches (sum of all):      
  L1d:                    384 KiB (6 instances)
  L1i:                    384 KiB (6 instances)
  L2:                     3 MiB (6 instances)
  L3:                     36 MiB (6 instances)
​￼NUMA:                     
  NUMA node(s):           1
  NUMA node0 CPU(s):      0-5
​￼Vulnerabilities:          
  Gather data sampling:   Not affected
  Itlb multihit:          Not affected
  L1tf:                   Not affected
  Mds:                    Not affected
  Meltdown:               Not affected
  Mmio stale data:        Not affected
  Reg file data sampling: Not affected
  Retbleed:               Not affected
  Spec rstack overflow:   Not affected
  Spec store bypass:      Not affected
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:             Mitigation; Retpolines; STIBP disabled; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
  Srbds:                  Not affected
  Tsx async abort:        Not affected
```

### nproc

To find out how many logical cores are available.

```bash
@masterhost:~$ nproc
6
```

### egrep -c '(vmx|svm)' /proc/cpuinfo

To check if the CPU supports virtualization (Intel VT-x or AMD-V).
￼
```bash
@masterhost:~$ egrep -c '(vmx|svm)' /proc/cpuinfo
6
```

A result greater than zero indicates that virtualization is supported.

## RAM

### free -h
To view the total and available RAM memory.

```bash
@masterhost:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:            11Gi       557Mi        10Gi       1.4Mi       563Mi        11Gi
Swap:            9Gi          0B         9Gi
```

### grep MemTotal /proc/meminfo

To see only the total memory in KB.

```bash
@masterhost:~$ grep MemTotal /proc/meminfo
MemTotal:       12208544 kB
```

## Disks

### lsblk -f

To list disks, partitions, sizes, and mount points:

```bash
@masterhost:~$ lsblk -f
NAME   FSTYPE FSVER LABEL UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda                                                                           
├─sda1 vfat   FAT32       F319-C6F1                                 1G     1% /boot/efi
├─sda2 ext4   1.0         36754b0d-deae-442d-aa0e-8b6ec1d24ea2   43.2G     7% /
├─sda3 ext4   1.0         28b14b85-c7c2-4d10-8467-613982d24da7   74.2G     0% /home
├─sda4 swap   1           82c5bb0c-895a-4edf-b925-4ddbb42ddbc3                [SWAP]
└─sda5 ext4   1.0         3b74329b-f9f5-4822-9cea-720036c8bbf2  737.4G     0% /mnt/vmstorage
```

### df -h

To check current filesystem usage.

```bash
@masterhost:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           1.2G  1.4M  1.2G   1% /run
efivarfs         64K   62K     0 100% /sys/firmware/efi/efivars
/dev/sda2        49G  3.3G   44G   7% /
tmpfs           5.9G     0  5.9G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sda3        79G   64K   75G   1% /home
/dev/sda1       1.1G  6.2M  1.1G   1% /boot/efi
tmpfs           1.2G   12K  1.2G   1% /run/user/1000
/dev/sda5       777G   28K  738G   1% /mnt/vmstorage
```

## Hardware Summary Utility

Before provisioning virtual machines, it’s important to understand the physical
capabilities of your host system. [This script](./scripts/summary_resources.sh)
provides a quick summary of your hardware resources, including:

- CPU model, core count, and virtualization support
- Total and available RAM
- Attached disks and partition layout
- Filesystem usage

You can use this utility to ensure your system is ready for virtualization.

### How to Use

To run a Bash script on Linux, follow
[this documentation.](./how_to_run_a_sh_script.md)
