#!/bin/bash

# v0.1.0
# 29.10.2019
# This script uses a fasta-file-like-variable to measure computation time and memory of swarm 
# used with different boundary values and creates a .stats file for each boundary value.
args=("$@")
echo "${args[0]} "
FASTA_FILE="${args[1]}"

SUBFOLDER="Test_stats"
mkdir "${SUBFOLDER}"
STATS="${SUBFOLDER}/statfile_test_b"

awk -F "_" '/^>/ {a=$2 - 1 ; if (a > 0) {print a}}' ${FASTA_FILE} | \
tac | \
while read b; do 
	for i in {1..3}; do # repeat it 3 times
		echo -ne "file\t${i}\t${b}\t" # shows boundary values as column next to other values
		/usr/bin/time -f "%e\t%M\t%P" \
		swarm -f -b "${b}" \
			"${FASTA_FILE}" \
			-s ${STATS}_${b}.stats \
			-o /dev/null \
			-l /dev/null 2>&1
	done 
done > temp.log

exit 0
