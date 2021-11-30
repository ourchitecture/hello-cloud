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

gcloud_project_unique_name="$GCLOUD_PROJECT_NAME"
gcloud_region="$GCLOUD_REGION"

project_exists_output=$(gcloud projects describe "$gcloud_project_unique_name" 2>&1 || true)

# debug
# echo 'Project exists?'
# echo $project_exists_output

if contains "$project_exists_output" "not exist"; then
  echo 'Creating new project...'
  gcloud projects create \
    "$gcloud_project_unique_name" \
    --quiet
    echo 'Successfully created new project.'
else
  if contains "$project_exists_output" "DELETE_REQUESTED"; then
    echo 'Project already exists.'
    echo 'Undeleting existing project...'
    gcloud projects undelete \
      "$gcloud_project_unique_name" \
      --quiet
    echo 'Successfully restored existing project.'
  fi
fi

echo 'Configuring gcloud project...'
gcloud config set project \
  "$gcloud_project_unique_name" \
  --quiet
echo 'Successfully configured gcloud project.'

java_component_exists_output=$(gcloud components list --format json --filter app-engine-java)

if ! contains "$java_component_exists_output" "Installed"; then
  echo 'Installing Java support...'
  echo 'Important: the local installation method for gcloud changes how Java component support is added. If this attempt fails, please read the output and follow the instructions on how to install Java support.'
  gcloud components install app-engine-java
  echo 'Successfully installed Java support.'
fi

app_exists_output=$(gcloud app describe 2>&1 || true)

# debug
# echo 'App exists?'
# echo $app_exists_output

if contains "$app_exists_output" "not contain"; then
  echo 'Creating application...'
  gcloud app create \
    --region=$gcloud_region \
    --quiet
  echo 'Successfully created application.'
fi

cloudbuild_enabled_output=$(gcloud services list --enabled)

if ! contains "$cloudbuild_enabled_output" "cloudbuild.googleapis.com"; then
  echo 'Enabling Cloud Build service...'
  gcloud services enable \
    cloudbuild.googleapis.com \
    --async
  echo 'Successfully enabled Cloud Build service.'
  echo 'Important: enabling Cloud Build can sometimes take several minutes.'
fi

echo ''
echo 'In case of error...'
echo 'Installation Troubleshooting:'
echo '--------------------------------'
echo '- Error "An internal error occurred while creating a Google Cloud Storage bucket": wait an additional few seconds or minutes and try again'
echo '- Error "Cloud Build has not been used in project ... before": use the information provided to enable Cloud Build and possibly to associate the project with a billing account (even if you use free levels of resources)'
echo ''
