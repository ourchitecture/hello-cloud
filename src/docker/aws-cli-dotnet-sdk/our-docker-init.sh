#!/usr/bin/env bash

set -e # exit if commands fail

# ensure current version of node is available
. /root/.nvm/nvm.sh

# future enhancement: detect if ".nvmrc" file is available
#   from a local volume mount (e.g. "/app") and auto-run `nvm use`

# NOTE: we need to detect if the right permissions are
#   available to start docker. The intended use case for
#   this script is "docker-in-docker", which requires the
#   `docker run ... --privileged ...` argument.
#   So, we execute a "dummy" command that requires these permissions.
# See: https://stackoverflow.com/a/32144661/6258497
set +e # do not exit if this fails
ip link add dummy0 type dummy > /dev/null 2>&1
# VITAL: status check must be after `ip link ...` command
ip_link_exit_code=$?

set -e # exit if commands fail

if [[ $ip_link_exit_code -eq 0 ]]; then
    # clean up the dummy0 link created to test permissions
    ip link delete dummy0 > /dev/null 2>&1

    # run docker in the background
    # and send output to a log file
    # NOTE: Microsoft's docker-in-docker developer images run DNS checks.
    #   Might need this in the future.
    ( dockerd > /tmp/dockerd.log 2>&1 ) &

    echo ""
    printf "Waiting for docker to start..."

    # loop until we get a successful response
    # DEBUG: when running docker-in-docker, if this message prints forever
    #   and docker never seems to start, check that the "privileged" argument
    #   was passed to the command e.g. `docker run --privileged ...`
    while [[ -z "$(! docker stats --no-stream 2> /dev/null)" ]];
      do printf ".";
      sleep 1
    done

    echo ""
    echo "Successfully started docker."
else
    echo "INFO: Skipping docker initialization. This container was not run with \"--privileged\" mode."
fi

# return to default shell behavior
set +e

# execute any commands passed as arguments
# this supports setting this script as the docker entrypoint:
#   `ENTRYPOINT ["our-docker-init.sh"]`
exec "$@"
