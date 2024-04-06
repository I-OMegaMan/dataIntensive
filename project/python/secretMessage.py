#!/usr/bin/env python
"""secretMessage.py"""
#a string selected from rockyou
import os
import hashlib
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
#https://cryptography.io/en/latest/

secretString = "cyprus2005"

class ICrypto:
    def __init__(self, ):
        "docstring"
    def makeKey(self, stringKey):
        pass
    def encrypt(self, stringToEncrypt) -> str :
        pass
    def decrypt(self, stringToDecrypt) -> str :
        pass

class aes256Crypto(ICrypto):
    def __init__(self, ):
        "docstring"
        self.hasher = hashlib.sha256
        self.cipher = None
    def makeKey(self, stringKey, iv=0):
        key = self.hasher(stringKey)
        self.cipher = Cipher(algorithms.AES(key), modes.CBC(iv))
        self.decrypt = self.cipher.decryptor()
        pass
    def encrypt(self, keyString) -> str :
        return(self.cipher.update(keyString) + self.cipher.finalize())
        pass
    def decrypt(self, stringToDecrypt) -> str :
        return(self.decrypt.update(stringToDecrypt) + self.decrypt.finalize())
        pass


    

