using './storage.bicep'

param adminUserName = 'abishowkathazureuser'
param location = 'eastus'
param camelCasePrefix = 'spaceGame'
param namePrefix = 'spacegame'
param vmName = '${camelCasePrefix}VM'
param accessTier = 'Hot'

