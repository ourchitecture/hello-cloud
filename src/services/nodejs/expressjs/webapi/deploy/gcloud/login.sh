#!/bin/bash

set -eu

echo ''
echo 'Authenticating with Google Cloud...'
echo 'You will be prompted to interactively authenticate with your credentials...'

# https://cloud.google.com/sdk/docs/authorizing
gcloud auth login --no-launch-browser > /dev/null

echo 'Successfully authenticated.'
