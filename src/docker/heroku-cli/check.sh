#!/bin/bash

set -eu

get_docker_hub_most_recent_image_tag_not_latest() {
  local docker_namespace=$1
  local docker_repository=$2
  local url="https://hub.docker.com/v2/repositories/${docker_namespace}/${docker_repository}/tags"

  echo "GET $url"

  local docker_tag_latest_version=$(curl -s $url \
    | jq -r '[.results[] | select(.name != "latest")] | sort_by(.last_updated)[-1] | .name' | cat)

  echo $docker_tag_latest_version
}

get_makefile_variable_value() {
  local makefile_path=$1
  local variable_name=$2
  local variable_token="${variable_name}:="

  # sed: replace variable name
  local variable_value=$(
    grep \
      "$variable_token" \
      "$makefile_path" \
      | sed 's/.*=//' \
    )

  echo $variable_value
}

get_dockerfile_arg_value() {
  local dockerfile_path=$1
  local variable_name=$2
  local variable_token="ARG ${variable_name}="

  # sed: replace arg name
  # sed: replace double quotes
  local variable_value=$(
    grep \
      "$variable_token" \
      "$dockerfile_path" \
      | sed 's/.*=//' \
      | sed 's/"//g' \
    )

  echo $variable_value
}

test_heroku_cli_docker() {

  echo ''
  echo 'Testing Heroku CLI docker image version...'

  local dockerfile_path='./Dockerfile'

  echo 'Dockerfile versioned arguments:'

  local dockerfile_contents=$(cat $dockerfile_path)

  grep 'ARG DEBIAN_NAMED_RELEASE' <<< $dockerfile_contents \
    | sed 's/.*/  &/'
  grep 'ARG DEBIAN_VERSION' <<< $dockerfile_contents \
    | sed 's/.*/  &/'
  grep 'ARG APT_VERSION_.*=' <<< $dockerfile_contents \
    | sed 's/.*/  &/'

  echo "source: $dockerfile_path"
}

test_heroku_cli_docker
