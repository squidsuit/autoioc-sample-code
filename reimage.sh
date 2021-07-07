#!/bin/bash

set +x

#variables for reimage
subscriptionID='58cf0bae-bb79-4033-be0b-03866e6c205b'
resourcegroupname='rg-autoioc-dev-eastus2'

resource="https://management.azure.com/"

ACCESS_TOKEN=$(curl -H Metadata:true "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=${resource}" | sed -e 's/\"//g' | grep -Eo "access_token:([^\,]+)" | sed -e 's/access_token://g')
echo $ACCESS_TOKEN

HOSTNAME=$(hostname)
echo $HOSTNAME

curl -i -X POST -H "Authorization: Bearer $ACCESS_TOKEN" -H "Content-Type: application/json" -H "Content-Length: 0" "https://management.azure.com/subscriptions/${subscriptionID}/resourceGroups/${resourcegroupname}/providers/Microsoft.Compute/VirtualMachines/${HOSTNAME}/reimage?api-version=2021-03-01"
