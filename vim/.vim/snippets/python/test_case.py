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
        self.assertNotIn(!!thingy!!, !!thingy container!!)
        self.assertIsInstance(!!a thing!!, !!a type!!)
        self.assertRaises(!!ERROR!!, !!function!!, !!args!!)
