# Setup: Wake-on-LAN & Remote Power Management

## Overview

Questa documentazione descrive la soluzione ibrida implementata per il **remote power management** del NAS su hardware legacy, combinando configurazioni BIOS, Wake-on-LAN (WoL) e componenti domotici.

A causa delle limitazioni hardware e dell’instabilità del classico approccio basato su *Magic Packet*, è stata progettata una soluzione alternativa fondata sul ripristino automatico dell’alimentazione AC.

##### References:
- https://wiki.archlinux.org/title/Wake-on-LAN  
- https://man7.org/linux/man-pages/man8/ethtool.8.html  

---

# 1. Obiettivi

La soluzione è stata progettata per:

- Accendere il NAS da remoto  
- Ridurre il consumo energetico quando inutilizzato  
- Evitare esposizione di porte pubbliche  
- Mantenere controllo remoto completo del sistema  

---

# 2. Configurazione Hardware (BIOS)

Per rendere il NAS controllabile tramite alimentazione esterna, sono state modificate alcune impostazioni BIOS.

## BIOS Settings

### Enabled Features

- `Restore on AC Power Loss` → **Always On**
- `Wake-on-LAN / WoL Support` → **Enabled**

---

## Funzionamento

Quando l’alimentazione elettrica viene ripristinata, il BIOS esegue automaticamente il boot del sistema senza necessità di pressione fisica del pulsante power.

---

# 3. Troubleshooting Batteria Tampone (Physical Hack)

Durante i test è emerso un problema hardware relativo alla batteria CMOS.

## Problema

Il socket della batteria tampone risultava instabile, causando:

- Reset del BIOS ad ogni perdita di alimentazione  
- Perdita delle configurazioni WoL  
- Reset dell’orario di sistema  

    Questo rendeva inutilizzabile il boot automatico configurato nel BIOS.

---

## Soluzione Implementata

È stato effettuato un intervento fisico temporaneo sul socket CMOS per stabilizzare il contatto della batteria CR2032.

### Intervento

- Inserimento di uno *spessore isolante/meccanico*  
- Stabilizzazione della pressione sul contatto della batteria  
- Ripristino della persistenza delle configurazioni BIOS  

---

## Notes

Pur essendo una soluzione non convenzionale, il workaround ha permesso di mantenere attive le impostazioni di power recovery.

---

# 4. Integrazione Smart Plug

Per compensare i limiti del WoL tradizionale su hardware legacy, è stata integrata una Smart Plug nella catena di alimentazione del NAS.

## Power-On Workflow

1. Attivazione remota della Smart Plug  
2. Ripristino dell’alimentazione AC  
3. Detection evento AC da parte del BIOS  
4. Boot automatico del NAS grazie a `Always On`  

    Questo approccio evita l’uso di soluzioni enterprise come IPMI.

---

# 5. Workflow Operativo

## Spegnimento Remoto

Lo shutdown veniva eseguito tramite SSH:

```bash
sudo poweroff
```

    Reference:
- https://man7.org/linux/man-pages/man8/poweroff.8.html  

---

## Deep Sleep Strategy

Una volta spento il NAS:

- La Smart Plug veniva disattivata  
- Eliminato il consumo passivo dei trasformatori (*Vampire Power*)  

---

## Riaccensione Remota

L’accensione avveniva tramite:

- App della Smart Plug  
- Automazioni domotiche  
- Script remoti  

---

# 6. Wake-on-LAN Utility

Come soluzione secondaria e di backup è stato testato il classico WoL tramite Magic Packet.

## Installazione

```bash
sudo apt install wakeonlan
```

## Example Usage

```bash
wakeonlan <MAC_ADDRESS>
```

    Reference:
- https://linux.die.net/man/1/wakeonlan  

---

# 7. Trade-offs & Limitations

## Advantages

- Nessuna esposizione diretta del router  
- Controllo remoto completo del sistema  
- Riduzione significativa dei consumi energetici  
- Soluzione low-cost e replicabile  

---

## Limitations

- Dipendenza dalla Smart Plug  
- Assenza di hardware enterprise (es. IPMI)  
- Affidabilità limitata dell’hardware legacy  
- Boot più lento rispetto a sistemi moderni  

---

# 8. Lessons Learned

- Anche hardware obsoleto può supportare remote management avanzato  
- Le soluzioni ibride possono sostituire infrastrutture costose  
- Il power management è fondamentale nei sistemi always-on  
- Il troubleshooting hardware reale richiede approcci creativi e non standard  