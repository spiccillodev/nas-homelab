# Network Configuration

## Local Setup

- Wired LAN connection
- Router-based network
- Static IP recommended for NAS

## Remote Access

- Tailscale VPN mesh network
- SSH access enabled

## Security

- No exposed ports
- Access only via VPN
- SSH key authentication
- Custom local DNS naming for ease of access

# Mermaid tecnico
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