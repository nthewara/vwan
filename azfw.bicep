param vhubfwname string
param location string 
param hubid string



resource vhub1fw 'Microsoft.Network/azureFirewalls@2021-02-01' = {
  name: vhubfwname
  location: location
  properties: {
    virtualHub: {
      id: hubid
    }
    sku: {
      name: 'AZFW_Hub'
      tier: 'Standard'
    }
    hubIPAddresses: {
      publicIPs: {
        count: 1
        addresses: [
          
        ]
      }
    }
  }
}
