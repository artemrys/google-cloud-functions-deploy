#!/usr/bin/env bash

# Deploy to GCP Cloud Functions, https://cloud.google.com/functions/
#
# Required globals:
#   KEY_FILE
#   PROJECT
#   FUNCTION_NAME
#   ENTRY_POINT
#   RUNTIME
#
# Optional globals:
#   MEMORY
#   TIMEOUT
#   EXTRA_ARGS
#   DEBUG

source "$(dirname "$0")/common.sh"
enable_debug

# mandatory parameters
KEY_FILE=${KEY_FILE:?'KEY_FILE variable missing.'}
PROJECT=${PROJECT:?'PROJECT variable missing.'}
FUNCTION_NAME=${FUNCTION_NAME:?'FUNCTION_NAME variable missing.'}
ENTRY_POINT=${ENTRY_POINT:?'ENTRY_POINT variable missing.'}
RUNTIME=${RUNTIME:?'RUNTIME variable missing.'}

info "Setting up environment".

run 'echo "${KEY_FILE}" >> /tmp/key-file.json'
run gcloud auth activate-service-account --key-file /tmp/key-file.json --quiet ${gcloud_debug_args}
run gcloud config set project $PROJECT --quiet ${gcloud_debug_args}

ARGS_STRING=""

if [ ! -z "${RUNTIME}" ]; then
  ARGS_STRING="${ARGS_STRING} --runtime ${RUNTIME} "
fi

if [ ! -z "${PROJECT}" ]; then
  ARGS_STRING="${ARGS_STRING} --project=${PROJECT}"
fi

if [ ! -z "${ENTRY_POINT}" ]; then
  ARGS_STRING="${ARGS_STRING} --entry-point=${ENTRY_POINT} "
fi

info "Starting deployment GCP Cloud Function..."

run gcloud functions deploy ${FUNCTION_NAME} --trigger-http ${ARGS_STRING} ${EXTRA_ARGS} --source . ${gcloud_debug_args}

if [ "${status}" -eq 0 ]; then
  success "Deployment successful."
else
  fail "Deployment failed."
fi