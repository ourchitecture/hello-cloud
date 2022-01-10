#!/bin/bash

set -eu

test_puppeteer_docker() {

  echo ''
  echo 'Testing Puppeteer versions...'

  local dockerfile_path='./Dockerfile'

  echo "source: $dockerfile_path"
}

test_puppeteer_docker
