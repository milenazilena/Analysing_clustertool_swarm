#!/bin/bash

URL="https://elwe.rhrk.uni-kl.de/outgoing/18S_V9_496_samples_1f.stats.gz"
LINES=50000
OUTPUT="${URL/*\//}"
OUTPUT="${OUTPUT/.gz/}"

wget --quiet --output-document - "${URL}" | \
gunzip --force --stdout | \
head --lines "${LINES}" > "${OUTPUT}"

exit 0
