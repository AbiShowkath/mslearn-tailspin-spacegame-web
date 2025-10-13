param adminUserName string = 'abishowkathazureuser'
param location string = resourceGroup().location
param camelCasePrefix string = 'spaceGame'
param namePrefix string = 'spacegame'

param vmName string = '${camelCasePrefix}VM'

var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'
var storageAccountSku = 'Standard_LRS'
var containerName = '${camelCasePrefix}Container'

param accessTier string = 'Hot'

resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSku
  }
  properties: {
    accessTier: accessTier
    supportsHttpsTrafficOnly: true
  }
}
