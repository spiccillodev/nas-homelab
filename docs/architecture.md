# System Architecture

## Overview

The system is composed of repurposed legacy hardware configured into a lightweight NAS infrastructure.

## Logica di Flusso

Il sistema opera come un nodo centrale in una rete a stella:

1. **Data Layer:** Basato su Linux (Lubuntu) con OpenMediaVault per la gestione dei permessi SMB.
2. **Access Layer:** Tunneling cifrato punto-punto tramite Tailscale.
3. **Control Layer:** Amministrazione via SSH (CLI-first).

## Data Flow

Client Device → Tailscale VPN → NAS → Storage Disk

## Design Principles

- Minimal cost
- Hardware reuse
- Remote accessibility without public exposure
- Simplicity over performance

## Architecture Diagram in Mermaid

```mermaid
flowchart TD

Internet[🌍 Internet Private Access]
Tailscale[🔐 Tailscale VPN Mesh]

Router[🌐 Home Router]

NAS[🖥️ NAS Server\nIntel Pentium + OMV]

LaptopDisk[💾 Laptop HDD 230GB]
PS4HDD[🎮 PS4 Recovered HDD]
DesktopHDD[💻 Old Desktop HDD]

Laptop[💻 Laptop SSH]
Phone[📱 Smartphone]
PC[🖥️ Desktop PC]

Internet --> Tailscale
Tailscale --> Router

Router --> NAS

Laptop --> NAS
Phone --> NAS
PC --> NAS

NAS --> LaptopDisk
NAS --> PS4HDD
NAS --> DesktopHDD
```
