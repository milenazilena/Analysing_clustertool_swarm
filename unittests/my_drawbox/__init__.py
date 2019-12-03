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
    max_width = 76
    filling = "*"
    comment = "#"
    mybox = list()
    inset = max_width - 2 * len(comment)
    filled = comment + " " + filling * inset + " " + comment
    empty = comment + " " + " " * inset + " " + comment
    line_list = textwrap.wrap(text, width=inset)
    mybox.extend([filled, empty])
    for line in line_list:
        middle = comment + " " + line.center(inset, " ") + " " + comment
        mybox.append(middle)
    mybox.extend([empty, filled])

    return mybox


def main():
    """
    Reads an input and draws a box around it.
    """

    text = arg_parse()
    mybox = draw_box(text)
    print("\n".join(mybox), file=sys.stdout)

    return


# ************************************************************************** #
#                                                                            #
#                                  Body                                      #
#                                                                            #
# ************************************************************************** #


if __name__ == '__main__':

    main()
