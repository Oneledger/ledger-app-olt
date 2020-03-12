#include "utils.h"
#include "signRawTx.h"
#include "os.h"
#include "ux.h"
#include "cx.h"

static struct messageSigningContext signCtx = {NULL, 0, 0, 0};
static struct sendTxParams sendCtx = {{0}, {0}, {0}};
static unsigned char signature[MAX_SIGNATURE] = {0};
static uint8_t sizeOfSignature = 0;

static uint8_t set_signed_tx() {
    uint8_t tx = 0;

    //Set the size of response message
    G_io_apdu_buffer[tx++] = sizeOfSignature;

    //Copy signature data into output buffer.
    os_memmove(G_io_apdu_buffer + tx, signature, sizeOfSignature);

    //Set current index of output buffer.
    tx += sizeOfSignature;

    return tx;
}

////////// REGISTER UI STEPS FOR SIGNING TRANSACTION ////////////

UX_STEP_NOCB(
    ux_display_sign_flow_1_step,
    bnnn_paging,
    {
      .title = "Signature",
      .text = "Signing Transaction...",
    });
UX_STEP_NOCB(
    ux_display_sign_amount_step,
    bnnn_paging,
    {
      .title = "Amount",
      .text = sendCtx.amount,
    });
UX_STEP_NOCB(
    ux_display_sign_recipient_step,
    bnnn_paging,
    {
      .title = "Recipient Address",
      .text = sendCtx.recipient,
    });
UX_STEP_NOCB(
    ux_display_sign_fee_step,
    bnnn_paging,
    {
      .title = "Fee <OLT>",
      .text = sendCtx.fee,
    });
UX_STEP_VALID(
    ux_display_sign_flow_2_step,
    pb,
    sendResponse(set_signed_tx(), true),
    {
      &C_icon_validate_14,
      "Approve",
    });
UX_STEP_VALID(
    ux_display_sign_flow_3_step,
    pb,
    sendResponse(0, false),
    {
      &C_icon_crossmark,
      "Reject",
    });

UX_FLOW(ux_display_sign_flow,
  &ux_display_sign_flow_1_step,
  &ux_display_sign_flow_2_step,
  &ux_display_sign_flow_3_step
);

UX_FLOW(ux_display_send_flow,
  &ux_display_sign_flow_1_step,
  &ux_display_sign_amount_step,
  &ux_display_sign_recipient_step,
  &ux_display_sign_fee_step,
  &ux_display_sign_flow_2_step,
  &ux_display_sign_flow_3_step
);

////////// HANDLE SIGN RAW TRANSACTION REQUEST //////////

void parseSignRawTxData(struct apduMessage *apdu)
{
    //Parse Account NUMBER
    signCtx.accountNumber = readUint32BE(&apdu->cData[ACCT_NUM_OFFSET]);

    //Parse Transaction type
    signCtx.txType = apdu->p2;

    //Parse Raw Tx - This should be the SHA512 hash of the raw transaction created from RPC services (OL Blockchain).
    signCtx.rawTxLen = 64;
    signCtx.rawTx = &apdu->cData[RAW_TX_OFFSET];

    if (signCtx.txType == TX_TYPE_SEND)
    {
        if (apdu->lc >= (TX_FEE_OFFSET + TX_FEE_LEN))
        {
            //set send tx parameters
            os_memmove(sendCtx.amount, &apdu->cData[TX_AMT_OFFSET], TX_AMT_LEN);
            os_memmove(sendCtx.recipient, &apdu->cData[TX_REC_OFFSET], TX_REC_LEN);
            os_memmove(sendCtx.fee, &apdu->cData[TX_FEE_OFFSET], TX_FEE_LEN);
        }
    }

}

void handleSignRawTx(struct apduMessage *apdu, volatile unsigned int *flags, volatile unsigned int *tx)
{
    unsigned int info = 0;
    cx_ecfp_private_key_t privateKey;
    size_t mpi_size = sizeof(signature);

    //Get private key using CX_CURVE_Ed25519
    getPrivateKey(signCtx.accountNumber, &privateKey);

    //Get deterministic Signature of SHA512 hash of the Raw Tx.
    sizeOfSignature = cx_eddsa_sign(&privateKey, 0, CX_SHA512, signCtx.rawTx, signCtx.rawTxLen, NULL, 0, signature, mpi_size, &info);

    //Clear memory of Private key data.
    os_memset(&privateKey, 0, sizeof(cx_ecfp_private_key_t));

    //Register User interface flow for the signature process.
    if (signCtx.txType == TX_TYPE_SEND && apdu->lc >= (TX_FEE_OFFSET + TX_FEE_LEN))
    {
        //If Transaction type is "send" and length of data received meets expectations.
        ux_flow_init(0, ux_display_send_flow, NULL);
    }
    else
        ux_flow_init(0, ux_display_sign_flow, NULL);

    //Set flags to indicate that user input is required to continue.
    *flags |= IO_ASYNCH_REPLY;
}
