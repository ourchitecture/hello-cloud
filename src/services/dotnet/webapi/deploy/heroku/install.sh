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

if ! command -v heroku >/dev/null 2>&1; then
    echo "The Heroku CLI ('heroku') could not be found and must be installed." 1>&2
    exit 1
fi

if [ -z "$GIT_EMAIL" ]; then
    echo "The environment variable GIT_EMAIL is required." 1>&2
    exit 1
fi

if [ -z "$GIT_NAME" ]; then
    echo "The environment variable GIT_NAME is required." 1>&2
    exit 1
fi

if [ -z "$HEROKU_AUTH_EMAIL" ]; then
    echo "The environment variable HEROKU_AUTH_EMAIL is required." 1>&2
    exit 1
fi

if [ -z "$HEROKU_AUTH_TOKEN" ]; then
    echo "The environment variable HEROKU_AUTH_TOKEN is required." 1>&2
    exit 1
fi

if [ -z "$HEROKU_APP_NAME" ]; then
    echo "The environment variable HEROKU_APP_NAME is required." 1>&2
    exit 1
fi

app_name="$HEROKU_APP_NAME"

# Heroku does not offer an officially supported .NET Core buildpack
# Ourchitecture has forked this individual's buildpack: https://github.com/jincod/dotnetcore-buildpack
app_buildpack="${HEROKU_APP_BUILDPACK:-https://github.com/ourchitecture/dotnetcore-buildpack}"

# login (interactively or automatically with Service Principal)
source $SCRIPT_DIR/login.sh

app_exists_output=$(heroku apps:info --app="$app_name" 2>&1 || true)

if contains "$app_exists_output" "Couldn't find"; then

  echo 'Creating a new application...'

  heroku apps:create \
    "$app_name" \
    --buildpack="$app_buildpack"

  echo 'Successfully created a new application.'
else
  echo 'Application already exists.'
fi

################################################################################
# Heroku works with git to sync changes to the cloud. For example, a production
# application might have it's own repository and the DevOps CI/CD pipeline might
# use the URL to that repository for the Heroku deployments.
#
# So, we're going to simulate a new git repo on every deploy to force Heroku
# to synchronize every time by initializing git and committing all of the
# "/app" files to it.
echo ''
echo 'Initializing empty git repository for Heroku deployment.'
echo 'See notes for why this is necessary.'
echo ''
git config --global init.defaultBranch main
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
git init
git add .
git commit -m 'feat: hello-cloud, heroku style'
echo ''
echo 'Successfully initialized git repository for Heroku deployment.'
################################################################################

echo 'Pushing application git repository to Heroku deployment.'
git push "https://git.heroku.com/$app_name.git" HEAD:main
