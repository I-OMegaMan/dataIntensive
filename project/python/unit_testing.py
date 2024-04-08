import unittest

import secretMessage as sm


class TestCrypto(unittest.TestCase):
    def test_string(self):
        crypt = sm.aes256Crypto()
        testKey = "test"
        #9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08
        #source of https://emn178.github.io/online-tools/sha256.html
        self.assertEqual( b'\x9f\x86\xd0\x81\x88L}e\x9a/\xea\xa0\xc5Z\xd0\x15\xa3\xbfO\x1b+\x0b\x82,\xd1]l\x15\xb0\xf0\n\x08', crypt.makeKey(testKey))

if __name__ == '__main__':
    unittest.main()
