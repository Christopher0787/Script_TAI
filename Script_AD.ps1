# Installer le rôle Active Directory Domain Services
Write-Host "Installation du rôle Active Directory Domain Services..."
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Restart


# Attendre le redémarrage du serveur
Write-Host "Attente du redémarrage du serveur..."
Start-Sleep -Seconds 30


# Renammer le serveur en "SRV-AD"
Write-Host "Renommage du serveur en SRV-AD..."
Rename-Computer -NewName "SRV-AD" -Force -Restart


# Attendre le redémarrage du serveur
Write-Host "Attente du redémarrage du serveur..."
Start-Sleep -Seconds 10


# Définir les paramètres du domaine
$domainName = "mondomaine.local"
$adminUserName = "Admin"
$adminPassword = "Irkhan07"


