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

app_path="${APP_PATH:-$(pwd)}"
dev_tool="${DEV_TOOL:-docker}"
network_name="${CONTAINER_NETWORK:-our-hello-net}"
docs_container_name="${DOCS_CONTAINER_NAME:-our-hello-docs}"
docs_container_port="${DOCS_CONTAINER_PORT:-8000}"
image_tag="${IMAGE_TAG:-our-hello-tasks-puppeteer:latest}"

if [ "$dev_tool" != "docker" ]; then
  if [ "$dev_tool" != "podman" ]; then
    echo "The \"dev_tool\" argument value \"${dev_tool}\" is not recognized." 1>&2
    exit 1
  fi
fi

if ! command -v ${dev_tool} >/dev/null 2>&1; then
  echo "The CLI for ${dev_tool} commands could not be found and must be installed." 1>&2
  exit 1
fi

if [ ! "$($dev_tool ps -a | grep $docs_container_name)" ]; then
  echo "A documentation container with the name \"$docs_container_name\" could not be found." 1>&2
  exit 1
fi

network_exists_output=$($dev_tool network inspect "$network_name" 2>&1 || true)

if contains "$network_exists_output" "No such network"; then
  echo "Creating container network \"$network_name\"..."
  $dev_tool network create $network_name
  echo 'Successfully created container network.'
else
  echo "Container network \"$network_name\" already exists."
fi

# already exists
connect_docs=$($dev_tool network connect $network_name $docs_container_name 2>&1 || true)

if contains "$connect_docs" "already exists"; then
  echo "Container \"$docs_container_name\" already connected to network \"$network_name\"."
else
  echo "Connecting container \"$docs_container_name\" to network \"$network_name\"..."
  echo $connect_docs
  echo 'Successfully connected container to the network.'
fi

$dev_tool run \
  --rm \
  --interactive \
  --network $network_name \
  --volume "$app_path":/app \
  --volume "$app_path"/screenshots:/screenshots \
  --env DOCS_PORT=$docs_container_port \
  --env DOCS_HOSTNAME=$docs_container_name \
  --workdir /app \
  "$image_tag" \
  node ./screenshots.js
