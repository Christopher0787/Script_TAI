# Mettre a jour le système et installer le rôle DHCP
Write-Output "Mise à jour le système et installation de rôle DHCP..."
$installResult = Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Vérifier et le redémarrage est nécessaire
if ($installResult.RestartNeeded -eq "Oui") {
    Write-Output "Un redémarrage est nécessaire pour terminer l'installation. Le serveur va redémarrer..."
    # Renommer le serveur en SRV-DHCP avant de redémarrer
    Rename-Computer -NewName "SRV-DHCP" -Force
    # Le script s'arrête ici, et vous devez redémarrer manuellement le serveur.
    Restart-Computer
    exit 
}

#*****************************************************************************************#

# Inportation du module DHCP
Import-Module DhcpServer

# Vérification de l'installation du rôle DHCP
if (!(Get-WindowsFeature DHCP -ErrorAction Stop)) {
    Write-Error "Le rôle DHCP n'est pas installé."
    exit 1
}

# Configuration des variables pour la nouvelle étendue DHCP
$ScopeStartAddress = "192.168.1.50"
$ScopeEndAddress = "192.168.1.254"
$ScopeSubnetMask = "255.255.255.0"
$DefaultGateway = "192.168.1.1"
$PrimaryDNSServer = "192.168.1.2"
$SecondaryDNSServer = "8.8.8.8"
$LeaseDuration = New-TimeSpan -Hours 8
$ExclusionRangeBegin = "192.168.1.200"
$ExclusionRangeEnd = "192.168.1.210"
$DnsDomainName = "exemple.local"
$ScopeId = @(, $ScopeStartAddress, $ScopeSubnetMask)


# Création d'une nouvelle étendue DHCP
try {
    Add-DhcpServerv4Scope -Name "LAN-Scope" -StartRange $ScopeStartAddress -EndRange $ScopeEndAddress -SubnetMask $ScopeSubnetMask
} catch {
    Write-Error $_.Exception.Message
    Exit 1
}


# Configuration des options d'étendue DHCP
try {
    Set-DhcpServerv4OptionValue -ScopeId -Router $DefaultGateway -DnsServer $PrimaryDNSServer, $SecondaryDNSServer -DnsDomainName $DnsDomainName
} catch {
    Write-Error $_.Exception.Message
    Exit 1
}