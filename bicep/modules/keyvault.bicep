param location string
param keyVaultName string
param adminPasswordOrKey string

// resource scriptIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
//   name: 'script-identity'
//   location: location
// }

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    accessPolicies: []
    enabledForTemplateDeployment: true
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
  }
}

resource keyVaultSecrets 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'adminPasswordOrKey'
  properties: {
    value: adminPasswordOrKey
  }
}
