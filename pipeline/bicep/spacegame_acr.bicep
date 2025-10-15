param location string = resourceGroup().location

@minLength(5)
@maxLength(50)
@description('Provide a globally unique name of your Azure Container Registry')
param acrName string

// resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
//   name: 'spaceGameIdentity'
//   location: location
// }

module acr 'modules/acr.bicep' = {
  name: 'acrModule'
  params: {
    location: location
    acrName: '${acrName}${uniqueString(resourceGroup().id)}'
    // userAssignedIdentityId: userAssignedIdentity.id
  }
}

output acrLoginServer string = acr.outputs.acrLoginServer
output acrName string = acr.outputs.acrName
