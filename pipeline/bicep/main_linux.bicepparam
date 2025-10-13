using './main_linux.bicep'

// var subscriptionId = '3ce7f1e6-ae95-4007-942b-4c8997e89354'
param namePrefix = 'spacegame'
param vmName = '${namePrefix}VM'
param adminUsername = 'abishowkathlinuxuser'
param authenticationType = 'password'
param dnsLabelPrefix = toLower('${namePrefix}dns')
param ubuntuOSVersion = 'Ubuntu-2204'
param vmSize = 'Standard_B1s'
param virtualNetworkName = 'vNet'
param subnetName = 'Subnet'
param networkSecurityGroupName = 'SecGroupNet'
param securityType = 'TrustedLaunch'

