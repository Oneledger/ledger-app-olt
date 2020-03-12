#!/usr/bin/env python

from ledgerblue.comm import getDongle
import argparse
import binascii
import requests
import json
import time
import hashlib
import base64


url = "http://127.0.0.1:26602/jsonrpc"
headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
}

tx_type_create = 0
tx_type_send = 1

class txCtx:
    accountNum = ""
    amount = {}
    recipient = ""
    sender = ""
    fee = {}

def rpc_call(method, params):
    payload = {
        "method": method,
        "params": params,
        "id": 123,
        "jsonrpc": "2.0"
    }

    print "PAYLOAD: ", payload
    response = requests.request("POST", url, data=json.dumps(payload), headers=headers)

    if response.status_code != 200:
        return ""

    resp = json.loads(response.text)
    return resp


def converBigInt(value):
    return str(value)

def create_domain(name, owner_hex, price):
    req = {
        "name": name,
        "owner": owner_hex,
        "account": owner_hex,
        "buyingprice": {
            "currency": "OLT",
            "value": converBigInt(price),
        },
        "gasprice": {
            "currency": "OLT",
            "value": "1000000000",
        },
        "gas": 40000,
    }
    resp = rpc_call('tx.ONS_CreateRawCreate', req)
    return resp["result"]["rawTx"]

def send( fromAddr, toAddr, amount):
    req = {
        "from":fromAddr,
        "to":toAddr,
        "amount": {
            "currency": "OLT",
            "value": converBigInt(amount),
        },
        "gasprice": {
            "currency": "OLT",
            "value": "1000000000",
        },
        "gas": 40000,
    }
    resp = rpc_call('tx.CreateRawSend', req)
    return resp["result"]["rawTx"]


def broadcast_commit(rawTx, signature, pub_key):
    resp = rpc_call('broadcast.TxCommit', {
        "rawTx": rawTx,
        "signature": signature,
        "publicKey": pub_key,
    })
    print resp
    return resp["result"]

def get_RawTx(txType):
    if txType == tx_type_create:
        create_price = (int("10023450")*10**14)
        raw_txn = create_domain("kevin.ol", address, create_price)

    if txType == tx_type_send:
        amount = (int("10023450")*10**14)
        raw_txn = send(address, address, amount)

    #RPC layer base 64 encodes message before sending. Need to decode.
    raw_txn_decoded =  base64.b64decode(raw_txn)

    print "raw tx:", raw_txn_decoded
    return raw_txn, raw_txn_decoded


# INFO:
# CLA=Class, INS=Instruction, P1=Parameter1, P2=Parameter2, Lc=Length of CDATA, CDATA=
# Create APDU message.
# CLA 0xE0
# INS 0x02  GET_ADDRESS
# P1 0x01   USER CONFIRMATION REQUIRED (0x00 otherwise)
# P2 0x00   UNUSED
# Ask for confirmation
# txt = "E00201000000" + '{:02x}'.format(len(donglePath) + 1) + '{:02x}'.format( int(len(donglePath) / 4 / 2)) + donglePath
# No confirmation

def getAddress(account_num):
    apduMessage = "E00200000000" + '{:02x}'.format(len(account_num)/2) + account_num
    apdu = bytearray.fromhex(apduMessage)

    dongle = getDongle(True)
    result = dongle.exchange(apdu)

    address = '0x' + result[:40].decode("utf-8")
    pubKey = '0x' + result[40:].decode("utf-8")

    print("Address received: 0x" + result[:40].decode("utf-8"))
    print("Public Key received: 0x" + result[40:].decode("utf-8"))

    dongle.close()

    return address, pubKey


def signRawTx(rawTx, sendCtx):
    #Convert Send Context object to strings:
    amount_str = sendCtx.amount["currency"] + ": " + sendCtx.amount["value"]
    amount = amount_str.encode('hex').ljust(64,'0')

    recipient = sendCtx.recipient.encode('hex').ljust(128,'0')

    fee = sendCtx.fee["value"].encode('hex').ljust(64,'0')

    account_num = sendCtx.accountNum

    #Create APDU message
    apduMessage = "E003010100" + '{:04x}'.format((len(account_num) + (len(rawTx) + len(amount) + len(recipient) + len(fee)) / 2)) + account_num + rawTx + amount + recipient + fee
    apdu = bytearray.fromhex(apduMessage)

    print 'length of apdu:'
    print len(apdu)

    #Send APDU Message
    dongle = getDongle(True)
    result = dongle.exchange(apdu)

    dongle.close()

    return result


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--account_number', help="BIP32 account to retrieve. e.g. \"12345\".")
    args = parser.parse_args()

    if args.account_number == None:
    	args.account_number = "12345"

    account = '{:08x}'.format(int(args.account_number))

    address, pubKey = getAddress(account)

    print("~~ OneLedger ~~")
    print("Sign Transaction")

    transCtx = txCtx()

    txType = tx_type_send

    # Get Raw Transaction
    raw_txn, rawTx_decoded = get_RawTx(txType)
    rawTx_json = json.loads(rawTx_decoded)
    print "rawTx:", rawTx_json
    print
    sendTx = json.loads( base64.b64decode(rawTx_json["data"]) )
    print json.dumps(sendTx, indent=4)

    transCtx.accountNum = account
    transCtx.amount = sendTx["amount"]
    transCtx.recipient = sendTx["to"]
    transCtx.fee = rawTx_json["fee"]["price"]


    #Using SHA512 to prehash raw message before signing.
    raw_hash = hashlib.sha512(rawTx_decoded).hexdigest()
    print "raw hash of tx: ", raw_hash

    # Sign Raw Transaction
    signature = signRawTx(raw_hash, transCtx)
    signature_str = ''.join(format(x, '02x') for x in signature)
    print "Signature: ", signature_str[2:]

    print "Public Key: ", pubKey[2:]

    #Token indicating that message has been hashed before calculating signature.
    token = "SHA512"

    #base 64 encode binary forms of signature and public key.
    #tx_b64 = base64.b64encode(bytearray.fromhex(raw_hash))
    signature_b64 = base64.b64encode( bytearray(token) + bytearray.fromhex(signature_str[2:]) )
    pubKey_b64 = base64.b64encode(bytearray.fromhex(pubKey[2:]))

    SignRawTxResponse = {
        "signature": {
                        "Signed": signature_b64,
                        "Signer": {
                                    "keyType": "ed25519",
                                    "data": pubKey_b64
                        }
        }
    }

    result = broadcast_commit(raw_txn, SignRawTxResponse['signature']['Signed'], SignRawTxResponse['signature']['Signer'])
    print result
    print "###################"
    print
