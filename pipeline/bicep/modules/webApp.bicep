param location string = resourceGroup().location
@secure()
param appServicePlanId string
param webSiteName string
param linuxFxName string
param linuxFxVersion string

resource appService 'Microsoft.Web/sites@2024-11-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    functionAppConfig: {
      runtime: {
        name: linuxFxName
        version: linuxFxVersion
      }
    }
  }
}

output webSiteName string = appService.name
