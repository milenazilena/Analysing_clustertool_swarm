#!/bin/bash

URL="https://elwe.rhrk.uni-kl.de/outgoing/all_forest_soils_18S_V4_904_samples_1f.stats.gz"
LINES=50000
OUTPUT="${URL/*\//}"
OUTPUT="${OUTPUT/.gz/}"

wget --quiet --output-document - "${URL}" | \
gunzip --force --stdout | \
head --lines "${LINES}" > "${OUTPUT}"

exit 0
