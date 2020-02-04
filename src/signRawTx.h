#include "os.h"
#include "cx.h"
#include "globals.h"

#ifndef _SIGN_RAW_TX_H_
#define _SIGN_RAW_TX_H_

#define ACCT_NUM_OFFSET 0
#define RAW_TX_OFFSET 4

struct messageSigningContext {
    uint8_t* rawTx;
    uint16_t rawTxLen;
    uint32_t accountNumber;
    //unsigned char hashValue[64];    
};

void parseSignRawTxData(struct apduMessage *apdu);
void handleSignRawTx(struct apduMessage *apdu, volatile unsigned int *flags, volatile unsigned int *tx);

#endif
