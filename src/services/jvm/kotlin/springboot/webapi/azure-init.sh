#!/bin/sh

set -eu

# contains(string, substring)
#
# Returns 0 if the specified string contains the specified substring,
# otherwise returns 1.
contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

if ! command -v az >/dev/null 2>&1; then
    echo "The Azure CLI ('az') could not be found and must be installed." 1>&2
    exit 1
fi

if [ -z "$AZURE_RESOURCE_GROUP" ]; then
    echo "The environment variable AZURE_RESOURCE_GROUP is required." 1>&2
    exit 1
fi

if [ -z "$AZURE_REGION" ]; then
    echo "The environment variable AZURE_REGION is required." 1>&2
    exit 1
fi

if [ -z "$AZURE_APPSERVICE_PLAN_NAME" ]; then
    echo "The environment variable AZURE_APPSERVICE_PLAN_NAME is required." 1>&2
    exit 1
fi

azure_resource_group="$AZURE_RESOURCE_GROUP"
azure_region="$AZURE_REGION"
azure_appservice_plan_name="$AZURE_APPSERVICE_PLAN_NAME"
azure_appservice_plan_sku="${AZURE_APPSERVICE_PLAN_SKU:-B1}"

resource_group_exists_output=$(az group show \
  --resource-group "$azure_resource_group" \
  --output json 2>&1 || true)

if contains "$resource_group_exists_output" "ResourceGroupNotFound"; then

  echo 'Creating Azure Resource Group...'

  az group create \
    --resource-group "$azure_resource_group" \
    --location "$azure_region"

  echo 'Successfully created Azure Resource Group.'
else
  echo 'The Azure Resource Group already exists.'
fi

az config set \
  defaults.group="$azure_resource_group" \
  defaults.location="$azure_region"

appservice_plan_exists_output=$(az appservice plan show \
  --resource-group "$azure_resource_group" \
  --name "$azure_appservice_plan_name" \
  --output json 2>&1 || true)

if contains "$appservice_plan_exists_output" "ResourceNotFound"; then

  echo 'Creating Azure AppService Plan...'

  az appservice plan create \
    --name "$azure_appservice_plan_name" \
    --is-linux \
    --sku "$azure_appservice_plan_sku"

  echo 'Successfully created the Azure AppService Plan.'
else
  echo 'The Azure AppService Plan already exists.'
fi
