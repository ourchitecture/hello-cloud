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

if ! command -v gcloud >/dev/null 2>&1; then
    echo "The Google Cloud CLI ('gcloud') could not be found and must be installed." 1>&2
    exit 1
fi

if [ -z "$GCLOUD_PROJECT_ID" ]; then
    echo "The environment variable GCLOUD_PROJECT_ID is required." 1>&2
    exit 1
fi

project_id="$GCLOUD_PROJECT_ID"
region="${GCLOUD_REGION:-us-east1}"
service_account_name="${GCLOUD_SERVICE_ACCOUNT_NAME:-sp-our-hello-cloud}"
service_account_title="${GCLOUD_SERVICE_ACCOUNT_TITLE:-Our Hello Cloud Service Account}"
service_account_description="${GCLOUD_SERVICE_ACCOUNT_DESCRIPTION:-See: https://www.ourchitecture.io/hello-cloud/}"

# login (interactively or automatically with Service Principal)
source $SCRIPT_DIR/login.sh

project_exists_output=$(gcloud projects describe "$project_id" --quiet 2>&1 || true)

project_may_not_exist=0

if contains "$project_exists_output" "may not exist"; then
  project_may_not_exist=1
fi

project_delete_requested=0

if contains "$project_exists_output" "DELETE_REQUESTED"; then
  project_delete_requested=1
fi

if [ "$project_may_not_exist" = 1 ]; then

  echo "Creating a new project \"${project_id}\"..."

  gcloud projects create \
		"$project_id" \
		--quiet

  echo 'Successfully created a new project.'
elif [ "$project_delete_requested" = 1 ]; then

  echo 'Restoring an existing and deleted project...'

  gcloud projects undelete \
		"$project_id" \
    --quiet

  echo 'Successfully restored an existing and previously deleted project.'
else
  echo 'Using existing project.'
fi

echo 'Looking up existing project number...'
project_number=$(gcloud projects describe "$project_id" --format="value(projectNumber)" --quiet)
echo "Successfully found project number: $project_number"

# set default project
gcloud config set project "$project_id"

service_account_key="${service_account_name}@${project_id}.iam.gserviceaccount.com"

echo 'Searching for service account...'
echo "Service account key: $service_account_key"

service_account_exists_output=$(gcloud iam service-accounts describe "$service_account_key" 2>&1 || true)

if contains "$service_account_exists_output" "NOT_FOUND"; then

  echo 'Creating a new service account...'
  echo "Service account key: $service_account_key"

  gcloud iam service-accounts create \
    "$service_account_name" \
    --display-name="$service_account_title" \
    --description="$service_account_description"

  echo 'Successfully created a new service account.'
else
  echo 'Service account already exists.'
fi

app_exists_output=$(gcloud app instances list 2>&1 || true)

if contains "$app_exists_output" "not found"; then

  echo 'Creating a new application...'

  gcloud app create \
    --region="$region" \
    --quiet

  echo 'Successfully created a new application.'
else
  echo 'Application already exists.'
fi

# TODO: figure out how to automatically associate Billing and Cloud Build with
#       the project. Currently, it prompts for manual intervention.
# the command below still requires "Billing" to already be associated with the
# project, so it currently doesn't work.
# gcloud services enable cloudbuild.googleapis.com

echo 'Deploying the application...'

# assumes that the context is running in a container
# where the current directory (`pwd`) is "/app"
# and relative to the root of this project
gcloud app deploy \
  ./gcloud-app.yaml \
  --stop-previous-version \
  --promote \
  --quiet

echo 'Successfully deployed the application.'
