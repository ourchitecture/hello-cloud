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

if ! command -v dotnet >/dev/null 2>&1; then
    echo "The .NET CLI ('dotnet') could not be found and must be installed." 1>&2
    exit 1
fi

if ! command -v node >/dev/null 2>&1; then
    echo "The Node.js CLI ('node') is required by the AWS tooling, could not be found and must be installed." 1>&2
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    echo "The Docker CLI ('docker') is required by the AWS tooling, could not be found and must be installed." 1>&2
    exit 1
fi

if [ -z "$AWS_REGION" ]; then
    echo "The environment variable AWS_REGION is required." 1>&2
    exit 1
fi

if [ -z "$AWS_STACK_NAME" ]; then
    echo "The environment variable AWS_STACK_NAME is required." 1>&2
    exit 1
fi

aws_region="$AWS_REGION"
aws_stack_name="$AWS_STACK_NAME"

# ensure `dotnet aws` is ready
dotnet tool restore

dotnet_aws_command_exists_output=$(dotnet aws || true)

if ! contains "$dotnet_aws_command_exists_output" "Usage"; then
  echo "The AWS plug-in for the .NET CLI ('dotnet aws') could not be found and must be installed." 1>&2
  exit 1
fi

# FRAGILE: there does not appear to be a named argument
# for the value "Choose deployment option" provided via
# an interactive prompt with option to select from.
# https://github.com/aws/aws-dotnet-deploy/issues/403
echo "2" | dotnet aws deploy \
  --region "${aws_region}" \
  --project-path ./ \
  --stack-name "${aws_stack_name}"
