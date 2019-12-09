#!/bin/bash
cd ~/neotropical_subset/
LENGTH=$(head -n 1000 L092_1.stats | \
sort -n | \
tail -1 | \
awk '{print $3}' | \
grep -f - L092.fas -A 1 | \
paste - - | \
awk '{print length($2)}')


cd ~/neotropical_subset/
awk '$2==1 {print $3} ' L092_1.stats | \
grep -f - L092.fas -A 1 --no-group-separator | \
paste - - | \
awk -v LENGTH="${LENGTH}" 'length($2)==LENGTH' | \
head | \
tr "\t" "\n" > L092_singletons.fas