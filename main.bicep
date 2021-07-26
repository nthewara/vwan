

param prefix string = 'nt6655'
param location string = resourceGroup().location

var uniqueId = uniqueString(resourceGroup().id,deployment().name)
var uniqueIdShort = take(uniqueId,5)
var uniqueprefix = '${prefix}-${uniqueIdShort}'
var vwanname = '${uniqueprefix}-vwan'

//Hub Configuration is defined in here - default configuration is with two hubs in the same location 
var vhubs = [
  {
    vhubname: '${uniqueprefix}-vhub1'
    vhubvpngwname: '${uniqueprefix}-vpngw1'
    vhubergwname: '${uniqueprefix}-ergw1'
    vhubfwname: '${uniqueprefix}-fw1'
    vhubaddress: '192.168.0.0/23'
    vhubvpn: false 
    vhuber: true
    vhubfw: false 
  }
 {
    vhubname: '${uniqueprefix}-vhub2'
    vhubvpngwname: '${uniqueprefix}-vpngw2'
    vhubergwname: '${uniqueprefix}-ergw2'
    vhubfwname: '${uniqueprefix}-fw2'
    vhubaddress: '192.168.2.0/23'
    vhubvpn: true 
    vhuber: false 
    vhubfw: false
  }
  {
    vhubname: '${uniqueprefix}-vhub3'
    vhubvpngwname: '${uniqueprefix}-vpngw3'
    vhubergwname: '${uniqueprefix}-ergw3'
    vhubfwname: '${uniqueprefix}-fw3'
    vhubaddress: '192.168.4.0/23'
    vhubvpn: false
    vhuber: false 
    vhubfw: true
  }
]

module vwan 'vwan.bicep' = {
  name: 'vwandeploy'
  params: {
    vwanname: vwanname
    location: location
  }
}

module vhub 'vhub.bicep' =  [for vhub in vhubs: {
  name: '${vhub.vhubname}-deploy'
  params: {
    vhubname: vhub.vhubname
    location: location
    vhubaddress: vhub.vhubaddress
    vwanid: vwan.outputs.id
  }
}]



module vhubvpngw 'vpngw.bicep' =  [for (vhubvpngw, i) in vhubs: if(vhubvpngw.vhubvpn) {
  name: '${vhubvpngw.vhubname}-vpngwdeploy'
  params: {
    vhubvpngwname: vhubvpngw.vhubergwname
    location: location
    hubid: vhub[i].outputs.id  
  }
}]

module vhubergw 'ergw.bicep' = [for (vhubergw, i) in vhubs: if(vhubergw.vhuber) {
  name: '${vhubergw.vhubname}-ergwdeploy'
  params: {
    vhubergwname: vhubergw.vhubergwname
    location: location
    hubid: vhub[i].outputs.id

  }
}]

module vhubfw 'azfw.bicep' = [for (vhubfw, i) in vhubs: if(vhubfw.vhubfw) {
  name: '${vhubfw.vhubname}-fwdeploy'
  params: {
    vhubfwname: vhubfw.vhubfwname
    location: location
    hubid: vhub[i].outputs.id
  }
}]
