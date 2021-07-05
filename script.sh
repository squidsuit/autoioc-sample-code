#!/bin/bash

ACCESS_TOKEN=$(curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true  | sed -e 's/\"//g' | grep -Eo "access_token:([^\,]+)" | sed -e 's/access_token://g')

SECRET_TOKEN=$(curl -s "https://kv-autoioc-dev-eastus2.vault.azure.net//secrets/secret-test23?api-version=2016-10-01" -H "Authorization: Bearer ${ACCESS_TOKEN}" | sed -e 's/\"//g' | grep -Eo "value:([^\,]+)" | sed -e 's/value://g')

echo $SECRET_TOKEN
echo "Done"