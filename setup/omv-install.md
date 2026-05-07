# Setup: OpenMediaVault (OMV) Installation

Invece di utilizzare l’immagine ISO preconfigurata, è stata scelta un’installazione di **OpenMediaVault (OMV)** sopra una base pulita di **Lubuntu**.

Questa decisione consente:

- maggiore **controllo sui driver** per hardware legacy  
- migliore **gestione delle risorse**  
- maggiore **flessibilità di configurazione**  

---

# 1. Installazione via Script

Per l’installazione è stato utilizzato lo script ufficiale compatibile con sistemi **Debian-based**.

## Download & Execution

```bash
wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash
```

---

## Notes

- Lo script esegue automaticamente:
  - installazione dei pacchetti OMV  
  - configurazione dei repository  
  - setup iniziale del sistema  

- È richiesto:
  - **accesso root / sudo**
  - connessione internet attiva  

- Tempo di installazione variabile in base a:
  - velocità disco *(HDD vs SSD)*  
  - performance CPU  

---

## Post-Installation

Al termine dell’installazione:

- Il sistema sarà accessibile via interfaccia web  
- Default access:
  - **URL:** `http://<IP-del-server>`  
  - **Username:** `admin`  
  - **Password:** `openmediavault`  

---

## Security Recommendation

Dopo il primo accesso:

- Cambiare immediatamente la **password di default**  
- Verificare aggiornamenti disponibili  
- Configurare accessi e permessi  

---

## References

- OMV Install Script: https://github.com/OpenMediaVault-Plugin-Developers/installScript  
- OpenMediaVault Official: https://www.openmediavault.org/
- OMV Documentation: https://docs.openmediavault.org/en/latest/installation/