#!/bin/bash
# ==============================================================================
# SCRIPT: wol.sh
# DESCRIZIONE: Invia un Magic Packet (Wake-on-LAN) al MAC address del NAS.
# DIPENDENZE: Richiede il pacchetto 'wakeonlan' (sudo apt install wakeonlan).
# UTILIZZO: ./wol.sh
# ==============================================================================

MAC="xx:xx:xx:xx:xx:xx"
BROADCAST="192.168.1.255"

# Verifica se il pacchetto wakeonlan è installato
if ! command -v wakeonlan &> /dev/null; then
    echo "Errore: 'wakeonlan' non è installato."
    echo "Sui sistemi Debian-based usa: sudo apt update && sudo apt install wakeonlan"
    exit 1
fi

# Invio pacchetto
wakeonlan -i "$BROADCAST" "$MAC"

if [ $? -eq 0 ]; then
    echo "Pacchetto inviato con successo a $MAC."
    echo "Il NAS dovrebbe avviarsi entro 60 secondi."
else
    echo "Errore durante l'invio del pacchetto."
fi