# Mettre a jour le système et installer le rôle DHCP
Write-Output "Mise à jour le système et installation de rôle DHCP..."
$installResult = Install-WindowsFeature -Name DHCP -IncludeManagementTools