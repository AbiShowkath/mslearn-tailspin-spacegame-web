param location string
param acrName string
// param userAssignedIdentityId string

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: acrName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
  // identity: {
  //   type: 'UserAssigned'
  //   userAssignedIdentities: {
  //     '${userAssignedIdentityId}': {}
  //   }
  // }
}

output acrLoginServer string = acr.properties.loginServer
output acrName string = acr.name
