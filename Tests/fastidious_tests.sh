#!/bin/bash

# Fastidious option links amplicons with two differences
printf ">s1_3\nAA\n>s2_2\nCC\n" | swarm -f -l /dev/null -i - 

# Without the fastidious option, the amplicons are not linked
printf ">s1_3\nAA\n>s2_2\nCC\n" | swarm -l /dev/null -i - 


# cluster total size is 4, largest amplicon has an abundance of 3
printf ">s1_3\nAA\n>s2_1\nAC\n>s3_1\nGG\n" | swarm -f -l /dev/null -i -

# cluster total size is 3, no amplicon is bigger than 2
printf ">s1_2\nAA\n>s2_1\nAC\n>s3_1\nGG\n" | swarm -f -l /dev/null -o -


# An OTU is small if it has a mass of less than 3: One Amplicon with abundance 2 - s1 and s2 should be linked
printf ">s1_3\nAA\n>s2_2\nCC\n" | swarm -f -l /dev/null -i - 

# An OTU is small if it has a mass of less than 3: One Amplicon with abundance 2 - s1 and s2 should not be linked
printf ">s1_3\nAA\n>s2_3\nCC\n" | swarm -f -l /dev/null -i - 


# An OTU is small if it has a mass of less than 3: Two amplicons with abundance 1 - s1, s2 and s3 should be linked
printf ">s1_3\nAA\n>s2_1\nCC\n>s3_1\nGC\n" | swarm -f -l /dev/null -i -

# An OTU is small if it has a mass of less than 3: Two amplicons with abundance 1 - there should be two clusters
printf ">s1_2\nAA\n>s2_1\nCC\n>s3_1\nGC\n>s4_1\nCT\n" | swarm -f -l /dev/null -o -


# We can change the default mass value when using -b: s1 and s2 should be linked
printf ">s1_4\nAA\n>s2_3\nCC\n" | swarm -f -b 4 -l /dev/null -o -

# We can change the default mass value when using -b: s1 and s2 should not be linked
printf ">s1_3\nAA\n>s2_3\nCC\n" | swarm -f -l /dev/null -o -


# Any positive value greater than 1 can be specified: should cause an error
printf ">s1_4\nAA\n>s2_3\nCC\n" | swarm -f -b 0 -l /dev/null -o -

exit 0


