#!/bin/bash

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

get_docker_hub_most_recent_image_tag_not_latest() {
  local docker_namespace=$1
  local docker_repository=$2
  local tag_starts_with=$3

  local base_url="https://hub.docker.com/v2/repositories/${docker_namespace}/${docker_repository}/tags?page_size=100"

  local url1="${base_url}&page=1"
  echo "GET $url1"
  local docker_tags_page1=$(curl -s $url1 | jq '.results')

  local url2="${base_url}&page=2"
  echo "GET $url2"
  local docker_tags_page2=$(curl -s $url2 | jq '.results')

  local url="${base_url}&page=3"
  echo "GET $url"
  local docker_tags_page3=$(curl -s $url | jq '.results')

  local url="${base_url}&page=4"
  echo "GET $url"
  local docker_tags_page4=$(curl -s $url | jq '.results')

  # append multiple arrays
  local all_docker_tags="${docker_tags_page1}\n${docker_tags_page2}\n${docker_tags_page3}\n${docker_tags_page4}"

  # jq: combine arrays
  #     filter array by "name"
  #     where starts with input and has specific alpine version
  #     select "name"
  # sort: https://stackoverflow.com/questions/4493205/unix-sort-of-version-numbers
  #       *sorting this as a pure Javascript array will sort the '[' and ']' too!
  # tr:   start to convert back to JS array by replacing new lines with comma
  # sed:  prefix and suffix list items with array '[]'
  #       and, append empty value because of `tr` trailing comma
  # jq:   select last tag, but skip empty item at end of array
  # cat:  convert to text
  local docker_tag_latest_version=$( \
    echo -e $all_docker_tags \
    | jq "reduce inputs as \$i (.; . += \$i) | .[] | select(.name | test(\"^$tag_starts_with\") and test(\"-alpine[0-9]\")) | .name" \
    | sort -V \
    | tr '\n' ',' \
    | sed 's/.*/[&""]/' \
    | jq -r '.[-2]' \
    | cat
  )

  echo $docker_tag_latest_version
}

get_makefile_variable_value() {
  local makefile_content="$1"
  local variable_name="$2"
  local variable_token="${variable_name}:="

  # sed: replace variable name
  local variable_value=$(
    grep "$variable_token" <<< "$makefile_content" \
    | sed 's/.*=//' \
  )

  echo $variable_value
}

get_nvm_node_lts() {
  . ~/.nvm/nvm.sh

  local node_latest_lts_version=$(nvm version-remote --lts)

  echo $node_latest_lts_version
}

test_node_project() {

  node_latest_lts_version="$1"

  echo ''
  echo 'Testing Node.js project...'

  nvm_file_path="./.nvmrc"
  nvm_version=$(cat $nvm_file_path)

  echo ''
  echo "${node_latest_lts_version} ... latest LTS version of node available."
  echo "${nvm_version} ... configured .nvmrc version."
  echo 'IMPORTANT: clouds may require older, maintenance LTS versions.'
  echo "source: $nvm_file_path"

  project_file_path="./package.json"
  project_file_content=$(cat $project_file_path)

  local project_node_version=$( \
    echo -e $project_file_content \
    | jq -r '.engines.node' \
    | cat \
  )

  local project_yarn_version=$( \
    echo -e $project_file_content \
    | jq -r '.packageManager' \
    | cat \
  )

  local yarn_latest_version=$( \
    curl -s https://api.github.com/repos/yarnpkg/berry/releases/latest \
    | jq -r '.name'
  )

  echo ''
  echo "${node_latest_lts_version} ... latest LTS version of node available."
  echo 'IMPORTANT: clouds may require older, maintenance LTS versions.'
  echo "${project_node_version} ... configured node version."
  echo "${yarn_latest_version} ... latest version of yarn available."
  echo "${project_yarn_version} ... configured yarn version."

  echo 'Project versioned packages:'

  echo -e $project_file_content \
    | jq '.dependencies' \
    | cat

  echo "source: $project_file_path"

  make_file_path="./makefile"
  make_file_content=$(cat $make_file_path)

  local makefile_docker_base_image_tag=$( \
    get_makefile_variable_value \
      "$make_file_content" \
      'base_image_tag' \
  )

  echo ''

  echo "${makefile_docker_base_image_tag} ... makefile docker base tag."
  echo "source: $make_file_path"
}

test_dockerfile() {

  node_latest_lts_version="$1"

  echo ''
  echo 'Testing docker image version...'

  local docker_namespace="library"
  local docker_repository="node"

  local docker_latest_version=$( \
    get_docker_hub_most_recent_image_tag_not_latest \
      $docker_namespace \
      $docker_repository \
      $node_latest_lts_version \
  )

  echo "${node_latest_lts_version} ... latest LTS version of node."
  echo "${docker_latest_version} ... latest tag version on docker hub."

  local dockerfile_path='./docker/Dockerfile'
  local dockerfile_content=$(cat $dockerfile_path)

  echo 'Dockerfile versioned arguments:'

  grep 'ARG NODE_VERSION=' <<< $dockerfile_content \
    | sed 's/.*/  &/'
  grep 'ARG ALPINE_VERSION=' <<< $dockerfile_content \
    | sed 's/.*/  &/'
  grep 'ARG APK_VERSION_.*=' <<< $dockerfile_content \
    | sed 's/.*/  &/'

  echo "source: $dockerfile_path"
}

# remove "v" prefix
node_lts_version=$(get_nvm_node_lts | sed 's/^v//')

test_node_project $node_lts_version

# test_dockerfile $node_lts_version
