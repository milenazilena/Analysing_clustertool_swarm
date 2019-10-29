#!/bin/bash

# V0
# 29.10.2019
# Script uses a fasta-file-like-variable to measure computation time
# and to create a .stats file for each boundary value via swarm. 

FASTA_FILE=$(printf ">s1_1000\nAA\n>s2_100\nCC\n>s3_10\nGG\n>s4_1\nTT\n")
SUBFOLDER="Test_stats"
mkdir "${SUBFOLDER}"
STATS="${SUBFOLDER}/statfile_test_b"

awk -F "_" '/^>/ {a=$2 - 1 ; if (a > 0) {print a}}' <<< $FASTA_FILE | \
tac | \
while read b; do 
	for i in {1..3}; do # repeat it 3 times
		echo -ne "file\t${i}\t${b}\t" # shows boundary values as column next to other values
		/usr/bin/time -f "%e\t%M\t%P" \
		swarm -f -b "${b}" \
			-s ${STATS}_${b}.stats \
			-o /dev/null \
			-l /dev/null 2>&1 <<< "${FASTA_FILE}"
	done 
done > temp.log

exit 0