
param vwanname string 
param location string

resource vwan 'Microsoft.Network/virtualWans@2021-02-01'  = {
  name: vwanname
  location: location
  properties: any({
    type: 'Standard'
    allowBranchToBranchTraffic: true
  })
}

output id string = vwan.id
