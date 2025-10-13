param location string
param keyVaultName string
@secure()
param adminPasswordOrKey string

// resource scriptIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
//   name: 'script-identity'
//   location: location
// }

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
  // location: location
  // properties: {
  //   accessPolicies: [
  //     // {
  //     //   tenantId: subscription().tenantId
  //     //   objectId: scriptIdentity.properties.principalId
  //     //   permissions: {
  //     //     secrets: [
  //     //       'get'
  //     //       'list'
  //     //       'set'
  //     //       'delete'
  //     //     ]
  //     //   }
  //     // }
  //   ]
  //   enabledForTemplateDeployment: true
  //   enableSoftDelete: false
  //   sku: {
  //     family: 'A'
  //     name: 'standard'
  //   }
  //   tenantId: subscription().tenantId
  // }
}

resource keyVaultSecrets 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'adminPassword'
  properties: {
    value: adminPasswordOrKey
  }
}
