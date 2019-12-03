#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import unittest
from my_drawbox import draw_box

# - empty str,
# - str with even number of chars,
# - str with odd number of chars,
# - short str (< 76 chars),
# - long str (>= 76 chars) (1 long word),
# - long str with spaces (words),
# - long string with tabs,


class TestDrawbox(unittest.TestCase):

    def test_draw_box_empty(self):
        text = ""
        result = draw_box(text)
        self.assertTrue(len(result) == 4)

    def test_draw_box_odd(self):
        text = "banan"
        result = draw_box(text)
        self.assertTrue(len(result[2]) == 78)
#                                   banan                                    #

    def test_draw_box_even(self):
        text = "banana"
        result = draw_box(text)
        self.assertTrue(len(result[2]) == 78)
#                                   banana                                   #
#                                     b                                      #
#                                     ba                                     #
    def test_draw_box_short(self):
        text = "banana"
        result = draw_box(text)
        self.assertTrue(len(result) == 5)

    def test_draw_box_long(self):
        text = "bananaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        result = draw_box(text)
        self.assertTrue(len(result) == 6)

    def test_draw_box_long_spaces(self):
        text = "bananaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaa aaaaaaaa"
        result = draw_box(text)
        self.assertTrue(len(result) == 6)

    def test_draw_box_long_tabs(self):
        text = "bananaaaaaa     aaaaaaaaaaaaa   aaaaaaaaaaaa    aaaaaaaaaaaaaa  aaaaaaaaaaaaa"
        result = draw_box(text)
        self.assertTrue(len(result) == 6)


if __name__ == '__main__':
    unittest.main(verbosity=2)
