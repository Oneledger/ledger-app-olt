#include "os.h"
#include "cx.h"
#include "globals.h"

#ifndef _UTILS_H_
#define _UTILS_H_

#define CLA 0xE0
#define INS_GET_APP_CONFIGURATION 0x01
#define INS_GET_ADDR 0x02
#define INS_SIGN_TX 0x03

#define OFFSET_CLA 0
#define OFFSET_INS 1
#define OFFSET_P1 2
#define OFFSET_P2 3
#define OFFSET_LC 4
#define OFFSET_CDATA 7

typedef enum rlpTxType {
    TX_LENGTH = 0,
    TX_TYPE,
    TX_SENDER,
    TX_RECIPIENT,
    TX_AMOUNT,
    TX_FEE
} rlpTxType;


struct apduMessage {
    char cla;        //Class
    char ins;        //Instruction
    char p1;         //Parameter1
    char p2;         //Parameter2
    uint16_t lc;     //Length of Cdata
    uint8_t* cData;  //Command Data
    char le;         //Max length of response in bytes
};

unsigned int ui_prepro(const bagl_element_t *element);

void getAddressStringFromBinary(uint8_t *publicKey, char *address);

void getPublicKey(uint32_t accountNumber, uint8_t *publicKeyArray);

uint32_t readUint32BE(uint8_t *buffer);

void getPrivateKey(uint32_t accountNumber, cx_ecfp_private_key_t *privateKey);

void sendResponse(uint8_t tx, bool approve);

void parseAPDU(struct apduMessage* apdu);

void btox(char *xp, const char *bb, int n);

    // type            userid    x    y   w    h  str rad fill      fg        bg      fid iid  txt   touchparams...       ]
#define UI_BUTTONS \
    {{BAGL_RECTANGLE   , 0x00,   0,   0, 128,  32, 0, 0, BAGL_FILL, 0x000000, 0xFFFFFF, 0, 0}, NULL, 0, 0, 0, NULL, NULL, NULL},\
    {{BAGL_ICON        , 0x00,   3,  12,   7,   7, 0, 0, 0        , 0xFFFFFF, 0x000000, 0, BAGL_GLYPH_ICON_CROSS  }, NULL, 0, 0, 0, NULL, NULL, NULL },\
    {{BAGL_ICON        , 0x00, 117,  13,   8,   6, 0, 0, 0        , 0xFFFFFF, 0x000000, 0, BAGL_GLYPH_ICON_CHECK  }, NULL, 0, 0, 0, NULL, NULL, NULL }

#define UI_FIRST 1
#define UI_SECOND 0

#define UI_LABELINE(userId, text, isFirst, font, horizontalScrollSpeed)    \
    {                                                                      \
        {                                                                  \
            BAGL_LABELINE,                                                 \
            (userId),                                                      \
            23,                                                            \
            (isFirst) ? 12 : 26,                                           \
            82,                                                            \
            12,                                                            \
            (horizontalScrollSpeed) ? BAGL_STROKE_FLAG_ONESHOT | 10 : 0,   \
            0, 0, 0xFFFFFF, 0x000000,                                      \
            (font)|BAGL_FONT_ALIGNMENT_CENTER,                             \
            horizontalScrollSpeed                                          \
        },                                                                 \
        (text), 0, 0, 0, NULL, NULL, NULL                                  \
    }

#endif
