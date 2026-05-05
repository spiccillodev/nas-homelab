# NAS Homelab – Self-Hosted Storage Infrastructure (DIY Project)
![Status](https://img.shields.io/badge/status-active-brightgreen)
![Project](https://img.shields.io/badge/project-NAS%20Homelab-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Version](https://img.shields.io/badge/version-v0.1--beta-orange)
![Platform](https://img.shields.io/badge/platform-Linux-lightgrey)

## Overview

This project is a self-hosted NAS system built using repurposed legacy hardware.  
Its primary goal is to replace commercial cloud storage services (Google Drive, iCloud) with a private, always-available storage solution accessible locally and remotely.

The project was also designed as a learning environment to explore networking, Linux system administration, and remote infrastructure management.

---

## 🎯 Objectives

- Create a private always-on storage system
- Replace paid cloud storage services
- Enable remote access from multiple devices (PC, smartphone)
- Learn Linux, networking, and system administration
- Maximize usage of obsolete hardware

---

## 🧱 System Architecture

- Main NAS: Intel Pentium desktop (OpenMediaVault)
- Storage expansion: 230GB HDD from Intel Atom laptop (NTFS)
- Network: LAN connection via router (static IP)
- Remote access: Tailscale VPN (mesh network)
- SSH access: Termius (mobile + desktop)

## 📊 System Architecture

![NAS Architecture](media/diagrams/nas-architecture.png)
---

## 🌐 Remote Access Strategy

- Tailscale used for secure private networking
- Custom local DNS naming for easier access
- No public port forwarding
- Access from:
  - Laptop
  - Desktop
  - Smartphone

---

## 🔐 Security Approach

- SSH key-based authentication (replaced password login)
- No exposed router ports
- VPN-only access via Tailscale

---

## ⚙️ Power Management

- Wake-on-LAN enabled
- Smart plug used for remote power control
- BIOS configured to allow automatic wake on power events

---

## ⚠️ Limitations

- Very low hardware performance (1GB RAM DDR2 system)
- Storage expansion limited
- Some self-hosted solutions (Nextcloud, TrueNAS) not feasible
- Hardware upgrade required for scalability

---

## 🚀 Future Improvements

- Migration to Micro-ATX / Mini-ITX system
- Upgrade RAM and storage
- Deploy TrueNAS SCALE
- Add proper containerized services (Docker / Kubernetes)