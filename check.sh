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

test_mkdocs_docker() {

  echo ''
  echo 'Testing mkdocs docker image version...'

  local docker_namespace="squidfunk"
  local docker_repository="mkdocs-material"

  local docker_latest_version=$(
    get_docker_hub_most_recent_image_tag_not_latest \
      $docker_namespace \
      $docker_repository \
  )

  echo "${docker_latest_version} ... latest tag version on docker hub."

  local makefile_path='./makefile'
  local makefile_variable_name='docker_image_mkdocs_material_version'

  local makefile_docker_mkdocs_version=$(
    get_makefile_variable_value \
      $makefile_path \
      $makefile_variable_name \
  )

  echo "${makefile_docker_mkdocs_version} ... makefile version."

  echo "source: $makefile_path"
}

test_mkdocs_docker
