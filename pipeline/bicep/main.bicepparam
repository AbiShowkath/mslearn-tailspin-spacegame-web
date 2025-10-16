using './main.bicep'

param namePrefix = 'spacegame'
param appServicePlanName = '${namePrefix}-app-service-plan'
param skuName = 'B1'
param appServiceKind = 'linux'
param linuxFxVersion = 'DOTNETCORE:8.0'
