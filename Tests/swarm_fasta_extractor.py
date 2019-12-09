#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import sys
from argparse import ArgumentParser

# files
# -s L092_1.stats
# -o L092_1.swarms
# -f L092.fas
# -nf L092_largest_cluster.fas


def arg_parse():
    """
    Parse arguments from command line.
    """

    parser = ArgumentParser()

    parser.add_argument("-s", "--stats",
                        action="store",
                        dest="stats",
                        required=True)

    parser.add_argument("-o", "--swarms",
                        action="store",
                        dest="swarms",
                        required=True)

    parser.add_argument("-f", "--fasta",
                        action="store",
                        dest="fasta",
                        required=True)

    parser.add_argument("-nf", "--newfasta",
                        action="store",
                        dest="newfasta",
                        required=True)
    args = parser.parse_args()

    return args.stats, args.swarms, args.fasta, args.newfasta


def find_largest_cluster(stats):
    """Extracts largest cluster from .stats file"""
    # open file
    # store the representative if the number of amplicons (first col)
    # is larger than the one before
    # only first 1000 lines
    # return the representative name
    with open(os.path.join(sys.path[0], stats), "r") as f:
        line = 0
        max_lines = 1000
        amplicon_nr = 0
        highest_amplicon_nr = 0
        representative = None
        best_representative = None

        while line <= max_lines:
            for row in f:
                row = row.split()
                amplicon_nr = int(row[0])
                representative = row[2]
                if amplicon_nr > highest_amplicon_nr:
                    highest_amplicon_nr = amplicon_nr
                    best_representative = representative
                line += 1

    return best_representative


def find_rep_in_swarms(best_representative, swarms):
    """Finds representive amplicon in .swarms file and
       returns set of all amplicons in that cluster"""
    # open swarms
    # read line by line and compare first element with representative
    # if it is the same, return set of the amplicons
    with open(os.path.join(sys.path[0], swarms), "r") as f:
        amplicons = None
        for row in f:
            amplicons = row.strip().split(" ")
            if best_representative in amplicons[0]:
                top_amplicon = amplicons[0]
                amplicons = set(amplicons)
                return amplicons, top_amplicon
                break


def find_amplicons_in_fasta(amplicons, top_amplicon, fasta):
    """Finds amplicons in fasta file and creates
       new fasta file of matching amplicon names"""
    # open fasta
    # read line by line and compare ampliconnames with names
    # then store matching name and following line in fasta file
    # if sequence length shorter or larger than
    # representative length, then discard
    with open(os.path.join(sys.path[0], fasta), "r") as oldf:
        matches = dict()
        header = ''
        for row in oldf:
            if row.startswith(">"):
                header = row.strip()[1:]
            else:
                if header in amplicons:
                    matches[header] = (row.strip(), len(row.strip()))

        seq_length = matches[top_amplicon][1]
        headers = list(matches.keys())

        for header in headers:
            if matches[header][1] != seq_length:
                del matches[header]

    return matches


def write_new_fasta_file(matches, newfasta):
    with open(os.path.join(sys.path[0],
              newfasta), "w+") as newf:
        for header in matches:
            print(">", header, "\n", matches[header][0], sep="", file=newf)
    return
    # return matches


def main():
    stats, swarms, fasta, newfasta = arg_parse()
    best_representative = find_largest_cluster(stats)
    amplicons, top_amplicon = find_rep_in_swarms(best_representative, swarms)
    matches = find_amplicons_in_fasta(amplicons, top_amplicon, fasta)
    write_new_fasta_file(matches, newfasta)
    return


if __name__ == '__main__':

    main()
