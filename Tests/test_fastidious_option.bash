#!/bin/bash


#
FASTA_FILE=$(printf ">s1_1000\nAA\n>s2_100\nCC\n>s3_10\nGG\n>s4_1\nTT\n")

awk -F "_" '/^>/ {a=$2 - 1 ; if (a > 0) {print a}}' <<< $FASTA_FILE | \
tac | \
while read b; do 
	for i in {1..3}; do #repeat it 3 times
		echo -ne "${i}\t${b}\t" #shows boundary values as column next to other values
		/usr/bin/time -f "%e\t%M\t%P" \
		swarm -f -b "${b}" \
		-s statfile_test_${b}.stats \
		-o /dev/null \
		-l /dev/null 2>&1<<< "${FASTA_FILE}"
	done 
done > temp.log

exit 0

#stat file for each b value