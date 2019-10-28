#!/bin/bash
FASTA_FILE=$(printf ">s1_1000\nAA\n>s2_100\nCC\n>s3_10\nGG\n>s4_1\nTT\n")
echo "${FASTA_FILE}"| while read -r line; do
	b= $(grep '^>' | -Eo "(_).*")
	for b in "${b}";do
		/usr/bin/time -f "%e\t%M\t%P" \
                       swarm \
                       -f -b ${b} \
                       "${FASTA_FILE}" \
                       -o /dev/null \
                       -l /dev/null 2>&1
	done
done

exit 0

grep 