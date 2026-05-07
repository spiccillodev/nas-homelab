# Setup: Infrastruttura di Accesso Remoto con Tailscale

## Overview

Tailscale è stato implementato per fornire accesso remoto sicuro all'infrastruttura NAS senza esporre direttamente servizi su Internet pubblico.

La soluzione consente accesso cifrato da più dispositivi — inclusi smartphone, laptop e desktop — tramite una rete privata mesh VPN basata su WireGuard.

📚 References:

- Tailscale Official: <https://tailscale.com/>
- Tailscale Knowledge Base: <https://tailscale.com/kb/>
- Tailscale Installation Guide: <https://tailscale.com/kb/1017/install>

---

# 1. Perché Tailscale

Le soluzioni tradizionali di accesso remoto richiedono spesso:

- Port forwarding
- Esposizione del Public IP
- Configurazione di Dynamic DNS
- Gestione aggiuntiva del firewall

Per evitare queste limitazioni e ridurre l'esposizione della attack surface, Tailscale è stato scelto come layer principale di networking remoto.

## Advantages

- Mesh VPN zero-configuration
- Supporto NAT traversal
- Nessuna esposizione di porte pubbliche
- Connessioni end-to-end encrypted
- Compatibilità cross-platform
- Deployment rapido anche su hardware legacy

---

# 2. Installazione

## Installazione di Tailscale

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

📚 Reference:

- Tailscale Download: <https://tailscale.com/download/linux>

---

# 3. Authentication & Node Registration

Dopo l'installazione:

```bash
sudo tailscale up
```

L'autenticazione avviene tramite browser con login al proprio account Tailscale.

Una volta autenticato, il NAS entra a far parte della rete privata Tailnet.

## Verifica Connessione

```bash
tailscale status
```

Questo comando permette di verificare:

- dispositivi connessi
- hostname registrati
- IP assegnati dalla VPN mesh

---

# 4. Strategia di Accesso

## Dispositivi Connessi

- Smartphone
- Laptop
- Desktop workstation

## Metodi di Remote Management

- Accesso SSH tramite Termius
- OpenMediaVault Web UI
- Accesso diretto tramite IP privato Tailscale

---

# 5. DNS & Hostname Configuration

Per semplificare l'accesso remoto, è stata adottata una strategia basata su hostname personalizzato invece di affidarsi agli IP dinamici assegnati dalla VPN.

## MagicDNS

È stato utilizzato MagicDNS per risolvere automaticamente i nodi della Tailnet tramite hostname leggibili.

### Example

```text
nas-server.tailnet-name.ts.net
```

Questo approccio evita la necessità di ricordare IP che possono cambiare nel tempo.

📚 Reference:

- MagicDNS: <https://tailscale.com/kb/1081/magicdns>

---

# 6. Security Considerations

## Miglioramenti di Sicurezza rispetto all'Esposizione Tradizionale

- Nessuna porta aperta sul router
- Nessun servizio SSH esposto pubblicamente
- Nessuna esposizione DNS esterna
- Traffico cifrato tramite tunnel basato su WireGuard

Questo riduce significativamente la superficie di attacco rispetto a un'esposizione tradizionale tramite port forwarding.

## SSH Authentication

Inizialmente veniva utilizzata autenticazione tramite password, successivamente sostituita con SSH key authentication per migliorare sicurezza e usabilità.

### Vantaggi delle SSH Keys

- Eliminazione dell'inserimento manuale della password
- Maggiore sicurezza contro brute-force attacks
- Workflow più rapido da dispositivi mobili

📚 References:

- SSH with Tailscale: <https://tailscale.com/kb/1193/tailscale-ssh>
- OpenSSH Manual: <https://www.openssh.com/manual.html>

---

# 7. Mobile Remote Administration

La gestione remota veniva effettuata anche direttamente da smartphone tramite il client SSH Termius.

Questo permetteva:

- System monitoring
- Modifiche di configurazione
- Remote troubleshooting
- Operazioni di power management
- Gestione rapida del NAS anche fuori rete locale

📚 Reference:

- Termius: <https://termius.com/>

---

# 8. Trade-offs & Limitations

## Advantages

- Deployment estremamente semplice
- Accesso remoto sicuro
- Configurazione di rete minima
- Nessuna necessità di Public IP statico

## Limitations

- Dipendenza da coordination servers di terze parti
- Leggero overhead di latenza
- Prestazioni limitate dall'hardware legacy del NAS

---

# 9. Lessons Learned

- Le architetture mesh VPN semplificano enormemente il networking in ambienti homelab
- L'amministrazione remota può essere realizzata in modo sicuro senza esposizione pubblica
- I workflow basati su SSH diventano significativamente più efficienti nel tempo
- Soluzioni moderne come Tailscale permettono di ottenere funzionalità enterprise anche su hardware economico o legacy
