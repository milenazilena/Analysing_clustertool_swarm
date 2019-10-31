#!/bin/bash

URL="https://elwe.rhrk.uni-kl.de/outgoing/Camargue_16S_roots_and_stems_20190920_1593_samples_1f.stats.gz"
LINES=10000
OUTPUT="${URL/*\//}"
OUTPUT="${OUTPUT/.gz/}"

wget --quiet --output-document - "${URL}" | \
gunzip --force --stdout | \
head --lines "${LINES}" > "${OUTPUT}"

exit 0
