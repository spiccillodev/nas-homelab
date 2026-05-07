#!/bin/bash
# ==============================================================================
# SCRIPT: backup.sh
# DESCRIZIONE: Backup compresso delle configurazioni critiche (Samba, fstab, etc).
#              Implementa una politica di rotazione dei log/backup di 7 giorni.
# DESTINAZIONE: /media/storage/backups/system_config
# AUTORE: [Il Tuo Nome/Username GitHub]
# ==============================================================================

BACKUP_DIR="/media/storage/backups/system_config"
DATE=$(date +%Y-%m-%d)
FILENAME="nas_config_backup_$DATE.tar.gz"

echo "Avvio backup delle configurazioni di sistema..."

# Creazione cartella di destinazione se non esiste
[ ! d "$BACKUP_DIR" ] && mkdir -p "$BACKUP_DIR"

# Creazione dell'archivio (configurazioni chiave)
# - Samba: per non dover rifare gli share
# - fstab: per i punti di montaggio dei dischi
# - crontab: per le automazioni pianificate
sudo tar -czf "$BACKUP_DIR/$FILENAME" \
    /etc/samba/smb.conf \
    /etc/fstab \
    /etc/network/interfaces \
    2>/dev/null

if [ $? -eq 0 ]; then
    echo "Backup completato: $BACKUP_DIR/$FILENAME"
    # Log rotation
    find "$BACKUP_DIR" -name "*.tar.gz" -mtime +7 -delete
    echo "Pulizia vecchi backup completata."
else
    echo "Errore durante la creazione del backup."
fi