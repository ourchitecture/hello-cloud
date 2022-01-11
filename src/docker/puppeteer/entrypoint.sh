#!/bin/bash

chown -R pptruser:pptruser /screenshots

cmd=$( printf '%q ' "${@:1}" )

# echo 'DEBUG: command $'
# echo $cmd

# exec runuser -u pptruser "${@:1}"
su pptruser -c "$cmd"
