#!/bin/bash
#
# Test support for local developer tools:
# - docker
# - docker-compose
# - podman
# - gradle
# BUG: maven known issue (documented below)
# Tips: https://google.github.io/styleguide/shellguide.html

# TODO: always clean up containers and processes (before and after)

set -eu

# TODO: https
app_url="${APP_URL:-http://localhost:8081}"
app_content="Hello cloud"

container_healthcheck_interval="0.2"

################################################################################
# dev_tool=docker
################################################################################

dev_tool="docker"
running_container_name="our-hello-kotlin-springboot-webapi"

if ! command -v $dev_tool; then
  echo ''
  echo "WARNING: Missing the tool: $dev_tool"
  echo "Skipping tests for $dev_tool."
  echo ''
else
  echo ''
  echo "Testing dev_tool=$dev_tool..."
  echo ''

  make_target=start
  make $make_target dev_tool="$dev_tool"

  while [ "`$dev_tool inspect -f {{.State.Health.Status}} $running_container_name`" != "healthy" ]; do
      echo "Waiting for healthy 'make $make_target dev_tool=$dev_tool'..."
      sleep 0.2;
  done;

  echo ''

  if ! curl -s "$app_url" | grep -q "$app_content"; then
    echo "The command 'make $make_target dev_tool=$dev_tool' failed." 1>&2
    exit 1
  else
    echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2
  fi

  make_target=stop
  make $make_target dev_tool="$dev_tool"
  echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2

  make_target=clean
  make $make_target dev_tool="$dev_tool"
  echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2
fi

################################################################################
# dev_tool=docker-compose
################################################################################

dev_tool="docker-compose"
running_container_name="webapi_web_1"

if ! command -v $dev_tool; then
  echo ''
  echo "WARNING: Missing the tool: $dev_tool"
  echo "Skipping tests for $dev_tool."
  echo ''
else
  echo ''
  echo "Testing dev_tool=$dev_tool..."
  echo ''

  make_target=start
  make $make_target dev_tool="$dev_tool"

  while [ "`docker inspect -f {{.State.Health.Status}} $running_container_name`" != "healthy" ]; do
      echo "Waiting for healthy 'make $make_target dev_tool=$dev_tool'..."
      sleep "$container_healthcheck_interval"
  done;

  echo ''

  if ! curl -s "$app_url" | grep -q "$app_content"; then
    echo "The command 'make $make_target dev_tool=$dev_tool' failed." 1>&2
    exit 1
  else
    echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2
  fi

  make_target=stop
  make $make_target dev_tool="$dev_tool"
  echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2

  make_target=clean
  make $make_target dev_tool="$dev_tool"
  echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2
fi

################################################################################
# dev_tool=podman
################################################################################

dev_tool="podman"
running_container_name="our-hello-kotlin-springboot-webapi"

if ! command -v $dev_tool; then
  echo ''
  echo "WARNING: Missing the tool: $dev_tool"
  echo "Skipping tests for $dev_tool."
  echo ''
else

  echo ''
  echo "Testing dev_tool=$dev_tool..."
  echo ''

  make_target=start
  make $make_target dev_tool="$dev_tool"

  # BUG: podman healthchecks require systemd and WSL2 does not support systemd
  # see: https://github.com/containers/podman/issues/3507
  # So, we just check that the container has started...
  # BUG: docker and podman have different paths
  # see: https://github.com/containers/podman/issues/11645
  while [ "`$dev_tool inspect -f {{.State.Status}} $running_container_name`" != "running" ]; do
      echo "Waiting for healthy 'make $make_target dev_tool=$dev_tool'..."
      sleep "$container_healthcheck_interval"
  done;

  echo ''

  podman_additional_healthcheck_interval="10.0"
  echo ''
  echo "FRAGILE: podman healthchecks are not currently working, so sleeping an extra ${podman_additional_healthcheck_interval}s..."
  echo ''
  sleep "$podman_additional_healthcheck_interval"

  echo ''

  if ! curl -s "$app_url" | grep -q "$app_content"; then
    echo "The command 'make $make_target dev_tool=$dev_tool' failed." 1>&2
    exit 1
  else
    echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2
  fi

  make_target=stop
  make $make_target dev_tool="$dev_tool"
  echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2

  make_target=clean
  make $make_target dev_tool="$dev_tool"
  echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2
fi

################################################################################
# dev_tool=gradle
################################################################################

dev_tool="gradle"
# spring-boot defaults to 8080 (not using the container ports)
app_url="http://localhost:8080"

# requires "java", not "gradle", since we use ./gradlew
if ! command -v java; then
  echo ''
  echo "WARNING: Missing the tool: java"
  echo "Skipping tests for $dev_tool."
  echo ''
else

  echo ''
  echo "Testing dev_tool=$dev_tool..."
  echo ''

  # since "start" is run in the background and is timed
  # run "install" first to ensure time delays only apply
  # to the application "start" time and not "install" time
  make_target=install
  make $make_target dev_tool="$dev_tool"
  echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2

  # List all processes: ps -ef
  make_target=start

  # start the process in the background (&)
  make $make_target dev_tool="$dev_tool" &
  MAKE_PID=$!

  echo "The process identifier for $dev_tool is: $MAKE_PID"
  echo ''

  echo "Waiting for $dev_tool to start..."
  sleep 20.0

  if ! curl -s "$app_url" | grep -q "$app_content"; then
    echo "The command 'make $make_target dev_tool=$dev_tool' failed." 1>&2
    exit 1
  else
    echo "Successfully executed 'make $make_target dev_tool=$dev_tool'." 1>&2
  fi

  echo 'Killing running background processes on exit...'
  trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
fi

# TODO: figure out how to also test ./mvnw, since Azure relies on plugins
#       it's not possible to simply re-run the above section with a different
#       "dev_tool=maven", because the "gradle" process is still running until
#       the script fails or exits and will have a "port in use" collision

echo ''
echo '------------------------------------------------------------------'
echo ''
echo 'Successfully executed all local developer tooling tests!'
echo ''
echo 'Cleaning up...'
echo ''
