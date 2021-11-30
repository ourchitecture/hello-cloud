#!/bin/sh

set -eu

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

if [ -z "$AZURE_APPSERVICE_NAME" ]; then
    echo "The environment variable AZURE_APPSERVICE_NAME is required." 1>&2
    exit 1
fi

azure_resource_group="$AZURE_RESOURCE_GROUP"
azure_region="$AZURE_REGION"
azure_appservice_plan_name="$AZURE_APPSERVICE_PLAN_NAME"
azure_appservice_name="$AZURE_APPSERVICE_NAME"

az config set \
  defaults.group="$azure_resource_group" \
  defaults.location="$azure_region"

echo 'Deploying to Azure AppService...'

echo ''
echo 'vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv'
echo ' IMPORTANT: deployment requires interactive CLI authentication.'
echo '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
echo ''
echo 'You will be prompted to open a web browser and authenticate...'
echo ''

./mvnw azure-webapp:deploy \
  "-Dazure.resourcegroup=$azure_resource_group" \
  "-Dazure.region=$azure_region" \
  "-Dazure.appservice.plan.name=$azure_appservice_plan_name" \
  "-Dazure.appservice.name=$azure_appservice_name"

echo 'Successfully deployed to Azure AppService.'
