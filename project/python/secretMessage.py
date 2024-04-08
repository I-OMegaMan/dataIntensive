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
        self.hasher = hashlib.sha256()
        self.cipher = None
        self.key = None
        #in this code, our zero IV is a source of vulnerability 
        #which will be exploited.
        self.iv = bytes([0x00]*16)
    def makeKey(self, stringKey, iv=0):
        self.hasher.update(bytes(stringKey, 'utf-8'))
        key = self.hasher.digest()
        print(len(key))
        self.cipher = Cipher(algorithms.AES(key), modes.CBC(self.iv))
        self.decrypt = self.cipher.decryptor()
        self.key = key
        return(self.key)
    def encrypt(self, keyString) -> str :
        return(self.cipher.update(keyString) + self.cipher.finalize())
    def decrypt(self, stringToDecrypt) -> str :
        return(self.decrypt.update(stringToDecrypt) + self.decrypt.finalize())
