# Azure Virtual WAN 
This repository contains example code for Virtual WAN deployment. Below features are included in this lab 
* Deployment of a Virtual WAN Resource 
* deployment of two Virtual Hubs 
* deployment of VPN Gateway (Optional - template conditions are used to control this)
* deployment of ExpressRoute Gateway (Optional)
* deployment of Secure Hubs (Optional)


## How to Deploy this template 

template is constracted using Azure Bicep. deployment example is below 
``` bash
rg=vwantest118
az group create --name $rg --location eastus2
az deployment group create --name deploy1 --resource-group $rg --template-file ./main.bicep --parameters prefix=$rg --no-wait 
```

