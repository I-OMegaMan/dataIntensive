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
        testKey = "I8pizza"
        print(f"key {testKey}: ", bytes(testCrypt.makeKey(testKey)).hex())
        testSecretMessage = "Ravioli Ravioli!"
        result = testCrypt.encrypt(testSecretMessage)
        #f02fdbceb7167abb65c4df0a03f5f791
        print(f"result for encrypted message: {testSecretMessage}")
        print(bytes(result).hex())
        decryptResult = testCrypt.decryptBytes(bytes(result))
        self.assertEqual(decryptResult.decode('utf-8'),testSecretMessage)
    def test_quick(self):
        hashBytes = bytes.fromhex("6cf13b8f64a910473727177ed4fcfcb9f279b00d005e4738c0e237a4cd8496b3")
        hashEnc = bytes.fromhex("d892c6718a7af2cd14a9f6056795279b")
        self.assertEqual(sm.quickDecrypt(hashBytes,hashEnc), b"Ravioli Ravioli!")


if __name__ == '__main__':
    unittest.main()
