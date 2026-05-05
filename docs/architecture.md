# System Architecture

## Overview

This NAS homelab is built using repurposed legacy hardware to provide low-cost, self-hosted storage.

## Components

- NAS Node: Intel Pentium running OpenMediaVault
- Storage Expansion: Disk from Intel Atom laptop
- Network: LAN via router
- Remote Access: Tailscale VPN

## Data Flow

Client → Router → NAS → Storage Disk

## Key Goals

- Low resource usage
- Stability over performance
- Remote accessibility
