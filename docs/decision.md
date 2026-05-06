# Engineering Decisions & Architecture Records

In questa sezione vengono documentate le scelte architetturali critiche, analizzando le motivazioni tecniche, i compromessi (trade-offs) e le alternative considerate.

---

## 🏗️ 01. Selezione del Software di Gestione: OpenMediaVault

**Contesto:** Hardware estremamente limitato (1GB RAM DDR2, CPU legacy).

- **Decisione:** Utilizzo di **OpenMediaVault (OMV)** su base Lubuntu Headless.
- **Motivazione:** OMV offre un framework leggero per la gestione dei servizi NAS (SMB, permessi, monitoraggio) senza l'overhead di sistemi più moderni come TrueNAS SCALE (che richiede minimo 8GB di RAM).
- **Compromesso:** Rinuncia alla containerizzazione massiva (Docker) per preservare la stabilità del kernel e la memoria swap.

---

## 🛡️ 02. Networking & Security: Tailscale vs Port Forwarding

**Contesto:** Necessità di accesso remoto globale senza esporre l'IP pubblico domestico.

- **Decisione:** Implementazione di una **Mesh VPN Zero-Trust** tramite **Tailscale**.
- **Perché:** Il Port Forwarding tradizionale espone la porta 22 (SSH) o 80/443 (WebUI) a scansioni automatizzate e attacchi brute-force. Tailscale utilizza il protocollo WireGuard per creare un tunnel cifrato punto-punto, rendendo il NAS "invisibile" sulla rete pubblica.
- **Vantaggio Extra:** Integrazione fluida con **MagicDNS** per risolvere il NAS con un hostname semplice invece di un indirizzo IP VPN.

---

## 🔑 03. Autenticazione: SSH Key-Based Only

**Contesto:** Gestione del server tramite Termius (Mobile/Desktop).

- **Decisione:** Disabilitazione totale dell'autenticazione via password (`PasswordAuthentication no`).
- **Motivazione:** Le chiavi RSA/Ed25519 offrono una sicurezza crittografica superiore. Questo ha permesso di velocizzare il workflow (niente inserimento manuale della password su smartphone) elevando drasticamente lo standard di sicurezza.

---

## 🔌 04. Power Management: Cold Boot via Smart Plug

**Contesto:** Inaffidabilità del Wake-on-LAN (WoL) su scheda madre legacy.

- **Decisione:** Utilizzo di una **Presa Smart esterna** combinata con la funzione BIOS `Restore on AC Power`.
- **Logica:** Se il sistema deve essere riavviato forzatamente o acceso da remoto dopo un blackout, la presa smart funge da "interruttore fisico digitale", garantendo il boot indipendentemente dallo stato dei pacchetti magic-packet WoL sulla rete.

---

## 📊 Analisi dei Trade-offs (Compromessi)

| Sfida           | Scelta                  | Compromesso                                                       |
| :-------------- | :---------------------- | :---------------------------------------------------------------- |
| **Performance** | Uso di Lubuntu Headless | Assenza di interfaccia grafica, gestione 100% CLI.                |
| **Scalabilità** | Disco singolo NTFS      | Assenza di ridondanza RAID; priorità alla portabilità dei dati.   |
| **Budget**      | Hardware Legacy ($0)    | Impossibilità di eseguire Nextcloud o transcodifica video (Plex). |

---

## 🧠 Lessons Learned

1. **L'hardware legacy non è e-waste:** Con la giusta configurazione software (CLI-first), macchine di 15 anni fa possono gestire infrastrutture di storage sicure.
2. **Security-First Mindset:** La configurazione di Tailscale e delle chiavi SSH ha insegnato che la comodità (accesso da telefono) non deve mai andare a discapito della sicurezza.
3. **Problem Solving Creativo:** Quando gli standard (WoL) falliscono, una soluzione ibrida (Hardware + Software + Domotica) è spesso la via più stabile.
