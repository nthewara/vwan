param vhubergwname string
param location string 
param hubid string



resource vhub1ergw 'Microsoft.Network/expressRouteGateways@2021-02-01' = {
  name: vhubergwname
  location: location
  properties: {
    virtualHub: {
      id: hubid
    }
    autoScaleConfiguration: {
      bounds: {
        min: 1
      }
    }
  }
}
