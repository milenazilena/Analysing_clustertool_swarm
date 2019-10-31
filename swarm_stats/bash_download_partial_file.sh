#!/bin/bash

URL=$1
LINES=10000
OUTPUT="${URL/*\//}"
OUTPUT="${OUTPUT/.gz/}"

wget --quiet --output-document - "${URL}" | \
gunzip --force --stdout | \
head --lines "${LINES}" > "${OUTPUT}"

exit 0
