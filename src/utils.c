#include "os.h"
#include "cx.h"
#include <stdbool.h>
#include <stdlib.h>
#include "utils.h"
#include "menu.h"

#define ACCOUNT_ADDRESS_PREFIX 1

void btox(char *xp, const char *bb, int n)
{
    const char xx[]= "0123456789abcdef";
    while (--n >= 0) xp[n] = xx[(bb[n>>1] >> ((1 - (n&1)) << 2)) & 0xF];
}

void getAddressStringFromBinary(uint8_t *publicKey, char *address) {
    uint8_t buffer[36];
    uint8_t hashAddress[32];

    os_memmove(buffer, publicKey, 32);
    cx_hash_sha256(buffer, 32, hashAddress, 32);

    //Only copy first 20 bytes of hashAddress as the User's address.
    btox(address, (const char*)hashAddress, 40);
    address[40] = 0;
}

void getPublicKey(uint32_t accountNumber, uint8_t *publicKeyArray) {
    cx_ecfp_private_key_t privateKey;
    cx_ecfp_public_key_t publicKey;

    getPrivateKey(accountNumber, &privateKey);
    cx_ecfp_generate_pair(CX_CURVE_Ed25519, &publicKey, &privateKey, 1);
    os_memset(&privateKey, 0, sizeof(privateKey));

    for (int i = 0; i < 32; i++) {
        publicKeyArray[i] = publicKey.W[64 - i];
    }
    if ((publicKey.W[32] & 1) != 0) {
        publicKeyArray[31] |= 0x80;
    }
}

uint32_t readUint32BE(uint8_t *buffer) {
  return (buffer[0] << 24) | (buffer[1] << 16) | (buffer[2] << 8) | (buffer[3]);
}

static const uint32_t HARDENED_OFFSET = 0x80000000;

static const uint32_t derivePath[BIP32_PATH] = {
  44 | HARDENED_OFFSET,
  403 | HARDENED_OFFSET,
  0 | HARDENED_OFFSET,
  0 | HARDENED_OFFSET,
  0 | HARDENED_OFFSET
};

void getPrivateKey(uint32_t accountNumber, cx_ecfp_private_key_t *privateKey) {
    uint8_t privateKeyData[32];
    uint32_t bip32Path[BIP32_PATH];

    os_memmove(bip32Path, derivePath, sizeof(derivePath));
    bip32Path[2] = accountNumber | HARDENED_OFFSET;
    PRINTF("BIP32: %.*H\n", BIP32_PATH*4, bip32Path);
    os_perso_derive_node_bip32_seed_key(HDW_ED25519_SLIP10, CX_CURVE_Ed25519, bip32Path, BIP32_PATH, privateKeyData, NULL, NULL, 0);
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, privateKey);
    os_memset(privateKeyData, 0, sizeof(privateKeyData));
}

void sendResponse(uint8_t tx, bool approve) {
    G_io_apdu_buffer[tx++] = approve? 0x90 : 0x69;
    G_io_apdu_buffer[tx++] = approve? 0x00 : 0x85;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
    // Display back the original UX
    ui_idle();
}

unsigned int ui_prepro(const bagl_element_t *element) {
    unsigned int display = 1;
    if (element->component.userid > 0) {
        display = (ux_step == element->component.userid - 1);
        if (display) {
            if (element->component.userid == 1) {
                UX_CALLBACK_SET_INTERVAL(2000);
            }
            else {
                UX_CALLBACK_SET_INTERVAL(MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
            }
        }
    }
    return display;
}

uint16_t readUint16BE(uint8_t *buffer) {
    return (buffer[0] << 8) | (buffer[1]);
}

void parseAPDU(struct apduMessage* apdu) {

    apdu->cla = G_io_apdu_buffer[OFFSET_CLA];
    apdu->ins = G_io_apdu_buffer[OFFSET_INS];
    apdu->p1 = G_io_apdu_buffer[OFFSET_P1];
    apdu->p2 = G_io_apdu_buffer[OFFSET_P2];

    //Parse Length of Data
    apdu->lc = readUint16BE(&G_io_apdu_buffer[OFFSET_LC + 1]);
    PRINTF("Length of APDU CDATA: %d", apdu->lc);

    apdu->cData = &G_io_apdu_buffer[OFFSET_CDATA];
}
