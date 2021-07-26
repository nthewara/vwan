param vhubvpngwname string
param location string 
param hubid string


resource vhub1vpngw 'Microsoft.Network/vpnGateways@2021-02-01' = {
  name: vhubvpngwname
  location: location
  properties: {
    virtualHub: {
      id: hubid
    }
    vpnGatewayScaleUnit: 1
  }
}
