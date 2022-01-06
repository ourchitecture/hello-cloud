#!/bin/bash

set -eu

test_dotnet_project() {

  echo ''
  echo 'Testing dotnet project...'

  project_file_path="./webapi.csproj"
  project_file_content=$(cat $project_file_path)

  target_framework_version=$(grep -o -P '(?<=TargetFramework>).*(?=</TargetFramework)' <<< $project_file_content)

  echo "$target_framework_version ... target framework."

  echo 'Project package versions:'

  grep -P '(?<=PackageReference).*' <<< $project_file_content

  echo "source: $project_file_path"
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
    | jq '[.tags[] | select(. | contains("-arm") or contains("-amd") | not) | select(. | contains("-alpine"))][]' \
    | sort -V \
    | tr '\n' ',' \
    | sed 's/.*/[&""]/' \
    | jq -r '.[-2]' \
    | cat \
  )

  echo $latest_version
}

test_dockerfile() {

  echo ''
  echo 'Testing docker image version...'

  local docker_tag="dotnet/sdk"

  local docker_latest_version=$(
    get_microsoft_docker_most_recent_image_tag_not_latest \
      $docker_tag \
  )

  echo "${docker_latest_version} ... latest tag version on docker hub."

  local dockerfile_path='./Dockerfile'
  local dockerfile_content=$(cat $dockerfile_path)

  echo 'Dockerfile versioned arguments:'

  grep 'ARG DOTNET_VERSION=' <<< $dockerfile_content \
    | sed 's/.*/  &/'
  grep 'ARG ALPINE_VERSION=' <<< $dockerfile_content \
    | sed 's/.*/  &/'
  grep 'ARG APK_VERSION_.*=' <<< $dockerfile_content \
    | sed 's/.*/  &/'

  echo "source: $dockerfile_path"
}

test_dotnet_project

test_dockerfile

echo ''
echo 'Also, check "./.config/dotnet-tools.json" for versions.'
