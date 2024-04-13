#!/usr/bin/env python
"""secretMessage.py"""
#a string selected from rockyou
import os
import hashlib
#https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
#https://cryptography.io/en/latest/

class ICrypto:
    def __init__(self, ):
        "docstring"
    def makeKey(self, stringKey):
        pass
    def encrypt(self, stringToEncrypt) -> str :
        pass
    def decryptBytes(self, stringToDecrypt) -> str :
        pass

class aes256Crypto(ICrypto):
    def __init__(self, ):
        "docstring"
        self.hasher = hashlib.sha256()
        self.cipher = None
        self.encryptor = None
        self.key = None
        self.blocksize = 16
        #in this code, our zero IV is a source of vulnerability 
        #which will be exploited.
        self.iv = bytes([0x00]*16)
    def makeKey(self, stringKey):
        self.hasher.update(bytes(stringKey, 'utf-8'))
        key = self.hasher.digest()
        self.cipher = Cipher(algorithms.AES(key), modes.CBC(self.iv))
        self.encryptor = self.cipher.encryptor()
        self.decrypt = self.cipher.decryptor()
        self.key = key
        return(self.key)
    def encrypt(self, stringToEncrypt) -> str :
        padding = len(stringToEncrypt) % self.blocksize
        stringToEncrypt += "x" * padding
        return(self.encryptor.update(bytes(stringToEncrypt, 'utf-8'))) #+ self.encryptor.finalize())
    def decryptBytes(self, stringToDecrypt) -> str :
        return(self.decrypt.update(stringToDecrypt) + self.decrypt.finalize())

def quickDecrypt(hashKey, encryptedText):
    cipher = Cipher(algorithms.AES(hashKey), modes.CBC(bytes([0x00]*16)))
    decrypt = cipher.decryptor()
    return(decrypt.update(encryptedText) + decrypt.finalize())
    
