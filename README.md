# foralyse for xubuntu 22.04 jammy

This bash scripts build a virtual machine dedicated to digital forensic investigations.

The objectives of this project are to provide basic tools in forensic analysis in a scalable and lightweight environment.

## Requires

- A host with qemu/kvm installed (easier use with GUI virt-manager)
- The latest ISO image of xubuntu 20.04 focal

## Results

- A Vitual Machine for numeric forensic tools to analyse :
    - disk
    - memory
    - network
    - malware (static analysis)

- A shared path between host and guest (manual mount)
- A script nbd.sh to mount all partitions of dumped disk ( raw, qcow, qcow2, qed, parallels, vhdx, vmdk, vdi )
- A script mount-cases.sh to automaticaly mounts all founded cases devices

## Tools

#### terminal

- Binary
    - balbuzard
    - binwalk
    - bsdiff
    - pedis pehash peres pesec pescan readpe rva2ofs
    - r2env
    - radare2
    - vbindiff

- Hive
    - chntpw reged sampasswd
    - hivexget hivexsh hivexml
    - malcarve
    - reglookup
    - regripper
    - regrippy

- Network
    - tshark
    - whois

- Others
    - base64sha

#### GUI

- Binary
    - bless
    - geany
    - ghex
    - gtkhash
    - wxhexeditor

- Disk
    - autopsy

- Malware
    - bytecode
    - cfr
    - idafree
    - luyten
 
- Memory
    - volatility 2 v2.6.1
    - volatility 3 v2.0.1

- Network
    - wireshark

## Installation

#### Host

```bash
git clone https://github.com/aguytech/foralyse
cd foralyse/host
bash host.sh
```

#### Guest

```bash
git clone https://github.com/aguytech/foralyse
cd foralyse/guest
bash guest.sh
```
