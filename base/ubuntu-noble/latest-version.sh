#!/usr/bin/env bash

version=$(curl -s "https://registry.hub.docker.com/v2/repositories/library/ubuntu/tags" | jq --raw-output '.results[] | select(.name | contains("noble")) | .name' | sort | tail -n1)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
