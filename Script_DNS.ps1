# Définition des paramètre IP statique
$ipv4Address = "192.168.1.100"
$subnetMask = "255.255.255.0"
$defaultGateway = "192.168.1.1"
$dnsServer = "127.0.0.1" # Adresse IP du serveur DNS local


# Configuration de l'adresse IP statique sur la carte réseau
Write-Output "Configuration de l'adresse IP statique sur la carte réseau..."
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $ipv4Address -Prefix 24 -DefaultGateway $defaultGateway


# Configurer les serveurs DNS
Write-Output "Configuration des serveurs DNS..."
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $dnsServer