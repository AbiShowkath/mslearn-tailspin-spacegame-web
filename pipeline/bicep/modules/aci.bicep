param location string
param acrName string
param containerGroupName string
param dnsNameLabel string
param repositoryName string

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: acrName
}

var acrLoginServer = acr.properties.loginServer

resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: containerGroupName
  location: location
  properties: {
    containers: [
      {
        name: '${repositoryName}-container'
        properties: {
          image: '${acrLoginServer}/${repositoryName}:latest'
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 1
            }
          }
          ports: [
            {
              port: 80
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    imageRegistryCredentials: [
      {
        server: acrLoginServer
        username: acr.listCredentials().username
        password: acr.listCredentials().passwords[0].value
      }
    ]
    ipAddress: {
      type: 'Public'
      ports: [
        {
          protocol: 'Tcp'
          port: 80
        }
      ]
      dnsNameLabel: toLower('${dnsNameLabel}-${uniqueString(resourceGroup().id)}')
    }
  }
}
