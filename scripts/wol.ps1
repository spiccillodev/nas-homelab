<#
.SYNOPSIS
    Script per l'invio del Magic Packet (Wake-on-LAN) via UDP.
    
.DESCRIPTION
    Permette l'accensione remota del NAS da client Windows. 
    Include note sulla compatibilità Layer 2/Layer 3 (Tailscale).

.NOTES
    Autore: [Il Tuo Nome/Username GitHub]
    Data: 2024
#>

$mac = "xx:xx:xx:xx:xx:xx"    # Inserire il MAC reale del NAS
$broadcast = "192.168.1.255"  # IP Broadcast della rete locale
# NOTA: Il WoL via Tailscale richiede un bridge o un "exit node" attivo nella LAN 
# poiché il protocollo WoL (Layer 2) non attraversa nativamente le subnet Layer 3.
$port = 9 # porta standard per WoL 

$macBytes = ($mac -split "[:-]") | ForEach-Object { [byte] "0x$_" }
$packet = (,[byte]255 * 6) + ($macBytes * 16)

try {
    $udp = New-Object System.Net.Sockets.UdpClient
    $udp.Send($packet, $packet.Length, $broadcast, $port)
    $udp.Close()
    Write-Host "Pacchetto Wake-on-LAN inviato con successo a $mac" -ForegroundColor Green
    Write-Host "[ℹ] Nota: Assicurarsi di essere connessi alla LAN o di avere un bridge VPN attivo." -ForegroundColor Cyan
}
catch {
    Write-Host "Errore durante l'invio del pacchetto: $($_.Exception.Message)" -ForegroundColor Red
}git commit -m "feat(scripts): add native bash script for LAN wake-up"