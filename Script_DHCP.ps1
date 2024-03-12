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