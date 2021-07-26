# Azure Virtual WAN 
This repository contains example code for Virtual WAN deployment. Below features are included in this lab 
* Deployment of a Virtual WAN Resource 
* deployment of three Virtual Hubs (Both hubs are deployed in the same region **this is a new feature that is now GA as of June 2021)
* deployment of VPN Gateway (Optional - template conditions are used to control this)
* deployment of ExpressRoute Gateway (Optional)
* deployment of Secure Hubs (Optional)


## How to Deploy this template 

Open Azure Cloudshell and change directory to Cloud Drive 
```
cd clouddrive
git clone https://github.com/nthewara/vwan
cd vwan
```

template is constracted using Azure Bicep. deployment example is below using Azure CLI
``` bash
rg=vwantest115
az group create --name $rg --location eastus2
az deployment group create --name deploy1 --resource-group $rg --template-file ./main.bicep --parameters prefix=$rg --no-wait 
```
