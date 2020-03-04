#!/bin/bash

# Begin Standard 'imports'
set -e
set -o pipefail

gray="\\e[37m"
blue="\\e[36m"
red="\\e[31m"
green="\\e[32m"
reset="\\e[0m"

info() { echo -e "${blue}INFO: $*${reset}"; }
error() { echo -e "${red}ERROR: $*${reset}"; }
debug() {
    if [[ "${DEBUG}" == "true" ]]; then
        echo -e "${gray}DEBUG: $*${reset}";
    fi
}

success() { echo -e "${green}✔ $*${reset}"; }
fail() { echo -e "${red}✖ $*${reset}"; exit 1; }

## Enable debug mode.
enable_debug() {
  gcloud_debug_args=""
  if [[ "${DEBUG}" == "true" ]]; then
    info "Enabling debug mode."
    set -x
    gcloud_debug_args="--verbosity=debug"
  else
    gcloud_debug_args="--verbosity=warning"
  fi
}

# Execute a command, saving its output and exit status code, and echoing its output upon completion.
# Globals set:
#   status: Exit status of the command that was executed.
#
run() {
  echo "$@"
  set +e
  eval "$@" 2>&1
  status=$?
  set -e
}

# End standard 'imports'