param namePrefix string = 'spacegame'
param location string = resourceGroup().location
param appServicePlanName string = '${namePrefix}-app-service-plan'
param skuName string = 'B1'
param appServiceKind string = 'linux'

@minLength(5)
@maxLength(50)
@description('Provide a globally unique suffix for the web app name')
param webSiteName string = toLower('${uniqueString(resourceGroup().id)}')
param linuxFxVersion string = 'DOTNETCORE:8.0'

@minLength(5)
@maxLength(50)
@description('Provide a globally unique name of your Azure Container Registry')
param acrName string = '${namePrefix}acr${uniqueString(resourceGroup().id)}'


module appService './modules/appService.bicep' = {
  name: 'appServiceModule'
  params: {
    location: location
    appServicePlanName: appServicePlanName
    skuName: skuName
    appServiceKind: appServiceKind
  }
}

var appServicePlanId = appService.outputs.appServicePlanId

module webAppDev 'modules/webApp.bicep' = {
  name: 'webAppDevModule'
  params: {
    location: location
    appServicePlanId: appServicePlanId
    webSiteName: toLower('${namePrefix}-webapp-dev-${webSiteName}')
    linuxFxVersion: linuxFxVersion
  }
}

output webAppDevName string = webAppDev.outputs.webSiteName

module webAppStage 'modules/webApp.bicep' = {
  name: 'webAppStageModule'
  params: {
    location: location
    appServicePlanId: appServicePlanId
    webSiteName: toLower('${namePrefix}-webapp-staging-${webSiteName}')
    linuxFxVersion: linuxFxVersion
  }
}

output webAppStageName string = webAppStage.outputs.webSiteName

module acr 'modules/acr.bicep' = {
  name: 'acrModule'
  params: {
    location: location
    acrName: acrName
  }
}

output acrName string = acr.outputs.acrName
