using './spacegame_aci.bicep'
  
var namePrefix = 'spaceGame'
param acrName = toLower('${namePrefix}Acr')
param containerGroupName = '${namePrefix}ContainerGroup'
param dnsNameLabel = '${namePrefix}Dns'
param repositoryName = toLower('${namePrefix}Repo')

