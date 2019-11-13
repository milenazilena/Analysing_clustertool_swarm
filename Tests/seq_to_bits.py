#!/usr/bin/env python3

# Script creates a pd.table of permutations of 'ACGT' including bits,
# bits shown as one integer and length of the permutation.
# Saves this table in a .csv.

# import sys
from itertools import permutations
import pandas as pd

n = 3
# n = int(sys.argv[1])
input = 'ACGT'
input = input.strip()

liste = []
numbers = []
for i in range(1, n+1):
    out = list(permutations(input, i))
    out = [''.join(i) for i in out]
    for i in out:
        numbers.append(out.index(i))
        liste.append(i)

liste_seq_to_bits = [j.replace('A', '00').replace('C', '01')
                     .replace('G', '10').replace('T', '11')
                     for j in liste]

list_length = []
for z in liste:
    list_length.append(len(z))

df = pd.DataFrame({"seq": liste, "bits": liste_seq_to_bits,
                   "bits to int": numbers, "length": list_length})
df.to_csv('permutation_ACGT.csv')

# print(numbers)
# print(liste_seq_to_bits)
# print(list_length)
# print(df)
