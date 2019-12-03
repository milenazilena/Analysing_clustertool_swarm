#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
    Draw a nice box around a given text.
"""

__authors__ = "Frédéric Mahé and Milena Königshofen"
__license__ = "GPL3"
__date__ = "2019/11/22"
__email__ = "frederic.mahe@cirad.fr"
__version__ = "2.0"

import sys
from argparse import ArgumentParser
import textwrap

# ************************************************************************** #
#                                                                            #
#                                 Variables                                  #
#                                                                            #
# ************************************************************************** #

max_width = 76
filling = "*"
comment = "#"

# ************************************************************************** #
#                                                                            #
#                                 Functions                                  #
#                                                                            #
# ************************************************************************** #


def arg_parse():
    """
    Parse arguments from command line.
    """
    desc = """Draw a nice box around a given text."""

    parser = ArgumentParser(description=desc)

    parser.add_argument("-t", "--text",
                        action="store",
                        nargs="?",
                        dest="text",
                        const="Go Banana!",
                        required=True)

    args = parser.parse_args()

    return args.text


def draw_box(text):
    """
    Creates box around text.
    """
    inset = max_width - 2 * len(comment)
    filled = comment + " " + filling * inset + " " + comment
    empty = comment + " " + " " * inset + " " + comment
    line_list = textwrap.wrap(text, width=inset)
    print(filled, empty, sep="\n", file=sys.stdout)
    for line in line_list:
        middle = comment + " " + line.center(inset, " ") + " " + comment
        print(middle, sep="", file=sys.stdout)
    print(empty, filled, sep="\n", file=sys.stdout)

    return


def main():
    """
    Reads an input and draws a box around it.
    """

    text = arg_parse()
    draw_box(text)

    return


# ************************************************************************** #
#                                                                            #
#                                  Body                                      #
#                                                                            #
# ************************************************************************** #


if __name__ == '__main__':

    main()

sys.exit(0)
