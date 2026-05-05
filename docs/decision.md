# Engineering Decisions

## Why this project exists

The project was created to eliminate dependency on paid cloud storage services and to explore self-hosted infrastructure.

## Why OpenMediaVault

Selected for its simplicity, low resource consumption, and ease of configuration on legacy hardware.

## Why Tailscale

Chosen to avoid port forwarding and reduce security risks while enabling remote access.

## Why SSH keys

Replaced password authentication to improve security and usability across multiple devices.

## Trade-offs

- Low performance due to hardware constraints
- Limited scalability
- Some modern self-hosted platforms not usable

## Lessons Learned

- Legacy hardware can still be useful for infrastructure learning
- Networking concepts become much clearer in real environments
- Remote system design requires balancing security and usability