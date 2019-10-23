#!/bin/bash
wget -q -O - https://elwe.rhrk.uni-kl.de/outgoing/16S_V3_V4_1332_samples_1f.stats.gz | gunzip -f - | head -n 20000 - > 16S_V3_V4_1332_samples_1f_20000.stats 

