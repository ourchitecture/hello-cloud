#!/bin/bash

set -eu

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

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

azure_resource_group="$AZURE_RESOURCE_GROUP"

# login (interactively or automatically with Service Principal)
source $SCRIPT_DIR/login.sh

resource_group_exists_output=$(az group show \
  --resource-group "$azure_resource_group" \
  --output json 2>&1 || true)

if ! contains "$resource_group_exists_output" "ResourceGroupNotFound"; then

	echo 'Deleting Azure Resource Group, including child resources...'

  az group delete \
		--name "$azure_resource_group" \
		--yes

  echo 'Successfully deleted the Azure Resource Group.'
else
  echo 'The Azure Resource Group does not exist.'
fi
