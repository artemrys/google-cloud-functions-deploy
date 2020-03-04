#!/usr/bin/env bash
#
# Release to dockerhub.
#
# On master, we push both a :latest tag, and :<next-version>
# On release/<foo> branches, we only push :<next-version>
#
# Required globals:
#   DOCKERHUB_USERNAME
#   DOCKERHUB_PASSWORD
#   BITBUCKET_BRANCH
#   BITBUCKET_BUILD_NUMBER
#
# Arguments:
#   REPOSITORY: The dockerhub repository we are pushing to.
#
set -ex

REPOSITORY=$1

# Login to dockerhub.
docker_login() {
    echo ${DOCKERHUB_PASSWORD} | docker login --username "$DOCKERHUB_USERNAME" --password-stdin
}

# Generate all tags.
generate_tags() {
    if [[ "${BITBUCKET_BRANCH}" == "master" ]]; then
        tags=("latest" "${BITBUCKET_BUILD_NUMBER}")
    else
        echo "ERROR: Can only push docker images from master branch."
        exit 1
    fi
}

# Build and tag with an intermediate tag.
docker_build() {
    docker build -t ${REPOSITORY}:pipelines-${BITBUCKET_BUILD_NUMBER} .
}

# Tag with final tags and push.
docker_push() {
    for tag in "${tags[@]}"; do
        docker tag "${REPOSITORY}:pipelines-${BITBUCKET_BUILD_NUMBER}" "${REPOSITORY}:${tag}"
        docker push "${REPOSITORY}:${tag}"
    done
}

docker_login
generate_tags
docker_build
docker_push