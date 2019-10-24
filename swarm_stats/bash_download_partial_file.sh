#!/bin/bash

URL="https://elwe.rhrk.uni-kl.de/outgoing/16S_V3_V4_1332_samples_1f.stats.gz"
LINES=20000
OUTPUT="${URL/*\//}"
OUTPUT="${OUTPUT/.gz/}"

wget --quiet --output-document - "${URL}" | \
gunzip --force --stdout | \
head --lines "${LINES}" > "${OUTPUT}"

exit 0
