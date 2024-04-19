import unittest

import secretMessage as sm


class TestCrypto(unittest.TestCase):
    def test_key(self):
        crypt = sm.aes256Crypto()
        testKey = "test"
        #9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08
        #source of https://emn178.github.io/online-tools/sha256.html
        self.assertEqual( b'\x9f\x86\xd0\x81\x88L}e\x9a/\xea\xa0\xc5Z\xd0\x15\xa3\xbfO\x1b+\x0b\x82,\xd1]l\x15\xb0\xf0\n\x08', crypt.makeKey(testKey))

    def test_crypt(self):
        testCrypt = sm.aes256Crypto()
        testKey = "i8pizza"
        print(f"key {testKey}: ", bytes(testCrypt.makeKey(testKey)).hex())
        testSecretMessage = "Ravioli Ravioli!"
        result = testCrypt.encrypt(testSecretMessage)
        #f02fdbceb7167abb65c4df0a03f5f791
        print(f"result for encrypted message: {testSecretMessage}")
        print(bytes(result).hex())
        decryptResult = testCrypt.decryptBytes(bytes(result))
        self.assertEqual(decryptResult.decode('utf-8'),testSecretMessage)
    def test_quick(self):
        hashBytes = bytes.fromhex("63359cf25e20abc6eb2dcad3d32e1c7c113a0be00bc2b9a930e02add704dd508")
        hashEnc = bytes.fromhex("c2843aa1e53c8089486cee9d28c42789")
        self.assertEqual(sm.quickDecrypt(hashBytes,hashEnc), b"Ravioli Ravioli!")


if __name__ == '__main__':
    unittest.main()
