using './main.bicep'

param namePrefix = 'spacegame'
param adminUsername = 'abishowkathazureuser'
param adminPassword = 'abishowkathaz@4321'
param dnsLabelPrefix = toLower('${namePrefix}dns')
param publicIpName = '${namePrefix}'
param publicIPAllocationMethod = 'Static'
param publicIpSku = 'Standard'
param OSVersion = '2022-datacenter-azure-edition'
param vmSize = 'Standard_D2s_v5'
param vmName = '${namePrefix}VM'
param securityType = 'TrustedLaunch'
