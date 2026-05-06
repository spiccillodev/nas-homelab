# Setup: Lubuntu Headless & System Optimization

## Overview

Il sistema base è costruito su **Lubuntu 22.04 LTS** *(Ubuntu/Debian-based)*, scelto per il suo **footprint leggero** e l’elevata compatibilità con hardware legacy.

Invece di utilizzare la ISO ufficiale di **OpenMediaVault**, è stata preferita un’installazione minimale del sistema operativo per garantire maggiore **stabilità**, controllo sulle risorse e configurazione personalizzata.

## References

- Lubuntu Official Website: <https://lubuntu.me/>
- Ubuntu Installation Guide: <https://ubuntu.com/tutorials/install-ubuntu-desktop>

---

# 1. Minimal Installation Strategy

### Base Configuration

- **OS:** Lubuntu 22.04 LTS  
- **Installation Type:** Standard Installation  
- **Post-installation Goal:** conversione in **headless server**

Dopo l’installazione:

```bash
sudo apt update && sudo apt upgrade -y
```

---

# 2. Headless Mode Configuration

Per ridurre il consumo di memoria, l’ambiente grafico è stato disabilitato.

## Switch to Multi-User Target (*No GUI*)

```bash
sudo systemctl set-default multi-user.target
```

## Optional: Remove GUI Packages

```bash
sudo apt purge lubuntu-desktop -y
sudo apt autoremove -y
```

## Reference

- systemctl documentation: <https://www.freedesktop.org/software/systemd/man/systemctl.html>

---

# 3. Resource Optimization (*RAM Management*)

Hardware disponibile:

- **RAM:** 1GB DDR2

A causa delle limitazioni hardware, è stata necessaria una forte ottimizzazione.

---

## 3.1 Disable Unnecessary Services

Disabilitazione di servizi non necessari per ridurre utilizzo CPU e RAM.

```bash
sudo systemctl disable cups.service
sudo systemctl disable bluetooth.service
sudo systemctl disable avahi-daemon.service
```

### Disabled Services

| Service | Purpose | Reason |
|---|---|---|
| **cups** | Printing service | Non necessario per NAS |
| **bluetooth** | Bluetooth management | Inutile in modalità headless |
| **avahi-daemon** | mDNS / Zeroconf | Opzionale |

## References

- Debian systemd wiki: <https://wiki.debian.org/systemd>  
- CUPS documentation: <https://www.cups.org/doc/man-cupsd.html>  
- Avahi documentation: <https://www.freedesktop.org/wiki/Software/Avahi/>

---

## 3.2 Swap File Configuration (*Virtual Memory*)

Per prevenire crash sotto pressione di memoria è stato configurato uno **swap file**.

### Create Swap File

```bash
sudo fallocate -l 2G /swapfile
```

### Set Secure Permissions

```bash
sudo chmod 600 /swapfile
```

### Enable Swap

```bash
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Persist After Reboot

```bash
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

## Reference

- Ubuntu Swap Guide: <https://help.ubuntu.com/community/SwapFaq>

### Notes

- Lo swap migliora la **stabilità** su sistemi low-memory  
- Prestazioni limitate da **HDD meccanico**  
- Non adatto a workload ad alto I/O  

---

# 4. Storage Configuration (*NTFS Disk*)

Disco utilizzato:

- **Capacity:** 230GB  
- **Filesystem:** NTFS  
- **Origin:** recuperato da laptop legacy  

Il disco non veniva rilevato automaticamente da OpenMediaVault.

---

## 4.1 Identify Disk

```bash
lsblk
blkid
```

---

## 4.2 Create Mount Point

```bash
sudo mkdir -p /mnt/storage
```

---

## 4.3 Configure Mount via fstab

Esempio configurazione:

```fstab
UUID=XXXX-XXXX /mnt/storage ntfs-3g defaults,uid=1000,gid=1000 0 0
```

## References

- fstab manual: <https://man7.org/linux/man-pages/man5/fstab.5.html>  
- ntfs-3g project: <https://github.com/tuxera/ntfs-3g>  

---

## 4.4 Mount Disk

```bash
sudo mount -a
```

---

## 4.5 Set Permissions

```bash
sudo chmod -R 775 /mnt/storage
```

---

# 5. Design Considerations

## Why Lubuntu Instead of OpenMediaVault ISO

### Advantages

- **Better compatibility** con hardware legacy  
- **Lower resource usage**  
- Maggiore controllo configurazione sistema  

### Trade-offs

- Setup più manuale  
- Maggiore complessità iniziale  
- Minore automazione rispetto a distro NAS preconfigurate  

---

# 6. Known Limitations

- **1GB DDR2 RAM** estremamente limitante  
- Uso swap introduce **latenza significativa**  
- **NTFS** non ideale per NAS Linux  
- Scalabilità limitata per servizi self-hosted moderni  

---

# 7. Lessons Learned

- Sistemi minimali offrono maggiore stabilità su hardware legacy  
- Configurazione **headless** essenziale in ambienti low-RAM  
- Lo storage richiede spesso configurazione manuale in setup non standard  
- Lo **swap** è una soluzione di emergenza, non un boost prestazionale  

---

## Final Result

Sistema finale:

- **Lubuntu 22.04 LTS**
- **Headless server**
- **Swap enabled**
- **NTFS storage mounted**
- **Services minimized**
- **Legacy hardware optimized**
