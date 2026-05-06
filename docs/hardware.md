# Analisi Hardware e Troubleshooting

## 💻 Hardware Host: Legacy Laptop Platform

Il cuore del progetto è un vecchio desktop e un laptop basati rispettivamente su architettura Intel Pentium/Atom, recuperato per scopi di decommissioning attivo.

### Specifiche Tecniche

- **CPU:** Intel Pentium / Atom (Single/Dual Core legacy)
- **RAM:** 1GB DDR2 (2x512MB)
- **Storage:** HDD 230GB SATA (ex-laptop Atom)
- **Networking:** Ethernet 10/100 Mbps

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
