#!/bin/bash

set -eu

echo ''
echo 'Authenticating with Heroku...'

# create the credentials file that Heroku uses to authenticate
tee --append ~/.netrc > /dev/null \
<<EOF
machine api.heroku.com
  login $HEROKU_AUTH_EMAIL
  password $HEROKU_AUTH_TOKEN
machine git.heroku.com
  login $HEROKU_AUTH_EMAIL
  password $HEROKU_AUTH_TOKEN
EOF

# force heroku to use the "~/.netrc" credentials file to authenticate
heroku auth:whoami

echo 'Successfully authenticated.'
