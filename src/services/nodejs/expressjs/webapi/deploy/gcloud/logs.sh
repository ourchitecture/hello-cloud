#!/bin/bash

set -eu

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# login (interactively or automatically with Service Principal)
source $SCRIPT_DIR/login.sh

gcloud logging read \
	--project="$GCLOUD_PROJECT_ID" \
	--limit=$GCLOUD_LOGS_LIMIT
