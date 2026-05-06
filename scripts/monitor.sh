#!/bin/bash
# ==============================================================================
# SCRIPT: monitor.sh
# DESCRIZIONE: Monitoraggio proattivo delle risorse hardware e dei servizi core.
#              Ottimizzato per sistemi con risorse limitate (1GB RAM).
# AUTORE: [Il Tuo Nome/Username GitHub]
# REQUISITI: Accesso sudo per il controllo dei servizi systemd.
# ==============================================================================

# Soglia critica RAM (es. 100MB su 1GB totale)
THRESHOLD=100

echo "--- NAS Health Check [$(date)] ---"

# 1. Controllo RAM Libera
FREE_RAM=$(free -m | awk '/^Mem:/{print $4}')
echo "RAM Libera: ${FREE_RAM}MB"

if [ "$FREE_RAM" -lt "$THRESHOLD" ]; then
    echo "WARNING: Memoria RAM sotto la soglia critica ($THRESHOLD MB)!"
fi

# 2. Controllo Stato Servizi
SERVICES=("smbd" "tailscaled")

for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SERVICE"; then
        echo "Servizio $SERVICE: Attivo"
    else
        echo "Servizio $SERVICE: NON ATTIVO"
    fi
done

# 3. Carico CPU (Load Average)
LOAD=$(uptime | awk -F'load average:' '{ print $2 }')
echo "Carico CPU:$LOAD"