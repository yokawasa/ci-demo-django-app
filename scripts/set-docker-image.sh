#!/bin/sh

# https://docs.microsoft.com/en-us/cli/azure/webapp/config/container#set
# az webapp config container set --name
#                               --resource-group
#                               [--docker-custom-image-name|-c]
#                               [--docker-registry-server-password|-p]
#                               [--docker-registry-server-url|-r]
#                               [--docker-registry-server-user|-u]
#                               [--slot|-s]

myAzureUser="http://yoichika-app"
myAzurePass="<service principal password>"
myAzureTenant="<service principal tenant name>"

myResourceGroup="RG-yoichika-demo"
#myAppName="yoichikaangulardemo01"
#myDockerCustomImage="yoichikawasaki/app-services-nodejs:angular4-app-0.0.2"
myAppName="yoichikadjangodemo01"
myDockerCustomImage="yoichikawasaki/app-services-python:django-app-0.0.5"

az login --service-principal -u $myAzureUser -p $myAzurePass --tenant $myAzureTenant
az webapp config container set --name $myAppName --resource-group $myResourceGroup -c "$myDockerCustomImage"
