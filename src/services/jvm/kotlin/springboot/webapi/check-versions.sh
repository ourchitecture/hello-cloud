#!/bin/bash

set -eu

test_kotlin_project() {

  echo ''
  echo 'Testing kotlin project...'

  mvnw_file_path='./.mvn/wrapper/maven-wrapper.properties'
  mvnw_file_content=$(cat $mvnw_file_path)

  echo ''
  grep = <<< $mvnw_file_content
  echo "source: $mvnw_file_path"

  maven_file_path="./pom.xml"
  maven_file_content=$(cat $maven_file_path)

  echo ''
  grep '[vV]ersion>' <<< $maven_file_content | sed 's/^ *//g'
  echo "source: $maven_file_path"

  gradlew_file_path="./gradle/wrapper/gradle-wrapper.properties"
  gradlew_file_content=$(cat $gradlew_file_path)

  echo ''
  grep distributionUrl <<< $gradlew_file_content
  echo "source: $gradlew_file_path"

  gradle_file_path="./build.gradle.kts"
  gradle_file_content=$(cat $gradle_file_path)

  echo ''
  grep '[vV]ersion' <<< $gradle_file_content | sed 's/^ *//g'
  grep 'jvmTarget' <<< $gradle_file_content | sed 's/^ *//g'
  echo "source: $gradle_file_path"

  gcloud_app_config_file_path="./app.yaml"
  gcloud_app_config_file_content=$(cat $gcloud_app_config_file_path)

  echo ''
  grep 'runtime:' <<< $gcloud_app_config_file_content
  echo "source: $gcloud_app_config_file_path"

  system_file_path="./system.properties"
  system_file_content=$(cat $system_file_path)

  echo ''
  grep = <<< $system_file_content
  echo "source: $system_file_path"

  make_file_path="./makefile"
  make_file_content=$(cat $make_file_path)

  echo ''
  grep 'aws_platform.*=' <<< $make_file_content
  echo "source: $make_file_path"
}

test_dockerfile() {

  echo ''
  echo 'Testing docker image version...'

  local dockerfile_path='./docker/Dockerfile'
  local dockerfile_content=$(cat $dockerfile_path)

  grep 'ARG .*VERSION=' <<< $dockerfile_content
  echo "source: $dockerfile_path"
}

test_kotlin_project

test_dockerfile
