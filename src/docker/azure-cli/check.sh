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

get_microsoft_docker_most_recent_image_tag_not_latest() {
  local docker_namespace_and_or_repository=$1
  local url="https://mcr.microsoft.com/v2/${docker_namespace_and_or_repository}/tags/list"

  echo "GET $url"

  # jq:   grab all "tags", except "latest", into list of new-line values
  # sort: https://stackoverflow.com/questions/4493205/unix-sort-of-version-numbers
  #       *sorting this as a pure Javascript array will sort the '[' and ']' too!
  # tr:   start to convert back to JS array by replacing new lines with comma
  # sed:  prefix and suffix list items with array '[]'
  #       and, append empty value because of `tr` trailing comma
  # jq:   select last tag, but skip empty item at end of array
  # cat:  convert to text
  local latest_version=$( \
    curl -sL $url \
    | jq '[.tags[] | select(. != "latest")][]' \
    | sort -V \
    | tr '\n' ',' \
    | sed 's/.*/[&""]/' \
    | jq -r '.[-2]' \
    | cat \
  )

  echo $latest_version
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

test_azure_cli_docker() {

  echo ''
  echo 'Testing Azure CLI docker image version...'

  local docker_tag="azure-cli"

  local docker_latest_version=$(
    get_microsoft_docker_most_recent_image_tag_not_latest \
      $docker_tag \
  )

  echo "${docker_latest_version} ... latest tag version on docker hub."

  local dockerfile_path='./Dockerfile'
  local dockerfile_variable_name='AZ_CLI_VERSION'

  local dockerfile_docker_mkdocs_version=$(
    get_dockerfile_arg_value \
      $dockerfile_path \
      $dockerfile_variable_name \
  )

  echo "${dockerfile_docker_mkdocs_version} ... Dockerfile version."

  echo "source: $dockerfile_path"
}

test_azure_cli_docker
