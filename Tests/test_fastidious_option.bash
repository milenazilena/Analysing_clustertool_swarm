#!/bin/bash

FASTA_FILE=printf ">s1_1000\nAA\n>s2_100\CC\n>s3_10\GG\n>s4_1\nTT\n"

for b in {2..1000};do
	/usr/bin/time -f "%e\t%M\t%P" \
                       swarm \
                       -f -b ${b} \
                       "${FASTA_FILE}" \
                       -o /dev/null \
                       -l /dev/null 2>&1
done

exit 0