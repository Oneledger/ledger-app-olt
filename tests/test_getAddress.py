#!/usr/bin/env python

from ledgerblue.comm import getDongle
import argparse
import binascii
#from binascii import unhexlify

parser = argparse.ArgumentParser()
parser.add_argument('--account_number', help="BIP32 account to retrieve. e.g. \"12345\".")
args = parser.parse_args()

if args.account_number == None:
	args.account_number = "12345"

account = '{:08x}'.format(int(args.account_number))

# INFO:
# CLA=Class, INS=Instruction, P1=Parameter1, P2=Parameter2, Lc=Length of CDATA, CDATA=
# Create APDU message.
# CLA 0xE0
# INS 0x02  GET_ADDRESS
# P1 0x01   USER CONFIRMATION REQUIRED (0x00 otherwise)
# P2 0x00   UNUSED
# Ask for confirmation
# txt = "E0020100" + '{:02x}'.format(len(donglePath) + 1) + '{:02x}'.format( int(len(donglePath) / 4 / 2)) + donglePath
# No confirmation
apduMessage = "E00201000000" + '{:02x}'.format(len(account) + 1) + account
apdu = bytearray.fromhex(apduMessage)

print("~~ OneLedger ~~")
print("Request Address")

dongle = getDongle(True)
result = dongle.exchange(apdu)

print("Address received: 0x" + result[:40].decode("utf-8"))
print("Public Key received: 0x" + result[40:].decode("utf-8"))
