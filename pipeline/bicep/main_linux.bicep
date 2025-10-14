param namePrefix string = 'spacegame'

@description('The name of your Virtual Machine.')
param vmName string = '${namePrefix}VM'

@description('Username for the Virtual Machine.')
param adminUsername string

@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string = newGuid()

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
param dnsLabelPrefix string = toLower('${vmName}-${uniqueString(resourceGroup().id, currentUtc)}')

@description('The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.')
@allowed([
  'Ubuntu-2004'
  'Ubuntu-2204'
])
param ubuntuOSVersion string = 'Ubuntu-2004'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The size of the VM')
param vmSize string = 'Standard_B1s'

@description('Name of the VNET')
param virtualNetworkName string = 'vNet'

@description('Name of the subnet in the virtual network')
param subnetName string = 'Subnet'

@description('Name of the Network Security Group')
param networkSecurityGroupName string = 'SecGroupNet'

@description('Security Type of the Virtual Machine.')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'TrustedLaunch'

@minLength(5)
@maxLength(50)
@description('Provide a globally unique name of your Azure Container Registry')
param acrName string = '${namePrefix}acr${uniqueString(resourceGroup().id)}'

@description('Allocation method for the Public IP used to access the Virtual Machine.')
param publicIPAllocationMethod string = 'Static'

@description('SKU for the Public IP used to access the Virtual Machine.')
param publicIpSku string = 'Standard'

var publicIPAddressName = '${vmName}PublicIP'
var networkInterfaceName = '${vmName}NetInt'
var osDiskType = 'Standard_LRS'
var subnetAddressPrefix = '10.1.0.0/24'
var addressPrefix = '10.1.0.0/16'
var extensionName = 'GuestAttestation'
var extensionPublisher = 'Microsoft.Azure.Security.LinuxAttestation'
var extensionVersion = '1.0'
var maaTenantName = 'GuestAttestation'
var maaEndpoint = substring('emptystring', 0, 0)

module network 'modules/network.bicep' = {
  name: 'networkModule'
  params: {
    location: location
    virtualNetworkName: virtualNetworkName
    subnetName: subnetName
    networkSecurityGroupName: networkSecurityGroupName
    addressPrefix: addressPrefix
    subnetAddressPrefix: subnetAddressPrefix
  }
}

var networkSubnetId = network.outputs.networkSubnetId
var networkSecurityGroupId = network.outputs.networkSecurityGroupId

module nic_ip 'modules/nic_ip.bicep' = {
  name: 'nicIpModule'
  params: {
    location: location
    networkSubnetId: networkSubnetId
    networkInterfaceName: networkInterfaceName
    networkSecurityGroupId: networkSecurityGroupId
    publicIPAddressName: publicIPAddressName
    publicIpSku: publicIpSku
    publicIPAllocationMethod: publicIPAllocationMethod
    dnsLabelPrefix: dnsLabelPrefix
  }
}

var networkInterfaceId = nic_ip.outputs.networkInterfaceId
var publicIPAddress = nic_ip.outputs.publicIPAddressFqdn

module compute 'modules/compute.bicep' = {
  name: 'computeModule'
  params: {
    location: location
    vmName: vmName
    adminUsername: adminUsername
    adminPasswordOrKey: adminPasswordOrKey
    authenticationType: authenticationType
    vmSize: vmSize
    ubuntuOSVersion: ubuntuOSVersion
    networkInterfaceId: networkInterfaceId
    securityType: securityType
    osDiskType: osDiskType
    extensionName: extensionName
    extensionPublisher: extensionPublisher
    extensionVersion: extensionVersion
    maaTenantName: maaTenantName
    maaEndpoint: maaEndpoint
  }
}

module acrResource 'modules/acr.bicep' = {
  name: 'acrModule'
  params: {
    location: location
    acrName: acrName
  }
}

@description('Current UTC time for unique Key Vault naming.')
param currentUtc string = utcNow()

module keyvaultResource 'modules/keyvault.bicep' = {
  name: 'keyvaultModule'
  params: {
    location: location
    keyVaultName: '${namePrefix}kv${uniqueString(resourceGroup().id, currentUtc)}'
    adminPasswordOrKey: adminPasswordOrKey
  }
}

// output vmId string = compute.outputs.vmId
output vmName string = compute.outputs.vmName
output acrLoginServer string = acrResource.outputs.acrLoginServer
output adminUsername string = adminUsername
// output hostname string = publicIPAddress
// output sshCommand string = 'ssh ${adminUsername}@${publicIPAddress}'
