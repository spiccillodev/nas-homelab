# Analisi Hardware e Troubleshooting

> [!NOTE]
> In questa sezione viene documentata l'analisi dettagliata dell'hardware utilizzato per il NAS, con un focus sui componenti chiave, le sfide tecniche incontrate e le soluzioni implementate per garantire la stabilità e la funzionalità del sistema. Vengono inoltre evidenziati i limiti intrinseci dell'hardware legacy e le decisioni strategiche adottate per massimizzare le prestazioni all'interno di tali vincoli.

## Hardware Host: Legacy Hybrid Platform

Il progetto NAS è basato su una infrastruttura ibrida composta da:

- Desktop legacy Intel LGA775
- Laptop Intel Atom (utilizzato per test e storage secondario)

L’obiettivo è il riutilizzo di hardware decommissionato per creare un sistema NAS leggero, stabile e modulare.

### 01. Desktop NAS Core System

## Motherboard / Platform

- Platform: Intel LGA775
- Southbridge Chipset: Intel 82801GB ICH7 (SL8FX)
- Super I/O Controller: ITE IT8718F-S
- Form Factor: likely Micro-ATX
- Estimated Production Period: 2007–2008

### Features

- SATA support
- DDR2 memory support
- Legacy BIOS platform
- Wake-on-LAN support (hardware dependent)
- AC Power Recovery support
- Designed for low-power systems

---

## CPU

- Brand: Intel
- Family: Intel Pentium
- Architecture: x86_64
- Socket: LGA775
- Estimated Frequency: ~2.0–2.8 GHz
- Core Count: 1–2 cores
- Estimated TDP: 35W–65W

---

## RAM

### Installed Module

- Brand: Samsung
- Model: M378T2863RZS-CE6
- Capacity: 1 GB
- Memory Type: DDR2 SDRAM
- Speed: 667 MHz
- Standard: PC2-5300U
- Rank Configuration: 1Rx8
- CAS Latency: CL5
- Voltage: 1.8V
- Unbuffered / Non-ECC

*ID RAM*:

``` bash
Samsung 1GB 1Rx8 PC2-5300U-555-12-ZZM378T2863RZS-CE6
```

---

## Power Supply

- OEM Manufacturer: Lenovo / IBM
- FRU Part Number: 41N3479
- P/N: 41N3480
- Revision: REV 01
- Manufacturing Date: 2008-02-27
- Origin: China

## Storage (Desktop NAS)

- HDD principale: 230 GB (recuperato da sistema precedente danneggiato)
- HDD secondario: 500 GB (recuperato da PS4 Slim)
- Interfaccia: SATA (1 linea funzionante stabile)
- Configurazione: adattamento manuale a singolo canale SATA disponibile

### Note tecniche Storage

- Il controller SATA della scheda madre supporta un numero limitato di porte
- Una porta risultava fisicamente danneggiata/non affidabile
- Configurazione finale basata su gestione manuale dei dischi
- Il disco da 230 GB è stato formattato in NTFS per garantire portabilità e compatibilità con altri sistemi (Windows, Linux)
- Il disco da 500 GB è stato mantenuto come backup secondario, utilizzando quello da 230 GB per il sistema operativo
  
## Network (Ethernet)

- Speed: 10/100 Mbps (Fast Ethernet)
- Standard: IEEE 802.3u

---

# 02. Laptop Intel Atom (Nodo Secondario)

## Hardware Overview

- Architecture: Intel Atom platform
- RAM: 1 GB DDR2/DDR3 (dipende dal modello)
- Storage: 230 GB HDD

## Ruolo nel sistema

- Nodo di test
- Storage secondario su rete
- Ambiente sperimentale per servizi leggeri
- Backup temporaneo o staging data

## 03. General NAS Characteristics

### Pro

- Very low acquisition cost
- Recycled legacy hardware
- Low idle power consumption
- Good for lightweight self-hosting services
- Excellent learning platform for homelab experimentation

### Contro

- Limited RAM capacity
- Old SATA controller generation
- No native NVMe support
- Limited virtualization capabilities
- Lower network throughput compared to modern platforms

---

## Intended Usage

- File storage
- Backup server
- Media server
- Remote access experimentation
- Wake-on-LAN testing
- Homelab learning environment
- Network services and automation

---

## 04. Sfide Tecniche e Soluzioni

### 1. Il problema della Batteria Tampone (CMOS)

__Sintomo:__ Ad ogni distacco della corrente, il BIOS perdeva le impostazioni (data, ora e priorità di boot), rendendo impossibile l'avvio headless automatizzato.
__Diagnosi:__ Socket della batteria CMOS danneggiato e batteria esausta.
__Soluzione:__

- Sostituzione della cella CR2032.
- __Hardware Mod:__ Poiché i pin del socket non facevano più pressione, è stata applicata una soluzione meccanica di fortuna (pressione calibrata tramite spessore isolante non conduttivo — lo "stuzzicadenti tecnico") per garantire la continuità elettrica.
- __Risultato:__ Persistenza dei dati CMOS ripristinata al 100%.

### 2. Gestione Energetica Ibrida

__Sfida:__ Il sistema doveva essere acceso/spento remotamente, ma il Wake-on-LAN (WoL) si è rivelato instabile su questa scheda madre legacy.
__Soluzione:__

- Configurazione BIOS: `Restore on AC Power Loss` impostato su __[Always On]__.
- Integrazione domotica: Il NAS è collegato a una __Presa Smart__.
- __Flusso operativo:__ Spegnimento via software (SSH `poweroff`). Per il riavvio, viene tolta e ridata tensione tramite l'app della presa smart, forzando il boot hardware immediato.

---

## 05. Analisi dei Limiti e Decisioni Strategiche

Durante la fase di test, è stata valutata l'espansione della RAM a 2GB o 4GB per supportare stack più complessi (Docker, Nextcloud).

__Analisi Costi-Benefici:__

- __Costo RAM DDR2:__ Prezzi di mercato sproporzionati per componenti obsoleti (fine serie).
- __Consumo Energetico:__ Il rapporto performance/watt non giustificava un investimento economico ulteriore.
- __Decisione:__ Mantenere il sistema "minimal" con OMV e CLI pura, posticipando l'espansione alla __Roadmap V2__ (Migrazione su architettura x64 moderna / Micro-ATX).

---

# 06. Stato Componenti

| Componente | Stato      | Note |
|------------|------------|------|
| HDD 230GB  | 🟢 Attivo  | Recuperato da sistema danneggiato |
| HDD 500GB | 🟢 Attivo | Recuperato da PS4 Slim |
| RAM | 🟢 Stabile | 1GB DDR2 Samsung |
| Raffreddamento | 🟡 Monitorato | Pulizia + pasta termica sostituita |
| Alimentatore | 🟢 Stabile | OEM Lenovo originale |
| Ethernet | 🟡 Limitato | 100 Mbps |
