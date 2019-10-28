#!/bin/bash
FASTA_FILE=$(printf ">s1_1000\nAA\n>s2_100\nCC\n>s3_10\nGG\n>s4_1\nTT\n")
echo "${FASTA_FILE}" | grep "^>"| grep -Eo "[0-9]+$" | \
while read abundance; do 
	echo $(( abundance - 1 )) 
done \
|grep -v "^0$" | \
while read b; do 
	/usr/bin/time -f "%e\t%M\t%P" \
                swarm \
                -f -b "${b}" \
                "${FASTA_FILE}" \
                -o /dev/null \
                -l /dev/null 2>&1
done \
| tac
exit 0