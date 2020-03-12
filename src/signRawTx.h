#include "os.h"
#include "cx.h"
#include "globals.h"

#ifndef _SIGN_RAW_TX_H_
#define _SIGN_RAW_TX_H_

#define ACCT_NUM_OFFSET 0
#define RAW_TX_OFFSET 4
#define TX_AMT_OFFSET 68
#define TX_REC_OFFSET 100
#define TX_FEE_OFFSET 164

#define TX_TYPE_SEND 1

#define RAW_TX_LEN  64
#define TX_AMT_LEN  32
#define TX_REC_LEN  64
#define TX_FEE_LEN  32

struct messageSigningContext {
    uint8_t* rawTx;         //Buffer for Raw transaction
    uint16_t rawTxLen;      //Length of RawTx
    uint32_t accountNumber; //Account number/index for given tree path
    uint8_t txType;         //Transaction type
};

struct sendTxParams {
    char amount[32];
    char recipient[64];
    char fee[32];
};

void parseSignRawTxData(struct apduMessage *apdu);
void handleSignRawTx(struct apduMessage *apdu, volatile unsigned int *flags, volatile unsigned int *tx);

#endif
