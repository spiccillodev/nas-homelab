# Analisi Hardware e Troubleshooting

## 💻 Hardware Host: Legacy Laptop Platform

Il cuore del progetto è un vecchio desktop e un laptop basati rispettivamente su architettura Intel Pentium/Atom, recuperato per scopi di decommissioning attivo.

### Specifiche Tecniche

- *# Hardware NAS Homemade

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
- Designed for low-power office/business systems

---

## CPU

### Installed Processor

- Brand: Intel
- Family: Intel Pentium
- Architecture: x86_64
- Socket: LGA775
- Estimated Frequency: ~2.0–2.8 GHz
- Core Count: 1–2 cores
- Estimated TDP: 35W–65W

### Characteristics

- Designed for office and entry-level desktop systems
- Low power consumption compared to high-end CPUs of the era
- Suitable for lightweight NAS and homelab workloads
- Supports basic multitasking and network services

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

### Full RAM Label

Samsung 1GB 1Rx8 PC2-5300U-555-12-ZZ  
M378T2863RZS-CE6

---

## Power Supply

- OEM Manufacturer: Lenovo / IBM
- FRU Part Number: 41N3479
- P/N: 41N3480
- Revision: REV 01
- Manufacturing Date: 2008-02-27
- Origin: China

## Network (Ethernet)

- Speed: 10/100 Mbps (Fast Ethernet)
- Standard: IEEE 802.3u

---

### Notes

- OEM business-class power supply
- Intended for Lenovo ThinkCentre systems
- Suitable for low-power NAS operation

---

## General NAS Characteristics

### Advantages

- Very low acquisition cost
- Recycled legacy hardware
- Low idle power consumption
- Good for lightweight self-hosting services
- Excellent learning platform for homelab experimentation

### Limitations

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

## 🛠 Sfide Tecniche e Soluzioni (Hardware Hacking)

### 1. Il problema della Batteria Tampone (CMOS)

**Sintomo:** Ad ogni distacco della corrente, il BIOS perdeva le impostazioni (data, ora e priorità di boot), rendendo impossibile l'avvio headless automatizzato.
**Diagnosi:** Socket della batteria CMOS danneggiato e batteria esausta.
**Soluzione:**

- Sostituzione della cella CR2032.
- **Hardware Mod:** Poiché i pin del socket non facevano più pressione, è stata applicata una soluzione meccanica di fortuna (pressione calibrata tramite spessore isolante non conduttivo — lo "stuzzicadenti tecnico") per garantire la continuità elettrica.
- **Risultato:** Persistenza dei dati CMOS ripristinata al 100%.

### 2. Gestione Energetica Ibrida (Power Management)

**Sfida:** Il sistema doveva essere acceso/spento remotamente, ma il Wake-on-LAN (WoL) si è rivelato instabile su questa scheda madre legacy.
**Soluzione:**

- Configurazione BIOS: `Restore on AC Power Loss` impostato su **[Always On]**.
- Integrazione domotica: Il NAS è collegato a una **Presa Smart**.
- **Flusso operativo:** Spegnimento via software (SSH `poweroff`). Per il riavvio, viene tolta e ridata tensione tramite l'app della presa smart, forzando il boot hardware immediato.

---

## 📉 Analisi dei Limiti e Decisioni Strategiche

Durante la fase di test, è stata valutata l'espansione della RAM a 2GB o 4GB per supportare stack più complessi (Docker, Nextcloud).

**Analisi Costi-Benefici:**

- **Costo RAM DDR2:** Prezzi di mercato sproporzionati per componenti obsoleti (fine serie).
- **Consumo Energetico:** Il rapporto performance/watt non giustificava un investimento economico ulteriore.
- **Decisione:** Mantenere il sistema "minimal" con OMV e CLI pura, posticipando l'espansione alla **Roadmap V2** (Migrazione su architettura x64 moderna / Micro-ATX).

---

## 📋 Stato dei Componenti

| Componente | Stato | Note |
| :--- | :--- | :--- |
| Disco 230GB | 🟢 Ottimo | Formattato NTFS per portabilità dati |
| Raffreddamento | 🟡 Monitorato | Pulizia ventole effettuata, pasta termica sostituita |
| Alimentatore | 🟢 Stabile | Originale del laptop, testato sotto carico |
