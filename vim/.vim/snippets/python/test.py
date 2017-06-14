#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import unittest


class Test!!TestCaseName!!(unittest.TestCase):
    """
    !! Summary !!

    !! description !!
    """
    @classmethod
    def setUpClass(cls):
        !!class setup!!

    @classmethod
    def tearDownClass(cls):
        !!class teardown!!

    def setUp(self):
        !!commands run before each test!!

    def tearDown(self):
        !!commands run after each test!!

    def test_!!test_name!!(self):
        """!!description!!"""
        !!test statements!!
        self.assertTrue(!!foo!!)
        self.assertFalse(!!bar!!)
        self.assertEqual(!!a!!, !!bah!!)
        self.assertNotEqual(!!clah!!, !!nah!!)
        self.assertIn(!!thing!!, !!thing container!!)


if __name__ == "__main__":
    # Run unit tests as script file or from buffer.
    try:
        unittest.main(verbosity=2)
        buffer = False
    except AttributeError:
        buffer = True
    if buffer:
        module = sys.modules[__name__]
        suite = unittest.TestLoader().loadTestsFromModule(module)
        unittest.TextTestRunner(verbosity=2).run(suite)

