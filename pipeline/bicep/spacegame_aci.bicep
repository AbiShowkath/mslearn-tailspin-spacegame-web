param location string = resourceGroup().location
param acrName string
param containerGroupName string
param dnsNameLabel string
param repositoryName string

module aci 'modules/aci.bicep' = {
  name: 'aciModule'
  params: {
    location: location
    acrName: acrName
    containerGroupName: containerGroupName
    dnsNameLabel: dnsNameLabel
    repositoryName: repositoryName
  }
}

