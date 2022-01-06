#!/bin/bash

set -eu

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if ! command -v gcloud >/dev/null 2>&1; then
    echo "The Google Cloud CLI ('gcloud') could not be found and must be installed." 1>&2
    exit 1
fi

if [ -z "$GCLOUD_PROJECT_ID" ]; then
    echo "The environment variable GCLOUD_PROJECT_ID is required." 1>&2
    exit 1
fi

project_id="$GCLOUD_PROJECT_ID"
logs_limit="${GCLOUD_LOGS_LIMIT:-20}"

# login (interactively or automatically with Service Principal)
source $SCRIPT_DIR/login.sh

gcloud logging read \
	--project="$project_id" \
	--limit=$logs_limit \
  --no-user-output-enabled
