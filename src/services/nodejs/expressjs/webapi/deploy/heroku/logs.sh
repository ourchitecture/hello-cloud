#!/bin/bash

set -eu

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if ! command -v heroku >/dev/null 2>&1; then
    echo "The Heroku CLI ('heroku') could not be found and must be installed." 1>&2
    exit 1
fi

if [ -z "$HEROKU_APP_NAME" ]; then
    echo "The environment variable HEROKU_APP_NAME is required." 1>&2
    exit 1
fi

app_name="$HEROKU_APP_NAME"

# login (interactively or automatically with Service Principal)
source $SCRIPT_DIR/login.sh

heroku logs \
  --app="$app_name"
