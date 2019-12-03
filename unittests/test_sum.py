#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import unittest
from fractions import Fraction
from my_sum import sum


class TestSum(unittest.TestCase):

    def test_list_int(self):
        data = [1, 2, 3]
        result = sum(data)
        self.assertEqual(result, 6)

    def test_tuple_int(self):
        data = (1, 2, 3)
        result = sum(data)
        self.assertEqual(result, 6)

    def test_set_int(self):
        data = set([1, 2, 3, 1])
        result = sum(data)
        self.assertEqual(result, 6)

    def test_list_floats(self):
        data = [1.5, 2.5, 3]
        result = sum(data)
        self.assertEqual(result, 7)

    def test_list_single(self):
        data = [6]
        result = sum(data)
        self.assertEqual(result, 6)

    def test_list_empty(self):
        data = []
        result = sum(data)
        self.assertEqual(result, 0)

    def test_int(self):
        data = 6
        self.assertRaises(TypeError, sum, data)

    def test_list_negative(self):
        data = [-2]
        result = sum(data)
        self.assertEqual(result, -2)

    def test_list_mixed(self):
        data = [1.5, 2.5, 3, "hello"]
        self.assertRaises(TypeError, sum, data)

    def test_list_large(self):
        data = [2**32, 2**32]
        result = sum(data)
        self.assertEqual(result, 2**33)

    def test_list_fraction(self):
        data = [Fraction(1, 4), Fraction(1, 4), Fraction(2, 5)]
        result = sum(data)
        self.assertEqual(result, 1)


if __name__ == '__main__':
    unittest.main(verbosity=2)
