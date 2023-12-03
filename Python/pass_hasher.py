import hashlib
import binascii
import os

def hash_password(password):
  salt = hashlib.sha256(os.urandom(60)).hexdigest().encode('ascii')
  pbkdf2_hash = hashlib.pbkdf2_hmac('sha256', password.encode('utf-8'), salt, 100000)
  password_hash = salt + pbkdf2_hash
  return binascii.b2a_base64(password_hash)

def check_password(password, password_hash):
  password_hash = binascii.a2b_base64(password_hash)
  salt = password_hash[:64]
  pbkdf2_hash = password_hash[64:]
  pbkdf2_hash_check = hashlib.pbkdf2_hmac('sha256', password.encode('utf-8'), salt, 100000)
  if pbkdf2_hash == pbkdf2_hash_check:
    return True
  else:
    return False

# Example Password
use_example = input("Use correct example password? (y/n): ")
if use_example.lower() == "y" or use_example.lower() == "yes" or use_example.lower() == "j" or use_example.lower() == "ja":
  example_pass = "°c8hUv59qPK2DW*76t$(@d1j3!)Gsex"
else:
  example_pass = input("Enter a password: ")

password_hash = hash_password(example_pass)
print(f"PASSWORD: {example_pass}")
print("HASH: ",password_hash)

password = "b'MmNlM2MzNWVmMWU1YTU0OWYwMTRmZmRlZTE3ZTBlZjMzNmFhOGQwZTVkZGZkMWU3NTlhZDAyYWVjY2IzM2Q2ZTrDst5FUb33JylsDPzakWmKx8mk4qLl1Yx25zjDQaOz\n'"
password_check = check_password("°c8hUv59qPK2DW*76t$(@d1j3!)Gsex", password_hash)

if password_check:
  print('Password is correct')
else:
    print('Password is incorrect')