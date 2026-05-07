# Network Infrastructure & Connectivity

[!NOTE]
> In questa sezione viene documentata la strategia di accesso remoto. Viene descritta l'architettura di rete adottata, le tecnologie VPN utilizzate e le soluzioni per garantire un accesso sicuro e senza interruzioni da dispositivi mobili e laptop esterni alla rete locale.

## Strategia di Accesso Remoto

La sfida principale è stata garantire l'accesso al NAS da smartphone e laptop esterni alla rete locale senza esporre il dispositivo a attacchi diretti.

### VPN(Tailscale)

Invece di utilizzare il port forwarding sul router (che espone la porta SSH o HTTP al pubblico), è stata implementata una **Mesh VPN basata su Tailscale (WireGuard)**.

- **Vantaggio:** Il NAS non ha porte aperte verso l'esterno.
- **MagicDNS:** Configurato per assegnare un nome mnemonico (es. `nas-homelab`) al posto dell'IP dinamico della VPN.

---

### Configurazione LAN Locale

- **IP Statico:** Assegnato a livello di router per garantire che la WebUI di OMV e l'accesso SSH siano sempre raggiungibili allo stesso indirizzo all'interno della rete domestica.
- **DNS Locale:** Implementato per facilitare il mapping dei servizi senza dover ricordare gli indirizzi IP.

---

## 01. Rete e Accesso Remoto

- Tailscale sempre attivo come VPN mesh
- SSH accessibile sia tramite IP locale sia hostname Tailscale
- Web UI OMV raggiungibile tramite DNS interno su Tailscale per evitare uso diretto di IP

---

## 02. Gestione Remota (Termius)

Per la gestione in mobilità, è stato scelto **Termius** (sfruttando il GitHub Student Developer Pack).

- **Integrazione:** Le chiavi SSH sono sincronizzate tra i dispositivi.
- **Accessibilità:** Possibilità di monitorare i log di sistema e gestire i file tramite SFTP direttamente da smartphone sotto rete 5G via Tailscale.

---

### 03. Sicurezza e Accesso

- Implementato **Fail2Ban** per limitare tentativi di brute force su SSH.
- SSH utilizzato sia in locale (PC principale Windows) sia in remoto tramite Tailscale.
- Accesso remoto usato solo quando necessario, mantenendo il sistema non esposto su Internet.

---

### 04. Sistema e Software NAS

- Sistema operativo: **Lubuntu Server 22.04 LTS**
- Gestione NAS: **OpenMediaVault (OMV)**

OMV utilizzato principalmente per:

- dashboard di controllo
- gestione servizi base
- monitoraggio sistema

Servizi attivi:

- **Samba** per condivisione file (unico servizio attivo per limiti hardware)

---

### 05. Gestione Storage

- Nessun RAID configurato per limiti hardware
- Dischi gestiti come volume logico unico
- Integrazione del disco del laptop come storage secondario virtuale
- Gestione completamente manuale da terminale

---

### 06. Prestazioni

- Connessione: Ethernet 100 Mbps
- Velocità limitata da rete e hardware legacy
- Sistema stabile ma con throughput ridotto sotto carico
- CPU raramente in saturazione, limite principale su rete e dischi

---

### 07. Modalità Operativa

- Nessuna automazione tramite script
- Gestione interamente manuale:
  - SSH
  - OMV WebUI
- Monitoraggio remoto solo da smartphone quando fuori casa