#include "os.h"
#include "cx.h"
#include "globals.h"

#ifndef _GET_ADDRESS_H_
#define _GET_ADDRESS_H_

void parseGetAddressData(struct apduMessage *apdu);
void handleGetAddress(struct apduMessage *apdu, volatile unsigned int *flags, volatile unsigned int *tx);

#endif
