#!/bin/bash

set -eu

# e.g. az ad sp create-for-rbac --name "our-hello-sp" --role Contributor
if ! [ -z "$AZURE_SP_APPID" ]; then

  if [ -z "$AZURE_SP_PASSWORD" ]; then
    echo "The environment variable AZURE_SP_PASSWORD is required when AZURE_SP_APPID is provided." 1>&2
    exit 1
  fi

  if [ -z "$AZURE_SP_TENANT" ]; then
    echo "The environment variable AZURE_SP_TENANT is required when AZURE_SP_APPID is provided." 1>&2
    exit 1
  fi

  echo ''
  echo 'Authenticating to Azure with Service Principal credentials...'
  az login --service-principal \
    -u "${AZURE_SP_APPID}" \
    -p "${AZURE_SP_PASSWORD}" \
    --tenant "${AZURE_SP_TENANT}" > /dev/null
  echo 'Successfully authenticated.'
else
  echo ''
  echo 'Logging into Azure...'
  echo 'You will be prompted to interactively authenticate with your credentials...'
  az login --use-device-code
  echo 'Successfully authenticated.'
fi
