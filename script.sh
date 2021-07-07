#!/bin/bash

set +x

KEYVAULT_URL="https://kv-autoioc-dev-eastus2.vault.azure.net/"
SECRET_NAME="secret-test23"

ACCESS_TOKEN=$(curl -H Metadata:true "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=${resource}" | sed -e 's/\"//g' | grep -Eo "access_token:([^\,]+)" | sed -e 's/access_token://g')
echo $ACCESS_TOKEN

SECRET_VALUE=$(curl -s "${KEYVAULT_URL}/secrets/${SECRET_NAME}?api-version=2016-10-01" -H "Authorization: Bearer ${ACCESS_TOKEN}" | sed -e 's/\"//g' | grep -Eo "value:([^\,]+)" | sed -e 's/value://g')
echo $SECRET_VALUE
