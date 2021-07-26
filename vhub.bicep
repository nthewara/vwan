
param vhubname string
param location string
param vhubaddress string
param vwanid string

resource vhub 'Microsoft.Network/virtualHubs@2021-02-01' = {
  name: vhubname
  location: location
  properties: {
    addressPrefix: vhubaddress
    virtualWan: {
      id: vwanid
    }
  }
}

output id string = vhub.id
