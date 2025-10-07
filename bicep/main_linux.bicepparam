using './main_linux.bicep'

param namePrefix = 'spacegameweb'
param vmName = '${namePrefix}VM'
param adminUsername = 'abishowkathlinuxuser'
param authenticationType = 'password'
param adminPasswordOrKey = 'abishowkathlinux@0987'
param dnsLabelPrefix = toLower('${namePrefix}dns')
param ubuntuOSVersion = 'Ubuntu-2204'
param vmSize = 'Standard_B1s'
param virtualNetworkName = 'vNet'
param subnetName = 'Subnet'
param networkSecurityGroupName = 'SecGroupNet'
param securityType = 'TrustedLaunch'

