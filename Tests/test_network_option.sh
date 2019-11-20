#!/bin/bash

# option dumps the network of single-difference amplicons to a specified 
# file in a sorted and tab-separated format (seed amplicon, neighbour 
# amplicon). Use -n to get the full network, otherwise only links between 
# amplicons where the abundance of the seed is higher or equal to the 
# abundance of the neighbour is included.

# test sequences with one difference (different abundances): we expect one link
printf ">s1_3\nA\n>s2_1\nC\n" | swarm -l /dev/null -o /dev/null -j - | \
awk '{exit NR == 1 ? 0 : 1}' && echo success || echo failure

# test sequences with two differences (different abundances): we expect no link
printf ">s1_3\nA\n>s2_1\nCC\n" | swarm -l /dev/null -o /dev/null -j - | \
awk '{exit NR == 0 ? 0 : 1}' && echo success || echo failure

# test sequences with one difference (same abundances): we expect two links
printf ">s1_1\nA\n>s2_1\nC\n" | swarm -l /dev/null -o /dev/null -j - | \
awk '{exit NR == 2 ? 0 : 1}' && echo success || echo failure

# test sequences with two differences (same abundances):  we expect no link
printf ">s1_1\nA\n>s2_1\nCC\n" | swarm -l /dev/null -o /dev/null -j - | \
awk '{exit NR == 0 ? 0 : 1}' && echo success || echo failure

# tab-separated format
printf ">s1_3\nA\n>s2_1\nC\n" | swarm -l /dev/null -o /dev/null -j - | \
grep -q $'\t' && echo success || echo failure

# sorted by decreasing abundances within line (most abundant amplicon first)
printf ">s1_1\nA\n>s2_3\nC\n" | swarm -l /dev/null -o /dev/null -j - | \
awk '{exit $1 == "s2_3" ? 0 : 1}' && echo success || echo failure

# sorted by decreasing abundances between lines (most abundant amplicon first)
printf ">s1_2\nA\n>s2_1\nC\n>s3_1\nTT\n>s4_3\nGT\n" | swarm -l /dev/null -o /dev/null -j - | \
cut -f 1 | tr "\n" " " | awk -F "[_ ]" '{exit $2 > $4 ? 0 : 1}' && echo success || echo failure

# binds from high to low abundances: we expect only one link if sequences have different abundance values
printf ">s1_3\nA\n>s2_1\nC\n" | swarm -l /dev/null -o /dev/null -j - | \
awk '{exit NR == 1 ? 0 : 1}' && echo success || echo failure

# binds between equals: we expect double link if sequences have different abundance values
printf ">s1_1\nA\n>s2_1\nC\n" | swarm -l /dev/null -o /dev/null -j - | tr "\n" " " | \
awk '{exit $1 == $4 && $2 == $3 ? 0 : 1}' && echo success || echo failure

# double links are from A to B and from B to A
printf ">s1_1\nA\n>s2_1\nC\n" | swarm -l /dev/null -o /dev/null -j - | \
awk '{exit NR == 2 ? 0 : 1}' && echo success || echo failure

# double links also between layers: we expect double links between s2_1 and s3_1
printf ">s1_3\nA\n>s2_1\nC\n>s3_1\nCT\n" | 
swarm -l /dev/null -o /dev/null -j - | \
tail -n 2 | tr "\n" " " | \
awk '{exit $1 == $4 && $2 == $3 ? 0 : 1}' && echo success || echo failure

# only with d = 1: we expect no link
printf ">s1_3\nA\n>s2_1\nC\n>s3_1\nG\n" | \
swarm -d 2 -o /dev/null -j - 2> /dev/null && \
echo failure || echo success

# using fastidious option: we expect no error
printf ">s1_3\nA\n>s2_1\nCC\n" | swarm -f -l /dev/null -o /dev/null -j - && \
echo success || echo failure

# with fastidious option: we expect no link 
# (referred to "test sequences with two differences (different abundances)")
printf ">s1_3\nA\n>s2_1\nCC\n" | swarm -f -l /dev/null -o /dev/null -j - | \
awk '{exit NR == 0 ? 0 : 1}' && echo success || echo failure

# fastidious option doesn't change behaviour of -j
printf ">s1_3\nA\n>s2_1\nC\n" | swarm -f -l /dev/null -o /dev/null -j - | \
awk '{exit NR == 1 ? 0 : 1}' && echo success || echo failure

# -n to get full network (abundance values don't matter anymore)
# we expect a double link
printf ">s1_3\nA\n>s2_1\nC\n" | swarm -n -l /dev/null -o /dev/null -j - | tr "\n" " " | \
awk '{exit $1 == $4 && $2 == $3 ? 0 : 1}' && echo success || echo failure