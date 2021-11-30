#!/bin/sh

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

if [ -z "$AWS_ENV_NAME" ]; then
    echo "The environment variable AWS_ENV_NAME is required" 1>&2
    exit 1
fi

if [ -z "$AWS_REGION" ]; then
    echo "The environment variable AWS_REGION is required" 1>&2
    exit 1
fi

aws_config_path="${AWS_CONFIG_PATH:-./.elasticbeanstalk/config.yml}"
aws_config_backup_path="${AWS_CONFIG_BACKUP_PATH:-./aws-eb-config.yml.bak}"

aws_env_name="$AWS_ENV_NAME"
aws_region="$AWS_REGION"

env_exists_output=$(eb status "$aws_env_name" --region "$aws_region" || true)

if contains "$env_exists_output" "$aws_env_name"; then
  echo 'Destroying the Elastic Beanstalk environment and application...'

  eb terminate \
    "$aws_env_name" \
		--force \
		--all

  echo 'Successfully terminated the Elastic Beanstalk environment and application.'
else
  echo 'The Elastic Beanstalk environment does not exist.'
fi
