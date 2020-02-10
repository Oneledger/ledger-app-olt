
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
    }
    dummy_setting_1 = N_storage.dummy_setting_1;
    dummy_setting_2 = N_storage.dummy_setting_2;
}

__attribute__((section(".boot"))) int main(void) {
c0d00000:	b5b0      	push	{r4, r5, r7, lr}
c0d00002:	b08c      	sub	sp, #48	; 0x30
    // exit critical section
    __asm volatile("cpsie i");
c0d00004:	b662      	cpsie	i

    // ensure exception will work as planned
    os_boot();
c0d00006:	f000 fd50 	bl	c0d00aaa <os_boot>
c0d0000a:	4c16      	ldr	r4, [pc, #88]	; (c0d00064 <main+0x64>)
c0d0000c:	2001      	movs	r0, #1
c0d0000e:	0201      	lsls	r1, r0, #8

    for (;;) {
        UX_INIT();
c0d00010:	4620      	mov	r0, r4
c0d00012:	f004 fa99 	bl	c0d04548 <__aeabi_memclr>
c0d00016:	466d      	mov	r5, sp

        BEGIN_TRY {
            TRY {
c0d00018:	4628      	mov	r0, r5
c0d0001a:	f004 fb39 	bl	c0d04690 <setjmp>
c0d0001e:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d00020:	b285      	uxth	r5, r0
c0d00022:	4668      	mov	r0, sp
c0d00024:	2d00      	cmp	r5, #0
c0d00026:	d00b      	beq.n	c0d00040 <main+0x40>
c0d00028:	2100      	movs	r1, #0
c0d0002a:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d0002c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0002e:	f001 fde5 	bl	c0d01bfc <try_context_set>
c0d00032:	2d10      	cmp	r5, #16
c0d00034:	d0ea      	beq.n	c0d0000c <main+0xc>
            FINALLY {
            }
        }
        END_TRY;
    }
    app_exit();
c0d00036:	f000 fcb5 	bl	c0d009a4 <app_exit>
c0d0003a:	2000      	movs	r0, #0
    return 0;
c0d0003c:	b00c      	add	sp, #48	; 0x30
c0d0003e:	bdb0      	pop	{r4, r5, r7, pc}

    for (;;) {
        UX_INIT();

        BEGIN_TRY {
            TRY {
c0d00040:	f001 fddc 	bl	c0d01bfc <try_context_set>
c0d00044:	900a      	str	r0, [sp, #40]	; 0x28
                io_seproxyhal_init();
c0d00046:	f000 fe9d 	bl	c0d00d84 <io_seproxyhal_init>

                nv_app_state_init();
c0d0004a:	f000 fccb 	bl	c0d009e4 <nv_app_state_init>
c0d0004e:	2000      	movs	r0, #0

                USB_power(0);
c0d00050:	f003 fa32 	bl	c0d034b8 <USB_power>
c0d00054:	2001      	movs	r0, #1
                USB_power(1);
c0d00056:	f003 fa2f 	bl	c0d034b8 <USB_power>

                ui_idle();
c0d0005a:	f000 fcf3 	bl	c0d00a44 <ui_idle>
#ifdef HAVE_BLE
                BLE_power(0, NULL);
                BLE_power(1, "Nano X");
#endif // HAVE_BLE

                app_main();
c0d0005e:	f000 f913 	bl	c0d00288 <app_main>
c0d00062:	46c0      	nop			; (mov r8, r8)
c0d00064:	2000186c 	.word	0x2000186c

c0d00068 <ux_display_public_flow_6_step_validateinit>:
    bnnn_paging,
    {
      .title = "Address",
      .text = address_str,
    });
UX_STEP_VALID(
c0d00068:	b510      	push	{r4, lr}
    //Get the length of the address, strlen will work since it is base 58 encoded.
    const uint8_t address_size = FULL_ADDRESS_LENGTH;
    const uint8_t public_key_size = FULL_PUBKEY_LENGTH;

    //Copy address data to the output buffer
    os_memmove(G_io_apdu_buffer + tx, address_str, address_size);
c0d0006a:	4c08      	ldr	r4, [pc, #32]	; (c0d0008c <ux_display_public_flow_6_step_validateinit+0x24>)
c0d0006c:	4908      	ldr	r1, [pc, #32]	; (c0d00090 <ux_display_public_flow_6_step_validateinit+0x28>)
c0d0006e:	2228      	movs	r2, #40	; 0x28
c0d00070:	4620      	mov	r0, r4
c0d00072:	f000 fd1f 	bl	c0d00ab4 <os_memmove>
    tx += address_size;

    //Copy Public Key data to output buffer
    os_memmove(G_io_apdu_buffer + tx, public_key_str, public_key_size);
c0d00076:	3428      	adds	r4, #40	; 0x28
c0d00078:	4906      	ldr	r1, [pc, #24]	; (c0d00094 <ux_display_public_flow_6_step_validateinit+0x2c>)
c0d0007a:	2240      	movs	r2, #64	; 0x40
c0d0007c:	4620      	mov	r0, r4
c0d0007e:	f000 fd19 	bl	c0d00ab4 <os_memmove>
c0d00082:	2068      	movs	r0, #104	; 0x68
c0d00084:	2101      	movs	r1, #1
    bnnn_paging,
    {
      .title = "Address",
      .text = address_str,
    });
UX_STEP_VALID(
c0d00086:	f003 fb6d 	bl	c0d03764 <sendResponse>
c0d0008a:	bd10      	pop	{r4, pc}
c0d0008c:	20001a8e 	.word	0x20001a8e
c0d00090:	20001800 	.word	0x20001800
c0d00094:	2000182c 	.word	0x2000182c

c0d00098 <ux_display_public_flow_7_step_validateinit>:
    sendResponse(set_result_get_address(), true),
    {
      &C_icon_validate_14,
      "Approve",
    });
UX_STEP_VALID(
c0d00098:	b580      	push	{r7, lr}
c0d0009a:	2000      	movs	r0, #0
c0d0009c:	4601      	mov	r1, r0
c0d0009e:	f003 fb61 	bl	c0d03764 <sendResponse>
c0d000a2:	bd80      	pop	{r7, pc}

c0d000a4 <parseGetAddressData>:
  &ux_display_public_flow_6_step,
  &ux_display_public_flow_7_step
);

void parseGetAddressData(struct apduMessage *apdu)
{
c0d000a4:	b580      	push	{r7, lr}
    //Parse Account Number
    accountNum = readUint32BE(apdu->cData);
c0d000a6:	6880      	ldr	r0, [r0, #8]
c0d000a8:	f003 fb50 	bl	c0d0374c <readUint32BE>
c0d000ac:	4901      	ldr	r1, [pc, #4]	; (c0d000b4 <parseGetAddressData+0x10>)
c0d000ae:	6008      	str	r0, [r1, #0]
}
c0d000b0:	bd80      	pop	{r7, pc}
c0d000b2:	46c0      	nop			; (mov r8, r8)
c0d000b4:	20001828 	.word	0x20001828

c0d000b8 <handleGetAddress>:

void handleGetAddress(struct apduMessage *apdu, volatile unsigned int *flags, volatile unsigned int *tx) {
c0d000b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d000ba:	b089      	sub	sp, #36	; 0x24
c0d000bc:	4615      	mov	r5, r2
c0d000be:	460c      	mov	r4, r1
c0d000c0:	4606      	mov	r6, r0
c0d000c2:	af01      	add	r7, sp, #4
c0d000c4:	2120      	movs	r1, #32
    uint8_t publicKey[32] = {0};
c0d000c6:	4638      	mov	r0, r7
c0d000c8:	f004 fa3e 	bl	c0d04548 <__aeabi_memclr>

    //Get Public key from ED25519 private key. This is done by creating a BIP32 path using the account number and deriving a key.
    getPublicKey(accountNum, publicKey);
c0d000cc:	4812      	ldr	r0, [pc, #72]	; (c0d00118 <handleGetAddress+0x60>)
c0d000ce:	6800      	ldr	r0, [r0, #0]
c0d000d0:	4639      	mov	r1, r7
c0d000d2:	f003 fae7 	bl	c0d036a4 <getPublicKey>

    //Get Public Key string from binary
    btox(public_key_str, (const char*)publicKey, FULL_PUBKEY_LENGTH);
c0d000d6:	4811      	ldr	r0, [pc, #68]	; (c0d0011c <handleGetAddress+0x64>)
c0d000d8:	2240      	movs	r2, #64	; 0x40
c0d000da:	4639      	mov	r1, r7
c0d000dc:	f003 fa9c 	bl	c0d03618 <btox>

    //Address is generated by calculating SHA256 hash and base 58 encoding the result.
    getAddressStringFromBinary(publicKey, address_str);
c0d000e0:	490f      	ldr	r1, [pc, #60]	; (c0d00120 <handleGetAddress+0x68>)
c0d000e2:	4638      	mov	r0, r7
c0d000e4:	f003 fab2 	bl	c0d0364c <getAddressStringFromBinary>

    //Check parameter1 to determine if we need to skip confirmation from the user.
    if (apdu->p1 == P1_NON_CONFIRM)
c0d000e8:	78b0      	ldrb	r0, [r6, #2]
c0d000ea:	2800      	cmp	r0, #0
c0d000ec:	d00b      	beq.n	c0d00106 <handleGetAddress+0x4e>
        THROW(0x9000);
    }
    else
    {
        //Register UI steps for returning address to the user.
        ux_flow_init(0, ux_display_public_flow, NULL);
c0d000ee:	490d      	ldr	r1, [pc, #52]	; (c0d00124 <handleGetAddress+0x6c>)
c0d000f0:	4479      	add	r1, pc
c0d000f2:	2000      	movs	r0, #0
c0d000f4:	4602      	mov	r2, r0
c0d000f6:	f003 fcbf 	bl	c0d03a78 <ux_flow_init>

        //Set flags to indicate that user input is required to continue.
        *flags |= IO_ASYNCH_REPLY;
c0d000fa:	6820      	ldr	r0, [r4, #0]
c0d000fc:	2110      	movs	r1, #16
c0d000fe:	4301      	orrs	r1, r0
c0d00100:	6021      	str	r1, [r4, #0]
    }
}
c0d00102:	b009      	add	sp, #36	; 0x24
c0d00104:	bdf0      	pop	{r4, r5, r6, r7, pc}

    //Check parameter1 to determine if we need to skip confirmation from the user.
    if (apdu->p1 == P1_NON_CONFIRM)
    {
        //Set address to the output buffer.
        *tx = set_result_get_address();
c0d00106:	f000 f80f 	bl	c0d00128 <set_result_get_address>
c0d0010a:	2068      	movs	r0, #104	; 0x68
c0d0010c:	6028      	str	r0, [r5, #0]
c0d0010e:	2009      	movs	r0, #9
c0d00110:	0300      	lsls	r0, r0, #12
        THROW(0x9000);
c0d00112:	f000 fd02 	bl	c0d00b1a <os_longjmp>
c0d00116:	46c0      	nop			; (mov r8, r8)
c0d00118:	20001828 	.word	0x20001828
c0d0011c:	2000182c 	.word	0x2000182c
c0d00120:	20001800 	.word	0x20001800
c0d00124:	000046c8 	.word	0x000046c8

c0d00128 <set_result_get_address>:

static char address_str[FULL_ADDRESS_LENGTH];
static char public_key_str[FULL_PUBKEY_LENGTH];
static uint32_t accountNum;

static uint8_t set_result_get_address() {
c0d00128:	b510      	push	{r4, lr}
    //Get the length of the address, strlen will work since it is base 58 encoded.
    const uint8_t address_size = FULL_ADDRESS_LENGTH;
    const uint8_t public_key_size = FULL_PUBKEY_LENGTH;

    //Copy address data to the output buffer
    os_memmove(G_io_apdu_buffer + tx, address_str, address_size);
c0d0012a:	4c06      	ldr	r4, [pc, #24]	; (c0d00144 <set_result_get_address+0x1c>)
c0d0012c:	4906      	ldr	r1, [pc, #24]	; (c0d00148 <set_result_get_address+0x20>)
c0d0012e:	2228      	movs	r2, #40	; 0x28
c0d00130:	4620      	mov	r0, r4
c0d00132:	f000 fcbf 	bl	c0d00ab4 <os_memmove>
    tx += address_size;

    //Copy Public Key data to output buffer
    os_memmove(G_io_apdu_buffer + tx, public_key_str, public_key_size);
c0d00136:	3428      	adds	r4, #40	; 0x28
c0d00138:	4904      	ldr	r1, [pc, #16]	; (c0d0014c <set_result_get_address+0x24>)
c0d0013a:	2240      	movs	r2, #64	; 0x40
c0d0013c:	4620      	mov	r0, r4
c0d0013e:	f000 fcb9 	bl	c0d00ab4 <os_memmove>
c0d00142:	bd10      	pop	{r4, pc}
c0d00144:	20001a8e 	.word	0x20001a8e
c0d00148:	20001800 	.word	0x20001800
c0d0014c:	2000182c 	.word	0x2000182c

c0d00150 <handleApdu>:
#include "signRawTx.h"
#include "menu.h"

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

void handleApdu(volatile unsigned int *flags, volatile unsigned int *tx) {
c0d00150:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00152:	b091      	sub	sp, #68	; 0x44
c0d00154:	460c      	mov	r4, r1
c0d00156:	4606      	mov	r6, r0
c0d00158:	af01      	add	r7, sp, #4

    unsigned short sw = 0;
    struct apduMessage apdu_input;

    BEGIN_TRY {
        TRY {
c0d0015a:	4638      	mov	r0, r7
c0d0015c:	f004 fa98 	bl	c0d04690 <setjmp>
c0d00160:	4605      	mov	r5, r0
c0d00162:	85b8      	strh	r0, [r7, #44]	; 0x2c
c0d00164:	b280      	uxth	r0, r0
c0d00166:	2800      	cmp	r0, #0
c0d00168:	d018      	beq.n	c0d0019c <handleApdu+0x4c>
c0d0016a:	2810      	cmp	r0, #16
c0d0016c:	d055      	beq.n	c0d0021a <handleApdu+0xca>
c0d0016e:	a801      	add	r0, sp, #4
c0d00170:	2100      	movs	r1, #0
            }
        }
        CATCH(EXCEPTION_IO_RESET) {
            THROW(EXCEPTION_IO_RESET);
        }
        CATCH_OTHER(e) {
c0d00172:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d00174:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00176:	f001 fd41 	bl	c0d01bfc <try_context_set>
c0d0017a:	200f      	movs	r0, #15
c0d0017c:	0300      	lsls	r0, r0, #12
        switch (e & 0xF000) {
c0d0017e:	4028      	ands	r0, r5
c0d00180:	2109      	movs	r1, #9
c0d00182:	0309      	lsls	r1, r1, #12
c0d00184:	4288      	cmp	r0, r1
c0d00186:	d003      	beq.n	c0d00190 <handleApdu+0x40>
c0d00188:	2103      	movs	r1, #3
c0d0018a:	0349      	lsls	r1, r1, #13
c0d0018c:	4288      	cmp	r0, r1
c0d0018e:	d12a      	bne.n	c0d001e6 <handleApdu+0x96>
c0d00190:	20ff      	movs	r0, #255	; 0xff
c0d00192:	0200      	lsls	r0, r0, #8

    unsigned short sw = 0;
    struct apduMessage apdu_input;

    BEGIN_TRY {
        TRY {
c0d00194:	4629      	mov	r1, r5
c0d00196:	4001      	ands	r1, r0
c0d00198:	0a08      	lsrs	r0, r1, #8
c0d0019a:	e027      	b.n	c0d001ec <handleApdu+0x9c>
c0d0019c:	a801      	add	r0, sp, #4
c0d0019e:	f001 fd2d 	bl	c0d01bfc <try_context_set>
c0d001a2:	900b      	str	r0, [sp, #44]	; 0x2c
c0d001a4:	ad0d      	add	r5, sp, #52	; 0x34
            parseAPDU(&apdu_input);
c0d001a6:	4628      	mov	r0, r5
c0d001a8:	f003 faf8 	bl	c0d0379c <parseAPDU>

            if (apdu_input.cla != CLA) {
c0d001ac:	7828      	ldrb	r0, [r5, #0]
c0d001ae:	28e0      	cmp	r0, #224	; 0xe0
c0d001b0:	d15d      	bne.n	c0d0026e <handleApdu+0x11e>
c0d001b2:	a80d      	add	r0, sp, #52	; 0x34
                THROW(0x6E00);
            }

            switch (apdu_input.ins) {
c0d001b4:	7840      	ldrb	r0, [r0, #1]
c0d001b6:	2802      	cmp	r0, #2
c0d001b8:	d00b      	beq.n	c0d001d2 <handleApdu+0x82>
c0d001ba:	2803      	cmp	r0, #3
c0d001bc:	d136      	bne.n	c0d0022c <handleApdu+0xdc>
c0d001be:	ad0d      	add	r5, sp, #52	; 0x34
                    parseGetAddressData(&apdu_input);
                    handleGetAddress(&apdu_input, flags, tx);
                    break;

                case INS_SIGN_TX:
                    parseSignRawTxData(&apdu_input);
c0d001c0:	4628      	mov	r0, r5
c0d001c2:	f001 fb97 	bl	c0d018f4 <parseSignRawTxData>
                    handleSignRawTx(&apdu_input, flags, tx);
c0d001c6:	4628      	mov	r0, r5
c0d001c8:	4631      	mov	r1, r6
c0d001ca:	4622      	mov	r2, r4
c0d001cc:	f001 fba8 	bl	c0d01920 <handleSignRawTx>
c0d001d0:	e015      	b.n	c0d001fe <handleApdu+0xae>
c0d001d2:	ad0d      	add	r5, sp, #52	; 0x34
                    *tx = 4;
                    THROW(0x9000);
                    break;

                case INS_GET_ADDR:
                    parseGetAddressData(&apdu_input);
c0d001d4:	4628      	mov	r0, r5
c0d001d6:	f7ff ff65 	bl	c0d000a4 <parseGetAddressData>
                    handleGetAddress(&apdu_input, flags, tx);
c0d001da:	4628      	mov	r0, r5
c0d001dc:	4631      	mov	r1, r6
c0d001de:	4622      	mov	r2, r4
c0d001e0:	f7ff ff6a 	bl	c0d000b8 <handleGetAddress>
c0d001e4:	e00b      	b.n	c0d001fe <handleApdu+0xae>
                sw = e;
                break;
            default:
                // Internal error
                sw = 0x6800 | (e & 0x7FF);
                break;
c0d001e6:	0568      	lsls	r0, r5, #21
c0d001e8:	0f40      	lsrs	r0, r0, #29
c0d001ea:	3068      	adds	r0, #104	; 0x68
            }
            // Unexpected exception => report
            G_io_apdu_buffer[*tx] = sw >> 8;
c0d001ec:	6821      	ldr	r1, [r4, #0]
c0d001ee:	4a24      	ldr	r2, [pc, #144]	; (c0d00280 <handleApdu+0x130>)
c0d001f0:	5450      	strb	r0, [r2, r1]
            G_io_apdu_buffer[*tx + 1] = sw;
c0d001f2:	6820      	ldr	r0, [r4, #0]
                // Internal error
                sw = 0x6800 | (e & 0x7FF);
                break;
            }
            // Unexpected exception => report
            G_io_apdu_buffer[*tx] = sw >> 8;
c0d001f4:	1810      	adds	r0, r2, r0
            G_io_apdu_buffer[*tx + 1] = sw;
c0d001f6:	7045      	strb	r5, [r0, #1]
            *tx += 2;
c0d001f8:	6820      	ldr	r0, [r4, #0]
c0d001fa:	1c80      	adds	r0, r0, #2
c0d001fc:	6020      	str	r0, [r4, #0]
        }
        FINALLY {
c0d001fe:	f001 fcf1 	bl	c0d01be4 <try_context_get>
c0d00202:	a901      	add	r1, sp, #4
c0d00204:	4288      	cmp	r0, r1
c0d00206:	d102      	bne.n	c0d0020e <handleApdu+0xbe>
c0d00208:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0020a:	f001 fcf7 	bl	c0d01bfc <try_context_set>
c0d0020e:	a801      	add	r0, sp, #4
        }
    }
    END_TRY;
c0d00210:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d00212:	2800      	cmp	r0, #0
c0d00214:	d12d      	bne.n	c0d00272 <handleApdu+0x122>

}
c0d00216:	b011      	add	sp, #68	; 0x44
c0d00218:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0021a:	a801      	add	r0, sp, #4
c0d0021c:	2100      	movs	r1, #0
                default:
                    THROW(0x6D00);
                    break;
            }
        }
        CATCH(EXCEPTION_IO_RESET) {
c0d0021e:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d00220:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00222:	f001 fceb 	bl	c0d01bfc <try_context_set>
c0d00226:	2010      	movs	r0, #16
            THROW(EXCEPTION_IO_RESET);
c0d00228:	f000 fc77 	bl	c0d00b1a <os_longjmp>

            if (apdu_input.cla != CLA) {
                THROW(0x6E00);
            }

            switch (apdu_input.ins) {
c0d0022c:	2801      	cmp	r0, #1
c0d0022e:	d122      	bne.n	c0d00276 <handleApdu+0x126>

                case INS_GET_APP_CONFIGURATION:
                    G_io_apdu_buffer[0] = (N_storage.dummy_setting_1 ? 0x01 : 0x00);
c0d00230:	4d14      	ldr	r5, [pc, #80]	; (c0d00284 <handleApdu+0x134>)
c0d00232:	447d      	add	r5, pc
c0d00234:	4628      	mov	r0, r5
c0d00236:	f001 fb2b 	bl	c0d01890 <pic>
c0d0023a:	7800      	ldrb	r0, [r0, #0]
c0d0023c:	2601      	movs	r6, #1
c0d0023e:	2800      	cmp	r0, #0
c0d00240:	4631      	mov	r1, r6
c0d00242:	d100      	bne.n	c0d00246 <handleApdu+0xf6>
c0d00244:	4601      	mov	r1, r0
c0d00246:	4f0e      	ldr	r7, [pc, #56]	; (c0d00280 <handleApdu+0x130>)
c0d00248:	7039      	strb	r1, [r7, #0]
                    G_io_apdu_buffer[1] = (N_storage.dummy_setting_2 ? 0x01 : 0x00);
c0d0024a:	4628      	mov	r0, r5
c0d0024c:	f001 fb20 	bl	c0d01890 <pic>
c0d00250:	7840      	ldrb	r0, [r0, #1]
                    G_io_apdu_buffer[2] = LEDGER_MAJOR_VERSION;
c0d00252:	70be      	strb	r6, [r7, #2]
c0d00254:	2100      	movs	r1, #0
                    G_io_apdu_buffer[3] = LEDGER_MINOR_VERSION;
c0d00256:	70f9      	strb	r1, [r7, #3]
                    G_io_apdu_buffer[4] = LEDGER_PATCH_VERSION;
c0d00258:	7139      	strb	r1, [r7, #4]

            switch (apdu_input.ins) {

                case INS_GET_APP_CONFIGURATION:
                    G_io_apdu_buffer[0] = (N_storage.dummy_setting_1 ? 0x01 : 0x00);
                    G_io_apdu_buffer[1] = (N_storage.dummy_setting_2 ? 0x01 : 0x00);
c0d0025a:	2800      	cmp	r0, #0
c0d0025c:	d100      	bne.n	c0d00260 <handleApdu+0x110>
c0d0025e:	4606      	mov	r6, r0
c0d00260:	707e      	strb	r6, [r7, #1]
c0d00262:	2004      	movs	r0, #4
                    G_io_apdu_buffer[2] = LEDGER_MAJOR_VERSION;
                    G_io_apdu_buffer[3] = LEDGER_MINOR_VERSION;
                    G_io_apdu_buffer[4] = LEDGER_PATCH_VERSION;
                    *tx = 4;
c0d00264:	6020      	str	r0, [r4, #0]
c0d00266:	2009      	movs	r0, #9
c0d00268:	0300      	lsls	r0, r0, #12
                    THROW(0x9000);
c0d0026a:	f000 fc56 	bl	c0d00b1a <os_longjmp>
c0d0026e:	2037      	movs	r0, #55	; 0x37
c0d00270:	0240      	lsls	r0, r0, #9
c0d00272:	f000 fc52 	bl	c0d00b1a <os_longjmp>
c0d00276:	206d      	movs	r0, #109	; 0x6d
c0d00278:	0200      	lsls	r0, r0, #8
                    parseSignRawTxData(&apdu_input);
                    handleSignRawTx(&apdu_input, flags, tx);
                    break;

                default:
                    THROW(0x6D00);
c0d0027a:	f000 fc4e 	bl	c0d00b1a <os_longjmp>
c0d0027e:	46c0      	nop			; (mov r8, r8)
c0d00280:	20001a8e 	.word	0x20001a8e
c0d00284:	0000500a 	.word	0x0000500a

c0d00288 <app_main>:
    }
    END_TRY;

}

void app_main(void) {
c0d00288:	b090      	sub	sp, #64	; 0x40
c0d0028a:	2600      	movs	r6, #0
    volatile unsigned int rx = 0;
c0d0028c:	960f      	str	r6, [sp, #60]	; 0x3c
    volatile unsigned int tx = 0;
c0d0028e:	960e      	str	r6, [sp, #56]	; 0x38
    volatile unsigned int flags = 0;
c0d00290:	960d      	str	r6, [sp, #52]	; 0x34
c0d00292:	4f37      	ldr	r7, [pc, #220]	; (c0d00370 <app_main+0xe8>)
c0d00294:	a80c      	add	r0, sp, #48	; 0x30
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00296:	8006      	strh	r6, [r0, #0]
c0d00298:	466d      	mov	r5, sp

        BEGIN_TRY {
            TRY {
c0d0029a:	4628      	mov	r0, r5
c0d0029c:	f004 f9f8 	bl	c0d04690 <setjmp>
c0d002a0:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d002a2:	b285      	uxth	r5, r0
c0d002a4:	2d00      	cmp	r5, #0
c0d002a6:	d015      	beq.n	c0d002d4 <app_main+0x4c>
c0d002a8:	2d10      	cmp	r5, #16
c0d002aa:	d051      	beq.n	c0d00350 <app_main+0xc8>
c0d002ac:	4604      	mov	r4, r0
c0d002ae:	4668      	mov	r0, sp
                handleApdu(&flags, &tx);
            }
            CATCH(EXCEPTION_IO_RESET) {
              THROW(EXCEPTION_IO_RESET);
            }
            CATCH_OTHER(e) {
c0d002b0:	8586      	strh	r6, [r0, #44]	; 0x2c
c0d002b2:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d002b4:	f001 fca2 	bl	c0d01bfc <try_context_set>
c0d002b8:	200f      	movs	r0, #15
c0d002ba:	0301      	lsls	r1, r0, #12
                switch (e & 0xF000) {
c0d002bc:	4021      	ands	r1, r4
c0d002be:	2009      	movs	r0, #9
c0d002c0:	0300      	lsls	r0, r0, #12
c0d002c2:	4281      	cmp	r1, r0
c0d002c4:	d003      	beq.n	c0d002ce <app_main+0x46>
c0d002c6:	2203      	movs	r2, #3
c0d002c8:	0352      	lsls	r2, r2, #13
c0d002ca:	4291      	cmp	r1, r2
c0d002cc:	d11a      	bne.n	c0d00304 <app_main+0x7c>
c0d002ce:	a90c      	add	r1, sp, #48	; 0x30
c0d002d0:	800c      	strh	r4, [r1, #0]
c0d002d2:	e01e      	b.n	c0d00312 <app_main+0x8a>
c0d002d4:	4668      	mov	r0, sp
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
c0d002d6:	f001 fc91 	bl	c0d01bfc <try_context_set>
                rx = tx;
c0d002da:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d002dc:	910f      	str	r1, [sp, #60]	; 0x3c
c0d002de:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d002e0:	940e      	str	r4, [sp, #56]	; 0x38
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
c0d002e2:	900a      	str	r0, [sp, #40]	; 0x28
                rx = tx;
                tx = 0; // ensure no race in catch_other if io_exchange throws
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d002e4:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d002e6:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d002e8:	b2c0      	uxtb	r0, r0
c0d002ea:	b289      	uxth	r1, r1
c0d002ec:	f000 fe58 	bl	c0d00fa0 <io_exchange>
c0d002f0:	900f      	str	r0, [sp, #60]	; 0x3c
                flags = 0;
c0d002f2:	940d      	str	r4, [sp, #52]	; 0x34

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d002f4:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d002f6:	2800      	cmp	r0, #0
c0d002f8:	d032      	beq.n	c0d00360 <app_main+0xd8>
c0d002fa:	a80d      	add	r0, sp, #52	; 0x34
c0d002fc:	a90e      	add	r1, sp, #56	; 0x38
                    THROW(0x6982);
                }

                PRINTF("New APDU received:\n%.*H\n", rx, G_io_apdu_buffer);

                handleApdu(&flags, &tx);
c0d002fe:	f7ff ff27 	bl	c0d00150 <handleApdu>
c0d00302:	e017      	b.n	c0d00334 <app_main+0xac>
                        // All is well
                        sw = e;
                        break;
                    default:
                        // Internal error
                        sw = 0x6800 | (e & 0x7FF);
c0d00304:	4919      	ldr	r1, [pc, #100]	; (c0d0036c <app_main+0xe4>)
c0d00306:	400c      	ands	r4, r1
c0d00308:	210d      	movs	r1, #13
c0d0030a:	02c9      	lsls	r1, r1, #11
c0d0030c:	1861      	adds	r1, r4, r1
c0d0030e:	aa0c      	add	r2, sp, #48	; 0x30
c0d00310:	8011      	strh	r1, [r2, #0]
                        break;
                }
                if (e != 0x9000) {
c0d00312:	4285      	cmp	r5, r0
c0d00314:	d003      	beq.n	c0d0031e <app_main+0x96>
c0d00316:	2010      	movs	r0, #16
                    flags &= ~IO_ASYNCH_REPLY;
c0d00318:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d0031a:	4381      	bics	r1, r0
c0d0031c:	910d      	str	r1, [sp, #52]	; 0x34
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d0031e:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00320:	0a00      	lsrs	r0, r0, #8
c0d00322:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d00324:	5478      	strb	r0, [r7, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00326:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00328:	990e      	ldr	r1, [sp, #56]	; 0x38
                }
                if (e != 0x9000) {
                    flags &= ~IO_ASYNCH_REPLY;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d0032a:	1879      	adds	r1, r7, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d0032c:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d0032e:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00330:	1c80      	adds	r0, r0, #2
c0d00332:	900e      	str	r0, [sp, #56]	; 0x38
            }
            FINALLY {
c0d00334:	f001 fc56 	bl	c0d01be4 <try_context_get>
c0d00338:	4669      	mov	r1, sp
c0d0033a:	4288      	cmp	r0, r1
c0d0033c:	d102      	bne.n	c0d00344 <app_main+0xbc>
c0d0033e:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00340:	f001 fc5c 	bl	c0d01bfc <try_context_set>
c0d00344:	4668      	mov	r0, sp
            }
        }
        END_TRY;
c0d00346:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d00348:	2800      	cmp	r0, #0
c0d0034a:	d0a3      	beq.n	c0d00294 <app_main+0xc>
c0d0034c:	f000 fbe5 	bl	c0d00b1a <os_longjmp>
c0d00350:	4668      	mov	r0, sp

                PRINTF("New APDU received:\n%.*H\n", rx, G_io_apdu_buffer);

                handleApdu(&flags, &tx);
            }
            CATCH(EXCEPTION_IO_RESET) {
c0d00352:	8586      	strh	r6, [r0, #44]	; 0x2c
c0d00354:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00356:	f001 fc51 	bl	c0d01bfc <try_context_set>
c0d0035a:	2010      	movs	r0, #16
              THROW(EXCEPTION_IO_RESET);
c0d0035c:	f000 fbdd 	bl	c0d00b1a <os_longjmp>
c0d00360:	4801      	ldr	r0, [pc, #4]	; (c0d00368 <app_main+0xe0>)
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    THROW(0x6982);
c0d00362:	f000 fbda 	bl	c0d00b1a <os_longjmp>
c0d00366:	46c0      	nop			; (mov r8, r8)
c0d00368:	00006982 	.word	0x00006982
c0d0036c:	000007ff 	.word	0x000007ff
c0d00370:	20001a8e 	.word	0x20001a8e

c0d00374 <io_seproxyhal_display>:
//return_to_dashboard:
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
c0d00374:	b580      	push	{r7, lr}
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d00376:	f000 fd79 	bl	c0d00e6c <io_seproxyhal_display_default>
}
c0d0037a:	bd80      	pop	{r7, pc}

c0d0037c <io_event>:

unsigned char io_event(unsigned char channel) {
c0d0037c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0037e:	b081      	sub	sp, #4
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00380:	4dfb      	ldr	r5, [pc, #1004]	; (c0d00770 <io_event+0x3f4>)
c0d00382:	7828      	ldrb	r0, [r5, #0]
c0d00384:	280c      	cmp	r0, #12
c0d00386:	dd10      	ble.n	c0d003aa <io_event+0x2e>
c0d00388:	280d      	cmp	r0, #13
c0d0038a:	d069      	beq.n	c0d00460 <io_event+0xe4>
c0d0038c:	280e      	cmp	r0, #14
c0d0038e:	d100      	bne.n	c0d00392 <io_event+0x16>
c0d00390:	e0b2      	b.n	c0d004f8 <io_event+0x17c>
c0d00392:	2815      	cmp	r0, #21
c0d00394:	d10f      	bne.n	c0d003b6 <io_event+0x3a>
        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
            break;

        case SEPROXYHAL_TAG_STATUS_EVENT:
            if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID && !(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d00396:	48f7      	ldr	r0, [pc, #988]	; (c0d00774 <io_event+0x3f8>)
c0d00398:	7980      	ldrb	r0, [r0, #6]
c0d0039a:	2801      	cmp	r0, #1
c0d0039c:	d10b      	bne.n	c0d003b6 <io_event+0x3a>
c0d0039e:	79a8      	ldrb	r0, [r5, #6]
c0d003a0:	0700      	lsls	r0, r0, #28
c0d003a2:	d408      	bmi.n	c0d003b6 <io_event+0x3a>
c0d003a4:	2010      	movs	r0, #16
                THROW(EXCEPTION_IO_RESET);
c0d003a6:	f000 fbb8 	bl	c0d00b1a <os_longjmp>
unsigned char io_event(unsigned char channel) {
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d003aa:	2805      	cmp	r0, #5
c0d003ac:	d100      	bne.n	c0d003b0 <io_event+0x34>
c0d003ae:	e0f8      	b.n	c0d005a2 <io_event+0x226>
c0d003b0:	280c      	cmp	r0, #12
c0d003b2:	d100      	bne.n	c0d003b6 <io_event+0x3a>
c0d003b4:	e266      	b.n	c0d00884 <io_event+0x508>
            if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID && !(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
                THROW(EXCEPTION_IO_RESET);
            }
            // no break is intentional
        default:
            UX_DEFAULT_EVENT();
c0d003b6:	4cf0      	ldr	r4, [pc, #960]	; (c0d00778 <io_event+0x3fc>)
c0d003b8:	2700      	movs	r7, #0
c0d003ba:	6067      	str	r7, [r4, #4]
c0d003bc:	2001      	movs	r0, #1
c0d003be:	7020      	strb	r0, [r4, #0]
c0d003c0:	4620      	mov	r0, r4
c0d003c2:	f001 fbb5 	bl	c0d01b30 <os_ux>
c0d003c6:	2004      	movs	r0, #4
c0d003c8:	f001 fc24 	bl	c0d01c14 <os_sched_last_status>
c0d003cc:	6060      	str	r0, [r4, #4]
c0d003ce:	2869      	cmp	r0, #105	; 0x69
c0d003d0:	d000      	beq.n	c0d003d4 <io_event+0x58>
c0d003d2:	e141      	b.n	c0d00658 <io_event+0x2dc>
c0d003d4:	f000 fcf0 	bl	c0d00db8 <io_seproxyhal_init_ux>
c0d003d8:	f000 fcf0 	bl	c0d00dbc <io_seproxyhal_init_button>
c0d003dc:	25be      	movs	r5, #190	; 0xbe
c0d003de:	4ee7      	ldr	r6, [pc, #924]	; (c0d0077c <io_event+0x400>)
c0d003e0:	5377      	strh	r7, [r6, r5]
c0d003e2:	2004      	movs	r0, #4
c0d003e4:	f001 fc16 	bl	c0d01c14 <os_sched_last_status>
c0d003e8:	6060      	str	r0, [r4, #4]
c0d003ea:	24c0      	movs	r4, #192	; 0xc0
c0d003ec:	5931      	ldr	r1, [r6, r4]
c0d003ee:	2900      	cmp	r1, #0
c0d003f0:	d100      	bne.n	c0d003f4 <io_event+0x78>
c0d003f2:	e247      	b.n	c0d00884 <io_event+0x508>
c0d003f4:	2800      	cmp	r0, #0
c0d003f6:	d100      	bne.n	c0d003fa <io_event+0x7e>
c0d003f8:	e244      	b.n	c0d00884 <io_event+0x508>
c0d003fa:	2897      	cmp	r0, #151	; 0x97
c0d003fc:	d100      	bne.n	c0d00400 <io_event+0x84>
c0d003fe:	e241      	b.n	c0d00884 <io_event+0x508>
c0d00400:	5b70      	ldrh	r0, [r6, r5]
c0d00402:	27aa      	movs	r7, #170	; 0xaa
c0d00404:	21c4      	movs	r1, #196	; 0xc4
c0d00406:	5c71      	ldrb	r1, [r6, r1]
c0d00408:	b280      	uxth	r0, r0
c0d0040a:	4288      	cmp	r0, r1
c0d0040c:	d300      	bcc.n	c0d00410 <io_event+0x94>
c0d0040e:	e239      	b.n	c0d00884 <io_event+0x508>
c0d00410:	f001 fbcc 	bl	c0d01bac <io_seph_is_status_sent>
c0d00414:	2800      	cmp	r0, #0
c0d00416:	d000      	beq.n	c0d0041a <io_event+0x9e>
c0d00418:	e234      	b.n	c0d00884 <io_event+0x508>
c0d0041a:	f001 fb4d 	bl	c0d01ab8 <os_perso_isonboarded>
c0d0041e:	42b8      	cmp	r0, r7
c0d00420:	d104      	bne.n	c0d0042c <io_event+0xb0>
c0d00422:	f001 fb79 	bl	c0d01b18 <os_global_pin_is_validated>
c0d00426:	42b8      	cmp	r0, r7
c0d00428:	d000      	beq.n	c0d0042c <io_event+0xb0>
c0d0042a:	e22b      	b.n	c0d00884 <io_event+0x508>
c0d0042c:	5930      	ldr	r0, [r6, r4]
c0d0042e:	5b71      	ldrh	r1, [r6, r5]
c0d00430:	0149      	lsls	r1, r1, #5
c0d00432:	1840      	adds	r0, r0, r1
c0d00434:	21cc      	movs	r1, #204	; 0xcc
c0d00436:	5871      	ldr	r1, [r6, r1]
c0d00438:	2900      	cmp	r1, #0
c0d0043a:	d002      	beq.n	c0d00442 <io_event+0xc6>
c0d0043c:	4788      	blx	r1
c0d0043e:	2800      	cmp	r0, #0
c0d00440:	d007      	beq.n	c0d00452 <io_event+0xd6>
c0d00442:	2801      	cmp	r0, #1
c0d00444:	d103      	bne.n	c0d0044e <io_event+0xd2>
c0d00446:	5930      	ldr	r0, [r6, r4]
c0d00448:	5b71      	ldrh	r1, [r6, r5]
c0d0044a:	0149      	lsls	r1, r1, #5
c0d0044c:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d0044e:	f000 fd0d 	bl	c0d00e6c <io_seproxyhal_display_default>
            if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID && !(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
                THROW(EXCEPTION_IO_RESET);
            }
            // no break is intentional
        default:
            UX_DEFAULT_EVENT();
c0d00452:	5b70      	ldrh	r0, [r6, r5]
c0d00454:	1c40      	adds	r0, r0, #1
c0d00456:	5370      	strh	r0, [r6, r5]
c0d00458:	5931      	ldr	r1, [r6, r4]
c0d0045a:	2900      	cmp	r1, #0
c0d0045c:	d1d2      	bne.n	c0d00404 <io_event+0x88>
c0d0045e:	e211      	b.n	c0d00884 <io_event+0x508>
            break;

        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
c0d00460:	4cc5      	ldr	r4, [pc, #788]	; (c0d00778 <io_event+0x3fc>)
c0d00462:	2700      	movs	r7, #0
c0d00464:	6067      	str	r7, [r4, #4]
c0d00466:	2001      	movs	r0, #1
c0d00468:	7020      	strb	r0, [r4, #0]
c0d0046a:	4620      	mov	r0, r4
c0d0046c:	f001 fb60 	bl	c0d01b30 <os_ux>
c0d00470:	2004      	movs	r0, #4
c0d00472:	f001 fbcf 	bl	c0d01c14 <os_sched_last_status>
c0d00476:	6060      	str	r0, [r4, #4]
c0d00478:	2800      	cmp	r0, #0
c0d0047a:	d100      	bne.n	c0d0047e <io_event+0x102>
c0d0047c:	e202      	b.n	c0d00884 <io_event+0x508>
c0d0047e:	2869      	cmp	r0, #105	; 0x69
c0d00480:	d100      	bne.n	c0d00484 <io_event+0x108>
c0d00482:	e17d      	b.n	c0d00780 <io_event+0x404>
c0d00484:	2897      	cmp	r0, #151	; 0x97
c0d00486:	d100      	bne.n	c0d0048a <io_event+0x10e>
c0d00488:	e1fc      	b.n	c0d00884 <io_event+0x508>
c0d0048a:	25c0      	movs	r5, #192	; 0xc0
c0d0048c:	4cbb      	ldr	r4, [pc, #748]	; (c0d0077c <io_event+0x400>)
c0d0048e:	5960      	ldr	r0, [r4, r5]
c0d00490:	2800      	cmp	r0, #0
c0d00492:	d100      	bne.n	c0d00496 <io_event+0x11a>
c0d00494:	e1ee      	b.n	c0d00874 <io_event+0x4f8>
c0d00496:	26be      	movs	r6, #190	; 0xbe
c0d00498:	5ba0      	ldrh	r0, [r4, r6]
c0d0049a:	27aa      	movs	r7, #170	; 0xaa
c0d0049c:	21c4      	movs	r1, #196	; 0xc4
c0d0049e:	5c61      	ldrb	r1, [r4, r1]
c0d004a0:	b280      	uxth	r0, r0
c0d004a2:	4288      	cmp	r0, r1
c0d004a4:	d300      	bcc.n	c0d004a8 <io_event+0x12c>
c0d004a6:	e1e5      	b.n	c0d00874 <io_event+0x4f8>
c0d004a8:	f001 fb80 	bl	c0d01bac <io_seph_is_status_sent>
c0d004ac:	2800      	cmp	r0, #0
c0d004ae:	d000      	beq.n	c0d004b2 <io_event+0x136>
c0d004b0:	e1e0      	b.n	c0d00874 <io_event+0x4f8>
c0d004b2:	f001 fb01 	bl	c0d01ab8 <os_perso_isonboarded>
c0d004b6:	42b8      	cmp	r0, r7
c0d004b8:	d104      	bne.n	c0d004c4 <io_event+0x148>
c0d004ba:	f001 fb2d 	bl	c0d01b18 <os_global_pin_is_validated>
c0d004be:	42b8      	cmp	r0, r7
c0d004c0:	d000      	beq.n	c0d004c4 <io_event+0x148>
c0d004c2:	e1d7      	b.n	c0d00874 <io_event+0x4f8>
c0d004c4:	5960      	ldr	r0, [r4, r5]
c0d004c6:	5ba1      	ldrh	r1, [r4, r6]
c0d004c8:	0149      	lsls	r1, r1, #5
c0d004ca:	1840      	adds	r0, r0, r1
c0d004cc:	21cc      	movs	r1, #204	; 0xcc
c0d004ce:	5861      	ldr	r1, [r4, r1]
c0d004d0:	2900      	cmp	r1, #0
c0d004d2:	d002      	beq.n	c0d004da <io_event+0x15e>
c0d004d4:	4788      	blx	r1
c0d004d6:	2800      	cmp	r0, #0
c0d004d8:	d007      	beq.n	c0d004ea <io_event+0x16e>
c0d004da:	2801      	cmp	r0, #1
c0d004dc:	d103      	bne.n	c0d004e6 <io_event+0x16a>
c0d004de:	5960      	ldr	r0, [r4, r5]
c0d004e0:	5ba1      	ldrh	r1, [r4, r6]
c0d004e2:	0149      	lsls	r1, r1, #5
c0d004e4:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d004e6:	f000 fcc1 	bl	c0d00e6c <io_seproxyhal_display_default>
        default:
            UX_DEFAULT_EVENT();
            break;

        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
c0d004ea:	5ba0      	ldrh	r0, [r4, r6]
c0d004ec:	1c40      	adds	r0, r0, #1
c0d004ee:	53a0      	strh	r0, [r4, r6]
c0d004f0:	5961      	ldr	r1, [r4, r5]
c0d004f2:	2900      	cmp	r1, #0
c0d004f4:	d1d2      	bne.n	c0d0049c <io_event+0x120>
c0d004f6:	e1bd      	b.n	c0d00874 <io_event+0x4f8>
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT:
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer,
c0d004f8:	4d9f      	ldr	r5, [pc, #636]	; (c0d00778 <io_event+0x3fc>)
c0d004fa:	2700      	movs	r7, #0
c0d004fc:	606f      	str	r7, [r5, #4]
c0d004fe:	2001      	movs	r0, #1
c0d00500:	7028      	strb	r0, [r5, #0]
c0d00502:	4628      	mov	r0, r5
c0d00504:	f001 fb14 	bl	c0d01b30 <os_ux>
c0d00508:	2004      	movs	r0, #4
c0d0050a:	f001 fb83 	bl	c0d01c14 <os_sched_last_status>
c0d0050e:	6068      	str	r0, [r5, #4]
c0d00510:	2869      	cmp	r0, #105	; 0x69
c0d00512:	d000      	beq.n	c0d00516 <io_event+0x19a>
c0d00514:	e0d7      	b.n	c0d006c6 <io_event+0x34a>
c0d00516:	f000 fc4f 	bl	c0d00db8 <io_seproxyhal_init_ux>
c0d0051a:	f000 fc4f 	bl	c0d00dbc <io_seproxyhal_init_button>
c0d0051e:	24be      	movs	r4, #190	; 0xbe
c0d00520:	4e96      	ldr	r6, [pc, #600]	; (c0d0077c <io_event+0x400>)
c0d00522:	5337      	strh	r7, [r6, r4]
c0d00524:	2004      	movs	r0, #4
c0d00526:	f001 fb75 	bl	c0d01c14 <os_sched_last_status>
c0d0052a:	6068      	str	r0, [r5, #4]
c0d0052c:	25c0      	movs	r5, #192	; 0xc0
c0d0052e:	5971      	ldr	r1, [r6, r5]
c0d00530:	2900      	cmp	r1, #0
c0d00532:	d100      	bne.n	c0d00536 <io_event+0x1ba>
c0d00534:	e1a6      	b.n	c0d00884 <io_event+0x508>
c0d00536:	2800      	cmp	r0, #0
c0d00538:	d100      	bne.n	c0d0053c <io_event+0x1c0>
c0d0053a:	e1a3      	b.n	c0d00884 <io_event+0x508>
c0d0053c:	2897      	cmp	r0, #151	; 0x97
c0d0053e:	d100      	bne.n	c0d00542 <io_event+0x1c6>
c0d00540:	e1a0      	b.n	c0d00884 <io_event+0x508>
c0d00542:	5b30      	ldrh	r0, [r6, r4]
c0d00544:	27aa      	movs	r7, #170	; 0xaa
c0d00546:	21c4      	movs	r1, #196	; 0xc4
c0d00548:	5c71      	ldrb	r1, [r6, r1]
c0d0054a:	b280      	uxth	r0, r0
c0d0054c:	4288      	cmp	r0, r1
c0d0054e:	d300      	bcc.n	c0d00552 <io_event+0x1d6>
c0d00550:	e198      	b.n	c0d00884 <io_event+0x508>
c0d00552:	f001 fb2b 	bl	c0d01bac <io_seph_is_status_sent>
c0d00556:	2800      	cmp	r0, #0
c0d00558:	d000      	beq.n	c0d0055c <io_event+0x1e0>
c0d0055a:	e193      	b.n	c0d00884 <io_event+0x508>
c0d0055c:	f001 faac 	bl	c0d01ab8 <os_perso_isonboarded>
c0d00560:	42b8      	cmp	r0, r7
c0d00562:	d104      	bne.n	c0d0056e <io_event+0x1f2>
c0d00564:	f001 fad8 	bl	c0d01b18 <os_global_pin_is_validated>
c0d00568:	42b8      	cmp	r0, r7
c0d0056a:	d000      	beq.n	c0d0056e <io_event+0x1f2>
c0d0056c:	e18a      	b.n	c0d00884 <io_event+0x508>
c0d0056e:	5970      	ldr	r0, [r6, r5]
c0d00570:	5b31      	ldrh	r1, [r6, r4]
c0d00572:	0149      	lsls	r1, r1, #5
c0d00574:	1840      	adds	r0, r0, r1
c0d00576:	21cc      	movs	r1, #204	; 0xcc
c0d00578:	5871      	ldr	r1, [r6, r1]
c0d0057a:	2900      	cmp	r1, #0
c0d0057c:	d002      	beq.n	c0d00584 <io_event+0x208>
c0d0057e:	4788      	blx	r1
c0d00580:	2800      	cmp	r0, #0
c0d00582:	d007      	beq.n	c0d00594 <io_event+0x218>
c0d00584:	2801      	cmp	r0, #1
c0d00586:	d103      	bne.n	c0d00590 <io_event+0x214>
c0d00588:	5970      	ldr	r0, [r6, r5]
c0d0058a:	5b31      	ldrh	r1, [r6, r4]
c0d0058c:	0149      	lsls	r1, r1, #5
c0d0058e:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d00590:	f000 fc6c 	bl	c0d00e6c <io_seproxyhal_display_default>
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT:
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer,
c0d00594:	5b30      	ldrh	r0, [r6, r4]
c0d00596:	1c40      	adds	r0, r0, #1
c0d00598:	5330      	strh	r0, [r6, r4]
c0d0059a:	5971      	ldr	r1, [r6, r5]
c0d0059c:	2900      	cmp	r1, #0
c0d0059e:	d1d2      	bne.n	c0d00546 <io_event+0x1ca>
c0d005a0:	e170      	b.n	c0d00884 <io_event+0x508>
        case SEPROXYHAL_TAG_FINGER_EVENT:
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
            break;

        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d005a2:	4cea      	ldr	r4, [pc, #936]	; (c0d0094c <io_event+0x5d0>)
c0d005a4:	2700      	movs	r7, #0
c0d005a6:	6067      	str	r7, [r4, #4]
c0d005a8:	2001      	movs	r0, #1
c0d005aa:	7020      	strb	r0, [r4, #0]
c0d005ac:	4620      	mov	r0, r4
c0d005ae:	f001 fabf 	bl	c0d01b30 <os_ux>
c0d005b2:	2004      	movs	r0, #4
c0d005b4:	f001 fb2e 	bl	c0d01c14 <os_sched_last_status>
c0d005b8:	6060      	str	r0, [r4, #4]
c0d005ba:	2800      	cmp	r0, #0
c0d005bc:	d100      	bne.n	c0d005c0 <io_event+0x244>
c0d005be:	e161      	b.n	c0d00884 <io_event+0x508>
c0d005c0:	2897      	cmp	r0, #151	; 0x97
c0d005c2:	d100      	bne.n	c0d005c6 <io_event+0x24a>
c0d005c4:	e15e      	b.n	c0d00884 <io_event+0x508>
c0d005c6:	2869      	cmp	r0, #105	; 0x69
c0d005c8:	d000      	beq.n	c0d005cc <io_event+0x250>
c0d005ca:	e119      	b.n	c0d00800 <io_event+0x484>
c0d005cc:	f000 fbf4 	bl	c0d00db8 <io_seproxyhal_init_ux>
c0d005d0:	f000 fbf4 	bl	c0d00dbc <io_seproxyhal_init_button>
c0d005d4:	25be      	movs	r5, #190	; 0xbe
c0d005d6:	4ede      	ldr	r6, [pc, #888]	; (c0d00950 <io_event+0x5d4>)
c0d005d8:	5377      	strh	r7, [r6, r5]
c0d005da:	2004      	movs	r0, #4
c0d005dc:	f001 fb1a 	bl	c0d01c14 <os_sched_last_status>
c0d005e0:	6060      	str	r0, [r4, #4]
c0d005e2:	24c0      	movs	r4, #192	; 0xc0
c0d005e4:	5931      	ldr	r1, [r6, r4]
c0d005e6:	2900      	cmp	r1, #0
c0d005e8:	d100      	bne.n	c0d005ec <io_event+0x270>
c0d005ea:	e14b      	b.n	c0d00884 <io_event+0x508>
c0d005ec:	2800      	cmp	r0, #0
c0d005ee:	d100      	bne.n	c0d005f2 <io_event+0x276>
c0d005f0:	e148      	b.n	c0d00884 <io_event+0x508>
c0d005f2:	2897      	cmp	r0, #151	; 0x97
c0d005f4:	d100      	bne.n	c0d005f8 <io_event+0x27c>
c0d005f6:	e145      	b.n	c0d00884 <io_event+0x508>
c0d005f8:	5b70      	ldrh	r0, [r6, r5]
c0d005fa:	27aa      	movs	r7, #170	; 0xaa
c0d005fc:	21c4      	movs	r1, #196	; 0xc4
c0d005fe:	5c71      	ldrb	r1, [r6, r1]
c0d00600:	b280      	uxth	r0, r0
c0d00602:	4288      	cmp	r0, r1
c0d00604:	d300      	bcc.n	c0d00608 <io_event+0x28c>
c0d00606:	e13d      	b.n	c0d00884 <io_event+0x508>
c0d00608:	f001 fad0 	bl	c0d01bac <io_seph_is_status_sent>
c0d0060c:	2800      	cmp	r0, #0
c0d0060e:	d000      	beq.n	c0d00612 <io_event+0x296>
c0d00610:	e138      	b.n	c0d00884 <io_event+0x508>
c0d00612:	f001 fa51 	bl	c0d01ab8 <os_perso_isonboarded>
c0d00616:	42b8      	cmp	r0, r7
c0d00618:	d104      	bne.n	c0d00624 <io_event+0x2a8>
c0d0061a:	f001 fa7d 	bl	c0d01b18 <os_global_pin_is_validated>
c0d0061e:	42b8      	cmp	r0, r7
c0d00620:	d000      	beq.n	c0d00624 <io_event+0x2a8>
c0d00622:	e12f      	b.n	c0d00884 <io_event+0x508>
c0d00624:	5930      	ldr	r0, [r6, r4]
c0d00626:	5b71      	ldrh	r1, [r6, r5]
c0d00628:	0149      	lsls	r1, r1, #5
c0d0062a:	1840      	adds	r0, r0, r1
c0d0062c:	21cc      	movs	r1, #204	; 0xcc
c0d0062e:	5871      	ldr	r1, [r6, r1]
c0d00630:	2900      	cmp	r1, #0
c0d00632:	d002      	beq.n	c0d0063a <io_event+0x2be>
c0d00634:	4788      	blx	r1
c0d00636:	2800      	cmp	r0, #0
c0d00638:	d007      	beq.n	c0d0064a <io_event+0x2ce>
c0d0063a:	2801      	cmp	r0, #1
c0d0063c:	d103      	bne.n	c0d00646 <io_event+0x2ca>
c0d0063e:	5930      	ldr	r0, [r6, r4]
c0d00640:	5b71      	ldrh	r1, [r6, r5]
c0d00642:	0149      	lsls	r1, r1, #5
c0d00644:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d00646:	f000 fc11 	bl	c0d00e6c <io_seproxyhal_display_default>
        case SEPROXYHAL_TAG_FINGER_EVENT:
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
            break;

        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0064a:	5b70      	ldrh	r0, [r6, r5]
c0d0064c:	1c40      	adds	r0, r0, #1
c0d0064e:	5370      	strh	r0, [r6, r5]
c0d00650:	5931      	ldr	r1, [r6, r4]
c0d00652:	2900      	cmp	r1, #0
c0d00654:	d1d2      	bne.n	c0d005fc <io_event+0x280>
c0d00656:	e115      	b.n	c0d00884 <io_event+0x508>
c0d00658:	25c0      	movs	r5, #192	; 0xc0
            if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID && !(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
                THROW(EXCEPTION_IO_RESET);
            }
            // no break is intentional
        default:
            UX_DEFAULT_EVENT();
c0d0065a:	4cbd      	ldr	r4, [pc, #756]	; (c0d00950 <io_event+0x5d4>)
c0d0065c:	5960      	ldr	r0, [r4, r5]
c0d0065e:	2800      	cmp	r0, #0
c0d00660:	d100      	bne.n	c0d00664 <io_event+0x2e8>
c0d00662:	e107      	b.n	c0d00874 <io_event+0x4f8>
c0d00664:	26be      	movs	r6, #190	; 0xbe
c0d00666:	5ba0      	ldrh	r0, [r4, r6]
c0d00668:	27aa      	movs	r7, #170	; 0xaa
c0d0066a:	21c4      	movs	r1, #196	; 0xc4
c0d0066c:	5c61      	ldrb	r1, [r4, r1]
c0d0066e:	b280      	uxth	r0, r0
c0d00670:	4288      	cmp	r0, r1
c0d00672:	d300      	bcc.n	c0d00676 <io_event+0x2fa>
c0d00674:	e0fe      	b.n	c0d00874 <io_event+0x4f8>
c0d00676:	f001 fa99 	bl	c0d01bac <io_seph_is_status_sent>
c0d0067a:	2800      	cmp	r0, #0
c0d0067c:	d000      	beq.n	c0d00680 <io_event+0x304>
c0d0067e:	e0f9      	b.n	c0d00874 <io_event+0x4f8>
c0d00680:	f001 fa1a 	bl	c0d01ab8 <os_perso_isonboarded>
c0d00684:	42b8      	cmp	r0, r7
c0d00686:	d104      	bne.n	c0d00692 <io_event+0x316>
c0d00688:	f001 fa46 	bl	c0d01b18 <os_global_pin_is_validated>
c0d0068c:	42b8      	cmp	r0, r7
c0d0068e:	d000      	beq.n	c0d00692 <io_event+0x316>
c0d00690:	e0f0      	b.n	c0d00874 <io_event+0x4f8>
c0d00692:	5960      	ldr	r0, [r4, r5]
c0d00694:	5ba1      	ldrh	r1, [r4, r6]
c0d00696:	0149      	lsls	r1, r1, #5
c0d00698:	1840      	adds	r0, r0, r1
c0d0069a:	21cc      	movs	r1, #204	; 0xcc
c0d0069c:	5861      	ldr	r1, [r4, r1]
c0d0069e:	2900      	cmp	r1, #0
c0d006a0:	d002      	beq.n	c0d006a8 <io_event+0x32c>
c0d006a2:	4788      	blx	r1
c0d006a4:	2800      	cmp	r0, #0
c0d006a6:	d007      	beq.n	c0d006b8 <io_event+0x33c>
c0d006a8:	2801      	cmp	r0, #1
c0d006aa:	d103      	bne.n	c0d006b4 <io_event+0x338>
c0d006ac:	5960      	ldr	r0, [r4, r5]
c0d006ae:	5ba1      	ldrh	r1, [r4, r6]
c0d006b0:	0149      	lsls	r1, r1, #5
c0d006b2:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d006b4:	f000 fbda 	bl	c0d00e6c <io_seproxyhal_display_default>
            if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID && !(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
                THROW(EXCEPTION_IO_RESET);
            }
            // no break is intentional
        default:
            UX_DEFAULT_EVENT();
c0d006b8:	5ba0      	ldrh	r0, [r4, r6]
c0d006ba:	1c40      	adds	r0, r0, #1
c0d006bc:	53a0      	strh	r0, [r4, r6]
c0d006be:	5961      	ldr	r1, [r4, r5]
c0d006c0:	2900      	cmp	r1, #0
c0d006c2:	d1d2      	bne.n	c0d0066a <io_event+0x2ee>
c0d006c4:	e0d6      	b.n	c0d00874 <io_event+0x4f8>
c0d006c6:	4604      	mov	r4, r0
c0d006c8:	20d8      	movs	r0, #216	; 0xd8
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT:
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer,
c0d006ca:	4ea1      	ldr	r6, [pc, #644]	; (c0d00950 <io_event+0x5d4>)
c0d006cc:	5831      	ldr	r1, [r6, r0]
c0d006ce:	2900      	cmp	r1, #0
c0d006d0:	d011      	beq.n	c0d006f6 <io_event+0x37a>
c0d006d2:	2264      	movs	r2, #100	; 0x64
c0d006d4:	2964      	cmp	r1, #100	; 0x64
c0d006d6:	460b      	mov	r3, r1
c0d006d8:	d300      	bcc.n	c0d006dc <io_event+0x360>
c0d006da:	4613      	mov	r3, r2
c0d006dc:	1ac9      	subs	r1, r1, r3
c0d006de:	5031      	str	r1, [r6, r0]
c0d006e0:	d109      	bne.n	c0d006f6 <io_event+0x37a>
c0d006e2:	21d4      	movs	r1, #212	; 0xd4
c0d006e4:	5871      	ldr	r1, [r6, r1]
c0d006e6:	2900      	cmp	r1, #0
c0d006e8:	d100      	bne.n	c0d006ec <io_event+0x370>
c0d006ea:	e0d4      	b.n	c0d00896 <io_event+0x51a>
c0d006ec:	22dc      	movs	r2, #220	; 0xdc
c0d006ee:	58b2      	ldr	r2, [r6, r2]
c0d006f0:	5032      	str	r2, [r6, r0]
c0d006f2:	2000      	movs	r0, #0
c0d006f4:	4788      	blx	r1
c0d006f6:	2c00      	cmp	r4, #0
c0d006f8:	d100      	bne.n	c0d006fc <io_event+0x380>
c0d006fa:	e0c3      	b.n	c0d00884 <io_event+0x508>
c0d006fc:	2c97      	cmp	r4, #151	; 0x97
c0d006fe:	d100      	bne.n	c0d00702 <io_event+0x386>
c0d00700:	e0c0      	b.n	c0d00884 <io_event+0x508>
c0d00702:	24c0      	movs	r4, #192	; 0xc0
c0d00704:	5930      	ldr	r0, [r6, r4]
c0d00706:	2800      	cmp	r0, #0
c0d00708:	d02c      	beq.n	c0d00764 <io_event+0x3e8>
c0d0070a:	25be      	movs	r5, #190	; 0xbe
c0d0070c:	5b70      	ldrh	r0, [r6, r5]
c0d0070e:	27aa      	movs	r7, #170	; 0xaa
c0d00710:	21c4      	movs	r1, #196	; 0xc4
c0d00712:	5c71      	ldrb	r1, [r6, r1]
c0d00714:	b280      	uxth	r0, r0
c0d00716:	4288      	cmp	r0, r1
c0d00718:	d224      	bcs.n	c0d00764 <io_event+0x3e8>
c0d0071a:	f001 fa47 	bl	c0d01bac <io_seph_is_status_sent>
c0d0071e:	2800      	cmp	r0, #0
c0d00720:	d120      	bne.n	c0d00764 <io_event+0x3e8>
c0d00722:	f001 f9c9 	bl	c0d01ab8 <os_perso_isonboarded>
c0d00726:	42b8      	cmp	r0, r7
c0d00728:	d103      	bne.n	c0d00732 <io_event+0x3b6>
c0d0072a:	f001 f9f5 	bl	c0d01b18 <os_global_pin_is_validated>
c0d0072e:	42b8      	cmp	r0, r7
c0d00730:	d118      	bne.n	c0d00764 <io_event+0x3e8>
c0d00732:	5930      	ldr	r0, [r6, r4]
c0d00734:	5b71      	ldrh	r1, [r6, r5]
c0d00736:	0149      	lsls	r1, r1, #5
c0d00738:	1840      	adds	r0, r0, r1
c0d0073a:	21cc      	movs	r1, #204	; 0xcc
c0d0073c:	5871      	ldr	r1, [r6, r1]
c0d0073e:	2900      	cmp	r1, #0
c0d00740:	d002      	beq.n	c0d00748 <io_event+0x3cc>
c0d00742:	4788      	blx	r1
c0d00744:	2800      	cmp	r0, #0
c0d00746:	d007      	beq.n	c0d00758 <io_event+0x3dc>
c0d00748:	2801      	cmp	r0, #1
c0d0074a:	d103      	bne.n	c0d00754 <io_event+0x3d8>
c0d0074c:	5930      	ldr	r0, [r6, r4]
c0d0074e:	5b71      	ldrh	r1, [r6, r5]
c0d00750:	0149      	lsls	r1, r1, #5
c0d00752:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d00754:	f000 fb8a 	bl	c0d00e6c <io_seproxyhal_display_default>
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT:
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer,
c0d00758:	5b70      	ldrh	r0, [r6, r5]
c0d0075a:	1c40      	adds	r0, r0, #1
c0d0075c:	5370      	strh	r0, [r6, r5]
c0d0075e:	5931      	ldr	r1, [r6, r4]
c0d00760:	2900      	cmp	r1, #0
c0d00762:	d1d5      	bne.n	c0d00710 <io_event+0x394>
c0d00764:	20c4      	movs	r0, #196	; 0xc4
c0d00766:	5c30      	ldrb	r0, [r6, r0]
c0d00768:	21be      	movs	r1, #190	; 0xbe
c0d0076a:	5a71      	ldrh	r1, [r6, r1]
c0d0076c:	e086      	b.n	c0d0087c <io_event+0x500>
c0d0076e:	46c0      	nop			; (mov r8, r8)
c0d00770:	20001a0c 	.word	0x20001a0c
c0d00774:	20001be0 	.word	0x20001be0
c0d00778:	2000196c 	.word	0x2000196c
c0d0077c:	2000186c 	.word	0x2000186c
        default:
            UX_DEFAULT_EVENT();
            break;

        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
c0d00780:	f000 fb1a 	bl	c0d00db8 <io_seproxyhal_init_ux>
c0d00784:	f000 fb1a 	bl	c0d00dbc <io_seproxyhal_init_button>
c0d00788:	25be      	movs	r5, #190	; 0xbe
c0d0078a:	4e71      	ldr	r6, [pc, #452]	; (c0d00950 <io_event+0x5d4>)
c0d0078c:	5377      	strh	r7, [r6, r5]
c0d0078e:	2004      	movs	r0, #4
c0d00790:	f001 fa40 	bl	c0d01c14 <os_sched_last_status>
c0d00794:	6060      	str	r0, [r4, #4]
c0d00796:	24c0      	movs	r4, #192	; 0xc0
c0d00798:	5931      	ldr	r1, [r6, r4]
c0d0079a:	2900      	cmp	r1, #0
c0d0079c:	d072      	beq.n	c0d00884 <io_event+0x508>
c0d0079e:	2800      	cmp	r0, #0
c0d007a0:	d070      	beq.n	c0d00884 <io_event+0x508>
c0d007a2:	2897      	cmp	r0, #151	; 0x97
c0d007a4:	d06e      	beq.n	c0d00884 <io_event+0x508>
c0d007a6:	5b70      	ldrh	r0, [r6, r5]
c0d007a8:	27aa      	movs	r7, #170	; 0xaa
c0d007aa:	21c4      	movs	r1, #196	; 0xc4
c0d007ac:	5c71      	ldrb	r1, [r6, r1]
c0d007ae:	b280      	uxth	r0, r0
c0d007b0:	4288      	cmp	r0, r1
c0d007b2:	d267      	bcs.n	c0d00884 <io_event+0x508>
c0d007b4:	f001 f9fa 	bl	c0d01bac <io_seph_is_status_sent>
c0d007b8:	2800      	cmp	r0, #0
c0d007ba:	d163      	bne.n	c0d00884 <io_event+0x508>
c0d007bc:	f001 f97c 	bl	c0d01ab8 <os_perso_isonboarded>
c0d007c0:	42b8      	cmp	r0, r7
c0d007c2:	d103      	bne.n	c0d007cc <io_event+0x450>
c0d007c4:	f001 f9a8 	bl	c0d01b18 <os_global_pin_is_validated>
c0d007c8:	42b8      	cmp	r0, r7
c0d007ca:	d15b      	bne.n	c0d00884 <io_event+0x508>
c0d007cc:	5930      	ldr	r0, [r6, r4]
c0d007ce:	5b71      	ldrh	r1, [r6, r5]
c0d007d0:	0149      	lsls	r1, r1, #5
c0d007d2:	1840      	adds	r0, r0, r1
c0d007d4:	21cc      	movs	r1, #204	; 0xcc
c0d007d6:	5871      	ldr	r1, [r6, r1]
c0d007d8:	2900      	cmp	r1, #0
c0d007da:	d002      	beq.n	c0d007e2 <io_event+0x466>
c0d007dc:	4788      	blx	r1
c0d007de:	2800      	cmp	r0, #0
c0d007e0:	d007      	beq.n	c0d007f2 <io_event+0x476>
c0d007e2:	2801      	cmp	r0, #1
c0d007e4:	d103      	bne.n	c0d007ee <io_event+0x472>
c0d007e6:	5930      	ldr	r0, [r6, r4]
c0d007e8:	5b71      	ldrh	r1, [r6, r5]
c0d007ea:	0149      	lsls	r1, r1, #5
c0d007ec:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d007ee:	f000 fb3d 	bl	c0d00e6c <io_seproxyhal_display_default>
        default:
            UX_DEFAULT_EVENT();
            break;

        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
c0d007f2:	5b70      	ldrh	r0, [r6, r5]
c0d007f4:	1c40      	adds	r0, r0, #1
c0d007f6:	5370      	strh	r0, [r6, r5]
c0d007f8:	5931      	ldr	r1, [r6, r4]
c0d007fa:	2900      	cmp	r1, #0
c0d007fc:	d1d5      	bne.n	c0d007aa <io_event+0x42e>
c0d007fe:	e041      	b.n	c0d00884 <io_event+0x508>
c0d00800:	20d0      	movs	r0, #208	; 0xd0
        case SEPROXYHAL_TAG_FINGER_EVENT:
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
            break;

        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00802:	4c53      	ldr	r4, [pc, #332]	; (c0d00950 <io_event+0x5d4>)
c0d00804:	5820      	ldr	r0, [r4, r0]
c0d00806:	2800      	cmp	r0, #0
c0d00808:	d003      	beq.n	c0d00812 <io_event+0x496>
c0d0080a:	78e9      	ldrb	r1, [r5, #3]
c0d0080c:	0849      	lsrs	r1, r1, #1
c0d0080e:	f000 fb71 	bl	c0d00ef4 <io_seproxyhal_button_push>
c0d00812:	25c0      	movs	r5, #192	; 0xc0
c0d00814:	5960      	ldr	r0, [r4, r5]
c0d00816:	2800      	cmp	r0, #0
c0d00818:	d02c      	beq.n	c0d00874 <io_event+0x4f8>
c0d0081a:	26be      	movs	r6, #190	; 0xbe
c0d0081c:	5ba0      	ldrh	r0, [r4, r6]
c0d0081e:	27aa      	movs	r7, #170	; 0xaa
c0d00820:	21c4      	movs	r1, #196	; 0xc4
c0d00822:	5c61      	ldrb	r1, [r4, r1]
c0d00824:	b280      	uxth	r0, r0
c0d00826:	4288      	cmp	r0, r1
c0d00828:	d224      	bcs.n	c0d00874 <io_event+0x4f8>
c0d0082a:	f001 f9bf 	bl	c0d01bac <io_seph_is_status_sent>
c0d0082e:	2800      	cmp	r0, #0
c0d00830:	d120      	bne.n	c0d00874 <io_event+0x4f8>
c0d00832:	f001 f941 	bl	c0d01ab8 <os_perso_isonboarded>
c0d00836:	42b8      	cmp	r0, r7
c0d00838:	d103      	bne.n	c0d00842 <io_event+0x4c6>
c0d0083a:	f001 f96d 	bl	c0d01b18 <os_global_pin_is_validated>
c0d0083e:	42b8      	cmp	r0, r7
c0d00840:	d118      	bne.n	c0d00874 <io_event+0x4f8>
c0d00842:	5960      	ldr	r0, [r4, r5]
c0d00844:	5ba1      	ldrh	r1, [r4, r6]
c0d00846:	0149      	lsls	r1, r1, #5
c0d00848:	1840      	adds	r0, r0, r1
c0d0084a:	21cc      	movs	r1, #204	; 0xcc
c0d0084c:	5861      	ldr	r1, [r4, r1]
c0d0084e:	2900      	cmp	r1, #0
c0d00850:	d002      	beq.n	c0d00858 <io_event+0x4dc>
c0d00852:	4788      	blx	r1
c0d00854:	2800      	cmp	r0, #0
c0d00856:	d007      	beq.n	c0d00868 <io_event+0x4ec>
c0d00858:	2801      	cmp	r0, #1
c0d0085a:	d103      	bne.n	c0d00864 <io_event+0x4e8>
c0d0085c:	5960      	ldr	r0, [r4, r5]
c0d0085e:	5ba1      	ldrh	r1, [r4, r6]
c0d00860:	0149      	lsls	r1, r1, #5
c0d00862:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d00864:	f000 fb02 	bl	c0d00e6c <io_seproxyhal_display_default>
        case SEPROXYHAL_TAG_FINGER_EVENT:
            UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
            break;

        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00868:	5ba0      	ldrh	r0, [r4, r6]
c0d0086a:	1c40      	adds	r0, r0, #1
c0d0086c:	53a0      	strh	r0, [r4, r6]
c0d0086e:	5961      	ldr	r1, [r4, r5]
c0d00870:	2900      	cmp	r1, #0
c0d00872:	d1d5      	bne.n	c0d00820 <io_event+0x4a4>
c0d00874:	20c4      	movs	r0, #196	; 0xc4
c0d00876:	5c20      	ldrb	r0, [r4, r0]
c0d00878:	21be      	movs	r1, #190	; 0xbe
c0d0087a:	5a61      	ldrh	r1, [r4, r1]
c0d0087c:	4281      	cmp	r1, r0
c0d0087e:	d301      	bcc.n	c0d00884 <io_event+0x508>
c0d00880:	f001 f994 	bl	c0d01bac <io_seph_is_status_sent>
            });
            break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00884:	f001 f992 	bl	c0d01bac <io_seph_is_status_sent>
c0d00888:	2800      	cmp	r0, #0
c0d0088a:	d101      	bne.n	c0d00890 <io_event+0x514>
        io_seproxyhal_general_status();
c0d0088c:	f000 f94c 	bl	c0d00b28 <io_seproxyhal_general_status>
c0d00890:	2001      	movs	r0, #1
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00892:	b001      	add	sp, #4
c0d00894:	bdf0      	pop	{r4, r5, r6, r7, pc}
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT:
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer,
c0d00896:	482f      	ldr	r0, [pc, #188]	; (c0d00954 <io_event+0x5d8>)
c0d00898:	6801      	ldr	r1, [r0, #0]
c0d0089a:	2900      	cmp	r1, #0
c0d0089c:	d100      	bne.n	c0d008a0 <io_event+0x524>
c0d0089e:	e72a      	b.n	c0d006f6 <io_event+0x37a>
c0d008a0:	2c00      	cmp	r4, #0
c0d008a2:	d0ef      	beq.n	c0d00884 <io_event+0x508>
c0d008a4:	2c97      	cmp	r4, #151	; 0x97
c0d008a6:	d0ed      	beq.n	c0d00884 <io_event+0x508>
c0d008a8:	482b      	ldr	r0, [pc, #172]	; (c0d00958 <io_event+0x5dc>)
c0d008aa:	6800      	ldr	r0, [r0, #0]
c0d008ac:	1c40      	adds	r0, r0, #1
c0d008ae:	f003 fe45 	bl	c0d0453c <__aeabi_uidivmod>
c0d008b2:	4829      	ldr	r0, [pc, #164]	; (c0d00958 <io_event+0x5dc>)
c0d008b4:	6001      	str	r1, [r0, #0]
c0d008b6:	f000 fa7f 	bl	c0d00db8 <io_seproxyhal_init_ux>
c0d008ba:	f000 fa7f 	bl	c0d00dbc <io_seproxyhal_init_button>
c0d008be:	20be      	movs	r0, #190	; 0xbe
c0d008c0:	9000      	str	r0, [sp, #0]
c0d008c2:	5237      	strh	r7, [r6, r0]
c0d008c4:	2004      	movs	r0, #4
c0d008c6:	f001 f9a5 	bl	c0d01c14 <os_sched_last_status>
c0d008ca:	6068      	str	r0, [r5, #4]
c0d008cc:	25c0      	movs	r5, #192	; 0xc0
c0d008ce:	5971      	ldr	r1, [r6, r5]
c0d008d0:	2900      	cmp	r1, #0
c0d008d2:	d100      	bne.n	c0d008d6 <io_event+0x55a>
c0d008d4:	e70f      	b.n	c0d006f6 <io_event+0x37a>
c0d008d6:	2800      	cmp	r0, #0
c0d008d8:	d100      	bne.n	c0d008dc <io_event+0x560>
c0d008da:	e70c      	b.n	c0d006f6 <io_event+0x37a>
c0d008dc:	2897      	cmp	r0, #151	; 0x97
c0d008de:	d100      	bne.n	c0d008e2 <io_event+0x566>
c0d008e0:	e709      	b.n	c0d006f6 <io_event+0x37a>
c0d008e2:	9800      	ldr	r0, [sp, #0]
c0d008e4:	5a30      	ldrh	r0, [r6, r0]
c0d008e6:	27aa      	movs	r7, #170	; 0xaa
c0d008e8:	21c4      	movs	r1, #196	; 0xc4
c0d008ea:	5c71      	ldrb	r1, [r6, r1]
c0d008ec:	b280      	uxth	r0, r0
c0d008ee:	4288      	cmp	r0, r1
c0d008f0:	d300      	bcc.n	c0d008f4 <io_event+0x578>
c0d008f2:	e700      	b.n	c0d006f6 <io_event+0x37a>
c0d008f4:	f001 f95a 	bl	c0d01bac <io_seph_is_status_sent>
c0d008f8:	2800      	cmp	r0, #0
c0d008fa:	d000      	beq.n	c0d008fe <io_event+0x582>
c0d008fc:	e6fb      	b.n	c0d006f6 <io_event+0x37a>
c0d008fe:	f001 f8db 	bl	c0d01ab8 <os_perso_isonboarded>
c0d00902:	42b8      	cmp	r0, r7
c0d00904:	d104      	bne.n	c0d00910 <io_event+0x594>
c0d00906:	f001 f907 	bl	c0d01b18 <os_global_pin_is_validated>
c0d0090a:	42b8      	cmp	r0, r7
c0d0090c:	d000      	beq.n	c0d00910 <io_event+0x594>
c0d0090e:	e6f2      	b.n	c0d006f6 <io_event+0x37a>
c0d00910:	5970      	ldr	r0, [r6, r5]
c0d00912:	9900      	ldr	r1, [sp, #0]
c0d00914:	5a71      	ldrh	r1, [r6, r1]
c0d00916:	0149      	lsls	r1, r1, #5
c0d00918:	1840      	adds	r0, r0, r1
c0d0091a:	21cc      	movs	r1, #204	; 0xcc
c0d0091c:	5871      	ldr	r1, [r6, r1]
c0d0091e:	2900      	cmp	r1, #0
c0d00920:	d002      	beq.n	c0d00928 <io_event+0x5ac>
c0d00922:	4788      	blx	r1
c0d00924:	2800      	cmp	r0, #0
c0d00926:	d008      	beq.n	c0d0093a <io_event+0x5be>
c0d00928:	2801      	cmp	r0, #1
c0d0092a:	d104      	bne.n	c0d00936 <io_event+0x5ba>
c0d0092c:	5970      	ldr	r0, [r6, r5]
c0d0092e:	9900      	ldr	r1, [sp, #0]
c0d00930:	5a71      	ldrh	r1, [r6, r1]
c0d00932:	0149      	lsls	r1, r1, #5
c0d00934:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t*)element);
c0d00936:	f000 fa99 	bl	c0d00e6c <io_seproxyhal_display_default>
c0d0093a:	9900      	ldr	r1, [sp, #0]
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
            break;

        case SEPROXYHAL_TAG_TICKER_EVENT:
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer,
c0d0093c:	5a70      	ldrh	r0, [r6, r1]
c0d0093e:	1c40      	adds	r0, r0, #1
c0d00940:	5270      	strh	r0, [r6, r1]
c0d00942:	5971      	ldr	r1, [r6, r5]
c0d00944:	2900      	cmp	r1, #0
c0d00946:	d1cf      	bne.n	c0d008e8 <io_event+0x56c>
c0d00948:	e6d5      	b.n	c0d006f6 <io_event+0x37a>
c0d0094a:	46c0      	nop			; (mov r8, r8)
c0d0094c:	2000196c 	.word	0x2000196c
c0d00950:	2000186c 	.word	0x2000186c
c0d00954:	20001a08 	.word	0x20001a08
c0d00958:	20001a04 	.word	0x20001a04

c0d0095c <io_exchange_al>:
    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}


unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d0095c:	b5b0      	push	{r4, r5, r7, lr}
c0d0095e:	4605      	mov	r5, r0
c0d00960:	2007      	movs	r0, #7
    switch (channel & ~(IO_FLAGS)) {
c0d00962:	4028      	ands	r0, r5
c0d00964:	2400      	movs	r4, #0
c0d00966:	2801      	cmp	r0, #1
c0d00968:	d014      	beq.n	c0d00994 <io_exchange_al+0x38>
c0d0096a:	2802      	cmp	r0, #2
c0d0096c:	d114      	bne.n	c0d00998 <io_exchange_al+0x3c>
        case CHANNEL_KEYBOARD:
            break;

        // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
        case CHANNEL_SPI:
            if (tx_len) {
c0d0096e:	2900      	cmp	r1, #0
c0d00970:	d009      	beq.n	c0d00986 <io_exchange_al+0x2a>
                io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00972:	480b      	ldr	r0, [pc, #44]	; (c0d009a0 <io_exchange_al+0x44>)
c0d00974:	f001 f90e 	bl	c0d01b94 <io_seph_send>

                if (channel & IO_RESET_AFTER_REPLIED) {
c0d00978:	b268      	sxtb	r0, r5
c0d0097a:	2800      	cmp	r0, #0
c0d0097c:	da0a      	bge.n	c0d00994 <io_exchange_al+0x38>
                    reset();
c0d0097e:	f001 f819 	bl	c0d019b4 <halt>
c0d00982:	2400      	movs	r4, #0
c0d00984:	e006      	b.n	c0d00994 <io_exchange_al+0x38>
c0d00986:	21ff      	movs	r1, #255	; 0xff
c0d00988:	3152      	adds	r1, #82	; 0x52
                }
                return 0; // nothing received from the master so far (it's a tx
                        // transaction)
            } else {
                return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d0098a:	4805      	ldr	r0, [pc, #20]	; (c0d009a0 <io_exchange_al+0x44>)
c0d0098c:	2200      	movs	r2, #0
c0d0098e:	f001 f919 	bl	c0d01bc4 <io_seph_recv>
c0d00992:	4604      	mov	r4, r0

        default:
            THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d00994:	4620      	mov	r0, r4
c0d00996:	bdb0      	pop	{r4, r5, r7, pc}
c0d00998:	2002      	movs	r0, #2
                return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                            sizeof(G_io_apdu_buffer), 0);
            }

        default:
            THROW(INVALID_PARAMETER);
c0d0099a:	f000 f8be 	bl	c0d00b1a <os_longjmp>
c0d0099e:	46c0      	nop			; (mov r8, r8)
c0d009a0:	20001a8e 	.word	0x20001a8e

c0d009a4 <app_exit>:
    }
    return 0;
}


void app_exit(void) {
c0d009a4:	b510      	push	{r4, lr}
c0d009a6:	b08c      	sub	sp, #48	; 0x30
c0d009a8:	466c      	mov	r4, sp

    BEGIN_TRY_L(exit) {
        TRY_L(exit) {
c0d009aa:	4620      	mov	r0, r4
c0d009ac:	f003 fe70 	bl	c0d04690 <setjmp>
c0d009b0:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d009b2:	0400      	lsls	r0, r0, #16
c0d009b4:	d106      	bne.n	c0d009c4 <app_exit+0x20>
c0d009b6:	4668      	mov	r0, sp
c0d009b8:	f001 f920 	bl	c0d01bfc <try_context_set>
c0d009bc:	900a      	str	r0, [sp, #40]	; 0x28
c0d009be:	20ff      	movs	r0, #255	; 0xff
            os_sched_exit(-1);
c0d009c0:	f001 f8dc 	bl	c0d01b7c <os_sched_exit>
        }
        FINALLY_L(exit) {
c0d009c4:	f001 f90e 	bl	c0d01be4 <try_context_get>
c0d009c8:	4669      	mov	r1, sp
c0d009ca:	4288      	cmp	r0, r1
c0d009cc:	d102      	bne.n	c0d009d4 <app_exit+0x30>
c0d009ce:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d009d0:	f001 f914 	bl	c0d01bfc <try_context_set>
c0d009d4:	4668      	mov	r0, sp

        }
    }
    END_TRY_L(exit);
c0d009d6:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d009d8:	2800      	cmp	r0, #0
c0d009da:	d101      	bne.n	c0d009e0 <app_exit+0x3c>
}
c0d009dc:	b00c      	add	sp, #48	; 0x30
c0d009de:	bd10      	pop	{r4, pc}
        }
        FINALLY_L(exit) {

        }
    }
    END_TRY_L(exit);
c0d009e0:	f000 f89b 	bl	c0d00b1a <os_longjmp>

c0d009e4 <nv_app_state_init>:
}

void nv_app_state_init(){
c0d009e4:	b510      	push	{r4, lr}
c0d009e6:	b082      	sub	sp, #8
    if (N_storage.initialized != 0x01) {
c0d009e8:	4813      	ldr	r0, [pc, #76]	; (c0d00a38 <nv_app_state_init+0x54>)
c0d009ea:	4478      	add	r0, pc
c0d009ec:	f000 ff50 	bl	c0d01890 <pic>
c0d009f0:	7880      	ldrb	r0, [r0, #2]
c0d009f2:	2801      	cmp	r0, #1
c0d009f4:	d00c      	beq.n	c0d00a10 <nv_app_state_init+0x2c>
c0d009f6:	ac01      	add	r4, sp, #4
c0d009f8:	2000      	movs	r0, #0
        internalStorage_t storage;
        storage.dummy_setting_1 = 0x00;
c0d009fa:	8020      	strh	r0, [r4, #0]
c0d009fc:	2001      	movs	r0, #1
        storage.dummy_setting_2 = 0x00;
        storage.initialized = 0x01;
c0d009fe:	70a0      	strb	r0, [r4, #2]
        nvm_write((internalStorage_t*)&N_storage, (void*)&storage, sizeof(internalStorage_t));
c0d00a00:	480e      	ldr	r0, [pc, #56]	; (c0d00a3c <nv_app_state_init+0x58>)
c0d00a02:	4478      	add	r0, pc
c0d00a04:	f000 ff44 	bl	c0d01890 <pic>
c0d00a08:	2203      	movs	r2, #3
c0d00a0a:	4621      	mov	r1, r4
c0d00a0c:	f000 ffdc 	bl	c0d019c8 <nvm_write>
    }
    dummy_setting_1 = N_storage.dummy_setting_1;
c0d00a10:	4c0b      	ldr	r4, [pc, #44]	; (c0d00a40 <nv_app_state_init+0x5c>)
c0d00a12:	447c      	add	r4, pc
c0d00a14:	4620      	mov	r0, r4
c0d00a16:	f000 ff3b 	bl	c0d01890 <pic>
c0d00a1a:	7800      	ldrb	r0, [r0, #0]
c0d00a1c:	4904      	ldr	r1, [pc, #16]	; (c0d00a30 <nv_app_state_init+0x4c>)
c0d00a1e:	7008      	strb	r0, [r1, #0]
    dummy_setting_2 = N_storage.dummy_setting_2;
c0d00a20:	4620      	mov	r0, r4
c0d00a22:	f000 ff35 	bl	c0d01890 <pic>
c0d00a26:	7840      	ldrb	r0, [r0, #1]
c0d00a28:	4902      	ldr	r1, [pc, #8]	; (c0d00a34 <nv_app_state_init+0x50>)
c0d00a2a:	7008      	strb	r0, [r1, #0]
}
c0d00a2c:	b002      	add	sp, #8
c0d00a2e:	bd10      	pop	{r4, pc}
c0d00a30:	20001a8c 	.word	0x20001a8c
c0d00a34:	20001a8d 	.word	0x20001a8d
c0d00a38:	00004852 	.word	0x00004852
c0d00a3c:	0000483a 	.word	0x0000483a
c0d00a40:	0000482a 	.word	0x0000482a

c0d00a44 <ui_idle>:
  &ux_idle_flow_3_step,
  &ux_idle_flow_4_step,
  FLOW_LOOP
);

void ui_idle(void) {
c0d00a44:	b580      	push	{r7, lr}
    // reserve a display stack slot if none yet
    if(G_ux.stack_count == 0) {
c0d00a46:	4806      	ldr	r0, [pc, #24]	; (c0d00a60 <ui_idle+0x1c>)
c0d00a48:	7800      	ldrb	r0, [r0, #0]
c0d00a4a:	2800      	cmp	r0, #0
c0d00a4c:	d101      	bne.n	c0d00a52 <ui_idle+0xe>
        ux_stack_push();
c0d00a4e:	f003 fc4f 	bl	c0d042f0 <ux_stack_push>
    }
    ux_flow_init(0, ux_idle_flow, NULL);
c0d00a52:	4904      	ldr	r1, [pc, #16]	; (c0d00a64 <ui_idle+0x20>)
c0d00a54:	4479      	add	r1, pc
c0d00a56:	2000      	movs	r0, #0
c0d00a58:	4602      	mov	r2, r0
c0d00a5a:	f003 f80d 	bl	c0d03a78 <ux_flow_init>
}
c0d00a5e:	bd80      	pop	{r7, pc}
c0d00a60:	2000186c 	.word	0x2000186c
c0d00a64:	00003fe0 	.word	0x00003fe0

c0d00a68 <settings_submenu_getter>:
 // "Dummy setting 1",
  //"Dummy setting 2",
  "Back",
};

const char* settings_submenu_getter(unsigned int idx) {
c0d00a68:	4601      	mov	r1, r0
c0d00a6a:	2000      	movs	r0, #0
  if (idx < ARRAYLEN(settings_submenu_getter_values)) {
    return settings_submenu_getter_values[idx];
c0d00a6c:	2900      	cmp	r1, #0
c0d00a6e:	d101      	bne.n	c0d00a74 <settings_submenu_getter+0xc>
c0d00a70:	4801      	ldr	r0, [pc, #4]	; (c0d00a78 <settings_submenu_getter+0x10>)
c0d00a72:	4478      	add	r0, pc
  }
  return NULL;
}
c0d00a74:	4770      	bx	lr
c0d00a76:	46c0      	nop			; (mov r8, r8)
c0d00a78:	00003ef9 	.word	0x00003ef9

c0d00a7c <settings_submenu_selector>:

void settings_submenu_selector(unsigned int idx) {
c0d00a7c:	b580      	push	{r7, lr}
      break;
    case 1:
      ux_menulist_init_select(0, dummy_setting_2_data_getter, dummy_setting_2_data_selector, N_storage.dummy_setting_2);
      break;*/
    default:
      ui_idle();
c0d00a7e:	f7ff ffe1 	bl	c0d00a44 <ui_idle>
  }
}
c0d00a82:	bd80      	pop	{r7, pc}

c0d00a84 <ux_idle_flow_2_step_validateinit>:
    {
      &C_oneLedger_logo,
      "OneLedger",
      "is ready",
    });
UX_STEP_VALID(
c0d00a84:	b580      	push	{r7, lr}
c0d00a86:	2000      	movs	r0, #0
c0d00a88:	4903      	ldr	r1, [pc, #12]	; (c0d00a98 <ux_idle_flow_2_step_validateinit+0x14>)
c0d00a8a:	4479      	add	r1, pc
c0d00a8c:	4a03      	ldr	r2, [pc, #12]	; (c0d00a9c <ux_idle_flow_2_step_validateinit+0x18>)
c0d00a8e:	447a      	add	r2, pc
c0d00a90:	f003 fc28 	bl	c0d042e4 <ux_menulist_init>
c0d00a94:	bd80      	pop	{r7, pc}
c0d00a96:	46c0      	nop			; (mov r8, r8)
c0d00a98:	ffffffdb 	.word	0xffffffdb
c0d00a9c:	ffffffeb 	.word	0xffffffeb

c0d00aa0 <ux_idle_flow_4_step_validateinit>:
    bn,
    {
      "Version",
      APPVERSION,
    });
UX_STEP_VALID(
c0d00aa0:	b580      	push	{r7, lr}
c0d00aa2:	20ff      	movs	r0, #255	; 0xff
c0d00aa4:	f001 f86a 	bl	c0d01b7c <os_sched_exit>
c0d00aa8:	bd80      	pop	{r7, pc}

c0d00aaa <os_boot>:

// apdu buffer must hold a complete apdu to avoid troubles
unsigned char G_io_apdu_buffer[IO_APDU_BUFFER_SIZE];


void os_boot(void) {
c0d00aaa:	b580      	push	{r7, lr}
c0d00aac:	2000      	movs	r0, #0
  // // TODO patch entry point when romming (f)
  // // set the default try context to nothing
#ifndef HAVE_BOLOS
  try_context_set(NULL);
c0d00aae:	f001 f8a5 	bl	c0d01bfc <try_context_set>
#endif // HAVE_BOLOS
}
c0d00ab2:	bd80      	pop	{r7, pc}

c0d00ab4 <os_memmove>:


REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00ab4:	b5b0      	push	{r4, r5, r7, lr}
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00ab6:	4288      	cmp	r0, r1
c0d00ab8:	d908      	bls.n	c0d00acc <os_memmove+0x18>
    while(length--) {
c0d00aba:	2a00      	cmp	r2, #0
c0d00abc:	d00f      	beq.n	c0d00ade <os_memmove+0x2a>
c0d00abe:	1e49      	subs	r1, r1, #1
c0d00ac0:	1e40      	subs	r0, r0, #1
      DSTCHAR[length] = SRCCHAR[length];
c0d00ac2:	5c8b      	ldrb	r3, [r1, r2]
c0d00ac4:	5483      	strb	r3, [r0, r2]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00ac6:	1e52      	subs	r2, r2, #1
c0d00ac8:	d1fb      	bne.n	c0d00ac2 <os_memmove+0xe>
c0d00aca:	e008      	b.n	c0d00ade <os_memmove+0x2a>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00acc:	2a00      	cmp	r2, #0
c0d00ace:	d006      	beq.n	c0d00ade <os_memmove+0x2a>
c0d00ad0:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00ad2:	b29c      	uxth	r4, r3
c0d00ad4:	5d0d      	ldrb	r5, [r1, r4]
c0d00ad6:	5505      	strb	r5, [r0, r4]
      l++;
c0d00ad8:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00ada:	1e52      	subs	r2, r2, #1
c0d00adc:	d1f9      	bne.n	c0d00ad2 <os_memmove+0x1e>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00ade:	bdb0      	pop	{r4, r5, r7, pc}

c0d00ae0 <os_memset>:

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00ae0:	b580      	push	{r7, lr}
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00ae2:	2a00      	cmp	r2, #0
c0d00ae4:	d004      	beq.n	c0d00af0 <os_memset+0x10>
c0d00ae6:	460b      	mov	r3, r1
    DSTCHAR[length] = c;
c0d00ae8:	4611      	mov	r1, r2
c0d00aea:	461a      	mov	r2, r3
c0d00aec:	f003 fd36 	bl	c0d0455c <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00af0:	bd80      	pop	{r7, pc}

c0d00af2 <os_memcmp>:
  while(nbintval--) {
    ((unsigned int*) dst)[nbintval] = initval;
  }
}

char os_memcmp(const void WIDE * buf1, const void WIDE * buf2, unsigned int length) {
c0d00af2:	b570      	push	{r4, r5, r6, lr}
#define BUF1 ((unsigned char const WIDE *)buf1)
#define BUF2 ((unsigned char const WIDE *)buf2)
  while(length--) {
c0d00af4:	1e40      	subs	r0, r0, #1
c0d00af6:	1e49      	subs	r1, r1, #1
c0d00af8:	1e54      	subs	r4, r2, #1
c0d00afa:	2300      	movs	r3, #0
c0d00afc:	2a00      	cmp	r2, #0
c0d00afe:	d00a      	beq.n	c0d00b16 <os_memcmp+0x24>
    if (BUF1[length] != BUF2[length]) {
c0d00b00:	5c8d      	ldrb	r5, [r1, r2]
c0d00b02:	5c86      	ldrb	r6, [r0, r2]
c0d00b04:	42ae      	cmp	r6, r5
c0d00b06:	4622      	mov	r2, r4
c0d00b08:	d0f6      	beq.n	c0d00af8 <os_memcmp+0x6>
c0d00b0a:	2000      	movs	r0, #0
c0d00b0c:	43c0      	mvns	r0, r0
c0d00b0e:	2301      	movs	r3, #1
      return (BUF1[length] > BUF2[length])? 1:-1;
c0d00b10:	42ae      	cmp	r6, r5
c0d00b12:	d800      	bhi.n	c0d00b16 <os_memcmp+0x24>
c0d00b14:	4603      	mov	r3, r0
  }
  return 0;
#undef BUF1
#undef BUF2

}
c0d00b16:	b2d8      	uxtb	r0, r3
c0d00b18:	bd70      	pop	{r4, r5, r6, pc}

c0d00b1a <os_longjmp>:
  return (try_context_t*) current_ctx->jmp_buf[5];
}
#endif // BOLOS_EXCEPTION_OLD

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0d00b1a:	4604      	mov	r4, r0
#ifdef HAVE_PRINTF  
  unsigned int lr_val;
  __asm volatile("mov %0, lr" :"=r"(lr_val));
  PRINTF("exception[%d]: LR=0x%08X\n", exception, lr_val);
#endif // HAVE_PRINTF
  longjmp(try_context_get()->jmp_buf, exception);
c0d00b1c:	f001 f862 	bl	c0d01be4 <try_context_get>
c0d00b20:	4621      	mov	r1, r4
c0d00b22:	f003 fdc1 	bl	c0d046a8 <longjmp>
	...

c0d00b28 <io_seproxyhal_general_status>:

#ifndef IO_RAPDU_TRANSMIT_TIMEOUT_MS 
#define IO_RAPDU_TRANSMIT_TIMEOUT_MS 2000UL
#endif // IO_RAPDU_TRANSMIT_TIMEOUT_MS

void io_seproxyhal_general_status(void) {
c0d00b28:	b580      	push	{r7, lr}
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00b2a:	f001 f83f 	bl	c0d01bac <io_seph_is_status_sent>
c0d00b2e:	2800      	cmp	r0, #0
c0d00b30:	d000      	beq.n	c0d00b34 <io_seproxyhal_general_status+0xc>
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 2;
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}
c0d00b32:	bd80      	pop	{r7, pc}
  if (io_seproxyhal_spi_is_status_sent()) {
    return;
  }

  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00b34:	4806      	ldr	r0, [pc, #24]	; (c0d00b50 <io_seproxyhal_general_status+0x28>)
c0d00b36:	2100      	movs	r1, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00b38:	7041      	strb	r1, [r0, #1]
c0d00b3a:	2260      	movs	r2, #96	; 0x60
  if (io_seproxyhal_spi_is_status_sent()) {
    return;
  }

  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00b3c:	7002      	strb	r2, [r0, #0]
c0d00b3e:	2202      	movs	r2, #2
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00b40:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00b42:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00b44:	7101      	strb	r1, [r0, #4]
c0d00b46:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00b48:	f001 f824 	bl	c0d01b94 <io_seph_send>
}
c0d00b4c:	bd80      	pop	{r7, pc}
c0d00b4e:	46c0      	nop			; (mov r8, r8)
c0d00b50:	20001a0c 	.word	0x20001a0c

c0d00b54 <io_seproxyhal_handle_usb_event>:
}

#ifdef HAVE_IO_USB
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
c0d00b54:	b5b0      	push	{r4, r5, r7, lr}
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00b56:	481a      	ldr	r0, [pc, #104]	; (c0d00bc0 <io_seproxyhal_handle_usb_event+0x6c>)
c0d00b58:	78c0      	ldrb	r0, [r0, #3]
c0d00b5a:	2803      	cmp	r0, #3
c0d00b5c:	dc07      	bgt.n	c0d00b6e <io_seproxyhal_handle_usb_event+0x1a>
c0d00b5e:	2801      	cmp	r0, #1
c0d00b60:	d00d      	beq.n	c0d00b7e <io_seproxyhal_handle_usb_event+0x2a>
c0d00b62:	2802      	cmp	r0, #2
c0d00b64:	d128      	bne.n	c0d00bb8 <io_seproxyhal_handle_usb_event+0x64>
      }
      os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
      os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00b66:	4817      	ldr	r0, [pc, #92]	; (c0d00bc4 <io_seproxyhal_handle_usb_event+0x70>)
c0d00b68:	f002 f813 	bl	c0d02b92 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00b6c:	bdb0      	pop	{r4, r5, r7, pc}

#ifdef HAVE_IO_USB
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00b6e:	2804      	cmp	r0, #4
c0d00b70:	d01f      	beq.n	c0d00bb2 <io_seproxyhal_handle_usb_event+0x5e>
c0d00b72:	2808      	cmp	r0, #8
c0d00b74:	d120      	bne.n	c0d00bb8 <io_seproxyhal_handle_usb_event+0x64>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d00b76:	4813      	ldr	r0, [pc, #76]	; (c0d00bc4 <io_seproxyhal_handle_usb_event+0x70>)
c0d00b78:	f002 f809 	bl	c0d02b8e <USBD_LL_Resume>
      break;
  }
}
c0d00b7c:	bdb0      	pop	{r4, r5, r7, pc}
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
  switch(G_io_seproxyhal_spi_buffer[3]) {
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00b7e:	4c11      	ldr	r4, [pc, #68]	; (c0d00bc4 <io_seproxyhal_handle_usb_event+0x70>)
c0d00b80:	2101      	movs	r1, #1
c0d00b82:	4620      	mov	r0, r4
c0d00b84:	f001 fffe 	bl	c0d02b84 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00b88:	4620      	mov	r0, r4
c0d00b8a:	f001 ffdc 	bl	c0d02b46 <USBD_LL_Reset>
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_app.apdu_media != IO_APDU_MEDIA_NONE) {
c0d00b8e:	4c0e      	ldr	r4, [pc, #56]	; (c0d00bc8 <io_seproxyhal_handle_usb_event+0x74>)
c0d00b90:	79a0      	ldrb	r0, [r4, #6]
c0d00b92:	2800      	cmp	r0, #0
c0d00b94:	d111      	bne.n	c0d00bba <io_seproxyhal_handle_usb_event+0x66>
        THROW(EXCEPTION_IO_RESET);
      }
      os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
c0d00b96:	4620      	mov	r0, r4
c0d00b98:	300c      	adds	r0, #12
c0d00b9a:	2500      	movs	r5, #0
c0d00b9c:	2206      	movs	r2, #6
c0d00b9e:	4629      	mov	r1, r5
c0d00ba0:	f7ff ff9e 	bl	c0d00ae0 <os_memset>
      os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d00ba4:	3412      	adds	r4, #18
c0d00ba6:	220c      	movs	r2, #12
c0d00ba8:	4620      	mov	r0, r4
c0d00baa:	4629      	mov	r1, r5
c0d00bac:	f7ff ff98 	bl	c0d00ae0 <os_memset>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00bb0:	bdb0      	pop	{r4, r5, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00bb2:	4804      	ldr	r0, [pc, #16]	; (c0d00bc4 <io_seproxyhal_handle_usb_event+0x70>)
c0d00bb4:	f001 ffe9 	bl	c0d02b8a <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00bb8:	bdb0      	pop	{r4, r5, r7, pc}
c0d00bba:	2010      	movs	r0, #16
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
      USBD_LL_Reset(&USBD_Device);
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_app.apdu_media != IO_APDU_MEDIA_NONE) {
        THROW(EXCEPTION_IO_RESET);
c0d00bbc:	f7ff ffad 	bl	c0d00b1a <os_longjmp>
c0d00bc0:	20001a0c 	.word	0x20001a0c
c0d00bc4:	20001d28 	.word	0x20001d28
c0d00bc8:	20001be0 	.word	0x20001be0

c0d00bcc <io_seproxyhal_get_ep_rx_size>:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
c0d00bcc:	217f      	movs	r1, #127	; 0x7f
  if ((epnum & 0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d00bce:	4001      	ands	r1, r0
c0d00bd0:	2000      	movs	r0, #0
c0d00bd2:	2905      	cmp	r1, #5
c0d00bd4:	d802      	bhi.n	c0d00bdc <io_seproxyhal_get_ep_rx_size+0x10>
  return G_io_app.usb_ep_xfer_len[epnum&0x7F];
c0d00bd6:	4802      	ldr	r0, [pc, #8]	; (c0d00be0 <io_seproxyhal_get_ep_rx_size+0x14>)
c0d00bd8:	1840      	adds	r0, r0, r1
c0d00bda:	7b00      	ldrb	r0, [r0, #12]
}
  return 0;
}
c0d00bdc:	4770      	bx	lr
c0d00bde:	46c0      	nop			; (mov r8, r8)
c0d00be0:	20001be0 	.word	0x20001be0

c0d00be4 <io_seproxyhal_handle_usb_ep_xfer_event>:

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00be4:	b580      	push	{r7, lr}
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00be6:	4815      	ldr	r0, [pc, #84]	; (c0d00c3c <io_seproxyhal_handle_usb_ep_xfer_event+0x58>)
c0d00be8:	7901      	ldrb	r1, [r0, #4]
c0d00bea:	2904      	cmp	r1, #4
c0d00bec:	d017      	beq.n	c0d00c1e <io_seproxyhal_handle_usb_ep_xfer_event+0x3a>
c0d00bee:	2902      	cmp	r1, #2
c0d00bf0:	d006      	beq.n	c0d00c00 <io_seproxyhal_handle_usb_ep_xfer_event+0x1c>
c0d00bf2:	2901      	cmp	r1, #1
c0d00bf4:	d120      	bne.n	c0d00c38 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
    /* This event is received when a new SETUP token had been received on a control endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00bf6:	1d81      	adds	r1, r0, #6
c0d00bf8:	4812      	ldr	r0, [pc, #72]	; (c0d00c44 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d00bfa:	f001 feaa 	bl	c0d02952 <USBD_LL_SetupStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d00bfe:	bd80      	pop	{r7, pc}
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    /* This event is received after the prepare data packet has been flushed to the usb host */
    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d00c00:	78c2      	ldrb	r2, [r0, #3]
c0d00c02:	217f      	movs	r1, #127	; 0x7f
c0d00c04:	4011      	ands	r1, r2
c0d00c06:	2905      	cmp	r1, #5
c0d00c08:	d816      	bhi.n	c0d00c38 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        // discard ep timeout as we received the sent packet confirmation
        G_io_app.usb_ep_timeouts[G_io_seproxyhal_spi_buffer[3]&0x7F].timeout = 0;
c0d00c0a:	004a      	lsls	r2, r1, #1
c0d00c0c:	4b0c      	ldr	r3, [pc, #48]	; (c0d00c40 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d00c0e:	189a      	adds	r2, r3, r2
c0d00c10:	2300      	movs	r3, #0
c0d00c12:	8253      	strh	r3, [r2, #18]
        // propagate sending ack of the data
        USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00c14:	1d82      	adds	r2, r0, #6
c0d00c16:	480b      	ldr	r0, [pc, #44]	; (c0d00c44 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d00c18:	f001 ff21 	bl	c0d02a5e <USBD_LL_DataInStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d00c1c:	bd80      	pop	{r7, pc}
      }
      break;

    /* This event is received when a new DATA token is received on an endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d00c1e:	78c2      	ldrb	r2, [r0, #3]
c0d00c20:	217f      	movs	r1, #127	; 0x7f
c0d00c22:	4011      	ands	r1, r2
c0d00c24:	2905      	cmp	r1, #5
c0d00c26:	d807      	bhi.n	c0d00c38 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        // saved just in case it is needed ...
        G_io_app.usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d00c28:	4a05      	ldr	r2, [pc, #20]	; (c0d00c40 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d00c2a:	1852      	adds	r2, r2, r1
c0d00c2c:	7943      	ldrb	r3, [r0, #5]
c0d00c2e:	7313      	strb	r3, [r2, #12]
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00c30:	1d82      	adds	r2, r0, #6
c0d00c32:	4804      	ldr	r0, [pc, #16]	; (c0d00c44 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d00c34:	f001 febb 	bl	c0d029ae <USBD_LL_DataOutStage>
      }
      break;
  }
}
c0d00c38:	bd80      	pop	{r7, pc}
c0d00c3a:	46c0      	nop			; (mov r8, r8)
c0d00c3c:	20001a0c 	.word	0x20001a0c
c0d00c40:	20001be0 	.word	0x20001be0
c0d00c44:	20001d28 	.word	0x20001d28

c0d00c48 <io_usb_send_ep>:
#endif // HAVE_L4_USBLIB

// TODO, refactor this using the USB DataIn event like for the U2F tunnel
// TODO add a blocking parameter, for HID KBD sending, or use a USB busy flag per channel to know if 
// the transfer has been processed or not. and move on to the next transfer on the same endpoint
void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00c48:	b570      	push	{r4, r5, r6, lr}
  if (timeout) {
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00c4a:	2aff      	cmp	r2, #255	; 0xff
c0d00c4c:	d81e      	bhi.n	c0d00c8c <io_usb_send_ep+0x44>
c0d00c4e:	4615      	mov	r5, r2
c0d00c50:	460e      	mov	r6, r1
c0d00c52:	4604      	mov	r4, r0
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00c54:	480e      	ldr	r0, [pc, #56]	; (c0d00c90 <io_usb_send_ep+0x48>)
c0d00c56:	2150      	movs	r1, #80	; 0x50
c0d00c58:	7001      	strb	r1, [r0, #0]
c0d00c5a:	2120      	movs	r1, #32
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
  G_io_seproxyhal_spi_buffer[2] = (3+length);
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d00c5c:	7101      	strb	r1, [r0, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d00c5e:	7142      	strb	r2, [r0, #5]
  if (length > 255) {
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00c60:	1cd1      	adds	r1, r2, #3
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00c62:	7081      	strb	r1, [r0, #2]
c0d00c64:	2280      	movs	r2, #128	; 0x80
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00c66:	4322      	orrs	r2, r4
c0d00c68:	70c2      	strb	r2, [r0, #3]
  if (length > 255) {
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00c6a:	0a09      	lsrs	r1, r1, #8
c0d00c6c:	7041      	strb	r1, [r0, #1]
c0d00c6e:	2106      	movs	r1, #6
  G_io_seproxyhal_spi_buffer[2] = (3+length);
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  G_io_seproxyhal_spi_buffer[5] = length;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d00c70:	f000 ff90 	bl	c0d01b94 <io_seph_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00c74:	4630      	mov	r0, r6
c0d00c76:	4629      	mov	r1, r5
c0d00c78:	f000 ff8c 	bl	c0d01b94 <io_seph_send>
c0d00c7c:	207f      	movs	r0, #127	; 0x7f
  // setup timeout of the endpoint
  G_io_app.usb_ep_timeouts[ep&0x7F].timeout = IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d00c7e:	4020      	ands	r0, r4
c0d00c80:	0040      	lsls	r0, r0, #1
c0d00c82:	4904      	ldr	r1, [pc, #16]	; (c0d00c94 <io_usb_send_ep+0x4c>)
c0d00c84:	1808      	adds	r0, r1, r0
c0d00c86:	217d      	movs	r1, #125	; 0x7d
c0d00c88:	0109      	lsls	r1, r1, #4
c0d00c8a:	8241      	strh	r1, [r0, #18]
}
c0d00c8c:	bd70      	pop	{r4, r5, r6, pc}
c0d00c8e:	46c0      	nop			; (mov r8, r8)
c0d00c90:	20001a0c 	.word	0x20001a0c
c0d00c94:	20001be0 	.word	0x20001be0

c0d00c98 <io_usb_send_apdu_data>:

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d00c98:	b580      	push	{r7, lr}
c0d00c9a:	460a      	mov	r2, r1
c0d00c9c:	4601      	mov	r1, r0
c0d00c9e:	2082      	movs	r0, #130	; 0x82
c0d00ca0:	2314      	movs	r3, #20
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d00ca2:	f7ff ffd1 	bl	c0d00c48 <io_usb_send_ep>
}
c0d00ca6:	bd80      	pop	{r7, pc}

c0d00ca8 <io_usb_send_apdu_data_ep0x83>:

#ifdef HAVE_WEBUSB
void io_usb_send_apdu_data_ep0x83(unsigned char* buffer, unsigned short length) {
c0d00ca8:	b580      	push	{r7, lr}
c0d00caa:	460a      	mov	r2, r1
c0d00cac:	4601      	mov	r1, r0
c0d00cae:	2083      	movs	r0, #131	; 0x83
c0d00cb0:	2314      	movs	r3, #20
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x83, buffer, length, 20);
c0d00cb2:	f7ff ffc9 	bl	c0d00c48 <io_usb_send_ep>
}
c0d00cb6:	bd80      	pop	{r7, pc}

c0d00cb8 <io_seproxyhal_handle_capdu_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif // HAVE_BLUENRG

void io_seproxyhal_handle_capdu_event(void) {
c0d00cb8:	b580      	push	{r7, lr}
  if (G_io_app.apdu_state == APDU_IDLE) {
c0d00cba:	480c      	ldr	r0, [pc, #48]	; (c0d00cec <io_seproxyhal_handle_capdu_event+0x34>)
c0d00cbc:	7801      	ldrb	r1, [r0, #0]
c0d00cbe:	2900      	cmp	r1, #0
c0d00cc0:	d000      	beq.n	c0d00cc4 <io_seproxyhal_handle_capdu_event+0xc>
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
    G_io_app.apdu_length = MIN(size, max);
    // copy apdu to apdu buffer
    os_memmove(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_app.apdu_length);
  }
}
c0d00cc2:	bd80      	pop	{r7, pc}
c0d00cc4:	2106      	movs	r1, #6
void io_seproxyhal_handle_capdu_event(void) {
  if (G_io_app.apdu_state == APDU_IDLE) {
    size_t max = MIN(sizeof(G_io_apdu_buffer)-3, sizeof(G_io_seproxyhal_spi_buffer)-3);
    size_t size = U2BE(G_io_seproxyhal_spi_buffer, 1);

    G_io_app.apdu_media = IO_APDU_MEDIA_RAW; // for application code
c0d00cc6:	7181      	strb	r1, [r0, #6]
c0d00cc8:	210a      	movs	r1, #10
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
c0d00cca:	7001      	strb	r1, [r0, #0]
#endif // HAVE_BLUENRG

void io_seproxyhal_handle_capdu_event(void) {
  if (G_io_app.apdu_state == APDU_IDLE) {
    size_t max = MIN(sizeof(G_io_apdu_buffer)-3, sizeof(G_io_seproxyhal_spi_buffer)-3);
    size_t size = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d00ccc:	4908      	ldr	r1, [pc, #32]	; (c0d00cf0 <io_seproxyhal_handle_capdu_event+0x38>)
c0d00cce:	788a      	ldrb	r2, [r1, #2]
c0d00cd0:	784b      	ldrb	r3, [r1, #1]
c0d00cd2:	021b      	lsls	r3, r3, #8
c0d00cd4:	189a      	adds	r2, r3, r2
c0d00cd6:	237d      	movs	r3, #125	; 0x7d

    G_io_app.apdu_media = IO_APDU_MEDIA_RAW; // for application code
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
    G_io_app.apdu_length = MIN(size, max);
c0d00cd8:	2a7d      	cmp	r2, #125	; 0x7d
c0d00cda:	d300      	bcc.n	c0d00cde <io_seproxyhal_handle_capdu_event+0x26>
c0d00cdc:	461a      	mov	r2, r3
c0d00cde:	8042      	strh	r2, [r0, #2]
    // copy apdu to apdu buffer
    os_memmove(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_app.apdu_length);
c0d00ce0:	1cc9      	adds	r1, r1, #3
c0d00ce2:	4804      	ldr	r0, [pc, #16]	; (c0d00cf4 <io_seproxyhal_handle_capdu_event+0x3c>)
c0d00ce4:	f7ff fee6 	bl	c0d00ab4 <os_memmove>
  }
}
c0d00ce8:	bd80      	pop	{r7, pc}
c0d00cea:	46c0      	nop			; (mov r8, r8)
c0d00cec:	20001be0 	.word	0x20001be0
c0d00cf0:	20001a0c 	.word	0x20001a0c
c0d00cf4:	20001a8e 	.word	0x20001a8e

c0d00cf8 <io_seproxyhal_handle_event>:

unsigned int io_seproxyhal_handle_event(void) {
c0d00cf8:	b510      	push	{r4, lr}
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d00cfa:	4820      	ldr	r0, [pc, #128]	; (c0d00d7c <io_seproxyhal_handle_event+0x84>)
c0d00cfc:	7881      	ldrb	r1, [r0, #2]
c0d00cfe:	7842      	ldrb	r2, [r0, #1]
c0d00d00:	0212      	lsls	r2, r2, #8
c0d00d02:	1851      	adds	r1, r2, r1

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d00d04:	7800      	ldrb	r0, [r0, #0]
c0d00d06:	280f      	cmp	r0, #15
c0d00d08:	dc0a      	bgt.n	c0d00d20 <io_seproxyhal_handle_event+0x28>
c0d00d0a:	280e      	cmp	r0, #14
c0d00d0c:	d010      	beq.n	c0d00d30 <io_seproxyhal_handle_event+0x38>
c0d00d0e:	280f      	cmp	r0, #15
c0d00d10:	d122      	bne.n	c0d00d58 <io_seproxyhal_handle_event+0x60>
c0d00d12:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 1) {
c0d00d14:	2901      	cmp	r1, #1
c0d00d16:	d126      	bne.n	c0d00d66 <io_seproxyhal_handle_event+0x6e>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d00d18:	f7ff ff1c 	bl	c0d00b54 <io_seproxyhal_handle_usb_event>
c0d00d1c:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d00d1e:	bd10      	pop	{r4, pc}
}

unsigned int io_seproxyhal_handle_event(void) {
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d00d20:	2810      	cmp	r0, #16
c0d00d22:	d01d      	beq.n	c0d00d60 <io_seproxyhal_handle_event+0x68>
c0d00d24:	2816      	cmp	r0, #22
c0d00d26:	d117      	bne.n	c0d00d58 <io_seproxyhal_handle_event+0x60>
      }
      return 1;
  #endif // HAVE_BLE

    case SEPROXYHAL_TAG_CAPDU_EVENT:
      io_seproxyhal_handle_capdu_event();
c0d00d28:	f7ff ffc6 	bl	c0d00cb8 <io_seproxyhal_handle_capdu_event>
c0d00d2c:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d00d2e:	bd10      	pop	{r4, pc}
      return 1;

      // ask the user if not processed here
    case SEPROXYHAL_TAG_TICKER_EVENT:
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
      G_io_app.ms += 100; // value is by default, don't change the ticker configuration
c0d00d30:	4813      	ldr	r0, [pc, #76]	; (c0d00d80 <io_seproxyhal_handle_event+0x88>)
c0d00d32:	6881      	ldr	r1, [r0, #8]
c0d00d34:	3164      	adds	r1, #100	; 0x64
c0d00d36:	6081      	str	r1, [r0, #8]
c0d00d38:	211c      	movs	r1, #28
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
          if (G_io_app.usb_ep_timeouts[i].timeout) {
c0d00d3a:	5a42      	ldrh	r2, [r0, r1]
c0d00d3c:	2a00      	cmp	r2, #0
c0d00d3e:	d008      	beq.n	c0d00d52 <io_seproxyhal_handle_event+0x5a>
c0d00d40:	2364      	movs	r3, #100	; 0x64
            G_io_app.usb_ep_timeouts[i].timeout-=MIN(G_io_app.usb_ep_timeouts[i].timeout, 100);
c0d00d42:	2a64      	cmp	r2, #100	; 0x64
c0d00d44:	4614      	mov	r4, r2
c0d00d46:	d300      	bcc.n	c0d00d4a <io_seproxyhal_handle_event+0x52>
c0d00d48:	461c      	mov	r4, r3
c0d00d4a:	1b12      	subs	r2, r2, r4
c0d00d4c:	5242      	strh	r2, [r0, r1]
            if (!G_io_app.usb_ep_timeouts[i].timeout) {
c0d00d4e:	0412      	lsls	r2, r2, #16
c0d00d50:	d00e      	beq.n	c0d00d70 <io_seproxyhal_handle_event+0x78>
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
      G_io_app.ms += 100; // value is by default, don't change the ticker configuration
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
c0d00d52:	1e89      	subs	r1, r1, #2
c0d00d54:	2910      	cmp	r1, #16
c0d00d56:	d1f0      	bne.n	c0d00d3a <io_seproxyhal_handle_event+0x42>
c0d00d58:	2002      	movs	r0, #2
        __attribute__((fallthrough));
      }
#endif // HAVE_BLE_APDU
      // no break is intentional
    default:
      return io_event(CHANNEL_SPI);
c0d00d5a:	f7ff fb0f 	bl	c0d0037c <io_event>
  }
  // defaultly return as not processed
  return 0;
}
c0d00d5e:	bd10      	pop	{r4, pc}
c0d00d60:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3) {
c0d00d62:	2903      	cmp	r1, #3
c0d00d64:	d200      	bcs.n	c0d00d68 <io_seproxyhal_handle_event+0x70>
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d00d66:	bd10      	pop	{r4, pc}
    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3) {
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d00d68:	f7ff ff3c 	bl	c0d00be4 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d00d6c:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d00d6e:	bd10      	pop	{r4, pc}
c0d00d70:	2100      	movs	r1, #0
        while(i--) {
          if (G_io_app.usb_ep_timeouts[i].timeout) {
            G_io_app.usb_ep_timeouts[i].timeout-=MIN(G_io_app.usb_ep_timeouts[i].timeout, 100);
            if (!G_io_app.usb_ep_timeouts[i].timeout) {
              // timeout !
              G_io_app.apdu_state = APDU_IDLE;
c0d00d72:	7001      	strb	r1, [r0, #0]
c0d00d74:	2010      	movs	r0, #16
              THROW(EXCEPTION_IO_RESET);
c0d00d76:	f7ff fed0 	bl	c0d00b1a <os_longjmp>
c0d00d7a:	46c0      	nop			; (mov r8, r8)
c0d00d7c:	20001a0c 	.word	0x20001a0c
c0d00d80:	20001be0 	.word	0x20001be0

c0d00d84 <io_seproxyhal_init>:
#ifdef HAVE_BOLOS_APP_STACK_CANARY
#define APP_STACK_CANARY_MAGIC 0xDEAD0031
extern unsigned int app_stack_canary;
#endif // HAVE_BOLOS_APP_STACK_CANARY

void io_seproxyhal_init(void) {
c0d00d84:	b5b0      	push	{r4, r5, r7, lr}
c0d00d86:	200a      	movs	r0, #10
#ifndef HAVE_BOLOS
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d00d88:	f000 fe08 	bl	c0d0199c <check_api_level>

  // wipe the io structure before it's used
#ifdef TARGET_NANOX
  unsigned int plane = G_io_app.plane_mode;
#endif // TARGET_NANOX
  os_memset(&G_io_app, 0, sizeof(G_io_app));
c0d00d8c:	4c08      	ldr	r4, [pc, #32]	; (c0d00db0 <io_seproxyhal_init+0x2c>)
c0d00d8e:	2500      	movs	r5, #0
c0d00d90:	2220      	movs	r2, #32
c0d00d92:	4620      	mov	r0, r4
c0d00d94:	4629      	mov	r1, r5
c0d00d96:	f7ff fea3 	bl	c0d00ae0 <os_memset>
#ifdef TARGET_NANOX
  G_io_app.plane_mode = plane;
#endif // TARGET_NANOX

  G_io_app.apdu_state = APDU_IDLE;
  G_io_app.apdu_length = 0;
c0d00d9a:	8065      	strh	r5, [r4, #2]
  os_memset(&G_io_app, 0, sizeof(G_io_app));
#ifdef TARGET_NANOX
  G_io_app.plane_mode = plane;
#endif // TARGET_NANOX

  G_io_app.apdu_state = APDU_IDLE;
c0d00d9c:	7025      	strb	r5, [r4, #0]
  G_io_app.apdu_length = 0;
  G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d00d9e:	71a5      	strb	r5, [r4, #6]

  G_io_app.ms = 0;
c0d00da0:	60a5      	str	r5, [r4, #8]
  #ifdef DEBUG_APDU
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU

  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d00da2:	f000 fb31 	bl	c0d01408 <io_usb_hid_init>
// #endif // TARGET_NANOX
}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_ux_os.button_mask = 0;
c0d00da6:	4803      	ldr	r0, [pc, #12]	; (c0d00db4 <io_seproxyhal_init+0x30>)
c0d00da8:	6005      	str	r5, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d00daa:	6045      	str	r5, [r0, #4]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d00dac:	bdb0      	pop	{r4, r5, r7, pc}
c0d00dae:	46c0      	nop			; (mov r8, r8)
c0d00db0:	20001be0 	.word	0x20001be0
c0d00db4:	20001c00 	.word	0x20001c00

c0d00db8 <io_seproxyhal_init_ux>:

// #ifdef TARGET_NANOX
//   // wipe frame buffer
//   screen_clear();
// #endif // TARGET_NANOX
}
c0d00db8:	4770      	bx	lr
	...

c0d00dbc <io_seproxyhal_init_button>:

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_ux_os.button_mask = 0;
c0d00dbc:	4802      	ldr	r0, [pc, #8]	; (c0d00dc8 <io_seproxyhal_init_button+0xc>)
c0d00dbe:	2100      	movs	r1, #0
c0d00dc0:	6001      	str	r1, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d00dc2:	6041      	str	r1, [r0, #4]
}
c0d00dc4:	4770      	bx	lr
c0d00dc6:	46c0      	nop			; (mov r8, r8)
c0d00dc8:	20001c00 	.word	0x20001c00

c0d00dcc <io_seproxyhal_display_icon>:
    }
  }
}

#else // TARGET_NANOX
void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_det) {
c0d00dcc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00dce:	b089      	sub	sp, #36	; 0x24
c0d00dd0:	4605      	mov	r5, r0
  bagl_component_t icon_component_mod;
  const bagl_icon_details_t* icon_details = (bagl_icon_details_t*)PIC(icon_det);
c0d00dd2:	4608      	mov	r0, r1
c0d00dd4:	f000 fd5c 	bl	c0d01890 <pic>
  if (icon_details && icon_details->bitmap) {
c0d00dd8:	2800      	cmp	r0, #0
c0d00dda:	d043      	beq.n	c0d00e64 <io_seproxyhal_display_icon+0x98>
c0d00ddc:	4604      	mov	r4, r0
c0d00dde:	6900      	ldr	r0, [r0, #16]
c0d00de0:	2800      	cmp	r0, #0
c0d00de2:	d03f      	beq.n	c0d00e64 <io_seproxyhal_display_icon+0x98>
    // ensure not being out of bounds in the icon component agianst the declared icon real size
    os_memmove(&icon_component_mod, PIC(icon_component), sizeof(bagl_component_t));
c0d00de4:	4628      	mov	r0, r5
c0d00de6:	f000 fd53 	bl	c0d01890 <pic>
c0d00dea:	4601      	mov	r1, r0
c0d00dec:	ad02      	add	r5, sp, #8
c0d00dee:	221c      	movs	r2, #28
c0d00df0:	4628      	mov	r0, r5
c0d00df2:	9201      	str	r2, [sp, #4]
c0d00df4:	f7ff fe5e 	bl	c0d00ab4 <os_memmove>
    icon_component_mod.width = icon_details->width;
c0d00df8:	6821      	ldr	r1, [r4, #0]
c0d00dfa:	80e9      	strh	r1, [r5, #6]
    icon_component_mod.height = icon_details->height;
c0d00dfc:	6862      	ldr	r2, [r4, #4]
c0d00dfe:	812a      	strh	r2, [r5, #8]
    // component type = ICON, provided bitmap
    // => bitmap transmitted


    // color index size
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d00e00:	68a0      	ldr	r0, [r4, #8]
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
                            +w; /* image bitmap size */
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d00e02:	4f19      	ldr	r7, [pc, #100]	; (c0d00e68 <io_seproxyhal_display_icon+0x9c>)
c0d00e04:	2365      	movs	r3, #101	; 0x65
c0d00e06:	703b      	strb	r3, [r7, #0]


    // color index size
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
    // bitmap size
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d00e08:	b289      	uxth	r1, r1
c0d00e0a:	b292      	uxth	r2, r2
c0d00e0c:	434a      	muls	r2, r1
c0d00e0e:	4342      	muls	r2, r0
c0d00e10:	0753      	lsls	r3, r2, #29
c0d00e12:	08d1      	lsrs	r1, r2, #3
c0d00e14:	1c4a      	adds	r2, r1, #1
c0d00e16:	2b00      	cmp	r3, #0
c0d00e18:	d100      	bne.n	c0d00e1c <io_seproxyhal_display_icon+0x50>
c0d00e1a:	460a      	mov	r2, r1
c0d00e1c:	9200      	str	r2, [sp, #0]
c0d00e1e:	2604      	movs	r6, #4
    // component type = ICON, provided bitmap
    // => bitmap transmitted


    // color index size
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d00e20:	4086      	lsls	r6, r0
    // bitmap size
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
c0d00e22:	18b0      	adds	r0, r6, r2
                            +w; /* image bitmap size */
c0d00e24:	301d      	adds	r0, #29
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
    G_io_seproxyhal_spi_buffer[1] = length>>8;
    G_io_seproxyhal_spi_buffer[2] = length;
c0d00e26:	70b8      	strb	r0, [r7, #2]
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
                            +w; /* image bitmap size */
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
    G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d00e28:	0a00      	lsrs	r0, r0, #8
c0d00e2a:	7078      	strb	r0, [r7, #1]
c0d00e2c:	2103      	movs	r1, #3
    G_io_seproxyhal_spi_buffer[2] = length;
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d00e2e:	4638      	mov	r0, r7
c0d00e30:	f000 feb0 	bl	c0d01b94 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d00e34:	4628      	mov	r0, r5
c0d00e36:	9901      	ldr	r1, [sp, #4]
c0d00e38:	f000 feac 	bl	c0d01b94 <io_seph_send>
    G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d00e3c:	68a0      	ldr	r0, [r4, #8]
c0d00e3e:	7038      	strb	r0, [r7, #0]
c0d00e40:	2101      	movs	r1, #1
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d00e42:	4638      	mov	r0, r7
c0d00e44:	f000 fea6 	bl	c0d01b94 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d00e48:	68e0      	ldr	r0, [r4, #12]
c0d00e4a:	f000 fd21 	bl	c0d01890 <pic>
c0d00e4e:	b2b1      	uxth	r1, r6
c0d00e50:	f000 fea0 	bl	c0d01b94 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d00e54:	9800      	ldr	r0, [sp, #0]
c0d00e56:	b285      	uxth	r5, r0
c0d00e58:	6920      	ldr	r0, [r4, #16]
c0d00e5a:	f000 fd19 	bl	c0d01890 <pic>
c0d00e5e:	4629      	mov	r1, r5
c0d00e60:	f000 fe98 	bl	c0d01b94 <io_seph_send>
  #endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
  }
}
c0d00e64:	b009      	add	sp, #36	; 0x24
c0d00e66:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00e68:	20001a0c 	.word	0x20001a0c

c0d00e6c <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(const bagl_element_t * el) {
c0d00e6c:	b570      	push	{r4, r5, r6, lr}

  const bagl_element_t* element = (const bagl_element_t*) PIC(el);
c0d00e6e:	f000 fd0f 	bl	c0d01890 <pic>
c0d00e72:	4604      	mov	r4, r0

  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d00e74:	7800      	ldrb	r0, [r0, #0]
c0d00e76:	267f      	movs	r6, #127	; 0x7f
c0d00e78:	4006      	ands	r6, r0

  // avoid sending another status :), fixes a lot of bugs in the end
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00e7a:	f000 fe97 	bl	c0d01bac <io_seph_is_status_sent>
c0d00e7e:	2800      	cmp	r0, #0
c0d00e80:	d130      	bne.n	c0d00ee4 <io_seproxyhal_display_default+0x78>
c0d00e82:	2e00      	cmp	r6, #0
c0d00e84:	d02e      	beq.n	c0d00ee4 <io_seproxyhal_display_default+0x78>
    return;
  }

  if (type != BAGL_NONE) {
    if (element->text != NULL) {
c0d00e86:	69e0      	ldr	r0, [r4, #28]
c0d00e88:	2800      	cmp	r0, #0
c0d00e8a:	d01d      	beq.n	c0d00ec8 <io_seproxyhal_display_default+0x5c>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d00e8c:	f000 fd00 	bl	c0d01890 <pic>
c0d00e90:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d00e92:	2e05      	cmp	r6, #5
c0d00e94:	d102      	bne.n	c0d00e9c <io_seproxyhal_display_default+0x30>
c0d00e96:	7ea0      	ldrb	r0, [r4, #26]
c0d00e98:	2800      	cmp	r0, #0
c0d00e9a:	d024      	beq.n	c0d00ee6 <io_seproxyhal_display_default+0x7a>
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d00e9c:	4628      	mov	r0, r5
c0d00e9e:	f003 fc11 	bl	c0d046c4 <strlen>
c0d00ea2:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d00ea4:	4812      	ldr	r0, [pc, #72]	; (c0d00ef0 <io_seproxyhal_display_default+0x84>)
c0d00ea6:	2165      	movs	r1, #101	; 0x65
c0d00ea8:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d00eaa:	4631      	mov	r1, r6
c0d00eac:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
        G_io_seproxyhal_spi_buffer[2] = length;
c0d00eae:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d00eb0:	0a09      	lsrs	r1, r1, #8
c0d00eb2:	7041      	strb	r1, [r0, #1]
c0d00eb4:	2103      	movs	r1, #3
        G_io_seproxyhal_spi_buffer[2] = length;
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d00eb6:	f000 fe6d 	bl	c0d01b94 <io_seph_send>
c0d00eba:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d00ebc:	4620      	mov	r0, r4
c0d00ebe:	f000 fe69 	bl	c0d01b94 <io_seph_send>
        io_seproxyhal_spi_send((unsigned char*)text_adr, length-sizeof(bagl_component_t));
c0d00ec2:	b2b1      	uxth	r1, r6
c0d00ec4:	4628      	mov	r0, r5
c0d00ec6:	e00b      	b.n	c0d00ee0 <io_seproxyhal_display_default+0x74>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d00ec8:	4809      	ldr	r0, [pc, #36]	; (c0d00ef0 <io_seproxyhal_display_default+0x84>)
c0d00eca:	2100      	movs	r1, #0
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d00ecc:	7041      	strb	r1, [r0, #1]
c0d00ece:	2165      	movs	r1, #101	; 0x65
        io_seproxyhal_spi_send((unsigned char*)text_adr, length-sizeof(bagl_component_t));
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d00ed0:	7001      	strb	r1, [r0, #0]
c0d00ed2:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[1] = length>>8;
      G_io_seproxyhal_spi_buffer[2] = length;
c0d00ed4:	7085      	strb	r5, [r0, #2]
c0d00ed6:	2103      	movs	r1, #3
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d00ed8:	f000 fe5c 	bl	c0d01b94 <io_seph_send>
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d00edc:	4620      	mov	r0, r4
c0d00ede:	4629      	mov	r1, r5
c0d00ee0:	f000 fe58 	bl	c0d01b94 <io_seph_send>
    }
  }
}
c0d00ee4:	bd70      	pop	{r4, r5, r6, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
c0d00ee6:	4620      	mov	r0, r4
c0d00ee8:	4629      	mov	r1, r5
c0d00eea:	f7ff ff6f 	bl	c0d00dcc <io_seproxyhal_display_icon>
      G_io_seproxyhal_spi_buffer[2] = length;
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
    }
  }
}
c0d00eee:	bd70      	pop	{r4, r5, r6, pc}
c0d00ef0:	20001a0c 	.word	0x20001a0c

c0d00ef4 <io_seproxyhal_button_push>:
  
  // compute scrolled text length
  return 2*(textlen - e->component.width)*1000/e->component.icon_id + 2*(e->component.stroke & ~(0x80))*100;
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d00ef4:	b570      	push	{r4, r5, r6, lr}
  if (button_callback) {
c0d00ef6:	2800      	cmp	r0, #0
c0d00ef8:	d029      	beq.n	c0d00f4e <io_seproxyhal_button_push+0x5a>
c0d00efa:	4604      	mov	r4, r0
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_ux_os.button_mask) {
c0d00efc:	4814      	ldr	r0, [pc, #80]	; (c0d00f50 <io_seproxyhal_button_push+0x5c>)
c0d00efe:	6806      	ldr	r6, [r0, #0]
c0d00f00:	6845      	ldr	r5, [r0, #4]
c0d00f02:	428e      	cmp	r6, r1
c0d00f04:	d101      	bne.n	c0d00f0a <io_seproxyhal_button_push+0x16>
      // each 100ms ~
      G_ux_os.button_same_mask_counter++;
c0d00f06:	1c6d      	adds	r5, r5, #1
c0d00f08:	6045      	str	r5, [r0, #4]
    }

    // when new_button_mask is 0 and 

    // append the button mask
    button_mask = G_ux_os.button_mask | new_button_mask;
c0d00f0a:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_ux_os.button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
c0d00f0c:	2900      	cmp	r1, #0
c0d00f0e:	d002      	beq.n	c0d00f16 <io_seproxyhal_button_push+0x22>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_ux_os.button_mask = button_mask;
c0d00f10:	6006      	str	r6, [r0, #0]
    }

    // reset counter when button mask changes
    if (new_button_mask != G_ux_os.button_mask) {
c0d00f12:	4632      	mov	r2, r6
c0d00f14:	e005      	b.n	c0d00f22 <io_seproxyhal_button_push+0x2e>
c0d00f16:	2200      	movs	r2, #0
    button_same_mask_counter = G_ux_os.button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_ux_os.button_mask = 0;
c0d00f18:	6002      	str	r2, [r0, #0]
      G_ux_os.button_same_mask_counter=0;
c0d00f1a:	6042      	str	r2, [r0, #4]
c0d00f1c:	4b0d      	ldr	r3, [pc, #52]	; (c0d00f54 <io_seproxyhal_button_push+0x60>)

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d00f1e:	1c5b      	adds	r3, r3, #1
c0d00f20:	431e      	orrs	r6, r3
    else {
      G_ux_os.button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_ux_os.button_mask) {
c0d00f22:	428a      	cmp	r2, r1
c0d00f24:	d001      	beq.n	c0d00f2a <io_seproxyhal_button_push+0x36>
c0d00f26:	2100      	movs	r1, #0
      G_ux_os.button_same_mask_counter=0;
c0d00f28:	6041      	str	r1, [r0, #4]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d00f2a:	2d08      	cmp	r5, #8
c0d00f2c:	d30c      	bcc.n	c0d00f48 <io_seproxyhal_button_push+0x54>
c0d00f2e:	2103      	movs	r1, #3
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d00f30:	4628      	mov	r0, r5
c0d00f32:	f003 fb03 	bl	c0d0453c <__aeabi_uidivmod>
c0d00f36:	2201      	movs	r2, #1
c0d00f38:	0790      	lsls	r0, r2, #30
        button_mask |= BUTTON_EVT_FAST;
c0d00f3a:	4330      	orrs	r0, r6
      G_ux_os.button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d00f3c:	2900      	cmp	r1, #0
c0d00f3e:	d000      	beq.n	c0d00f42 <io_seproxyhal_button_push+0x4e>
c0d00f40:	4630      	mov	r0, r6
c0d00f42:	07d1      	lsls	r1, r2, #31
      }
      */

      // discard the release event after a fastskip has been detected, to avoid strange at release behavior
      // and also to enable user to cancel an operation by starting triggering the fast skip
      button_mask &= ~BUTTON_EVT_RELEASED;
c0d00f44:	4388      	bics	r0, r1
c0d00f46:	e000      	b.n	c0d00f4a <io_seproxyhal_button_push+0x56>
c0d00f48:	4630      	mov	r0, r6
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d00f4a:	4629      	mov	r1, r5
c0d00f4c:	47a0      	blx	r4

  }
}
c0d00f4e:	bd70      	pop	{r4, r5, r6, pc}
c0d00f50:	20001c00 	.word	0x20001c00
c0d00f54:	7fffffff 	.word	0x7fffffff

c0d00f58 <os_io_seproxyhal_get_app_name_and_version>:
#ifdef HAVE_IO_U2F
u2f_service_t G_io_u2f;
#endif // HAVE_IO_U2F

unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
c0d00f58:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f5a:	b081      	sub	sp, #4
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d00f5c:	4e0f      	ldr	r6, [pc, #60]	; (c0d00f9c <os_io_seproxyhal_get_app_name_and_version+0x44>)
c0d00f5e:	2401      	movs	r4, #1
c0d00f60:	7034      	strb	r4, [r6, #0]

#ifndef HAVE_BOLOS
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d00f62:	1cb1      	adds	r1, r6, #2
c0d00f64:	27ff      	movs	r7, #255	; 0xff
c0d00f66:	3750      	adds	r7, #80	; 0x50
c0d00f68:	1c7a      	adds	r2, r7, #1
c0d00f6a:	4620      	mov	r0, r4
c0d00f6c:	f000 fdf8 	bl	c0d01b60 <os_registry_get_current_app_tag>
c0d00f70:	4605      	mov	r5, r0
  G_io_apdu_buffer[tx_len++] = len;
c0d00f72:	7070      	strb	r0, [r6, #1]
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d00f74:	1a3a      	subs	r2, r7, r0
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d00f76:	1837      	adds	r7, r6, r0
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
  G_io_apdu_buffer[tx_len++] = len;
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d00f78:	1cf9      	adds	r1, r7, #3
c0d00f7a:	2002      	movs	r0, #2
c0d00f7c:	f000 fdf0 	bl	c0d01b60 <os_registry_get_current_app_tag>
  G_io_apdu_buffer[tx_len++] = len;
c0d00f80:	70b8      	strb	r0, [r7, #2]
c0d00f82:	182d      	adds	r5, r5, r0
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d00f84:	1976      	adds	r6, r6, r5
#endif // HAVE_BOLOS

#if !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)
  // to be fixed within io tasks
  // return OS flags to notify of platform's global state (pin lock etc)
  G_io_apdu_buffer[tx_len++] = 1; // flags length
c0d00f86:	70f4      	strb	r4, [r6, #3]
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d00f88:	f000 fdde 	bl	c0d01b48 <os_flags>
c0d00f8c:	7130      	strb	r0, [r6, #4]
c0d00f8e:	2090      	movs	r0, #144	; 0x90
#endif // !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)

  // status words
  G_io_apdu_buffer[tx_len++] = 0x90;
c0d00f90:	7170      	strb	r0, [r6, #5]
c0d00f92:	2000      	movs	r0, #0
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d00f94:	71b0      	strb	r0, [r6, #6]
c0d00f96:	1de8      	adds	r0, r5, #7
  return tx_len;
c0d00f98:	b001      	add	sp, #4
c0d00f9a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00f9c:	20001a8e 	.word	0x20001a8e

c0d00fa0 <io_exchange>:
}


unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d00fa0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00fa2:	b08b      	sub	sp, #44	; 0x2c
c0d00fa4:	4607      	mov	r7, r0
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d00fa6:	0740      	lsls	r0, r0, #29
c0d00fa8:	d008      	beq.n	c0d00fbc <io_exchange+0x1c>
c0d00faa:	9707      	str	r7, [sp, #28]
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d00fac:	9807      	ldr	r0, [sp, #28]
c0d00fae:	b2c0      	uxtb	r0, r0
c0d00fb0:	b289      	uxth	r1, r1
c0d00fb2:	f7ff fcd3 	bl	c0d0095c <io_exchange_al>
  }
}
c0d00fb6:	b280      	uxth	r0, r0
c0d00fb8:	b00b      	add	sp, #44	; 0x2c
c0d00fba:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00fbc:	2080      	movs	r0, #128	; 0x80
c0d00fbe:	9006      	str	r0, [sp, #24]
c0d00fc0:	4ca5      	ldr	r4, [pc, #660]	; (c0d01258 <io_exchange+0x2b8>)
c0d00fc2:	4ea4      	ldr	r6, [pc, #656]	; (c0d01254 <io_exchange+0x2b4>)
c0d00fc4:	9707      	str	r7, [sp, #28]
c0d00fc6:	2010      	movs	r0, #16
reply_apdu:
  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d00fc8:	463d      	mov	r5, r7
c0d00fca:	4005      	ands	r5, r0
c0d00fcc:	b28a      	uxth	r2, r1
c0d00fce:	2a00      	cmp	r2, #0
c0d00fd0:	d100      	bne.n	c0d00fd4 <io_exchange+0x34>
c0d00fd2:	e0b6      	b.n	c0d01142 <io_exchange+0x1a2>
c0d00fd4:	2d00      	cmp	r5, #0
c0d00fd6:	d000      	beq.n	c0d00fda <io_exchange+0x3a>
c0d00fd8:	e0b3      	b.n	c0d01142 <io_exchange+0x1a2>
c0d00fda:	9205      	str	r2, [sp, #20]
c0d00fdc:	9102      	str	r1, [sp, #8]
c0d00fde:	9003      	str	r0, [sp, #12]
c0d00fe0:	9504      	str	r5, [sp, #16]
c0d00fe2:	e007      	b.n	c0d00ff4 <io_exchange+0x54>
c0d00fe4:	2180      	movs	r1, #128	; 0x80
c0d00fe6:	2200      	movs	r2, #0
      // ensure it's our turn to send a command/status, could lag a bit before sending the reply
      while (io_seproxyhal_spi_is_status_sent()) {
        io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00fe8:	4630      	mov	r0, r6
c0d00fea:	f000 fdeb 	bl	c0d01bc4 <io_seph_recv>
c0d00fee:	2001      	movs	r0, #1
        // process without sending status on tickers etc, to ensure keeping the hand
        os_io_seph_recv_and_process(1);
c0d00ff0:	f000 f946 	bl	c0d01280 <os_io_seph_recv_and_process>
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
      // ensure it's our turn to send a command/status, could lag a bit before sending the reply
      while (io_seproxyhal_spi_is_status_sent()) {
c0d00ff4:	f000 fdda 	bl	c0d01bac <io_seph_is_status_sent>
c0d00ff8:	2800      	cmp	r0, #0
c0d00ffa:	d1f3      	bne.n	c0d00fe4 <io_exchange+0x44>
c0d00ffc:	207d      	movs	r0, #125	; 0x7d
c0d00ffe:	0100      	lsls	r0, r0, #4
        // process without sending status on tickers etc, to ensure keeping the hand
        os_io_seph_recv_and_process(1);
      }

      // reinit sending timeout for APDU replied within io_exchange
      timeout_ms = G_io_app.ms + IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d01000:	68a1      	ldr	r1, [r4, #8]
c0d01002:	180d      	adds	r5, r1, r0

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_app.apdu_state) {
c0d01004:	7820      	ldrb	r0, [r4, #0]
c0d01006:	2809      	cmp	r0, #9
c0d01008:	dc43      	bgt.n	c0d01092 <io_exchange+0xf2>
c0d0100a:	2807      	cmp	r0, #7
c0d0100c:	9905      	ldr	r1, [sp, #20]
c0d0100e:	d04b      	beq.n	c0d010a8 <io_exchange+0x108>
c0d01010:	2809      	cmp	r0, #9
c0d01012:	d165      	bne.n	c0d010e0 <io_exchange+0x140>
c0d01014:	2100      	movs	r1, #0
c0d01016:	4891      	ldr	r0, [pc, #580]	; (c0d0125c <io_exchange+0x2bc>)
c0d01018:	9101      	str	r1, [sp, #4]
          // case to handle U2F channels. u2f apdu to be dispatched in the upper layers
          case APDU_U2F:
            // prepare reply, the remaining segments will be pumped during USB/BLE events handling while waiting for the next APDU

            // the reply has been prepared by the application, stop sending anti timeouts
            u2f_message_set_autoreply_wait_user_presence(&G_io_u2f, false);
c0d0101a:	f001 faad 	bl	c0d02578 <u2f_message_set_autoreply_wait_user_presence>
c0d0101e:	e010      	b.n	c0d01042 <io_exchange+0xa2>

            // continue processing currently received command until completely received.
            while(!u2f_message_repliable(&G_io_u2f)) {

              io_seproxyhal_general_status();
c0d01020:	f7ff fd82 	bl	c0d00b28 <io_seproxyhal_general_status>
c0d01024:	2180      	movs	r1, #128	; 0x80
c0d01026:	2200      	movs	r2, #0
              do {
                io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01028:	4630      	mov	r0, r6
c0d0102a:	f000 fdcb 	bl	c0d01bc4 <io_seph_recv>
                // check for reply timeout
                if (G_io_app.ms >= timeout_ms) {
c0d0102e:	68a0      	ldr	r0, [r4, #8]
c0d01030:	42a8      	cmp	r0, r5
c0d01032:	d300      	bcc.n	c0d01036 <io_exchange+0x96>
c0d01034:	e103      	b.n	c0d0123e <io_exchange+0x29e>
                  THROW(EXCEPTION_IO_RESET);
                }
                // avoid a general status to be replied
                io_seproxyhal_handle_event();
c0d01036:	f7ff fe5f 	bl	c0d00cf8 <io_seproxyhal_handle_event>
              } while (io_seproxyhal_spi_is_status_sent());
c0d0103a:	f000 fdb7 	bl	c0d01bac <io_seph_is_status_sent>
c0d0103e:	2800      	cmp	r0, #0
c0d01040:	d1f0      	bne.n	c0d01024 <io_exchange+0x84>

            // the reply has been prepared by the application, stop sending anti timeouts
            u2f_message_set_autoreply_wait_user_presence(&G_io_u2f, false);

            // continue processing currently received command until completely received.
            while(!u2f_message_repliable(&G_io_u2f)) {
c0d01042:	4886      	ldr	r0, [pc, #536]	; (c0d0125c <io_exchange+0x2bc>)
c0d01044:	f000 fff0 	bl	c0d02028 <u2f_message_repliable>
c0d01048:	2800      	cmp	r0, #0
c0d0104a:	d0e9      	beq.n	c0d01020 <io_exchange+0x80>
c0d0104c:	9a05      	ldr	r2, [sp, #20]
              } while (io_seproxyhal_spi_is_status_sent());
            }
#ifdef U2F_PROXY_MAGIC

            // user presence + counter + rapdu + sw must fit the apdu buffer
            if (1U+ 4U+ tx_len +2U > sizeof(G_io_apdu_buffer)) {
c0d0104e:	1dd0      	adds	r0, r2, #7
c0d01050:	0840      	lsrs	r0, r0, #1
c0d01052:	28a9      	cmp	r0, #169	; 0xa9
c0d01054:	d300      	bcc.n	c0d01058 <io_exchange+0xb8>
c0d01056:	e0f8      	b.n	c0d0124a <io_exchange+0x2aa>
              THROW(INVALID_PARAMETER);
            }

            // u2F tunnel needs the status words to be included in the signature response BLOB, do it now.
            // always return 9000 in the signature to avoid error @ transport level in u2f layers. 
            G_io_apdu_buffer[tx_len] = 0x90; //G_io_apdu_buffer[tx_len-2];
c0d01058:	9806      	ldr	r0, [sp, #24]
c0d0105a:	3010      	adds	r0, #16
c0d0105c:	4980      	ldr	r1, [pc, #512]	; (c0d01260 <io_exchange+0x2c0>)
c0d0105e:	5488      	strb	r0, [r1, r2]
c0d01060:	1888      	adds	r0, r1, r2
            G_io_apdu_buffer[tx_len+1] = 0x00; //G_io_apdu_buffer[tx_len-1];
c0d01062:	9a01      	ldr	r2, [sp, #4]
c0d01064:	7042      	strb	r2, [r0, #1]
            tx_len += 2;
            os_memmove(G_io_apdu_buffer+5, G_io_apdu_buffer, tx_len);
c0d01066:	1d48      	adds	r0, r1, #5

            // u2F tunnel needs the status words to be included in the signature response BLOB, do it now.
            // always return 9000 in the signature to avoid error @ transport level in u2f layers. 
            G_io_apdu_buffer[tx_len] = 0x90; //G_io_apdu_buffer[tx_len-2];
            G_io_apdu_buffer[tx_len+1] = 0x00; //G_io_apdu_buffer[tx_len-1];
            tx_len += 2;
c0d01068:	9a02      	ldr	r2, [sp, #8]
c0d0106a:	1c92      	adds	r2, r2, #2
            os_memmove(G_io_apdu_buffer+5, G_io_apdu_buffer, tx_len);
c0d0106c:	b292      	uxth	r2, r2
c0d0106e:	f7ff fd21 	bl	c0d00ab4 <os_memmove>
c0d01072:	2205      	movs	r2, #5
            // zeroize user presence and counter
            os_memset(G_io_apdu_buffer, 0, 5);
c0d01074:	487a      	ldr	r0, [pc, #488]	; (c0d01260 <io_exchange+0x2c0>)
c0d01076:	9901      	ldr	r1, [sp, #4]
c0d01078:	f7ff fd32 	bl	c0d00ae0 <os_memset>
            u2f_message_reply(&G_io_u2f, U2F_CMD_MSG, G_io_apdu_buffer, tx_len+5);
c0d0107c:	9806      	ldr	r0, [sp, #24]
c0d0107e:	1cc0      	adds	r0, r0, #3
c0d01080:	b2c1      	uxtb	r1, r0
c0d01082:	9802      	ldr	r0, [sp, #8]
c0d01084:	1dc0      	adds	r0, r0, #7
c0d01086:	b283      	uxth	r3, r0
c0d01088:	4874      	ldr	r0, [pc, #464]	; (c0d0125c <io_exchange+0x2bc>)
c0d0108a:	4a75      	ldr	r2, [pc, #468]	; (c0d01260 <io_exchange+0x2c0>)
c0d0108c:	f001 fa88 	bl	c0d025a0 <u2f_message_reply>
c0d01090:	e041      	b.n	c0d01116 <io_exchange+0x176>
      // reinit sending timeout for APDU replied within io_exchange
      timeout_ms = G_io_app.ms + IO_RAPDU_TRANSMIT_TIMEOUT_MS;

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_app.apdu_state) {
c0d01092:	280a      	cmp	r0, #10
c0d01094:	9a02      	ldr	r2, [sp, #8]
c0d01096:	d00c      	beq.n	c0d010b2 <io_exchange+0x112>
c0d01098:	280b      	cmp	r0, #11
c0d0109a:	9905      	ldr	r1, [sp, #20]
c0d0109c:	d123      	bne.n	c0d010e6 <io_exchange+0x146>
            io_usb_ccid_reply(G_io_apdu_buffer, tx_len);
            goto break_send;
#endif // HAVE_USB_CLASS_CCID
#ifdef HAVE_WEBUSB
          case APDU_USB_WEBUSB:
            io_usb_hid_send(io_usb_send_apdu_data_ep0x83, tx_len);
c0d0109e:	4874      	ldr	r0, [pc, #464]	; (c0d01270 <io_exchange+0x2d0>)
c0d010a0:	4478      	add	r0, pc
c0d010a2:	f000 fa1b 	bl	c0d014dc <io_usb_hid_send>
c0d010a6:	e036      	b.n	c0d01116 <io_exchange+0x176>
            goto break_send;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_send(io_usb_send_apdu_data, tx_len);
c0d010a8:	4870      	ldr	r0, [pc, #448]	; (c0d0126c <io_exchange+0x2cc>)
c0d010aa:	4478      	add	r0, pc
c0d010ac:	f000 fa16 	bl	c0d014dc <io_usb_hid_send>
c0d010b0:	e031      	b.n	c0d01116 <io_exchange+0x176>
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
            break;

          case APDU_RAW:
            if (tx_len > sizeof(G_io_apdu_buffer)) {
c0d010b2:	4610      	mov	r0, r2
c0d010b4:	496b      	ldr	r1, [pc, #428]	; (c0d01264 <io_exchange+0x2c4>)
c0d010b6:	4008      	ands	r0, r1
c0d010b8:	0840      	lsrs	r0, r0, #1
c0d010ba:	28a9      	cmp	r0, #169	; 0xa9
c0d010bc:	d300      	bcc.n	c0d010c0 <io_exchange+0x120>
c0d010be:	e0c4      	b.n	c0d0124a <io_exchange+0x2aa>
c0d010c0:	2053      	movs	r0, #83	; 0x53
              THROW(INVALID_PARAMETER);
            }
            // reply the RAW APDU over SEPROXYHAL protocol
            G_io_seproxyhal_spi_buffer[0]  = SEPROXYHAL_TAG_RAPDU;
c0d010c2:	7030      	strb	r0, [r6, #0]
            G_io_seproxyhal_spi_buffer[1]  = (tx_len)>>8;
            G_io_seproxyhal_spi_buffer[2]  = (tx_len);
c0d010c4:	70b2      	strb	r2, [r6, #2]
            if (tx_len > sizeof(G_io_apdu_buffer)) {
              THROW(INVALID_PARAMETER);
            }
            // reply the RAW APDU over SEPROXYHAL protocol
            G_io_seproxyhal_spi_buffer[0]  = SEPROXYHAL_TAG_RAPDU;
            G_io_seproxyhal_spi_buffer[1]  = (tx_len)>>8;
c0d010c6:	0a10      	lsrs	r0, r2, #8
c0d010c8:	7070      	strb	r0, [r6, #1]
c0d010ca:	2103      	movs	r1, #3
            G_io_seproxyhal_spi_buffer[2]  = (tx_len);
            io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d010cc:	4630      	mov	r0, r6
c0d010ce:	f000 fd61 	bl	c0d01b94 <io_seph_send>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d010d2:	4863      	ldr	r0, [pc, #396]	; (c0d01260 <io_exchange+0x2c0>)
c0d010d4:	9905      	ldr	r1, [sp, #20]
c0d010d6:	f000 fd5d 	bl	c0d01b94 <io_seph_send>
c0d010da:	2000      	movs	r0, #0

            // isngle packet reply, mark immediate idle
            G_io_app.apdu_state = APDU_IDLE;
c0d010dc:	7020      	strb	r0, [r4, #0]
c0d010de:	e01d      	b.n	c0d0111c <io_exchange+0x17c>
      // reinit sending timeout for APDU replied within io_exchange
      timeout_ms = G_io_app.ms + IO_RAPDU_TRANSMIT_TIMEOUT_MS;

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_app.apdu_state) {
c0d010e0:	2800      	cmp	r0, #0
c0d010e2:	d100      	bne.n	c0d010e6 <io_exchange+0x146>
c0d010e4:	e0ae      	b.n	c0d01244 <io_exchange+0x2a4>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d010e6:	9807      	ldr	r0, [sp, #28]
c0d010e8:	b2c0      	uxtb	r0, r0
c0d010ea:	f7ff fc37 	bl	c0d0095c <io_exchange_al>
c0d010ee:	2800      	cmp	r0, #0
c0d010f0:	d011      	beq.n	c0d01116 <io_exchange+0x176>
c0d010f2:	e0a7      	b.n	c0d01244 <io_exchange+0x2a4>
        // TODO: add timeout here to avoid spending too much time when host has disconnected
        while (G_io_app.apdu_state != APDU_IDLE) {
#ifdef HAVE_TINY_COROUTINE
          tcr_yield();
#else // HAVE_TINY_COROUTINE
          io_seproxyhal_general_status();
c0d010f4:	f7ff fd18 	bl	c0d00b28 <io_seproxyhal_general_status>
c0d010f8:	2180      	movs	r1, #128	; 0x80
c0d010fa:	2200      	movs	r2, #0
          do {
            io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d010fc:	4630      	mov	r0, r6
c0d010fe:	f000 fd61 	bl	c0d01bc4 <io_seph_recv>
            // check for reply timeout (when asynch reply (over hid or u2f for example))
            // this case shall be covered by usb_ep_timeout but is not, investigate that
            if (G_io_app.ms >= timeout_ms) {
c0d01102:	68a0      	ldr	r0, [r4, #8]
c0d01104:	42a8      	cmp	r0, r5
c0d01106:	d300      	bcc.n	c0d0110a <io_exchange+0x16a>
c0d01108:	e099      	b.n	c0d0123e <io_exchange+0x29e>
              THROW(EXCEPTION_IO_RESET);
            }
            // avoid a general status to be replied
            io_seproxyhal_handle_event();
c0d0110a:	f7ff fdf5 	bl	c0d00cf8 <io_seproxyhal_handle_event>
          } while (io_seproxyhal_spi_is_status_sent());
c0d0110e:	f000 fd4d 	bl	c0d01bac <io_seph_is_status_sent>
c0d01112:	2800      	cmp	r0, #0
c0d01114:	d1f0      	bne.n	c0d010f8 <io_exchange+0x158>

      break_send:

        // wait end of reply transmission
        // TODO: add timeout here to avoid spending too much time when host has disconnected
        while (G_io_app.apdu_state != APDU_IDLE) {
c0d01116:	7820      	ldrb	r0, [r4, #0]
c0d01118:	2800      	cmp	r0, #0
c0d0111a:	d1eb      	bne.n	c0d010f4 <io_exchange+0x154>
c0d0111c:	2000      	movs	r0, #0
          } while (io_seproxyhal_spi_is_status_sent());
#endif // HAVE_TINY_COROUTINE
        }
        // reset apdu state
        G_io_app.apdu_state = APDU_IDLE;
        G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d0111e:	71a0      	strb	r0, [r4, #6]
            io_seproxyhal_handle_event();
          } while (io_seproxyhal_spi_is_status_sent());
#endif // HAVE_TINY_COROUTINE
        }
        // reset apdu state
        G_io_app.apdu_state = APDU_IDLE;
c0d01120:	7020      	strb	r0, [r4, #0]
        G_io_app.apdu_media = IO_APDU_MEDIA_NONE;

        G_io_app.apdu_length = 0;
c0d01122:	8060      	strh	r0, [r4, #2]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d01124:	06b9      	lsls	r1, r7, #26
c0d01126:	d500      	bpl.n	c0d0112a <io_exchange+0x18a>
c0d01128:	e745      	b.n	c0d00fb6 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d0112a:	f7ff fcfd 	bl	c0d00b28 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d0112e:	0638      	lsls	r0, r7, #24
c0d01130:	9d04      	ldr	r5, [sp, #16]
c0d01132:	9803      	ldr	r0, [sp, #12]
c0d01134:	d505      	bpl.n	c0d01142 <io_exchange+0x1a2>
#define SYSCALL_os_sched_exit_ID_IN 0x60009abeUL
#define SYSCALL_os_sched_exit_ID_OUT 0x90009adeUL
__attribute__((always_inline)) inline void
os_sched_exit_inline(bolos_task_status_t exit_code) {
  volatile unsigned int parameters[2 + 1];
  parameters[0] = (unsigned int)exit_code;
c0d01136:	9008      	str	r0, [sp, #32]
c0d01138:	aa08      	add	r2, sp, #32
  __asm volatile("mov r0, %1\n"
c0d0113a:	4b4b      	ldr	r3, [pc, #300]	; (c0d01268 <io_exchange+0x2c8>)
c0d0113c:	4618      	mov	r0, r3
c0d0113e:	4611      	mov	r1, r2
c0d01140:	df01      	svc	1
        //reset();
      }
    }

#ifndef HAVE_TINY_COROUTINE
    if (!(channel&IO_ASYNCH_REPLY)) {
c0d01142:	2d00      	cmp	r5, #0
c0d01144:	d104      	bne.n	c0d01150 <io_exchange+0x1b0>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d01146:	0678      	lsls	r0, r7, #25
c0d01148:	d474      	bmi.n	c0d01234 <io_exchange+0x294>
c0d0114a:	2000      	movs	r0, #0
        return G_io_app.apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_app.apdu_state = APDU_IDLE;
      G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d0114c:	71a0      	strb	r0, [r4, #6]
c0d0114e:	7020      	strb	r0, [r4, #0]
c0d01150:	2000      	movs	r0, #0
c0d01152:	8060      	strh	r0, [r4, #2]
#ifdef HAVE_TINY_COROUTINE
      // give back hand to the seph task which interprets all incoming events first
      tcr_yield();
#else // HAVE_TINY_COROUTINE

      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01154:	f000 fd2a 	bl	c0d01bac <io_seph_is_status_sent>
c0d01158:	2800      	cmp	r0, #0
c0d0115a:	d101      	bne.n	c0d01160 <io_exchange+0x1c0>
        io_seproxyhal_general_status();
c0d0115c:	f7ff fce4 	bl	c0d00b28 <io_seproxyhal_general_status>
c0d01160:	2180      	movs	r1, #128	; 0x80
c0d01162:	2500      	movs	r5, #0
      }
      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01164:	4630      	mov	r0, r6
c0d01166:	462a      	mov	r2, r5
c0d01168:	f000 fd2c 	bl	c0d01bc4 <io_seph_recv>

      // can't process split TLV, continue
      if (rx_len < 3 && rx_len != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])+3U) {
c0d0116c:	2802      	cmp	r0, #2
c0d0116e:	d806      	bhi.n	c0d0117e <io_exchange+0x1de>
c0d01170:	78b1      	ldrb	r1, [r6, #2]
c0d01172:	7872      	ldrb	r2, [r6, #1]
c0d01174:	0212      	lsls	r2, r2, #8
c0d01176:	1851      	adds	r1, r2, r1
c0d01178:	1cc9      	adds	r1, r1, #3
c0d0117a:	4281      	cmp	r1, r0
c0d0117c:	d13d      	bne.n	c0d011fa <io_exchange+0x25a>
        G_io_app.apdu_state = APDU_IDLE;
        G_io_app.apdu_length = 0;
        continue;
      }

      io_seproxyhal_handle_event();
c0d0117e:	f7ff fdbb 	bl	c0d00cf8 <io_seproxyhal_handle_event>
#endif // HAVE_TINY_COROUTINE

      // an apdu has been received asynchroneously, return it
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
c0d01182:	8860      	ldrh	r0, [r4, #2]
c0d01184:	7821      	ldrb	r1, [r4, #0]
c0d01186:	2900      	cmp	r1, #0
c0d01188:	d0e4      	beq.n	c0d01154 <io_exchange+0x1b4>
c0d0118a:	2800      	cmp	r0, #0
c0d0118c:	d0e2      	beq.n	c0d01154 <io_exchange+0x1b4>
#ifndef HAVE_BOLOS_NO_DEFAULT_APDU
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
c0d0118e:	4939      	ldr	r1, [pc, #228]	; (c0d01274 <io_exchange+0x2d4>)
c0d01190:	4479      	add	r1, pc
c0d01192:	2204      	movs	r2, #4
c0d01194:	4f32      	ldr	r7, [pc, #200]	; (c0d01260 <io_exchange+0x2c0>)
c0d01196:	4638      	mov	r0, r7
c0d01198:	f7ff fcab 	bl	c0d00af2 <os_memcmp>
c0d0119c:	2800      	cmp	r0, #0
c0d0119e:	d02e      	beq.n	c0d011fe <io_exchange+0x25e>
          // disable 'return after tx' and 'asynch reply' flags
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
c0d011a0:	4935      	ldr	r1, [pc, #212]	; (c0d01278 <io_exchange+0x2d8>)
c0d011a2:	4479      	add	r1, pc
c0d011a4:	2204      	movs	r2, #4
c0d011a6:	4638      	mov	r0, r7
c0d011a8:	f7ff fca3 	bl	c0d00af2 <os_memcmp>
c0d011ac:	2800      	cmp	r0, #0
c0d011ae:	d02b      	beq.n	c0d01208 <io_exchange+0x268>
        }
#ifndef BOLOS_OS_UPGRADER
        // seed cookie
        // host: <nothing>
        // device: <format(1B)> <len(1B)> <seed magic cookie if pin is entered(len)> 9000 | 6985
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\x02\x00\x00", 4) == 0) {
c0d011b0:	4932      	ldr	r1, [pc, #200]	; (c0d0127c <io_exchange+0x2dc>)
c0d011b2:	4479      	add	r1, pc
c0d011b4:	2204      	movs	r2, #4
c0d011b6:	4638      	mov	r0, r7
c0d011b8:	f7ff fc9b 	bl	c0d00af2 <os_memcmp>
c0d011bc:	2800      	cmp	r0, #0
c0d011be:	d13c      	bne.n	c0d0123a <io_exchange+0x29a>
          tx_len = 0;
          if (os_global_pin_is_validated() == BOLOS_UX_OK) {
c0d011c0:	9806      	ldr	r0, [sp, #24]
c0d011c2:	302a      	adds	r0, #42	; 0x2a
c0d011c4:	b2c7      	uxtb	r7, r0
c0d011c6:	f000 fca7 	bl	c0d01b18 <os_global_pin_is_validated>
c0d011ca:	42b8      	cmp	r0, r7
c0d011cc:	d125      	bne.n	c0d0121a <io_exchange+0x27a>
c0d011ce:	2001      	movs	r0, #1
c0d011d0:	4d23      	ldr	r5, [pc, #140]	; (c0d01260 <io_exchange+0x2c0>)
            unsigned int i;
            // format
            G_io_apdu_buffer[tx_len++] = 0x01;
c0d011d2:	7028      	strb	r0, [r5, #0]

#ifndef HAVE_BOLOS
            i = os_perso_seed_cookie(G_io_apdu_buffer+1+1, MIN(64,sizeof(G_io_apdu_buffer)-1-1-2));
c0d011d4:	1ca8      	adds	r0, r5, #2
c0d011d6:	2140      	movs	r1, #64	; 0x40
c0d011d8:	f000 fc90 	bl	c0d01afc <os_perso_seed_cookie>
#else
            i = os_perso_seed_cookie_os(G_io_apdu_buffer+1+1, MIN(64,sizeof(G_io_apdu_buffer)-1-1-2));
#endif // HAVE_BOLOS

            G_io_apdu_buffer[tx_len++] = i;
c0d011dc:	7068      	strb	r0, [r5, #1]
            tx_len += i;
c0d011de:	1c81      	adds	r1, r0, #2
c0d011e0:	4a1b      	ldr	r2, [pc, #108]	; (c0d01250 <io_exchange+0x2b0>)
c0d011e2:	4613      	mov	r3, r2
            G_io_apdu_buffer[tx_len++] = 0x90;
c0d011e4:	4011      	ands	r1, r2
c0d011e6:	9a06      	ldr	r2, [sp, #24]
c0d011e8:	3210      	adds	r2, #16
c0d011ea:	546a      	strb	r2, [r5, r1]
c0d011ec:	1cc1      	adds	r1, r0, #3
            G_io_apdu_buffer[tx_len++] = 0x00;
c0d011ee:	4019      	ands	r1, r3
c0d011f0:	2200      	movs	r2, #0
c0d011f2:	546a      	strb	r2, [r5, r1]
c0d011f4:	1d01      	adds	r1, r0, #4
c0d011f6:	4615      	mov	r5, r2
c0d011f8:	e016      	b.n	c0d01228 <io_exchange+0x288>
c0d011fa:	2000      	movs	r0, #0
c0d011fc:	e7a7      	b.n	c0d0114e <io_exchange+0x1ae>
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
#ifndef HAVE_BOLOS_NO_DEFAULT_APDU
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
          tx_len = os_io_seproxyhal_get_app_name_and_version();
c0d011fe:	f7ff feab 	bl	c0d00f58 <os_io_seproxyhal_get_app_name_and_version>
c0d01202:	4601      	mov	r1, r0
c0d01204:	2500      	movs	r5, #0
c0d01206:	e00f      	b.n	c0d01228 <io_exchange+0x288>
c0d01208:	2000      	movs	r0, #0
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
          tx_len = 0;
          G_io_apdu_buffer[tx_len++] = 0x90;
          G_io_apdu_buffer[tx_len++] = 0x00;
c0d0120a:	7078      	strb	r0, [r7, #1]
c0d0120c:	9906      	ldr	r1, [sp, #24]
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
          tx_len = 0;
          G_io_apdu_buffer[tx_len++] = 0x90;
c0d0120e:	4608      	mov	r0, r1
c0d01210:	3010      	adds	r0, #16
c0d01212:	7038      	strb	r0, [r7, #0]
c0d01214:	9d07      	ldr	r5, [sp, #28]
          G_io_apdu_buffer[tx_len++] = 0x00;
          // exit app after replied
          channel |= IO_RESET_AFTER_REPLIED;
c0d01216:	430d      	orrs	r5, r1
c0d01218:	e005      	b.n	c0d01226 <io_exchange+0x286>
c0d0121a:	2069      	movs	r0, #105	; 0x69
c0d0121c:	4910      	ldr	r1, [pc, #64]	; (c0d01260 <io_exchange+0x2c0>)
            tx_len += i;
            G_io_apdu_buffer[tx_len++] = 0x90;
            G_io_apdu_buffer[tx_len++] = 0x00;
          }
          else {
            G_io_apdu_buffer[tx_len++] = 0x69;
c0d0121e:	7008      	strb	r0, [r1, #0]
            G_io_apdu_buffer[tx_len++] = 0x85;
c0d01220:	9806      	ldr	r0, [sp, #24]
c0d01222:	1d40      	adds	r0, r0, #5
c0d01224:	7048      	strb	r0, [r1, #1]
c0d01226:	2102      	movs	r1, #2
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d01228:	b2ef      	uxtb	r7, r5
c0d0122a:	9507      	str	r5, [sp, #28]
c0d0122c:	0768      	lsls	r0, r5, #29
c0d0122e:	d100      	bne.n	c0d01232 <io_exchange+0x292>
c0d01230:	e6c9      	b.n	c0d00fc6 <io_exchange+0x26>
c0d01232:	e6bb      	b.n	c0d00fac <io_exchange+0xc>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_app.apdu_length-5;
c0d01234:	8860      	ldrh	r0, [r4, #2]
c0d01236:	1f40      	subs	r0, r0, #5
c0d01238:	e6bd      	b.n	c0d00fb6 <io_exchange+0x16>
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
#endif // BOLOS_OS_UPGRADER
#endif // HAVE_BOLOS_NO_DEFAULT_APDU
        return G_io_app.apdu_length;
c0d0123a:	8860      	ldrh	r0, [r4, #2]
c0d0123c:	e6bb      	b.n	c0d00fb6 <io_exchange+0x16>
c0d0123e:	2010      	movs	r0, #16
c0d01240:	f7ff fc6b 	bl	c0d00b1a <os_longjmp>
c0d01244:	2009      	movs	r0, #9
              goto break_send;
            }
            __attribute__((fallthrough));
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01246:	f7ff fc68 	bl	c0d00b1a <os_longjmp>
c0d0124a:	2002      	movs	r0, #2
c0d0124c:	f7ff fc65 	bl	c0d00b1a <os_longjmp>
c0d01250:	0000ffff 	.word	0x0000ffff
c0d01254:	20001a0c 	.word	0x20001a0c
c0d01258:	20001be0 	.word	0x20001be0
c0d0125c:	20001c08 	.word	0x20001c08
c0d01260:	20001a8e 	.word	0x20001a8e
c0d01264:	0000fffe 	.word	0x0000fffe
c0d01268:	60009abe 	.word	0x60009abe
c0d0126c:	fffffbeb 	.word	0xfffffbeb
c0d01270:	fffffc05 	.word	0xfffffc05
c0d01274:	000038bc 	.word	0x000038bc
c0d01278:	000038af 	.word	0x000038af
c0d0127c:	000038a4 	.word	0x000038a4

c0d01280 <os_io_seph_recv_and_process>:
  default:
    return io_exchange_al(channel, tx_len);
  }
}

unsigned int os_io_seph_recv_and_process(unsigned int dont_process_ux_events) {
c0d01280:	b570      	push	{r4, r5, r6, lr}
c0d01282:	4604      	mov	r4, r0
  // send general status before receiving next event
  if (!io_seproxyhal_spi_is_status_sent()) {
c0d01284:	f000 fc92 	bl	c0d01bac <io_seph_is_status_sent>
c0d01288:	2800      	cmp	r0, #0
c0d0128a:	d101      	bne.n	c0d01290 <os_io_seph_recv_and_process+0x10>
    io_seproxyhal_general_status();
c0d0128c:	f7ff fc4c 	bl	c0d00b28 <io_seproxyhal_general_status>
  }

  io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01290:	4e0c      	ldr	r6, [pc, #48]	; (c0d012c4 <os_io_seph_recv_and_process+0x44>)
c0d01292:	2180      	movs	r1, #128	; 0x80
c0d01294:	2500      	movs	r5, #0
c0d01296:	4630      	mov	r0, r6
c0d01298:	462a      	mov	r2, r5
c0d0129a:	f000 fc93 	bl	c0d01bc4 <io_seph_recv>

  switch (G_io_seproxyhal_spi_buffer[0]) {
c0d0129e:	7830      	ldrb	r0, [r6, #0]
c0d012a0:	2815      	cmp	r0, #21
c0d012a2:	d806      	bhi.n	c0d012b2 <os_io_seph_recv_and_process+0x32>
c0d012a4:	2101      	movs	r1, #1
c0d012a6:	4081      	lsls	r1, r0
c0d012a8:	4807      	ldr	r0, [pc, #28]	; (c0d012c8 <os_io_seph_recv_and_process+0x48>)
c0d012aa:	4201      	tst	r1, r0
c0d012ac:	d001      	beq.n	c0d012b2 <os_io_seph_recv_and_process+0x32>
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
    case SEPROXYHAL_TAG_TICKER_EVENT:
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
    case SEPROXYHAL_TAG_STATUS_EVENT:
      // perform UX event on these ones, don't process as an IO event
      if (dont_process_ux_events) {
c0d012ae:	2c00      	cmp	r4, #0
c0d012b0:	d105      	bne.n	c0d012be <os_io_seph_recv_and_process+0x3e>
      }
      __attribute__((fallthrough));

    default:
      // if malformed, then a stall is likely to occur
      if (io_seproxyhal_handle_event()) {
c0d012b2:	f7ff fd21 	bl	c0d00cf8 <io_seproxyhal_handle_event>
c0d012b6:	2501      	movs	r5, #1
c0d012b8:	2800      	cmp	r0, #0
c0d012ba:	d100      	bne.n	c0d012be <os_io_seph_recv_and_process+0x3e>
c0d012bc:	4605      	mov	r5, r0
        return 1;
      }
  }
  return 0;
}
c0d012be:	4628      	mov	r0, r5
c0d012c0:	bd70      	pop	{r4, r5, r6, pc}
c0d012c2:	46c0      	nop			; (mov r8, r8)
c0d012c4:	20001a0c 	.word	0x20001a0c
c0d012c8:	00207020 	.word	0x00207020

c0d012cc <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_channel;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d012cc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d012ce:	b081      	sub	sp, #4
c0d012d0:	9200      	str	r2, [sp, #0]
c0d012d2:	4604      	mov	r4, r0
  // avoid over/under flows
  if (buffer != G_io_usb_ep_buffer) {
c0d012d4:	4e45      	ldr	r6, [pc, #276]	; (c0d013ec <io_usb_hid_receive+0x120>)
c0d012d6:	42b1      	cmp	r1, r6
c0d012d8:	d010      	beq.n	c0d012fc <io_usb_hid_receive+0x30>
c0d012da:	460f      	mov	r7, r1
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d012dc:	4d43      	ldr	r5, [pc, #268]	; (c0d013ec <io_usb_hid_receive+0x120>)
c0d012de:	2100      	movs	r1, #0
c0d012e0:	2640      	movs	r6, #64	; 0x40
c0d012e2:	4628      	mov	r0, r5
c0d012e4:	4632      	mov	r2, r6
c0d012e6:	f7ff fbfb 	bl	c0d00ae0 <os_memset>
c0d012ea:	9a00      	ldr	r2, [sp, #0]
    os_memmove(G_io_usb_ep_buffer, buffer, MIN(l, sizeof(G_io_usb_ep_buffer)));
c0d012ec:	2a40      	cmp	r2, #64	; 0x40
c0d012ee:	d300      	bcc.n	c0d012f2 <io_usb_hid_receive+0x26>
c0d012f0:	4632      	mov	r2, r6
c0d012f2:	4628      	mov	r0, r5
c0d012f4:	4639      	mov	r1, r7
c0d012f6:	f7ff fbdd 	bl	c0d00ab4 <os_memmove>
c0d012fa:	4e3c      	ldr	r6, [pc, #240]	; (c0d013ec <io_usb_hid_receive+0x120>)
  }

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
c0d012fc:	78b0      	ldrb	r0, [r6, #2]
c0d012fe:	2801      	cmp	r0, #1
c0d01300:	dc0a      	bgt.n	c0d01318 <io_usb_hid_receive+0x4c>
c0d01302:	2800      	cmp	r0, #0
c0d01304:	d025      	beq.n	c0d01352 <io_usb_hid_receive+0x86>
c0d01306:	2801      	cmp	r0, #1
c0d01308:	d160      	bne.n	c0d013cc <io_usb_hid_receive+0x100>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_usb_ep_buffer+3, 4);
c0d0130a:	1cf0      	adds	r0, r6, #3
c0d0130c:	2104      	movs	r1, #4
c0d0130e:	f000 fb69 	bl	c0d019e4 <cx_rng>
c0d01312:	2140      	movs	r1, #64	; 0x40
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01314:	4630      	mov	r0, r6
c0d01316:	e028      	b.n	c0d0136a <io_usb_hid_receive+0x9e>
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
    os_memmove(G_io_usb_ep_buffer, buffer, MIN(l, sizeof(G_io_usb_ep_buffer)));
  }

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
c0d01318:	2802      	cmp	r0, #2
c0d0131a:	d024      	beq.n	c0d01366 <io_usb_hid_receive+0x9a>
c0d0131c:	2805      	cmp	r0, #5
c0d0131e:	d155      	bne.n	c0d013cc <io_usb_hid_receive+0x100>
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if ((unsigned int)U2BE(G_io_usb_ep_buffer, 3) != (unsigned int)G_io_usb_hid_sequence_number) {
c0d01320:	7930      	ldrb	r0, [r6, #4]
c0d01322:	78f1      	ldrb	r1, [r6, #3]
c0d01324:	0209      	lsls	r1, r1, #8
c0d01326:	1808      	adds	r0, r1, r0
c0d01328:	4c31      	ldr	r4, [pc, #196]	; (c0d013f0 <io_usb_hid_receive+0x124>)
c0d0132a:	6821      	ldr	r1, [r4, #0]
c0d0132c:	2700      	movs	r7, #0
c0d0132e:	4288      	cmp	r0, r1
c0d01330:	d152      	bne.n	c0d013d8 <io_usb_hid_receive+0x10c>
    }
    // cid, tag, seq
    l -= 2+1+2;
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d01332:	6820      	ldr	r0, [r4, #0]
c0d01334:	2800      	cmp	r0, #0
c0d01336:	d01b      	beq.n	c0d01370 <io_usb_hid_receive+0xa4>
    if ((unsigned int)U2BE(G_io_usb_ep_buffer, 3) != (unsigned int)G_io_usb_hid_sequence_number) {
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d01338:	9800      	ldr	r0, [sp, #0]
c0d0133a:	1f40      	subs	r0, r0, #5
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d0133c:	b285      	uxth	r5, r0
c0d0133e:	482d      	ldr	r0, [pc, #180]	; (c0d013f4 <io_usb_hid_receive+0x128>)
c0d01340:	6801      	ldr	r1, [r0, #0]
c0d01342:	42a9      	cmp	r1, r5
c0d01344:	d201      	bcs.n	c0d0134a <io_usb_hid_receive+0x7e>
        l = G_io_usb_hid_remaining_length;
c0d01346:	6800      	ldr	r0, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
c0d01348:	b285      	uxth	r5, r0
c0d0134a:	482b      	ldr	r0, [pc, #172]	; (c0d013f8 <io_usb_hid_receive+0x12c>)
c0d0134c:	6800      	ldr	r0, [r0, #0]
c0d0134e:	1d71      	adds	r1, r6, #5
c0d01350:	e02e      	b.n	c0d013b0 <io_usb_hid_receive+0xe4>
    G_io_usb_hid_sequence_number++;
    break;

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_usb_ep_buffer+3, 0, 4); // PROTOCOL VERSION is 0
c0d01352:	1cf0      	adds	r0, r6, #3
c0d01354:	2700      	movs	r7, #0
c0d01356:	2204      	movs	r2, #4
c0d01358:	4639      	mov	r1, r7
c0d0135a:	f7ff fbc1 	bl	c0d00ae0 <os_memset>
c0d0135e:	2140      	movs	r1, #64	; 0x40
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01360:	4630      	mov	r0, r6
c0d01362:	47a0      	blx	r4
c0d01364:	e038      	b.n	c0d013d8 <io_usb_hid_receive+0x10c>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01366:	4821      	ldr	r0, [pc, #132]	; (c0d013ec <io_usb_hid_receive+0x120>)
c0d01368:	2140      	movs	r1, #64	; 0x40
c0d0136a:	47a0      	blx	r4
c0d0136c:	2700      	movs	r7, #0
c0d0136e:	e033      	b.n	c0d013d8 <io_usb_hid_receive+0x10c>
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = U2BE(G_io_usb_ep_buffer, 5); //(G_io_usb_ep_buffer[5]<<8)+(G_io_usb_ep_buffer[6]&0xFF);
c0d01370:	79b0      	ldrb	r0, [r6, #6]
c0d01372:	7971      	ldrb	r1, [r6, #5]
c0d01374:	0209      	lsls	r1, r1, #8
c0d01376:	1809      	adds	r1, r1, r0
c0d01378:	4820      	ldr	r0, [pc, #128]	; (c0d013fc <io_usb_hid_receive+0x130>)
c0d0137a:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d0137c:	6801      	ldr	r1, [r0, #0]
c0d0137e:	0849      	lsrs	r1, r1, #1
c0d01380:	29a8      	cmp	r1, #168	; 0xa8
c0d01382:	d829      	bhi.n	c0d013d8 <io_usb_hid_receive+0x10c>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d01384:	6801      	ldr	r1, [r0, #0]
c0d01386:	481b      	ldr	r0, [pc, #108]	; (c0d013f4 <io_usb_hid_receive+0x128>)
c0d01388:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);
c0d0138a:	7871      	ldrb	r1, [r6, #1]
c0d0138c:	7832      	ldrb	r2, [r6, #0]
c0d0138e:	0212      	lsls	r2, r2, #8
c0d01390:	1851      	adds	r1, r2, r1
c0d01392:	4a1b      	ldr	r2, [pc, #108]	; (c0d01400 <io_usb_hid_receive+0x134>)
c0d01394:	6011      	str	r1, [r2, #0]
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01396:	4918      	ldr	r1, [pc, #96]	; (c0d013f8 <io_usb_hid_receive+0x12c>)
c0d01398:	4a1a      	ldr	r2, [pc, #104]	; (c0d01404 <io_usb_hid_receive+0x138>)
c0d0139a:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d0139c:	9900      	ldr	r1, [sp, #0]
c0d0139e:	1fc9      	subs	r1, r1, #7
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);

      if (l > G_io_usb_hid_remaining_length) {
c0d013a0:	b28d      	uxth	r5, r1
c0d013a2:	6801      	ldr	r1, [r0, #0]
c0d013a4:	42a9      	cmp	r1, r5
c0d013a6:	d201      	bcs.n	c0d013ac <io_usb_hid_receive+0xe0>
        l = G_io_usb_hid_remaining_length;
c0d013a8:	6800      	ldr	r0, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
c0d013aa:	b285      	uxth	r5, r0
c0d013ac:	1df1      	adds	r1, r6, #7
c0d013ae:	4815      	ldr	r0, [pc, #84]	; (c0d01404 <io_usb_hid_receive+0x138>)
c0d013b0:	462a      	mov	r2, r5
c0d013b2:	f7ff fb7f 	bl	c0d00ab4 <os_memmove>
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
    G_io_usb_hid_remaining_length -= l;
c0d013b6:	480f      	ldr	r0, [pc, #60]	; (c0d013f4 <io_usb_hid_receive+0x128>)
c0d013b8:	6801      	ldr	r1, [r0, #0]
c0d013ba:	1b49      	subs	r1, r1, r5
c0d013bc:	6001      	str	r1, [r0, #0]
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d013be:	480e      	ldr	r0, [pc, #56]	; (c0d013f8 <io_usb_hid_receive+0x12c>)
c0d013c0:	6801      	ldr	r1, [r0, #0]
c0d013c2:	1949      	adds	r1, r1, r5
c0d013c4:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
    G_io_usb_hid_sequence_number++;
c0d013c6:	6820      	ldr	r0, [r4, #0]
c0d013c8:	1c40      	adds	r0, r0, #1
c0d013ca:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d013cc:	4809      	ldr	r0, [pc, #36]	; (c0d013f4 <io_usb_hid_receive+0x128>)
c0d013ce:	6801      	ldr	r1, [r0, #0]
c0d013d0:	2001      	movs	r0, #1
c0d013d2:	2702      	movs	r7, #2
c0d013d4:	2900      	cmp	r1, #0
c0d013d6:	d107      	bne.n	c0d013e8 <io_usb_hid_receive+0x11c>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d013d8:	4805      	ldr	r0, [pc, #20]	; (c0d013f0 <io_usb_hid_receive+0x124>)
c0d013da:	2100      	movs	r1, #0
c0d013dc:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
  G_io_usb_hid_current_buffer = NULL;
c0d013de:	4806      	ldr	r0, [pc, #24]	; (c0d013f8 <io_usb_hid_receive+0x12c>)
c0d013e0:	6001      	str	r1, [r0, #0]
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
  G_io_usb_hid_remaining_length = 0;
c0d013e2:	4804      	ldr	r0, [pc, #16]	; (c0d013f4 <io_usb_hid_receive+0x128>)
c0d013e4:	6001      	str	r1, [r0, #0]
c0d013e6:	4638      	mov	r0, r7
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d013e8:	b001      	add	sp, #4
c0d013ea:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d013ec:	20001c4c 	.word	0x20001c4c
c0d013f0:	20001c8c 	.word	0x20001c8c
c0d013f4:	20001c94 	.word	0x20001c94
c0d013f8:	20001c98 	.word	0x20001c98
c0d013fc:	20001c90 	.word	0x20001c90
c0d01400:	20001c9c 	.word	0x20001c9c
c0d01404:	20001a8e 	.word	0x20001a8e

c0d01408 <io_usb_hid_init>:

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01408:	4803      	ldr	r0, [pc, #12]	; (c0d01418 <io_usb_hid_init+0x10>)
c0d0140a:	2100      	movs	r1, #0
c0d0140c:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
  G_io_usb_hid_current_buffer = NULL;
c0d0140e:	4803      	ldr	r0, [pc, #12]	; (c0d0141c <io_usb_hid_init+0x14>)
c0d01410:	6001      	str	r1, [r0, #0]
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
  G_io_usb_hid_remaining_length = 0;
c0d01412:	4803      	ldr	r0, [pc, #12]	; (c0d01420 <io_usb_hid_init+0x18>)
c0d01414:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_current_buffer = NULL;
}
c0d01416:	4770      	bx	lr
c0d01418:	20001c8c 	.word	0x20001c8c
c0d0141c:	20001c98 	.word	0x20001c98
c0d01420:	20001c94 	.word	0x20001c94

c0d01424 <io_usb_hid_sent>:

/**
 * sent the next io_usb_hid transport chunk (rx on the host, tx on the device)
 */
void io_usb_hid_sent(io_send_t sndfct) {
c0d01424:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01426:	b081      	sub	sp, #4
  unsigned int l;

  // only prepare next chunk if some data to be sent remain
  if (G_io_usb_hid_remaining_length && G_io_usb_hid_current_buffer) {
c0d01428:	4f26      	ldr	r7, [pc, #152]	; (c0d014c4 <io_usb_hid_sent+0xa0>)
c0d0142a:	683a      	ldr	r2, [r7, #0]
c0d0142c:	4c26      	ldr	r4, [pc, #152]	; (c0d014c8 <io_usb_hid_sent+0xa4>)
c0d0142e:	6821      	ldr	r1, [r4, #0]
c0d01430:	2900      	cmp	r1, #0
c0d01432:	d021      	beq.n	c0d01478 <io_usb_hid_sent+0x54>
c0d01434:	2a00      	cmp	r2, #0
c0d01436:	d01f      	beq.n	c0d01478 <io_usb_hid_sent+0x54>
c0d01438:	9000      	str	r0, [sp, #0]
    // fill the chunk
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d0143a:	4d26      	ldr	r5, [pc, #152]	; (c0d014d4 <io_usb_hid_sent+0xb0>)
c0d0143c:	2100      	movs	r1, #0
c0d0143e:	2240      	movs	r2, #64	; 0x40
c0d01440:	4628      	mov	r0, r5
c0d01442:	f7ff fb4d 	bl	c0d00ae0 <os_memset>
c0d01446:	2005      	movs	r0, #5

    // keep the channel identifier
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
    G_io_usb_ep_buffer[2] = 0x05;
c0d01448:	70a8      	strb	r0, [r5, #2]
  if (G_io_usb_hid_remaining_length && G_io_usb_hid_current_buffer) {
    // fill the chunk
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));

    // keep the channel identifier
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
c0d0144a:	4823      	ldr	r0, [pc, #140]	; (c0d014d8 <io_usb_hid_sent+0xb4>)
c0d0144c:	6801      	ldr	r1, [r0, #0]
c0d0144e:	0a09      	lsrs	r1, r1, #8
c0d01450:	7029      	strb	r1, [r5, #0]
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
c0d01452:	6800      	ldr	r0, [r0, #0]
c0d01454:	7068      	strb	r0, [r5, #1]
    G_io_usb_ep_buffer[2] = 0x05;
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
c0d01456:	491d      	ldr	r1, [pc, #116]	; (c0d014cc <io_usb_hid_sent+0xa8>)
c0d01458:	6808      	ldr	r0, [r1, #0]
c0d0145a:	0a00      	lsrs	r0, r0, #8
c0d0145c:	70e8      	strb	r0, [r5, #3]
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;
c0d0145e:	6808      	ldr	r0, [r1, #0]
c0d01460:	7128      	strb	r0, [r5, #4]

    if (G_io_usb_hid_sequence_number == 0) {
c0d01462:	6809      	ldr	r1, [r1, #0]
c0d01464:	6820      	ldr	r0, [r4, #0]
c0d01466:	2900      	cmp	r1, #0
c0d01468:	d00e      	beq.n	c0d01488 <io_usb_hid_sent+0x64>
c0d0146a:	263b      	movs	r6, #59	; 0x3b
      os_memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
    }
    else {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : G_io_usb_hid_remaining_length);
c0d0146c:	283b      	cmp	r0, #59	; 0x3b
c0d0146e:	d800      	bhi.n	c0d01472 <io_usb_hid_sent+0x4e>
c0d01470:	6826      	ldr	r6, [r4, #0]
      os_memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d01472:	6839      	ldr	r1, [r7, #0]
c0d01474:	1d68      	adds	r0, r5, #5
c0d01476:	e012      	b.n	c0d0149e <io_usb_hid_sent+0x7a>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01478:	4814      	ldr	r0, [pc, #80]	; (c0d014cc <io_usb_hid_sent+0xa8>)
c0d0147a:	2100      	movs	r1, #0
c0d0147c:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
  G_io_usb_hid_current_buffer = NULL;
c0d0147e:	6039      	str	r1, [r7, #0]
  // cleanup when everything has been sent (ack for the last sent usb in packet)
  else {
    io_usb_hid_init();

    // we sent the whole response
    G_io_app.apdu_state = APDU_IDLE;
c0d01480:	4813      	ldr	r0, [pc, #76]	; (c0d014d0 <io_usb_hid_sent+0xac>)
c0d01482:	7001      	strb	r1, [r0, #0]
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
  G_io_usb_hid_remaining_length = 0;
c0d01484:	6021      	str	r1, [r4, #0]
c0d01486:	e01b      	b.n	c0d014c0 <io_usb_hid_sent+0x9c>
c0d01488:	2639      	movs	r6, #57	; 0x39
    G_io_usb_ep_buffer[2] = 0x05;
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : G_io_usb_hid_remaining_length);
c0d0148a:	2839      	cmp	r0, #57	; 0x39
c0d0148c:	d800      	bhi.n	c0d01490 <io_usb_hid_sent+0x6c>
c0d0148e:	6826      	ldr	r6, [r4, #0]
      G_io_usb_ep_buffer[5] = G_io_usb_hid_remaining_length>>8;
c0d01490:	6820      	ldr	r0, [r4, #0]
c0d01492:	0a00      	lsrs	r0, r0, #8
c0d01494:	7168      	strb	r0, [r5, #5]
      G_io_usb_ep_buffer[6] = G_io_usb_hid_remaining_length;
c0d01496:	6820      	ldr	r0, [r4, #0]
c0d01498:	71a8      	strb	r0, [r5, #6]
      os_memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d0149a:	6839      	ldr	r1, [r7, #0]
c0d0149c:	1de8      	adds	r0, r5, #7
c0d0149e:	4632      	mov	r2, r6
c0d014a0:	f7ff fb08 	bl	c0d00ab4 <os_memmove>
c0d014a4:	9a00      	ldr	r2, [sp, #0]
c0d014a6:	4909      	ldr	r1, [pc, #36]	; (c0d014cc <io_usb_hid_sent+0xa8>)
c0d014a8:	6820      	ldr	r0, [r4, #0]
c0d014aa:	1b80      	subs	r0, r0, r6
c0d014ac:	6020      	str	r0, [r4, #0]
c0d014ae:	6838      	ldr	r0, [r7, #0]
c0d014b0:	1980      	adds	r0, r0, r6
c0d014b2:	6038      	str	r0, [r7, #0]
      os_memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;   
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d014b4:	6808      	ldr	r0, [r1, #0]
c0d014b6:	1c40      	adds	r0, r0, #1
c0d014b8:	6008      	str	r0, [r1, #0]
    // send the chunk
    // always padded (USB HID transport) :)
    sndfct(G_io_usb_ep_buffer, sizeof(G_io_usb_ep_buffer));
c0d014ba:	4806      	ldr	r0, [pc, #24]	; (c0d014d4 <io_usb_hid_sent+0xb0>)
c0d014bc:	2140      	movs	r1, #64	; 0x40
c0d014be:	4790      	blx	r2
    io_usb_hid_init();

    // we sent the whole response
    G_io_app.apdu_state = APDU_IDLE;
  }
}
c0d014c0:	b001      	add	sp, #4
c0d014c2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d014c4:	20001c98 	.word	0x20001c98
c0d014c8:	20001c94 	.word	0x20001c94
c0d014cc:	20001c8c 	.word	0x20001c8c
c0d014d0:	20001be0 	.word	0x20001be0
c0d014d4:	20001c4c 	.word	0x20001c4c
c0d014d8:	20001c9c 	.word	0x20001c9c

c0d014dc <io_usb_hid_send>:

void io_usb_hid_send(io_send_t sndfct, unsigned short sndlength) {
c0d014dc:	b580      	push	{r7, lr}
  // perform send
  if (sndlength) {
c0d014de:	2900      	cmp	r1, #0
c0d014e0:	d00b      	beq.n	c0d014fa <io_usb_hid_send+0x1e>
    G_io_usb_hid_sequence_number = 0; 
c0d014e2:	4a06      	ldr	r2, [pc, #24]	; (c0d014fc <io_usb_hid_send+0x20>)
c0d014e4:	2300      	movs	r3, #0
c0d014e6:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
    G_io_usb_hid_remaining_length = sndlength;
c0d014e8:	4a05      	ldr	r2, [pc, #20]	; (c0d01500 <io_usb_hid_send+0x24>)
c0d014ea:	6011      	str	r1, [r2, #0]

void io_usb_hid_send(io_send_t sndfct, unsigned short sndlength) {
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d014ec:	4a05      	ldr	r2, [pc, #20]	; (c0d01504 <io_usb_hid_send+0x28>)
c0d014ee:	4b06      	ldr	r3, [pc, #24]	; (c0d01508 <io_usb_hid_send+0x2c>)
c0d014f0:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_remaining_length = sndlength;
    G_io_usb_hid_total_length = sndlength;
c0d014f2:	4a06      	ldr	r2, [pc, #24]	; (c0d0150c <io_usb_hid_send+0x30>)
c0d014f4:	6011      	str	r1, [r2, #0]
    io_usb_hid_sent(sndfct);
c0d014f6:	f7ff ff95 	bl	c0d01424 <io_usb_hid_sent>
  }
}
c0d014fa:	bd80      	pop	{r7, pc}
c0d014fc:	20001c8c 	.word	0x20001c8c
c0d01500:	20001c94 	.word	0x20001c94
c0d01504:	20001c98 	.word	0x20001c98
c0d01508:	20001a8e 	.word	0x20001a8e
c0d0150c:	20001c90 	.word	0x20001c90

c0d01510 <snprintf>:
#endif // HAVE_PRINTF

#ifdef HAVE_SPRINTF
//unsigned int snprintf(unsigned char * str, unsigned int str_size, const char* format, ...)
int snprintf(char * str, size_t str_size, const char * format, ...)
 {
c0d01510:	b081      	sub	sp, #4
c0d01512:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01514:	b08e      	sub	sp, #56	; 0x38
c0d01516:	9313      	str	r3, [sp, #76]	; 0x4c
    char cStrlenSet;
    
    //
    // Check the arguments.
    //
    if(format == NULL || str == NULL ||str_size < 2) {
c0d01518:	2902      	cmp	r1, #2
c0d0151a:	d200      	bcs.n	c0d0151e <snprintf+0xe>
c0d0151c:	e1aa      	b.n	c0d01874 <snprintf+0x364>
c0d0151e:	4607      	mov	r7, r0
c0d01520:	2800      	cmp	r0, #0
c0d01522:	d100      	bne.n	c0d01526 <snprintf+0x16>
c0d01524:	e1a6      	b.n	c0d01874 <snprintf+0x364>
c0d01526:	4615      	mov	r5, r2
c0d01528:	2a00      	cmp	r2, #0
c0d0152a:	d100      	bne.n	c0d0152e <snprintf+0x1e>
c0d0152c:	e1a2      	b.n	c0d01874 <snprintf+0x364>
c0d0152e:	460c      	mov	r4, r1
      return 0;
    }

    // ensure terminating string with a \0
    memset(str, 0, str_size);
c0d01530:	4638      	mov	r0, r7
c0d01532:	f003 f809 	bl	c0d04548 <__aeabi_memclr>
c0d01536:	a813      	add	r0, sp, #76	; 0x4c


    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01538:	9009      	str	r0, [sp, #36]	; 0x24

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d0153a:	7829      	ldrb	r1, [r5, #0]
c0d0153c:	2900      	cmp	r1, #0
c0d0153e:	d100      	bne.n	c0d01542 <snprintf+0x32>
c0d01540:	e198      	b.n	c0d01874 <snprintf+0x364>
      return 0;
    }

    // ensure terminating string with a \0
    memset(str, 0, str_size);
    str_size--;
c0d01542:	1e64      	subs	r4, r4, #1
c0d01544:	2600      	movs	r6, #0
c0d01546:	e002      	b.n	c0d0154e <snprintf+0x3e>
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01548:	19a8      	adds	r0, r5, r6
c0d0154a:	7841      	ldrb	r1, [r0, #1]
            ulIdx++)
c0d0154c:	1c76      	adds	r6, r6, #1
c0d0154e:	b2c8      	uxtb	r0, r1
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01550:	2800      	cmp	r0, #0
c0d01552:	d001      	beq.n	c0d01558 <snprintf+0x48>
c0d01554:	2825      	cmp	r0, #37	; 0x25
c0d01556:	d1f7      	bne.n	c0d01548 <snprintf+0x38>
        }

        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
c0d01558:	42a6      	cmp	r6, r4
c0d0155a:	d300      	bcc.n	c0d0155e <snprintf+0x4e>
c0d0155c:	4626      	mov	r6, r4
        memmove(str, format, ulIdx);
c0d0155e:	4638      	mov	r0, r7
c0d01560:	4629      	mov	r1, r5
c0d01562:	4632      	mov	r2, r6
c0d01564:	f002 fff6 	bl	c0d04554 <__aeabi_memmove>
        str+= ulIdx;
        str_size -= ulIdx;
c0d01568:	1ba4      	subs	r4, r4, r6
        //
        // Write this portion of the string.
        //
        ulIdx = MIN(ulIdx, str_size);
        memmove(str, format, ulIdx);
        str+= ulIdx;
c0d0156a:	19bf      	adds	r7, r7, r6
        str_size -= ulIdx;
        if (str_size == 0) {
c0d0156c:	2c00      	cmp	r4, #0
c0d0156e:	d100      	bne.n	c0d01572 <snprintf+0x62>
c0d01570:	e180      	b.n	c0d01874 <snprintf+0x364>
        format += ulIdx;

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01572:	5da9      	ldrb	r1, [r5, r6]
        }

        //
        // Skip the portion of the string that was written.
        //
        format += ulIdx;
c0d01574:	19ad      	adds	r5, r5, r6

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01576:	2925      	cmp	r1, #37	; 0x25
c0d01578:	d000      	beq.n	c0d0157c <snprintf+0x6c>
c0d0157a:	e114      	b.n	c0d017a6 <snprintf+0x296>
c0d0157c:	9406      	str	r4, [sp, #24]
c0d0157e:	9704      	str	r7, [sp, #16]
        {
            //
            // Skip the %.
            //
            format++;
c0d01580:	1c6b      	adds	r3, r5, #1
c0d01582:	2400      	movs	r4, #0
c0d01584:	2020      	movs	r0, #32
c0d01586:	210a      	movs	r1, #10
c0d01588:	9108      	str	r1, [sp, #32]
c0d0158a:	4627      	mov	r7, r4
c0d0158c:	9405      	str	r4, [sp, #20]
c0d0158e:	9407      	str	r4, [sp, #28]
c0d01590:	e003      	b.n	c0d0159a <snprintf+0x8a>
c0d01592:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01594:	1d0a      	adds	r2, r1, #4
c0d01596:	9209      	str	r2, [sp, #36]	; 0x24
c0d01598:	680f      	ldr	r7, [r1, #0]
c0d0159a:	461d      	mov	r5, r3
c0d0159c:	4622      	mov	r2, r4
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d0159e:	7829      	ldrb	r1, [r5, #0]
c0d015a0:	1c6d      	adds	r5, r5, #1
c0d015a2:	2400      	movs	r4, #0
c0d015a4:	292d      	cmp	r1, #45	; 0x2d
c0d015a6:	d0f9      	beq.n	c0d0159c <snprintf+0x8c>
c0d015a8:	2947      	cmp	r1, #71	; 0x47
c0d015aa:	dc18      	bgt.n	c0d015de <snprintf+0xce>
c0d015ac:	292f      	cmp	r1, #47	; 0x2f
c0d015ae:	9c06      	ldr	r4, [sp, #24]
c0d015b0:	dd28      	ble.n	c0d01604 <snprintf+0xf4>
c0d015b2:	460b      	mov	r3, r1
c0d015b4:	3b30      	subs	r3, #48	; 0x30
c0d015b6:	2b0a      	cmp	r3, #10
c0d015b8:	d26e      	bcs.n	c0d01698 <snprintf+0x188>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d015ba:	2930      	cmp	r1, #48	; 0x30
c0d015bc:	4604      	mov	r4, r0
c0d015be:	d100      	bne.n	c0d015c2 <snprintf+0xb2>
c0d015c0:	460c      	mov	r4, r1
c0d015c2:	9b07      	ldr	r3, [sp, #28]
c0d015c4:	2b00      	cmp	r3, #0
c0d015c6:	d000      	beq.n	c0d015ca <snprintf+0xba>
c0d015c8:	4604      	mov	r4, r0
c0d015ca:	230a      	movs	r3, #10
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d015cc:	9807      	ldr	r0, [sp, #28]
c0d015ce:	4343      	muls	r3, r0
                    ulCount += format[-1] - '0';
c0d015d0:	1858      	adds	r0, r3, r1
c0d015d2:	3830      	subs	r0, #48	; 0x30
c0d015d4:	9007      	str	r0, [sp, #28]
c0d015d6:	462b      	mov	r3, r5
c0d015d8:	4620      	mov	r0, r4
c0d015da:	4614      	mov	r4, r2
c0d015dc:	e7dd      	b.n	c0d0159a <snprintf+0x8a>
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d015de:	2967      	cmp	r1, #103	; 0x67
c0d015e0:	9c06      	ldr	r4, [sp, #24]
c0d015e2:	dc08      	bgt.n	c0d015f6 <snprintf+0xe6>
c0d015e4:	2962      	cmp	r1, #98	; 0x62
c0d015e6:	dc3e      	bgt.n	c0d01666 <snprintf+0x156>
c0d015e8:	2948      	cmp	r1, #72	; 0x48
c0d015ea:	d14c      	bne.n	c0d01686 <snprintf+0x176>
c0d015ec:	4601      	mov	r1, r0
c0d015ee:	2001      	movs	r0, #1
c0d015f0:	9005      	str	r0, [sp, #20]
c0d015f2:	4608      	mov	r0, r1
c0d015f4:	e003      	b.n	c0d015fe <snprintf+0xee>
c0d015f6:	2972      	cmp	r1, #114	; 0x72
c0d015f8:	dc1a      	bgt.n	c0d01630 <snprintf+0x120>
c0d015fa:	2968      	cmp	r1, #104	; 0x68
c0d015fc:	d14a      	bne.n	c0d01694 <snprintf+0x184>
c0d015fe:	2110      	movs	r1, #16
c0d01600:	9108      	str	r1, [sp, #32]
c0d01602:	e017      	b.n	c0d01634 <snprintf+0x124>
c0d01604:	2925      	cmp	r1, #37	; 0x25
c0d01606:	d100      	bne.n	c0d0160a <snprintf+0xfa>
c0d01608:	e0c0      	b.n	c0d0178c <snprintf+0x27c>
c0d0160a:	292a      	cmp	r1, #42	; 0x2a
c0d0160c:	d023      	beq.n	c0d01656 <snprintf+0x146>
c0d0160e:	292e      	cmp	r1, #46	; 0x2e
c0d01610:	d142      	bne.n	c0d01698 <snprintf+0x188>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'/'h'/'H'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01612:	7829      	ldrb	r1, [r5, #0]
c0d01614:	292a      	cmp	r1, #42	; 0x2a
c0d01616:	d000      	beq.n	c0d0161a <snprintf+0x10a>
c0d01618:	e12a      	b.n	c0d01870 <snprintf+0x360>
c0d0161a:	786a      	ldrb	r2, [r5, #1]
c0d0161c:	1c6b      	adds	r3, r5, #1
c0d0161e:	2401      	movs	r4, #1
c0d01620:	212a      	movs	r1, #42	; 0x2a
c0d01622:	2a48      	cmp	r2, #72	; 0x48
c0d01624:	d0b5      	beq.n	c0d01592 <snprintf+0x82>
c0d01626:	2a68      	cmp	r2, #104	; 0x68
c0d01628:	d0b3      	beq.n	c0d01592 <snprintf+0x82>
c0d0162a:	2a73      	cmp	r2, #115	; 0x73
c0d0162c:	d0b1      	beq.n	c0d01592 <snprintf+0x82>
c0d0162e:	e017      	b.n	c0d01660 <snprintf+0x150>
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01630:	2973      	cmp	r1, #115	; 0x73
c0d01632:	d133      	bne.n	c0d0169c <snprintf+0x18c>
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01634:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d01636:	1d0b      	adds	r3, r1, #4
c0d01638:	9309      	str	r3, [sp, #36]	; 0x24
c0d0163a:	2303      	movs	r3, #3
c0d0163c:	4013      	ands	r3, r2
c0d0163e:	6809      	ldr	r1, [r1, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01640:	2b01      	cmp	r3, #1
c0d01642:	d100      	bne.n	c0d01646 <snprintf+0x136>
c0d01644:	e0b2      	b.n	c0d017ac <snprintf+0x29c>
c0d01646:	2b02      	cmp	r3, #2
c0d01648:	d100      	bne.n	c0d0164c <snprintf+0x13c>
c0d0164a:	e0b2      	b.n	c0d017b2 <snprintf+0x2a2>
c0d0164c:	2b03      	cmp	r3, #3
c0d0164e:	462b      	mov	r3, r5
c0d01650:	4614      	mov	r4, r2
c0d01652:	d0a2      	beq.n	c0d0159a <snprintf+0x8a>
c0d01654:	e0b3      	b.n	c0d017be <snprintf+0x2ae>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01656:	7829      	ldrb	r1, [r5, #0]
c0d01658:	2402      	movs	r4, #2
c0d0165a:	2973      	cmp	r1, #115	; 0x73
c0d0165c:	462b      	mov	r3, r5
c0d0165e:	d098      	beq.n	c0d01592 <snprintf+0x82>
c0d01660:	9f04      	ldr	r7, [sp, #16]
c0d01662:	9c06      	ldr	r4, [sp, #24]
c0d01664:	e09f      	b.n	c0d017a6 <snprintf+0x296>
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01666:	2963      	cmp	r1, #99	; 0x63
c0d01668:	d100      	bne.n	c0d0166c <snprintf+0x15c>
c0d0166a:	e091      	b.n	c0d01790 <snprintf+0x280>
c0d0166c:	2964      	cmp	r1, #100	; 0x64
c0d0166e:	d113      	bne.n	c0d01698 <snprintf+0x188>
c0d01670:	9002      	str	r0, [sp, #8]
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01672:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d01674:	1d01      	adds	r1, r0, #4
c0d01676:	9109      	str	r1, [sp, #36]	; 0x24
c0d01678:	6800      	ldr	r0, [r0, #0]
c0d0167a:	17c1      	asrs	r1, r0, #31
c0d0167c:	1842      	adds	r2, r0, r1
c0d0167e:	404a      	eors	r2, r1

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01680:	0fc0      	lsrs	r0, r0, #31
c0d01682:	270a      	movs	r7, #10
c0d01684:	e013      	b.n	c0d016ae <snprintf+0x19e>
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01686:	2958      	cmp	r1, #88	; 0x58
c0d01688:	d106      	bne.n	c0d01698 <snprintf+0x188>
c0d0168a:	4601      	mov	r1, r0
c0d0168c:	2001      	movs	r0, #1
c0d0168e:	9005      	str	r0, [sp, #20]
c0d01690:	4608      	mov	r0, r1
c0d01692:	e005      	b.n	c0d016a0 <snprintf+0x190>
c0d01694:	2970      	cmp	r1, #112	; 0x70
c0d01696:	d003      	beq.n	c0d016a0 <snprintf+0x190>
c0d01698:	9f04      	ldr	r7, [sp, #16]
c0d0169a:	e083      	b.n	c0d017a4 <snprintf+0x294>
c0d0169c:	2978      	cmp	r1, #120	; 0x78
c0d0169e:	d1fb      	bne.n	c0d01698 <snprintf+0x188>
c0d016a0:	9002      	str	r0, [sp, #8]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d016a2:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d016a4:	1d01      	adds	r1, r0, #4
c0d016a6:	9109      	str	r1, [sp, #36]	; 0x24
c0d016a8:	6802      	ldr	r2, [r0, #0]
c0d016aa:	2000      	movs	r0, #0
c0d016ac:	2710      	movs	r7, #16
c0d016ae:	2401      	movs	r4, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d016b0:	4297      	cmp	r7, r2
c0d016b2:	9208      	str	r2, [sp, #32]
c0d016b4:	9003      	str	r0, [sp, #12]
c0d016b6:	d812      	bhi.n	c0d016de <snprintf+0x1ce>
c0d016b8:	2601      	movs	r6, #1
c0d016ba:	4638      	mov	r0, r7
c0d016bc:	4604      	mov	r4, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d016be:	4639      	mov	r1, r7
c0d016c0:	f002 feb6 	bl	c0d04430 <__aeabi_uidiv>
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d016c4:	42b0      	cmp	r0, r6
c0d016c6:	d109      	bne.n	c0d016dc <snprintf+0x1cc>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d016c8:	4638      	mov	r0, r7
c0d016ca:	4360      	muls	r0, r4
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d016cc:	9907      	ldr	r1, [sp, #28]
c0d016ce:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d016d0:	9107      	str	r1, [sp, #28]
c0d016d2:	9908      	ldr	r1, [sp, #32]
c0d016d4:	4288      	cmp	r0, r1
c0d016d6:	4626      	mov	r6, r4
c0d016d8:	d9f0      	bls.n	c0d016bc <snprintf+0x1ac>
c0d016da:	e000      	b.n	c0d016de <snprintf+0x1ce>
c0d016dc:	4634      	mov	r4, r6
c0d016de:	9807      	ldr	r0, [sp, #28]

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d016e0:	1e41      	subs	r1, r0, #1
c0d016e2:	9b03      	ldr	r3, [sp, #12]
c0d016e4:	2b00      	cmp	r3, #0
c0d016e6:	d100      	bne.n	c0d016ea <snprintf+0x1da>
c0d016e8:	4601      	mov	r1, r0
c0d016ea:	2600      	movs	r6, #0
c0d016ec:	43f0      	mvns	r0, r6
c0d016ee:	2b00      	cmp	r3, #0
c0d016f0:	d100      	bne.n	c0d016f4 <snprintf+0x1e4>
c0d016f2:	4618      	mov	r0, r3
c0d016f4:	9001      	str	r0, [sp, #4]

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d016f6:	9802      	ldr	r0, [sp, #8]
c0d016f8:	b2c2      	uxtb	r2, r0
c0d016fa:	2a30      	cmp	r2, #48	; 0x30
c0d016fc:	d106      	bne.n	c0d0170c <snprintf+0x1fc>
c0d016fe:	2b00      	cmp	r3, #0
c0d01700:	d004      	beq.n	c0d0170c <snprintf+0x1fc>
c0d01702:	a80a      	add	r0, sp, #40	; 0x28
c0d01704:	232d      	movs	r3, #45	; 0x2d
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01706:	7003      	strb	r3, [r0, #0]
c0d01708:	2300      	movs	r3, #0
c0d0170a:	2601      	movs	r6, #1

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d0170c:	1e88      	subs	r0, r1, #2
c0d0170e:	280d      	cmp	r0, #13
c0d01710:	d80b      	bhi.n	c0d0172a <snprintf+0x21a>
c0d01712:	a80a      	add	r0, sp, #40	; 0x28
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d01714:	1980      	adds	r0, r0, r6
c0d01716:	1e49      	subs	r1, r1, #1
c0d01718:	9303      	str	r3, [sp, #12]
c0d0171a:	f002 ff1f 	bl	c0d0455c <__aeabi_memset>
c0d0171e:	9b03      	ldr	r3, [sp, #12]
c0d01720:	9807      	ldr	r0, [sp, #28]
c0d01722:	1980      	adds	r0, r0, r6
c0d01724:	9901      	ldr	r1, [sp, #4]
c0d01726:	1840      	adds	r0, r0, r1
c0d01728:	1e46      	subs	r6, r0, #1
c0d0172a:	9a05      	ldr	r2, [sp, #20]

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d0172c:	2b00      	cmp	r3, #0
c0d0172e:	d003      	beq.n	c0d01738 <snprintf+0x228>
c0d01730:	a80a      	add	r0, sp, #40	; 0x28
c0d01732:	212d      	movs	r1, #45	; 0x2d
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d01734:	5581      	strb	r1, [r0, r6]
c0d01736:	1c76      	adds	r6, r6, #1
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01738:	2c00      	cmp	r4, #0
c0d0173a:	d01a      	beq.n	c0d01772 <snprintf+0x262>
c0d0173c:	2a00      	cmp	r2, #0
c0d0173e:	d002      	beq.n	c0d01746 <snprintf+0x236>
c0d01740:	4852      	ldr	r0, [pc, #328]	; (c0d0188c <snprintf+0x37c>)
c0d01742:	4478      	add	r0, pc
c0d01744:	e001      	b.n	c0d0174a <snprintf+0x23a>
c0d01746:	4850      	ldr	r0, [pc, #320]	; (c0d01888 <snprintf+0x378>)
c0d01748:	4478      	add	r0, pc
c0d0174a:	9007      	str	r0, [sp, #28]
c0d0174c:	9808      	ldr	r0, [sp, #32]
c0d0174e:	4621      	mov	r1, r4
c0d01750:	f002 fe6e 	bl	c0d04430 <__aeabi_uidiv>
c0d01754:	4639      	mov	r1, r7
c0d01756:	f002 fef1 	bl	c0d0453c <__aeabi_uidivmod>
c0d0175a:	9807      	ldr	r0, [sp, #28]
c0d0175c:	5c40      	ldrb	r0, [r0, r1]
c0d0175e:	a90a      	add	r1, sp, #40	; 0x28
                    {
                        if (!ulCap) {
                          pcBuf[ulPos++] = g_pcHex[(ulValue / ulIdx) % ulBase];
c0d01760:	5588      	strb	r0, [r1, r6]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d01762:	4620      	mov	r0, r4
c0d01764:	4639      	mov	r1, r7
c0d01766:	f002 fe63 	bl	c0d04430 <__aeabi_uidiv>
c0d0176a:	1c76      	adds	r6, r6, #1
c0d0176c:	42a7      	cmp	r7, r4
c0d0176e:	4604      	mov	r4, r0
c0d01770:	d9ec      	bls.n	c0d0174c <snprintf+0x23c>
c0d01772:	9c06      	ldr	r4, [sp, #24]
                    }

                    //
                    // Write the string.
                    //
                    ulPos = MIN(ulPos, str_size);
c0d01774:	42a6      	cmp	r6, r4
c0d01776:	d300      	bcc.n	c0d0177a <snprintf+0x26a>
c0d01778:	4626      	mov	r6, r4
c0d0177a:	a90a      	add	r1, sp, #40	; 0x28
c0d0177c:	9f04      	ldr	r7, [sp, #16]
                    memmove(str, pcBuf, ulPos);
c0d0177e:	4638      	mov	r0, r7
c0d01780:	4632      	mov	r2, r6
c0d01782:	f002 fee7 	bl	c0d04554 <__aeabi_memmove>
c0d01786:	1ba4      	subs	r4, r4, r6
c0d01788:	19bf      	adds	r7, r7, r6
c0d0178a:	e009      	b.n	c0d017a0 <snprintf+0x290>
c0d0178c:	2025      	movs	r0, #37	; 0x25
c0d0178e:	e003      	b.n	c0d01798 <snprintf+0x288>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01790:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d01792:	1d01      	adds	r1, r0, #4
c0d01794:	9109      	str	r1, [sp, #36]	; 0x24
c0d01796:	6800      	ldr	r0, [r0, #0]
c0d01798:	9f04      	ldr	r7, [sp, #16]
c0d0179a:	7038      	strb	r0, [r7, #0]
c0d0179c:	1e64      	subs	r4, r4, #1
c0d0179e:	1c7f      	adds	r7, r7, #1
c0d017a0:	2c00      	cmp	r4, #0
c0d017a2:	d067      	beq.n	c0d01874 <snprintf+0x364>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d017a4:	7829      	ldrb	r1, [r5, #0]
c0d017a6:	2900      	cmp	r1, #0
c0d017a8:	d064      	beq.n	c0d01874 <snprintf+0x364>
c0d017aa:	e6cb      	b.n	c0d01544 <snprintf+0x34>
c0d017ac:	463e      	mov	r6, r7
c0d017ae:	9f04      	ldr	r7, [sp, #16]
c0d017b0:	e00d      	b.n	c0d017ce <snprintf+0x2be>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d017b2:	7808      	ldrb	r0, [r1, #0]
c0d017b4:	2800      	cmp	r0, #0
c0d017b6:	d03f      	beq.n	c0d01838 <snprintf+0x328>
c0d017b8:	9f04      	ldr	r7, [sp, #16]
c0d017ba:	9c06      	ldr	r4, [sp, #24]
c0d017bc:	e7f2      	b.n	c0d017a4 <snprintf+0x294>
c0d017be:	2200      	movs	r2, #0
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d017c0:	5c8b      	ldrb	r3, [r1, r2]
c0d017c2:	1c52      	adds	r2, r2, #1
c0d017c4:	2b00      	cmp	r3, #0
c0d017c6:	d1fb      	bne.n	c0d017c0 <snprintf+0x2b0>
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d017c8:	1e56      	subs	r6, r2, #1
c0d017ca:	9f04      	ldr	r7, [sp, #16]
c0d017cc:	9c06      	ldr	r4, [sp, #24]
c0d017ce:	9808      	ldr	r0, [sp, #32]
c0d017d0:	2810      	cmp	r0, #16
c0d017d2:	d127      	bne.n	c0d01824 <snprintf+0x314>
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d017d4:	2e00      	cmp	r6, #0
c0d017d6:	d0e5      	beq.n	c0d017a4 <snprintf+0x294>
c0d017d8:	9108      	str	r1, [sp, #32]
c0d017da:	2000      	movs	r0, #0
c0d017dc:	4623      	mov	r3, r4
c0d017de:	4601      	mov	r1, r0
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d017e0:	9a08      	ldr	r2, [sp, #32]
c0d017e2:	5c12      	ldrb	r2, [r2, r0]
c0d017e4:	200f      	movs	r0, #15
                          nibble2 = pcStr[ulCount]&0xF;
c0d017e6:	4010      	ands	r0, r2
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d017e8:	0912      	lsrs	r2, r2, #4
                          nibble2 = pcStr[ulCount]&0xF;
                          if (str_size < 2) {
c0d017ea:	2b02      	cmp	r3, #2
c0d017ec:	d342      	bcc.n	c0d01874 <snprintf+0x364>
c0d017ee:	461c      	mov	r4, r3
c0d017f0:	9b05      	ldr	r3, [sp, #20]
                              return 0;
                          }
                          switch(ulCap) {
c0d017f2:	2b00      	cmp	r3, #0
c0d017f4:	d004      	beq.n	c0d01800 <snprintf+0x2f0>
c0d017f6:	2b01      	cmp	r3, #1
c0d017f8:	d108      	bne.n	c0d0180c <snprintf+0x2fc>
c0d017fa:	4b22      	ldr	r3, [pc, #136]	; (c0d01884 <snprintf+0x374>)
c0d017fc:	447b      	add	r3, pc
c0d017fe:	e001      	b.n	c0d01804 <snprintf+0x2f4>
c0d01800:	4b1f      	ldr	r3, [pc, #124]	; (c0d01880 <snprintf+0x370>)
c0d01802:	447b      	add	r3, pc
c0d01804:	5c18      	ldrb	r0, [r3, r0]
c0d01806:	7078      	strb	r0, [r7, #1]
c0d01808:	5c98      	ldrb	r0, [r3, r2]
c0d0180a:	7038      	strb	r0, [r7, #0]
c0d0180c:	4620      	mov	r0, r4
                                str[0] = g_pcHex_cap[nibble1];
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
                          str_size -= 2;
c0d0180e:	1ea4      	subs	r4, r4, #2
                          if (str_size == 0) {
c0d01810:	2802      	cmp	r0, #2
c0d01812:	d02f      	beq.n	c0d01874 <snprintf+0x364>
c0d01814:	4608      	mov	r0, r1
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01816:	1c48      	adds	r0, r1, #1
                            case 1:
                                str[0] = g_pcHex_cap[nibble1];
                                str[1] = g_pcHex_cap[nibble2];
                              break;
                          }
                          str+= 2;
c0d01818:	1cbf      	adds	r7, r7, #2
                            return 0;
                        }
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d0181a:	42b0      	cmp	r0, r6
c0d0181c:	4623      	mov	r3, r4
c0d0181e:	d3de      	bcc.n	c0d017de <snprintf+0x2ce>
c0d01820:	9007      	str	r0, [sp, #28]
c0d01822:	e018      	b.n	c0d01856 <snprintf+0x346>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
c0d01824:	42a6      	cmp	r6, r4
c0d01826:	d300      	bcc.n	c0d0182a <snprintf+0x31a>
c0d01828:	4626      	mov	r6, r4
                        memmove(str, pcStr, ulIdx);
c0d0182a:	4638      	mov	r0, r7
c0d0182c:	4632      	mov	r2, r6
c0d0182e:	f002 fe91 	bl	c0d04554 <__aeabi_memmove>
                        str+= ulIdx;
                        str_size -= ulIdx;
c0d01832:	1ba4      	subs	r4, r4, r6
                    //
                    switch(ulBase) {
                      default:
                        ulIdx = MIN(ulIdx, str_size);
                        memmove(str, pcStr, ulIdx);
                        str+= ulIdx;
c0d01834:	19bf      	adds	r7, r7, r6
c0d01836:	e00c      	b.n	c0d01852 <snprintf+0x342>
c0d01838:	9c06      	ldr	r4, [sp, #24]
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
c0d0183a:	42a7      	cmp	r7, r4
c0d0183c:	d300      	bcc.n	c0d01840 <snprintf+0x330>
c0d0183e:	4627      	mov	r7, r4
c0d01840:	2220      	movs	r2, #32
                          memset(str, ' ', ulStrlen);
c0d01842:	9804      	ldr	r0, [sp, #16]
c0d01844:	4639      	mov	r1, r7
c0d01846:	f002 fe89 	bl	c0d0455c <__aeabi_memset>
                          str+= ulStrlen;
                          str_size -= ulStrlen;
c0d0184a:	1be4      	subs	r4, r4, r7
c0d0184c:	9804      	ldr	r0, [sp, #16]
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          ulStrlen = MIN(ulStrlen, str_size);
                          memset(str, ' ', ulStrlen);
                          str+= ulStrlen;
c0d0184e:	19c0      	adds	r0, r0, r7
c0d01850:	4607      	mov	r7, r0
c0d01852:	2c00      	cmp	r4, #0
c0d01854:	d00e      	beq.n	c0d01874 <snprintf+0x364>
c0d01856:	9807      	ldr	r0, [sp, #28]

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01858:	42b0      	cmp	r0, r6
c0d0185a:	d9a3      	bls.n	c0d017a4 <snprintf+0x294>
                    {
                        ulCount -= ulIdx;
c0d0185c:	1b86      	subs	r6, r0, r6
                        ulCount = MIN(ulCount, str_size);
c0d0185e:	42a6      	cmp	r6, r4
c0d01860:	d300      	bcc.n	c0d01864 <snprintf+0x354>
c0d01862:	4626      	mov	r6, r4
c0d01864:	2220      	movs	r2, #32
                        memset(str, ' ', ulCount);
c0d01866:	4638      	mov	r0, r7
c0d01868:	4631      	mov	r1, r6
c0d0186a:	f002 fe77 	bl	c0d0455c <__aeabi_memset>
c0d0186e:	e78a      	b.n	c0d01786 <snprintf+0x276>
c0d01870:	9f04      	ldr	r7, [sp, #16]
c0d01872:	e798      	b.n	c0d017a6 <snprintf+0x296>
c0d01874:	2000      	movs	r0, #0
    // End the varargs processing.
    //
    va_end(vaArgP);

    return 0;
}
c0d01876:	b00e      	add	sp, #56	; 0x38
c0d01878:	bcf0      	pop	{r4, r5, r6, r7}
c0d0187a:	bc02      	pop	{r1}
c0d0187c:	b001      	add	sp, #4
c0d0187e:	4708      	bx	r1
c0d01880:	00003259 	.word	0x00003259
c0d01884:	0000326f 	.word	0x0000326f
c0d01888:	00003313 	.word	0x00003313
c0d0188c:	00003329 	.word	0x00003329

c0d01890 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d01890:	b580      	push	{r7, lr}
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01892:	4904      	ldr	r1, [pc, #16]	; (c0d018a4 <pic+0x14>)
c0d01894:	4288      	cmp	r0, r1
c0d01896:	d304      	bcc.n	c0d018a2 <pic+0x12>
c0d01898:	4903      	ldr	r1, [pc, #12]	; (c0d018a8 <pic+0x18>)
c0d0189a:	4288      	cmp	r0, r1
c0d0189c:	d201      	bcs.n	c0d018a2 <pic+0x12>
		link_address = pic_internal(link_address);
c0d0189e:	f000 f805 	bl	c0d018ac <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d018a2:	bd80      	pop	{r7, pc}
c0d018a4:	c0d00000 	.word	0xc0d00000
c0d018a8:	c0d05280 	.word	0xc0d05280

c0d018ac <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d018ac:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d018ae:	4902      	ldr	r1, [pc, #8]	; (c0d018b8 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d018b0:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d018b2:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d018b4:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d018b6:	4770      	bx	lr
c0d018b8:	c0d018ad 	.word	0xc0d018ad

c0d018bc <ux_display_sign_flow_2_step_validateinit>:
    bnnn_paging,
    {
      .title = "Signature",
      .text = "Signing Transaction...",
    });
UX_STEP_VALID(
c0d018bc:	b510      	push	{r4, lr}

static uint8_t set_signed_tx() {
    uint8_t tx = 0;

    //Set the size of response message
    G_io_apdu_buffer[tx++] = sizeOfSignature;
c0d018be:	4c07      	ldr	r4, [pc, #28]	; (c0d018dc <ux_display_sign_flow_2_step_validateinit+0x20>)
c0d018c0:	7822      	ldrb	r2, [r4, #0]
c0d018c2:	4807      	ldr	r0, [pc, #28]	; (c0d018e0 <ux_display_sign_flow_2_step_validateinit+0x24>)
c0d018c4:	7002      	strb	r2, [r0, #0]

    //Copy signature data into output buffer.
    os_memmove(G_io_apdu_buffer + tx, signature, sizeOfSignature);
c0d018c6:	1c40      	adds	r0, r0, #1
c0d018c8:	4906      	ldr	r1, [pc, #24]	; (c0d018e4 <ux_display_sign_flow_2_step_validateinit+0x28>)
c0d018ca:	f7ff f8f3 	bl	c0d00ab4 <os_memmove>

    //Set current index of output buffer.
    tx += sizeOfSignature;
c0d018ce:	7820      	ldrb	r0, [r4, #0]
c0d018d0:	1c40      	adds	r0, r0, #1
    bnnn_paging,
    {
      .title = "Signature",
      .text = "Signing Transaction...",
    });
UX_STEP_VALID(
c0d018d2:	b2c0      	uxtb	r0, r0
c0d018d4:	2101      	movs	r1, #1
c0d018d6:	f001 ff45 	bl	c0d03764 <sendResponse>
c0d018da:	bd10      	pop	{r4, pc}
c0d018dc:	20001d12 	.word	0x20001d12
c0d018e0:	20001a8e 	.word	0x20001a8e
c0d018e4:	20001ca0 	.word	0x20001ca0

c0d018e8 <ux_display_sign_flow_3_step_validateinit>:
    sendResponse(set_signed_tx(), true),
    {
      &C_icon_validate_14,
      "Approve",
    });
UX_STEP_VALID(
c0d018e8:	b580      	push	{r7, lr}
c0d018ea:	2000      	movs	r0, #0
c0d018ec:	4601      	mov	r1, r0
c0d018ee:	f001 ff39 	bl	c0d03764 <sendResponse>
c0d018f2:	bd80      	pop	{r7, pc}

c0d018f4 <parseSignRawTxData>:
);

////////// HANDLE SIGN RAW TRANSACTION REQUEST //////////

void parseSignRawTxData(struct apduMessage *apdu)
{
c0d018f4:	b510      	push	{r4, lr}
c0d018f6:	4604      	mov	r4, r0
    //Parse Account NUMBER
    signCtx.accountNumber = readUint32BE(&apdu->cData[ACCT_NUM_OFFSET]);
c0d018f8:	6880      	ldr	r0, [r0, #8]
c0d018fa:	f001 ff27 	bl	c0d0374c <readUint32BE>
c0d018fe:	4905      	ldr	r1, [pc, #20]	; (c0d01914 <parseSignRawTxData+0x20>)
c0d01900:	6008      	str	r0, [r1, #0]

    //Parse Raw Tx - This should be the SHA512 hash of the raw transaction created from RPC services (OL Blockchain).
    signCtx.rawTxLen = apdu->lc - 4;
c0d01902:	88a0      	ldrh	r0, [r4, #4]
c0d01904:	1f00      	subs	r0, r0, #4
c0d01906:	4904      	ldr	r1, [pc, #16]	; (c0d01918 <parseSignRawTxData+0x24>)
c0d01908:	8008      	strh	r0, [r1, #0]
    signCtx.rawTx = &apdu->cData[RAW_TX_OFFSET];
c0d0190a:	68a0      	ldr	r0, [r4, #8]
c0d0190c:	1d00      	adds	r0, r0, #4
c0d0190e:	4903      	ldr	r1, [pc, #12]	; (c0d0191c <parseSignRawTxData+0x28>)
c0d01910:	6008      	str	r0, [r1, #0]

}
c0d01912:	bd10      	pop	{r4, pc}
c0d01914:	20001d1c 	.word	0x20001d1c
c0d01918:	20001d18 	.word	0x20001d18
c0d0191c:	20001d14 	.word	0x20001d14

c0d01920 <handleSignRawTx>:

void handleSignRawTx(struct apduMessage *apdu, volatile unsigned int *flags, volatile unsigned int *tx)
{
c0d01920:	b570      	push	{r4, r5, r6, lr}
c0d01922:	b092      	sub	sp, #72	; 0x48
c0d01924:	460c      	mov	r4, r1
c0d01926:	2500      	movs	r5, #0
    unsigned int info = 0;
c0d01928:	9511      	str	r5, [sp, #68]	; 0x44
    cx_ecfp_private_key_t privateKey;
    size_t mpi_size = sizeof(signature);

    //Get private key using CX_CURVE_Ed25519
    getPrivateKey(signCtx.accountNumber, &privateKey);
c0d0192a:	4815      	ldr	r0, [pc, #84]	; (c0d01980 <handleSignRawTx+0x60>)
c0d0192c:	6800      	ldr	r0, [r0, #0]
c0d0192e:	ae07      	add	r6, sp, #28
c0d01930:	4631      	mov	r1, r6
c0d01932:	f001 fedf 	bl	c0d036f4 <getPrivateKey>

    //Get deterministic Signature of SHA512 hash of the Raw Tx.
    sizeOfSignature = cx_eddsa_sign(&privateKey, 0, CX_SHA512, signCtx.rawTx, signCtx.rawTxLen, NULL, 0, signature, mpi_size, &info);
c0d01936:	4813      	ldr	r0, [pc, #76]	; (c0d01984 <handleSignRawTx+0x64>)
c0d01938:	6803      	ldr	r3, [r0, #0]
c0d0193a:	4813      	ldr	r0, [pc, #76]	; (c0d01988 <handleSignRawTx+0x68>)
c0d0193c:	8800      	ldrh	r0, [r0, #0]
c0d0193e:	a911      	add	r1, sp, #68	; 0x44
c0d01940:	466a      	mov	r2, sp
c0d01942:	6151      	str	r1, [r2, #20]
c0d01944:	2172      	movs	r1, #114	; 0x72
c0d01946:	6111      	str	r1, [r2, #16]
c0d01948:	4910      	ldr	r1, [pc, #64]	; (c0d0198c <handleSignRawTx+0x6c>)
c0d0194a:	60d1      	str	r1, [r2, #12]
c0d0194c:	6095      	str	r5, [r2, #8]
c0d0194e:	c221      	stmia	r2!, {r0, r5}
c0d01950:	2205      	movs	r2, #5
c0d01952:	4630      	mov	r0, r6
c0d01954:	4629      	mov	r1, r5
c0d01956:	f000 f883 	bl	c0d01a60 <cx_eddsa_sign>
c0d0195a:	490d      	ldr	r1, [pc, #52]	; (c0d01990 <handleSignRawTx+0x70>)
c0d0195c:	7008      	strb	r0, [r1, #0]
c0d0195e:	2228      	movs	r2, #40	; 0x28

    //Clear memory of Private key data.
    os_memset(&privateKey, 0, sizeof(cx_ecfp_private_key_t));
c0d01960:	4630      	mov	r0, r6
c0d01962:	4629      	mov	r1, r5
c0d01964:	f7ff f8bc 	bl	c0d00ae0 <os_memset>

    //Register User interface flow for the signature process.
    ux_flow_init(0, ux_display_sign_flow, NULL);
c0d01968:	490a      	ldr	r1, [pc, #40]	; (c0d01994 <handleSignRawTx+0x74>)
c0d0196a:	4479      	add	r1, pc
c0d0196c:	4628      	mov	r0, r5
c0d0196e:	462a      	mov	r2, r5
c0d01970:	f002 f882 	bl	c0d03a78 <ux_flow_init>

    //Set flags to indicate that user input is required to continue.
    *flags |= IO_ASYNCH_REPLY;
c0d01974:	6820      	ldr	r0, [r4, #0]
c0d01976:	2110      	movs	r1, #16
c0d01978:	4301      	orrs	r1, r0
c0d0197a:	6021      	str	r1, [r4, #0]
}
c0d0197c:	b012      	add	sp, #72	; 0x48
c0d0197e:	bd70      	pop	{r4, r5, r6, pc}
c0d01980:	20001d1c 	.word	0x20001d1c
c0d01984:	20001d14 	.word	0x20001d14
c0d01988:	20001d18 	.word	0x20001d18
c0d0198c:	20001ca0 	.word	0x20001ca0
c0d01990:	20001d12 	.word	0x20001d12
c0d01994:	000031aa 	.word	0x000031aa

c0d01998 <SVC_Call>:

// avoid a separate asm file, but avoid any intrusion from the compiler
__attribute__((naked)) void SVC_Call(unsigned int syscall_id, volatile unsigned int * parameters);
__attribute__((naked)) void SVC_Call(__attribute__((unused)) unsigned int syscall_id, __attribute__((unused)) volatile unsigned int * parameters) {
  // delegate svc, ensure no optimization by gcc with naked and r0, r1 marked as clobbered
  asm volatile("svc #1":::"r0","r1");
c0d01998:	df01      	svc	1
  asm volatile("bx  lr");
c0d0199a:	4770      	bx	lr

c0d0199c <check_api_level>:
}
void check_api_level ( unsigned int apiLevel ) 
{
c0d0199c:	b580      	push	{r7, lr}
c0d0199e:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
  parameters[0] = (unsigned int)apiLevel;
c0d019a0:	9001      	str	r0, [sp, #4]
c0d019a2:	4803      	ldr	r0, [pc, #12]	; (c0d019b0 <check_api_level+0x14>)
c0d019a4:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
c0d019a6:	f7ff fff7 	bl	c0d01998 <SVC_Call>
}
c0d019aa:	b004      	add	sp, #16
c0d019ac:	bd80      	pop	{r7, pc}
c0d019ae:	46c0      	nop			; (mov r8, r8)
c0d019b0:	60000137 	.word	0x60000137

c0d019b4 <halt>:

void halt ( void ) 
{
c0d019b4:	b580      	push	{r7, lr}
c0d019b6:	b082      	sub	sp, #8
c0d019b8:	4802      	ldr	r0, [pc, #8]	; (c0d019c4 <halt+0x10>)
c0d019ba:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
  SVC_Call(SYSCALL_halt_ID_IN, parameters);
c0d019bc:	f7ff ffec 	bl	c0d01998 <SVC_Call>
}
c0d019c0:	b002      	add	sp, #8
c0d019c2:	bd80      	pop	{r7, pc}
c0d019c4:	6000023c 	.word	0x6000023c

c0d019c8 <nvm_write>:

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d019c8:	b580      	push	{r7, lr}
c0d019ca:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)dst_adr;
c0d019cc:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)src_adr;
c0d019ce:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)src_len;
c0d019d0:	9203      	str	r2, [sp, #12]
c0d019d2:	4803      	ldr	r0, [pc, #12]	; (c0d019e0 <nvm_write+0x18>)
c0d019d4:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_nvm_write_ID_IN, parameters);
c0d019d6:	f7ff ffdf 	bl	c0d01998 <SVC_Call>
}
c0d019da:	b006      	add	sp, #24
c0d019dc:	bd80      	pop	{r7, pc}
c0d019de:	46c0      	nop			; (mov r8, r8)
c0d019e0:	6000037f 	.word	0x6000037f

c0d019e4 <cx_rng>:
  SVC_Call(SYSCALL_cx_rng_u8_ID_IN, parameters);
  return (unsigned char)(((volatile unsigned int*)parameters)[1]);
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d019e4:	b580      	push	{r7, lr}
c0d019e6:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
c0d019e8:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)len;
c0d019ea:	9101      	str	r1, [sp, #4]
c0d019ec:	4803      	ldr	r0, [pc, #12]	; (c0d019fc <cx_rng+0x18>)
c0d019ee:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_rng_ID_IN, parameters);
c0d019f0:	f7ff ffd2 	bl	c0d01998 <SVC_Call>
  return (unsigned char *)(((volatile unsigned int*)parameters)[1]);
c0d019f4:	9801      	ldr	r0, [sp, #4]
c0d019f6:	b004      	add	sp, #16
c0d019f8:	bd80      	pop	{r7, pc}
c0d019fa:	46c0      	nop			; (mov r8, r8)
c0d019fc:	6000052c 	.word	0x6000052c

c0d01a00 <cx_hash_sha256>:
  SVC_Call(SYSCALL_cx_sha256_init_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_hash_sha256 ( const unsigned char * in, unsigned int len, unsigned char * out, unsigned int out_len ) 
{
c0d01a00:	b580      	push	{r7, lr}
c0d01a02:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+4];
  parameters[0] = (unsigned int)in;
c0d01a04:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)len;
c0d01a06:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)out;
c0d01a08:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)out_len;
c0d01a0a:	9303      	str	r3, [sp, #12]
c0d01a0c:	4803      	ldr	r0, [pc, #12]	; (c0d01a1c <cx_hash_sha256+0x1c>)
c0d01a0e:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_hash_sha256_ID_IN, parameters);
c0d01a10:	f7ff ffc2 	bl	c0d01998 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d01a14:	9801      	ldr	r0, [sp, #4]
c0d01a16:	b006      	add	sp, #24
c0d01a18:	bd80      	pop	{r7, pc}
c0d01a1a:	46c0      	nop			; (mov r8, r8)
c0d01a1c:	60000b2c 	.word	0x60000b2c

c0d01a20 <cx_ecfp_init_private_key>:
  SVC_Call(SYSCALL_cx_ecfp_init_public_key_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_ecfp_init_private_key ( cx_curve_t curve, const unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * pvkey ) 
{
c0d01a20:	b580      	push	{r7, lr}
c0d01a22:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+4];
  parameters[0] = (unsigned int)curve;
c0d01a24:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)rawkey;
c0d01a26:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)key_len;
c0d01a28:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)pvkey;
c0d01a2a:	9303      	str	r3, [sp, #12]
c0d01a2c:	4803      	ldr	r0, [pc, #12]	; (c0d01a3c <cx_ecfp_init_private_key+0x1c>)
c0d01a2e:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_ecfp_init_private_key_ID_IN, parameters);
c0d01a30:	f7ff ffb2 	bl	c0d01998 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d01a34:	9801      	ldr	r0, [sp, #4]
c0d01a36:	b006      	add	sp, #24
c0d01a38:	bd80      	pop	{r7, pc}
c0d01a3a:	46c0      	nop			; (mov r8, r8)
c0d01a3c:	60002eea 	.word	0x60002eea

c0d01a40 <cx_ecfp_generate_pair>:
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01a40:	b580      	push	{r7, lr}
c0d01a42:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+4];
  parameters[0] = (unsigned int)curve;
c0d01a44:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)pubkey;
c0d01a46:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)privkey;
c0d01a48:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)keepprivate;
c0d01a4a:	9303      	str	r3, [sp, #12]
c0d01a4c:	4803      	ldr	r0, [pc, #12]	; (c0d01a5c <cx_ecfp_generate_pair+0x1c>)
c0d01a4e:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_ecfp_generate_pair_ID_IN, parameters);
c0d01a50:	f7ff ffa2 	bl	c0d01998 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d01a54:	9801      	ldr	r0, [sp, #4]
c0d01a56:	b006      	add	sp, #24
c0d01a58:	bd80      	pop	{r7, pc}
c0d01a5a:	46c0      	nop			; (mov r8, r8)
c0d01a5c:	60002f2e 	.word	0x60002f2e

c0d01a60 <cx_eddsa_sign>:
  parameters[6] = (unsigned int)h_len;
  SVC_Call(SYSCALL_cx_eddsa_get_public_key_ID_IN, parameters);
}

int cx_eddsa_sign ( const cx_ecfp_private_key_t * pvkey, int mode, cx_md_t hashID, const unsigned char * hash, unsigned int hash_len, const unsigned char * ctx, unsigned int ctx_len, unsigned char * sig, unsigned int sig_len, unsigned int * info ) 
{
c0d01a60:	b580      	push	{r7, lr}
c0d01a62:	b08c      	sub	sp, #48	; 0x30
  volatile unsigned int parameters [2+10];
  parameters[0] = (unsigned int)pvkey;
c0d01a64:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)mode;
c0d01a66:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)hashID;
c0d01a68:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)hash;
c0d01a6a:	9303      	str	r3, [sp, #12]
c0d01a6c:	980e      	ldr	r0, [sp, #56]	; 0x38
  parameters[4] = (unsigned int)hash_len;
c0d01a6e:	9004      	str	r0, [sp, #16]
c0d01a70:	980f      	ldr	r0, [sp, #60]	; 0x3c
  parameters[5] = (unsigned int)ctx;
c0d01a72:	9005      	str	r0, [sp, #20]
c0d01a74:	9810      	ldr	r0, [sp, #64]	; 0x40
  parameters[6] = (unsigned int)ctx_len;
c0d01a76:	9006      	str	r0, [sp, #24]
c0d01a78:	9811      	ldr	r0, [sp, #68]	; 0x44
  parameters[7] = (unsigned int)sig;
c0d01a7a:	9007      	str	r0, [sp, #28]
c0d01a7c:	9812      	ldr	r0, [sp, #72]	; 0x48
  parameters[8] = (unsigned int)sig_len;
c0d01a7e:	9008      	str	r0, [sp, #32]
c0d01a80:	9813      	ldr	r0, [sp, #76]	; 0x4c
  parameters[9] = (unsigned int)info;
c0d01a82:	9009      	str	r0, [sp, #36]	; 0x24
c0d01a84:	4803      	ldr	r0, [pc, #12]	; (c0d01a94 <cx_eddsa_sign+0x34>)
c0d01a86:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_eddsa_sign_ID_IN, parameters);
c0d01a88:	f7ff ff86 	bl	c0d01998 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d01a8c:	9801      	ldr	r0, [sp, #4]
c0d01a8e:	b00c      	add	sp, #48	; 0x30
c0d01a90:	bd80      	pop	{r7, pc}
c0d01a92:	46c0      	nop			; (mov r8, r8)
c0d01a94:	6000363b 	.word	0x6000363b

c0d01a98 <cx_crc16_update>:
  SVC_Call(SYSCALL_cx_crc16_ID_IN, parameters);
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
}

unsigned short cx_crc16_update ( unsigned short crc, const void * buffer, size_t len ) 
{
c0d01a98:	b580      	push	{r7, lr}
c0d01a9a:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)crc;
c0d01a9c:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)buffer;
c0d01a9e:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)len;
c0d01aa0:	9203      	str	r2, [sp, #12]
c0d01aa2:	4804      	ldr	r0, [pc, #16]	; (c0d01ab4 <cx_crc16_update+0x1c>)
c0d01aa4:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_cx_crc16_update_ID_IN, parameters);
c0d01aa6:	f7ff ff77 	bl	c0d01998 <SVC_Call>
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
c0d01aaa:	9802      	ldr	r0, [sp, #8]
c0d01aac:	b280      	uxth	r0, r0
c0d01aae:	b006      	add	sp, #24
c0d01ab0:	bd80      	pop	{r7, pc}
c0d01ab2:	46c0      	nop			; (mov r8, r8)
c0d01ab4:	6000926e 	.word	0x6000926e

c0d01ab8 <os_perso_isonboarded>:
  volatile unsigned int parameters [2];
  SVC_Call(SYSCALL_os_perso_finalize_ID_IN, parameters);
}

bolos_bool_t os_perso_isonboarded ( void ) 
{
c0d01ab8:	b580      	push	{r7, lr}
c0d01aba:	b082      	sub	sp, #8
c0d01abc:	4803      	ldr	r0, [pc, #12]	; (c0d01acc <os_perso_isonboarded+0x14>)
c0d01abe:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_perso_isonboarded_ID_IN, parameters);
c0d01ac0:	f7ff ff6a 	bl	c0d01998 <SVC_Call>
  return (bolos_bool_t)(((volatile unsigned int*)parameters)[1]);
c0d01ac4:	9801      	ldr	r0, [sp, #4]
c0d01ac6:	b2c0      	uxtb	r0, r0
c0d01ac8:	b002      	add	sp, #8
c0d01aca:	bd80      	pop	{r7, pc}
c0d01acc:	60009f4f 	.word	0x60009f4f

c0d01ad0 <os_perso_derive_node_with_seed_key>:
  parameters[4] = (unsigned int)chain;
  SVC_Call(SYSCALL_os_perso_derive_node_bip32_ID_IN, parameters);
}

void os_perso_derive_node_with_seed_key ( unsigned int mode, cx_curve_t curve, const unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain, unsigned char * seed_key, unsigned int seed_key_length ) 
{
c0d01ad0:	b580      	push	{r7, lr}
c0d01ad2:	b08a      	sub	sp, #40	; 0x28
  volatile unsigned int parameters [2+8];
  parameters[0] = (unsigned int)mode;
c0d01ad4:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)curve;
c0d01ad6:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)path;
c0d01ad8:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)pathLength;
c0d01ada:	9303      	str	r3, [sp, #12]
c0d01adc:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[4] = (unsigned int)privateKey;
c0d01ade:	9004      	str	r0, [sp, #16]
c0d01ae0:	980d      	ldr	r0, [sp, #52]	; 0x34
  parameters[5] = (unsigned int)chain;
c0d01ae2:	9005      	str	r0, [sp, #20]
c0d01ae4:	980e      	ldr	r0, [sp, #56]	; 0x38
  parameters[6] = (unsigned int)seed_key;
c0d01ae6:	9006      	str	r0, [sp, #24]
c0d01ae8:	980f      	ldr	r0, [sp, #60]	; 0x3c
  parameters[7] = (unsigned int)seed_key_length;
c0d01aea:	9007      	str	r0, [sp, #28]
c0d01aec:	4802      	ldr	r0, [pc, #8]	; (c0d01af8 <os_perso_derive_node_with_seed_key+0x28>)
c0d01aee:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_perso_derive_node_with_seed_key_ID_IN, parameters);
c0d01af0:	f7ff ff52 	bl	c0d01998 <SVC_Call>
}
c0d01af4:	b00a      	add	sp, #40	; 0x28
c0d01af6:	bd80      	pop	{r7, pc}
c0d01af8:	6000a6d8 	.word	0x6000a6d8

c0d01afc <os_perso_seed_cookie>:

unsigned int os_perso_seed_cookie ( unsigned char * seed_cookie, unsigned int seed_cookie_length ) 
{
c0d01afc:	b580      	push	{r7, lr}
c0d01afe:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)seed_cookie;
c0d01b00:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)seed_cookie_length;
c0d01b02:	9101      	str	r1, [sp, #4]
c0d01b04:	4803      	ldr	r0, [pc, #12]	; (c0d01b14 <os_perso_seed_cookie+0x18>)
c0d01b06:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_perso_seed_cookie_ID_IN, parameters);
c0d01b08:	f7ff ff46 	bl	c0d01998 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01b0c:	9801      	ldr	r0, [sp, #4]
c0d01b0e:	b004      	add	sp, #16
c0d01b10:	bd80      	pop	{r7, pc}
c0d01b12:	46c0      	nop			; (mov r8, r8)
c0d01b14:	6000a8fc 	.word	0x6000a8fc

c0d01b18 <os_global_pin_is_validated>:
  SVC_Call(SYSCALL_os_endorsement_key2_derive_sign_data_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

bolos_bool_t os_global_pin_is_validated ( void ) 
{
c0d01b18:	b580      	push	{r7, lr}
c0d01b1a:	b082      	sub	sp, #8
c0d01b1c:	4803      	ldr	r0, [pc, #12]	; (c0d01b2c <os_global_pin_is_validated+0x14>)
c0d01b1e:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_global_pin_is_validated_ID_IN, parameters);
c0d01b20:	f7ff ff3a 	bl	c0d01998 <SVC_Call>
  return (bolos_bool_t)(((volatile unsigned int*)parameters)[1]);
c0d01b24:	9801      	ldr	r0, [sp, #4]
c0d01b26:	b2c0      	uxtb	r0, r0
c0d01b28:	b002      	add	sp, #8
c0d01b2a:	bd80      	pop	{r7, pc}
c0d01b2c:	6000a03c 	.word	0x6000a03c

c0d01b30 <os_ux>:
  parameters[1] = (unsigned int)out_application_entry;
  SVC_Call(SYSCALL_os_registry_get_ID_IN, parameters);
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01b30:	b580      	push	{r7, lr}
c0d01b32:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)params;
c0d01b34:	9001      	str	r0, [sp, #4]
c0d01b36:	4803      	ldr	r0, [pc, #12]	; (c0d01b44 <os_ux+0x14>)
c0d01b38:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
c0d01b3a:	f7ff ff2d 	bl	c0d01998 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01b3e:	9802      	ldr	r0, [sp, #8]
c0d01b40:	b004      	add	sp, #16
c0d01b42:	bd80      	pop	{r7, pc}
c0d01b44:	60006458 	.word	0x60006458

c0d01b48 <os_flags>:
  parameters[0] = (unsigned int)exception;
  SVC_Call(SYSCALL_os_lib_throw_ID_IN, parameters);
}

unsigned int os_flags ( void ) 
{
c0d01b48:	b580      	push	{r7, lr}
c0d01b4a:	b082      	sub	sp, #8
c0d01b4c:	4803      	ldr	r0, [pc, #12]	; (c0d01b5c <os_flags+0x14>)
c0d01b4e:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
c0d01b50:	f7ff ff22 	bl	c0d01998 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01b54:	9801      	ldr	r0, [sp, #4]
c0d01b56:	b002      	add	sp, #8
c0d01b58:	bd80      	pop	{r7, pc}
c0d01b5a:	46c0      	nop			; (mov r8, r8)
c0d01b5c:	60006a6e 	.word	0x60006a6e

c0d01b60 <os_registry_get_current_app_tag>:
  SVC_Call(SYSCALL_os_registry_get_tag_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

unsigned int os_registry_get_current_app_tag ( unsigned int tag, unsigned char * buffer, unsigned int maxlen ) 
{
c0d01b60:	b580      	push	{r7, lr}
c0d01b62:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)tag;
c0d01b64:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)buffer;
c0d01b66:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)maxlen;
c0d01b68:	9203      	str	r2, [sp, #12]
c0d01b6a:	4803      	ldr	r0, [pc, #12]	; (c0d01b78 <os_registry_get_current_app_tag+0x18>)
c0d01b6c:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
c0d01b6e:	f7ff ff13 	bl	c0d01998 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01b72:	9802      	ldr	r0, [sp, #8]
c0d01b74:	b006      	add	sp, #24
c0d01b76:	bd80      	pop	{r7, pc}
c0d01b78:	600074d4 	.word	0x600074d4

c0d01b7c <os_sched_exit>:
  parameters[0] = (unsigned int)application_index;
  SVC_Call(SYSCALL_os_sched_exec_ID_IN, parameters);
}

void os_sched_exit ( bolos_task_status_t exit_code ) 
{
c0d01b7c:	b580      	push	{r7, lr}
c0d01b7e:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
  parameters[0] = (unsigned int)exit_code;
c0d01b80:	9001      	str	r0, [sp, #4]
c0d01b82:	4803      	ldr	r0, [pc, #12]	; (c0d01b90 <os_sched_exit+0x14>)
c0d01b84:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d01b86:	f7ff ff07 	bl	c0d01998 <SVC_Call>
}
c0d01b8a:	b004      	add	sp, #16
c0d01b8c:	bd80      	pop	{r7, pc}
c0d01b8e:	46c0      	nop			; (mov r8, r8)
c0d01b90:	60009abe 	.word	0x60009abe

c0d01b94 <io_seph_send>:
  parameters[0] = (unsigned int)taskidx;
  SVC_Call(SYSCALL_os_sched_kill_ID_IN, parameters);
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01b94:	b580      	push	{r7, lr}
c0d01b96:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
c0d01b98:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)length;
c0d01b9a:	9101      	str	r1, [sp, #4]
c0d01b9c:	4802      	ldr	r0, [pc, #8]	; (c0d01ba8 <io_seph_send+0x14>)
c0d01b9e:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_io_seph_send_ID_IN, parameters);
c0d01ba0:	f7ff fefa 	bl	c0d01998 <SVC_Call>
}
c0d01ba4:	b004      	add	sp, #16
c0d01ba6:	bd80      	pop	{r7, pc}
c0d01ba8:	60008381 	.word	0x60008381

c0d01bac <io_seph_is_status_sent>:

unsigned int io_seph_is_status_sent ( void ) 
{
c0d01bac:	b580      	push	{r7, lr}
c0d01bae:	b082      	sub	sp, #8
c0d01bb0:	4803      	ldr	r0, [pc, #12]	; (c0d01bc0 <io_seph_is_status_sent+0x14>)
c0d01bb2:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_io_seph_is_status_sent_ID_IN, parameters);
c0d01bb4:	f7ff fef0 	bl	c0d01998 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01bb8:	9801      	ldr	r0, [sp, #4]
c0d01bba:	b002      	add	sp, #8
c0d01bbc:	bd80      	pop	{r7, pc}
c0d01bbe:	46c0      	nop			; (mov r8, r8)
c0d01bc0:	600084bb 	.word	0x600084bb

c0d01bc4 <io_seph_recv>:
}

unsigned short io_seph_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01bc4:	b580      	push	{r7, lr}
c0d01bc6:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)buffer;
c0d01bc8:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)maxlength;
c0d01bca:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)flags;
c0d01bcc:	9203      	str	r2, [sp, #12]
c0d01bce:	4804      	ldr	r0, [pc, #16]	; (c0d01be0 <io_seph_recv+0x1c>)
c0d01bd0:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_io_seph_recv_ID_IN, parameters);
c0d01bd2:	f7ff fee1 	bl	c0d01998 <SVC_Call>
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
c0d01bd6:	9802      	ldr	r0, [sp, #8]
c0d01bd8:	b280      	uxth	r0, r0
c0d01bda:	b006      	add	sp, #24
c0d01bdc:	bd80      	pop	{r7, pc}
c0d01bde:	46c0      	nop			; (mov r8, r8)
c0d01be0:	600085e4 	.word	0x600085e4

c0d01be4 <try_context_get>:
  parameters[0] = (unsigned int)page_adr;
  SVC_Call(SYSCALL_nvm_write_page_ID_IN, parameters);
}

try_context_t * try_context_get ( void ) 
{
c0d01be4:	b580      	push	{r7, lr}
c0d01be6:	b082      	sub	sp, #8
c0d01be8:	4803      	ldr	r0, [pc, #12]	; (c0d01bf8 <try_context_get+0x14>)
c0d01bea:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_try_context_get_ID_IN, parameters);
c0d01bec:	f7ff fed4 	bl	c0d01998 <SVC_Call>
  return (try_context_t *)(((volatile unsigned int*)parameters)[1]);
c0d01bf0:	9801      	ldr	r0, [sp, #4]
c0d01bf2:	b002      	add	sp, #8
c0d01bf4:	bd80      	pop	{r7, pc}
c0d01bf6:	46c0      	nop			; (mov r8, r8)
c0d01bf8:	600087b1 	.word	0x600087b1

c0d01bfc <try_context_set>:
}

try_context_t * try_context_set ( try_context_t * context ) 
{
c0d01bfc:	b580      	push	{r7, lr}
c0d01bfe:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)context;
c0d01c00:	9001      	str	r0, [sp, #4]
c0d01c02:	4803      	ldr	r0, [pc, #12]	; (c0d01c10 <try_context_set+0x14>)
c0d01c04:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_try_context_set_ID_IN, parameters);
c0d01c06:	f7ff fec7 	bl	c0d01998 <SVC_Call>
  return (try_context_t *)(((volatile unsigned int*)parameters)[1]);
c0d01c0a:	9802      	ldr	r0, [sp, #8]
c0d01c0c:	b004      	add	sp, #16
c0d01c0e:	bd80      	pop	{r7, pc}
c0d01c10:	60008875 	.word	0x60008875

c0d01c14 <os_sched_last_status>:
  SVC_Call(SYSCALL_cx_rng_u32_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

bolos_task_status_t os_sched_last_status ( unsigned int task_idx ) 
{
c0d01c14:	b580      	push	{r7, lr}
c0d01c16:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)task_idx;
c0d01c18:	9001      	str	r0, [sp, #4]
c0d01c1a:	4804      	ldr	r0, [pc, #16]	; (c0d01c2c <os_sched_last_status+0x18>)
c0d01c1c:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_sched_last_status_ID_IN, parameters);
c0d01c1e:	f7ff febb 	bl	c0d01998 <SVC_Call>
  return (bolos_task_status_t)(((volatile unsigned int*)parameters)[1]);
c0d01c22:	9802      	ldr	r0, [sp, #8]
c0d01c24:	b2c0      	uxtb	r0, r0
c0d01c26:	b004      	add	sp, #16
c0d01c28:	bd80      	pop	{r7, pc}
c0d01c2a:	46c0      	nop			; (mov r8, r8)
c0d01c2c:	60009c8b 	.word	0x60009c8b

c0d01c30 <u2f_apdu_sign>:

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
}

void u2f_apdu_sign(u2f_service_t *service, uint8_t p1, uint8_t p2,
                     uint8_t *buffer, uint16_t length) {
c0d01c30:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c32:	b081      	sub	sp, #4
c0d01c34:	4604      	mov	r4, r0
    UNUSED(p2);
    uint8_t keyHandleLength;
    uint8_t i;

    // can't process the apdu if another one is already scheduled in
    if (G_io_app.apdu_state != APDU_IDLE) {
c0d01c36:	4834      	ldr	r0, [pc, #208]	; (c0d01d08 <u2f_apdu_sign+0xd8>)
c0d01c38:	7800      	ldrb	r0, [r0, #0]
c0d01c3a:	2800      	cmp	r0, #0
c0d01c3c:	d003      	beq.n	c0d01c46 <u2f_apdu_sign+0x16>
c0d01c3e:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01c40:	4a33      	ldr	r2, [pc, #204]	; (c0d01d10 <u2f_apdu_sign+0xe0>)
c0d01c42:	447a      	add	r2, pc
c0d01c44:	e045      	b.n	c0d01cd2 <u2f_apdu_sign+0xa2>
c0d01c46:	9806      	ldr	r0, [sp, #24]
                  (uint8_t *)SW_BUSY,
                  sizeof(SW_BUSY));
        return;        
    }

    if (length < U2F_HANDLE_SIGN_HEADER_SIZE + 5 /*at least an apdu header*/) {
c0d01c48:	2845      	cmp	r0, #69	; 0x45
c0d01c4a:	d803      	bhi.n	c0d01c54 <u2f_apdu_sign+0x24>
c0d01c4c:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01c4e:	4a31      	ldr	r2, [pc, #196]	; (c0d01d14 <u2f_apdu_sign+0xe4>)
c0d01c50:	447a      	add	r2, pc
c0d01c52:	e03e      	b.n	c0d01cd2 <u2f_apdu_sign+0xa2>
                  sizeof(SW_WRONG_LENGTH));
        return;
    }

    // Confirm immediately if it's just a validation call
    if (p1 == P1_SIGN_CHECK_ONLY) {
c0d01c54:	2907      	cmp	r1, #7
c0d01c56:	d103      	bne.n	c0d01c60 <u2f_apdu_sign+0x30>
c0d01c58:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01c5a:	4a2f      	ldr	r2, [pc, #188]	; (c0d01d18 <u2f_apdu_sign+0xe8>)
c0d01c5c:	447a      	add	r2, pc
c0d01c5e:	e038      	b.n	c0d01cd2 <u2f_apdu_sign+0xa2>
c0d01c60:	461d      	mov	r5, r3
c0d01c62:	9000      	str	r0, [sp, #0]
c0d01c64:	2040      	movs	r0, #64	; 0x40
                  sizeof(SW_PROOF_OF_PRESENCE_REQUIRED));
        return;
    }

    // Unwrap magic
    keyHandleLength = buffer[U2F_HANDLE_SIGN_HEADER_SIZE-1];
c0d01c66:	5c1e      	ldrb	r6, [r3, r0]
    
    // reply to the "get magic" question of the host
    if (keyHandleLength == 5) {
c0d01c68:	2e00      	cmp	r6, #0
c0d01c6a:	d018      	beq.n	c0d01c9e <u2f_apdu_sign+0x6e>
c0d01c6c:	2e05      	cmp	r6, #5
c0d01c6e:	d108      	bne.n	c0d01c82 <u2f_apdu_sign+0x52>
        // GET U2F PROXY PARAMETERS
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
c0d01c70:	4628      	mov	r0, r5
c0d01c72:	3041      	adds	r0, #65	; 0x41
c0d01c74:	4929      	ldr	r1, [pc, #164]	; (c0d01d1c <u2f_apdu_sign+0xec>)
c0d01c76:	4479      	add	r1, pc
c0d01c78:	2205      	movs	r2, #5
c0d01c7a:	f7fe ff3a 	bl	c0d00af2 <os_memcmp>
c0d01c7e:	2800      	cmp	r0, #0
c0d01c80:	d02d      	beq.n	c0d01cde <u2f_apdu_sign+0xae>
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
c0d01c82:	4628      	mov	r0, r5
c0d01c84:	3041      	adds	r0, #65	; 0x41
c0d01c86:	2100      	movs	r1, #0
c0d01c88:	4a25      	ldr	r2, [pc, #148]	; (c0d01d20 <u2f_apdu_sign+0xf0>)
c0d01c8a:	447a      	add	r2, pc
c0d01c8c:	5c43      	ldrb	r3, [r0, r1]
c0d01c8e:	2703      	movs	r7, #3
c0d01c90:	400f      	ands	r7, r1
c0d01c92:	5dd7      	ldrb	r7, [r2, r7]
c0d01c94:	405f      	eors	r7, r3
c0d01c96:	5447      	strb	r7, [r0, r1]
            return;
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
c0d01c98:	1c49      	adds	r1, r1, #1
c0d01c9a:	428e      	cmp	r6, r1
c0d01c9c:	d1f6      	bne.n	c0d01c8c <u2f_apdu_sign+0x5c>
c0d01c9e:	2045      	movs	r0, #69	; 0x45
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
c0d01ca0:	5c28      	ldrb	r0, [r5, r0]
c0d01ca2:	3046      	adds	r0, #70	; 0x46
c0d01ca4:	9900      	ldr	r1, [sp, #0]
c0d01ca6:	4288      	cmp	r0, r1
c0d01ca8:	d110      	bne.n	c0d01ccc <u2f_apdu_sign+0x9c>
                  sizeof(SW_BAD_KEY_HANDLE));
        return;
    }

    // make the apdu available to higher layers
    os_memmove(G_io_apdu_buffer, buffer + U2F_HANDLE_SIGN_HEADER_SIZE, keyHandleLength);
c0d01caa:	3541      	adds	r5, #65	; 0x41
c0d01cac:	4817      	ldr	r0, [pc, #92]	; (c0d01d0c <u2f_apdu_sign+0xdc>)
c0d01cae:	4629      	mov	r1, r5
c0d01cb0:	4632      	mov	r2, r6
c0d01cb2:	f7fe feff 	bl	c0d00ab4 <os_memmove>
c0d01cb6:	2007      	movs	r0, #7
c0d01cb8:	4913      	ldr	r1, [pc, #76]	; (c0d01d08 <u2f_apdu_sign+0xd8>)
    G_io_app.apdu_length = keyHandleLength;
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
c0d01cba:	7188      	strb	r0, [r1, #6]
        return;
    }

    // make the apdu available to higher layers
    os_memmove(G_io_apdu_buffer, buffer + U2F_HANDLE_SIGN_HEADER_SIZE, keyHandleLength);
    G_io_app.apdu_length = keyHandleLength;
c0d01cbc:	804e      	strh	r6, [r1, #2]
c0d01cbe:	2009      	movs	r0, #9
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
    G_io_app.apdu_state = APDU_U2F;
c0d01cc0:	7008      	strb	r0, [r1, #0]
c0d01cc2:	2101      	movs	r1, #1

    // prepare for asynch reply
    u2f_message_set_autoreply_wait_user_presence(service, true);
c0d01cc4:	4620      	mov	r0, r4
c0d01cc6:	f000 fc57 	bl	c0d02578 <u2f_message_set_autoreply_wait_user_presence>
c0d01cca:	e006      	b.n	c0d01cda <u2f_apdu_sign+0xaa>
c0d01ccc:	2183      	movs	r1, #131	; 0x83
    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01cce:	4a15      	ldr	r2, [pc, #84]	; (c0d01d24 <u2f_apdu_sign+0xf4>)
c0d01cd0:	447a      	add	r2, pc
c0d01cd2:	2302      	movs	r3, #2
c0d01cd4:	4620      	mov	r0, r4
c0d01cd6:	f000 fc63 	bl	c0d025a0 <u2f_message_reply>
    app_dispatch();
    if ((btchip_context_D.io_flags & IO_ASYNCH_REPLY) == 0) {
        u2f_proxy_response(service, btchip_context_D.outLength);
    }
    */
}
c0d01cda:	b001      	add	sp, #4
c0d01cdc:	bdf0      	pop	{r4, r5, r6, r7, pc}
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
c0d01cde:	4d0b      	ldr	r5, [pc, #44]	; (c0d01d0c <u2f_apdu_sign+0xdc>)
c0d01ce0:	2604      	movs	r6, #4
c0d01ce2:	702e      	strb	r6, [r5, #0]
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
c0d01ce4:	1c68      	adds	r0, r5, #1
c0d01ce6:	4910      	ldr	r1, [pc, #64]	; (c0d01d28 <u2f_apdu_sign+0xf8>)
c0d01ce8:	4479      	add	r1, pc
c0d01cea:	4632      	mov	r2, r6
c0d01cec:	f7fe fee2 	bl	c0d00ab4 <os_memmove>
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
c0d01cf0:	1d68      	adds	r0, r5, #5
c0d01cf2:	490e      	ldr	r1, [pc, #56]	; (c0d01d2c <u2f_apdu_sign+0xfc>)
c0d01cf4:	4479      	add	r1, pc
c0d01cf6:	4632      	mov	r2, r6
c0d01cf8:	f7fe fedc 	bl	c0d00ab4 <os_memmove>
            u2f_message_reply(service, U2F_CMD_MSG,
                              (uint8_t *)G_io_apdu_buffer,
                              G_io_apdu_buffer[0]+1+2+2);
c0d01cfc:	7828      	ldrb	r0, [r5, #0]
c0d01cfe:	1d43      	adds	r3, r0, #5
c0d01d00:	2183      	movs	r1, #131	; 0x83
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
            u2f_message_reply(service, U2F_CMD_MSG,
c0d01d02:	4620      	mov	r0, r4
c0d01d04:	462a      	mov	r2, r5
c0d01d06:	e7e6      	b.n	c0d01cd6 <u2f_apdu_sign+0xa6>
c0d01d08:	20001be0 	.word	0x20001be0
c0d01d0c:	20001a8e 	.word	0x20001a8e
c0d01d10:	00002ee4 	.word	0x00002ee4
c0d01d14:	00002ed8 	.word	0x00002ed8
c0d01d18:	00002ece 	.word	0x00002ece
c0d01d1c:	00002eb6 	.word	0x00002eb6
c0d01d20:	00002ea8 	.word	0x00002ea8
c0d01d24:	00002e6c 	.word	0x00002e6c
c0d01d28:	00002e4a 	.word	0x00002e4a
c0d01d2c:	00002e43 	.word	0x00002e43

c0d01d30 <u2f_handle_cmd_init>:
}

#endif // U2F_PROXY_MAGIC

void u2f_handle_cmd_init(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length, uint8_t *channelInit) {
c0d01d30:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01d32:	b081      	sub	sp, #4
c0d01d34:	461d      	mov	r5, r3
c0d01d36:	460e      	mov	r6, r1
c0d01d38:	4604      	mov	r4, r0
    // screen_printf("U2F init\n");
    uint8_t channel[4];
    (void)length;
    if (u2f_is_channel_broadcast(channelInit)) {
c0d01d3a:	4618      	mov	r0, r3
c0d01d3c:	f000 fc10 	bl	c0d02560 <u2f_is_channel_broadcast>
c0d01d40:	2800      	cmp	r0, #0
c0d01d42:	d00e      	beq.n	c0d01d62 <u2f_handle_cmd_init+0x32>
        // cx_rng(channel, 4); // not available within the IO task
        U4BE_ENCODE(channel, 0, ++service->next_channel);
c0d01d44:	6820      	ldr	r0, [r4, #0]
c0d01d46:	1cc1      	adds	r1, r0, #3
c0d01d48:	0a09      	lsrs	r1, r1, #8
c0d01d4a:	466a      	mov	r2, sp
c0d01d4c:	7091      	strb	r1, [r2, #2]
c0d01d4e:	1c81      	adds	r1, r0, #2
c0d01d50:	0c09      	lsrs	r1, r1, #16
c0d01d52:	7051      	strb	r1, [r2, #1]
c0d01d54:	1c41      	adds	r1, r0, #1
c0d01d56:	0e09      	lsrs	r1, r1, #24
c0d01d58:	7011      	strb	r1, [r2, #0]
c0d01d5a:	1d00      	adds	r0, r0, #4
c0d01d5c:	6020      	str	r0, [r4, #0]
c0d01d5e:	70d0      	strb	r0, [r2, #3]
c0d01d60:	e004      	b.n	c0d01d6c <u2f_handle_cmd_init+0x3c>
c0d01d62:	4668      	mov	r0, sp
c0d01d64:	2204      	movs	r2, #4
    } else {
        os_memmove(channel, channelInit, 4);
c0d01d66:	4629      	mov	r1, r5
c0d01d68:	f7fe fea4 	bl	c0d00ab4 <os_memmove>
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
c0d01d6c:	4f17      	ldr	r7, [pc, #92]	; (c0d01dcc <u2f_handle_cmd_init+0x9c>)
c0d01d6e:	2208      	movs	r2, #8
c0d01d70:	4638      	mov	r0, r7
c0d01d72:	4631      	mov	r1, r6
c0d01d74:	f7fe fe9e 	bl	c0d00ab4 <os_memmove>
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
c0d01d78:	4638      	mov	r0, r7
c0d01d7a:	3008      	adds	r0, #8
c0d01d7c:	4669      	mov	r1, sp
c0d01d7e:	2204      	movs	r2, #4
c0d01d80:	f7fe fe98 	bl	c0d00ab4 <os_memmove>
c0d01d84:	2000      	movs	r0, #0
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
c0d01d86:	7378      	strb	r0, [r7, #13]
c0d01d88:	2102      	movs	r1, #2
    } else {
        os_memmove(channel, channelInit, 4);
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
c0d01d8a:	7339      	strb	r1, [r7, #12]
c0d01d8c:	2101      	movs	r1, #1
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
c0d01d8e:	73b9      	strb	r1, [r7, #14]
    G_io_apdu_buffer[15] = INIT_BUILD_VERSION;
c0d01d90:	73f8      	strb	r0, [r7, #15]
    G_io_apdu_buffer[16] = INIT_CAPABILITIES;
c0d01d92:	7438      	strb	r0, [r7, #16]

    if (u2f_is_channel_broadcast(channelInit)) {
c0d01d94:	4628      	mov	r0, r5
c0d01d96:	f000 fbe3 	bl	c0d02560 <u2f_is_channel_broadcast>
c0d01d9a:	4601      	mov	r1, r0
c0d01d9c:	1d20      	adds	r0, r4, #4
c0d01d9e:	2586      	movs	r5, #134	; 0x86
c0d01da0:	2900      	cmp	r1, #0
c0d01da2:	d006      	beq.n	c0d01db2 <u2f_handle_cmd_init+0x82>
        os_memset(service->channel, 0xff, 4);
c0d01da4:	4629      	mov	r1, r5
c0d01da6:	3179      	adds	r1, #121	; 0x79
c0d01da8:	b2c9      	uxtb	r1, r1
c0d01daa:	2204      	movs	r2, #4
c0d01dac:	f7fe fe98 	bl	c0d00ae0 <os_memset>
c0d01db0:	e003      	b.n	c0d01dba <u2f_handle_cmd_init+0x8a>
c0d01db2:	4669      	mov	r1, sp
c0d01db4:	2204      	movs	r2, #4
    } else {
        os_memmove(service->channel, channel, 4);
c0d01db6:	f7fe fe7d 	bl	c0d00ab4 <os_memmove>
    }
    u2f_message_reply(service, U2F_CMD_INIT, G_io_apdu_buffer, 17);
c0d01dba:	4a04      	ldr	r2, [pc, #16]	; (c0d01dcc <u2f_handle_cmd_init+0x9c>)
c0d01dbc:	2311      	movs	r3, #17
c0d01dbe:	4620      	mov	r0, r4
c0d01dc0:	4629      	mov	r1, r5
c0d01dc2:	f000 fbed 	bl	c0d025a0 <u2f_message_reply>
}
c0d01dc6:	b001      	add	sp, #4
c0d01dc8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01dca:	46c0      	nop			; (mov r8, r8)
c0d01dcc:	20001a8e 	.word	0x20001a8e

c0d01dd0 <u2f_handle_cmd_msg>:
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
c0d01dd0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01dd2:	b083      	sub	sp, #12
c0d01dd4:	9002      	str	r0, [sp, #8]
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
c0d01dd6:	7988      	ldrb	r0, [r1, #6]
c0d01dd8:	794b      	ldrb	r3, [r1, #5]
c0d01dda:	021b      	lsls	r3, r3, #8
c0d01ddc:	181f      	adds	r7, r3, r0
void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
c0d01dde:	7888      	ldrb	r0, [r1, #2]

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
c0d01de0:	9001      	str	r0, [sp, #4]
c0d01de2:	784b      	ldrb	r3, [r1, #1]
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
c0d01de4:	780e      	ldrb	r6, [r1, #0]
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
c0d01de6:	4615      	mov	r5, r2
c0d01de8:	3d09      	subs	r5, #9
c0d01dea:	b2ac      	uxth	r4, r5
c0d01dec:	42a7      	cmp	r7, r4
c0d01dee:	d004      	beq.n	c0d01dfa <u2f_handle_cmd_msg+0x2a>
c0d01df0:	1fd0      	subs	r0, r2, #7
c0d01df2:	1fd2      	subs	r2, r2, #7
c0d01df4:	b292      	uxth	r2, r2
c0d01df6:	4297      	cmp	r7, r2
c0d01df8:	d11b      	bne.n	c0d01e32 <u2f_handle_cmd_msg+0x62>
c0d01dfa:	463d      	mov	r5, r7
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
    G_io_app.apdu_state = APDU_U2F;

#else // U2F_PROXY_MAGIC

    if (cla != FIDO_CLA) {
c0d01dfc:	2e00      	cmp	r6, #0
c0d01dfe:	d008      	beq.n	c0d01e12 <u2f_handle_cmd_msg+0x42>
c0d01e00:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01e02:	4a1c      	ldr	r2, [pc, #112]	; (c0d01e74 <u2f_handle_cmd_msg+0xa4>)
c0d01e04:	447a      	add	r2, pc
c0d01e06:	2302      	movs	r3, #2
c0d01e08:	9802      	ldr	r0, [sp, #8]
c0d01e0a:	f000 fbc9 	bl	c0d025a0 <u2f_message_reply>
                 sizeof(SW_UNKNOWN_INSTRUCTION));
        return;
    }

#endif // U2F_PROXY_MAGIC
}
c0d01e0e:	b003      	add	sp, #12
c0d01e10:	bdf0      	pop	{r4, r5, r6, r7, pc}
        u2f_message_reply(service, U2F_CMD_MSG,
                  (uint8_t *)SW_UNKNOWN_CLASS,
                  sizeof(SW_UNKNOWN_CLASS));
        return;
    }
    switch (ins) {
c0d01e12:	2b02      	cmp	r3, #2
c0d01e14:	dc18      	bgt.n	c0d01e48 <u2f_handle_cmd_msg+0x78>
c0d01e16:	2b01      	cmp	r3, #1
c0d01e18:	d023      	beq.n	c0d01e62 <u2f_handle_cmd_msg+0x92>
c0d01e1a:	2b02      	cmp	r3, #2
c0d01e1c:	d11d      	bne.n	c0d01e5a <u2f_handle_cmd_msg+0x8a>
        // screen_printf("enroll\n");
        u2f_apdu_enroll(service, p1, p2, buffer + 7, dataLength);
        break;
    case FIDO_INS_SIGN:
        // screen_printf("sign\n");
        u2f_apdu_sign(service, p1, p2, buffer + 7, dataLength);
c0d01e1e:	b2a8      	uxth	r0, r5
c0d01e20:	466a      	mov	r2, sp
c0d01e22:	6010      	str	r0, [r2, #0]
c0d01e24:	1dcb      	adds	r3, r1, #7
c0d01e26:	2200      	movs	r2, #0
c0d01e28:	9802      	ldr	r0, [sp, #8]
c0d01e2a:	9901      	ldr	r1, [sp, #4]
c0d01e2c:	f7ff ff00 	bl	c0d01c30 <u2f_apdu_sign>
c0d01e30:	e7ed      	b.n	c0d01e0e <u2f_handle_cmd_msg+0x3e>
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
        // Le is optional
        // nominal case from the specification
    }
    // circumvent google chrome extended length encoding done on the last byte only (module 256) but all data being transferred
    else if (dataLength == (uint16_t)(length - 9)%256) {
c0d01e32:	b2e4      	uxtb	r4, r4
c0d01e34:	42a7      	cmp	r7, r4
c0d01e36:	d0e1      	beq.n	c0d01dfc <u2f_handle_cmd_msg+0x2c>
        dataLength = length - 9;
    }
    else if (dataLength == (uint16_t)(length - 7)%256) {
c0d01e38:	b2d2      	uxtb	r2, r2
c0d01e3a:	4297      	cmp	r7, r2
c0d01e3c:	4605      	mov	r5, r0
c0d01e3e:	d0dd      	beq.n	c0d01dfc <u2f_handle_cmd_msg+0x2c>
c0d01e40:	2183      	movs	r1, #131	; 0x83
        dataLength = length - 7;
    }    
    else { 
        // invalid size
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01e42:	4a0d      	ldr	r2, [pc, #52]	; (c0d01e78 <u2f_handle_cmd_msg+0xa8>)
c0d01e44:	447a      	add	r2, pc
c0d01e46:	e7de      	b.n	c0d01e06 <u2f_handle_cmd_msg+0x36>
        u2f_message_reply(service, U2F_CMD_MSG,
                  (uint8_t *)SW_UNKNOWN_CLASS,
                  sizeof(SW_UNKNOWN_CLASS));
        return;
    }
    switch (ins) {
c0d01e48:	2b03      	cmp	r3, #3
c0d01e4a:	d00e      	beq.n	c0d01e6a <u2f_handle_cmd_msg+0x9a>
c0d01e4c:	2bc1      	cmp	r3, #193	; 0xc1
c0d01e4e:	d104      	bne.n	c0d01e5a <u2f_handle_cmd_msg+0x8a>
c0d01e50:	2183      	movs	r1, #131	; 0x83
                            uint8_t *buffer, uint16_t length) {
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)INFO, sizeof(INFO));
c0d01e52:	4a0a      	ldr	r2, [pc, #40]	; (c0d01e7c <u2f_handle_cmd_msg+0xac>)
c0d01e54:	447a      	add	r2, pc
c0d01e56:	2304      	movs	r3, #4
c0d01e58:	e7d6      	b.n	c0d01e08 <u2f_handle_cmd_msg+0x38>
c0d01e5a:	2183      	movs	r1, #131	; 0x83
        u2f_apdu_get_info(service, p1, p2, buffer + 7, dataLength);
        break;

    default:
        // screen_printf("unsupported\n");
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01e5c:	4a0a      	ldr	r2, [pc, #40]	; (c0d01e88 <u2f_handle_cmd_msg+0xb8>)
c0d01e5e:	447a      	add	r2, pc
c0d01e60:	e7d1      	b.n	c0d01e06 <u2f_handle_cmd_msg+0x36>
c0d01e62:	2183      	movs	r1, #131	; 0x83
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
c0d01e64:	4a06      	ldr	r2, [pc, #24]	; (c0d01e80 <u2f_handle_cmd_msg+0xb0>)
c0d01e66:	447a      	add	r2, pc
c0d01e68:	e7cd      	b.n	c0d01e06 <u2f_handle_cmd_msg+0x36>
c0d01e6a:	2183      	movs	r1, #131	; 0x83
    // screen_printf("U2F version\n");
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)U2F_VERSION, sizeof(U2F_VERSION));
c0d01e6c:	4a05      	ldr	r2, [pc, #20]	; (c0d01e84 <u2f_handle_cmd_msg+0xb4>)
c0d01e6e:	447a      	add	r2, pc
c0d01e70:	2308      	movs	r3, #8
c0d01e72:	e7c9      	b.n	c0d01e08 <u2f_handle_cmd_msg+0x38>
c0d01e74:	00002d46 	.word	0x00002d46
c0d01e78:	00002ce4 	.word	0x00002ce4
c0d01e7c:	00002cf2 	.word	0x00002cf2
c0d01e80:	00002cbe 	.word	0x00002cbe
c0d01e84:	00002cd0 	.word	0x00002cd0
c0d01e88:	00002cee 	.word	0x00002cee

c0d01e8c <u2f_message_complete>:
    }

#endif // U2F_PROXY_MAGIC
}

void u2f_message_complete(u2f_service_t *service) {
c0d01e8c:	b580      	push	{r7, lr}
    uint8_t cmd = service->transportBuffer[0];
c0d01e8e:	69c1      	ldr	r1, [r0, #28]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
c0d01e90:	788a      	ldrb	r2, [r1, #2]
c0d01e92:	784b      	ldrb	r3, [r1, #1]
c0d01e94:	021b      	lsls	r3, r3, #8
c0d01e96:	189b      	adds	r3, r3, r2

#endif // U2F_PROXY_MAGIC
}

void u2f_message_complete(u2f_service_t *service) {
    uint8_t cmd = service->transportBuffer[0];
c0d01e98:	780a      	ldrb	r2, [r1, #0]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
    switch (cmd) {
c0d01e9a:	2a81      	cmp	r2, #129	; 0x81
c0d01e9c:	d009      	beq.n	c0d01eb2 <u2f_message_complete+0x26>
c0d01e9e:	2a83      	cmp	r2, #131	; 0x83
c0d01ea0:	d00d      	beq.n	c0d01ebe <u2f_message_complete+0x32>
c0d01ea2:	2a86      	cmp	r2, #134	; 0x86
c0d01ea4:	d10f      	bne.n	c0d01ec6 <u2f_message_complete+0x3a>
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
c0d01ea6:	1cc9      	adds	r1, r1, #3
c0d01ea8:	1d03      	adds	r3, r0, #4
c0d01eaa:	2200      	movs	r2, #0
c0d01eac:	f7ff ff40 	bl	c0d01d30 <u2f_handle_cmd_init>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d01eb0:	bd80      	pop	{r7, pc}
    switch (cmd) {
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
c0d01eb2:	1cca      	adds	r2, r1, #3
}

void u2f_handle_cmd_ping(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length) {
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
c0d01eb4:	b29b      	uxth	r3, r3
c0d01eb6:	2181      	movs	r1, #129	; 0x81
c0d01eb8:	f000 fb72 	bl	c0d025a0 <u2f_message_reply>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d01ebc:	bd80      	pop	{r7, pc}
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
c0d01ebe:	1cc9      	adds	r1, r1, #3
c0d01ec0:	b29a      	uxth	r2, r3
c0d01ec2:	f7ff ff85 	bl	c0d01dd0 <u2f_handle_cmd_msg>
        break;
    }
}
c0d01ec6:	bd80      	pop	{r7, pc}

c0d01ec8 <u2f_io_send>:
#include "u2f_processing.h"
#include "u2f_impl.h"

#include "os_io_seproxyhal.h"

void u2f_io_send(uint8_t *buffer, uint16_t length, u2f_transport_media_t media) {
c0d01ec8:	b570      	push	{r4, r5, r6, lr}
    if (media == U2F_MEDIA_USB) {
c0d01eca:	2a01      	cmp	r2, #1
c0d01ecc:	d113      	bne.n	c0d01ef6 <u2f_io_send+0x2e>
c0d01ece:	460d      	mov	r5, r1
c0d01ed0:	4601      	mov	r1, r0
        os_memmove(G_io_usb_ep_buffer, buffer, length);
c0d01ed2:	4c09      	ldr	r4, [pc, #36]	; (c0d01ef8 <u2f_io_send+0x30>)
c0d01ed4:	4620      	mov	r0, r4
c0d01ed6:	462a      	mov	r2, r5
c0d01ed8:	f7fe fdec 	bl	c0d00ab4 <os_memmove>
        // wipe the remaining to avoid :
        // 1/ data leaks
        // 2/ invalid junk
        os_memset(G_io_usb_ep_buffer+length, 0, sizeof(G_io_usb_ep_buffer)-length);
c0d01edc:	1960      	adds	r0, r4, r5
c0d01ede:	2640      	movs	r6, #64	; 0x40
c0d01ee0:	1b72      	subs	r2, r6, r5
c0d01ee2:	2500      	movs	r5, #0
c0d01ee4:	4629      	mov	r1, r5
c0d01ee6:	f7fe fdfb 	bl	c0d00ae0 <os_memset>
c0d01eea:	2081      	movs	r0, #129	; 0x81
    }
    switch (media) {
    case U2F_MEDIA_USB:
        io_usb_send_ep(U2F_EPIN_ADDR, G_io_usb_ep_buffer, USB_SEGMENT_SIZE, 0);
c0d01eec:	4621      	mov	r1, r4
c0d01eee:	4632      	mov	r2, r6
c0d01ef0:	462b      	mov	r3, r5
c0d01ef2:	f7fe fea9 	bl	c0d00c48 <io_usb_send_ep>
#endif
    default:
        PRINTF("Request to send on unsupported media %d\n", media);
        break;
    }
}
c0d01ef6:	bd70      	pop	{r4, r5, r6, pc}
c0d01ef8:	20001c4c 	.word	0x20001c4c

c0d01efc <u2f_transport_init>:
/**
 * Initialize the u2f transport and provide the buffer into which to store incoming message
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
    service->transportReceiveBufferLength = message_buffer_length;
c0d01efc:	8202      	strh	r2, [r0, #16]

/**
 * Initialize the u2f transport and provide the buffer into which to store incoming message
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
c0d01efe:	60c1      	str	r1, [r0, #12]
c0d01f00:	2200      	movs	r2, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d01f02:	82c2      	strh	r2, [r0, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d01f04:	7682      	strb	r2, [r0, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d01f06:	8542      	strh	r2, [r0, #42]	; 0x2a

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d01f08:	8482      	strh	r2, [r0, #36]	; 0x24
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d01f0a:	61c1      	str	r1, [r0, #28]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d01f0c:	6202      	str	r2, [r0, #32]
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
    service->transportReceiveBufferLength = message_buffer_length;
    u2f_transport_reset(service);
}
c0d01f0e:	4770      	bx	lr

c0d01f10 <u2f_transport_sent>:

/**
 * Function called when the previously scheduled message to be sent on the media is effectively sent.
 * And a new message can be scheduled.
 */
void u2f_transport_sent(u2f_service_t* service, u2f_transport_media_t media) {
c0d01f10:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01f12:	b083      	sub	sp, #12
c0d01f14:	460d      	mov	r5, r1
c0d01f16:	4604      	mov	r4, r0
c0d01f18:	202a      	movs	r0, #42	; 0x2a

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d01f1a:	5c21      	ldrb	r1, [r4, r0]
c0d01f1c:	4620      	mov	r0, r4
c0d01f1e:	302a      	adds	r0, #42	; 0x2a
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d01f20:	2901      	cmp	r1, #1
c0d01f22:	d048      	beq.n	c0d01fb6 <u2f_transport_sent+0xa6>
c0d01f24:	2900      	cmp	r1, #0
c0d01f26:	d139      	bne.n	c0d01f9c <u2f_transport_sent+0x8c>
c0d01f28:	212b      	movs	r1, #43	; 0x2b
c0d01f2a:	2200      	movs	r2, #0
c0d01f2c:	5462      	strb	r2, [r4, r1]
c0d01f2e:	4622      	mov	r2, r4
c0d01f30:	322b      	adds	r2, #43	; 0x2b
c0d01f32:	2120      	movs	r1, #32

    // previous mark packet as sent
    service->sending = false;

    // if idle (possibly after an error), then only await for a transmission 
    if (service->transportState != U2F_SENDING_RESPONSE 
c0d01f34:	5c63      	ldrb	r3, [r4, r1]
        && service->transportState != U2F_SENDING_ERROR) {
c0d01f36:	1edb      	subs	r3, r3, #3
c0d01f38:	b2db      	uxtb	r3, r3

    // previous mark packet as sent
    service->sending = false;

    // if idle (possibly after an error), then only await for a transmission 
    if (service->transportState != U2F_SENDING_RESPONSE 
c0d01f3a:	4626      	mov	r6, r4
c0d01f3c:	3620      	adds	r6, #32
        && service->transportState != U2F_SENDING_ERROR) {
c0d01f3e:	2b01      	cmp	r3, #1
c0d01f40:	d83c      	bhi.n	c0d01fbc <u2f_transport_sent+0xac>
        // absorb the error, transport is erroneous but that won't hurt in the end.
        // also absorb the fake channel user presence check reply ack
        //THROW(INVALID_STATE);
        return;
    }
    if (service->transportOffset < service->transportLength) {
c0d01f42:	8b23      	ldrh	r3, [r4, #24]
c0d01f44:	8ae7      	ldrh	r7, [r4, #22]
c0d01f46:	42bb      	cmp	r3, r7
c0d01f48:	d93a      	bls.n	c0d01fc0 <u2f_transport_sent+0xb0>
        uint16_t mtu = (media == U2F_MEDIA_USB) ? USB_SEGMENT_SIZE : BLE_SEGMENT_SIZE;
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
c0d01f4a:	7ea0      	ldrb	r0, [r4, #26]
c0d01f4c:	2203      	movs	r2, #3
c0d01f4e:	2601      	movs	r6, #1
c0d01f50:	9000      	str	r0, [sp, #0]
c0d01f52:	2800      	cmp	r0, #0
c0d01f54:	d000      	beq.n	c0d01f58 <u2f_transport_sent+0x48>
c0d01f56:	4632      	mov	r2, r6
        // also absorb the fake channel user presence check reply ack
        //THROW(INVALID_STATE);
        return;
    }
    if (service->transportOffset < service->transportLength) {
        uint16_t mtu = (media == U2F_MEDIA_USB) ? USB_SEGMENT_SIZE : BLE_SEGMENT_SIZE;
c0d01f58:	1e68      	subs	r0, r5, #1
c0d01f5a:	2600      	movs	r6, #0
c0d01f5c:	9602      	str	r6, [sp, #8]
c0d01f5e:	1a36      	subs	r6, r6, r0
c0d01f60:	4146      	adcs	r6, r0
c0d01f62:	00b0      	lsls	r0, r6, #2
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
c0d01f64:	1810      	adds	r0, r2, r0
c0d01f66:	2240      	movs	r2, #64	; 0x40
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
                                      (mtu - headerSize)
c0d01f68:	2d01      	cmp	r5, #1
c0d01f6a:	d000      	beq.n	c0d01f6e <u2f_transport_sent+0x5e>
c0d01f6c:	460a      	mov	r2, r1
c0d01f6e:	1a16      	subs	r6, r2, r0
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
c0d01f70:	1bd9      	subs	r1, r3, r7
c0d01f72:	42b1      	cmp	r1, r6
c0d01f74:	dc00      	bgt.n	c0d01f78 <u2f_transport_sent+0x68>
c0d01f76:	460e      	mov	r6, r1
                                      (mtu - headerSize)
                                  ? (mtu - headerSize)
                                  : service->transportLength - service->transportOffset);
        uint16_t dataSize = blockSize + headerSize;
c0d01f78:	1831      	adds	r1, r6, r0
        uint16_t offset = 0;
        // Fragment
        if (media == U2F_MEDIA_USB) {
c0d01f7a:	9101      	str	r1, [sp, #4]
c0d01f7c:	2d01      	cmp	r5, #1
c0d01f7e:	4607      	mov	r7, r0
c0d01f80:	9800      	ldr	r0, [sp, #0]
c0d01f82:	d106      	bne.n	c0d01f92 <u2f_transport_sent+0x82>
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d01f84:	1d21      	adds	r1, r4, #4
c0d01f86:	4827      	ldr	r0, [pc, #156]	; (c0d02024 <u2f_transport_sent+0x114>)
c0d01f88:	2204      	movs	r2, #4
c0d01f8a:	9202      	str	r2, [sp, #8]
c0d01f8c:	f7fe fd92 	bl	c0d00ab4 <os_memmove>
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
c0d01f90:	7ea0      	ldrb	r0, [r4, #26]
c0d01f92:	2800      	cmp	r0, #0
c0d01f94:	d021      	beq.n	c0d01fda <u2f_transport_sent+0xca>
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
c0d01f96:	1e40      	subs	r0, r0, #1
c0d01f98:	9902      	ldr	r1, [sp, #8]
c0d01f9a:	e029      	b.n	c0d01ff0 <u2f_transport_sent+0xe0>
c0d01f9c:	2125      	movs	r1, #37	; 0x25
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d01f9e:	5c61      	ldrb	r1, [r4, r1]
            && service->sending == false)
c0d01fa0:	2906      	cmp	r1, #6
c0d01fa2:	d108      	bne.n	c0d01fb6 <u2f_transport_sent+0xa6>
c0d01fa4:	212b      	movs	r1, #43	; 0x2b
c0d01fa6:	5c63      	ldrb	r3, [r4, r1]
c0d01fa8:	2200      	movs	r2, #0
c0d01faa:	5462      	strb	r2, [r4, r1]
c0d01fac:	4622      	mov	r2, r4
c0d01fae:	322b      	adds	r2, #43	; 0x2b
 * And a new message can be scheduled.
 */
void u2f_transport_sent(u2f_service_t* service, u2f_transport_media_t media) {

    // don't process when replying to anti timeout requests
    if (!u2f_message_repliable(service)) {
c0d01fb0:	2b00      	cmp	r3, #0
c0d01fb2:	d103      	bne.n	c0d01fbc <u2f_transport_sent+0xac>
c0d01fb4:	e7bd      	b.n	c0d01f32 <u2f_transport_sent+0x22>
c0d01fb6:	202b      	movs	r0, #43	; 0x2b
c0d01fb8:	2100      	movs	r1, #0
c0d01fba:	5421      	strb	r1, [r4, r0]
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
    }
}
c0d01fbc:	b003      	add	sp, #12
c0d01fbe:	bdf0      	pop	{r4, r5, r6, r7, pc}
        service->transportOffset += blockSize;
        service->transportPacketIndex++;
        u2f_io_send(G_io_usb_ep_buffer, dataSize, media);
    }
    // last part sent
    else if (service->transportOffset == service->transportLength) {
c0d01fc0:	d1fc      	bne.n	c0d01fbc <u2f_transport_sent+0xac>
c0d01fc2:	2100      	movs	r1, #0
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d01fc4:	76a1      	strb	r1, [r4, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d01fc6:	82e1      	strh	r1, [r4, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d01fc8:	7011      	strb	r1, [r2, #0]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d01fca:	7001      	strb	r1, [r0, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d01fcc:	80b1      	strh	r1, [r6, #4]
c0d01fce:	6031      	str	r1, [r6, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d01fd0:	68e0      	ldr	r0, [r4, #12]
c0d01fd2:	61e0      	str	r0, [r4, #28]
    }
    // last part sent
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
c0d01fd4:	4812      	ldr	r0, [pc, #72]	; (c0d02020 <u2f_transport_sent+0x110>)
c0d01fd6:	7001      	strb	r1, [r0, #0]
c0d01fd8:	e7f0      	b.n	c0d01fbc <u2f_transport_sent+0xac>
c0d01fda:	2040      	movs	r0, #64	; 0x40
        if (media == U2F_MEDIA_USB) {
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
c0d01fdc:	5c20      	ldrb	r0, [r4, r0]
c0d01fde:	4911      	ldr	r1, [pc, #68]	; (c0d02024 <u2f_transport_sent+0x114>)
c0d01fe0:	9a02      	ldr	r2, [sp, #8]
c0d01fe2:	5488      	strb	r0, [r1, r2]
c0d01fe4:	2001      	movs	r0, #1
c0d01fe6:	4310      	orrs	r0, r2
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
c0d01fe8:	7e62      	ldrb	r2, [r4, #25]
c0d01fea:	540a      	strb	r2, [r1, r0]
c0d01fec:	1c41      	adds	r1, r0, #1
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
c0d01fee:	7e20      	ldrb	r0, [r4, #24]
c0d01ff0:	4b0c      	ldr	r3, [pc, #48]	; (c0d02024 <u2f_transport_sent+0x114>)
c0d01ff2:	5458      	strb	r0, [r3, r1]
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
c0d01ff4:	69e1      	ldr	r1, [r4, #28]
c0d01ff6:	2900      	cmp	r1, #0
c0d01ff8:	d005      	beq.n	c0d02006 <u2f_transport_sent+0xf6>
c0d01ffa:	b2b2      	uxth	r2, r6
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d01ffc:	19d8      	adds	r0, r3, r7
                       service->transportBuffer + service->transportOffset, blockSize);
c0d01ffe:	8ae3      	ldrh	r3, [r4, #22]
c0d02000:	18c9      	adds	r1, r1, r3
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d02002:	f7fe fd57 	bl	c0d00ab4 <os_memmove>
                       service->transportBuffer + service->transportOffset, blockSize);
        }
        service->transportOffset += blockSize;
c0d02006:	8ae0      	ldrh	r0, [r4, #22]
c0d02008:	1980      	adds	r0, r0, r6
c0d0200a:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d0200c:	7ea0      	ldrb	r0, [r4, #26]
c0d0200e:	1c40      	adds	r0, r0, #1
c0d02010:	76a0      	strb	r0, [r4, #26]
        u2f_io_send(G_io_usb_ep_buffer, dataSize, media);
c0d02012:	9801      	ldr	r0, [sp, #4]
c0d02014:	b281      	uxth	r1, r0
c0d02016:	4803      	ldr	r0, [pc, #12]	; (c0d02024 <u2f_transport_sent+0x114>)
c0d02018:	462a      	mov	r2, r5
c0d0201a:	f7ff ff55 	bl	c0d01ec8 <u2f_io_send>
c0d0201e:	e7cd      	b.n	c0d01fbc <u2f_transport_sent+0xac>
c0d02020:	20001be0 	.word	0x20001be0
c0d02024:	20001c4c 	.word	0x20001c4c

c0d02028 <u2f_message_repliable>:
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
    }
}

bool u2f_message_repliable(u2f_service_t* service) {
c0d02028:	212a      	movs	r1, #42	; 0x2a
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d0202a:	5c42      	ldrb	r2, [r0, r1]
c0d0202c:	2101      	movs	r1, #1
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d0202e:	2a00      	cmp	r2, #0
c0d02030:	d00d      	beq.n	c0d0204e <u2f_message_repliable+0x26>
c0d02032:	2a01      	cmp	r2, #1
c0d02034:	d101      	bne.n	c0d0203a <u2f_message_repliable+0x12>
c0d02036:	2100      	movs	r1, #0
c0d02038:	e009      	b.n	c0d0204e <u2f_message_repliable+0x26>
c0d0203a:	2125      	movs	r1, #37	; 0x25
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d0203c:	5c42      	ldrb	r2, [r0, r1]
c0d0203e:	2100      	movs	r1, #0
            && service->sending == false)
c0d02040:	2a06      	cmp	r2, #6
c0d02042:	d104      	bne.n	c0d0204e <u2f_message_repliable+0x26>
c0d02044:	212b      	movs	r1, #43	; 0x2b
c0d02046:	5c40      	ldrb	r0, [r0, r1]
c0d02048:	2100      	movs	r1, #0
c0d0204a:	1a09      	subs	r1, r1, r0
c0d0204c:	4141      	adcs	r1, r0

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d0204e:	4608      	mov	r0, r1
c0d02050:	4770      	bx	lr
	...

c0d02054 <u2f_transport_send_usb_user_presence_required>:
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
    }
}

void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
c0d02054:	b5b0      	push	{r4, r5, r7, lr}
c0d02056:	212b      	movs	r1, #43	; 0x2b
c0d02058:	2401      	movs	r4, #1
    uint16_t offset = 0;
    service->sending = true;
c0d0205a:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d0205c:	1d01      	adds	r1, r0, #4
c0d0205e:	4d0b      	ldr	r5, [pc, #44]	; (c0d0208c <u2f_transport_send_usb_user_presence_required+0x38>)
c0d02060:	2204      	movs	r2, #4
c0d02062:	4628      	mov	r0, r5
c0d02064:	f7fe fd26 	bl	c0d00ab4 <os_memmove>
c0d02068:	2000      	movs	r0, #0
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
    G_io_usb_ep_buffer[offset++] = 0;
c0d0206a:	7168      	strb	r0, [r5, #5]
c0d0206c:	2083      	movs	r0, #131	; 0x83
void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
c0d0206e:	7128      	strb	r0, [r5, #4]
c0d02070:	2002      	movs	r0, #2
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 2;
c0d02072:	71a8      	strb	r0, [r5, #6]
c0d02074:	2069      	movs	r0, #105	; 0x69
    G_io_usb_ep_buffer[offset++] = 0x69;
c0d02076:	71e8      	strb	r0, [r5, #7]
c0d02078:	207c      	movs	r0, #124	; 0x7c
c0d0207a:	43c0      	mvns	r0, r0
    G_io_usb_ep_buffer[offset++] = 0x85;
c0d0207c:	1c80      	adds	r0, r0, #2
c0d0207e:	7228      	strb	r0, [r5, #8]
c0d02080:	2109      	movs	r1, #9
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d02082:	4628      	mov	r0, r5
c0d02084:	4622      	mov	r2, r4
c0d02086:	f7ff ff1f 	bl	c0d01ec8 <u2f_io_send>
}
c0d0208a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0208c:	20001c4c 	.word	0x20001c4c

c0d02090 <u2f_transport_send_wink>:

void u2f_transport_send_wink(u2f_service_t *service) {
c0d02090:	b5b0      	push	{r4, r5, r7, lr}
c0d02092:	212b      	movs	r1, #43	; 0x2b
c0d02094:	2401      	movs	r4, #1
    uint16_t offset = 0;
    service->sending = true;
c0d02096:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d02098:	1d01      	adds	r1, r0, #4
c0d0209a:	4d08      	ldr	r5, [pc, #32]	; (c0d020bc <u2f_transport_send_wink+0x2c>)
c0d0209c:	2204      	movs	r2, #4
c0d0209e:	4628      	mov	r0, r5
c0d020a0:	f7fe fd08 	bl	c0d00ab4 <os_memmove>
c0d020a4:	2000      	movs	r0, #0
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_WINK;
    G_io_usb_ep_buffer[offset++] = 0;
c0d020a6:	7168      	strb	r0, [r5, #5]
c0d020a8:	2188      	movs	r1, #136	; 0x88
void u2f_transport_send_wink(u2f_service_t *service) {
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_WINK;
c0d020aa:	7129      	strb	r1, [r5, #4]
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 0;
c0d020ac:	71a8      	strb	r0, [r5, #6]
c0d020ae:	2107      	movs	r1, #7
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d020b0:	4628      	mov	r0, r5
c0d020b2:	4622      	mov	r2, r4
c0d020b4:	f7ff ff08 	bl	c0d01ec8 <u2f_io_send>
}
c0d020b8:	bdb0      	pop	{r4, r5, r7, pc}
c0d020ba:	46c0      	nop			; (mov r8, r8)
c0d020bc:	20001c4c 	.word	0x20001c4c

c0d020c0 <u2f_transport_receive_fakeChannel>:

bool u2f_transport_receive_fakeChannel(u2f_service_t *service, uint8_t *buffer, uint16_t size) {
c0d020c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d020c2:	b081      	sub	sp, #4
c0d020c4:	4604      	mov	r4, r0
c0d020c6:	2025      	movs	r0, #37	; 0x25
    if (service->fakeChannelTransportState == U2F_INTERNAL_ERROR) {
c0d020c8:	5c20      	ldrb	r0, [r4, r0]
c0d020ca:	4626      	mov	r6, r4
c0d020cc:	3625      	adds	r6, #37	; 0x25
c0d020ce:	2500      	movs	r5, #0
c0d020d0:	2805      	cmp	r0, #5
c0d020d2:	d06a      	beq.n	c0d021aa <u2f_transport_receive_fakeChannel+0xea>
        return false;
    }
    if (memcmp(service->channel, buffer, 4) != 0) {
c0d020d4:	7808      	ldrb	r0, [r1, #0]
c0d020d6:	784b      	ldrb	r3, [r1, #1]
c0d020d8:	021b      	lsls	r3, r3, #8
c0d020da:	1818      	adds	r0, r3, r0
c0d020dc:	788b      	ldrb	r3, [r1, #2]
c0d020de:	78cd      	ldrb	r5, [r1, #3]
c0d020e0:	022d      	lsls	r5, r5, #8
c0d020e2:	18eb      	adds	r3, r5, r3
c0d020e4:	041b      	lsls	r3, r3, #16
c0d020e6:	1818      	adds	r0, r3, r0
c0d020e8:	7923      	ldrb	r3, [r4, #4]
c0d020ea:	7965      	ldrb	r5, [r4, #5]
c0d020ec:	022d      	lsls	r5, r5, #8
c0d020ee:	18eb      	adds	r3, r5, r3
c0d020f0:	79a5      	ldrb	r5, [r4, #6]
c0d020f2:	79e7      	ldrb	r7, [r4, #7]
c0d020f4:	023f      	lsls	r7, r7, #8
c0d020f6:	197d      	adds	r5, r7, r5
c0d020f8:	042d      	lsls	r5, r5, #16
c0d020fa:	18eb      	adds	r3, r5, r3
c0d020fc:	4283      	cmp	r3, r0
c0d020fe:	d157      	bne.n	c0d021b0 <u2f_transport_receive_fakeChannel+0xf0>
c0d02100:	7908      	ldrb	r0, [r1, #4]
c0d02102:	1d0b      	adds	r3, r1, #4
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
c0d02104:	8c65      	ldrh	r5, [r4, #34]	; 0x22
c0d02106:	2d00      	cmp	r5, #0
c0d02108:	d013      	beq.n	c0d02132 <u2f_transport_receive_fakeChannel+0x72>
c0d0210a:	2324      	movs	r3, #36	; 0x24
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
        service->fakeChannelTransportPacketIndex = 0;
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
c0d0210c:	5ce7      	ldrb	r7, [r4, r3]
c0d0210e:	4623      	mov	r3, r4
c0d02110:	3324      	adds	r3, #36	; 0x24
c0d02112:	42b8      	cmp	r0, r7
c0d02114:	d14c      	bne.n	c0d021b0 <u2f_transport_receive_fakeChannel+0xf0>
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d02116:	8b27      	ldrh	r7, [r4, #24]
        service->fakeChannelTransportPacketIndex++;
c0d02118:	1c40      	adds	r0, r0, #1
c0d0211a:	7018      	strb	r0, [r3, #0]
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d0211c:	1b7b      	subs	r3, r7, r5
c0d0211e:	1f50      	subs	r0, r2, #5
c0d02120:	4298      	cmp	r0, r3
c0d02122:	db00      	blt.n	c0d02126 <u2f_transport_receive_fakeChannel+0x66>
c0d02124:	4618      	mov	r0, r3
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
c0d02126:	182a      	adds	r2, r5, r0
c0d02128:	8462      	strh	r2, [r4, #34]	; 0x22
c0d0212a:	b282      	uxth	r2, r0
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
c0d0212c:	8d20      	ldrh	r0, [r4, #40]	; 0x28
c0d0212e:	1d49      	adds	r1, r1, #5
c0d02130:	e023      	b.n	c0d0217a <u2f_transport_receive_fakeChannel+0xba>
c0d02132:	257c      	movs	r5, #124	; 0x7c
c0d02134:	43ed      	mvns	r5, r5
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
        uint16_t commandLength = U2BE(buffer, 4+1) + U2F_COMMAND_HEADER_SIZE;
        // Some buggy implementations can send a WINK here, reply it gently
        if (buffer[4] == U2F_CMD_WINK) {
c0d02136:	1d6d      	adds	r5, r5, #5
c0d02138:	b2ef      	uxtb	r7, r5
c0d0213a:	2583      	movs	r5, #131	; 0x83
c0d0213c:	42b8      	cmp	r0, r7
c0d0213e:	d104      	bne.n	c0d0214a <u2f_transport_receive_fakeChannel+0x8a>
            u2f_transport_send_wink(service);
c0d02140:	4620      	mov	r0, r4
c0d02142:	f7ff ffa5 	bl	c0d02090 <u2f_transport_send_wink>
c0d02146:	2501      	movs	r5, #1
c0d02148:	e02f      	b.n	c0d021aa <u2f_transport_receive_fakeChannel+0xea>
    }
    if (memcmp(service->channel, buffer, 4) != 0) {
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
        uint16_t commandLength = U2BE(buffer, 4+1) + U2F_COMMAND_HEADER_SIZE;
c0d0214a:	798f      	ldrb	r7, [r1, #6]
c0d0214c:	7949      	ldrb	r1, [r1, #5]
c0d0214e:	0209      	lsls	r1, r1, #8
c0d02150:	19c9      	adds	r1, r1, r7
c0d02152:	1cc9      	adds	r1, r1, #3
        if (buffer[4] == U2F_CMD_WINK) {
            u2f_transport_send_wink(service);
            return true;
        }

        if (commandLength != service->transportLength) {
c0d02154:	42a8      	cmp	r0, r5
c0d02156:	d12b      	bne.n	c0d021b0 <u2f_transport_receive_fakeChannel+0xf0>
c0d02158:	8b20      	ldrh	r0, [r4, #24]
c0d0215a:	b28d      	uxth	r5, r1
c0d0215c:	42a8      	cmp	r0, r5
c0d0215e:	d127      	bne.n	c0d021b0 <u2f_transport_receive_fakeChannel+0xf0>
c0d02160:	b289      	uxth	r1, r1
c0d02162:	4d16      	ldr	r5, [pc, #88]	; (c0d021bc <u2f_transport_receive_fakeChannel+0xfc>)
c0d02164:	2724      	movs	r7, #36	; 0x24
c0d02166:	2000      	movs	r0, #0
        }
        if (buffer[4] != U2F_CMD_MSG) {
            goto error;
        }
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
        service->fakeChannelTransportPacketIndex = 0;
c0d02168:	55e0      	strb	r0, [r4, r7]
            goto error;
        }
        if (buffer[4] != U2F_CMD_MSG) {
            goto error;
        }
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
c0d0216a:	1f12      	subs	r2, r2, #4
c0d0216c:	428a      	cmp	r2, r1
c0d0216e:	db00      	blt.n	c0d02172 <u2f_transport_receive_fakeChannel+0xb2>
c0d02170:	460a      	mov	r2, r1
c0d02172:	8462      	strh	r2, [r4, #34]	; 0x22
        service->fakeChannelTransportPacketIndex = 0;
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
c0d02174:	4015      	ands	r5, r2
c0d02176:	4619      	mov	r1, r3
c0d02178:	462a      	mov	r2, r5
c0d0217a:	f7ff fc8d 	bl	c0d01a98 <cx_crc16_update>
c0d0217e:	8520      	strh	r0, [r4, #40]	; 0x28
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
    }
    if (service->fakeChannelTransportOffset >= service->transportLength) {
c0d02180:	8b21      	ldrh	r1, [r4, #24]
c0d02182:	8c62      	ldrh	r2, [r4, #34]	; 0x22
c0d02184:	2501      	movs	r5, #1
c0d02186:	428a      	cmp	r2, r1
c0d02188:	d30f      	bcc.n	c0d021aa <u2f_transport_receive_fakeChannel+0xea>
        if (service->fakeChannelCrc != service->commandCrc) {
c0d0218a:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d0218c:	4288      	cmp	r0, r1
c0d0218e:	d10f      	bne.n	c0d021b0 <u2f_transport_receive_fakeChannel+0xf0>
c0d02190:	2006      	movs	r0, #6
            goto error;
        }
        service->fakeChannelTransportState = U2F_FAKE_RECEIVED;
c0d02192:	7030      	strb	r0, [r6, #0]
c0d02194:	2000      	movs	r0, #0
        service->fakeChannelTransportOffset = 0;
c0d02196:	8460      	strh	r0, [r4, #34]	; 0x22
c0d02198:	202a      	movs	r0, #42	; 0x2a
        // reply immediately when the asynch response is not yet ready
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d0219a:	5c20      	ldrb	r0, [r4, r0]
c0d0219c:	2801      	cmp	r0, #1
c0d0219e:	d104      	bne.n	c0d021aa <u2f_transport_receive_fakeChannel+0xea>
            u2f_transport_send_usb_user_presence_required(service);
c0d021a0:	4620      	mov	r0, r4
c0d021a2:	f7ff ff57 	bl	c0d02054 <u2f_transport_send_usb_user_presence_required>
c0d021a6:	2000      	movs	r0, #0
            // response sent
            service->fakeChannelTransportState = U2F_IDLE;
c0d021a8:	7030      	strb	r0, [r6, #0]
error:
    service->fakeChannelTransportState = U2F_INTERNAL_ERROR;
    // don't hesitate here, the user will have to exit/rerun the app otherwise.
    THROW(EXCEPTION_IO_RESET);
    return false;    
}
c0d021aa:	4628      	mov	r0, r5
c0d021ac:	b001      	add	sp, #4
c0d021ae:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d021b0:	2005      	movs	r0, #5
            service->fakeChannelTransportState = U2F_IDLE;
        }
    }
    return true;
error:
    service->fakeChannelTransportState = U2F_INTERNAL_ERROR;
c0d021b2:	7030      	strb	r0, [r6, #0]
c0d021b4:	2010      	movs	r0, #16
    // don't hesitate here, the user will have to exit/rerun the app otherwise.
    THROW(EXCEPTION_IO_RESET);
c0d021b6:	f7fe fcb0 	bl	c0d00b1a <os_longjmp>
c0d021ba:	46c0      	nop			; (mov r8, r8)
c0d021bc:	0000ffff 	.word	0x0000ffff

c0d021c0 <u2f_transport_received>:
/** 
 * Function that process every message received on a media.
 * Performs message concatenation when message is splitted.
 */
void u2f_transport_received(u2f_service_t *service, uint8_t *buffer,
                          uint16_t size, u2f_transport_media_t media) {
c0d021c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d021c2:	b089      	sub	sp, #36	; 0x24
c0d021c4:	4604      	mov	r4, r0
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
    uint16_t xfer_len;
    service->media = media;
c0d021c6:	7203      	strb	r3, [r0, #8]
c0d021c8:	2020      	movs	r0, #32

    // Handle a busy channel and avoid reentry
    if (service->transportState == U2F_SENDING_RESPONSE) {
c0d021ca:	5c20      	ldrb	r0, [r4, r0]
c0d021cc:	4626      	mov	r6, r4
c0d021ce:	3620      	adds	r6, #32
c0d021d0:	2803      	cmp	r0, #3
c0d021d2:	d00c      	beq.n	c0d021ee <u2f_transport_received+0x2e>
c0d021d4:	460f      	mov	r7, r1
c0d021d6:	212a      	movs	r1, #42	; 0x2a
        u2f_transport_error(service, ERROR_CHANNEL_BUSY);
        goto error;
    }
    if (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_IDLE) {
c0d021d8:	5c61      	ldrb	r1, [r4, r1]
c0d021da:	4625      	mov	r5, r4
c0d021dc:	352a      	adds	r5, #42	; 0x2a
c0d021de:	2900      	cmp	r1, #0
c0d021e0:	d015      	beq.n	c0d0220e <u2f_transport_received+0x4e>
        if (!u2f_transport_receive_fakeChannel(service, buffer, size)) {
c0d021e2:	4620      	mov	r0, r4
c0d021e4:	4639      	mov	r1, r7
c0d021e6:	f7ff ff6b 	bl	c0d020c0 <u2f_transport_receive_fakeChannel>
c0d021ea:	2800      	cmp	r0, #0
c0d021ec:	d174      	bne.n	c0d022d8 <u2f_transport_received+0x118>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d021ee:	48d8      	ldr	r0, [pc, #864]	; (c0d02550 <u2f_transport_received+0x390>)
c0d021f0:	2106      	movs	r1, #6
c0d021f2:	7201      	strb	r1, [r0, #8]
c0d021f4:	2104      	movs	r1, #4

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d021f6:	7031      	strb	r1, [r6, #0]
c0d021f8:	217a      	movs	r1, #122	; 0x7a
c0d021fa:	43c9      	mvns	r1, r1
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d021fc:	313a      	adds	r1, #58	; 0x3a
c0d021fe:	2240      	movs	r2, #64	; 0x40
c0d02200:	54a1      	strb	r1, [r4, r2]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02202:	3008      	adds	r0, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d02204:	61e0      	str	r0, [r4, #28]
c0d02206:	2000      	movs	r0, #0
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
c0d02208:	76a0      	strb	r0, [r4, #26]
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
c0d0220a:	82e0      	strh	r0, [r4, #22]
c0d0220c:	e05e      	b.n	c0d022cc <u2f_transport_received+0x10c>
c0d0220e:	9208      	str	r2, [sp, #32]
        }
        return;
    }
    
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
c0d02210:	2804      	cmp	r0, #4
c0d02212:	d109      	bne.n	c0d02228 <u2f_transport_received+0x68>
c0d02214:	202b      	movs	r0, #43	; 0x2b
c0d02216:	2100      	movs	r1, #0
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d02218:	5421      	strb	r1, [r4, r0]
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d0221a:	76a1      	strb	r1, [r4, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d0221c:	82e1      	strh	r1, [r4, #22]
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d0221e:	7029      	strb	r1, [r5, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d02220:	80b1      	strh	r1, [r6, #4]
c0d02222:	6031      	str	r1, [r6, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d02224:	68e0      	ldr	r0, [r4, #12]
c0d02226:	61e0      	str	r0, [r4, #28]
 * Function that process every message received on a media.
 * Performs message concatenation when message is splitted.
 */
void u2f_transport_received(u2f_service_t *service, uint8_t *buffer,
                          uint16_t size, u2f_transport_media_t media) {
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
c0d02228:	1e58      	subs	r0, r3, #1
c0d0222a:	461a      	mov	r2, r3
c0d0222c:	2300      	movs	r3, #0
c0d0222e:	1a19      	subs	r1, r3, r0
c0d02230:	4141      	adcs	r1, r0
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
        u2f_transport_reset(service);
    }

    if (size < (1 + channelHeader)) {
c0d02232:	0088      	lsls	r0, r1, #2
c0d02234:	9007      	str	r0, [sp, #28]
c0d02236:	1c41      	adds	r1, r0, #1
c0d02238:	9808      	ldr	r0, [sp, #32]
c0d0223a:	4281      	cmp	r1, r0
c0d0223c:	d838      	bhi.n	c0d022b0 <u2f_transport_received+0xf0>
c0d0223e:	9104      	str	r1, [sp, #16]
c0d02240:	9206      	str	r2, [sp, #24]
        // Message to short, abort
        u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
        goto error;
    }
    if (media == U2F_MEDIA_USB) {
c0d02242:	2a01      	cmp	r2, #1
c0d02244:	9305      	str	r3, [sp, #20]
c0d02246:	d105      	bne.n	c0d02254 <u2f_transport_received+0x94>
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
c0d02248:	1d20      	adds	r0, r4, #4
c0d0224a:	2204      	movs	r2, #4
c0d0224c:	4639      	mov	r1, r7
c0d0224e:	f7fe fc31 	bl	c0d00ab4 <os_memmove>
c0d02252:	9b05      	ldr	r3, [sp, #20]
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d02254:	8ae0      	ldrh	r0, [r4, #22]
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
c0d02256:	2800      	cmp	r0, #0
c0d02258:	d00b      	beq.n	c0d02272 <u2f_transport_received+0xb2>
c0d0225a:	9806      	ldr	r0, [sp, #24]
c0d0225c:	2801      	cmp	r0, #1
c0d0225e:	d121      	bne.n	c0d022a4 <u2f_transport_received+0xe4>
c0d02260:	4620      	mov	r0, r4
c0d02262:	3012      	adds	r0, #18
c0d02264:	1d21      	adds	r1, r4, #4
c0d02266:	2204      	movs	r2, #4
c0d02268:	f7fe fc43 	bl	c0d00af2 <os_memcmp>
c0d0226c:	9b05      	ldr	r3, [sp, #20]
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d0226e:	2800      	cmp	r0, #0
c0d02270:	d018      	beq.n	c0d022a4 <u2f_transport_received+0xe4>
c0d02272:	2503      	movs	r5, #3
c0d02274:	9a07      	ldr	r2, [sp, #28]
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
        if (size < (channelHeader + 3)) {
c0d02276:	4610      	mov	r0, r2
c0d02278:	4328      	orrs	r0, r5
c0d0227a:	9908      	ldr	r1, [sp, #32]
c0d0227c:	4288      	cmp	r0, r1
c0d0227e:	d817      	bhi.n	c0d022b0 <u2f_transport_received+0xf0>
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        // check this is a command, cannot accept continuation without previous command
        if ((buffer[channelHeader+0]&U2F_MASK_COMMAND) == 0) {
c0d02280:	18b8      	adds	r0, r7, r2
c0d02282:	9003      	str	r0, [sp, #12]
c0d02284:	56b8      	ldrsb	r0, [r7, r2]
c0d02286:	217a      	movs	r1, #122	; 0x7a
c0d02288:	43c9      	mvns	r1, r1
c0d0228a:	317a      	adds	r1, #122	; 0x7a
c0d0228c:	b249      	sxtb	r1, r1
c0d0228e:	2285      	movs	r2, #133	; 0x85
c0d02290:	4288      	cmp	r0, r1
c0d02292:	dd3f      	ble.n	c0d02314 <u2f_transport_received+0x154>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02294:	48ae      	ldr	r0, [pc, #696]	; (c0d02550 <u2f_transport_received+0x390>)
c0d02296:	2104      	movs	r1, #4
c0d02298:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d0229a:	7031      	strb	r1, [r6, #0]
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d0229c:	323a      	adds	r2, #58	; 0x3a
c0d0229e:	2140      	movs	r1, #64	; 0x40
c0d022a0:	5462      	strb	r2, [r4, r1]
c0d022a2:	e00f      	b.n	c0d022c4 <u2f_transport_received+0x104>
c0d022a4:	2002      	movs	r0, #2
c0d022a6:	9a07      	ldr	r2, [sp, #28]
            service->transportPacketIndex = 0;
            os_memmove(service->transportChannel, service->channel, 4);
        }
    } else {
        // Continuation
        if (size < (channelHeader + 2)) {
c0d022a8:	4310      	orrs	r0, r2
c0d022aa:	9908      	ldr	r1, [sp, #32]
c0d022ac:	4288      	cmp	r0, r1
c0d022ae:	d915      	bls.n	c0d022dc <u2f_transport_received+0x11c>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d022b0:	48a7      	ldr	r0, [pc, #668]	; (c0d02550 <u2f_transport_received+0x390>)
c0d022b2:	2185      	movs	r1, #133	; 0x85
c0d022b4:	7201      	strb	r1, [r0, #8]
c0d022b6:	2104      	movs	r1, #4

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d022b8:	7031      	strb	r1, [r6, #0]
c0d022ba:	217a      	movs	r1, #122	; 0x7a
c0d022bc:	43c9      	mvns	r1, r1
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d022be:	313a      	adds	r1, #58	; 0x3a
c0d022c0:	2240      	movs	r2, #64	; 0x40
c0d022c2:	54a1      	strb	r1, [r4, r2]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d022c4:	3008      	adds	r0, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d022c6:	61e0      	str	r0, [r4, #28]
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
c0d022c8:	76a3      	strb	r3, [r4, #26]
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
c0d022ca:	82e3      	strh	r3, [r4, #22]
c0d022cc:	2001      	movs	r0, #1
    service->transportLength = 1;
c0d022ce:	8320      	strh	r0, [r4, #24]
    service->sendCmd = U2F_STATUS_ERROR;
    // pump the first message, with the reception media
    u2f_transport_sent(service, service->media);
c0d022d0:	7a21      	ldrb	r1, [r4, #8]
c0d022d2:	4620      	mov	r0, r4
c0d022d4:	f7ff fe1c 	bl	c0d01f10 <u2f_transport_sent>
        service->seqTimeout = 0;
        service->transportState = U2F_HANDLE_SEGMENTED;
    }
error:
    return;
}
c0d022d8:	b009      	add	sp, #36	; 0x24
c0d022da:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d022dc:	2021      	movs	r0, #33	; 0x21
        if (size < (channelHeader + 2)) {
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        if (media != service->transportMedia) {
c0d022de:	5c20      	ldrb	r0, [r4, r0]
c0d022e0:	9906      	ldr	r1, [sp, #24]
c0d022e2:	4288      	cmp	r0, r1
c0d022e4:	d149      	bne.n	c0d0237a <u2f_transport_received+0x1ba>
            // Mixed medias
            u2f_transport_error(service, ERROR_PROP_MEDIA_MIXED);
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
c0d022e6:	7830      	ldrb	r0, [r6, #0]
c0d022e8:	2801      	cmp	r0, #1
c0d022ea:	d154      	bne.n	c0d02396 <u2f_transport_received+0x1d6>
            } else {
                u2f_transport_error(service, ERROR_INVALID_SEQ);
                goto error;
            }
        }
        if (media == U2F_MEDIA_USB) {
c0d022ec:	9806      	ldr	r0, [sp, #24]
c0d022ee:	2801      	cmp	r0, #1
c0d022f0:	d000      	beq.n	c0d022f4 <u2f_transport_received+0x134>
c0d022f2:	e080      	b.n	c0d023f6 <u2f_transport_received+0x236>
            // Check the channel
            if (os_memcmp(buffer, service->channel, 4) != 0) {
c0d022f4:	1d21      	adds	r1, r4, #4
c0d022f6:	2204      	movs	r2, #4
c0d022f8:	4638      	mov	r0, r7
c0d022fa:	9203      	str	r2, [sp, #12]
c0d022fc:	461d      	mov	r5, r3
c0d022fe:	f7fe fbf8 	bl	c0d00af2 <os_memcmp>
c0d02302:	9a07      	ldr	r2, [sp, #28]
c0d02304:	462b      	mov	r3, r5
c0d02306:	2800      	cmp	r0, #0
c0d02308:	d075      	beq.n	c0d023f6 <u2f_transport_received+0x236>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d0230a:	4891      	ldr	r0, [pc, #580]	; (c0d02550 <u2f_transport_received+0x390>)
c0d0230c:	2106      	movs	r1, #6
c0d0230e:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02310:	9903      	ldr	r1, [sp, #12]
c0d02312:	e7d1      	b.n	c0d022b8 <u2f_transport_received+0xf8>
c0d02314:	9202      	str	r2, [sp, #8]
c0d02316:	9a06      	ldr	r2, [sp, #24]
            goto error;
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
c0d02318:	2a01      	cmp	r2, #1
c0d0231a:	d114      	bne.n	c0d02346 <u2f_transport_received+0x186>
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d0231c:	7830      	ldrb	r0, [r6, #0]
c0d0231e:	2801      	cmp	r0, #1
c0d02320:	d11d      	bne.n	c0d0235e <u2f_transport_received+0x19e>
                (os_memcmp(service->channel, service->transportChannel, 4) !=
c0d02322:	1d20      	adds	r0, r4, #4
c0d02324:	4621      	mov	r1, r4
c0d02326:	3112      	adds	r1, #18
c0d02328:	2204      	movs	r2, #4
c0d0232a:	9001      	str	r0, [sp, #4]
c0d0232c:	f7fe fbe1 	bl	c0d00af2 <os_memcmp>
c0d02330:	9a06      	ldr	r2, [sp, #24]
                 0) &&
c0d02332:	2800      	cmp	r0, #0
c0d02334:	d007      	beq.n	c0d02346 <u2f_transport_received+0x186>
                (buffer[channelHeader] != U2F_CMD_INIT)) {
c0d02336:	9803      	ldr	r0, [sp, #12]
c0d02338:	7800      	ldrb	r0, [r0, #0]
c0d0233a:	9902      	ldr	r1, [sp, #8]
c0d0233c:	1c49      	adds	r1, r1, #1
c0d0233e:	b2c9      	uxtb	r1, r1
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d02340:	4288      	cmp	r0, r1
c0d02342:	d000      	beq.n	c0d02346 <u2f_transport_received+0x186>
c0d02344:	e0ea      	b.n	c0d0251c <u2f_transport_received+0x35c>
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d02346:	7830      	ldrb	r0, [r6, #0]
c0d02348:	2801      	cmp	r0, #1
c0d0234a:	d108      	bne.n	c0d0235e <u2f_transport_received+0x19e>
            !((media == U2F_MEDIA_USB) &&
c0d0234c:	2a01      	cmp	r2, #1
c0d0234e:	d17e      	bne.n	c0d0244e <u2f_transport_received+0x28e>
              (buffer[channelHeader] == U2F_CMD_INIT))) {
c0d02350:	9803      	ldr	r0, [sp, #12]
c0d02352:	7800      	ldrb	r0, [r0, #0]
c0d02354:	9902      	ldr	r1, [sp, #8]
c0d02356:	1c49      	adds	r1, r1, #1
c0d02358:	b2c9      	uxtb	r1, r1
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d0235a:	4288      	cmp	r0, r1
c0d0235c:	d177      	bne.n	c0d0244e <u2f_transport_received+0x28e>
c0d0235e:	9904      	ldr	r1, [sp, #16]
            // Unexpected continuation at this stage, abort
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        // Check the length
        uint16_t commandLength = U2BE(buffer, channelHeader + 1);
c0d02360:	1878      	adds	r0, r7, r1
c0d02362:	7840      	ldrb	r0, [r0, #1]
c0d02364:	5c79      	ldrb	r1, [r7, r1]
c0d02366:	0209      	lsls	r1, r1, #8
c0d02368:	180f      	adds	r7, r1, r0
        if (commandLength > (service->transportReceiveBufferLength - 3)) {
c0d0236a:	8a20      	ldrh	r0, [r4, #16]
c0d0236c:	1ec0      	subs	r0, r0, #3
c0d0236e:	4287      	cmp	r7, r0
c0d02370:	dd1f      	ble.n	c0d023b2 <u2f_transport_received+0x1f2>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02372:	4877      	ldr	r0, [pc, #476]	; (c0d02550 <u2f_transport_received+0x390>)
c0d02374:	7205      	strb	r5, [r0, #8]
c0d02376:	2104      	movs	r1, #4
c0d02378:	e06c      	b.n	c0d02454 <u2f_transport_received+0x294>
c0d0237a:	207a      	movs	r0, #122	; 0x7a
c0d0237c:	43c0      	mvns	r0, r0
c0d0237e:	4601      	mov	r1, r0
c0d02380:	3108      	adds	r1, #8
c0d02382:	4a73      	ldr	r2, [pc, #460]	; (c0d02550 <u2f_transport_received+0x390>)
c0d02384:	7211      	strb	r1, [r2, #8]
c0d02386:	2104      	movs	r1, #4

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02388:	7031      	strb	r1, [r6, #0]
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d0238a:	303a      	adds	r0, #58	; 0x3a
c0d0238c:	2140      	movs	r1, #64	; 0x40
c0d0238e:	5460      	strb	r0, [r4, r1]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02390:	3208      	adds	r2, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d02392:	61e2      	str	r2, [r4, #28]
c0d02394:	e798      	b.n	c0d022c8 <u2f_transport_received+0x108>
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
            // Unexpected continuation at this stage, abort
            // TODO : review the behavior is HID only
            if (media == U2F_MEDIA_USB) {
c0d02396:	9806      	ldr	r0, [sp, #24]
c0d02398:	2801      	cmp	r0, #1
c0d0239a:	d154      	bne.n	c0d02446 <u2f_transport_received+0x286>
c0d0239c:	202b      	movs	r0, #43	; 0x2b
c0d0239e:	2100      	movs	r1, #0
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d023a0:	5421      	strb	r1, [r4, r0]
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d023a2:	76a1      	strb	r1, [r4, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d023a4:	82e1      	strh	r1, [r4, #22]
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d023a6:	7029      	strb	r1, [r5, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d023a8:	80b1      	strh	r1, [r6, #4]
c0d023aa:	6031      	str	r1, [r6, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d023ac:	68e0      	ldr	r0, [r4, #12]
c0d023ae:	61e0      	str	r0, [r4, #28]
c0d023b0:	e792      	b.n	c0d022d8 <u2f_transport_received+0x118>
            // Overflow in message size, abort
            u2f_transport_error(service, ERROR_INVALID_LEN);
            goto error;
        }
        // Check if the command is supported
        switch (buffer[channelHeader]) {
c0d023b2:	9803      	ldr	r0, [sp, #12]
c0d023b4:	7800      	ldrb	r0, [r0, #0]
c0d023b6:	2881      	cmp	r0, #129	; 0x81
c0d023b8:	d004      	beq.n	c0d023c4 <u2f_transport_received+0x204>
c0d023ba:	2886      	cmp	r0, #134	; 0x86
c0d023bc:	d053      	beq.n	c0d02466 <u2f_transport_received+0x2a6>
c0d023be:	2883      	cmp	r0, #131	; 0x83
c0d023c0:	d000      	beq.n	c0d023c4 <u2f_transport_received+0x204>
c0d023c2:	e095      	b.n	c0d024f0 <u2f_transport_received+0x330>
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
c0d023c4:	2a01      	cmp	r2, #1
c0d023c6:	d159      	bne.n	c0d0247c <u2f_transport_received+0x2bc>
                if (u2f_is_channel_broadcast(service->channel) ||
c0d023c8:	1d25      	adds	r5, r4, #4
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d023ca:	4962      	ldr	r1, [pc, #392]	; (c0d02554 <u2f_transport_received+0x394>)
c0d023cc:	4479      	add	r1, pc
c0d023ce:	2204      	movs	r2, #4
c0d023d0:	4628      	mov	r0, r5
c0d023d2:	9204      	str	r2, [sp, #16]
c0d023d4:	f7fe fb8d 	bl	c0d00af2 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d023d8:	2800      	cmp	r0, #0
c0d023da:	d007      	beq.n	c0d023ec <u2f_transport_received+0x22c>
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d023dc:	495e      	ldr	r1, [pc, #376]	; (c0d02558 <u2f_transport_received+0x398>)
c0d023de:	4479      	add	r1, pc
c0d023e0:	2204      	movs	r2, #4
c0d023e2:	4628      	mov	r0, r5
c0d023e4:	f7fe fb85 	bl	c0d00af2 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d023e8:	2800      	cmp	r0, #0
c0d023ea:	d147      	bne.n	c0d0247c <u2f_transport_received+0x2bc>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d023ec:	4858      	ldr	r0, [pc, #352]	; (c0d02550 <u2f_transport_received+0x390>)
c0d023ee:	210b      	movs	r1, #11
c0d023f0:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d023f2:	9904      	ldr	r1, [sp, #16]
c0d023f4:	e02e      	b.n	c0d02454 <u2f_transport_received+0x294>
                u2f_transport_error(service, ERROR_CHANNEL_BUSY);
                goto error;
            }
        }
        // also discriminate invalid command sent instead of a continuation
        if (buffer[channelHeader] != service->transportPacketIndex) {
c0d023f6:	18b9      	adds	r1, r7, r2
c0d023f8:	5cb8      	ldrb	r0, [r7, r2]
c0d023fa:	7ea2      	ldrb	r2, [r4, #26]
c0d023fc:	4290      	cmp	r0, r2
c0d023fe:	d122      	bne.n	c0d02446 <u2f_transport_received+0x286>
            // Bad continuation packet, abort
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        xfer_len = MIN(size - (channelHeader + 1), service->transportLength - service->transportOffset);
c0d02400:	9808      	ldr	r0, [sp, #32]
c0d02402:	9a04      	ldr	r2, [sp, #16]
c0d02404:	1a85      	subs	r5, r0, r2
c0d02406:	8ae0      	ldrh	r0, [r4, #22]
c0d02408:	8b22      	ldrh	r2, [r4, #24]
c0d0240a:	1a12      	subs	r2, r2, r0
c0d0240c:	4295      	cmp	r5, r2
c0d0240e:	db00      	blt.n	c0d02412 <u2f_transport_received+0x252>
c0d02410:	4615      	mov	r5, r2
        os_memmove(service->transportBuffer + service->transportOffset, buffer + channelHeader + 1, xfer_len);
c0d02412:	b2af      	uxth	r7, r5
c0d02414:	69e2      	ldr	r2, [r4, #28]
c0d02416:	1810      	adds	r0, r2, r0
c0d02418:	1c49      	adds	r1, r1, #1
c0d0241a:	463a      	mov	r2, r7
c0d0241c:	f7fe fb4a 	bl	c0d00ab4 <os_memmove>
c0d02420:	9906      	ldr	r1, [sp, #24]
        if (media == U2F_MEDIA_USB) {
c0d02422:	2901      	cmp	r1, #1
c0d02424:	d108      	bne.n	c0d02438 <u2f_transport_received+0x278>
            service->commandCrc = cx_crc16_update(service->commandCrc, service->transportBuffer + service->transportOffset, xfer_len);
c0d02426:	8ae0      	ldrh	r0, [r4, #22]
c0d02428:	69e1      	ldr	r1, [r4, #28]
c0d0242a:	1809      	adds	r1, r1, r0
c0d0242c:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d0242e:	463a      	mov	r2, r7
c0d02430:	f7ff fb32 	bl	c0d01a98 <cx_crc16_update>
c0d02434:	9906      	ldr	r1, [sp, #24]
c0d02436:	84e0      	strh	r0, [r4, #38]	; 0x26
        }        
        service->transportOffset += xfer_len;
c0d02438:	8ae0      	ldrh	r0, [r4, #22]
c0d0243a:	1940      	adds	r0, r0, r5
c0d0243c:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d0243e:	7ea0      	ldrb	r0, [r4, #26]
c0d02440:	1c40      	adds	r0, r0, #1
c0d02442:	76a0      	strb	r0, [r4, #26]
c0d02444:	e040      	b.n	c0d024c8 <u2f_transport_received+0x308>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02446:	4842      	ldr	r0, [pc, #264]	; (c0d02550 <u2f_transport_received+0x390>)
c0d02448:	2104      	movs	r1, #4
c0d0244a:	7201      	strb	r1, [r0, #8]
c0d0244c:	e734      	b.n	c0d022b8 <u2f_transport_received+0xf8>
c0d0244e:	4840      	ldr	r0, [pc, #256]	; (c0d02550 <u2f_transport_received+0x390>)
c0d02450:	2104      	movs	r1, #4
c0d02452:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02454:	7031      	strb	r1, [r6, #0]
c0d02456:	9a02      	ldr	r2, [sp, #8]
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d02458:	323a      	adds	r2, #58	; 0x3a
c0d0245a:	2140      	movs	r1, #64	; 0x40
c0d0245c:	5462      	strb	r2, [r4, r1]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d0245e:	3008      	adds	r0, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d02460:	61e0      	str	r0, [r4, #28]
c0d02462:	9805      	ldr	r0, [sp, #20]
c0d02464:	e6d0      	b.n	c0d02208 <u2f_transport_received+0x48>
                }
            }
            // no channel for BLE
            break;
        case U2F_CMD_INIT:
            if (media != U2F_MEDIA_USB) {
c0d02466:	2a01      	cmp	r2, #1
c0d02468:	d142      	bne.n	c0d024f0 <u2f_transport_received+0x330>
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d0246a:	1d20      	adds	r0, r4, #4
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d0246c:	493b      	ldr	r1, [pc, #236]	; (c0d0255c <u2f_transport_received+0x39c>)
c0d0246e:	4479      	add	r1, pc
c0d02470:	2504      	movs	r5, #4
c0d02472:	462a      	mov	r2, r5
c0d02474:	f7fe fb3d 	bl	c0d00af2 <os_memcmp>
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d02478:	2800      	cmp	r0, #0
c0d0247a:	d063      	beq.n	c0d02544 <u2f_transport_received+0x384>
        }

        // Ok, initialize the buffer
        //if (buffer[channelHeader] != U2F_CMD_INIT) 
        {
            xfer_len = MIN(size - (channelHeader), U2F_COMMAND_HEADER_SIZE+commandLength);
c0d0247c:	9808      	ldr	r0, [sp, #32]
c0d0247e:	9907      	ldr	r1, [sp, #28]
c0d02480:	1a45      	subs	r5, r0, r1
c0d02482:	1cf8      	adds	r0, r7, #3
c0d02484:	4285      	cmp	r5, r0
c0d02486:	db00      	blt.n	c0d0248a <u2f_transport_received+0x2ca>
c0d02488:	4605      	mov	r5, r0
c0d0248a:	9008      	str	r0, [sp, #32]
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
c0d0248c:	b2af      	uxth	r7, r5
c0d0248e:	69e0      	ldr	r0, [r4, #28]
c0d02490:	9903      	ldr	r1, [sp, #12]
c0d02492:	463a      	mov	r2, r7
c0d02494:	f7fe fb0e 	bl	c0d00ab4 <os_memmove>
c0d02498:	9906      	ldr	r1, [sp, #24]
            if (media == U2F_MEDIA_USB) {
c0d0249a:	2901      	cmp	r1, #1
c0d0249c:	d106      	bne.n	c0d024ac <u2f_transport_received+0x2ec>
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
c0d0249e:	69e1      	ldr	r1, [r4, #28]
c0d024a0:	2000      	movs	r0, #0
c0d024a2:	463a      	mov	r2, r7
c0d024a4:	f7ff faf8 	bl	c0d01a98 <cx_crc16_update>
c0d024a8:	9906      	ldr	r1, [sp, #24]
c0d024aa:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d024ac:	2021      	movs	r0, #33	; 0x21
            }
            service->transportOffset = xfer_len;
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
            service->transportMedia = media;
c0d024ae:	5421      	strb	r1, [r4, r0]
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
            if (media == U2F_MEDIA_USB) {
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
            }
            service->transportOffset = xfer_len;
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
c0d024b0:	9808      	ldr	r0, [sp, #32]
c0d024b2:	8320      	strh	r0, [r4, #24]
            xfer_len = MIN(size - (channelHeader), U2F_COMMAND_HEADER_SIZE+commandLength);
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
            if (media == U2F_MEDIA_USB) {
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
            }
            service->transportOffset = xfer_len;
c0d024b4:	82e5      	strh	r5, [r4, #22]
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
            service->transportMedia = media;
            // initialize the response
            service->transportPacketIndex = 0;
c0d024b6:	9805      	ldr	r0, [sp, #20]
c0d024b8:	76a0      	strb	r0, [r4, #26]
            os_memmove(service->transportChannel, service->channel, 4);
c0d024ba:	4620      	mov	r0, r4
c0d024bc:	3012      	adds	r0, #18
c0d024be:	1d21      	adds	r1, r4, #4
c0d024c0:	2204      	movs	r2, #4
c0d024c2:	f7fe faf7 	bl	c0d00ab4 <os_memmove>
c0d024c6:	9906      	ldr	r1, [sp, #24]
c0d024c8:	8ae0      	ldrh	r0, [r4, #22]
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d024ca:	2901      	cmp	r1, #1
c0d024cc:	d102      	bne.n	c0d024d4 <u2f_transport_received+0x314>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
c0d024ce:	8b21      	ldrh	r1, [r4, #24]
c0d024d0:	9b05      	ldr	r3, [sp, #20]
c0d024d2:	e007      	b.n	c0d024e4 <u2f_transport_received+0x324>
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
c0d024d4:	8b21      	ldrh	r1, [r4, #24]
c0d024d6:	1cca      	adds	r2, r1, #3
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d024d8:	4282      	cmp	r2, r0
c0d024da:	9b05      	ldr	r3, [sp, #20]
c0d024dc:	d202      	bcs.n	c0d024e4 <u2f_transport_received+0x324>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d024de:	481c      	ldr	r0, [pc, #112]	; (c0d02550 <u2f_transport_received+0x390>)
c0d024e0:	2103      	movs	r1, #3
c0d024e2:	e6e7      	b.n	c0d022b4 <u2f_transport_received+0xf4>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
c0d024e4:	4288      	cmp	r0, r1
c0d024e6:	d213      	bcs.n	c0d02510 <u2f_transport_received+0x350>
        service->transportState = U2F_PROCESSING_COMMAND;
        // internal notification of a complete message received
        u2f_message_complete(service);
    } else {
        // new segment received, reset the timeout for the current piece
        service->seqTimeout = 0;
c0d024e8:	6363      	str	r3, [r4, #52]	; 0x34
c0d024ea:	2001      	movs	r0, #1
        service->transportState = U2F_HANDLE_SEGMENTED;
c0d024ec:	7030      	strb	r0, [r6, #0]
c0d024ee:	e6f3      	b.n	c0d022d8 <u2f_transport_received+0x118>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d024f0:	4817      	ldr	r0, [pc, #92]	; (c0d02550 <u2f_transport_received+0x390>)
c0d024f2:	2101      	movs	r1, #1
c0d024f4:	7201      	strb	r1, [r0, #8]
c0d024f6:	2204      	movs	r2, #4

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d024f8:	7032      	strb	r2, [r6, #0]
c0d024fa:	9b02      	ldr	r3, [sp, #8]
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d024fc:	333a      	adds	r3, #58	; 0x3a
c0d024fe:	2240      	movs	r2, #64	; 0x40
c0d02500:	54a3      	strb	r3, [r4, r2]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02502:	3008      	adds	r0, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d02504:	61e0      	str	r0, [r4, #28]
c0d02506:	2000      	movs	r0, #0
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
c0d02508:	76a0      	strb	r0, [r4, #26]
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
c0d0250a:	82e0      	strh	r0, [r4, #22]
    service->transportLength = 1;
c0d0250c:	8321      	strh	r1, [r4, #24]
c0d0250e:	e6df      	b.n	c0d022d0 <u2f_transport_received+0x110>
c0d02510:	2002      	movs	r0, #2
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
        // switch before the handler gets the opportunity to change it again
        service->transportState = U2F_PROCESSING_COMMAND;
c0d02512:	7030      	strb	r0, [r6, #0]
        // internal notification of a complete message received
        u2f_message_complete(service);
c0d02514:	4620      	mov	r0, r4
c0d02516:	f7ff fcb9 	bl	c0d01e8c <u2f_message_complete>
c0d0251a:	e6dd      	b.n	c0d022d8 <u2f_transport_received+0x118>
                // special error case, we reply but don't change the current state of the transport (ongoing message for example)
                //u2f_transport_error_no_reset(service, ERROR_CHANNEL_BUSY);
                uint16_t offset = 0;
                // Fragment
                if (media == U2F_MEDIA_USB) {
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d0251c:	4c0c      	ldr	r4, [pc, #48]	; (c0d02550 <u2f_transport_received+0x390>)
c0d0251e:	2204      	movs	r2, #4
c0d02520:	4620      	mov	r0, r4
c0d02522:	9901      	ldr	r1, [sp, #4]
c0d02524:	f7fe fac6 	bl	c0d00ab4 <os_memmove>
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
                G_io_usb_ep_buffer[offset++] = 0;
c0d02528:	9805      	ldr	r0, [sp, #20]
c0d0252a:	7160      	strb	r0, [r4, #5]
c0d0252c:	9802      	ldr	r0, [sp, #8]
                // Fragment
                if (media == U2F_MEDIA_USB) {
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
c0d0252e:	303a      	adds	r0, #58	; 0x3a
c0d02530:	7120      	strb	r0, [r4, #4]
c0d02532:	2201      	movs	r2, #1
                G_io_usb_ep_buffer[offset++] = 0;
                G_io_usb_ep_buffer[offset++] = 1;
c0d02534:	71a2      	strb	r2, [r4, #6]
c0d02536:	2006      	movs	r0, #6
                G_io_usb_ep_buffer[offset++] = ERROR_CHANNEL_BUSY;
c0d02538:	71e0      	strb	r0, [r4, #7]
c0d0253a:	2108      	movs	r1, #8
                u2f_io_send(G_io_usb_ep_buffer, offset, media);
c0d0253c:	4620      	mov	r0, r4
c0d0253e:	f7ff fcc3 	bl	c0d01ec8 <u2f_io_send>
c0d02542:	e6c9      	b.n	c0d022d8 <u2f_transport_received+0x118>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02544:	4802      	ldr	r0, [pc, #8]	; (c0d02550 <u2f_transport_received+0x390>)
c0d02546:	210b      	movs	r1, #11
c0d02548:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d0254a:	7035      	strb	r5, [r6, #0]
c0d0254c:	e783      	b.n	c0d02456 <u2f_transport_received+0x296>
c0d0254e:	46c0      	nop			; (mov r8, r8)
c0d02550:	20001c4c 	.word	0x20001c4c
c0d02554:	00002782 	.word	0x00002782
c0d02558:	00002774 	.word	0x00002774
c0d0255c:	000026e4 	.word	0x000026e4

c0d02560 <u2f_is_channel_broadcast>:
    }
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
c0d02560:	b580      	push	{r7, lr}
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d02562:	4904      	ldr	r1, [pc, #16]	; (c0d02574 <u2f_is_channel_broadcast+0x14>)
c0d02564:	4479      	add	r1, pc
c0d02566:	2204      	movs	r2, #4
c0d02568:	f7fe fac3 	bl	c0d00af2 <os_memcmp>
c0d0256c:	2100      	movs	r1, #0
c0d0256e:	1a09      	subs	r1, r1, r0
c0d02570:	4148      	adcs	r0, r1
c0d02572:	bd80      	pop	{r7, pc}
c0d02574:	000025ea 	.word	0x000025ea

c0d02578 <u2f_message_set_autoreply_wait_user_presence>:
}

/**
 * Auto reply hodl until the real reply is prepared and sent
 */
void u2f_message_set_autoreply_wait_user_presence(u2f_service_t* service, bool enabled) {
c0d02578:	b580      	push	{r7, lr}
c0d0257a:	222a      	movs	r2, #42	; 0x2a
c0d0257c:	5c83      	ldrb	r3, [r0, r2]
c0d0257e:	4602      	mov	r2, r0
c0d02580:	322a      	adds	r2, #42	; 0x2a

    if (enabled) {
c0d02582:	2900      	cmp	r1, #0
c0d02584:	d006      	beq.n	c0d02594 <u2f_message_set_autoreply_wait_user_presence+0x1c>
        // start replying placeholder until user presence validated
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE) {
c0d02586:	2b00      	cmp	r3, #0
c0d02588:	d108      	bne.n	c0d0259c <u2f_message_set_autoreply_wait_user_presence+0x24>
c0d0258a:	2101      	movs	r1, #1
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
c0d0258c:	7011      	strb	r1, [r2, #0]
            u2f_transport_send_usb_user_presence_required(service);
c0d0258e:	f7ff fd61 	bl	c0d02054 <u2f_transport_send_usb_user_presence_required>
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
    }
}
c0d02592:	bd80      	pop	{r7, pc}
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
            u2f_transport_send_usb_user_presence_required(service);
        }
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d02594:	2b01      	cmp	r3, #1
c0d02596:	d101      	bne.n	c0d0259c <u2f_message_set_autoreply_wait_user_presence+0x24>
c0d02598:	2002      	movs	r0, #2
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
c0d0259a:	7010      	strb	r0, [r2, #0]
    }
}
c0d0259c:	bd80      	pop	{r7, pc}
	...

c0d025a0 <u2f_message_reply>:
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
            && service->sending == false)
        ;
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {
c0d025a0:	b570      	push	{r4, r5, r6, lr}
c0d025a2:	4604      	mov	r4, r0
c0d025a4:	202a      	movs	r0, #42	; 0x2a

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d025a6:	5c20      	ldrb	r0, [r4, r0]
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d025a8:	2800      	cmp	r0, #0
c0d025aa:	d009      	beq.n	c0d025c0 <u2f_message_reply+0x20>
c0d025ac:	2801      	cmp	r0, #1
c0d025ae:	d024      	beq.n	c0d025fa <u2f_message_reply+0x5a>
c0d025b0:	2025      	movs	r0, #37	; 0x25
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d025b2:	5c20      	ldrb	r0, [r4, r0]
            && service->sending == false)
c0d025b4:	2806      	cmp	r0, #6
c0d025b6:	d120      	bne.n	c0d025fa <u2f_message_reply+0x5a>
c0d025b8:	202b      	movs	r0, #43	; 0x2b
c0d025ba:	5c20      	ldrb	r0, [r4, r0]
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {

    // if U2F is not ready to reply, then gently avoid replying
    if (u2f_message_repliable(service)) 
c0d025bc:	2800      	cmp	r0, #0
c0d025be:	d11c      	bne.n	c0d025fa <u2f_message_reply+0x5a>
c0d025c0:	2020      	movs	r0, #32
c0d025c2:	2503      	movs	r5, #3
    {
        service->transportState = U2F_SENDING_RESPONSE;
c0d025c4:	5425      	strb	r5, [r4, r0]
c0d025c6:	2040      	movs	r0, #64	; 0x40
        service->transportPacketIndex = 0;
        service->transportBuffer = buffer;
        service->transportOffset = 0;
        service->transportLength = len;
        service->sendCmd = cmd;
c0d025c8:	5421      	strb	r1, [r4, r0]
c0d025ca:	2000      	movs	r0, #0

    // if U2F is not ready to reply, then gently avoid replying
    if (u2f_message_repliable(service)) 
    {
        service->transportState = U2F_SENDING_RESPONSE;
        service->transportPacketIndex = 0;
c0d025cc:	76a0      	strb	r0, [r4, #26]
        service->transportBuffer = buffer;
c0d025ce:	61e2      	str	r2, [r4, #28]
        service->transportOffset = 0;
c0d025d0:	82e0      	strh	r0, [r4, #22]
        service->transportLength = len;
c0d025d2:	8323      	strh	r3, [r4, #24]
c0d025d4:	2021      	movs	r0, #33	; 0x21
        service->sendCmd = cmd;
        if (service->transportMedia != U2F_MEDIA_BLE) {
c0d025d6:	5c21      	ldrb	r1, [r4, r0]
c0d025d8:	4625      	mov	r5, r4
c0d025da:	3521      	adds	r5, #33	; 0x21
c0d025dc:	2903      	cmp	r1, #3
c0d025de:	d10d      	bne.n	c0d025fc <u2f_message_reply+0x5c>
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
        }
        else {
            while (G_io_app.apdu_state != APDU_IDLE) {
c0d025e0:	4e08      	ldr	r6, [pc, #32]	; (c0d02604 <u2f_message_reply+0x64>)
c0d025e2:	7830      	ldrb	r0, [r6, #0]
c0d025e4:	2800      	cmp	r0, #0
c0d025e6:	d008      	beq.n	c0d025fa <u2f_message_reply+0x5a>
c0d025e8:	2103      	movs	r1, #3
c0d025ea:	e000      	b.n	c0d025ee <u2f_message_reply+0x4e>
                u2f_transport_sent(service, service->transportMedia);       
c0d025ec:	7829      	ldrb	r1, [r5, #0]
c0d025ee:	4620      	mov	r0, r4
c0d025f0:	f7ff fc8e 	bl	c0d01f10 <u2f_transport_sent>
        if (service->transportMedia != U2F_MEDIA_BLE) {
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
        }
        else {
            while (G_io_app.apdu_state != APDU_IDLE) {
c0d025f4:	7830      	ldrb	r0, [r6, #0]
c0d025f6:	2800      	cmp	r0, #0
c0d025f8:	d1f8      	bne.n	c0d025ec <u2f_message_reply+0x4c>
                u2f_transport_sent(service, service->transportMedia);       
            }
        }
    }
}
c0d025fa:	bd70      	pop	{r4, r5, r6, pc}
        service->transportOffset = 0;
        service->transportLength = len;
        service->sendCmd = cmd;
        if (service->transportMedia != U2F_MEDIA_BLE) {
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
c0d025fc:	4620      	mov	r0, r4
c0d025fe:	f7ff fc87 	bl	c0d01f10 <u2f_transport_sent>
            while (G_io_app.apdu_state != APDU_IDLE) {
                u2f_transport_sent(service, service->transportMedia);       
            }
        }
    }
}
c0d02602:	bd70      	pop	{r4, r5, r6, pc}
c0d02604:	20001be0 	.word	0x20001be0

c0d02608 <USBD_LL_Init>:
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
  ep_out_stall = 0;
c0d02608:	4902      	ldr	r1, [pc, #8]	; (c0d02614 <USBD_LL_Init+0xc>)
c0d0260a:	2000      	movs	r0, #0
c0d0260c:	6008      	str	r0, [r1, #0]
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d0260e:	4902      	ldr	r1, [pc, #8]	; (c0d02618 <USBD_LL_Init+0x10>)
c0d02610:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
  return USBD_OK;
c0d02612:	4770      	bx	lr
c0d02614:	20001d24 	.word	0x20001d24
c0d02618:	20001d20 	.word	0x20001d20

c0d0261c <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d0261c:	b510      	push	{r4, lr}
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0261e:	4807      	ldr	r0, [pc, #28]	; (c0d0263c <USBD_LL_DeInit+0x20>)
c0d02620:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02622:	7044      	strb	r4, [r0, #1]
c0d02624:	214f      	movs	r1, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02626:	7001      	strb	r1, [r0, #0]
c0d02628:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d0262a:	7081      	strb	r1, [r0, #2]
c0d0262c:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0262e:	70c1      	strb	r1, [r0, #3]
c0d02630:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02632:	f7ff faaf 	bl	c0d01b94 <io_seph_send>

  return USBD_OK; 
c0d02636:	4620      	mov	r0, r4
c0d02638:	bd10      	pop	{r4, pc}
c0d0263a:	46c0      	nop			; (mov r8, r8)
c0d0263c:	20001a0c 	.word	0x20001a0c

c0d02640 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02640:	b570      	push	{r4, r5, r6, lr}
c0d02642:	b082      	sub	sp, #8
c0d02644:	466d      	mov	r5, sp
c0d02646:	2400      	movs	r4, #0
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02648:	706c      	strb	r4, [r5, #1]
c0d0264a:	264f      	movs	r6, #79	; 0x4f
{
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0264c:	702e      	strb	r6, [r5, #0]
c0d0264e:	2002      	movs	r0, #2
  buffer[1] = 0;
  buffer[2] = 2;
c0d02650:	70a8      	strb	r0, [r5, #2]
c0d02652:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02654:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d02656:	712c      	strb	r4, [r5, #4]
c0d02658:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(buffer, 5);
c0d0265a:	4628      	mov	r0, r5
c0d0265c:	f7ff fa9a 	bl	c0d01b94 <io_seph_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02660:	706c      	strb	r4, [r5, #1]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = 0;
  io_seproxyhal_spi_send(buffer, 5);
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02662:	702e      	strb	r6, [r5, #0]
c0d02664:	2001      	movs	r0, #1
  buffer[1] = 0;
  buffer[2] = 1;
c0d02666:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d02668:	70e8      	strb	r0, [r5, #3]
c0d0266a:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d0266c:	4628      	mov	r0, r5
c0d0266e:	f7ff fa91 	bl	c0d01b94 <io_seph_send>
  return USBD_OK; 
c0d02672:	4620      	mov	r0, r4
c0d02674:	b002      	add	sp, #8
c0d02676:	bd70      	pop	{r4, r5, r6, pc}

c0d02678 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d02678:	b510      	push	{r4, lr}
c0d0267a:	b082      	sub	sp, #8
c0d0267c:	a801      	add	r0, sp, #4
c0d0267e:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02680:	7044      	strb	r4, [r0, #1]
c0d02682:	214f      	movs	r1, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02684:	7001      	strb	r1, [r0, #0]
c0d02686:	2101      	movs	r1, #1
  buffer[1] = 0;
  buffer[2] = 1;
c0d02688:	7081      	strb	r1, [r0, #2]
c0d0268a:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0268c:	70c1      	strb	r1, [r0, #3]
c0d0268e:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d02690:	f7ff fa80 	bl	c0d01b94 <io_seph_send>
  return USBD_OK; 
c0d02694:	4620      	mov	r0, r4
c0d02696:	b002      	add	sp, #8
c0d02698:	bd10      	pop	{r4, pc}
	...

c0d0269c <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d0269c:	b5b0      	push	{r4, r5, r7, lr}
c0d0269e:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
  ep_out_stall = 0;
c0d026a0:	4814      	ldr	r0, [pc, #80]	; (c0d026f4 <USBD_LL_OpenEP+0x58>)
c0d026a2:	2400      	movs	r4, #0
c0d026a4:	6004      	str	r4, [r0, #0]
                                      uint16_t ep_mps)
{
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d026a6:	4814      	ldr	r0, [pc, #80]	; (c0d026f8 <USBD_LL_OpenEP+0x5c>)
c0d026a8:	6004      	str	r4, [r0, #0]
c0d026aa:	466d      	mov	r5, sp
c0d026ac:	204f      	movs	r0, #79	; 0x4f
  ep_out_stall = 0;

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d026ae:	7028      	strb	r0, [r5, #0]
  buffer[1] = 0;
c0d026b0:	706c      	strb	r4, [r5, #1]
c0d026b2:	2005      	movs	r0, #5
  buffer[2] = 5;
c0d026b4:	70a8      	strb	r0, [r5, #2]
c0d026b6:	2004      	movs	r0, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d026b8:	70e8      	strb	r0, [r5, #3]
c0d026ba:	2001      	movs	r0, #1
  buffer[4] = 1;
c0d026bc:	7128      	strb	r0, [r5, #4]
  buffer[5] = ep_addr;
c0d026be:	7169      	strb	r1, [r5, #5]
  buffer[6] = 0;
c0d026c0:	71ac      	strb	r4, [r5, #6]
  switch(ep_type) {
c0d026c2:	2a01      	cmp	r2, #1
c0d026c4:	dc05      	bgt.n	c0d026d2 <USBD_LL_OpenEP+0x36>
c0d026c6:	2a00      	cmp	r2, #0
c0d026c8:	d00a      	beq.n	c0d026e0 <USBD_LL_OpenEP+0x44>
c0d026ca:	2a01      	cmp	r2, #1
c0d026cc:	d10a      	bne.n	c0d026e4 <USBD_LL_OpenEP+0x48>
c0d026ce:	2004      	movs	r0, #4
c0d026d0:	e006      	b.n	c0d026e0 <USBD_LL_OpenEP+0x44>
c0d026d2:	2a02      	cmp	r2, #2
c0d026d4:	d003      	beq.n	c0d026de <USBD_LL_OpenEP+0x42>
c0d026d6:	2a03      	cmp	r2, #3
c0d026d8:	d104      	bne.n	c0d026e4 <USBD_LL_OpenEP+0x48>
c0d026da:	2002      	movs	r0, #2
c0d026dc:	e000      	b.n	c0d026e0 <USBD_LL_OpenEP+0x44>
c0d026de:	2003      	movs	r0, #3
c0d026e0:	4669      	mov	r1, sp
c0d026e2:	7188      	strb	r0, [r1, #6]
c0d026e4:	4668      	mov	r0, sp
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d026e6:	71c3      	strb	r3, [r0, #7]
c0d026e8:	2108      	movs	r1, #8
  io_seproxyhal_spi_send(buffer, 8);
c0d026ea:	f7ff fa53 	bl	c0d01b94 <io_seph_send>
c0d026ee:	2000      	movs	r0, #0
  return USBD_OK; 
c0d026f0:	b002      	add	sp, #8
c0d026f2:	bdb0      	pop	{r4, r5, r7, pc}
c0d026f4:	20001d24 	.word	0x20001d24
c0d026f8:	20001d20 	.word	0x20001d20

c0d026fc <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d026fc:	b510      	push	{r4, lr}
c0d026fe:	b082      	sub	sp, #8
c0d02700:	4668      	mov	r0, sp
c0d02702:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02704:	7044      	strb	r4, [r0, #1]
c0d02706:	224f      	movs	r2, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02708:	7002      	strb	r2, [r0, #0]
c0d0270a:	2205      	movs	r2, #5
  buffer[1] = 0;
  buffer[2] = 5;
c0d0270c:	7082      	strb	r2, [r0, #2]
c0d0270e:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02710:	70c2      	strb	r2, [r0, #3]
c0d02712:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d02714:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d02716:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02718:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d0271a:	71c4      	strb	r4, [r0, #7]
c0d0271c:	2108      	movs	r1, #8
  io_seproxyhal_spi_send(buffer, 8);
c0d0271e:	f7ff fa39 	bl	c0d01b94 <io_seph_send>
  return USBD_OK; 
c0d02722:	4620      	mov	r0, r4
c0d02724:	b002      	add	sp, #8
c0d02726:	bd10      	pop	{r4, pc}

c0d02728 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02728:	b5b0      	push	{r4, r5, r7, lr}
c0d0272a:	b082      	sub	sp, #8
c0d0272c:	460d      	mov	r5, r1
c0d0272e:	4668      	mov	r0, sp
c0d02730:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
c0d02732:	7044      	strb	r4, [r0, #1]
c0d02734:	2150      	movs	r1, #80	; 0x50
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02736:	7001      	strb	r1, [r0, #0]
c0d02738:	2103      	movs	r1, #3
  buffer[1] = 0;
  buffer[2] = 3;
c0d0273a:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d0273c:	70c5      	strb	r5, [r0, #3]
c0d0273e:	2140      	movs	r1, #64	; 0x40
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02740:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d02742:	7144      	strb	r4, [r0, #5]
c0d02744:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d02746:	f7ff fa25 	bl	c0d01b94 <io_seph_send>
  if (ep_addr & 0x80) {
c0d0274a:	0628      	lsls	r0, r5, #24
c0d0274c:	d501      	bpl.n	c0d02752 <USBD_LL_StallEP+0x2a>
c0d0274e:	4807      	ldr	r0, [pc, #28]	; (c0d0276c <USBD_LL_StallEP+0x44>)
c0d02750:	e000      	b.n	c0d02754 <USBD_LL_StallEP+0x2c>
c0d02752:	4805      	ldr	r0, [pc, #20]	; (c0d02768 <USBD_LL_StallEP+0x40>)
c0d02754:	6801      	ldr	r1, [r0, #0]
c0d02756:	227f      	movs	r2, #127	; 0x7f
c0d02758:	4015      	ands	r5, r2
c0d0275a:	2201      	movs	r2, #1
c0d0275c:	40aa      	lsls	r2, r5
c0d0275e:	430a      	orrs	r2, r1
c0d02760:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02762:	4620      	mov	r0, r4
c0d02764:	b002      	add	sp, #8
c0d02766:	bdb0      	pop	{r4, r5, r7, pc}
c0d02768:	20001d24 	.word	0x20001d24
c0d0276c:	20001d20 	.word	0x20001d20

c0d02770 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02770:	b5b0      	push	{r4, r5, r7, lr}
c0d02772:	b082      	sub	sp, #8
c0d02774:	460d      	mov	r5, r1
c0d02776:	4668      	mov	r0, sp
c0d02778:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
c0d0277a:	7044      	strb	r4, [r0, #1]
c0d0277c:	2150      	movs	r1, #80	; 0x50
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0277e:	7001      	strb	r1, [r0, #0]
c0d02780:	2103      	movs	r1, #3
  buffer[1] = 0;
  buffer[2] = 3;
c0d02782:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d02784:	70c5      	strb	r5, [r0, #3]
c0d02786:	2180      	movs	r1, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d02788:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d0278a:	7144      	strb	r4, [r0, #5]
c0d0278c:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d0278e:	f7ff fa01 	bl	c0d01b94 <io_seph_send>
  if (ep_addr & 0x80) {
c0d02792:	0628      	lsls	r0, r5, #24
c0d02794:	d501      	bpl.n	c0d0279a <USBD_LL_ClearStallEP+0x2a>
c0d02796:	4807      	ldr	r0, [pc, #28]	; (c0d027b4 <USBD_LL_ClearStallEP+0x44>)
c0d02798:	e000      	b.n	c0d0279c <USBD_LL_ClearStallEP+0x2c>
c0d0279a:	4805      	ldr	r0, [pc, #20]	; (c0d027b0 <USBD_LL_ClearStallEP+0x40>)
c0d0279c:	6801      	ldr	r1, [r0, #0]
c0d0279e:	227f      	movs	r2, #127	; 0x7f
c0d027a0:	4015      	ands	r5, r2
c0d027a2:	2201      	movs	r2, #1
c0d027a4:	40aa      	lsls	r2, r5
c0d027a6:	4391      	bics	r1, r2
c0d027a8:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d027aa:	4620      	mov	r0, r4
c0d027ac:	b002      	add	sp, #8
c0d027ae:	bdb0      	pop	{r4, r5, r7, pc}
c0d027b0:	20001d24 	.word	0x20001d24
c0d027b4:	20001d20 	.word	0x20001d20

c0d027b8 <USBD_LL_IsStallEP>:
c0d027b8:	0608      	lsls	r0, r1, #24
c0d027ba:	d501      	bpl.n	c0d027c0 <USBD_LL_IsStallEP+0x8>
c0d027bc:	4805      	ldr	r0, [pc, #20]	; (c0d027d4 <USBD_LL_IsStallEP+0x1c>)
c0d027be:	e000      	b.n	c0d027c2 <USBD_LL_IsStallEP+0xa>
c0d027c0:	4803      	ldr	r0, [pc, #12]	; (c0d027d0 <USBD_LL_IsStallEP+0x18>)
c0d027c2:	7802      	ldrb	r2, [r0, #0]
c0d027c4:	207f      	movs	r0, #127	; 0x7f
c0d027c6:	4001      	ands	r1, r0
c0d027c8:	2001      	movs	r0, #1
c0d027ca:	4088      	lsls	r0, r1
c0d027cc:	4010      	ands	r0, r2
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d027ce:	4770      	bx	lr
c0d027d0:	20001d24 	.word	0x20001d24
c0d027d4:	20001d20 	.word	0x20001d20

c0d027d8 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d027d8:	b510      	push	{r4, lr}
c0d027da:	b082      	sub	sp, #8
c0d027dc:	4668      	mov	r0, sp
c0d027de:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d027e0:	7044      	strb	r4, [r0, #1]
c0d027e2:	224f      	movs	r2, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d027e4:	7002      	strb	r2, [r0, #0]
c0d027e6:	2202      	movs	r2, #2
  buffer[1] = 0;
  buffer[2] = 2;
c0d027e8:	7082      	strb	r2, [r0, #2]
c0d027ea:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d027ec:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d027ee:	7101      	strb	r1, [r0, #4]
c0d027f0:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(buffer, 5);
c0d027f2:	f7ff f9cf 	bl	c0d01b94 <io_seph_send>
  return USBD_OK; 
c0d027f6:	4620      	mov	r0, r4
c0d027f8:	b002      	add	sp, #8
c0d027fa:	bd10      	pop	{r4, pc}

c0d027fc <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d027fc:	b5b0      	push	{r4, r5, r7, lr}
c0d027fe:	b082      	sub	sp, #8
c0d02800:	461c      	mov	r4, r3
c0d02802:	4615      	mov	r5, r2
c0d02804:	4668      	mov	r0, sp
c0d02806:	2250      	movs	r2, #80	; 0x50
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02808:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
c0d0280a:	70c1      	strb	r1, [r0, #3]
c0d0280c:	2120      	movs	r1, #32
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0280e:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02810:	7143      	strb	r3, [r0, #5]
                                      uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
c0d02812:	1cd9      	adds	r1, r3, #3
  buffer[2] = (3+size);
c0d02814:	7081      	strb	r1, [r0, #2]
                                      uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
c0d02816:	0a09      	lsrs	r1, r1, #8
c0d02818:	7041      	strb	r1, [r0, #1]
c0d0281a:	2106      	movs	r1, #6
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  buffer[5] = size;
  io_seproxyhal_spi_send(buffer, 6);
c0d0281c:	f7ff f9ba 	bl	c0d01b94 <io_seph_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02820:	4628      	mov	r0, r5
c0d02822:	4621      	mov	r1, r4
c0d02824:	f7ff f9b6 	bl	c0d01b94 <io_seph_send>
c0d02828:	2000      	movs	r0, #0
  return USBD_OK;   
c0d0282a:	b002      	add	sp, #8
c0d0282c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0282e <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d0282e:	b510      	push	{r4, lr}
c0d02830:	b082      	sub	sp, #8
c0d02832:	4668      	mov	r0, sp
c0d02834:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3/*+size*/)>>8;
c0d02836:	7044      	strb	r4, [r0, #1]
c0d02838:	2350      	movs	r3, #80	; 0x50
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0283a:	7003      	strb	r3, [r0, #0]
c0d0283c:	2303      	movs	r3, #3
  buffer[1] = (3/*+size*/)>>8;
  buffer[2] = (3/*+size*/);
c0d0283e:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d02840:	70c1      	strb	r1, [r0, #3]
c0d02842:	2130      	movs	r1, #48	; 0x30
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02844:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d02846:	7142      	strb	r2, [r0, #5]
c0d02848:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d0284a:	f7ff f9a3 	bl	c0d01b94 <io_seph_send>
  return USBD_OK;   
c0d0284e:	4620      	mov	r0, r4
c0d02850:	b002      	add	sp, #8
c0d02852:	bd10      	pop	{r4, pc}

c0d02854 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02854:	b570      	push	{r4, r5, r6, lr}
c0d02856:	4604      	mov	r4, r0
c0d02858:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d0285a:	2c00      	cmp	r4, #0
c0d0285c:	d012      	beq.n	c0d02884 <USBD_Init+0x30>
c0d0285e:	4615      	mov	r5, r2
c0d02860:	460e      	mov	r6, r1
c0d02862:	2045      	movs	r0, #69	; 0x45
c0d02864:	0081      	lsls	r1, r0, #2
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02866:	4620      	mov	r0, r4
c0d02868:	f001 fe6e 	bl	c0d04548 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d0286c:	2e00      	cmp	r6, #0
c0d0286e:	d001      	beq.n	c0d02874 <USBD_Init+0x20>
c0d02870:	20f0      	movs	r0, #240	; 0xf0
  {
    pdev->pDesc = pdesc;
c0d02872:	5026      	str	r6, [r4, r0]
c0d02874:	20dc      	movs	r0, #220	; 0xdc
c0d02876:	2101      	movs	r1, #1
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02878:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d0287a:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d0287c:	4620      	mov	r0, r4
c0d0287e:	f7ff fec3 	bl	c0d02608 <USBD_LL_Init>
c0d02882:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d02884:	bd70      	pop	{r4, r5, r6, pc}

c0d02886 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d02886:	b5b0      	push	{r4, r5, r7, lr}
c0d02888:	4604      	mov	r4, r0
c0d0288a:	20dc      	movs	r0, #220	; 0xdc
c0d0288c:	2101      	movs	r1, #1
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d0288e:	5421      	strb	r1, [r4, r0]
c0d02890:	2017      	movs	r0, #23
c0d02892:	43c5      	mvns	r5, r0
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(pdev->interfacesClass[intf].pClass != NULL) {
c0d02894:	1960      	adds	r0, r4, r5
c0d02896:	2143      	movs	r1, #67	; 0x43
c0d02898:	0089      	lsls	r1, r1, #2
c0d0289a:	5840      	ldr	r0, [r0, r1]
c0d0289c:	2800      	cmp	r0, #0
c0d0289e:	d006      	beq.n	c0d028ae <USBD_DeInit+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
c0d028a0:	6840      	ldr	r0, [r0, #4]
c0d028a2:	f7fe fff5 	bl	c0d01890 <pic>
c0d028a6:	4602      	mov	r2, r0
c0d028a8:	7921      	ldrb	r1, [r4, #4]
c0d028aa:	4620      	mov	r0, r4
c0d028ac:	4790      	blx	r2
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d028ae:	3508      	adds	r5, #8
c0d028b0:	d1f0      	bne.n	c0d02894 <USBD_DeInit+0xe>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
    }
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d028b2:	4620      	mov	r0, r4
c0d028b4:	f7ff fee0 	bl	c0d02678 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d028b8:	4620      	mov	r0, r4
c0d028ba:	f7ff feaf 	bl	c0d0261c <USBD_LL_DeInit>
c0d028be:	2000      	movs	r0, #0
  
  return USBD_OK;
c0d028c0:	bdb0      	pop	{r4, r5, r7, pc}

c0d028c2 <USBD_RegisterClassForInterface>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef USBD_RegisterClassForInterface(uint8_t interfaceidx, USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d028c2:	4603      	mov	r3, r0
c0d028c4:	2002      	movs	r0, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d028c6:	2a00      	cmp	r2, #0
c0d028c8:	d007      	beq.n	c0d028da <USBD_RegisterClassForInterface+0x18>
c0d028ca:	2000      	movs	r0, #0
  {
    if (interfaceidx < USBD_MAX_NUM_INTERFACES) {
c0d028cc:	2b02      	cmp	r3, #2
c0d028ce:	d804      	bhi.n	c0d028da <USBD_RegisterClassForInterface+0x18>
      /* link the class to the USB Device handle */
      pdev->interfacesClass[interfaceidx].pClass = pclass;
c0d028d0:	00d8      	lsls	r0, r3, #3
c0d028d2:	1808      	adds	r0, r1, r0
c0d028d4:	21f4      	movs	r1, #244	; 0xf4
c0d028d6:	5042      	str	r2, [r0, r1]
c0d028d8:	2000      	movs	r0, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d028da:	4770      	bx	lr

c0d028dc <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d028dc:	b580      	push	{r7, lr}
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d028de:	f7ff feaf 	bl	c0d02640 <USBD_LL_Start>
c0d028e2:	2000      	movs	r0, #0
  
  return USBD_OK;  
c0d028e4:	bd80      	pop	{r7, pc}

c0d028e6 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d028e6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d028e8:	b081      	sub	sp, #4
c0d028ea:	460c      	mov	r4, r1
c0d028ec:	4605      	mov	r5, r0
c0d028ee:	2600      	movs	r6, #0
c0d028f0:	27f4      	movs	r7, #244	; 0xf4
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d028f2:	4628      	mov	r0, r5
c0d028f4:	4631      	mov	r1, r6
c0d028f6:	f000 f969 	bl	c0d02bcc <usbd_is_valid_intf>
c0d028fa:	2800      	cmp	r0, #0
c0d028fc:	d007      	beq.n	c0d0290e <USBD_SetClassConfig+0x28>
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
c0d028fe:	59e8      	ldr	r0, [r5, r7]
c0d02900:	6800      	ldr	r0, [r0, #0]
c0d02902:	f7fe ffc5 	bl	c0d01890 <pic>
c0d02906:	4602      	mov	r2, r0
c0d02908:	4628      	mov	r0, r5
c0d0290a:	4621      	mov	r1, r4
c0d0290c:	4790      	blx	r2

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0290e:	3708      	adds	r7, #8
c0d02910:	1c76      	adds	r6, r6, #1
c0d02912:	2e03      	cmp	r6, #3
c0d02914:	d1ed      	bne.n	c0d028f2 <USBD_SetClassConfig+0xc>
c0d02916:	2000      	movs	r0, #0
    if(usbd_is_valid_intf(pdev, intf)) {
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
    }
  }

  return USBD_OK; 
c0d02918:	b001      	add	sp, #4
c0d0291a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0291c <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d0291c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0291e:	b081      	sub	sp, #4
c0d02920:	460c      	mov	r4, r1
c0d02922:	4605      	mov	r5, r0
c0d02924:	2600      	movs	r6, #0
c0d02926:	27f4      	movs	r7, #244	; 0xf4
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d02928:	4628      	mov	r0, r5
c0d0292a:	4631      	mov	r1, r6
c0d0292c:	f000 f94e 	bl	c0d02bcc <usbd_is_valid_intf>
c0d02930:	2800      	cmp	r0, #0
c0d02932:	d007      	beq.n	c0d02944 <USBD_ClrClassConfig+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
c0d02934:	59e8      	ldr	r0, [r5, r7]
c0d02936:	6840      	ldr	r0, [r0, #4]
c0d02938:	f7fe ffaa 	bl	c0d01890 <pic>
c0d0293c:	4602      	mov	r2, r0
c0d0293e:	4628      	mov	r0, r5
c0d02940:	4621      	mov	r1, r4
c0d02942:	4790      	blx	r2
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02944:	3708      	adds	r7, #8
c0d02946:	1c76      	adds	r6, r6, #1
c0d02948:	2e03      	cmp	r6, #3
c0d0294a:	d1ed      	bne.n	c0d02928 <USBD_ClrClassConfig+0xc>
c0d0294c:	2000      	movs	r0, #0
    if(usbd_is_valid_intf(pdev, intf)) {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
    }
  }
  return USBD_OK;
c0d0294e:	b001      	add	sp, #4
c0d02950:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02952 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d02952:	b5b0      	push	{r4, r5, r7, lr}
c0d02954:	4604      	mov	r4, r0
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d02956:	4605      	mov	r5, r0
c0d02958:	35e8      	adds	r5, #232	; 0xe8
c0d0295a:	4628      	mov	r0, r5
c0d0295c:	f000 fb79 	bl	c0d03052 <USBD_ParseSetupRequest>
c0d02960:	20d4      	movs	r0, #212	; 0xd4
c0d02962:	2101      	movs	r1, #1
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d02964:	5021      	str	r1, [r4, r0]
c0d02966:	20ee      	movs	r0, #238	; 0xee
  pdev->ep0_data_len = pdev->request.wLength;
c0d02968:	5a20      	ldrh	r0, [r4, r0]
c0d0296a:	21d8      	movs	r1, #216	; 0xd8
c0d0296c:	5060      	str	r0, [r4, r1]
c0d0296e:	20e8      	movs	r0, #232	; 0xe8
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d02970:	5c21      	ldrb	r1, [r4, r0]
c0d02972:	201f      	movs	r0, #31
c0d02974:	4008      	ands	r0, r1
c0d02976:	2802      	cmp	r0, #2
c0d02978:	d008      	beq.n	c0d0298c <USBD_LL_SetupStage+0x3a>
c0d0297a:	2801      	cmp	r0, #1
c0d0297c:	d00b      	beq.n	c0d02996 <USBD_LL_SetupStage+0x44>
c0d0297e:	2800      	cmp	r0, #0
c0d02980:	d10e      	bne.n	c0d029a0 <USBD_LL_SetupStage+0x4e>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d02982:	4620      	mov	r0, r4
c0d02984:	4629      	mov	r1, r5
c0d02986:	f000 f92e 	bl	c0d02be6 <USBD_StdDevReq>
c0d0298a:	e00e      	b.n	c0d029aa <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d0298c:	4620      	mov	r0, r4
c0d0298e:	4629      	mov	r1, r5
c0d02990:	f000 fadb 	bl	c0d02f4a <USBD_StdEPReq>
c0d02994:	e009      	b.n	c0d029aa <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d02996:	4620      	mov	r0, r4
c0d02998:	4629      	mov	r1, r5
c0d0299a:	f000 fab2 	bl	c0d02f02 <USBD_StdItfReq>
c0d0299e:	e004      	b.n	c0d029aa <USBD_LL_SetupStage+0x58>
c0d029a0:	2080      	movs	r0, #128	; 0x80
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d029a2:	4001      	ands	r1, r0
c0d029a4:	4620      	mov	r0, r4
c0d029a6:	f7ff febf 	bl	c0d02728 <USBD_LL_StallEP>
c0d029aa:	2000      	movs	r0, #0
    break;
  }  
  return USBD_OK;  
c0d029ac:	bdb0      	pop	{r4, r5, r7, pc}

c0d029ae <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d029ae:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d029b0:	b083      	sub	sp, #12
c0d029b2:	9202      	str	r2, [sp, #8]
c0d029b4:	4604      	mov	r4, r0
c0d029b6:	9101      	str	r1, [sp, #4]
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d029b8:	2900      	cmp	r1, #0
c0d029ba:	d01c      	beq.n	c0d029f6 <USBD_LL_DataOutStage+0x48>
c0d029bc:	4625      	mov	r5, r4
c0d029be:	35dc      	adds	r5, #220	; 0xdc
c0d029c0:	2700      	movs	r7, #0
c0d029c2:	26f4      	movs	r6, #244	; 0xf4
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d029c4:	4620      	mov	r0, r4
c0d029c6:	4639      	mov	r1, r7
c0d029c8:	f000 f900 	bl	c0d02bcc <usbd_is_valid_intf>
c0d029cc:	2800      	cmp	r0, #0
c0d029ce:	d00d      	beq.n	c0d029ec <USBD_LL_DataOutStage+0x3e>
c0d029d0:	59a0      	ldr	r0, [r4, r6]
c0d029d2:	6980      	ldr	r0, [r0, #24]
c0d029d4:	2800      	cmp	r0, #0
c0d029d6:	d009      	beq.n	c0d029ec <USBD_LL_DataOutStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d029d8:	7829      	ldrb	r1, [r5, #0]
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d029da:	2903      	cmp	r1, #3
c0d029dc:	d106      	bne.n	c0d029ec <USBD_LL_DataOutStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
c0d029de:	f7fe ff57 	bl	c0d01890 <pic>
c0d029e2:	4603      	mov	r3, r0
c0d029e4:	4620      	mov	r0, r4
c0d029e6:	9901      	ldr	r1, [sp, #4]
c0d029e8:	9a02      	ldr	r2, [sp, #8]
c0d029ea:	4798      	blx	r3
    }
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d029ec:	3608      	adds	r6, #8
c0d029ee:	1c7f      	adds	r7, r7, #1
c0d029f0:	2f03      	cmp	r7, #3
c0d029f2:	d1e7      	bne.n	c0d029c4 <USBD_LL_DataOutStage+0x16>
c0d029f4:	e030      	b.n	c0d02a58 <USBD_LL_DataOutStage+0xaa>
c0d029f6:	20d4      	movs	r0, #212	; 0xd4
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d029f8:	5820      	ldr	r0, [r4, r0]
c0d029fa:	2803      	cmp	r0, #3
c0d029fc:	d12c      	bne.n	c0d02a58 <USBD_LL_DataOutStage+0xaa>
c0d029fe:	2080      	movs	r0, #128	; 0x80
    {
      if(pep->rem_length > pep->maxpacket)
c0d02a00:	5820      	ldr	r0, [r4, r0]
c0d02a02:	6fe1      	ldr	r1, [r4, #124]	; 0x7c
c0d02a04:	4281      	cmp	r1, r0
c0d02a06:	d90a      	bls.n	c0d02a1e <USBD_LL_DataOutStage+0x70>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02a08:	1a09      	subs	r1, r1, r0
c0d02a0a:	67e1      	str	r1, [r4, #124]	; 0x7c
       
        USBD_CtlContinueRx (pdev, 
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
c0d02a0c:	4281      	cmp	r1, r0
c0d02a0e:	d300      	bcc.n	c0d02a12 <USBD_LL_DataOutStage+0x64>
c0d02a10:	4601      	mov	r1, r0
    {
      if(pep->rem_length > pep->maxpacket)
      {
        pep->rem_length -=  pep->maxpacket;
       
        USBD_CtlContinueRx (pdev, 
c0d02a12:	b28a      	uxth	r2, r1
c0d02a14:	4620      	mov	r0, r4
c0d02a16:	9902      	ldr	r1, [sp, #8]
c0d02a18:	f000 fde0 	bl	c0d035dc <USBD_CtlContinueRx>
c0d02a1c:	e01c      	b.n	c0d02a58 <USBD_LL_DataOutStage+0xaa>
c0d02a1e:	4626      	mov	r6, r4
c0d02a20:	36dc      	adds	r6, #220	; 0xdc
c0d02a22:	2500      	movs	r5, #0
c0d02a24:	27f4      	movs	r7, #244	; 0xf4
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d02a26:	4620      	mov	r0, r4
c0d02a28:	4629      	mov	r1, r5
c0d02a2a:	f000 f8cf 	bl	c0d02bcc <usbd_is_valid_intf>
c0d02a2e:	2800      	cmp	r0, #0
c0d02a30:	d00b      	beq.n	c0d02a4a <USBD_LL_DataOutStage+0x9c>
c0d02a32:	59e0      	ldr	r0, [r4, r7]
c0d02a34:	6900      	ldr	r0, [r0, #16]
c0d02a36:	2800      	cmp	r0, #0
c0d02a38:	d007      	beq.n	c0d02a4a <USBD_LL_DataOutStage+0x9c>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02a3a:	7831      	ldrb	r1, [r6, #0]
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d02a3c:	2903      	cmp	r1, #3
c0d02a3e:	d104      	bne.n	c0d02a4a <USBD_LL_DataOutStage+0x9c>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
c0d02a40:	f7fe ff26 	bl	c0d01890 <pic>
c0d02a44:	4601      	mov	r1, r0
c0d02a46:	4620      	mov	r0, r4
c0d02a48:	4788      	blx	r1
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02a4a:	3708      	adds	r7, #8
c0d02a4c:	1c6d      	adds	r5, r5, #1
c0d02a4e:	2d03      	cmp	r5, #3
c0d02a50:	d1e9      	bne.n	c0d02a26 <USBD_LL_DataOutStage+0x78>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
          }
        }
        USBD_CtlSendStatus(pdev);
c0d02a52:	4620      	mov	r0, r4
c0d02a54:	f000 fdc9 	bl	c0d035ea <USBD_CtlSendStatus>
c0d02a58:	2000      	movs	r0, #0
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
      }
    }
  }  
  return USBD_OK;
c0d02a5a:	b003      	add	sp, #12
c0d02a5c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02a5e <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02a5e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a60:	b081      	sub	sp, #4
c0d02a62:	4604      	mov	r4, r0
c0d02a64:	9100      	str	r1, [sp, #0]
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02a66:	2900      	cmp	r1, #0
c0d02a68:	d01b      	beq.n	c0d02aa2 <USBD_LL_DataInStage+0x44>
c0d02a6a:	4627      	mov	r7, r4
c0d02a6c:	37dc      	adds	r7, #220	; 0xdc
c0d02a6e:	2600      	movs	r6, #0
c0d02a70:	25f4      	movs	r5, #244	; 0xf4
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d02a72:	4620      	mov	r0, r4
c0d02a74:	4631      	mov	r1, r6
c0d02a76:	f000 f8a9 	bl	c0d02bcc <usbd_is_valid_intf>
c0d02a7a:	2800      	cmp	r0, #0
c0d02a7c:	d00c      	beq.n	c0d02a98 <USBD_LL_DataInStage+0x3a>
c0d02a7e:	5960      	ldr	r0, [r4, r5]
c0d02a80:	6940      	ldr	r0, [r0, #20]
c0d02a82:	2800      	cmp	r0, #0
c0d02a84:	d008      	beq.n	c0d02a98 <USBD_LL_DataInStage+0x3a>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02a86:	7839      	ldrb	r1, [r7, #0]
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d02a88:	2903      	cmp	r1, #3
c0d02a8a:	d105      	bne.n	c0d02a98 <USBD_LL_DataInStage+0x3a>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
c0d02a8c:	f7fe ff00 	bl	c0d01890 <pic>
c0d02a90:	4602      	mov	r2, r0
c0d02a92:	4620      	mov	r0, r4
c0d02a94:	9900      	ldr	r1, [sp, #0]
c0d02a96:	4790      	blx	r2
      pdev->dev_test_mode = 0;
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02a98:	3508      	adds	r5, #8
c0d02a9a:	1c76      	adds	r6, r6, #1
c0d02a9c:	2e03      	cmp	r6, #3
c0d02a9e:	d1e8      	bne.n	c0d02a72 <USBD_LL_DataInStage+0x14>
c0d02aa0:	e04e      	b.n	c0d02b40 <USBD_LL_DataInStage+0xe2>
c0d02aa2:	20d4      	movs	r0, #212	; 0xd4
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02aa4:	5820      	ldr	r0, [r4, r0]
c0d02aa6:	2802      	cmp	r0, #2
c0d02aa8:	d143      	bne.n	c0d02b32 <USBD_LL_DataInStage+0xd4>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02aaa:	69e0      	ldr	r0, [r4, #28]
c0d02aac:	6a25      	ldr	r5, [r4, #32]
c0d02aae:	42a8      	cmp	r0, r5
c0d02ab0:	d90b      	bls.n	c0d02aca <USBD_LL_DataInStage+0x6c>
c0d02ab2:	2111      	movs	r1, #17
c0d02ab4:	010a      	lsls	r2, r1, #4
      {
        pep->rem_length -=  pep->maxpacket;
        pdev->pData += pep->maxpacket;
c0d02ab6:	58a1      	ldr	r1, [r4, r2]
c0d02ab8:	1949      	adds	r1, r1, r5
c0d02aba:	50a1      	str	r1, [r4, r2]
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
    {
      if(pep->rem_length > pep->maxpacket)
      {
        pep->rem_length -=  pep->maxpacket;
c0d02abc:	1b40      	subs	r0, r0, r5
c0d02abe:	61e0      	str	r0, [r4, #28]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02ac0:	b282      	uxth	r2, r0
c0d02ac2:	4620      	mov	r0, r4
c0d02ac4:	f000 fd7c 	bl	c0d035c0 <USBD_CtlContinueSendData>
c0d02ac8:	e033      	b.n	c0d02b32 <USBD_LL_DataInStage+0xd4>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02aca:	69a6      	ldr	r6, [r4, #24]
c0d02acc:	4630      	mov	r0, r6
c0d02ace:	4629      	mov	r1, r5
c0d02ad0:	f001 fd34 	bl	c0d0453c <__aeabi_uidivmod>
c0d02ad4:	42ae      	cmp	r6, r5
c0d02ad6:	d30f      	bcc.n	c0d02af8 <USBD_LL_DataInStage+0x9a>
c0d02ad8:	2900      	cmp	r1, #0
c0d02ada:	d10d      	bne.n	c0d02af8 <USBD_LL_DataInStage+0x9a>
c0d02adc:	20d8      	movs	r0, #216	; 0xd8
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02ade:	5820      	ldr	r0, [r4, r0]
c0d02ae0:	4627      	mov	r7, r4
c0d02ae2:	37d8      	adds	r7, #216	; 0xd8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02ae4:	4286      	cmp	r6, r0
c0d02ae6:	d207      	bcs.n	c0d02af8 <USBD_LL_DataInStage+0x9a>
c0d02ae8:	2500      	movs	r5, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02aea:	4620      	mov	r0, r4
c0d02aec:	4629      	mov	r1, r5
c0d02aee:	462a      	mov	r2, r5
c0d02af0:	f000 fd66 	bl	c0d035c0 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02af4:	603d      	str	r5, [r7, #0]
c0d02af6:	e01c      	b.n	c0d02b32 <USBD_LL_DataInStage+0xd4>
c0d02af8:	4626      	mov	r6, r4
c0d02afa:	36dc      	adds	r6, #220	; 0xdc
c0d02afc:	2500      	movs	r5, #0
c0d02afe:	27f4      	movs	r7, #244	; 0xf4
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d02b00:	4620      	mov	r0, r4
c0d02b02:	4629      	mov	r1, r5
c0d02b04:	f000 f862 	bl	c0d02bcc <usbd_is_valid_intf>
c0d02b08:	2800      	cmp	r0, #0
c0d02b0a:	d00b      	beq.n	c0d02b24 <USBD_LL_DataInStage+0xc6>
c0d02b0c:	59e0      	ldr	r0, [r4, r7]
c0d02b0e:	68c0      	ldr	r0, [r0, #12]
c0d02b10:	2800      	cmp	r0, #0
c0d02b12:	d007      	beq.n	c0d02b24 <USBD_LL_DataInStage+0xc6>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02b14:	7831      	ldrb	r1, [r6, #0]
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d02b16:	2903      	cmp	r1, #3
c0d02b18:	d104      	bne.n	c0d02b24 <USBD_LL_DataInStage+0xc6>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
c0d02b1a:	f7fe feb9 	bl	c0d01890 <pic>
c0d02b1e:	4601      	mov	r1, r0
c0d02b20:	4620      	mov	r0, r4
c0d02b22:	4788      	blx	r1
          
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02b24:	3708      	adds	r7, #8
c0d02b26:	1c6d      	adds	r5, r5, #1
c0d02b28:	2d03      	cmp	r5, #3
c0d02b2a:	d1e9      	bne.n	c0d02b00 <USBD_LL_DataInStage+0xa2>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
            }
          }
          USBD_CtlReceiveStatus(pdev);
c0d02b2c:	4620      	mov	r0, r4
c0d02b2e:	f000 fd68 	bl	c0d03602 <USBD_CtlReceiveStatus>
c0d02b32:	20e0      	movs	r0, #224	; 0xe0
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02b34:	5c20      	ldrb	r0, [r4, r0]
c0d02b36:	34e0      	adds	r4, #224	; 0xe0
c0d02b38:	2801      	cmp	r0, #1
c0d02b3a:	d101      	bne.n	c0d02b40 <USBD_LL_DataInStage+0xe2>
c0d02b3c:	2000      	movs	r0, #0
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02b3e:	7020      	strb	r0, [r4, #0]
c0d02b40:	2000      	movs	r0, #0
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
      }
    }
  }
  return USBD_OK;
c0d02b42:	b001      	add	sp, #4
c0d02b44:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02b46 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02b46:	b570      	push	{r4, r5, r6, lr}
c0d02b48:	4604      	mov	r4, r0
c0d02b4a:	2080      	movs	r0, #128	; 0x80
c0d02b4c:	2140      	movs	r1, #64	; 0x40
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02b4e:	5021      	str	r1, [r4, r0]
c0d02b50:	20dc      	movs	r0, #220	; 0xdc
c0d02b52:	2201      	movs	r2, #1
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02b54:	5422      	strb	r2, [r4, r0]
USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02b56:	6221      	str	r1, [r4, #32]
c0d02b58:	2500      	movs	r5, #0
c0d02b5a:	26f4      	movs	r6, #244	; 0xf4
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if( usbd_is_valid_intf(pdev, intf))
c0d02b5c:	4620      	mov	r0, r4
c0d02b5e:	4629      	mov	r1, r5
c0d02b60:	f000 f834 	bl	c0d02bcc <usbd_is_valid_intf>
c0d02b64:	2800      	cmp	r0, #0
c0d02b66:	d007      	beq.n	c0d02b78 <USBD_LL_Reset+0x32>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
c0d02b68:	59a0      	ldr	r0, [r4, r6]
c0d02b6a:	6840      	ldr	r0, [r0, #4]
c0d02b6c:	f7fe fe90 	bl	c0d01890 <pic>
c0d02b70:	4602      	mov	r2, r0
c0d02b72:	7921      	ldrb	r1, [r4, #4]
c0d02b74:	4620      	mov	r0, r4
c0d02b76:	4790      	blx	r2
  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02b78:	3608      	adds	r6, #8
c0d02b7a:	1c6d      	adds	r5, r5, #1
c0d02b7c:	2d03      	cmp	r5, #3
c0d02b7e:	d1ed      	bne.n	c0d02b5c <USBD_LL_Reset+0x16>
c0d02b80:	2000      	movs	r0, #0
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
    }
  }
  
  return USBD_OK;
c0d02b82:	bd70      	pop	{r4, r5, r6, pc}

c0d02b84 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02b84:	7401      	strb	r1, [r0, #16]
c0d02b86:	2000      	movs	r0, #0
  return USBD_OK;
c0d02b88:	4770      	bx	lr

c0d02b8a <USBD_LL_Suspend>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Suspend(USBD_HandleTypeDef  *pdev)
{
c0d02b8a:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02b8c:	4770      	bx	lr

c0d02b8e <USBD_LL_Resume>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
c0d02b8e:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02b90:	4770      	bx	lr

c0d02b92 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02b92:	b570      	push	{r4, r5, r6, lr}
c0d02b94:	4604      	mov	r4, r0
c0d02b96:	20dc      	movs	r0, #220	; 0xdc
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02b98:	5c20      	ldrb	r0, [r4, r0]
c0d02b9a:	2803      	cmp	r0, #3
c0d02b9c:	d114      	bne.n	c0d02bc8 <USBD_LL_SOF+0x36>
c0d02b9e:	2500      	movs	r5, #0
c0d02ba0:	26f4      	movs	r6, #244	; 0xf4
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && pdev->interfacesClass[intf].pClass->SOF != NULL)
c0d02ba2:	4620      	mov	r0, r4
c0d02ba4:	4629      	mov	r1, r5
c0d02ba6:	f000 f811 	bl	c0d02bcc <usbd_is_valid_intf>
c0d02baa:	2800      	cmp	r0, #0
c0d02bac:	d008      	beq.n	c0d02bc0 <USBD_LL_SOF+0x2e>
c0d02bae:	59a0      	ldr	r0, [r4, r6]
c0d02bb0:	69c0      	ldr	r0, [r0, #28]
c0d02bb2:	2800      	cmp	r0, #0
c0d02bb4:	d004      	beq.n	c0d02bc0 <USBD_LL_SOF+0x2e>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
c0d02bb6:	f7fe fe6b 	bl	c0d01890 <pic>
c0d02bba:	4601      	mov	r1, r0
c0d02bbc:	4620      	mov	r0, r4
c0d02bbe:	4788      	blx	r1
USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02bc0:	3608      	adds	r6, #8
c0d02bc2:	1c6d      	adds	r5, r5, #1
c0d02bc4:	2d03      	cmp	r5, #3
c0d02bc6:	d1ec      	bne.n	c0d02ba2 <USBD_LL_SOF+0x10>
c0d02bc8:	2000      	movs	r0, #0
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
      }
    }
  }
  return USBD_OK;
c0d02bca:	bd70      	pop	{r4, r5, r6, pc}

c0d02bcc <usbd_is_valid_intf>:

/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
c0d02bcc:	4602      	mov	r2, r0
c0d02bce:	2000      	movs	r0, #0
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02bd0:	2902      	cmp	r1, #2
c0d02bd2:	d807      	bhi.n	c0d02be4 <usbd_is_valid_intf+0x18>
c0d02bd4:	00c8      	lsls	r0, r1, #3
c0d02bd6:	1810      	adds	r0, r2, r0
c0d02bd8:	21f4      	movs	r1, #244	; 0xf4
c0d02bda:	5841      	ldr	r1, [r0, r1]
c0d02bdc:	2001      	movs	r0, #1
c0d02bde:	2900      	cmp	r1, #0
c0d02be0:	d100      	bne.n	c0d02be4 <usbd_is_valid_intf+0x18>
c0d02be2:	4608      	mov	r0, r1
c0d02be4:	4770      	bx	lr

c0d02be6 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02be6:	b580      	push	{r7, lr}
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02be8:	784a      	ldrb	r2, [r1, #1]
c0d02bea:	2a04      	cmp	r2, #4
c0d02bec:	dd08      	ble.n	c0d02c00 <USBD_StdDevReq+0x1a>
c0d02bee:	2a07      	cmp	r2, #7
c0d02bf0:	dc0f      	bgt.n	c0d02c12 <USBD_StdDevReq+0x2c>
c0d02bf2:	2a05      	cmp	r2, #5
c0d02bf4:	d014      	beq.n	c0d02c20 <USBD_StdDevReq+0x3a>
c0d02bf6:	2a06      	cmp	r2, #6
c0d02bf8:	d11b      	bne.n	c0d02c32 <USBD_StdDevReq+0x4c>
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02bfa:	f000 f821 	bl	c0d02c40 <USBD_GetDescriptor>
c0d02bfe:	e01d      	b.n	c0d02c3c <USBD_StdDevReq+0x56>
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02c00:	2a00      	cmp	r2, #0
c0d02c02:	d010      	beq.n	c0d02c26 <USBD_StdDevReq+0x40>
c0d02c04:	2a01      	cmp	r2, #1
c0d02c06:	d017      	beq.n	c0d02c38 <USBD_StdDevReq+0x52>
c0d02c08:	2a03      	cmp	r2, #3
c0d02c0a:	d112      	bne.n	c0d02c32 <USBD_StdDevReq+0x4c>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02c0c:	f000 f934 	bl	c0d02e78 <USBD_SetFeature>
c0d02c10:	e014      	b.n	c0d02c3c <USBD_StdDevReq+0x56>
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02c12:	2a08      	cmp	r2, #8
c0d02c14:	d00a      	beq.n	c0d02c2c <USBD_StdDevReq+0x46>
c0d02c16:	2a09      	cmp	r2, #9
c0d02c18:	d10b      	bne.n	c0d02c32 <USBD_StdDevReq+0x4c>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02c1a:	f000 f8bd 	bl	c0d02d98 <USBD_SetConfig>
c0d02c1e:	e00d      	b.n	c0d02c3c <USBD_StdDevReq+0x56>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02c20:	f000 f894 	bl	c0d02d4c <USBD_SetAddress>
c0d02c24:	e00a      	b.n	c0d02c3c <USBD_StdDevReq+0x56>
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02c26:	f000 f905 	bl	c0d02e34 <USBD_GetStatus>
c0d02c2a:	e007      	b.n	c0d02c3c <USBD_StdDevReq+0x56>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02c2c:	f000 f8eb 	bl	c0d02e06 <USBD_GetConfig>
c0d02c30:	e004      	b.n	c0d02c3c <USBD_StdDevReq+0x56>
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
    break;
    
  default:  
    USBD_CtlError(pdev , req);
c0d02c32:	f000 fbe1 	bl	c0d033f8 <USBD_CtlError>
c0d02c36:	e001      	b.n	c0d02c3c <USBD_StdDevReq+0x56>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02c38:	f000 f93b 	bl	c0d02eb2 <USBD_ClrFeature>
c0d02c3c:	2000      	movs	r0, #0
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02c3e:	bd80      	pop	{r7, pc}

c0d02c40 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02c40:	b5b0      	push	{r4, r5, r7, lr}
c0d02c42:	b082      	sub	sp, #8
c0d02c44:	460d      	mov	r5, r1
c0d02c46:	4604      	mov	r4, r0
c0d02c48:	a801      	add	r0, sp, #4
c0d02c4a:	2100      	movs	r1, #0
  uint16_t len = 0;
c0d02c4c:	8001      	strh	r1, [r0, #0]
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d02c4e:	886a      	ldrh	r2, [r5, #2]
c0d02c50:	0a10      	lsrs	r0, r2, #8
c0d02c52:	2805      	cmp	r0, #5
c0d02c54:	dc12      	bgt.n	c0d02c7c <USBD_GetDescriptor+0x3c>
c0d02c56:	2801      	cmp	r0, #1
c0d02c58:	d01c      	beq.n	c0d02c94 <USBD_GetDescriptor+0x54>
c0d02c5a:	2802      	cmp	r0, #2
c0d02c5c:	d024      	beq.n	c0d02ca8 <USBD_GetDescriptor+0x68>
c0d02c5e:	2803      	cmp	r0, #3
c0d02c60:	d137      	bne.n	c0d02cd2 <USBD_GetDescriptor+0x92>
c0d02c62:	b2d0      	uxtb	r0, r2
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02c64:	2802      	cmp	r0, #2
c0d02c66:	dc39      	bgt.n	c0d02cdc <USBD_GetDescriptor+0x9c>
c0d02c68:	2800      	cmp	r0, #0
c0d02c6a:	d05f      	beq.n	c0d02d2c <USBD_GetDescriptor+0xec>
c0d02c6c:	2801      	cmp	r0, #1
c0d02c6e:	d065      	beq.n	c0d02d3c <USBD_GetDescriptor+0xfc>
c0d02c70:	2802      	cmp	r0, #2
c0d02c72:	d12e      	bne.n	c0d02cd2 <USBD_GetDescriptor+0x92>
c0d02c74:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02c76:	5820      	ldr	r0, [r4, r0]
c0d02c78:	68c0      	ldr	r0, [r0, #12]
c0d02c7a:	e00e      	b.n	c0d02c9a <USBD_GetDescriptor+0x5a>
{
  uint16_t len = 0;
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d02c7c:	2806      	cmp	r0, #6
c0d02c7e:	d01c      	beq.n	c0d02cba <USBD_GetDescriptor+0x7a>
c0d02c80:	2807      	cmp	r0, #7
c0d02c82:	d023      	beq.n	c0d02ccc <USBD_GetDescriptor+0x8c>
c0d02c84:	280f      	cmp	r0, #15
c0d02c86:	d124      	bne.n	c0d02cd2 <USBD_GetDescriptor+0x92>
c0d02c88:	20f0      	movs	r0, #240	; 0xf0
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    if(pdev->pDesc->GetBOSDescriptor != NULL) {
c0d02c8a:	5820      	ldr	r0, [r4, r0]
c0d02c8c:	69c0      	ldr	r0, [r0, #28]
c0d02c8e:	2800      	cmp	r0, #0
c0d02c90:	d103      	bne.n	c0d02c9a <USBD_GetDescriptor+0x5a>
c0d02c92:	e01e      	b.n	c0d02cd2 <USBD_GetDescriptor+0x92>
c0d02c94:	20f0      	movs	r0, #240	; 0xf0
      goto default_error;
    }
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02c96:	5820      	ldr	r0, [r4, r0]
c0d02c98:	6800      	ldr	r0, [r0, #0]
c0d02c9a:	f7fe fdf9 	bl	c0d01890 <pic>
c0d02c9e:	4602      	mov	r2, r0
c0d02ca0:	7c20      	ldrb	r0, [r4, #16]
c0d02ca2:	a901      	add	r1, sp, #4
c0d02ca4:	4790      	blx	r2
c0d02ca6:	e02f      	b.n	c0d02d08 <USBD_GetDescriptor+0xc8>
c0d02ca8:	20f4      	movs	r0, #244	; 0xf4
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
c0d02caa:	5820      	ldr	r0, [r4, r0]
c0d02cac:	2800      	cmp	r0, #0
c0d02cae:	d02c      	beq.n	c0d02d0a <USBD_GetDescriptor+0xca>
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02cb0:	7c21      	ldrb	r1, [r4, #16]
c0d02cb2:	2900      	cmp	r1, #0
c0d02cb4:	d022      	beq.n	c0d02cfc <USBD_GetDescriptor+0xbc>
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
        //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
      }
      else
      {
        pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetFSConfigDescriptor))(&len);
c0d02cb6:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02cb8:	e021      	b.n	c0d02cfe <USBD_GetDescriptor+0xbe>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL )   
c0d02cba:	7c20      	ldrb	r0, [r4, #16]
c0d02cbc:	2800      	cmp	r0, #0
c0d02cbe:	d108      	bne.n	c0d02cd2 <USBD_GetDescriptor+0x92>
c0d02cc0:	20f4      	movs	r0, #244	; 0xf4
c0d02cc2:	5820      	ldr	r0, [r4, r0]
c0d02cc4:	2800      	cmp	r0, #0
c0d02cc6:	d004      	beq.n	c0d02cd2 <USBD_GetDescriptor+0x92>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetDeviceQualifierDescriptor))(&len);
c0d02cc8:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02cca:	e018      	b.n	c0d02cfe <USBD_GetDescriptor+0xbe>
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d02ccc:	7c20      	ldrb	r0, [r4, #16]
c0d02cce:	2800      	cmp	r0, #0
c0d02cd0:	d00e      	beq.n	c0d02cf0 <USBD_GetDescriptor+0xb0>
      goto default_error;
    }

  default: 
  default_error:
     USBD_CtlError(pdev , req);
c0d02cd2:	4620      	mov	r0, r4
c0d02cd4:	4629      	mov	r1, r5
c0d02cd6:	f000 fb8f 	bl	c0d033f8 <USBD_CtlError>
c0d02cda:	e025      	b.n	c0d02d28 <USBD_GetDescriptor+0xe8>
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02cdc:	2803      	cmp	r0, #3
c0d02cde:	d029      	beq.n	c0d02d34 <USBD_GetDescriptor+0xf4>
c0d02ce0:	2804      	cmp	r0, #4
c0d02ce2:	d02f      	beq.n	c0d02d44 <USBD_GetDescriptor+0x104>
c0d02ce4:	2805      	cmp	r0, #5
c0d02ce6:	d1f4      	bne.n	c0d02cd2 <USBD_GetDescriptor+0x92>
c0d02ce8:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02cea:	5820      	ldr	r0, [r4, r0]
c0d02cec:	6980      	ldr	r0, [r0, #24]
c0d02cee:	e7d4      	b.n	c0d02c9a <USBD_GetDescriptor+0x5a>
c0d02cf0:	20f4      	movs	r0, #244	; 0xf4
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d02cf2:	5820      	ldr	r0, [r4, r0]
c0d02cf4:	2800      	cmp	r0, #0
c0d02cf6:	d0ec      	beq.n	c0d02cd2 <USBD_GetDescriptor+0x92>
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02cf8:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02cfa:	e000      	b.n	c0d02cfe <USBD_GetDescriptor+0xbe>
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
      {
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
c0d02cfc:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02cfe:	f7fe fdc7 	bl	c0d01890 <pic>
c0d02d02:	4601      	mov	r1, r0
c0d02d04:	a801      	add	r0, sp, #4
c0d02d06:	4788      	blx	r1
c0d02d08:	4601      	mov	r1, r0
c0d02d0a:	a801      	add	r0, sp, #4
  default_error:
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02d0c:	8802      	ldrh	r2, [r0, #0]
c0d02d0e:	2a00      	cmp	r2, #0
c0d02d10:	d00a      	beq.n	c0d02d28 <USBD_GetDescriptor+0xe8>
c0d02d12:	88e8      	ldrh	r0, [r5, #6]
c0d02d14:	2800      	cmp	r0, #0
c0d02d16:	d007      	beq.n	c0d02d28 <USBD_GetDescriptor+0xe8>
  {
    
    len = MIN(len , req->wLength);
c0d02d18:	4282      	cmp	r2, r0
c0d02d1a:	d300      	bcc.n	c0d02d1e <USBD_GetDescriptor+0xde>
c0d02d1c:	4602      	mov	r2, r0
c0d02d1e:	a801      	add	r0, sp, #4
c0d02d20:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02d22:	4620      	mov	r0, r4
c0d02d24:	f000 fc36 	bl	c0d03594 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02d28:	b002      	add	sp, #8
c0d02d2a:	bdb0      	pop	{r4, r5, r7, pc}
c0d02d2c:	20f0      	movs	r0, #240	; 0xf0
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02d2e:	5820      	ldr	r0, [r4, r0]
c0d02d30:	6840      	ldr	r0, [r0, #4]
c0d02d32:	e7b2      	b.n	c0d02c9a <USBD_GetDescriptor+0x5a>
c0d02d34:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02d36:	5820      	ldr	r0, [r4, r0]
c0d02d38:	6900      	ldr	r0, [r0, #16]
c0d02d3a:	e7ae      	b.n	c0d02c9a <USBD_GetDescriptor+0x5a>
c0d02d3c:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02d3e:	5820      	ldr	r0, [r4, r0]
c0d02d40:	6880      	ldr	r0, [r0, #8]
c0d02d42:	e7aa      	b.n	c0d02c9a <USBD_GetDescriptor+0x5a>
c0d02d44:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02d46:	5820      	ldr	r0, [r4, r0]
c0d02d48:	6940      	ldr	r0, [r0, #20]
c0d02d4a:	e7a6      	b.n	c0d02c9a <USBD_GetDescriptor+0x5a>

c0d02d4c <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02d4c:	b570      	push	{r4, r5, r6, lr}
c0d02d4e:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02d50:	8888      	ldrh	r0, [r1, #4]
c0d02d52:	2800      	cmp	r0, #0
c0d02d54:	d10b      	bne.n	c0d02d6e <USBD_SetAddress+0x22>
c0d02d56:	88c8      	ldrh	r0, [r1, #6]
c0d02d58:	2800      	cmp	r0, #0
c0d02d5a:	d108      	bne.n	c0d02d6e <USBD_SetAddress+0x22>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02d5c:	8848      	ldrh	r0, [r1, #2]
c0d02d5e:	257f      	movs	r5, #127	; 0x7f
c0d02d60:	4005      	ands	r5, r0
c0d02d62:	20dc      	movs	r0, #220	; 0xdc
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02d64:	5c20      	ldrb	r0, [r4, r0]
c0d02d66:	4626      	mov	r6, r4
c0d02d68:	36dc      	adds	r6, #220	; 0xdc
c0d02d6a:	2803      	cmp	r0, #3
c0d02d6c:	d103      	bne.n	c0d02d76 <USBD_SetAddress+0x2a>
c0d02d6e:	4620      	mov	r0, r4
c0d02d70:	f000 fb42 	bl	c0d033f8 <USBD_CtlError>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02d74:	bd70      	pop	{r4, r5, r6, pc}
c0d02d76:	20de      	movs	r0, #222	; 0xde
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02d78:	5425      	strb	r5, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02d7a:	4620      	mov	r0, r4
c0d02d7c:	4629      	mov	r1, r5
c0d02d7e:	f7ff fd2b 	bl	c0d027d8 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02d82:	4620      	mov	r0, r4
c0d02d84:	f000 fc31 	bl	c0d035ea <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02d88:	2d00      	cmp	r5, #0
c0d02d8a:	d002      	beq.n	c0d02d92 <USBD_SetAddress+0x46>
c0d02d8c:	2002      	movs	r0, #2
      {
        pdev->dev_state  = USBD_STATE_ADDRESSED;
c0d02d8e:	7030      	strb	r0, [r6, #0]
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02d90:	bd70      	pop	{r4, r5, r6, pc}
c0d02d92:	2001      	movs	r0, #1
      {
        pdev->dev_state  = USBD_STATE_ADDRESSED;
      } 
      else 
      {
        pdev->dev_state  = USBD_STATE_DEFAULT; 
c0d02d94:	7030      	strb	r0, [r6, #0]
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02d96:	bd70      	pop	{r4, r5, r6, pc}

c0d02d98 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02d98:	b570      	push	{r4, r5, r6, lr}
c0d02d9a:	460d      	mov	r5, r1
c0d02d9c:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02d9e:	788e      	ldrb	r6, [r1, #2]
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02da0:	2e02      	cmp	r6, #2
c0d02da2:	d21d      	bcs.n	c0d02de0 <USBD_SetConfig+0x48>
c0d02da4:	20dc      	movs	r0, #220	; 0xdc
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02da6:	5c21      	ldrb	r1, [r4, r0]
c0d02da8:	4620      	mov	r0, r4
c0d02daa:	30dc      	adds	r0, #220	; 0xdc
c0d02dac:	2903      	cmp	r1, #3
c0d02dae:	d007      	beq.n	c0d02dc0 <USBD_SetConfig+0x28>
c0d02db0:	2902      	cmp	r1, #2
c0d02db2:	d115      	bne.n	c0d02de0 <USBD_SetConfig+0x48>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02db4:	2e00      	cmp	r6, #0
c0d02db6:	d022      	beq.n	c0d02dfe <USBD_SetConfig+0x66>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02db8:	6066      	str	r6, [r4, #4]
c0d02dba:	2103      	movs	r1, #3
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02dbc:	7001      	strb	r1, [r0, #0]
c0d02dbe:	e009      	b.n	c0d02dd4 <USBD_SetConfig+0x3c>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02dc0:	2e00      	cmp	r6, #0
c0d02dc2:	d012      	beq.n	c0d02dea <USBD_SetConfig+0x52>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02dc4:	6860      	ldr	r0, [r4, #4]
c0d02dc6:	42b0      	cmp	r0, r6
c0d02dc8:	d019      	beq.n	c0d02dfe <USBD_SetConfig+0x66>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02dca:	b2c1      	uxtb	r1, r0
c0d02dcc:	4620      	mov	r0, r4
c0d02dce:	f7ff fda5 	bl	c0d0291c <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02dd2:	6066      	str	r6, [r4, #4]
c0d02dd4:	4620      	mov	r0, r4
c0d02dd6:	4631      	mov	r1, r6
c0d02dd8:	f7ff fd85 	bl	c0d028e6 <USBD_SetClassConfig>
c0d02ddc:	2802      	cmp	r0, #2
c0d02dde:	d10e      	bne.n	c0d02dfe <USBD_SetConfig+0x66>
c0d02de0:	4620      	mov	r0, r4
c0d02de2:	4629      	mov	r1, r5
c0d02de4:	f000 fb08 	bl	c0d033f8 <USBD_CtlError>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02de8:	bd70      	pop	{r4, r5, r6, pc}
c0d02dea:	2102      	movs	r1, #2
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02dec:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02dee:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02df0:	4620      	mov	r0, r4
c0d02df2:	4631      	mov	r1, r6
c0d02df4:	f7ff fd92 	bl	c0d0291c <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02df8:	4620      	mov	r0, r4
c0d02dfa:	f000 fbf6 	bl	c0d035ea <USBD_CtlSendStatus>
c0d02dfe:	4620      	mov	r0, r4
c0d02e00:	f000 fbf3 	bl	c0d035ea <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02e04:	bd70      	pop	{r4, r5, r6, pc}

c0d02e06 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02e06:	b580      	push	{r7, lr}

  if (req->wLength != 1) 
c0d02e08:	88ca      	ldrh	r2, [r1, #6]
c0d02e0a:	2a01      	cmp	r2, #1
c0d02e0c:	d10a      	bne.n	c0d02e24 <USBD_GetConfig+0x1e>
c0d02e0e:	22dc      	movs	r2, #220	; 0xdc
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02e10:	5c82      	ldrb	r2, [r0, r2]
c0d02e12:	2a03      	cmp	r2, #3
c0d02e14:	d009      	beq.n	c0d02e2a <USBD_GetConfig+0x24>
c0d02e16:	2a02      	cmp	r2, #2
c0d02e18:	d104      	bne.n	c0d02e24 <USBD_GetConfig+0x1e>
c0d02e1a:	2100      	movs	r1, #0
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02e1c:	6081      	str	r1, [r0, #8]
c0d02e1e:	4601      	mov	r1, r0
c0d02e20:	3108      	adds	r1, #8
c0d02e22:	e003      	b.n	c0d02e2c <USBD_GetConfig+0x26>
c0d02e24:	f000 fae8 	bl	c0d033f8 <USBD_CtlError>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02e28:	bd80      	pop	{r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02e2a:	1d01      	adds	r1, r0, #4
c0d02e2c:	2201      	movs	r2, #1
c0d02e2e:	f000 fbb1 	bl	c0d03594 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02e32:	bd80      	pop	{r7, pc}

c0d02e34 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02e34:	b5b0      	push	{r4, r5, r7, lr}
c0d02e36:	4604      	mov	r4, r0
c0d02e38:	20dc      	movs	r0, #220	; 0xdc
  
    
  switch (pdev->dev_state) 
c0d02e3a:	5c20      	ldrb	r0, [r4, r0]
c0d02e3c:	22fe      	movs	r2, #254	; 0xfe
c0d02e3e:	4002      	ands	r2, r0
c0d02e40:	2a02      	cmp	r2, #2
c0d02e42:	d115      	bne.n	c0d02e70 <USBD_GetStatus+0x3c>
c0d02e44:	2001      	movs	r0, #1
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02e46:	60e0      	str	r0, [r4, #12]
c0d02e48:	20e4      	movs	r0, #228	; 0xe4
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02e4a:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02e4c:	4625      	mov	r5, r4
c0d02e4e:	350c      	adds	r5, #12
c0d02e50:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02e52:	2900      	cmp	r1, #0
c0d02e54:	d005      	beq.n	c0d02e62 <USBD_GetStatus+0x2e>
c0d02e56:	4620      	mov	r0, r4
c0d02e58:	f000 fbd3 	bl	c0d03602 <USBD_CtlReceiveStatus>
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02e5c:	68e1      	ldr	r1, [r4, #12]
c0d02e5e:	2002      	movs	r0, #2
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02e60:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02e62:	60e0      	str	r0, [r4, #12]
c0d02e64:	2202      	movs	r2, #2
    }
    
    USBD_CtlSendData (pdev, 
c0d02e66:	4620      	mov	r0, r4
c0d02e68:	4629      	mov	r1, r5
c0d02e6a:	f000 fb93 	bl	c0d03594 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02e6e:	bdb0      	pop	{r4, r5, r7, pc}
                      (uint8_t *)& pdev->dev_config_status,
                      2);
    break;
    
  default :
    USBD_CtlError(pdev , req);                        
c0d02e70:	4620      	mov	r0, r4
c0d02e72:	f000 fac1 	bl	c0d033f8 <USBD_CtlError>
    break;
  }
}
c0d02e76:	bdb0      	pop	{r4, r5, r7, pc}

c0d02e78 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02e78:	b5b0      	push	{r4, r5, r7, lr}
c0d02e7a:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02e7c:	8848      	ldrh	r0, [r1, #2]
c0d02e7e:	2801      	cmp	r0, #1
c0d02e80:	d116      	bne.n	c0d02eb0 <USBD_SetFeature+0x38>
c0d02e82:	460d      	mov	r5, r1
c0d02e84:	20e4      	movs	r0, #228	; 0xe4
c0d02e86:	2101      	movs	r1, #1
  {
    pdev->dev_remote_wakeup = 1;  
c0d02e88:	5021      	str	r1, [r4, r0]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02e8a:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02e8c:	2802      	cmp	r0, #2
c0d02e8e:	d80c      	bhi.n	c0d02eaa <USBD_SetFeature+0x32>
c0d02e90:	00c0      	lsls	r0, r0, #3
c0d02e92:	1820      	adds	r0, r4, r0
c0d02e94:	21f4      	movs	r1, #244	; 0xf4
c0d02e96:	5840      	ldr	r0, [r0, r1]
{

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
  {
    pdev->dev_remote_wakeup = 1;  
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02e98:	2800      	cmp	r0, #0
c0d02e9a:	d006      	beq.n	c0d02eaa <USBD_SetFeature+0x32>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d02e9c:	6880      	ldr	r0, [r0, #8]
c0d02e9e:	f7fe fcf7 	bl	c0d01890 <pic>
c0d02ea2:	4602      	mov	r2, r0
c0d02ea4:	4620      	mov	r0, r4
c0d02ea6:	4629      	mov	r1, r5
c0d02ea8:	4790      	blx	r2
    }
    USBD_CtlSendStatus(pdev);
c0d02eaa:	4620      	mov	r0, r4
c0d02eac:	f000 fb9d 	bl	c0d035ea <USBD_CtlSendStatus>
  }

}
c0d02eb0:	bdb0      	pop	{r4, r5, r7, pc}

c0d02eb2 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02eb2:	b5b0      	push	{r4, r5, r7, lr}
c0d02eb4:	460d      	mov	r5, r1
c0d02eb6:	4604      	mov	r4, r0
c0d02eb8:	20dc      	movs	r0, #220	; 0xdc
  switch (pdev->dev_state)
c0d02eba:	5c20      	ldrb	r0, [r4, r0]
c0d02ebc:	21fe      	movs	r1, #254	; 0xfe
c0d02ebe:	4001      	ands	r1, r0
c0d02ec0:	2902      	cmp	r1, #2
c0d02ec2:	d119      	bne.n	c0d02ef8 <USBD_ClrFeature+0x46>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02ec4:	8868      	ldrh	r0, [r5, #2]
c0d02ec6:	2801      	cmp	r0, #1
c0d02ec8:	d11a      	bne.n	c0d02f00 <USBD_ClrFeature+0x4e>
c0d02eca:	20e4      	movs	r0, #228	; 0xe4
c0d02ecc:	2100      	movs	r1, #0
    {
      pdev->dev_remote_wakeup = 0; 
c0d02ece:	5021      	str	r1, [r4, r0]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02ed0:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02ed2:	2802      	cmp	r0, #2
c0d02ed4:	d80c      	bhi.n	c0d02ef0 <USBD_ClrFeature+0x3e>
c0d02ed6:	00c0      	lsls	r0, r0, #3
c0d02ed8:	1820      	adds	r0, r4, r0
c0d02eda:	21f4      	movs	r1, #244	; 0xf4
c0d02edc:	5840      	ldr	r0, [r0, r1]
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
    {
      pdev->dev_remote_wakeup = 0; 
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02ede:	2800      	cmp	r0, #0
c0d02ee0:	d006      	beq.n	c0d02ef0 <USBD_ClrFeature+0x3e>
        ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d02ee2:	6880      	ldr	r0, [r0, #8]
c0d02ee4:	f7fe fcd4 	bl	c0d01890 <pic>
c0d02ee8:	4602      	mov	r2, r0
c0d02eea:	4620      	mov	r0, r4
c0d02eec:	4629      	mov	r1, r5
c0d02eee:	4790      	blx	r2
      }
      USBD_CtlSendStatus(pdev);
c0d02ef0:	4620      	mov	r0, r4
c0d02ef2:	f000 fb7a 	bl	c0d035ea <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02ef6:	bdb0      	pop	{r4, r5, r7, pc}
      USBD_CtlSendStatus(pdev);
    }
    break;
    
  default :
     USBD_CtlError(pdev , req);
c0d02ef8:	4620      	mov	r0, r4
c0d02efa:	4629      	mov	r1, r5
c0d02efc:	f000 fa7c 	bl	c0d033f8 <USBD_CtlError>
    break;
  }
}
c0d02f00:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f02 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02f02:	b5b0      	push	{r4, r5, r7, lr}
c0d02f04:	460d      	mov	r5, r1
c0d02f06:	4604      	mov	r4, r0
c0d02f08:	20dc      	movs	r0, #220	; 0xdc
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02f0a:	5c20      	ldrb	r0, [r4, r0]
c0d02f0c:	2803      	cmp	r0, #3
c0d02f0e:	d116      	bne.n	c0d02f3e <USBD_StdItfReq+0x3c>
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d02f10:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02f12:	2802      	cmp	r0, #2
c0d02f14:	d813      	bhi.n	c0d02f3e <USBD_StdItfReq+0x3c>
c0d02f16:	00c0      	lsls	r0, r0, #3
c0d02f18:	1820      	adds	r0, r4, r0
c0d02f1a:	21f4      	movs	r1, #244	; 0xf4
c0d02f1c:	5840      	ldr	r0, [r0, r1]
  
  switch (pdev->dev_state) 
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d02f1e:	2800      	cmp	r0, #0
c0d02f20:	d00d      	beq.n	c0d02f3e <USBD_StdItfReq+0x3c>
    {
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d02f22:	6880      	ldr	r0, [r0, #8]
c0d02f24:	f7fe fcb4 	bl	c0d01890 <pic>
c0d02f28:	4602      	mov	r2, r0
c0d02f2a:	4620      	mov	r0, r4
c0d02f2c:	4629      	mov	r1, r5
c0d02f2e:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02f30:	88e8      	ldrh	r0, [r5, #6]
c0d02f32:	2800      	cmp	r0, #0
c0d02f34:	d107      	bne.n	c0d02f46 <USBD_StdItfReq+0x44>
      {
         USBD_CtlSendStatus(pdev);
c0d02f36:	4620      	mov	r0, r4
c0d02f38:	f000 fb57 	bl	c0d035ea <USBD_CtlSendStatus>
c0d02f3c:	e003      	b.n	c0d02f46 <USBD_StdItfReq+0x44>
c0d02f3e:	4620      	mov	r0, r4
c0d02f40:	4629      	mov	r1, r5
c0d02f42:	f000 fa59 	bl	c0d033f8 <USBD_CtlError>
c0d02f46:	2000      	movs	r0, #0
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02f48:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f4a <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02f4a:	b5b0      	push	{r4, r5, r7, lr}
c0d02f4c:	460d      	mov	r5, r1
c0d02f4e:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d02f50:	7808      	ldrb	r0, [r1, #0]
c0d02f52:	2260      	movs	r2, #96	; 0x60
c0d02f54:	4002      	ands	r2, r0
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02f56:	7909      	ldrb	r1, [r1, #4]
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d02f58:	2a20      	cmp	r2, #32
c0d02f5a:	d10f      	bne.n	c0d02f7c <USBD_StdEPReq+0x32>
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02f5c:	2902      	cmp	r1, #2
c0d02f5e:	d80d      	bhi.n	c0d02f7c <USBD_StdEPReq+0x32>
c0d02f60:	00c8      	lsls	r0, r1, #3
c0d02f62:	1820      	adds	r0, r4, r0
c0d02f64:	22f4      	movs	r2, #244	; 0xf4
c0d02f66:	5880      	ldr	r0, [r0, r2]
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d02f68:	2800      	cmp	r0, #0
c0d02f6a:	d007      	beq.n	c0d02f7c <USBD_StdEPReq+0x32>
  {
    ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d02f6c:	6880      	ldr	r0, [r0, #8]
c0d02f6e:	f7fe fc8f 	bl	c0d01890 <pic>
c0d02f72:	4602      	mov	r2, r0
c0d02f74:	4620      	mov	r0, r4
c0d02f76:	4629      	mov	r1, r5
c0d02f78:	4790      	blx	r2
c0d02f7a:	e068      	b.n	c0d0304e <USBD_StdEPReq+0x104>
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02f7c:	7868      	ldrb	r0, [r5, #1]
c0d02f7e:	2800      	cmp	r0, #0
c0d02f80:	d016      	beq.n	c0d02fb0 <USBD_StdEPReq+0x66>
c0d02f82:	2801      	cmp	r0, #1
c0d02f84:	d01d      	beq.n	c0d02fc2 <USBD_StdEPReq+0x78>
c0d02f86:	2803      	cmp	r0, #3
c0d02f88:	d161      	bne.n	c0d0304e <USBD_StdEPReq+0x104>
c0d02f8a:	20dc      	movs	r0, #220	; 0xdc
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02f8c:	5c20      	ldrb	r0, [r4, r0]
c0d02f8e:	2803      	cmp	r0, #3
c0d02f90:	d11b      	bne.n	c0d02fca <USBD_StdEPReq+0x80>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02f92:	8868      	ldrh	r0, [r5, #2]
c0d02f94:	2800      	cmp	r0, #0
c0d02f96:	d107      	bne.n	c0d02fa8 <USBD_StdEPReq+0x5e>
c0d02f98:	2080      	movs	r0, #128	; 0x80
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02f9a:	4308      	orrs	r0, r1
c0d02f9c:	2880      	cmp	r0, #128	; 0x80
c0d02f9e:	d003      	beq.n	c0d02fa8 <USBD_StdEPReq+0x5e>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d02fa0:	4620      	mov	r0, r4
c0d02fa2:	f7ff fbc1 	bl	c0d02728 <USBD_LL_StallEP>
          
        }
c0d02fa6:	7929      	ldrb	r1, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02fa8:	2902      	cmp	r1, #2
c0d02faa:	d84d      	bhi.n	c0d03048 <USBD_StdEPReq+0xfe>
c0d02fac:	00c8      	lsls	r0, r1, #3
c0d02fae:	e03f      	b.n	c0d03030 <USBD_StdEPReq+0xe6>
c0d02fb0:	20dc      	movs	r0, #220	; 0xdc
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02fb2:	5c20      	ldrb	r0, [r4, r0]
c0d02fb4:	2803      	cmp	r0, #3
c0d02fb6:	d017      	beq.n	c0d02fe8 <USBD_StdEPReq+0x9e>
c0d02fb8:	2802      	cmp	r0, #2
c0d02fba:	d110      	bne.n	c0d02fde <USBD_StdEPReq+0x94>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02fbc:	0648      	lsls	r0, r1, #25
c0d02fbe:	d10a      	bne.n	c0d02fd6 <USBD_StdEPReq+0x8c>
c0d02fc0:	e045      	b.n	c0d0304e <USBD_StdEPReq+0x104>
c0d02fc2:	20dc      	movs	r0, #220	; 0xdc
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d02fc4:	5c20      	ldrb	r0, [r4, r0]
c0d02fc6:	2803      	cmp	r0, #3
c0d02fc8:	d026      	beq.n	c0d03018 <USBD_StdEPReq+0xce>
c0d02fca:	2802      	cmp	r0, #2
c0d02fcc:	d107      	bne.n	c0d02fde <USBD_StdEPReq+0x94>
c0d02fce:	2080      	movs	r0, #128	; 0x80
c0d02fd0:	4308      	orrs	r0, r1
c0d02fd2:	2880      	cmp	r0, #128	; 0x80
c0d02fd4:	d03b      	beq.n	c0d0304e <USBD_StdEPReq+0x104>
c0d02fd6:	4620      	mov	r0, r4
c0d02fd8:	f7ff fba6 	bl	c0d02728 <USBD_LL_StallEP>
c0d02fdc:	e037      	b.n	c0d0304e <USBD_StdEPReq+0x104>
c0d02fde:	4620      	mov	r0, r4
c0d02fe0:	4629      	mov	r1, r5
c0d02fe2:	f000 fa09 	bl	c0d033f8 <USBD_CtlError>
c0d02fe6:	e032      	b.n	c0d0304e <USBD_StdEPReq+0x104>
c0d02fe8:	207f      	movs	r0, #127	; 0x7f
c0d02fea:	4008      	ands	r0, r1
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02fec:	0100      	lsls	r0, r0, #4
c0d02fee:	1820      	adds	r0, r4, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d02ff0:	4605      	mov	r5, r0
c0d02ff2:	3574      	adds	r5, #116	; 0x74
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d02ff4:	3014      	adds	r0, #20
c0d02ff6:	060a      	lsls	r2, r1, #24
c0d02ff8:	d500      	bpl.n	c0d02ffc <USBD_StdEPReq+0xb2>
c0d02ffa:	4605      	mov	r5, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d02ffc:	4620      	mov	r0, r4
c0d02ffe:	f7ff fbdb 	bl	c0d027b8 <USBD_LL_IsStallEP>
c0d03002:	2101      	movs	r1, #1
c0d03004:	2800      	cmp	r0, #0
c0d03006:	d100      	bne.n	c0d0300a <USBD_StdEPReq+0xc0>
c0d03008:	4601      	mov	r1, r0
c0d0300a:	6029      	str	r1, [r5, #0]
c0d0300c:	2202      	movs	r2, #2
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d0300e:	4620      	mov	r0, r4
c0d03010:	4629      	mov	r1, r5
c0d03012:	f000 fabf 	bl	c0d03594 <USBD_CtlSendData>
c0d03016:	e01a      	b.n	c0d0304e <USBD_StdEPReq+0x104>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d03018:	8868      	ldrh	r0, [r5, #2]
c0d0301a:	2800      	cmp	r0, #0
c0d0301c:	d117      	bne.n	c0d0304e <USBD_StdEPReq+0x104>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d0301e:	0648      	lsls	r0, r1, #25
c0d03020:	d012      	beq.n	c0d03048 <USBD_StdEPReq+0xfe>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d03022:	4620      	mov	r0, r4
c0d03024:	f7ff fba4 	bl	c0d02770 <USBD_LL_ClearStallEP>
          if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d03028:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d0302a:	2802      	cmp	r0, #2
c0d0302c:	d80c      	bhi.n	c0d03048 <USBD_StdEPReq+0xfe>
c0d0302e:	00c0      	lsls	r0, r0, #3
c0d03030:	1820      	adds	r0, r4, r0
c0d03032:	21f4      	movs	r1, #244	; 0xf4
c0d03034:	5840      	ldr	r0, [r0, r1]
c0d03036:	2800      	cmp	r0, #0
c0d03038:	d006      	beq.n	c0d03048 <USBD_StdEPReq+0xfe>
c0d0303a:	6880      	ldr	r0, [r0, #8]
c0d0303c:	f7fe fc28 	bl	c0d01890 <pic>
c0d03040:	4602      	mov	r2, r0
c0d03042:	4620      	mov	r0, r4
c0d03044:	4629      	mov	r1, r5
c0d03046:	4790      	blx	r2
c0d03048:	4620      	mov	r0, r4
c0d0304a:	f000 face 	bl	c0d035ea <USBD_CtlSendStatus>
c0d0304e:	2000      	movs	r0, #0
    
  default:
    break;
  }
  return ret;
}
c0d03050:	bdb0      	pop	{r4, r5, r7, pc}

c0d03052 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d03052:	780a      	ldrb	r2, [r1, #0]
c0d03054:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d03056:	784a      	ldrb	r2, [r1, #1]
c0d03058:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d0305a:	788a      	ldrb	r2, [r1, #2]
c0d0305c:	78cb      	ldrb	r3, [r1, #3]
c0d0305e:	021b      	lsls	r3, r3, #8
c0d03060:	189a      	adds	r2, r3, r2
c0d03062:	8042      	strh	r2, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d03064:	790a      	ldrb	r2, [r1, #4]
c0d03066:	794b      	ldrb	r3, [r1, #5]
c0d03068:	021b      	lsls	r3, r3, #8
c0d0306a:	189a      	adds	r2, r3, r2
c0d0306c:	8082      	strh	r2, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d0306e:	798a      	ldrb	r2, [r1, #6]
c0d03070:	79c9      	ldrb	r1, [r1, #7]
c0d03072:	0209      	lsls	r1, r1, #8
c0d03074:	1889      	adds	r1, r1, r2
c0d03076:	80c1      	strh	r1, [r0, #6]

}
c0d03078:	4770      	bx	lr

c0d0307a <USBD_CtlStall>:
* @param  pdev: device instance
* @param  req: usb request
* @retval None
*/
void USBD_CtlStall( USBD_HandleTypeDef *pdev)
{
c0d0307a:	b510      	push	{r4, lr}
c0d0307c:	4604      	mov	r4, r0
c0d0307e:	2180      	movs	r1, #128	; 0x80
  USBD_LL_StallEP(pdev , 0x80);
c0d03080:	f7ff fb52 	bl	c0d02728 <USBD_LL_StallEP>
c0d03084:	2100      	movs	r1, #0
  USBD_LL_StallEP(pdev , 0);
c0d03086:	4620      	mov	r0, r4
c0d03088:	f7ff fb4e 	bl	c0d02728 <USBD_LL_StallEP>
}
c0d0308c:	bd10      	pop	{r4, pc}

c0d0308e <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d0308e:	b570      	push	{r4, r5, r6, lr}
c0d03090:	b082      	sub	sp, #8
c0d03092:	460d      	mov	r5, r1
c0d03094:	4604      	mov	r4, r0
c0d03096:	a901      	add	r1, sp, #4
c0d03098:	2000      	movs	r0, #0
  uint16_t len = 0;
c0d0309a:	8008      	strh	r0, [r1, #0]
c0d0309c:	4669      	mov	r1, sp
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d0309e:	7008      	strb	r0, [r1, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d030a0:	782a      	ldrb	r2, [r5, #0]
c0d030a2:	2160      	movs	r1, #96	; 0x60
c0d030a4:	4011      	ands	r1, r2
c0d030a6:	2900      	cmp	r1, #0
c0d030a8:	d010      	beq.n	c0d030cc <USBD_HID_Setup+0x3e>
c0d030aa:	2920      	cmp	r1, #32
c0d030ac:	d138      	bne.n	c0d03120 <USBD_HID_Setup+0x92>
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d030ae:	7869      	ldrb	r1, [r5, #1]
c0d030b0:	460a      	mov	r2, r1
c0d030b2:	3a0a      	subs	r2, #10
c0d030b4:	2a02      	cmp	r2, #2
c0d030b6:	d333      	bcc.n	c0d03120 <USBD_HID_Setup+0x92>
c0d030b8:	2902      	cmp	r1, #2
c0d030ba:	d01b      	beq.n	c0d030f4 <USBD_HID_Setup+0x66>
c0d030bc:	2903      	cmp	r1, #3
c0d030be:	d019      	beq.n	c0d030f4 <USBD_HID_Setup+0x66>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d030c0:	4620      	mov	r0, r4
c0d030c2:	4629      	mov	r1, r5
c0d030c4:	f000 f998 	bl	c0d033f8 <USBD_CtlError>
c0d030c8:	2002      	movs	r0, #2
c0d030ca:	e029      	b.n	c0d03120 <USBD_HID_Setup+0x92>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d030cc:	7869      	ldrb	r1, [r5, #1]
c0d030ce:	290b      	cmp	r1, #11
c0d030d0:	d013      	beq.n	c0d030fa <USBD_HID_Setup+0x6c>
c0d030d2:	290a      	cmp	r1, #10
c0d030d4:	d00e      	beq.n	c0d030f4 <USBD_HID_Setup+0x66>
c0d030d6:	2906      	cmp	r1, #6
c0d030d8:	d122      	bne.n	c0d03120 <USBD_HID_Setup+0x92>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d030da:	8868      	ldrh	r0, [r5, #2]
c0d030dc:	0a00      	lsrs	r0, r0, #8
c0d030de:	2200      	movs	r2, #0
c0d030e0:	2821      	cmp	r0, #33	; 0x21
c0d030e2:	d00e      	beq.n	c0d03102 <USBD_HID_Setup+0x74>
c0d030e4:	2822      	cmp	r0, #34	; 0x22
c0d030e6:	4611      	mov	r1, r2
c0d030e8:	d116      	bne.n	c0d03118 <USBD_HID_Setup+0x8a>
c0d030ea:	ae01      	add	r6, sp, #4
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d030ec:	4630      	mov	r0, r6
c0d030ee:	f000 f857 	bl	c0d031a0 <USBD_HID_GetReportDescriptor_impl>
c0d030f2:	e00a      	b.n	c0d0310a <USBD_HID_Setup+0x7c>
c0d030f4:	4669      	mov	r1, sp
c0d030f6:	2201      	movs	r2, #1
c0d030f8:	e00e      	b.n	c0d03118 <USBD_HID_Setup+0x8a>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d030fa:	4620      	mov	r0, r4
c0d030fc:	f000 fa75 	bl	c0d035ea <USBD_CtlSendStatus>
c0d03100:	e00d      	b.n	c0d0311e <USBD_HID_Setup+0x90>
c0d03102:	ae01      	add	r6, sp, #4
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d03104:	4630      	mov	r0, r6
c0d03106:	f000 f831 	bl	c0d0316c <USBD_HID_GetHidDescriptor_impl>
c0d0310a:	4601      	mov	r1, r0
c0d0310c:	8832      	ldrh	r2, [r6, #0]
c0d0310e:	88e8      	ldrh	r0, [r5, #6]
c0d03110:	4282      	cmp	r2, r0
c0d03112:	d300      	bcc.n	c0d03116 <USBD_HID_Setup+0x88>
c0d03114:	4602      	mov	r2, r0
c0d03116:	8032      	strh	r2, [r6, #0]
c0d03118:	4620      	mov	r0, r4
c0d0311a:	f000 fa3b 	bl	c0d03594 <USBD_CtlSendData>
c0d0311e:	2000      	movs	r0, #0
      
    }
  }

  return USBD_OK;
}
c0d03120:	b002      	add	sp, #8
c0d03122:	bd70      	pop	{r4, r5, r6, pc}

c0d03124 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d03124:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03126:	b081      	sub	sp, #4
c0d03128:	4604      	mov	r4, r0
c0d0312a:	2182      	movs	r1, #130	; 0x82
c0d0312c:	2603      	movs	r6, #3
c0d0312e:	2540      	movs	r5, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d03130:	4632      	mov	r2, r6
c0d03132:	462b      	mov	r3, r5
c0d03134:	f7ff fab2 	bl	c0d0269c <USBD_LL_OpenEP>
c0d03138:	2702      	movs	r7, #2
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d0313a:	4620      	mov	r0, r4
c0d0313c:	4639      	mov	r1, r7
c0d0313e:	4632      	mov	r2, r6
c0d03140:	462b      	mov	r3, r5
c0d03142:	f7ff faab 	bl	c0d0269c <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d03146:	4620      	mov	r0, r4
c0d03148:	4639      	mov	r1, r7
c0d0314a:	462a      	mov	r2, r5
c0d0314c:	f7ff fb6f 	bl	c0d0282e <USBD_LL_PrepareReceive>
c0d03150:	2000      	movs	r0, #0
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d03152:	b001      	add	sp, #4
c0d03154:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03156 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d03156:	b510      	push	{r4, lr}
c0d03158:	4604      	mov	r4, r0
c0d0315a:	2182      	movs	r1, #130	; 0x82
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d0315c:	f7ff face 	bl	c0d026fc <USBD_LL_CloseEP>
c0d03160:	2102      	movs	r1, #2
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d03162:	4620      	mov	r0, r4
c0d03164:	f7ff faca 	bl	c0d026fc <USBD_LL_CloseEP>
c0d03168:	2000      	movs	r0, #0
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d0316a:	bd10      	pop	{r4, pc}

c0d0316c <USBD_HID_GetHidDescriptor_impl>:
{
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
c0d0316c:	21ec      	movs	r1, #236	; 0xec
  switch (USBD_Device.request.wIndex&0xFF) {
c0d0316e:	4a09      	ldr	r2, [pc, #36]	; (c0d03194 <USBD_HID_GetHidDescriptor_impl+0x28>)
c0d03170:	5c51      	ldrb	r1, [r2, r1]
c0d03172:	2209      	movs	r2, #9
c0d03174:	2901      	cmp	r1, #1
c0d03176:	d005      	beq.n	c0d03184 <USBD_HID_GetHidDescriptor_impl+0x18>
c0d03178:	2900      	cmp	r1, #0
c0d0317a:	d106      	bne.n	c0d0318a <USBD_HID_GetHidDescriptor_impl+0x1e>
c0d0317c:	4907      	ldr	r1, [pc, #28]	; (c0d0319c <USBD_HID_GetHidDescriptor_impl+0x30>)
c0d0317e:	4479      	add	r1, pc
c0d03180:	2209      	movs	r2, #9
c0d03182:	e004      	b.n	c0d0318e <USBD_HID_GetHidDescriptor_impl+0x22>
c0d03184:	4904      	ldr	r1, [pc, #16]	; (c0d03198 <USBD_HID_GetHidDescriptor_impl+0x2c>)
c0d03186:	4479      	add	r1, pc
c0d03188:	e001      	b.n	c0d0318e <USBD_HID_GetHidDescriptor_impl+0x22>
c0d0318a:	2200      	movs	r2, #0
c0d0318c:	4611      	mov	r1, r2
c0d0318e:	8002      	strh	r2, [r0, #0]
      *len = sizeof(USBD_HID_Desc);
      return (uint8_t*)USBD_HID_Desc; 
  }
  *len = 0;
  return 0;
}
c0d03190:	4608      	mov	r0, r1
c0d03192:	4770      	bx	lr
c0d03194:	20001d28 	.word	0x20001d28
c0d03198:	000019d2 	.word	0x000019d2
c0d0319c:	000019e6 	.word	0x000019e6

c0d031a0 <USBD_HID_GetReportDescriptor_impl>:

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
c0d031a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d031a2:	b081      	sub	sp, #4
c0d031a4:	4604      	mov	r4, r0
c0d031a6:	20ec      	movs	r0, #236	; 0xec
  switch (USBD_Device.request.wIndex&0xFF) {
c0d031a8:	4913      	ldr	r1, [pc, #76]	; (c0d031f8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d031aa:	5c08      	ldrb	r0, [r1, r0]
c0d031ac:	2122      	movs	r1, #34	; 0x22
c0d031ae:	2800      	cmp	r0, #0
c0d031b0:	d019      	beq.n	c0d031e6 <USBD_HID_GetReportDescriptor_impl+0x46>
c0d031b2:	2801      	cmp	r0, #1
c0d031b4:	d11a      	bne.n	c0d031ec <USBD_HID_GetReportDescriptor_impl+0x4c>
#ifdef HAVE_IO_U2F
  case U2F_INTF:

    // very dirty work due to lack of callback when USB_HID_Init is called
    USBD_LL_OpenEP(&USBD_Device,
c0d031b6:	4810      	ldr	r0, [pc, #64]	; (c0d031f8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d031b8:	2181      	movs	r1, #129	; 0x81
c0d031ba:	2703      	movs	r7, #3
c0d031bc:	2640      	movs	r6, #64	; 0x40
c0d031be:	463a      	mov	r2, r7
c0d031c0:	4633      	mov	r3, r6
c0d031c2:	f7ff fa6b 	bl	c0d0269c <USBD_LL_OpenEP>
c0d031c6:	2501      	movs	r5, #1
                   U2F_EPIN_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPIN_SIZE);
    
    USBD_LL_OpenEP(&USBD_Device,
c0d031c8:	480b      	ldr	r0, [pc, #44]	; (c0d031f8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d031ca:	4629      	mov	r1, r5
c0d031cc:	463a      	mov	r2, r7
c0d031ce:	4633      	mov	r3, r6
c0d031d0:	f7ff fa64 	bl	c0d0269c <USBD_LL_OpenEP>
                   U2F_EPOUT_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPOUT_SIZE);

    /* Prepare Out endpoint to receive 1st packet */ 
    USBD_LL_PrepareReceive(&USBD_Device, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d031d4:	4808      	ldr	r0, [pc, #32]	; (c0d031f8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d031d6:	4629      	mov	r1, r5
c0d031d8:	4632      	mov	r2, r6
c0d031da:	f7ff fb28 	bl	c0d0282e <USBD_LL_PrepareReceive>
c0d031de:	4808      	ldr	r0, [pc, #32]	; (c0d03200 <USBD_HID_GetReportDescriptor_impl+0x60>)
c0d031e0:	4478      	add	r0, pc
c0d031e2:	2122      	movs	r1, #34	; 0x22
c0d031e4:	e004      	b.n	c0d031f0 <USBD_HID_GetReportDescriptor_impl+0x50>
c0d031e6:	4805      	ldr	r0, [pc, #20]	; (c0d031fc <USBD_HID_GetReportDescriptor_impl+0x5c>)
c0d031e8:	4478      	add	r0, pc
c0d031ea:	e001      	b.n	c0d031f0 <USBD_HID_GetReportDescriptor_impl+0x50>
c0d031ec:	2100      	movs	r1, #0
c0d031ee:	4608      	mov	r0, r1
c0d031f0:	8021      	strh	r1, [r4, #0]
    *len = sizeof(HID_ReportDesc);
    return (uint8_t*)HID_ReportDesc;
  }
  *len = 0;
  return 0;
}
c0d031f2:	b001      	add	sp, #4
c0d031f4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d031f6:	46c0      	nop			; (mov r8, r8)
c0d031f8:	20001d28 	.word	0x20001d28
c0d031fc:	000019a7 	.word	0x000019a7
c0d03200:	0000198d 	.word	0x0000198d

c0d03204 <USBD_U2F_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_U2F_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d03204:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03206:	b081      	sub	sp, #4
c0d03208:	4604      	mov	r4, r0
c0d0320a:	2181      	movs	r1, #129	; 0x81
c0d0320c:	2603      	movs	r6, #3
c0d0320e:	2540      	movs	r5, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d03210:	4632      	mov	r2, r6
c0d03212:	462b      	mov	r3, r5
c0d03214:	f7ff fa42 	bl	c0d0269c <USBD_LL_OpenEP>
c0d03218:	2701      	movs	r7, #1
                 U2F_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d0321a:	4620      	mov	r0, r4
c0d0321c:	4639      	mov	r1, r7
c0d0321e:	4632      	mov	r2, r6
c0d03220:	462b      	mov	r3, r5
c0d03222:	f7ff fa3b 	bl	c0d0269c <USBD_LL_OpenEP>
                 U2F_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d03226:	4620      	mov	r0, r4
c0d03228:	4639      	mov	r1, r7
c0d0322a:	462a      	mov	r2, r5
c0d0322c:	f7ff faff 	bl	c0d0282e <USBD_LL_PrepareReceive>
c0d03230:	2000      	movs	r0, #0

  return USBD_OK;
c0d03232:	b001      	add	sp, #4
c0d03234:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d03238 <USBD_U2F_DataIn_impl>:
}

uint8_t  USBD_U2F_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d03238:	b580      	push	{r7, lr}
  UNUSED(pdev);
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d0323a:	2901      	cmp	r1, #1
c0d0323c:	d103      	bne.n	c0d03246 <USBD_U2F_DataIn_impl+0xe>
  // FIDO endpoint
  case (U2F_EPIN_ADDR&0x7F):
    // advance the u2f sending machine state
    u2f_transport_sent(&G_io_u2f, U2F_MEDIA_USB);
c0d0323e:	4803      	ldr	r0, [pc, #12]	; (c0d0324c <USBD_U2F_DataIn_impl+0x14>)
c0d03240:	2101      	movs	r1, #1
c0d03242:	f7fe fe65 	bl	c0d01f10 <u2f_transport_sent>
c0d03246:	2000      	movs	r0, #0
    break;
  } 
  return USBD_OK;
c0d03248:	bd80      	pop	{r7, pc}
c0d0324a:	46c0      	nop			; (mov r8, r8)
c0d0324c:	20001c08 	.word	0x20001c08

c0d03250 <USBD_U2F_DataOut_impl>:
}

uint8_t  USBD_U2F_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03250:	b5b0      	push	{r4, r5, r7, lr}
  switch (epnum) {
c0d03252:	2901      	cmp	r1, #1
c0d03254:	d10e      	bne.n	c0d03274 <USBD_U2F_DataOut_impl+0x24>
c0d03256:	4614      	mov	r4, r2
c0d03258:	2501      	movs	r5, #1
c0d0325a:	2240      	movs	r2, #64	; 0x40
  // FIDO endpoint
  case (U2F_EPOUT_ADDR&0x7F):
      USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR , U2F_EPOUT_SIZE);
c0d0325c:	4629      	mov	r1, r5
c0d0325e:	f7ff fae6 	bl	c0d0282e <USBD_LL_PrepareReceive>
      u2f_transport_received(&G_io_u2f, buffer, io_seproxyhal_get_ep_rx_size(U2F_EPOUT_ADDR), U2F_MEDIA_USB);
c0d03262:	4628      	mov	r0, r5
c0d03264:	f7fd fcb2 	bl	c0d00bcc <io_seproxyhal_get_ep_rx_size>
c0d03268:	4602      	mov	r2, r0
c0d0326a:	4803      	ldr	r0, [pc, #12]	; (c0d03278 <USBD_U2F_DataOut_impl+0x28>)
c0d0326c:	4621      	mov	r1, r4
c0d0326e:	462b      	mov	r3, r5
c0d03270:	f7fe ffa6 	bl	c0d021c0 <u2f_transport_received>
c0d03274:	2000      	movs	r0, #0
    break;
  }

  return USBD_OK;
c0d03276:	bdb0      	pop	{r4, r5, r7, pc}
c0d03278:	20001c08 	.word	0x20001c08

c0d0327c <USBD_HID_DataIn_impl>:
}
#endif // HAVE_IO_U2F

uint8_t  USBD_HID_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d0327c:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d0327e:	2902      	cmp	r1, #2
c0d03280:	d103      	bne.n	c0d0328a <USBD_HID_DataIn_impl+0xe>
    // HID gen endpoint
    case (HID_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data);
c0d03282:	4803      	ldr	r0, [pc, #12]	; (c0d03290 <USBD_HID_DataIn_impl+0x14>)
c0d03284:	4478      	add	r0, pc
c0d03286:	f7fe f8cd 	bl	c0d01424 <io_usb_hid_sent>
c0d0328a:	2000      	movs	r0, #0
      break;
  }

  return USBD_OK;
c0d0328c:	bd80      	pop	{r7, pc}
c0d0328e:	46c0      	nop			; (mov r8, r8)
c0d03290:	ffffda11 	.word	0xffffda11

c0d03294 <USBD_HID_DataOut_impl>:
}

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03294:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d03296:	2902      	cmp	r1, #2
c0d03298:	d11a      	bne.n	c0d032d0 <USBD_HID_DataOut_impl+0x3c>
c0d0329a:	4614      	mov	r4, r2
c0d0329c:	2102      	movs	r1, #2
c0d0329e:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (HID_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d032a0:	f7ff fac5 	bl	c0d0282e <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d032a4:	4d0b      	ldr	r5, [pc, #44]	; (c0d032d4 <USBD_HID_DataOut_impl+0x40>)
c0d032a6:	79a8      	ldrb	r0, [r5, #6]
c0d032a8:	2800      	cmp	r0, #0
c0d032aa:	d111      	bne.n	c0d032d0 <USBD_HID_DataOut_impl+0x3c>
c0d032ac:	2002      	movs	r0, #2
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d032ae:	f7fd fc8d 	bl	c0d00bcc <io_seproxyhal_get_ep_rx_size>
c0d032b2:	4602      	mov	r2, r0
c0d032b4:	4809      	ldr	r0, [pc, #36]	; (c0d032dc <USBD_HID_DataOut_impl+0x48>)
c0d032b6:	4478      	add	r0, pc
c0d032b8:	4621      	mov	r1, r4
c0d032ba:	f7fe f807 	bl	c0d012cc <io_usb_hid_receive>
c0d032be:	2802      	cmp	r0, #2
c0d032c0:	d106      	bne.n	c0d032d0 <USBD_HID_DataOut_impl+0x3c>
c0d032c2:	2007      	movs	r0, #7
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
          G_io_app.apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d032c4:	7028      	strb	r0, [r5, #0]
c0d032c6:	2001      	movs	r0, #1
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d032c8:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_state = APDU_USB_HID; // for next call to io_exchange
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d032ca:	4803      	ldr	r0, [pc, #12]	; (c0d032d8 <USBD_HID_DataOut_impl+0x44>)
c0d032cc:	6800      	ldr	r0, [r0, #0]
c0d032ce:	8068      	strh	r0, [r5, #2]
c0d032d0:	2000      	movs	r0, #0
      }
    }
    break;
  }

  return USBD_OK;
c0d032d2:	bdb0      	pop	{r4, r5, r7, pc}
c0d032d4:	20001be0 	.word	0x20001be0
c0d032d8:	20001c90 	.word	0x20001c90
c0d032dc:	ffffd9df 	.word	0xffffd9df

c0d032e0 <USBD_WEBUSB_Init>:

#ifdef HAVE_WEBUSB

uint8_t  USBD_WEBUSB_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d032e0:	b570      	push	{r4, r5, r6, lr}
c0d032e2:	4604      	mov	r4, r0
c0d032e4:	2183      	movs	r1, #131	; 0x83
c0d032e6:	2503      	movs	r5, #3
c0d032e8:	2640      	movs	r6, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d032ea:	462a      	mov	r2, r5
c0d032ec:	4633      	mov	r3, r6
c0d032ee:	f7ff f9d5 	bl	c0d0269c <USBD_LL_OpenEP>
                 WEBUSB_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d032f2:	4620      	mov	r0, r4
c0d032f4:	4629      	mov	r1, r5
c0d032f6:	462a      	mov	r2, r5
c0d032f8:	4633      	mov	r3, r6
c0d032fa:	f7ff f9cf 	bl	c0d0269c <USBD_LL_OpenEP>
                 WEBUSB_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d032fe:	4620      	mov	r0, r4
c0d03300:	4629      	mov	r1, r5
c0d03302:	4632      	mov	r2, r6
c0d03304:	f7ff fa93 	bl	c0d0282e <USBD_LL_PrepareReceive>
c0d03308:	2000      	movs	r0, #0

  return USBD_OK;
c0d0330a:	bd70      	pop	{r4, r5, r6, pc}

c0d0330c <USBD_WEBUSB_DeInit>:
}

uint8_t  USBD_WEBUSB_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx) {
c0d0330c:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(cfgidx);
  return USBD_OK;
c0d0330e:	4770      	bx	lr

c0d03310 <USBD_WEBUSB_Setup>:
}

uint8_t  USBD_WEBUSB_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d03310:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(req);
  return USBD_OK;
c0d03312:	4770      	bx	lr

c0d03314 <USBD_WEBUSB_DataIn>:
}

uint8_t  USBD_WEBUSB_DataIn (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d03314:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d03316:	2903      	cmp	r1, #3
c0d03318:	d103      	bne.n	c0d03322 <USBD_WEBUSB_DataIn+0xe>
    // HID gen endpoint
    case (WEBUSB_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data_ep0x83);
c0d0331a:	4803      	ldr	r0, [pc, #12]	; (c0d03328 <USBD_WEBUSB_DataIn+0x14>)
c0d0331c:	4478      	add	r0, pc
c0d0331e:	f7fe f881 	bl	c0d01424 <io_usb_hid_sent>
c0d03322:	2000      	movs	r0, #0
      break;
  }
  return USBD_OK;
c0d03324:	bd80      	pop	{r7, pc}
c0d03326:	46c0      	nop			; (mov r8, r8)
c0d03328:	ffffd989 	.word	0xffffd989

c0d0332c <USBD_WEBUSB_DataOut>:
}

uint8_t USBD_WEBUSB_DataOut (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d0332c:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d0332e:	2903      	cmp	r1, #3
c0d03330:	d11a      	bne.n	c0d03368 <USBD_WEBUSB_DataOut+0x3c>
c0d03332:	4614      	mov	r4, r2
c0d03334:	2103      	movs	r1, #3
c0d03336:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (WEBUSB_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d03338:	f7ff fa79 	bl	c0d0282e <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d0333c:	4d0b      	ldr	r5, [pc, #44]	; (c0d0336c <USBD_WEBUSB_DataOut+0x40>)
c0d0333e:	79a8      	ldrb	r0, [r5, #6]
c0d03340:	2800      	cmp	r0, #0
c0d03342:	d111      	bne.n	c0d03368 <USBD_WEBUSB_DataOut+0x3c>
c0d03344:	2003      	movs	r0, #3
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data_ep0x83, buffer, io_seproxyhal_get_ep_rx_size(WEBUSB_EPOUT_ADDR))) {
c0d03346:	f7fd fc41 	bl	c0d00bcc <io_seproxyhal_get_ep_rx_size>
c0d0334a:	4602      	mov	r2, r0
c0d0334c:	4809      	ldr	r0, [pc, #36]	; (c0d03374 <USBD_WEBUSB_DataOut+0x48>)
c0d0334e:	4478      	add	r0, pc
c0d03350:	4621      	mov	r1, r4
c0d03352:	f7fd ffbb 	bl	c0d012cc <io_usb_hid_receive>
c0d03356:	2802      	cmp	r0, #2
c0d03358:	d106      	bne.n	c0d03368 <USBD_WEBUSB_DataOut+0x3c>
c0d0335a:	200b      	movs	r0, #11
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
          G_io_app.apdu_state = APDU_USB_WEBUSB; // for next call to io_exchange
c0d0335c:	7028      	strb	r0, [r5, #0]
c0d0335e:	2005      	movs	r0, #5
      switch(io_usb_hid_receive(io_usb_send_apdu_data_ep0x83, buffer, io_seproxyhal_get_ep_rx_size(WEBUSB_EPOUT_ADDR))) {
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
c0d03360:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_state = APDU_USB_WEBUSB; // for next call to io_exchange
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d03362:	4803      	ldr	r0, [pc, #12]	; (c0d03370 <USBD_WEBUSB_DataOut+0x44>)
c0d03364:	6800      	ldr	r0, [r0, #0]
c0d03366:	8068      	strh	r0, [r5, #2]
c0d03368:	2000      	movs	r0, #0
      }
    }
    break;
  }

  return USBD_OK;
c0d0336a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0336c:	20001be0 	.word	0x20001be0
c0d03370:	20001c90 	.word	0x20001c90
c0d03374:	ffffd957 	.word	0xffffd957

c0d03378 <USBD_DeviceDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03378:	2012      	movs	r0, #18
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d0337a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d0337c:	4801      	ldr	r0, [pc, #4]	; (c0d03384 <USBD_DeviceDescriptor+0xc>)
c0d0337e:	4478      	add	r0, pc
c0d03380:	4770      	bx	lr
c0d03382:	46c0      	nop			; (mov r8, r8)
c0d03384:	00001aa6 	.word	0x00001aa6

c0d03388 <USBD_LangIDStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03388:	2004      	movs	r0, #4
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d0338a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d0338c:	4801      	ldr	r0, [pc, #4]	; (c0d03394 <USBD_LangIDStrDescriptor+0xc>)
c0d0338e:	4478      	add	r0, pc
c0d03390:	4770      	bx	lr
c0d03392:	46c0      	nop			; (mov r8, r8)
c0d03394:	00001aa8 	.word	0x00001aa8

c0d03398 <USBD_ManufacturerStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03398:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d0339a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d0339c:	4801      	ldr	r0, [pc, #4]	; (c0d033a4 <USBD_ManufacturerStrDescriptor+0xc>)
c0d0339e:	4478      	add	r0, pc
c0d033a0:	4770      	bx	lr
c0d033a2:	46c0      	nop			; (mov r8, r8)
c0d033a4:	00001a9c 	.word	0x00001a9c

c0d033a8 <USBD_ProductStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d033a8:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d033aa:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d033ac:	4801      	ldr	r0, [pc, #4]	; (c0d033b4 <USBD_ProductStrDescriptor+0xc>)
c0d033ae:	4478      	add	r0, pc
c0d033b0:	4770      	bx	lr
c0d033b2:	46c0      	nop			; (mov r8, r8)
c0d033b4:	00001a9a 	.word	0x00001a9a

c0d033b8 <USBD_SerialStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d033b8:	200a      	movs	r0, #10
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d033ba:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d033bc:	4801      	ldr	r0, [pc, #4]	; (c0d033c4 <USBD_SerialStrDescriptor+0xc>)
c0d033be:	4478      	add	r0, pc
c0d033c0:	4770      	bx	lr
c0d033c2:	46c0      	nop			; (mov r8, r8)
c0d033c4:	00001a98 	.word	0x00001a98

c0d033c8 <USBD_ConfigStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d033c8:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d033ca:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d033cc:	4801      	ldr	r0, [pc, #4]	; (c0d033d4 <USBD_ConfigStrDescriptor+0xc>)
c0d033ce:	4478      	add	r0, pc
c0d033d0:	4770      	bx	lr
c0d033d2:	46c0      	nop			; (mov r8, r8)
c0d033d4:	00001a7a 	.word	0x00001a7a

c0d033d8 <USBD_InterfaceStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d033d8:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d033da:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d033dc:	4801      	ldr	r0, [pc, #4]	; (c0d033e4 <USBD_InterfaceStrDescriptor+0xc>)
c0d033de:	4478      	add	r0, pc
c0d033e0:	4770      	bx	lr
c0d033e2:	46c0      	nop			; (mov r8, r8)
c0d033e4:	00001a6a 	.word	0x00001a6a

c0d033e8 <USBD_BOSDescriptor>:
};

#endif // HAVE_WEBUSB

static uint8_t *USBD_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d033e8:	2039      	movs	r0, #57	; 0x39
  UNUSED(speed);
#ifdef HAVE_WEBUSB
  *length = sizeof(C_usb_bos);
c0d033ea:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)C_usb_bos;
c0d033ec:	4801      	ldr	r0, [pc, #4]	; (c0d033f4 <USBD_BOSDescriptor+0xc>)
c0d033ee:	4478      	add	r0, pc
c0d033f0:	4770      	bx	lr
c0d033f2:	46c0      	nop			; (mov r8, r8)
c0d033f4:	000017da 	.word	0x000017da

c0d033f8 <USBD_CtlError>:
  '4', 0x00, '6', 0x00, '7', 0x00, '6', 0x00, '5', 0x00, '7', 0x00,
  '2', 0x00, '}', 0x00, 0x00, 0x00, 0x00, 0x00 // propertyData, double unicode nul terminated
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
c0d033f8:	b580      	push	{r7, lr}
#if WEBUSB_URL_SIZE_B > 0
  if ((req->bmRequest & 0x80) && req->bRequest == WEBUSB_VENDOR_CODE && req->wIndex == WEBUSB_REQ_GET_URL
c0d033fa:	780a      	ldrb	r2, [r1, #0]
c0d033fc:	b252      	sxtb	r2, r2
c0d033fe:	2a00      	cmp	r2, #0
c0d03400:	db02      	blt.n	c0d03408 <USBD_CtlError+0x10>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
c0d03402:	f7ff fe3a 	bl	c0d0307a <USBD_CtlStall>
  }
}
c0d03406:	bd80      	pop	{r7, pc}
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
#if WEBUSB_URL_SIZE_B > 0
  if ((req->bmRequest & 0x80) && req->bRequest == WEBUSB_VENDOR_CODE && req->wIndex == WEBUSB_REQ_GET_URL
c0d03408:	784a      	ldrb	r2, [r1, #1]
c0d0340a:	2a06      	cmp	r2, #6
c0d0340c:	d013      	beq.n	c0d03436 <USBD_CtlError+0x3e>
c0d0340e:	2a77      	cmp	r2, #119	; 0x77
c0d03410:	d01f      	beq.n	c0d03452 <USBD_CtlError+0x5a>
c0d03412:	2a1e      	cmp	r2, #30
c0d03414:	d1f5      	bne.n	c0d03402 <USBD_CtlError+0xa>
c0d03416:	888a      	ldrh	r2, [r1, #4]
    // HTTPS url
    && req->wValue == 1) {
c0d03418:	2a02      	cmp	r2, #2
c0d0341a:	d1f2      	bne.n	c0d03402 <USBD_CtlError+0xa>
c0d0341c:	884a      	ldrh	r2, [r1, #2]
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
#if WEBUSB_URL_SIZE_B > 0
  if ((req->bmRequest & 0x80) && req->bRequest == WEBUSB_VENDOR_CODE && req->wIndex == WEBUSB_REQ_GET_URL
c0d0341e:	2a01      	cmp	r2, #1
c0d03420:	d1ef      	bne.n	c0d03402 <USBD_CtlError+0xa>
    // HTTPS url
    && req->wValue == 1) {
    // return the URL descriptor
    USBD_CtlSendData (pdev, (unsigned char*)C_webusb_url_descriptor, MIN(req->wLength, sizeof(C_webusb_url_descriptor)));
c0d03422:	88ca      	ldrh	r2, [r1, #6]
c0d03424:	2117      	movs	r1, #23
c0d03426:	2a17      	cmp	r2, #23
c0d03428:	d300      	bcc.n	c0d0342c <USBD_CtlError+0x34>
c0d0342a:	460a      	mov	r2, r1
c0d0342c:	491d      	ldr	r1, [pc, #116]	; (c0d034a4 <USBD_CtlError+0xac>)
c0d0342e:	4479      	add	r1, pc
c0d03430:	f000 f8b0 	bl	c0d03594 <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d03434:	bd80      	pop	{r7, pc}
  else 
#endif // WEBUSB_URL_SIZE_B
    // SETUP (LE): 0x80 0x06 0x03 0x77 0x00 0x00 0xXX 0xXX
    if ((req->bmRequest & 0x80) 
    && req->bRequest == USB_REQ_GET_DESCRIPTOR 
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
c0d03436:	884a      	ldrh	r2, [r1, #2]
c0d03438:	4b19      	ldr	r3, [pc, #100]	; (c0d034a0 <USBD_CtlError+0xa8>)
    && (req->wValue & 0xFF) == 0xEE) {
c0d0343a:	429a      	cmp	r2, r3
c0d0343c:	d1e1      	bne.n	c0d03402 <USBD_CtlError+0xa>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
c0d0343e:	88ca      	ldrh	r2, [r1, #6]
c0d03440:	2112      	movs	r1, #18
c0d03442:	2a12      	cmp	r2, #18
c0d03444:	d300      	bcc.n	c0d03448 <USBD_CtlError+0x50>
c0d03446:	460a      	mov	r2, r1
c0d03448:	4917      	ldr	r1, [pc, #92]	; (c0d034a8 <USBD_CtlError+0xb0>)
c0d0344a:	4479      	add	r1, pc
c0d0344c:	f000 f8a2 	bl	c0d03594 <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d03450:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
  }
  // SETUP (LE): 0x80 0x77 0x04 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
c0d03452:	888a      	ldrh	r2, [r1, #4]
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
    && (req->wValue & 0xFF) == 0xEE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
  }
  // SETUP (LE): 0x80 0x77 0x04 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
c0d03454:	2a04      	cmp	r2, #4
c0d03456:	d109      	bne.n	c0d0346c <USBD_CtlError+0x74>
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
c0d03458:	88ca      	ldrh	r2, [r1, #6]
c0d0345a:	2128      	movs	r1, #40	; 0x28
c0d0345c:	2a28      	cmp	r2, #40	; 0x28
c0d0345e:	d300      	bcc.n	c0d03462 <USBD_CtlError+0x6a>
c0d03460:	460a      	mov	r2, r1
c0d03462:	4912      	ldr	r1, [pc, #72]	; (c0d034ac <USBD_CtlError+0xb4>)
c0d03464:	4479      	add	r1, pc
c0d03466:	f000 f895 	bl	c0d03594 <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d0346a:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
  }
  // SETUP (LE): 0x80 0x77 0x05 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
c0d0346c:	888a      	ldrh	r2, [r1, #4]
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
  }
  // SETUP (LE): 0x80 0x77 0x05 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
c0d0346e:	2a05      	cmp	r2, #5
c0d03470:	d109      	bne.n	c0d03486 <USBD_CtlError+0x8e>
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
  ) {        
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
c0d03472:	88ca      	ldrh	r2, [r1, #6]
c0d03474:	2192      	movs	r1, #146	; 0x92
c0d03476:	2a92      	cmp	r2, #146	; 0x92
c0d03478:	d300      	bcc.n	c0d0347c <USBD_CtlError+0x84>
c0d0347a:	460a      	mov	r2, r1
c0d0347c:	490c      	ldr	r1, [pc, #48]	; (c0d034b0 <USBD_CtlError+0xb8>)
c0d0347e:	4479      	add	r1, pc
c0d03480:	f000 f888 	bl	c0d03594 <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d03484:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
  }
  // Microsoft OS 2.0 Descriptors for Windows 8.1 and Windows 10
  else if ((req->bmRequest & 0x80)
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
c0d03486:	888a      	ldrh	r2, [r1, #4]
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
  ) {        
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
  }
  // Microsoft OS 2.0 Descriptors for Windows 8.1 and Windows 10
  else if ((req->bmRequest & 0x80)
c0d03488:	2a07      	cmp	r2, #7
c0d0348a:	d1ba      	bne.n	c0d03402 <USBD_CtlError+0xa>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
c0d0348c:	88ca      	ldrh	r2, [r1, #6]
c0d0348e:	21b2      	movs	r1, #178	; 0xb2
c0d03490:	2ab2      	cmp	r2, #178	; 0xb2
c0d03492:	d300      	bcc.n	c0d03496 <USBD_CtlError+0x9e>
c0d03494:	460a      	mov	r2, r1
c0d03496:	4907      	ldr	r1, [pc, #28]	; (c0d034b4 <USBD_CtlError+0xbc>)
c0d03498:	4479      	add	r1, pc
c0d0349a:	f000 f87b 	bl	c0d03594 <USBD_CtlSendData>
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d0349e:	bd80      	pop	{r7, pc}
c0d034a0:	000003ee 	.word	0x000003ee
c0d034a4:	00001783 	.word	0x00001783
c0d034a8:	000017da 	.word	0x000017da
c0d034ac:	000019fc 	.word	0x000019fc
c0d034b0:	000017b8 	.word	0x000017b8
c0d034b4:	00001830 	.word	0x00001830

c0d034b8 <USB_power>:
  // nothing to do ?
  return 0;
}
#endif // HAVE_USB_CLASS_CCID

void USB_power(unsigned char enabled) {
c0d034b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d034ba:	b081      	sub	sp, #4
c0d034bc:	4604      	mov	r4, r0
c0d034be:	2045      	movs	r0, #69	; 0x45
c0d034c0:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d034c2:	4824      	ldr	r0, [pc, #144]	; (c0d03554 <USB_power+0x9c>)
c0d034c4:	2600      	movs	r6, #0
c0d034c6:	4631      	mov	r1, r6
c0d034c8:	462a      	mov	r2, r5
c0d034ca:	f7fd fb09 	bl	c0d00ae0 <os_memset>

  // init timeouts and other global fields
  os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
c0d034ce:	4f22      	ldr	r7, [pc, #136]	; (c0d03558 <USB_power+0xa0>)
c0d034d0:	4638      	mov	r0, r7
c0d034d2:	300c      	adds	r0, #12
c0d034d4:	2206      	movs	r2, #6
c0d034d6:	4631      	mov	r1, r6
c0d034d8:	f7fd fb02 	bl	c0d00ae0 <os_memset>
  os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d034dc:	3712      	adds	r7, #18
c0d034de:	220c      	movs	r2, #12
c0d034e0:	4638      	mov	r0, r7
c0d034e2:	4631      	mov	r1, r6
c0d034e4:	f7fd fafc 	bl	c0d00ae0 <os_memset>

  if (enabled) {
c0d034e8:	2c00      	cmp	r4, #0
c0d034ea:	d02d      	beq.n	c0d03548 <USB_power+0x90>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d034ec:	4c19      	ldr	r4, [pc, #100]	; (c0d03554 <USB_power+0x9c>)
c0d034ee:	2600      	movs	r6, #0
c0d034f0:	4620      	mov	r0, r4
c0d034f2:	4631      	mov	r1, r6
c0d034f4:	462a      	mov	r2, r5
c0d034f6:	f7fd faf3 	bl	c0d00ae0 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d034fa:	491a      	ldr	r1, [pc, #104]	; (c0d03564 <USB_power+0xac>)
c0d034fc:	4479      	add	r1, pc
c0d034fe:	4620      	mov	r0, r4
c0d03500:	4632      	mov	r2, r6
c0d03502:	f7ff f9a7 	bl	c0d02854 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClassForInterface(HID_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d03506:	4a18      	ldr	r2, [pc, #96]	; (c0d03568 <USB_power+0xb0>)
c0d03508:	447a      	add	r2, pc
c0d0350a:	4630      	mov	r0, r6
c0d0350c:	4621      	mov	r1, r4
c0d0350e:	f7ff f9d8 	bl	c0d028c2 <USBD_RegisterClassForInterface>
c0d03512:	2001      	movs	r0, #1
#ifdef HAVE_IO_U2F
    USBD_RegisterClassForInterface(U2F_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_U2F);
c0d03514:	4a15      	ldr	r2, [pc, #84]	; (c0d0356c <USB_power+0xb4>)
c0d03516:	447a      	add	r2, pc
c0d03518:	4621      	mov	r1, r4
c0d0351a:	f7ff f9d2 	bl	c0d028c2 <USBD_RegisterClassForInterface>
c0d0351e:	22ff      	movs	r2, #255	; 0xff
c0d03520:	3252      	adds	r2, #82	; 0x52
    // initialize the U2F tunnel transport
    u2f_transport_init(&G_io_u2f, G_io_apdu_buffer, IO_APDU_BUFFER_SIZE);
c0d03522:	480e      	ldr	r0, [pc, #56]	; (c0d0355c <USB_power+0xa4>)
c0d03524:	490e      	ldr	r1, [pc, #56]	; (c0d03560 <USB_power+0xa8>)
c0d03526:	f7fe fce9 	bl	c0d01efc <u2f_transport_init>
c0d0352a:	2002      	movs	r0, #2
#ifdef HAVE_USB_CLASS_CCID
    USBD_RegisterClassForInterface(CCID_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_CCID);
#endif // HAVE_USB_CLASS_CCID

#ifdef HAVE_WEBUSB
    USBD_RegisterClassForInterface(WEBUSB_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_WEBUSB);
c0d0352c:	4a10      	ldr	r2, [pc, #64]	; (c0d03570 <USB_power+0xb8>)
c0d0352e:	447a      	add	r2, pc
c0d03530:	4621      	mov	r1, r4
c0d03532:	f7ff f9c6 	bl	c0d028c2 <USBD_RegisterClassForInterface>
c0d03536:	2103      	movs	r1, #3
c0d03538:	2240      	movs	r2, #64	; 0x40
    USBD_LL_PrepareReceive(&USBD_Device, WEBUSB_EPOUT_ADDR , WEBUSB_EPOUT_SIZE);
c0d0353a:	4620      	mov	r0, r4
c0d0353c:	f7ff f977 	bl	c0d0282e <USBD_LL_PrepareReceive>
#endif // HAVE_WEBUSB

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d03540:	4620      	mov	r0, r4
c0d03542:	f7ff f9cb 	bl	c0d028dc <USBD_Start>
c0d03546:	e002      	b.n	c0d0354e <USB_power+0x96>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d03548:	4802      	ldr	r0, [pc, #8]	; (c0d03554 <USB_power+0x9c>)
c0d0354a:	f7ff f99c 	bl	c0d02886 <USBD_DeInit>
  }
}
c0d0354e:	b001      	add	sp, #4
c0d03550:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03552:	46c0      	nop			; (mov r8, r8)
c0d03554:	20001d28 	.word	0x20001d28
c0d03558:	20001be0 	.word	0x20001be0
c0d0355c:	20001c08 	.word	0x20001c08
c0d03560:	20001a8e 	.word	0x20001a8e
c0d03564:	00001708 	.word	0x00001708
c0d03568:	00001874 	.word	0x00001874
c0d0356c:	0000189e 	.word	0x0000189e
c0d03570:	000018be 	.word	0x000018be

c0d03574 <USBD_GetCfgDesc_impl>:
  * @param  speed : current device speed
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
c0d03574:	2160      	movs	r1, #96	; 0x60
  *length = sizeof (USBD_CfgDesc);
c0d03576:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d03578:	4801      	ldr	r0, [pc, #4]	; (c0d03580 <USBD_GetCfgDesc_impl+0xc>)
c0d0357a:	4478      	add	r0, pc
c0d0357c:	4770      	bx	lr
c0d0357e:	46c0      	nop			; (mov r8, r8)
c0d03580:	0000190e 	.word	0x0000190e

c0d03584 <USBD_GetDeviceQualifierDesc_impl>:
*         return Device Qualifier descriptor
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
c0d03584:	210a      	movs	r1, #10
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d03586:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d03588:	4801      	ldr	r0, [pc, #4]	; (c0d03590 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d0358a:	4478      	add	r0, pc
c0d0358c:	4770      	bx	lr
c0d0358e:	46c0      	nop			; (mov r8, r8)
c0d03590:	0000195e 	.word	0x0000195e

c0d03594 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d03594:	b5b0      	push	{r4, r5, r7, lr}
c0d03596:	460c      	mov	r4, r1
c0d03598:	21d4      	movs	r1, #212	; 0xd4
c0d0359a:	2302      	movs	r3, #2
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d0359c:	5043      	str	r3, [r0, r1]
c0d0359e:	2111      	movs	r1, #17
c0d035a0:	0109      	lsls	r1, r1, #4
  pdev->ep_in[0].total_length = len;
  pdev->ep_in[0].rem_length   = len;
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d035a2:	5044      	str	r4, [r0, r1]
                               uint8_t *pbuf,
                               uint16_t len)
{
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
  pdev->ep_in[0].total_length = len;
c0d035a4:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d035a6:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d035a8:	6a01      	ldr	r1, [r0, #32]
c0d035aa:	4291      	cmp	r1, r2
c0d035ac:	d800      	bhi.n	c0d035b0 <USBD_CtlSendData+0x1c>
c0d035ae:	460a      	mov	r2, r1
c0d035b0:	b293      	uxth	r3, r2
c0d035b2:	2500      	movs	r5, #0
c0d035b4:	4629      	mov	r1, r5
c0d035b6:	4622      	mov	r2, r4
c0d035b8:	f7ff f920 	bl	c0d027fc <USBD_LL_Transmit>
  
  return USBD_OK;
c0d035bc:	4628      	mov	r0, r5
c0d035be:	bdb0      	pop	{r4, r5, r7, pc}

c0d035c0 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d035c0:	b5b0      	push	{r4, r5, r7, lr}
c0d035c2:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d035c4:	6a01      	ldr	r1, [r0, #32]
c0d035c6:	4291      	cmp	r1, r2
c0d035c8:	d800      	bhi.n	c0d035cc <USBD_CtlContinueSendData+0xc>
c0d035ca:	460a      	mov	r2, r1
c0d035cc:	b293      	uxth	r3, r2
c0d035ce:	2500      	movs	r5, #0
c0d035d0:	4629      	mov	r1, r5
c0d035d2:	4622      	mov	r2, r4
c0d035d4:	f7ff f912 	bl	c0d027fc <USBD_LL_Transmit>
  return USBD_OK;
c0d035d8:	4628      	mov	r0, r5
c0d035da:	bdb0      	pop	{r4, r5, r7, pc}

c0d035dc <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d035dc:	b510      	push	{r4, lr}
c0d035de:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d035e0:	4621      	mov	r1, r4
c0d035e2:	f7ff f924 	bl	c0d0282e <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d035e6:	4620      	mov	r0, r4
c0d035e8:	bd10      	pop	{r4, pc}

c0d035ea <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d035ea:	b510      	push	{r4, lr}
c0d035ec:	21d4      	movs	r1, #212	; 0xd4
c0d035ee:	2204      	movs	r2, #4

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d035f0:	5042      	str	r2, [r0, r1]
c0d035f2:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d035f4:	4621      	mov	r1, r4
c0d035f6:	4622      	mov	r2, r4
c0d035f8:	4623      	mov	r3, r4
c0d035fa:	f7ff f8ff 	bl	c0d027fc <USBD_LL_Transmit>
  
  return USBD_OK;
c0d035fe:	4620      	mov	r0, r4
c0d03600:	bd10      	pop	{r4, pc}

c0d03602 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d03602:	b510      	push	{r4, lr}
c0d03604:	21d4      	movs	r1, #212	; 0xd4
c0d03606:	2205      	movs	r2, #5
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d03608:	5042      	str	r2, [r0, r1]
c0d0360a:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d0360c:	4621      	mov	r1, r4
c0d0360e:	4622      	mov	r2, r4
c0d03610:	f7ff f90d 	bl	c0d0282e <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d03614:	4620      	mov	r0, r4
c0d03616:	bd10      	pop	{r4, pc}

c0d03618 <btox>:
    os_memmove(out, (buffer + j), length);
    return length;
}

void btox(char *xp, const char *bb, int n)
{
c0d03618:	b570      	push	{r4, r5, r6, lr}
    const char xx[]= "0123456789abcdef";
    while (--n >= 0) xp[n] = xx[(bb[n>>1] >> ((1 - (n&1)) << 2)) & 0xF];
c0d0361a:	2a01      	cmp	r2, #1
c0d0361c:	db13      	blt.n	c0d03646 <btox+0x2e>
c0d0361e:	1e54      	subs	r4, r2, #1
c0d03620:	0092      	lsls	r2, r2, #2
c0d03622:	1f12      	subs	r2, r2, #4
c0d03624:	4b08      	ldr	r3, [pc, #32]	; (c0d03648 <btox+0x30>)
c0d03626:	447b      	add	r3, pc
c0d03628:	2504      	movs	r5, #4
c0d0362a:	4395      	bics	r5, r2
c0d0362c:	1066      	asrs	r6, r4, #1
c0d0362e:	5d8e      	ldrb	r6, [r1, r6]
c0d03630:	40ee      	lsrs	r6, r5
c0d03632:	250f      	movs	r5, #15
c0d03634:	4035      	ands	r5, r6
c0d03636:	5d5d      	ldrb	r5, [r3, r5]
c0d03638:	5505      	strb	r5, [r0, r4]
c0d0363a:	1f12      	subs	r2, r2, #4
c0d0363c:	1e65      	subs	r5, r4, #1
c0d0363e:	1c64      	adds	r4, r4, #1
c0d03640:	2c01      	cmp	r4, #1
c0d03642:	462c      	mov	r4, r5
c0d03644:	dcf0      	bgt.n	c0d03628 <btox+0x10>
}
c0d03646:	bd70      	pop	{r4, r5, r6, pc}
c0d03648:	000018cc 	.word	0x000018cc

c0d0364c <getAddressStringFromBinary>:

void getAddressStringFromBinary(uint8_t *publicKey, char *address) {
c0d0364c:	b570      	push	{r4, r5, r6, lr}
c0d0364e:	b092      	sub	sp, #72	; 0x48
c0d03650:	460c      	mov	r4, r1
c0d03652:	4601      	mov	r1, r0
c0d03654:	ad09      	add	r5, sp, #36	; 0x24
c0d03656:	2620      	movs	r6, #32
    uint8_t buffer[36];
    uint8_t hashAddress[32];

    os_memmove(buffer, publicKey, 32);
c0d03658:	4628      	mov	r0, r5
c0d0365a:	4632      	mov	r2, r6
c0d0365c:	f7fd fa2a 	bl	c0d00ab4 <os_memmove>
c0d03660:	aa01      	add	r2, sp, #4
    cx_hash_sha256(buffer, 32, hashAddress, 32);
c0d03662:	4628      	mov	r0, r5
c0d03664:	4631      	mov	r1, r6
c0d03666:	4633      	mov	r3, r6
c0d03668:	f7fe f9ca 	bl	c0d01a00 <cx_hash_sha256>
c0d0366c:	2227      	movs	r2, #39	; 0x27
c0d0366e:	209c      	movs	r0, #156	; 0x9c
c0d03670:	490b      	ldr	r1, [pc, #44]	; (c0d036a0 <getAddressStringFromBinary+0x54>)
c0d03672:	4479      	add	r1, pc
c0d03674:	2304      	movs	r3, #4
}

void btox(char *xp, const char *bb, int n)
{
    const char xx[]= "0123456789abcdef";
    while (--n >= 0) xp[n] = xx[(bb[n>>1] >> ((1 - (n&1)) << 2)) & 0xF];
c0d03676:	4383      	bics	r3, r0
c0d03678:	1055      	asrs	r5, r2, #1
c0d0367a:	ae01      	add	r6, sp, #4
c0d0367c:	5d75      	ldrb	r5, [r6, r5]
c0d0367e:	40dd      	lsrs	r5, r3
c0d03680:	230f      	movs	r3, #15
c0d03682:	402b      	ands	r3, r5
c0d03684:	5ccb      	ldrb	r3, [r1, r3]
c0d03686:	54a3      	strb	r3, [r4, r2]
c0d03688:	1f00      	subs	r0, r0, #4
c0d0368a:	1e53      	subs	r3, r2, #1
c0d0368c:	1c52      	adds	r2, r2, #1
c0d0368e:	2a01      	cmp	r2, #1
c0d03690:	461a      	mov	r2, r3
c0d03692:	d8ef      	bhi.n	c0d03674 <getAddressStringFromBinary+0x28>
c0d03694:	2028      	movs	r0, #40	; 0x28
c0d03696:	2100      	movs	r1, #0
    os_memmove(buffer, publicKey, 32);
    cx_hash_sha256(buffer, 32, hashAddress, 32);

    //Only copy first 20 bytes of hashAddress as the User's address.
    btox(address, (const char*)hashAddress, 40);
    address[40] = 0;
c0d03698:	5421      	strb	r1, [r4, r0]
}
c0d0369a:	b012      	add	sp, #72	; 0x48
c0d0369c:	bd70      	pop	{r4, r5, r6, pc}
c0d0369e:	46c0      	nop			; (mov r8, r8)
c0d036a0:	00001880 	.word	0x00001880

c0d036a4 <getPublicKey>:

void getPublicKey(uint32_t accountNumber, uint8_t *publicKeyArray) {
c0d036a4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d036a6:	b09d      	sub	sp, #116	; 0x74
c0d036a8:	460c      	mov	r4, r1
c0d036aa:	ae13      	add	r6, sp, #76	; 0x4c
    cx_ecfp_private_key_t privateKey;
    cx_ecfp_public_key_t publicKey;

    getPrivateKey(accountNumber, &privateKey);
c0d036ac:	4631      	mov	r1, r6
c0d036ae:	f000 f821 	bl	c0d036f4 <getPrivateKey>
c0d036b2:	2041      	movs	r0, #65	; 0x41
c0d036b4:	466d      	mov	r5, sp
c0d036b6:	2301      	movs	r3, #1
    cx_ecfp_generate_pair(CX_CURVE_Ed25519, &publicKey, &privateKey, 1);
c0d036b8:	4629      	mov	r1, r5
c0d036ba:	4632      	mov	r2, r6
c0d036bc:	f7fe f9c0 	bl	c0d01a40 <cx_ecfp_generate_pair>
c0d036c0:	2700      	movs	r7, #0
c0d036c2:	2128      	movs	r1, #40	; 0x28
    os_memset(&privateKey, 0, sizeof(privateKey));
c0d036c4:	4630      	mov	r0, r6
c0d036c6:	460e      	mov	r6, r1
c0d036c8:	4639      	mov	r1, r7
c0d036ca:	4632      	mov	r2, r6
c0d036cc:	f7fd fa08 	bl	c0d00ae0 <os_memset>

    for (int i = 0; i < 32; i++) {
c0d036d0:	3548      	adds	r5, #72	; 0x48
        publicKeyArray[i] = publicKey.W[64 - i];
c0d036d2:	7828      	ldrb	r0, [r5, #0]
c0d036d4:	55e0      	strb	r0, [r4, r7]

    getPrivateKey(accountNumber, &privateKey);
    cx_ecfp_generate_pair(CX_CURVE_Ed25519, &publicKey, &privateKey, 1);
    os_memset(&privateKey, 0, sizeof(privateKey));

    for (int i = 0; i < 32; i++) {
c0d036d6:	1e6d      	subs	r5, r5, #1
c0d036d8:	1c7f      	adds	r7, r7, #1
c0d036da:	2f20      	cmp	r7, #32
c0d036dc:	d1f9      	bne.n	c0d036d2 <getPublicKey+0x2e>
c0d036de:	4668      	mov	r0, sp
        publicKeyArray[i] = publicKey.W[64 - i];
    }
    if ((publicKey.W[32] & 1) != 0) {
c0d036e0:	5d80      	ldrb	r0, [r0, r6]
c0d036e2:	07c0      	lsls	r0, r0, #31
c0d036e4:	d003      	beq.n	c0d036ee <getPublicKey+0x4a>
        publicKeyArray[31] |= 0x80;
c0d036e6:	7fe0      	ldrb	r0, [r4, #31]
c0d036e8:	2180      	movs	r1, #128	; 0x80
c0d036ea:	4301      	orrs	r1, r0
c0d036ec:	77e1      	strb	r1, [r4, #31]
    }
}
c0d036ee:	b01d      	add	sp, #116	; 0x74
c0d036f0:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d036f4 <getPrivateKey>:
  0 | HARDENED_OFFSET,
  0 | HARDENED_OFFSET,
  0 | HARDENED_OFFSET
};

void getPrivateKey(uint32_t accountNumber, cx_ecfp_private_key_t *privateKey) {
c0d036f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d036f6:	b093      	sub	sp, #76	; 0x4c
c0d036f8:	9105      	str	r1, [sp, #20]
c0d036fa:	4606      	mov	r6, r0
c0d036fc:	ad06      	add	r5, sp, #24
    uint8_t privateKeyData[32];
    uint32_t bip32Path[BIP32_PATH];

    os_memmove(bip32Path, derivePath, sizeof(derivePath));
c0d036fe:	4912      	ldr	r1, [pc, #72]	; (c0d03748 <getPrivateKey+0x54>)
c0d03700:	4479      	add	r1, pc
c0d03702:	2214      	movs	r2, #20
c0d03704:	4628      	mov	r0, r5
c0d03706:	f7fd f9d5 	bl	c0d00ab4 <os_memmove>
c0d0370a:	2001      	movs	r0, #1
c0d0370c:	07c1      	lsls	r1, r0, #31
    bip32Path[2] = accountNumber | HARDENED_OFFSET;
c0d0370e:	4331      	orrs	r1, r6
c0d03710:	9108      	str	r1, [sp, #32]
c0d03712:	2600      	movs	r6, #0
    PRINTF("BIP32: %.*H\n", BIP32_PATH*4, bip32Path);
    os_perso_derive_node_bip32_seed_key(HDW_ED25519_SLIP10, CX_CURVE_Ed25519, bip32Path, BIP32_PATH, privateKeyData, NULL, NULL, 0);
c0d03714:	4669      	mov	r1, sp
c0d03716:	60ce      	str	r6, [r1, #12]
c0d03718:	608e      	str	r6, [r1, #8]
c0d0371a:	604e      	str	r6, [r1, #4]
c0d0371c:	af0b      	add	r7, sp, #44	; 0x2c
c0d0371e:	600f      	str	r7, [r1, #0]
c0d03720:	2441      	movs	r4, #65	; 0x41
c0d03722:	2305      	movs	r3, #5
c0d03724:	4621      	mov	r1, r4
c0d03726:	462a      	mov	r2, r5
c0d03728:	f7fe f9d2 	bl	c0d01ad0 <os_perso_derive_node_with_seed_key>
c0d0372c:	2520      	movs	r5, #32
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, privateKey);
c0d0372e:	4620      	mov	r0, r4
c0d03730:	4639      	mov	r1, r7
c0d03732:	462a      	mov	r2, r5
c0d03734:	9b05      	ldr	r3, [sp, #20]
c0d03736:	f7fe f973 	bl	c0d01a20 <cx_ecfp_init_private_key>
    os_memset(privateKeyData, 0, sizeof(privateKeyData));
c0d0373a:	4638      	mov	r0, r7
c0d0373c:	4631      	mov	r1, r6
c0d0373e:	462a      	mov	r2, r5
c0d03740:	f7fd f9ce 	bl	c0d00ae0 <os_memset>
}
c0d03744:	b013      	add	sp, #76	; 0x4c
c0d03746:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03748:	00001804 	.word	0x00001804

c0d0374c <readUint32BE>:
        publicKeyArray[31] |= 0x80;
    }
}

uint32_t readUint32BE(uint8_t *buffer) {
  return (buffer[0] << 24) | (buffer[1] << 16) | (buffer[2] << 8) | (buffer[3]);
c0d0374c:	7801      	ldrb	r1, [r0, #0]
c0d0374e:	0609      	lsls	r1, r1, #24
c0d03750:	7842      	ldrb	r2, [r0, #1]
c0d03752:	0412      	lsls	r2, r2, #16
c0d03754:	1851      	adds	r1, r2, r1
c0d03756:	7882      	ldrb	r2, [r0, #2]
c0d03758:	0212      	lsls	r2, r2, #8
c0d0375a:	1889      	adds	r1, r1, r2
c0d0375c:	78c0      	ldrb	r0, [r0, #3]
c0d0375e:	1808      	adds	r0, r1, r0
c0d03760:	4770      	bx	lr
	...

c0d03764 <sendResponse>:
    os_perso_derive_node_bip32_seed_key(HDW_ED25519_SLIP10, CX_CURVE_Ed25519, bip32Path, BIP32_PATH, privateKeyData, NULL, NULL, 0);
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, privateKey);
    os_memset(privateKeyData, 0, sizeof(privateKeyData));
}

void sendResponse(uint8_t tx, bool approve) {
c0d03764:	b510      	push	{r4, lr}
c0d03766:	227a      	movs	r2, #122	; 0x7a
c0d03768:	43d2      	mvns	r2, r2
    G_io_apdu_buffer[tx++] = approve? 0x90 : 0x69;
c0d0376a:	4614      	mov	r4, r2
c0d0376c:	340b      	adds	r4, #11
c0d0376e:	2369      	movs	r3, #105	; 0x69
c0d03770:	2900      	cmp	r1, #0
c0d03772:	d100      	bne.n	c0d03776 <sendResponse+0x12>
c0d03774:	461c      	mov	r4, r3
c0d03776:	4b08      	ldr	r3, [pc, #32]	; (c0d03798 <sendResponse+0x34>)
c0d03778:	541c      	strb	r4, [r3, r0]
c0d0377a:	2400      	movs	r4, #0
    G_io_apdu_buffer[tx++] = approve? 0x00 : 0x85;
c0d0377c:	2900      	cmp	r1, #0
c0d0377e:	d100      	bne.n	c0d03782 <sendResponse+0x1e>
c0d03780:	4614      	mov	r4, r2
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, privateKey);
    os_memset(privateKeyData, 0, sizeof(privateKeyData));
}

void sendResponse(uint8_t tx, bool approve) {
    G_io_apdu_buffer[tx++] = approve? 0x90 : 0x69;
c0d03782:	1c41      	adds	r1, r0, #1
    G_io_apdu_buffer[tx++] = approve? 0x00 : 0x85;
c0d03784:	b2c9      	uxtb	r1, r1
c0d03786:	545c      	strb	r4, [r3, r1]
c0d03788:	1c80      	adds	r0, r0, #2
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d0378a:	b2c1      	uxtb	r1, r0
c0d0378c:	2020      	movs	r0, #32
c0d0378e:	f7fd fc07 	bl	c0d00fa0 <io_exchange>
    // Display back the original UX
    ui_idle();
c0d03792:	f7fd f957 	bl	c0d00a44 <ui_idle>
}
c0d03796:	bd10      	pop	{r4, pc}
c0d03798:	20001a8e 	.word	0x20001a8e

c0d0379c <parseAPDU>:
    return (buffer[0] << 8) | (buffer[1]);
}

void parseAPDU(struct apduMessage* apdu) {

    apdu->cla = G_io_apdu_buffer[OFFSET_CLA];
c0d0379c:	4908      	ldr	r1, [pc, #32]	; (c0d037c0 <parseAPDU+0x24>)
c0d0379e:	780a      	ldrb	r2, [r1, #0]
c0d037a0:	7002      	strb	r2, [r0, #0]
    apdu->ins = G_io_apdu_buffer[OFFSET_INS];
c0d037a2:	784a      	ldrb	r2, [r1, #1]
c0d037a4:	7042      	strb	r2, [r0, #1]
    apdu->p1 = G_io_apdu_buffer[OFFSET_P1];
c0d037a6:	788a      	ldrb	r2, [r1, #2]
c0d037a8:	7082      	strb	r2, [r0, #2]
    apdu->p2 = G_io_apdu_buffer[OFFSET_P2];
c0d037aa:	78ca      	ldrb	r2, [r1, #3]
c0d037ac:	70c2      	strb	r2, [r0, #3]
    }
    return display;
}

uint16_t readUint16BE(uint8_t *buffer) {
    return (buffer[0] << 8) | (buffer[1]);
c0d037ae:	798a      	ldrb	r2, [r1, #6]
c0d037b0:	794b      	ldrb	r3, [r1, #5]

    //Parse Length of Data
    apdu->lc = readUint16BE(&G_io_apdu_buffer[OFFSET_LC + 1]);
    PRINTF("Length of APDU CDATA: %d", apdu->lc);

    apdu->cData = &G_io_apdu_buffer[OFFSET_CDATA];
c0d037b2:	1dc9      	adds	r1, r1, #7
c0d037b4:	6081      	str	r1, [r0, #8]
    }
    return display;
}

uint16_t readUint16BE(uint8_t *buffer) {
    return (buffer[0] << 8) | (buffer[1]);
c0d037b6:	0219      	lsls	r1, r3, #8
c0d037b8:	1889      	adds	r1, r1, r2
    apdu->ins = G_io_apdu_buffer[OFFSET_INS];
    apdu->p1 = G_io_apdu_buffer[OFFSET_P1];
    apdu->p2 = G_io_apdu_buffer[OFFSET_P2];

    //Parse Length of Data
    apdu->lc = readUint16BE(&G_io_apdu_buffer[OFFSET_LC + 1]);
c0d037ba:	8081      	strh	r1, [r0, #4]
    PRINTF("Length of APDU CDATA: %d", apdu->lc);

    apdu->cData = &G_io_apdu_buffer[OFFSET_CDATA];
}
c0d037bc:	4770      	bx	lr
c0d037be:	46c0      	nop			; (mov r8, r8)
c0d037c0:	20001a8e 	.word	0x20001a8e

c0d037c4 <ux_flow_is_first>:
	}
	return 1;
}

// to hide the left tick or not
unsigned int ux_flow_is_first(void) {
c0d037c4:	b5b0      	push	{r4, r5, r7, lr}
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d037c6:	4912      	ldr	r1, [pc, #72]	; (c0d03810 <ux_flow_is_first+0x4c>)
c0d037c8:	780a      	ldrb	r2, [r1, #0]
c0d037ca:	2001      	movs	r0, #1
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d037cc:	2a01      	cmp	r2, #1
c0d037ce:	d81d      	bhi.n	c0d0380c <ux_flow_is_first+0x48>
c0d037d0:	1e52      	subs	r2, r2, #1
c0d037d2:	230c      	movs	r3, #12
c0d037d4:	4353      	muls	r3, r2
c0d037d6:	18cb      	adds	r3, r1, r3
c0d037d8:	8b1a      	ldrh	r2, [r3, #24]

// to hide the left tick or not
unsigned int ux_flow_is_first(void) {
	// no previous ?
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d037da:	2a00      	cmp	r2, #0
c0d037dc:	d016      	beq.n	c0d0380c <ux_flow_is_first+0x48>
c0d037de:	6919      	ldr	r1, [r3, #16]
		|| (G_ux.flow_stack[G_ux.stack_count-1].index == 0 
c0d037e0:	2900      	cmp	r1, #0
c0d037e2:	d013      	beq.n	c0d0380c <ux_flow_is_first+0x48>
c0d037e4:	8a9b      	ldrh	r3, [r3, #20]
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
c0d037e6:	2b00      	cmp	r3, #0
c0d037e8:	d106      	bne.n	c0d037f8 <ux_flow_is_first+0x34>
c0d037ea:	0094      	lsls	r4, r2, #2
c0d037ec:	190c      	adds	r4, r1, r4
c0d037ee:	2503      	movs	r5, #3
c0d037f0:	43ed      	mvns	r5, r5
c0d037f2:	5964      	ldr	r4, [r4, r5]
}

// to hide the left tick or not
unsigned int ux_flow_is_first(void) {
	// no previous ?
	if (!ux_flow_check_valid()
c0d037f4:	1ce4      	adds	r4, r4, #3
c0d037f6:	d109      	bne.n	c0d0380c <ux_flow_is_first+0x48>
		return 1;
	}

	// previous is a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
		&& G_ux.flow_stack[G_ux.stack_count-1].index < G_ux.flow_stack[G_ux.stack_count-1].length
c0d037f8:	4293      	cmp	r3, r2
c0d037fa:	d206      	bcs.n	c0d0380a <ux_flow_is_first+0x46>
		&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index-1] == FLOW_BARRIER) {
c0d037fc:	009a      	lsls	r2, r3, #2
c0d037fe:	1889      	adds	r1, r1, r2
c0d03800:	2203      	movs	r2, #3
c0d03802:	43d2      	mvns	r2, r2
c0d03804:	5889      	ldr	r1, [r1, r2]
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
		return 1;
	}

	// previous is a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d03806:	1c89      	adds	r1, r1, #2
c0d03808:	d000      	beq.n	c0d0380c <ux_flow_is_first+0x48>
c0d0380a:	2000      	movs	r0, #0
		return 1;
	}

	// not the first, for sure
	return 0;
}
c0d0380c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0380e:	46c0      	nop			; (mov r8, r8)
c0d03810:	2000186c 	.word	0x2000186c

c0d03814 <ux_flow_is_last>:

unsigned int ux_flow_is_last(void){
c0d03814:	b510      	push	{r4, lr}
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d03816:	490e      	ldr	r1, [pc, #56]	; (c0d03850 <ux_flow_is_last+0x3c>)
c0d03818:	780a      	ldrb	r2, [r1, #0]
c0d0381a:	2001      	movs	r0, #1
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d0381c:	2a01      	cmp	r2, #1
c0d0381e:	d816      	bhi.n	c0d0384e <ux_flow_is_last+0x3a>
c0d03820:	1e52      	subs	r2, r2, #1
c0d03822:	230c      	movs	r3, #12
c0d03824:	4353      	muls	r3, r2
c0d03826:	18cb      	adds	r3, r1, r3
c0d03828:	8b1a      	ldrh	r2, [r3, #24]
}

unsigned int ux_flow_is_last(void){
	// last ?
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d0382a:	2a00      	cmp	r2, #0
c0d0382c:	d00f      	beq.n	c0d0384e <ux_flow_is_last+0x3a>
c0d0382e:	6919      	ldr	r1, [r3, #16]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0
c0d03830:	2900      	cmp	r1, #0
c0d03832:	d00c      	beq.n	c0d0384e <ux_flow_is_last+0x3a>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
c0d03834:	8a9b      	ldrh	r3, [r3, #20]
c0d03836:	1e54      	subs	r4, r2, #1
	return 0;
}

unsigned int ux_flow_is_last(void){
	// last ?
	if (!ux_flow_check_valid()
c0d03838:	429c      	cmp	r4, r3
c0d0383a:	dd08      	ble.n	c0d0384e <ux_flow_is_last+0x3a>
		return 1;
	}

	// followed by a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
		&& G_ux.flow_stack[G_ux.stack_count-1].index < G_ux.flow_stack[G_ux.stack_count-1].length - 2
c0d0383c:	1e92      	subs	r2, r2, #2
c0d0383e:	429a      	cmp	r2, r3
c0d03840:	dd04      	ble.n	c0d0384c <ux_flow_is_last+0x38>
		&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d03842:	009a      	lsls	r2, r3, #2
c0d03844:	1889      	adds	r1, r1, r2
c0d03846:	6849      	ldr	r1, [r1, #4]
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
		return 1;
	}

	// followed by a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d03848:	1c89      	adds	r1, r1, #2
c0d0384a:	d000      	beq.n	c0d0384e <ux_flow_is_last+0x3a>
c0d0384c:	2000      	movs	r0, #0
		return 1;
	}

	// is not last
	return 0;
}
c0d0384e:	bd10      	pop	{r4, pc}
c0d03850:	2000186c 	.word	0x2000186c

c0d03854 <ux_flow_direction>:

ux_flow_direction_t ux_flow_direction(void) {
	if (G_ux.stack_count) {
c0d03854:	4808      	ldr	r0, [pc, #32]	; (c0d03878 <ux_flow_direction+0x24>)
c0d03856:	7801      	ldrb	r1, [r0, #0]
c0d03858:	2900      	cmp	r1, #0
c0d0385a:	d00a      	beq.n	c0d03872 <ux_flow_direction+0x1e>
c0d0385c:	220c      	movs	r2, #12
		if (G_ux.flow_stack[G_ux.stack_count-1].index > G_ux.flow_stack[G_ux.stack_count-1].prev_index) {
c0d0385e:	434a      	muls	r2, r1
c0d03860:	1880      	adds	r0, r0, r2
c0d03862:	8941      	ldrh	r1, [r0, #10]
c0d03864:	8902      	ldrh	r2, [r0, #8]
c0d03866:	2001      	movs	r0, #1
c0d03868:	428a      	cmp	r2, r1
c0d0386a:	d803      	bhi.n	c0d03874 <ux_flow_direction+0x20>
c0d0386c:	20ff      	movs	r0, #255	; 0xff
		return FLOW_DIRECTION_FORWARD;
		}
		else if (G_ux.flow_stack[G_ux.stack_count-1].index < G_ux.flow_stack[G_ux.stack_count-1].prev_index) {
c0d0386e:	428a      	cmp	r2, r1
c0d03870:	d300      	bcc.n	c0d03874 <ux_flow_direction+0x20>
c0d03872:	2000      	movs	r0, #0
			return FLOW_DIRECTION_BACKWARD;
		}
	}
  return FLOW_DIRECTION_START;
}
c0d03874:	b240      	sxtb	r0, r0
c0d03876:	4770      	bx	lr
c0d03878:	2000186c 	.word	0x2000186c

c0d0387c <ux_flow_next_internal>:
			           STEPSPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->validate_flow), 
			           (const ux_flow_step_t*) PIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->params));
	}
}

static void ux_flow_next_internal(unsigned int display_step) {
c0d0387c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0387e:	b081      	sub	sp, #4
c0d03880:	4601      	mov	r1, r0
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d03882:	4a16      	ldr	r2, [pc, #88]	; (c0d038dc <ux_flow_next_internal+0x60>)
c0d03884:	7810      	ldrb	r0, [r2, #0]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d03886:	2801      	cmp	r0, #1
c0d03888:	d826      	bhi.n	c0d038d8 <ux_flow_next_internal+0x5c>
c0d0388a:	1e40      	subs	r0, r0, #1
c0d0388c:	230c      	movs	r3, #12
c0d0388e:	4343      	muls	r3, r0
c0d03890:	18d2      	adds	r2, r2, r3
c0d03892:	8b16      	ldrh	r6, [r2, #24]
}

static void ux_flow_next_internal(unsigned int display_step) {
	// last reached already (need validation, not next)
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d03894:	2e00      	cmp	r6, #0
c0d03896:	d01f      	beq.n	c0d038d8 <ux_flow_next_internal+0x5c>
c0d03898:	6915      	ldr	r5, [r2, #16]
		|| G_ux.flow_stack[G_ux.stack_count-1].length <= 1
c0d0389a:	2d00      	cmp	r5, #0
c0d0389c:	d01c      	beq.n	c0d038d8 <ux_flow_next_internal+0x5c>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
c0d0389e:	2e02      	cmp	r6, #2
c0d038a0:	d31a      	bcc.n	c0d038d8 <ux_flow_next_internal+0x5c>
c0d038a2:	8a94      	ldrh	r4, [r2, #20]
c0d038a4:	4613      	mov	r3, r2
c0d038a6:	3314      	adds	r3, #20
c0d038a8:	1e77      	subs	r7, r6, #1
	}
}

static void ux_flow_next_internal(unsigned int display_step) {
	// last reached already (need validation, not next)
	if (!ux_flow_check_valid()
c0d038aa:	42a7      	cmp	r7, r4
c0d038ac:	dd14      	ble.n	c0d038d8 <ux_flow_next_internal+0x5c>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
		return;
	}

	// followed by a flow barrier ? => need validation instead of next
	if (G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {
c0d038ae:	1eb6      	subs	r6, r6, #2
c0d038b0:	42a6      	cmp	r6, r4
c0d038b2:	db0a      	blt.n	c0d038ca <ux_flow_next_internal+0x4e>
		if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d038b4:	00a6      	lsls	r6, r4, #2
c0d038b6:	19ad      	adds	r5, r5, r6
c0d038b8:	686d      	ldr	r5, [r5, #4]
c0d038ba:	1cae      	adds	r6, r5, #2
c0d038bc:	d00c      	beq.n	c0d038d8 <ux_flow_next_internal+0x5c>
c0d038be:	1ced      	adds	r5, r5, #3
c0d038c0:	d103      	bne.n	c0d038ca <ux_flow_next_internal+0x4e>
c0d038c2:	2100      	movs	r1, #0
		}

		// followed by a flow barrier ? => need validation instead of next
		if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_LOOP) {
			// display first step, fake direction as forward
			G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index = 0;
c0d038c4:	8019      	strh	r1, [r3, #0]
c0d038c6:	82d1      	strh	r1, [r2, #22]
c0d038c8:	e004      	b.n	c0d038d4 <ux_flow_next_internal+0x58>
			return;
		}
	}

	// advance flow pointer and display it (skip META STEPS)
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
c0d038ca:	82d4      	strh	r4, [r2, #22]
	G_ux.flow_stack[G_ux.stack_count-1].index++;
c0d038cc:	1c62      	adds	r2, r4, #1
c0d038ce:	801a      	strh	r2, [r3, #0]
	if (display_step) {
c0d038d0:	2900      	cmp	r1, #0
c0d038d2:	d001      	beq.n	c0d038d8 <ux_flow_next_internal+0x5c>
c0d038d4:	f000 f83c 	bl	c0d03950 <ux_flow_engine_init_step>
		ux_flow_engine_init_step(G_ux.stack_count-1);
	}
}
c0d038d8:	b001      	add	sp, #4
c0d038da:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d038dc:	2000186c 	.word	0x2000186c

c0d038e0 <ux_flow_next>:

void ux_flow_next_no_display(void) {
	ux_flow_next_internal(0);
}

void ux_flow_next(void) {
c0d038e0:	b580      	push	{r7, lr}
c0d038e2:	2001      	movs	r0, #1
	ux_flow_next_internal(1);
c0d038e4:	f7ff ffca 	bl	c0d0387c <ux_flow_next_internal>
}
c0d038e8:	bd80      	pop	{r7, pc}
	...

c0d038ec <ux_flow_prev>:

void ux_flow_prev(void) {
c0d038ec:	b5b0      	push	{r4, r5, r7, lr}
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d038ee:	4917      	ldr	r1, [pc, #92]	; (c0d0394c <ux_flow_prev+0x60>)
c0d038f0:	7808      	ldrb	r0, [r1, #0]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d038f2:	2801      	cmp	r0, #1
c0d038f4:	d828      	bhi.n	c0d03948 <ux_flow_prev+0x5c>
c0d038f6:	1e40      	subs	r0, r0, #1
c0d038f8:	220c      	movs	r2, #12
c0d038fa:	4342      	muls	r2, r0
c0d038fc:	1889      	adds	r1, r1, r2
c0d038fe:	8b0a      	ldrh	r2, [r1, #24]
}

void ux_flow_prev(void) {
	// first reached already
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d03900:	2a00      	cmp	r2, #0
c0d03902:	d021      	beq.n	c0d03948 <ux_flow_prev+0x5c>
c0d03904:	690c      	ldr	r4, [r1, #16]
		|| G_ux.flow_stack[G_ux.stack_count-1].length <= 1
c0d03906:	2c00      	cmp	r4, #0
c0d03908:	d01e      	beq.n	c0d03948 <ux_flow_prev+0x5c>
		|| (G_ux.flow_stack[G_ux.stack_count-1].index == 0 
c0d0390a:	2a02      	cmp	r2, #2
c0d0390c:	d31c      	bcc.n	c0d03948 <ux_flow_prev+0x5c>
c0d0390e:	8a8d      	ldrh	r5, [r1, #20]
c0d03910:	460b      	mov	r3, r1
c0d03912:	3314      	adds	r3, #20
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
c0d03914:	2d00      	cmp	r5, #0
c0d03916:	d00a      	beq.n	c0d0392e <ux_flow_prev+0x42>
		ux_flow_engine_init_step(G_ux.stack_count-1);
		return;
	}

	// previous item is a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index-1] == FLOW_BARRIER) {
c0d03918:	00aa      	lsls	r2, r5, #2
c0d0391a:	18a2      	adds	r2, r4, r2
c0d0391c:	2403      	movs	r4, #3
c0d0391e:	43e4      	mvns	r4, r4
c0d03920:	5912      	ldr	r2, [r2, r4]
c0d03922:	1c92      	adds	r2, r2, #2
c0d03924:	d010      	beq.n	c0d03948 <ux_flow_prev+0x5c>
		return;
	}

	// advance flow pointer and display it (skip META STEPS)
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
c0d03926:	82cd      	strh	r5, [r1, #22]
	G_ux.flow_stack[G_ux.stack_count-1].index--;
c0d03928:	1e69      	subs	r1, r5, #1
c0d0392a:	8019      	strh	r1, [r3, #0]
c0d0392c:	e00a      	b.n	c0d03944 <ux_flow_prev+0x58>
	// first reached already
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
		|| G_ux.flow_stack[G_ux.stack_count-1].length <= 1
		|| (G_ux.flow_stack[G_ux.stack_count-1].index == 0 
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
c0d0392e:	0095      	lsls	r5, r2, #2
c0d03930:	1964      	adds	r4, r4, r5
c0d03932:	2503      	movs	r5, #3
c0d03934:	43ed      	mvns	r5, r5
c0d03936:	5964      	ldr	r4, [r4, r5]
	ux_flow_next_internal(1);
}

void ux_flow_prev(void) {
	// first reached already
	if (!ux_flow_check_valid()
c0d03938:	1ce4      	adds	r4, r4, #3
c0d0393a:	d105      	bne.n	c0d03948 <ux_flow_prev+0x5c>

	// loop in flow (before checking barrier as there is no prestep when looping)
	if (G_ux.flow_stack[G_ux.stack_count-1].index == 0
		&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] == FLOW_LOOP) {
		// display last step (shall skip BARRIER if any, but a flow finishing with a BARRIER is cryptic)
		G_ux.flow_stack[G_ux.stack_count-1].index = G_ux.flow_stack[G_ux.stack_count-1].length-2;
c0d0393c:	1e94      	subs	r4, r2, #2
c0d0393e:	801c      	strh	r4, [r3, #0]
		// fact direction as backward
		G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index+1;
c0d03940:	1e52      	subs	r2, r2, #1
c0d03942:	82ca      	strh	r2, [r1, #22]
c0d03944:	f000 f804 	bl	c0d03950 <ux_flow_engine_init_step>
	// advance flow pointer and display it (skip META STEPS)
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
	G_ux.flow_stack[G_ux.stack_count-1].index--;

	ux_flow_engine_init_step(G_ux.stack_count-1);
}
c0d03948:	bdb0      	pop	{r4, r5, r7, pc}
c0d0394a:	46c0      	nop			; (mov r8, r8)
c0d0394c:	2000186c 	.word	0x2000186c

c0d03950 <ux_flow_engine_init_step>:
		return NULL;
	}
	return STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index]);
}

static void ux_flow_engine_init_step(unsigned int stack_slot) {
c0d03950:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03952:	b081      	sub	sp, #4
c0d03954:	4604      	mov	r4, r0
c0d03956:	200c      	movs	r0, #12
	// invalid ux_flow_length ??? (previous check shall have exited earlier)
	if (G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] == FLOW_END_STEP) {
c0d03958:	4360      	muls	r0, r4
c0d0395a:	491a      	ldr	r1, [pc, #104]	; (c0d039c4 <ux_flow_engine_init_step+0x74>)
c0d0395c:	180e      	adds	r6, r1, r0
c0d0395e:	6930      	ldr	r0, [r6, #16]
c0d03960:	8ab1      	ldrh	r1, [r6, #20]
c0d03962:	0089      	lsls	r1, r1, #2
c0d03964:	5840      	ldr	r0, [r0, r1]
c0d03966:	4637      	mov	r7, r6
c0d03968:	3714      	adds	r7, #20
c0d0396a:	3610      	adds	r6, #16
c0d0396c:	2103      	movs	r1, #3
c0d0396e:	43c9      	mvns	r1, r1
c0d03970:	4288      	cmp	r0, r1
c0d03972:	d824      	bhi.n	c0d039be <ux_flow_engine_init_step+0x6e>
	// this shall not have occured due to previous checks
	if (G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] == FLOW_LOOP) {
		return;
	}
	// if init function is set, call it
	if (STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init) {
c0d03974:	f7fd ff8c 	bl	c0d01890 <pic>
c0d03978:	6831      	ldr	r1, [r6, #0]
c0d0397a:	883a      	ldrh	r2, [r7, #0]
c0d0397c:	0092      	lsls	r2, r2, #2
c0d0397e:	5889      	ldr	r1, [r1, r2]
c0d03980:	6805      	ldr	r5, [r0, #0]
c0d03982:	4608      	mov	r0, r1
c0d03984:	f7fd ff84 	bl	c0d01890 <pic>
c0d03988:	2d00      	cmp	r5, #0
c0d0398a:	d006      	beq.n	c0d0399a <ux_flow_engine_init_step+0x4a>
		INITPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init)(stack_slot);
c0d0398c:	6800      	ldr	r0, [r0, #0]
c0d0398e:	f7fd ff7f 	bl	c0d01890 <pic>
c0d03992:	4601      	mov	r1, r0
c0d03994:	4620      	mov	r0, r4
c0d03996:	4788      	blx	r1
c0d03998:	e011      	b.n	c0d039be <ux_flow_engine_init_step+0x6e>
	}
	else {
		// if init method is not set, jump to referenced flow and step
		ux_flow_init(stack_slot,
			           STEPSPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->validate_flow), 
c0d0399a:	6880      	ldr	r0, [r0, #8]
c0d0399c:	f7fd ff78 	bl	c0d01890 <pic>
c0d039a0:	4605      	mov	r5, r0
			           (const ux_flow_step_t*) PIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->params));
c0d039a2:	6830      	ldr	r0, [r6, #0]
c0d039a4:	8839      	ldrh	r1, [r7, #0]
c0d039a6:	0089      	lsls	r1, r1, #2
c0d039a8:	5840      	ldr	r0, [r0, r1]
c0d039aa:	f7fd ff71 	bl	c0d01890 <pic>
c0d039ae:	6840      	ldr	r0, [r0, #4]
c0d039b0:	f7fd ff6e 	bl	c0d01890 <pic>
c0d039b4:	4602      	mov	r2, r0
	if (STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init) {
		INITPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init)(stack_slot);
	}
	else {
		// if init method is not set, jump to referenced flow and step
		ux_flow_init(stack_slot,
c0d039b6:	4620      	mov	r0, r4
c0d039b8:	4629      	mov	r1, r5
c0d039ba:	f000 f85d 	bl	c0d03a78 <ux_flow_init>
			           STEPSPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->validate_flow), 
			           (const ux_flow_step_t*) PIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->params));
	}
}
c0d039be:	b001      	add	sp, #4
c0d039c0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d039c2:	46c0      	nop			; (mov r8, r8)
c0d039c4:	2000186c 	.word	0x2000186c

c0d039c8 <ux_flow_validate>:
	G_ux.flow_stack[G_ux.stack_count-1].index--;

	ux_flow_engine_init_step(G_ux.stack_count-1);
}

void ux_flow_validate(void) {
c0d039c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d039ca:	b081      	sub	sp, #4
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d039cc:	4d29      	ldr	r5, [pc, #164]	; (c0d03a74 <ux_flow_validate+0xac>)
c0d039ce:	7828      	ldrb	r0, [r5, #0]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d039d0:	2801      	cmp	r0, #1
c0d039d2:	d825      	bhi.n	c0d03a20 <ux_flow_validate+0x58>
c0d039d4:	1e40      	subs	r0, r0, #1
c0d039d6:	260c      	movs	r6, #12
c0d039d8:	4370      	muls	r0, r6
c0d039da:	182a      	adds	r2, r5, r0
c0d039dc:	8b10      	ldrh	r0, [r2, #24]
}

void ux_flow_validate(void) {
	// no flow ?
	if (!ux_flow_check_valid()
	  || G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d039de:	2800      	cmp	r0, #0
c0d039e0:	d01e      	beq.n	c0d03a20 <ux_flow_validate+0x58>
c0d039e2:	6911      	ldr	r1, [r2, #16]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0
c0d039e4:	2900      	cmp	r1, #0
c0d039e6:	d01b      	beq.n	c0d03a20 <ux_flow_validate+0x58>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length) {
c0d039e8:	8a92      	ldrh	r2, [r2, #20]
	ux_flow_engine_init_step(G_ux.stack_count-1);
}

void ux_flow_validate(void) {
	// no flow ?
	if (!ux_flow_check_valid()
c0d039ea:	4282      	cmp	r2, r0
c0d039ec:	d218      	bcs.n	c0d03a20 <ux_flow_validate+0x58>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length) {
		return;
	}

	// no validation flow ?
	if (STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index])->validate_flow != NULL) {
c0d039ee:	0090      	lsls	r0, r2, #2
c0d039f0:	5808      	ldr	r0, [r1, r0]
c0d039f2:	f7fd ff4d 	bl	c0d01890 <pic>
c0d039f6:	6880      	ldr	r0, [r0, #8]
c0d039f8:	7829      	ldrb	r1, [r5, #0]
c0d039fa:	1e4c      	subs	r4, r1, #1
	}
	else {
		// if next is a barrier, then proceed to the item after the barrier
		// if NOT followed by a barrier, then validation is only performed through 
		// a validate_flow specified in the step, else ignored
		if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d039fc:	4366      	muls	r6, r4
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length) {
		return;
	}

	// no validation flow ?
	if (STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index])->validate_flow != NULL) {
c0d039fe:	2800      	cmp	r0, #0
c0d03a00:	d010      	beq.n	c0d03a24 <ux_flow_validate+0x5c>
		// execute validation flow
		ux_flow_init(G_ux.stack_count-1, STEPSPIC(STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index])->validate_flow), NULL);
c0d03a02:	19a8      	adds	r0, r5, r6
c0d03a04:	6901      	ldr	r1, [r0, #16]
c0d03a06:	8a80      	ldrh	r0, [r0, #20]
c0d03a08:	0080      	lsls	r0, r0, #2
c0d03a0a:	5808      	ldr	r0, [r1, r0]
c0d03a0c:	f7fd ff40 	bl	c0d01890 <pic>
c0d03a10:	6880      	ldr	r0, [r0, #8]
c0d03a12:	f7fd ff3d 	bl	c0d01890 <pic>
c0d03a16:	4601      	mov	r1, r0
c0d03a18:	2200      	movs	r2, #0
c0d03a1a:	4620      	mov	r0, r4
c0d03a1c:	f000 f82c 	bl	c0d03a78 <ux_flow_init>
				// execute reached step
				ux_flow_engine_init_step(G_ux.stack_count-1);
			}
		}
	}
}
c0d03a20:	b001      	add	sp, #4
c0d03a22:	bdf0      	pop	{r4, r5, r6, r7, pc}
	}
	else {
		// if next is a barrier, then proceed to the item after the barrier
		// if NOT followed by a barrier, then validation is only performed through 
		// a validate_flow specified in the step, else ignored
		if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d03a24:	19a8      	adds	r0, r5, r6
c0d03a26:	8b03      	ldrh	r3, [r0, #24]
			&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {
c0d03a28:	2b00      	cmp	r3, #0
c0d03a2a:	d0f9      	beq.n	c0d03a20 <ux_flow_validate+0x58>
c0d03a2c:	8a82      	ldrh	r2, [r0, #20]
c0d03a2e:	4601      	mov	r1, r0
c0d03a30:	3114      	adds	r1, #20
c0d03a32:	1e9b      	subs	r3, r3, #2
	}
	else {
		// if next is a barrier, then proceed to the item after the barrier
		// if NOT followed by a barrier, then validation is only performed through 
		// a validate_flow specified in the step, else ignored
		if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d03a34:	4293      	cmp	r3, r2
c0d03a36:	dbf3      	blt.n	c0d03a20 <ux_flow_validate+0x58>
			&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {

			if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d03a38:	6905      	ldr	r5, [r0, #16]
c0d03a3a:	0096      	lsls	r6, r2, #2
c0d03a3c:	19ae      	adds	r6, r5, r6
c0d03a3e:	6876      	ldr	r6, [r6, #4]
c0d03a40:	1cf7      	adds	r7, r6, #3
c0d03a42:	d010      	beq.n	c0d03a66 <ux_flow_validate+0x9e>
c0d03a44:	1cb6      	adds	r6, r6, #2
c0d03a46:	d1eb      	bne.n	c0d03a20 <ux_flow_validate+0x58>
c0d03a48:	4616      	mov	r6, r2

				// take into account multi barrier at once, kthx poor code review
				while (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
					&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2
					&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d03a4a:	00b6      	lsls	r6, r6, #2
c0d03a4c:	19ae      	adds	r6, r5, r6
c0d03a4e:	6876      	ldr	r6, [r6, #4]
			&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {

			if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {

				// take into account multi barrier at once, kthx poor code review
				while (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d03a50:	1cb6      	adds	r6, r6, #2
c0d03a52:	d104      	bne.n	c0d03a5e <ux_flow_validate+0x96>
					&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2
					&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
					G_ux.flow_stack[G_ux.stack_count-1].index++;
c0d03a54:	1c52      	adds	r2, r2, #1
c0d03a56:	800a      	strh	r2, [r1, #0]

			if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {

				// take into account multi barrier at once, kthx poor code review
				while (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
					&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2
c0d03a58:	b296      	uxth	r6, r2
					&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d03a5a:	42b3      	cmp	r3, r6
c0d03a5c:	daf5      	bge.n	c0d03a4a <ux_flow_validate+0x82>
					G_ux.flow_stack[G_ux.stack_count-1].index++;
				}
				// skip to next step
				G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
c0d03a5e:	82c2      	strh	r2, [r0, #22]
				G_ux.flow_stack[G_ux.stack_count-1].index++;
c0d03a60:	1c50      	adds	r0, r2, #1
c0d03a62:	8008      	strh	r0, [r1, #0]
c0d03a64:	e002      	b.n	c0d03a6c <ux_flow_validate+0xa4>
c0d03a66:	2200      	movs	r2, #0
				ux_flow_engine_init_step(G_ux.stack_count-1);
			}
			// reached the last step, but step if FLOW_LOOP
			else if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_LOOP) {
				// we go the forward direction
				G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index = 0;
c0d03a68:	800a      	strh	r2, [r1, #0]
c0d03a6a:	82c2      	strh	r2, [r0, #22]
c0d03a6c:	4620      	mov	r0, r4
c0d03a6e:	f7ff ff6f 	bl	c0d03950 <ux_flow_engine_init_step>
c0d03a72:	e7d5      	b.n	c0d03a20 <ux_flow_validate+0x58>
c0d03a74:	2000186c 	.word	0x2000186c

c0d03a78 <ux_flow_init>:
 * Last step is marked with a FLOW_END_STEP value
 */
#define FLOW_END_STEP ((void*)0xFFFFFFFFUL)
#define FLOW_BARRIER  ((void*)0xFFFFFFFEUL)
#define FLOW_START    ((void*)0xFFFFFFFDUL)
void ux_flow_init(unsigned int stack_slot, const ux_flow_step_t* const * steps, const ux_flow_step_t* const start_step) {
c0d03a78:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03a7a:	b083      	sub	sp, #12
c0d03a7c:	9201      	str	r2, [sp, #4]
c0d03a7e:	460c      	mov	r4, r1
c0d03a80:	220c      	movs	r2, #12
	G_ux.flow_stack[stack_slot].length = G_ux.flow_stack[stack_slot].prev_index = G_ux.flow_stack[stack_slot].index = 0;
c0d03a82:	4611      	mov	r1, r2
c0d03a84:	9002      	str	r0, [sp, #8]
c0d03a86:	4341      	muls	r1, r0
c0d03a88:	4b1f      	ldr	r3, [pc, #124]	; (c0d03b08 <ux_flow_init+0x90>)
c0d03a8a:	185f      	adds	r7, r3, r1
c0d03a8c:	2100      	movs	r1, #0
	G_ux.flow_stack[stack_slot].steps = NULL;
c0d03a8e:	8339      	strh	r1, [r7, #24]
c0d03a90:	6139      	str	r1, [r7, #16]
c0d03a92:	6179      	str	r1, [r7, #20]
	
	// reset paging to avoid troubles if first step is a paginated step
	os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d03a94:	1d18      	adds	r0, r3, #4
c0d03a96:	f7fd f823 	bl	c0d00ae0 <os_memset>
c0d03a9a:	4620      	mov	r0, r4
 */
#define FLOW_END_STEP ((void*)0xFFFFFFFFUL)
#define FLOW_BARRIER  ((void*)0xFFFFFFFEUL)
#define FLOW_START    ((void*)0xFFFFFFFDUL)
void ux_flow_init(unsigned int stack_slot, const ux_flow_step_t* const * steps, const ux_flow_step_t* const start_step) {
	G_ux.flow_stack[stack_slot].length = G_ux.flow_stack[stack_slot].prev_index = G_ux.flow_stack[stack_slot].index = 0;
c0d03a9c:	463c      	mov	r4, r7
c0d03a9e:	3410      	adds	r4, #16
c0d03aa0:	463d      	mov	r5, r7
c0d03aa2:	3518      	adds	r5, #24
c0d03aa4:	463e      	mov	r6, r7
c0d03aa6:	3616      	adds	r6, #22
c0d03aa8:	3714      	adds	r7, #20
	G_ux.flow_stack[stack_slot].steps = NULL;
	
	// reset paging to avoid troubles if first step is a paginated step
	os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));

	if (steps) {
c0d03aaa:	2800      	cmp	r0, #0
c0d03aac:	d02a      	beq.n	c0d03b04 <ux_flow_init+0x8c>
		G_ux.flow_stack[stack_slot].steps = STEPSPIC(steps);
c0d03aae:	f7fd feef 	bl	c0d01890 <pic>
c0d03ab2:	6020      	str	r0, [r4, #0]
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
c0d03ab4:	8829      	ldrh	r1, [r5, #0]
c0d03ab6:	008a      	lsls	r2, r1, #2
c0d03ab8:	5882      	ldr	r2, [r0, r2]
c0d03aba:	1c52      	adds	r2, r2, #1
c0d03abc:	d006      	beq.n	c0d03acc <ux_flow_init+0x54>
			G_ux.flow_stack[stack_slot].length++;
c0d03abe:	1c49      	adds	r1, r1, #1
	// reset paging to avoid troubles if first step is a paginated step
	os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));

	if (steps) {
		G_ux.flow_stack[stack_slot].steps = STEPSPIC(steps);
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
c0d03ac0:	b28a      	uxth	r2, r1
c0d03ac2:	0092      	lsls	r2, r2, #2
c0d03ac4:	5882      	ldr	r2, [r0, r2]
c0d03ac6:	1c52      	adds	r2, r2, #1
c0d03ac8:	d1f9      	bne.n	c0d03abe <ux_flow_init+0x46>
c0d03aca:	8029      	strh	r1, [r5, #0]
c0d03acc:	9801      	ldr	r0, [sp, #4]
			G_ux.flow_stack[stack_slot].length++;
		}
		if (start_step != NULL) {
c0d03ace:	2800      	cmp	r0, #0
c0d03ad0:	d015      	beq.n	c0d03afe <ux_flow_init+0x86>
			const ux_flow_step_t* const start_step2  = STEPPIC(start_step);
c0d03ad2:	f7fd fedd 	bl	c0d01890 <pic>
c0d03ad6:	4605      	mov	r5, r0
			while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] != FLOW_END_STEP
c0d03ad8:	6820      	ldr	r0, [r4, #0]
c0d03ada:	8839      	ldrh	r1, [r7, #0]
c0d03adc:	0089      	lsls	r1, r1, #2
c0d03ade:	5840      	ldr	r0, [r0, r1]
c0d03ae0:	e00b      	b.n	c0d03afa <ux_flow_init+0x82>
				 && STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index]) != start_step2) {
c0d03ae2:	f7fd fed5 	bl	c0d01890 <pic>
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
			G_ux.flow_stack[stack_slot].length++;
		}
		if (start_step != NULL) {
			const ux_flow_step_t* const start_step2  = STEPPIC(start_step);
			while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] != FLOW_END_STEP
c0d03ae6:	42a8      	cmp	r0, r5
c0d03ae8:	d009      	beq.n	c0d03afe <ux_flow_init+0x86>
				 && STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index]) != start_step2) {
				G_ux.flow_stack[stack_slot].prev_index = G_ux.flow_stack[stack_slot].index;
c0d03aea:	8838      	ldrh	r0, [r7, #0]
c0d03aec:	8030      	strh	r0, [r6, #0]
				G_ux.flow_stack[stack_slot].index++;
c0d03aee:	1c40      	adds	r0, r0, #1
c0d03af0:	8038      	strh	r0, [r7, #0]
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
			G_ux.flow_stack[stack_slot].length++;
		}
		if (start_step != NULL) {
			const ux_flow_step_t* const start_step2  = STEPPIC(start_step);
			while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] != FLOW_END_STEP
c0d03af2:	b280      	uxth	r0, r0
c0d03af4:	0080      	lsls	r0, r0, #2
c0d03af6:	6821      	ldr	r1, [r4, #0]
c0d03af8:	5808      	ldr	r0, [r1, r0]
				 && STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index]) != start_step2) {
c0d03afa:	1c41      	adds	r1, r0, #1
c0d03afc:	d1f1      	bne.n	c0d03ae2 <ux_flow_init+0x6a>
				G_ux.flow_stack[stack_slot].index++;
			}
		}

		// init step
		ux_flow_engine_init_step(stack_slot);
c0d03afe:	9802      	ldr	r0, [sp, #8]
c0d03b00:	f7ff ff26 	bl	c0d03950 <ux_flow_engine_init_step>
	}
}
c0d03b04:	b003      	add	sp, #12
c0d03b06:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03b08:	2000186c 	.word	0x2000186c

c0d03b0c <ux_flow_button_callback>:

void ux_flow_uninit(unsigned int stack_slot) {
	memset(&G_ux.flow_stack[stack_slot], 0, sizeof(G_ux.flow_stack[stack_slot]));
}

unsigned int ux_flow_button_callback(unsigned int button_mask, unsigned int button_mask_counter) {
c0d03b0c:	b580      	push	{r7, lr}
c0d03b0e:	490a      	ldr	r1, [pc, #40]	; (c0d03b38 <ux_flow_button_callback+0x2c>)
  UNUSED(button_mask_counter);
  switch(button_mask) {
c0d03b10:	4288      	cmp	r0, r1
c0d03b12:	d008      	beq.n	c0d03b26 <ux_flow_button_callback+0x1a>
c0d03b14:	4909      	ldr	r1, [pc, #36]	; (c0d03b3c <ux_flow_button_callback+0x30>)
c0d03b16:	4288      	cmp	r0, r1
c0d03b18:	d008      	beq.n	c0d03b2c <ux_flow_button_callback+0x20>
c0d03b1a:	4909      	ldr	r1, [pc, #36]	; (c0d03b40 <ux_flow_button_callback+0x34>)
c0d03b1c:	4288      	cmp	r0, r1
c0d03b1e:	d108      	bne.n	c0d03b32 <ux_flow_button_callback+0x26>
    case BUTTON_EVT_RELEASED|BUTTON_LEFT:
      ux_flow_prev();
c0d03b20:	f7ff fee4 	bl	c0d038ec <ux_flow_prev>
c0d03b24:	e005      	b.n	c0d03b32 <ux_flow_button_callback+0x26>
      break;
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      ux_flow_next();
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      ux_flow_validate();
c0d03b26:	f7ff ff4f 	bl	c0d039c8 <ux_flow_validate>
c0d03b2a:	e002      	b.n	c0d03b32 <ux_flow_button_callback+0x26>
c0d03b2c:	2001      	movs	r0, #1
void ux_flow_next_no_display(void) {
	ux_flow_next_internal(0);
}

void ux_flow_next(void) {
	ux_flow_next_internal(1);
c0d03b2e:	f7ff fea5 	bl	c0d0387c <ux_flow_next_internal>
c0d03b32:	2000      	movs	r0, #0
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      ux_flow_validate();
      break;
  }
  return 0;
c0d03b34:	bd80      	pop	{r7, pc}
c0d03b36:	46c0      	nop			; (mov r8, r8)
c0d03b38:	80000003 	.word	0x80000003
c0d03b3c:	80000002 	.word	0x80000002
c0d03b40:	80000001 	.word	0x80000001

c0d03b44 <ux_stack_get_step_params>:
}

void* ux_stack_get_step_params(unsigned int stack_slot) {
c0d03b44:	b510      	push	{r4, lr}
c0d03b46:	4601      	mov	r1, r0
c0d03b48:	2000      	movs	r0, #0
	if (stack_slot >= UX_STACK_SLOT_COUNT) {
c0d03b4a:	2900      	cmp	r1, #0
c0d03b4c:	d10f      	bne.n	c0d03b6e <ux_stack_get_step_params+0x2a>
		return NULL;
	}

	if (G_ux.flow_stack[stack_slot].length == 0) {
c0d03b4e:	4c08      	ldr	r4, [pc, #32]	; (c0d03b70 <ux_stack_get_step_params+0x2c>)
c0d03b50:	8b21      	ldrh	r1, [r4, #24]
		return NULL;
	}

	if (G_ux.flow_stack[stack_slot].index >= G_ux.flow_stack[stack_slot].length) {
c0d03b52:	8aa2      	ldrh	r2, [r4, #20]
void* ux_stack_get_step_params(unsigned int stack_slot) {
	if (stack_slot >= UX_STACK_SLOT_COUNT) {
		return NULL;
	}

	if (G_ux.flow_stack[stack_slot].length == 0) {
c0d03b54:	428a      	cmp	r2, r1
c0d03b56:	d20a      	bcs.n	c0d03b6e <ux_stack_get_step_params+0x2a>

	if (G_ux.flow_stack[stack_slot].index >= G_ux.flow_stack[stack_slot].length) {
		return NULL;
	}

	return (void*)PIC(STEPPIC(STEPSPIC(G_ux.flow_stack[stack_slot].steps)[G_ux.flow_stack[stack_slot].index])->params);
c0d03b58:	6920      	ldr	r0, [r4, #16]
c0d03b5a:	f7fd fe99 	bl	c0d01890 <pic>
c0d03b5e:	8aa1      	ldrh	r1, [r4, #20]
c0d03b60:	0089      	lsls	r1, r1, #2
c0d03b62:	5840      	ldr	r0, [r0, r1]
c0d03b64:	f7fd fe94 	bl	c0d01890 <pic>
c0d03b68:	6840      	ldr	r0, [r0, #4]
c0d03b6a:	f7fd fe91 	bl	c0d01890 <pic>
}
c0d03b6e:	bd10      	pop	{r4, pc}
c0d03b70:	2000186c 	.word	0x2000186c

c0d03b74 <ux_stack_get_current_step_params>:

void* ux_stack_get_current_step_params(void) {
c0d03b74:	b580      	push	{r7, lr}
	return ux_stack_get_step_params(G_ux.stack_count-1);
c0d03b76:	4803      	ldr	r0, [pc, #12]	; (c0d03b84 <ux_stack_get_current_step_params+0x10>)
c0d03b78:	7800      	ldrb	r0, [r0, #0]
c0d03b7a:	1e40      	subs	r0, r0, #1
c0d03b7c:	f7ff ffe2 	bl	c0d03b44 <ux_stack_get_step_params>
c0d03b80:	bd80      	pop	{r7, pc}
c0d03b82:	46c0      	nop			; (mov r8, r8)
c0d03b84:	2000186c 	.word	0x2000186c

c0d03b88 <ux_layout_bb_init_common>:
  }
  return &G_ux.tmp_element;
}
*/

void ux_layout_bb_init_common(unsigned int stack_slot) {
c0d03b88:	b510      	push	{r4, lr}
c0d03b8a:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d03b8c:	f000 fbf2 	bl	c0d04374 <ux_stack_init>
c0d03b90:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_bb_elements;
c0d03b92:	4360      	muls	r0, r4
c0d03b94:	4908      	ldr	r1, [pc, #32]	; (c0d03bb8 <ux_layout_bb_init_common+0x30>)
c0d03b96:	1808      	adds	r0, r1, r0
c0d03b98:	21c4      	movs	r1, #196	; 0xc4
c0d03b9a:	2205      	movs	r2, #5
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_bb_elements);
c0d03b9c:	5442      	strb	r2, [r0, r1]
c0d03b9e:	21c0      	movs	r1, #192	; 0xc0
}
*/

void ux_layout_bb_init_common(unsigned int stack_slot) {
  ux_stack_init(stack_slot);
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_bb_elements;
c0d03ba0:	4a06      	ldr	r2, [pc, #24]	; (c0d03bbc <ux_layout_bb_init_common+0x34>)
c0d03ba2:	447a      	add	r2, pc
c0d03ba4:	5042      	str	r2, [r0, r1]
c0d03ba6:	21bd      	movs	r1, #189	; 0xbd
c0d03ba8:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_bb_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d03baa:	5442      	strb	r2, [r0, r1]
c0d03bac:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d03bae:	4a04      	ldr	r2, [pc, #16]	; (c0d03bc0 <ux_layout_bb_init_common+0x38>)
c0d03bb0:	447a      	add	r2, pc
c0d03bb2:	5042      	str	r2, [r0, r1]
}
c0d03bb4:	bd10      	pop	{r4, pc}
c0d03bb6:	46c0      	nop			; (mov r8, r8)
c0d03bb8:	2000186c 	.word	0x2000186c
c0d03bbc:	00001376 	.word	0x00001376
c0d03bc0:	ffffff59 	.word	0xffffff59

c0d03bc4 <ux_layout_bn_prepro>:
#endif
#endif
};
*/

const bagl_element_t* ux_layout_bn_prepro(const bagl_element_t* element) {
c0d03bc4:	b580      	push	{r7, lr}
      G_ux.tmp_element.text = params->line2;
      break;
  }
  return &G_ux.tmp_element;
*/
  const bagl_element_t* e = ux_layout_strings_prepro(element);
c0d03bc6:	f000 fae9 	bl	c0d0419c <ux_layout_strings_prepro>
c0d03bca:	229d      	movs	r2, #157	; 0x9d
  if (e && G_ux.tmp_element.component.userid == 0x11) {
c0d03bcc:	2800      	cmp	r0, #0
c0d03bce:	d006      	beq.n	c0d03bde <ux_layout_bn_prepro+0x1a>
c0d03bd0:	4903      	ldr	r1, [pc, #12]	; (c0d03be0 <ux_layout_bn_prepro+0x1c>)
c0d03bd2:	5c8a      	ldrb	r2, [r1, r2]
c0d03bd4:	2a11      	cmp	r2, #17
c0d03bd6:	d102      	bne.n	c0d03bde <ux_layout_bn_prepro+0x1a>
c0d03bd8:	22b4      	movs	r2, #180	; 0xb4
c0d03bda:	4b02      	ldr	r3, [pc, #8]	; (c0d03be4 <ux_layout_bn_prepro+0x20>)
    G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_REGULAR_11px|BAGL_FONT_ALIGNMENT_CENTER;
c0d03bdc:	528b      	strh	r3, [r1, r2]
  }
  return e;
c0d03bde:	bd80      	pop	{r7, pc}
c0d03be0:	2000186c 	.word	0x2000186c
c0d03be4:	0000800a 	.word	0x0000800a

c0d03be8 <ux_layout_bn_init>:
}

void ux_layout_bn_init(unsigned int stack_slot) { 
c0d03be8:	b510      	push	{r4, lr}
c0d03bea:	4604      	mov	r4, r0
  ux_layout_bb_init_common(stack_slot);
c0d03bec:	f7ff ffcc 	bl	c0d03b88 <ux_layout_bb_init_common>
c0d03bf0:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_bn_prepro;
c0d03bf2:	4360      	muls	r0, r4
c0d03bf4:	4904      	ldr	r1, [pc, #16]	; (c0d03c08 <ux_layout_bn_init+0x20>)
c0d03bf6:	1808      	adds	r0, r1, r0
c0d03bf8:	21cc      	movs	r1, #204	; 0xcc
c0d03bfa:	4a04      	ldr	r2, [pc, #16]	; (c0d03c0c <ux_layout_bn_init+0x24>)
c0d03bfc:	447a      	add	r2, pc
c0d03bfe:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d03c00:	4620      	mov	r0, r4
c0d03c02:	f000 fb91 	bl	c0d04328 <ux_stack_display>
}
c0d03c06:	bd10      	pop	{r4, pc}
c0d03c08:	2000186c 	.word	0x2000186c
c0d03c0c:	ffffffc5 	.word	0xffffffc5

c0d03c10 <ux_layout_nnbnn_prepro>:
  {{BAGL_LABELINE                       , 0x12,   0,  19, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},  
  {{BAGL_LABELINE                       , 0x13,   0,  35, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_REGULAR_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
#endif // TARGET_NANOX
};

const bagl_element_t* ux_layout_nnbnn_prepro(const bagl_element_t* element) {
c0d03c10:	b570      	push	{r4, r5, r6, lr}
c0d03c12:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_strings_params_t* params = (const ux_layout_strings_params_t*)ux_stack_get_current_step_params();
c0d03c14:	f7ff ffae 	bl	c0d03b74 <ux_stack_get_current_step_params>
c0d03c18:	4604      	mov	r4, r0

	// ocpy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d03c1a:	4e11      	ldr	r6, [pc, #68]	; (c0d03c60 <ux_layout_nnbnn_prepro+0x50>)
c0d03c1c:	4630      	mov	r0, r6
c0d03c1e:	309c      	adds	r0, #156	; 0x9c
c0d03c20:	2220      	movs	r2, #32
c0d03c22:	4629      	mov	r1, r5
c0d03c24:	f7fc ff46 	bl	c0d00ab4 <os_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d03c28:	7868      	ldrb	r0, [r5, #1]
c0d03c2a:	4601      	mov	r1, r0
c0d03c2c:	3910      	subs	r1, #16
c0d03c2e:	2905      	cmp	r1, #5
c0d03c30:	d20a      	bcs.n	c0d03c48 <ux_layout_nnbnn_prepro+0x38>
c0d03c32:	209d      	movs	r0, #157	; 0x9d
    case 0x10:
    case 0x11:
    case 0x12:
    case 0x13:
    case 0x14:
      G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
c0d03c34:	5c30      	ldrb	r0, [r6, r0]
c0d03c36:	210f      	movs	r1, #15
c0d03c38:	4001      	ands	r1, r0
c0d03c3a:	0088      	lsls	r0, r1, #2
c0d03c3c:	5820      	ldr	r0, [r4, r0]
c0d03c3e:	21b8      	movs	r1, #184	; 0xb8
c0d03c40:	5070      	str	r0, [r6, r1]
c0d03c42:	369c      	adds	r6, #156	; 0x9c
c0d03c44:	4630      	mov	r0, r6
      break;
  }
  return &G_ux.tmp_element;
}
c0d03c46:	bd70      	pop	{r4, r5, r6, pc}

	// ocpy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d03c48:	2802      	cmp	r0, #2
c0d03c4a:	d003      	beq.n	c0d03c54 <ux_layout_nnbnn_prepro+0x44>
c0d03c4c:	2801      	cmp	r0, #1
c0d03c4e:	d1f8      	bne.n	c0d03c42 <ux_layout_nnbnn_prepro+0x32>

    case 0x01:
  		if (!params->lines[1]) {
c0d03c50:	6861      	ldr	r1, [r4, #4]
c0d03c52:	e000      	b.n	c0d03c56 <ux_layout_nnbnn_prepro+0x46>
  			return NULL;
  		}
  		break;

  	case 0x02:
  		if (!params->lines[3]) {
c0d03c54:	68e1      	ldr	r1, [r4, #12]
c0d03c56:	2000      	movs	r0, #0
c0d03c58:	2900      	cmp	r1, #0
c0d03c5a:	d1f2      	bne.n	c0d03c42 <ux_layout_nnbnn_prepro+0x32>
c0d03c5c:	e7f3      	b.n	c0d03c46 <ux_layout_nnbnn_prepro+0x36>
c0d03c5e:	46c0      	nop			; (mov r8, r8)
c0d03c60:	2000186c 	.word	0x2000186c

c0d03c64 <ux_layout_nnbnn_init>:
      break;
  }
  return &G_ux.tmp_element;
}

void ux_layout_nnbnn_init(unsigned int stack_slot) {
c0d03c64:	b510      	push	{r4, lr}
c0d03c66:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d03c68:	f000 fb84 	bl	c0d04374 <ux_stack_init>
c0d03c6c:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_nnbnn_elements;
c0d03c6e:	4360      	muls	r0, r4
c0d03c70:	490b      	ldr	r1, [pc, #44]	; (c0d03ca0 <ux_layout_nnbnn_init+0x3c>)
c0d03c72:	1808      	adds	r0, r1, r0
c0d03c74:	21c4      	movs	r1, #196	; 0xc4
c0d03c76:	2206      	movs	r2, #6
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_nnbnn_elements);
c0d03c78:	5442      	strb	r2, [r0, r1]
c0d03c7a:	21c0      	movs	r1, #192	; 0xc0
  return &G_ux.tmp_element;
}

void ux_layout_nnbnn_init(unsigned int stack_slot) {
  ux_stack_init(stack_slot);
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_nnbnn_elements;
c0d03c7c:	4a09      	ldr	r2, [pc, #36]	; (c0d03ca4 <ux_layout_nnbnn_init+0x40>)
c0d03c7e:	447a      	add	r2, pc
c0d03c80:	5042      	str	r2, [r0, r1]
c0d03c82:	21bd      	movs	r1, #189	; 0xbd
c0d03c84:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_nnbnn_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d03c86:	5442      	strb	r2, [r0, r1]
c0d03c88:	21cc      	movs	r1, #204	; 0xcc
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_nnbnn_prepro;
c0d03c8a:	4a07      	ldr	r2, [pc, #28]	; (c0d03ca8 <ux_layout_nnbnn_init+0x44>)
c0d03c8c:	447a      	add	r2, pc
c0d03c8e:	5042      	str	r2, [r0, r1]
c0d03c90:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d03c92:	4a06      	ldr	r2, [pc, #24]	; (c0d03cac <ux_layout_nnbnn_init+0x48>)
c0d03c94:	447a      	add	r2, pc
c0d03c96:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d03c98:	4620      	mov	r0, r4
c0d03c9a:	f000 fb45 	bl	c0d04328 <ux_stack_display>
}
c0d03c9e:	bd10      	pop	{r4, pc}
c0d03ca0:	2000186c 	.word	0x2000186c
c0d03ca4:	0000133a 	.word	0x0000133a
c0d03ca8:	ffffff81 	.word	0xffffff81
c0d03cac:	fffffe75 	.word	0xfffffe75

c0d03cb0 <ux_layout_paging_compute>:
  //       || (c >= '0' && c <= '9'));
  return c == ' ' || c == '\n' || c == '\t' || c == '-' || c == '_';
}

// return the number of pages to be displayed when current page to show is -1
unsigned int ux_layout_paging_compute(unsigned int stack_slot, unsigned int page_to_display) {
c0d03cb0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03cb2:	b085      	sub	sp, #20
c0d03cb4:	460e      	mov	r6, r1
  const ux_layout_paging_params_t* params = (const ux_layout_paging_params_t*)ux_stack_get_step_params(stack_slot);
c0d03cb6:	f7ff ff45 	bl	c0d03b44 <ux_stack_get_step_params>
c0d03cba:	9004      	str	r0, [sp, #16]

  // reset length and offset of lines
  os_memset(&G_ux.layout_paging.offsets, 0, sizeof(G_ux.layout_paging.offsets));
c0d03cbc:	4c45      	ldr	r4, [pc, #276]	; (c0d03dd4 <ux_layout_paging_compute+0x124>)
c0d03cbe:	4620      	mov	r0, r4
c0d03cc0:	300c      	adds	r0, #12
c0d03cc2:	2500      	movs	r5, #0
c0d03cc4:	2702      	movs	r7, #2
c0d03cc6:	4629      	mov	r1, r5
c0d03cc8:	463a      	mov	r2, r7
c0d03cca:	f7fc ff09 	bl	c0d00ae0 <os_memset>
  os_memset(&G_ux.layout_paging.lengths, 0, sizeof(G_ux.layout_paging.lengths));
c0d03cce:	4620      	mov	r0, r4
c0d03cd0:	300e      	adds	r0, #14
c0d03cd2:	9503      	str	r5, [sp, #12]
c0d03cd4:	4629      	mov	r1, r5
c0d03cd6:	463a      	mov	r2, r7
c0d03cd8:	f7fc ff02 	bl	c0d00ae0 <os_memset>

  // a page has been asked, but no page exists
  if (page_to_display != -1UL && G_ux.layout_paging.count == 0) {
c0d03cdc:	1c70      	adds	r0, r6, #1
c0d03cde:	9002      	str	r0, [sp, #8]
c0d03ce0:	d002      	beq.n	c0d03ce8 <ux_layout_paging_compute+0x38>
c0d03ce2:	68a0      	ldr	r0, [r4, #8]
c0d03ce4:	2800      	cmp	r0, #0
c0d03ce6:	d072      	beq.n	c0d03dce <ux_layout_paging_compute+0x11e>
  }

  // compute offset/length of text of each line for the current page
  unsigned int page = 0;
  unsigned int line = 0;
  const char* start = STRPIC(params->text);
c0d03ce8:	9804      	ldr	r0, [sp, #16]
c0d03cea:	6840      	ldr	r0, [r0, #4]
c0d03cec:	f7fd fdd0 	bl	c0d01890 <pic>
c0d03cf0:	4607      	mov	r7, r0
  const char* start2 = start;
  const char* end = start + strlen(start);
c0d03cf2:	f000 fce7 	bl	c0d046c4 <strlen>
c0d03cf6:	1839      	adds	r1, r7, r0
c0d03cf8:	2201      	movs	r2, #1
  while (start < end) {
c0d03cfa:	9203      	str	r2, [sp, #12]
c0d03cfc:	2801      	cmp	r0, #1
c0d03cfe:	db66      	blt.n	c0d03dce <ux_layout_paging_compute+0x11e>
c0d03d00:	6860      	ldr	r0, [r4, #4]
c0d03d02:	9003      	str	r0, [sp, #12]
c0d03d04:	68a0      	ldr	r0, [r4, #8]
c0d03d06:	9000      	str	r0, [sp, #0]
c0d03d08:	2000      	movs	r0, #0
c0d03d0a:	463c      	mov	r4, r7
c0d03d0c:	9701      	str	r7, [sp, #4]
c0d03d0e:	9004      	str	r0, [sp, #16]
c0d03d10:	2000      	movs	r0, #0
c0d03d12:	4607      	mov	r7, r0
c0d03d14:	4625      	mov	r5, r4
c0d03d16:	463e      	mov	r6, r7
    unsigned int len = 0;
    unsigned int linew = 0; 
    const char* last_word_delim = start;
    // not reached end of content
    while (start + len < end
c0d03d18:	19e2      	adds	r2, r4, r7
c0d03d1a:	428a      	cmp	r2, r1
c0d03d1c:	d215      	bcs.n	c0d03d4a <ux_layout_paging_compute+0x9a>
      #else // TARGET_NANOX
      // nano s does not have the bagl lib o nthe SE side
      linew = (len+1)*7 /* width of a capitalized W (the largest char in each font) */;
      #endif //TARGET_NANOX
      //if (start[len] )
      if (linew > PIXEL_PER_LINE) {
c0d03d1e:	1dc0      	adds	r0, r0, #7
      // compute new line length
      #ifdef TARGET_NANOX
      linew = bagl_compute_line_width(LINE_FONT, 0, start, len+1, BAGL_ENCODING_LATIN1);
      #else // TARGET_NANOX
      // nano s does not have the bagl lib o nthe SE side
      linew = (len+1)*7 /* width of a capitalized W (the largest char in each font) */;
c0d03d20:	1c77      	adds	r7, r6, #1
      #endif //TARGET_NANOX
      //if (start[len] )
      if (linew > PIXEL_PER_LINE) {
c0d03d22:	2872      	cmp	r0, #114	; 0x72
c0d03d24:	d811      	bhi.n	c0d03d4a <ux_layout_paging_compute+0x9a>
        // we got a full line
        break;
      }
      unsigned char c = start[len];
c0d03d26:	7813      	ldrb	r3, [r2, #0]

static unsigned int is_word_delim(unsigned char c) {
  // return !((c >= 'a' && c <= 'z') 
  //       || (c >= 'A' && c <= 'Z')
  //       || (c >= '0' && c <= '9'));
  return c == ' ' || c == '\n' || c == '\t' || c == '-' || c == '_';
c0d03d28:	461e      	mov	r6, r3
c0d03d2a:	3e09      	subs	r6, #9
c0d03d2c:	2e02      	cmp	r6, #2
c0d03d2e:	d306      	bcc.n	c0d03d3e <ux_layout_paging_compute+0x8e>
c0d03d30:	2b20      	cmp	r3, #32
c0d03d32:	d004      	beq.n	c0d03d3e <ux_layout_paging_compute+0x8e>
c0d03d34:	2b2d      	cmp	r3, #45	; 0x2d
c0d03d36:	d002      	beq.n	c0d03d3e <ux_layout_paging_compute+0x8e>
      if (linew > PIXEL_PER_LINE) {
        // we got a full line
        break;
      }
      unsigned char c = start[len];
      if (is_word_delim(c)) {
c0d03d38:	2b5f      	cmp	r3, #95	; 0x5f
c0d03d3a:	d000      	beq.n	c0d03d3e <ux_layout_paging_compute+0x8e>
c0d03d3c:	462a      	mov	r2, r5
c0d03d3e:	4615      	mov	r5, r2
c0d03d40:	2b0a      	cmp	r3, #10
c0d03d42:	d1e8      	bne.n	c0d03d16 <ux_layout_paging_compute+0x66>
c0d03d44:	19e0      	adds	r0, r4, r7
c0d03d46:	463e      	mov	r6, r7
c0d03d48:	e000      	b.n	c0d03d4c <ux_layout_paging_compute+0x9c>
        break;
      }
    }

    // if not splitting line onto a word delimiter, then cut at the previous word_delim, adjust len accordingly (and a wor delim has been found already)
    if (start + len < end && last_word_delim != start && len) {
c0d03d4a:	19a0      	adds	r0, r4, r6
c0d03d4c:	9f01      	ldr	r7, [sp, #4]
c0d03d4e:	4288      	cmp	r0, r1
c0d03d50:	d223      	bcs.n	c0d03d9a <ux_layout_paging_compute+0xea>
c0d03d52:	2e00      	cmp	r6, #0
c0d03d54:	d021      	beq.n	c0d03d9a <ux_layout_paging_compute+0xea>
c0d03d56:	42a5      	cmp	r5, r4
c0d03d58:	d01f      	beq.n	c0d03d9a <ux_layout_paging_compute+0xea>
      // if line split within a word
      if ((!is_word_delim(start[len-1]) && !is_word_delim(start[len]))) {
c0d03d5a:	19a0      	adds	r0, r4, r6
c0d03d5c:	2200      	movs	r2, #0
c0d03d5e:	43d2      	mvns	r2, r2
c0d03d60:	5c80      	ldrb	r0, [r0, r2]

static unsigned int is_word_delim(unsigned char c) {
  // return !((c >= 'a' && c <= 'z') 
  //       || (c >= 'A' && c <= 'Z')
  //       || (c >= '0' && c <= '9'));
  return c == ' ' || c == '\n' || c == '\t' || c == '-' || c == '_';
c0d03d62:	282c      	cmp	r0, #44	; 0x2c
c0d03d64:	dc06      	bgt.n	c0d03d74 <ux_layout_paging_compute+0xc4>
c0d03d66:	4602      	mov	r2, r0
c0d03d68:	3a09      	subs	r2, #9
c0d03d6a:	2a02      	cmp	r2, #2
c0d03d6c:	d315      	bcc.n	c0d03d9a <ux_layout_paging_compute+0xea>
c0d03d6e:	2820      	cmp	r0, #32
c0d03d70:	d013      	beq.n	c0d03d9a <ux_layout_paging_compute+0xea>
c0d03d72:	e003      	b.n	c0d03d7c <ux_layout_paging_compute+0xcc>
c0d03d74:	282d      	cmp	r0, #45	; 0x2d
c0d03d76:	d010      	beq.n	c0d03d9a <ux_layout_paging_compute+0xea>
c0d03d78:	285f      	cmp	r0, #95	; 0x5f
c0d03d7a:	d00e      	beq.n	c0d03d9a <ux_layout_paging_compute+0xea>
    }

    // if not splitting line onto a word delimiter, then cut at the previous word_delim, adjust len accordingly (and a wor delim has been found already)
    if (start + len < end && last_word_delim != start && len) {
      // if line split within a word
      if ((!is_word_delim(start[len-1]) && !is_word_delim(start[len]))) {
c0d03d7c:	5da0      	ldrb	r0, [r4, r6]

static unsigned int is_word_delim(unsigned char c) {
  // return !((c >= 'a' && c <= 'z') 
  //       || (c >= 'A' && c <= 'Z')
  //       || (c >= '0' && c <= '9'));
  return c == ' ' || c == '\n' || c == '\t' || c == '-' || c == '_';
c0d03d7e:	282c      	cmp	r0, #44	; 0x2c
c0d03d80:	dc06      	bgt.n	c0d03d90 <ux_layout_paging_compute+0xe0>
c0d03d82:	4602      	mov	r2, r0
c0d03d84:	3a09      	subs	r2, #9
c0d03d86:	2a02      	cmp	r2, #2
c0d03d88:	d307      	bcc.n	c0d03d9a <ux_layout_paging_compute+0xea>
c0d03d8a:	2820      	cmp	r0, #32
c0d03d8c:	d005      	beq.n	c0d03d9a <ux_layout_paging_compute+0xea>
c0d03d8e:	e003      	b.n	c0d03d98 <ux_layout_paging_compute+0xe8>
c0d03d90:	282d      	cmp	r0, #45	; 0x2d
c0d03d92:	d002      	beq.n	c0d03d9a <ux_layout_paging_compute+0xea>
c0d03d94:	285f      	cmp	r0, #95	; 0x5f
c0d03d96:	d000      	beq.n	c0d03d9a <ux_layout_paging_compute+0xea>

    // if not splitting line onto a word delimiter, then cut at the previous word_delim, adjust len accordingly (and a wor delim has been found already)
    if (start + len < end && last_word_delim != start && len) {
      // if line split within a word
      if ((!is_word_delim(start[len-1]) && !is_word_delim(start[len]))) {
        len = last_word_delim - start;
c0d03d98:	1b2e      	subs	r6, r5, r4
      }
    }

    // fill up the paging structure
    if (page_to_display != -1UL && G_ux.layout_paging.current == page && G_ux.layout_paging.current < G_ux.layout_paging.count) {
c0d03d9a:	9802      	ldr	r0, [sp, #8]
c0d03d9c:	2800      	cmp	r0, #0
c0d03d9e:	9b04      	ldr	r3, [sp, #16]
c0d03da0:	d006      	beq.n	c0d03db0 <ux_layout_paging_compute+0x100>
c0d03da2:	9803      	ldr	r0, [sp, #12]
c0d03da4:	4298      	cmp	r0, r3
c0d03da6:	d103      	bne.n	c0d03db0 <ux_layout_paging_compute+0x100>
c0d03da8:	9803      	ldr	r0, [sp, #12]
c0d03daa:	9a00      	ldr	r2, [sp, #0]
c0d03dac:	4290      	cmp	r0, r2
c0d03dae:	d309      	bcc.n	c0d03dc4 <ux_layout_paging_compute+0x114>
        return page;
      }
    }

    // prepare for next line
    start += len;
c0d03db0:	19a4      	adds	r4, r4, r6
    line++;
    if (
#if UX_LAYOUT_PAGING_LINE > 1
      line >= UX_LAYOUT_PAGING_LINE && 
#endif // UX_LAYOUT_PAGING_LINE
      start < end) {
c0d03db2:	1c58      	adds	r0, r3, #1
c0d03db4:	428c      	cmp	r4, r1
c0d03db6:	d300      	bcc.n	c0d03dba <ux_layout_paging_compute+0x10a>
c0d03db8:	4618      	mov	r0, r3
  unsigned int page = 0;
  unsigned int line = 0;
  const char* start = STRPIC(params->text);
  const char* start2 = start;
  const char* end = start + strlen(start);
  while (start < end) {
c0d03dba:	428c      	cmp	r4, r1
c0d03dbc:	d3a7      	bcc.n	c0d03d0e <ux_layout_paging_compute+0x5e>
      start < end) {
      page++;
      line = 0;
    }
  }
  return page+1;
c0d03dbe:	1c40      	adds	r0, r0, #1
c0d03dc0:	9003      	str	r0, [sp, #12]
c0d03dc2:	e004      	b.n	c0d03dce <ux_layout_paging_compute+0x11e>
c0d03dc4:	4803      	ldr	r0, [pc, #12]	; (c0d03dd4 <ux_layout_paging_compute+0x124>)
c0d03dc6:	4601      	mov	r1, r0
    }

    // fill up the paging structure
    if (page_to_display != -1UL && G_ux.layout_paging.current == page && G_ux.layout_paging.current < G_ux.layout_paging.count) {
      G_ux.layout_paging.offsets[line] = start - start2;
      G_ux.layout_paging.lengths[line] = len;
c0d03dc8:	81c6      	strh	r6, [r0, #14]
      }
    }

    // fill up the paging structure
    if (page_to_display != -1UL && G_ux.layout_paging.current == page && G_ux.layout_paging.current < G_ux.layout_paging.count) {
      G_ux.layout_paging.offsets[line] = start - start2;
c0d03dca:	1be0      	subs	r0, r4, r7
c0d03dcc:	8188      	strh	r0, [r1, #12]
      page++;
      line = 0;
    }
  }
  return page+1;
}
c0d03dce:	9803      	ldr	r0, [sp, #12]
c0d03dd0:	b005      	add	sp, #20
c0d03dd2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03dd4:	2000186c 	.word	0x2000186c

c0d03dd8 <ux_layout_paging_redisplay>:

// redisplay current page
void ux_layout_paging_redisplay(unsigned int stack_slot) {
c0d03dd8:	b5b0      	push	{r4, r5, r7, lr}
c0d03dda:	4604      	mov	r4, r0

#ifndef TARGET_NANOX
  ux_layout_bb_init_common(stack_slot);
c0d03ddc:	f7ff fed4 	bl	c0d03b88 <ux_layout_bb_init_common>
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_paging_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
#endif // TARGET_NANOX

  // request offsets and lengths of lines for the current page
  ux_layout_paging_compute(stack_slot, G_ux.layout_paging.current);
c0d03de0:	4d09      	ldr	r5, [pc, #36]	; (c0d03e08 <ux_layout_paging_redisplay+0x30>)
c0d03de2:	6869      	ldr	r1, [r5, #4]
c0d03de4:	4620      	mov	r0, r4
c0d03de6:	f7ff ff63 	bl	c0d03cb0 <ux_layout_paging_compute>
c0d03dea:	2024      	movs	r0, #36	; 0x24

  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_paging_prepro;
c0d03dec:	4360      	muls	r0, r4
c0d03dee:	1828      	adds	r0, r5, r0
c0d03df0:	21cc      	movs	r1, #204	; 0xcc
c0d03df2:	4a06      	ldr	r2, [pc, #24]	; (c0d03e0c <ux_layout_paging_redisplay+0x34>)
c0d03df4:	447a      	add	r2, pc
c0d03df6:	5042      	str	r2, [r0, r1]
c0d03df8:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_layout_paging_button_callback;
c0d03dfa:	4a05      	ldr	r2, [pc, #20]	; (c0d03e10 <ux_layout_paging_redisplay+0x38>)
c0d03dfc:	447a      	add	r2, pc
c0d03dfe:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d03e00:	4620      	mov	r0, r4
c0d03e02:	f000 fa91 	bl	c0d04328 <ux_stack_display>
}
c0d03e06:	bdb0      	pop	{r4, r5, r7, pc}
c0d03e08:	2000186c 	.word	0x2000186c
c0d03e0c:	0000001d 	.word	0x0000001d
c0d03e10:	00000115 	.word	0x00000115

c0d03e14 <ux_layout_paging_prepro>:
  {{BAGL_LABELINE                       , 0x12,   (128-PIXEL_PER_LINE)/2,  43, PIXEL_PER_LINE,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, LINE_FONT|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
  {{BAGL_LABELINE                       , 0x13,   (128-PIXEL_PER_LINE)/2,  57, PIXEL_PER_LINE,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, LINE_FONT|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
};
#endif // TARGET_NANOX

static const bagl_element_t* ux_layout_paging_prepro(const bagl_element_t* element) {
c0d03e14:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03e16:	b083      	sub	sp, #12
c0d03e18:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_paging_params_t* params = (const ux_layout_paging_params_t*)ux_stack_get_current_step_params();
c0d03e1a:	f7ff feab 	bl	c0d03b74 <ux_stack_get_current_step_params>
c0d03e1e:	4604      	mov	r4, r0
  
  // copy element before any mod
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d03e20:	4e37      	ldr	r6, [pc, #220]	; (c0d03f00 <ux_layout_paging_prepro+0xec>)
c0d03e22:	4630      	mov	r0, r6
c0d03e24:	309c      	adds	r0, #156	; 0x9c
c0d03e26:	2220      	movs	r2, #32
c0d03e28:	4629      	mov	r1, r5
c0d03e2a:	f7fc fe43 	bl	c0d00ab4 <os_memmove>

  switch (element->component.userid) {
c0d03e2e:	7868      	ldrb	r0, [r5, #1]
c0d03e30:	2810      	cmp	r0, #16
c0d03e32:	dc16      	bgt.n	c0d03e62 <ux_layout_paging_prepro+0x4e>
c0d03e34:	2801      	cmp	r0, #1
c0d03e36:	d033      	beq.n	c0d03ea0 <ux_layout_paging_prepro+0x8c>
c0d03e38:	2802      	cmp	r0, #2
c0d03e3a:	d03b      	beq.n	c0d03eb4 <ux_layout_paging_prepro+0xa0>
c0d03e3c:	2810      	cmp	r0, #16
c0d03e3e:	d15a      	bne.n	c0d03ef6 <ux_layout_paging_prepro+0xe2>
  		}
  		break;

    case 0x10:
      // display 
    	if (params->title) {
c0d03e40:	6820      	ldr	r0, [r4, #0]
c0d03e42:	2800      	cmp	r0, #0
c0d03e44:	d041      	beq.n	c0d03eca <ux_layout_paging_prepro+0xb6>
        SPRINTF(G_ux.string_buffer, (G_ux.layout_paging.count>1)?"%s (%d/%d)":"%s", STRPIC(params->title), G_ux.layout_paging.current+1, G_ux.layout_paging.count);
c0d03e46:	68b4      	ldr	r4, [r6, #8]
c0d03e48:	f7fd fd22 	bl	c0d01890 <pic>
c0d03e4c:	4603      	mov	r3, r0
c0d03e4e:	6870      	ldr	r0, [r6, #4]
c0d03e50:	68b1      	ldr	r1, [r6, #8]
c0d03e52:	466a      	mov	r2, sp
c0d03e54:	1c40      	adds	r0, r0, #1
c0d03e56:	c203      	stmia	r2!, {r0, r1}
c0d03e58:	2c01      	cmp	r4, #1
c0d03e5a:	d841      	bhi.n	c0d03ee0 <ux_layout_paging_prepro+0xcc>
c0d03e5c:	4a2a      	ldr	r2, [pc, #168]	; (c0d03f08 <ux_layout_paging_prepro+0xf4>)
c0d03e5e:	447a      	add	r2, pc
c0d03e60:	e040      	b.n	c0d03ee4 <ux_layout_paging_prepro+0xd0>
  const ux_layout_paging_params_t* params = (const ux_layout_paging_params_t*)ux_stack_get_current_step_params();
  
  // copy element before any mod
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  switch (element->component.userid) {
c0d03e62:	4601      	mov	r1, r0
c0d03e64:	3911      	subs	r1, #17
c0d03e66:	2903      	cmp	r1, #3
c0d03e68:	d245      	bcs.n	c0d03ef6 <ux_layout_paging_prepro+0xe2>
c0d03e6a:	210f      	movs	r1, #15
      break;

    case 0x11:
    case 0x12:
    case 0x13: {
      unsigned int lineidx = (element->component.userid&0xF)-1;
c0d03e6c:	4008      	ands	r0, r1
c0d03e6e:	1e40      	subs	r0, r0, #1
      if (G_ux.layout_paging.lengths[lineidx]) {
c0d03e70:	0040      	lsls	r0, r0, #1
c0d03e72:	1837      	adds	r7, r6, r0
c0d03e74:	89fd      	ldrh	r5, [r7, #14]
c0d03e76:	2d00      	cmp	r5, #0
c0d03e78:	d03d      	beq.n	c0d03ef6 <ux_layout_paging_prepro+0xe2>
        SPRINTF(G_ux.string_buffer, "%.*s", G_ux.layout_paging.lengths[lineidx], STRPIC(params->text) + G_ux.layout_paging.offsets[lineidx]);
c0d03e7a:	6860      	ldr	r0, [r4, #4]
c0d03e7c:	f7fd fd08 	bl	c0d01890 <pic>
c0d03e80:	89b9      	ldrh	r1, [r7, #12]
c0d03e82:	1840      	adds	r0, r0, r1
c0d03e84:	4669      	mov	r1, sp
c0d03e86:	6008      	str	r0, [r1, #0]
c0d03e88:	4634      	mov	r4, r6
c0d03e8a:	341c      	adds	r4, #28
c0d03e8c:	2180      	movs	r1, #128	; 0x80
c0d03e8e:	4a20      	ldr	r2, [pc, #128]	; (c0d03f10 <ux_layout_paging_prepro+0xfc>)
c0d03e90:	447a      	add	r2, pc
c0d03e92:	4620      	mov	r0, r4
c0d03e94:	462b      	mov	r3, r5
c0d03e96:	f7fd fb3b 	bl	c0d01510 <snprintf>
c0d03e9a:	20b8      	movs	r0, #184	; 0xb8
        G_ux.tmp_element.text = G_ux.string_buffer;
c0d03e9c:	5034      	str	r4, [r6, r0]
c0d03e9e:	e02a      	b.n	c0d03ef6 <ux_layout_paging_prepro+0xe2>
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  switch (element->component.userid) {
  	case 0x01:
      // no step before AND no pages before
  		if (ux_flow_is_first() && G_ux.layout_paging.current == 0) {
c0d03ea0:	f7ff fc90 	bl	c0d037c4 <ux_flow_is_first>
c0d03ea4:	4601      	mov	r1, r0
c0d03ea6:	2000      	movs	r0, #0
c0d03ea8:	2900      	cmp	r1, #0
c0d03eaa:	d024      	beq.n	c0d03ef6 <ux_layout_paging_prepro+0xe2>
c0d03eac:	6871      	ldr	r1, [r6, #4]
c0d03eae:	2900      	cmp	r1, #0
c0d03eb0:	d023      	beq.n	c0d03efa <ux_layout_paging_prepro+0xe6>
c0d03eb2:	e020      	b.n	c0d03ef6 <ux_layout_paging_prepro+0xe2>
  			return NULL;
  		}
  		break;

  	case 0x02:
  		if (ux_flow_is_last() && G_ux.layout_paging.current == G_ux.layout_paging.count -1 ) {
c0d03eb4:	f7ff fcae 	bl	c0d03814 <ux_flow_is_last>
c0d03eb8:	2800      	cmp	r0, #0
c0d03eba:	d01c      	beq.n	c0d03ef6 <ux_layout_paging_prepro+0xe2>
c0d03ebc:	6871      	ldr	r1, [r6, #4]
c0d03ebe:	68b0      	ldr	r0, [r6, #8]
c0d03ec0:	1e42      	subs	r2, r0, #1
c0d03ec2:	2000      	movs	r0, #0
c0d03ec4:	4291      	cmp	r1, r2
c0d03ec6:	d116      	bne.n	c0d03ef6 <ux_layout_paging_prepro+0xe2>
c0d03ec8:	e017      	b.n	c0d03efa <ux_layout_paging_prepro+0xe6>
      // display 
    	if (params->title) {
        SPRINTF(G_ux.string_buffer, (G_ux.layout_paging.count>1)?"%s (%d/%d)":"%s", STRPIC(params->title), G_ux.layout_paging.current+1, G_ux.layout_paging.count);
    	}
      else {
        SPRINTF(G_ux.string_buffer, "%d/%d", G_ux.layout_paging.current+1, G_ux.layout_paging.count);
c0d03eca:	6871      	ldr	r1, [r6, #4]
c0d03ecc:	68b0      	ldr	r0, [r6, #8]
c0d03ece:	466a      	mov	r2, sp
c0d03ed0:	6010      	str	r0, [r2, #0]
c0d03ed2:	4630      	mov	r0, r6
c0d03ed4:	301c      	adds	r0, #28
c0d03ed6:	1c4b      	adds	r3, r1, #1
c0d03ed8:	2180      	movs	r1, #128	; 0x80
c0d03eda:	4a0c      	ldr	r2, [pc, #48]	; (c0d03f0c <ux_layout_paging_prepro+0xf8>)
c0d03edc:	447a      	add	r2, pc
c0d03ede:	e004      	b.n	c0d03eea <ux_layout_paging_prepro+0xd6>
c0d03ee0:	4a08      	ldr	r2, [pc, #32]	; (c0d03f04 <ux_layout_paging_prepro+0xf0>)
c0d03ee2:	447a      	add	r2, pc
  		break;

    case 0x10:
      // display 
    	if (params->title) {
        SPRINTF(G_ux.string_buffer, (G_ux.layout_paging.count>1)?"%s (%d/%d)":"%s", STRPIC(params->title), G_ux.layout_paging.current+1, G_ux.layout_paging.count);
c0d03ee4:	4630      	mov	r0, r6
c0d03ee6:	301c      	adds	r0, #28
c0d03ee8:	2180      	movs	r1, #128	; 0x80
c0d03eea:	f7fd fb11 	bl	c0d01510 <snprintf>
    	}
      else {
        SPRINTF(G_ux.string_buffer, "%d/%d", G_ux.layout_paging.current+1, G_ux.layout_paging.count);
      }
      G_ux.tmp_element.text = G_ux.string_buffer;
c0d03eee:	4630      	mov	r0, r6
c0d03ef0:	301c      	adds	r0, #28
c0d03ef2:	21b8      	movs	r1, #184	; 0xb8
c0d03ef4:	5070      	str	r0, [r6, r1]
c0d03ef6:	369c      	adds	r6, #156	; 0x9c
c0d03ef8:	4630      	mov	r0, r6
      }
      break;
    }
  }
  return &G_ux.tmp_element;
}
c0d03efa:	b003      	add	sp, #12
c0d03efc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03efe:	46c0      	nop			; (mov r8, r8)
c0d03f00:	2000186c 	.word	0x2000186c
c0d03f04:	00001196 	.word	0x00001196
c0d03f08:	00001225 	.word	0x00001225
c0d03f0c:	000011aa 	.word	0x000011aa
c0d03f10:	000011fc 	.word	0x000011fc

c0d03f14 <ux_layout_paging_button_callback>:
    G_ux.layout_paging.current--;
    ux_layout_paging_redisplay(G_ux.stack_count-1);
  }
}

static unsigned int ux_layout_paging_button_callback(unsigned int button_mask, unsigned int button_mask_counter) {
c0d03f14:	b580      	push	{r7, lr}
c0d03f16:	4917      	ldr	r1, [pc, #92]	; (c0d03f74 <ux_layout_paging_button_callback+0x60>)
  UNUSED(button_mask_counter);
  switch(button_mask) {
c0d03f18:	4288      	cmp	r0, r1
c0d03f1a:	d00b      	beq.n	c0d03f34 <ux_layout_paging_button_callback+0x20>
c0d03f1c:	4916      	ldr	r1, [pc, #88]	; (c0d03f78 <ux_layout_paging_button_callback+0x64>)
c0d03f1e:	4288      	cmp	r0, r1
c0d03f20:	d013      	beq.n	c0d03f4a <ux_layout_paging_button_callback+0x36>
c0d03f22:	4916      	ldr	r1, [pc, #88]	; (c0d03f7c <ux_layout_paging_button_callback+0x68>)
c0d03f24:	4288      	cmp	r0, r1
c0d03f26:	d122      	bne.n	c0d03f6e <ux_layout_paging_button_callback+0x5a>
    ux_layout_paging_redisplay(G_ux.stack_count-1);
  }
}

static void ux_layout_paging_prev(void) {
  if (G_ux.layout_paging.current == 0) {
c0d03f28:	4815      	ldr	r0, [pc, #84]	; (c0d03f80 <ux_layout_paging_button_callback+0x6c>)
c0d03f2a:	6841      	ldr	r1, [r0, #4]
c0d03f2c:	2900      	cmp	r1, #0
c0d03f2e:	d01c      	beq.n	c0d03f6a <ux_layout_paging_button_callback+0x56>
    ux_flow_prev();
  }
  else {
    // display previous page, count the number of char to fit in the previous page
    G_ux.layout_paging.current--;
c0d03f30:	1e49      	subs	r1, r1, #1
c0d03f32:	e014      	b.n	c0d03f5e <ux_layout_paging_button_callback+0x4a>
      break;
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      ux_layout_paging_next();
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      if (G_ux.layout_paging.count == 0 
c0d03f34:	4912      	ldr	r1, [pc, #72]	; (c0d03f80 <ux_layout_paging_button_callback+0x6c>)
c0d03f36:	6888      	ldr	r0, [r1, #8]
        || G_ux.layout_paging.count-1 == G_ux.layout_paging.current) {
c0d03f38:	2800      	cmp	r0, #0
c0d03f3a:	d003      	beq.n	c0d03f44 <ux_layout_paging_button_callback+0x30>
c0d03f3c:	6849      	ldr	r1, [r1, #4]
c0d03f3e:	1e40      	subs	r0, r0, #1
      break;
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      ux_layout_paging_next();
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      if (G_ux.layout_paging.count == 0 
c0d03f40:	4288      	cmp	r0, r1
c0d03f42:	d114      	bne.n	c0d03f6e <ux_layout_paging_button_callback+0x5a>
        || G_ux.layout_paging.count-1 == G_ux.layout_paging.current) {
        ux_flow_validate();
c0d03f44:	f7ff fd40 	bl	c0d039c8 <ux_flow_validate>
c0d03f48:	e011      	b.n	c0d03f6e <ux_layout_paging_button_callback+0x5a>
  G_ux.stack[stack_slot].button_push_callback = ux_layout_paging_button_callback;
  ux_stack_display(stack_slot);
}

static void ux_layout_paging_next(void) {
  if (G_ux.layout_paging.current == G_ux.layout_paging.count-1) {
c0d03f4a:	480d      	ldr	r0, [pc, #52]	; (c0d03f80 <ux_layout_paging_button_callback+0x6c>)
c0d03f4c:	6841      	ldr	r1, [r0, #4]
c0d03f4e:	6882      	ldr	r2, [r0, #8]
c0d03f50:	1e52      	subs	r2, r2, #1
c0d03f52:	4291      	cmp	r1, r2
c0d03f54:	d102      	bne.n	c0d03f5c <ux_layout_paging_button_callback+0x48>
    ux_flow_next();
c0d03f56:	f7ff fcc3 	bl	c0d038e0 <ux_flow_next>
c0d03f5a:	e008      	b.n	c0d03f6e <ux_layout_paging_button_callback+0x5a>
  }
  else {
    // display next page, count the number of char to fit in the next page
    G_ux.layout_paging.current++;
c0d03f5c:	1c49      	adds	r1, r1, #1
c0d03f5e:	6041      	str	r1, [r0, #4]
c0d03f60:	7800      	ldrb	r0, [r0, #0]
c0d03f62:	1e40      	subs	r0, r0, #1
c0d03f64:	f7ff ff38 	bl	c0d03dd8 <ux_layout_paging_redisplay>
c0d03f68:	e001      	b.n	c0d03f6e <ux_layout_paging_button_callback+0x5a>
  }
}

static void ux_layout_paging_prev(void) {
  if (G_ux.layout_paging.current == 0) {
    ux_flow_prev();
c0d03f6a:	f7ff fcbf 	bl	c0d038ec <ux_flow_prev>
c0d03f6e:	2000      	movs	r0, #0
        || G_ux.layout_paging.count-1 == G_ux.layout_paging.current) {
        ux_flow_validate();
      }
      break;
  }
  return 0;
c0d03f70:	bd80      	pop	{r7, pc}
c0d03f72:	46c0      	nop			; (mov r8, r8)
c0d03f74:	80000003 	.word	0x80000003
c0d03f78:	80000002 	.word	0x80000002
c0d03f7c:	80000001 	.word	0x80000001
c0d03f80:	2000186c 	.word	0x2000186c

c0d03f84 <ux_layout_paging_init>:
}

unsigned short bagl_compute_line_width(unsigned short font_id, unsigned short width, const void * text, unsigned char text_length, unsigned char text_encoding);

void ux_layout_paging_init(unsigned int stack_slot) {
c0d03f84:	b570      	push	{r4, r5, r6, lr}
c0d03f86:	4604      	mov	r4, r0

  // depending flow browsing direction, select the correct page to display
  switch(ux_flow_direction()) {
c0d03f88:	f7ff fc64 	bl	c0d03854 <ux_flow_direction>
c0d03f8c:	2801      	cmp	r0, #1
c0d03f8e:	d00b      	beq.n	c0d03fa8 <ux_layout_paging_init+0x24>
c0d03f90:	1c40      	adds	r0, r0, #1
c0d03f92:	d10f      	bne.n	c0d03fb4 <ux_layout_paging_init+0x30>
  ux_layout_paging_redisplay(stack_slot);
}

// function callable externally which reset the paging (to be called before init when willing to redisplay the first page)
void ux_layout_paging_reset(void) {
  os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d03f94:	4e1c      	ldr	r6, [pc, #112]	; (c0d04008 <ux_layout_paging_init+0x84>)
c0d03f96:	1d30      	adds	r0, r6, #4
c0d03f98:	2500      	movs	r5, #0
c0d03f9a:	220c      	movs	r2, #12
c0d03f9c:	4629      	mov	r1, r5
c0d03f9e:	f7fc fd9f 	bl	c0d00ae0 <os_memset>
c0d03fa2:	43e8      	mvns	r0, r5
  // depending flow browsing direction, select the correct page to display
  switch(ux_flow_direction()) {
    case FLOW_DIRECTION_BACKWARD:
      // ask the paging to start at the last page
      ux_layout_paging_reset();
      G_ux.layout_paging.current = -1UL;
c0d03fa4:	6070      	str	r0, [r6, #4]
c0d03fa6:	e005      	b.n	c0d03fb4 <ux_layout_paging_init+0x30>
  ux_layout_paging_redisplay(stack_slot);
}

// function callable externally which reset the paging (to be called before init when willing to redisplay the first page)
void ux_layout_paging_reset(void) {
  os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d03fa8:	4817      	ldr	r0, [pc, #92]	; (c0d04008 <ux_layout_paging_init+0x84>)
c0d03faa:	1d00      	adds	r0, r0, #4
c0d03fac:	2100      	movs	r1, #0
c0d03fae:	220c      	movs	r2, #12
c0d03fb0:	f7fc fd96 	bl	c0d00ae0 <os_memset>
    case FLOW_DIRECTION_START:
      break;
  }

  // store params
  ux_stack_init(stack_slot);
c0d03fb4:	4620      	mov	r0, r4
c0d03fb6:	f000 f9dd 	bl	c0d04374 <ux_stack_init>
  const ux_layout_paging_params_t* params = (const ux_layout_paging_params_t*)ux_stack_get_step_params(stack_slot);
c0d03fba:	4620      	mov	r0, r4
c0d03fbc:	f7ff fdc2 	bl	c0d03b44 <ux_stack_get_step_params>

  // compute number of chars to display from the params complete string 
  if (params->text == NULL /*|| strlen(STRPIC(params->text)) == 0*/) {
c0d03fc0:	6840      	ldr	r0, [r0, #4]
c0d03fc2:	2800      	cmp	r0, #0
c0d03fc4:	d019      	beq.n	c0d03ffa <ux_layout_paging_init+0x76>
c0d03fc6:	2000      	movs	r0, #0
c0d03fc8:	43c1      	mvns	r1, r0
    ux_layout_paging_reset();
    return;
  }

  // count total number of pages
  G_ux.layout_paging.count = ux_layout_paging_compute(stack_slot, -1UL); // at least one page
c0d03fca:	4620      	mov	r0, r4
c0d03fcc:	f7ff fe70 	bl	c0d03cb0 <ux_layout_paging_compute>
c0d03fd0:	4d0d      	ldr	r5, [pc, #52]	; (c0d04008 <ux_layout_paging_init+0x84>)
c0d03fd2:	60a8      	str	r0, [r5, #8]

  if (G_ux.layout_paging.count == 0) {
c0d03fd4:	2800      	cmp	r0, #0
c0d03fd6:	d107      	bne.n	c0d03fe8 <ux_layout_paging_init+0x64>
  ux_layout_paging_redisplay(stack_slot);
}

// function callable externally which reset the paging (to be called before init when willing to redisplay the first page)
void ux_layout_paging_reset(void) {
  os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d03fd8:	1d28      	adds	r0, r5, #4
c0d03fda:	2100      	movs	r1, #0
c0d03fdc:	220c      	movs	r2, #12
c0d03fde:	f7fc fd7f 	bl	c0d00ae0 <os_memset>
  // if (start != end) {
  //   ux_layout_paging_reset();
  // }

  // perform displaying the last page as requested (-1UL in prevstep hook does this)
  if (G_ux.layout_paging.count && G_ux.layout_paging.current > G_ux.layout_paging.count-1UL) {
c0d03fe2:	68a8      	ldr	r0, [r5, #8]
c0d03fe4:	2800      	cmp	r0, #0
c0d03fe6:	d004      	beq.n	c0d03ff2 <ux_layout_paging_init+0x6e>
c0d03fe8:	1e40      	subs	r0, r0, #1
c0d03fea:	6869      	ldr	r1, [r5, #4]
c0d03fec:	4281      	cmp	r1, r0
c0d03fee:	d900      	bls.n	c0d03ff2 <ux_layout_paging_init+0x6e>
    G_ux.layout_paging.current = G_ux.layout_paging.count-1;
c0d03ff0:	6068      	str	r0, [r5, #4]
  }

  ux_layout_paging_redisplay(stack_slot);
c0d03ff2:	4620      	mov	r0, r4
c0d03ff4:	f7ff fef0 	bl	c0d03dd8 <ux_layout_paging_redisplay>
}
c0d03ff8:	bd70      	pop	{r4, r5, r6, pc}

// function callable externally which reset the paging (to be called before init when willing to redisplay the first page)
void ux_layout_paging_reset(void) {
  os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d03ffa:	4803      	ldr	r0, [pc, #12]	; (c0d04008 <ux_layout_paging_init+0x84>)
c0d03ffc:	1d00      	adds	r0, r0, #4
c0d03ffe:	2100      	movs	r1, #0
c0d04000:	220c      	movs	r2, #12
c0d04002:	f7fc fd6d 	bl	c0d00ae0 <os_memset>
  if (G_ux.layout_paging.count && G_ux.layout_paging.current > G_ux.layout_paging.count-1UL) {
    G_ux.layout_paging.current = G_ux.layout_paging.count-1;
  }

  ux_layout_paging_redisplay(stack_slot);
}
c0d04006:	bd70      	pop	{r4, r5, r6, pc}
c0d04008:	2000186c 	.word	0x2000186c

c0d0400c <ux_layout_pb_prepro>:
  {{BAGL_ICON                           , 0x10,  56,  2,  16,  16, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_REGULAR_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
  {{BAGL_LABELINE                       , 0x11,   0, 28, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
#endif // TARGET_NANOX
};

const bagl_element_t* ux_layout_pb_prepro(const bagl_element_t* element) {
c0d0400c:	b570      	push	{r4, r5, r6, lr}
c0d0400e:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_pb_params_t* params = (const ux_layout_pb_params_t*)ux_stack_get_current_step_params();
c0d04010:	f7ff fdb0 	bl	c0d03b74 <ux_stack_get_current_step_params>
c0d04014:	4604      	mov	r4, r0

	// copy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d04016:	4e12      	ldr	r6, [pc, #72]	; (c0d04060 <ux_layout_pb_prepro+0x54>)
c0d04018:	4630      	mov	r0, r6
c0d0401a:	309c      	adds	r0, #156	; 0x9c
c0d0401c:	2220      	movs	r2, #32
c0d0401e:	4629      	mov	r1, r5
c0d04020:	f7fc fd48 	bl	c0d00ab4 <os_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d04024:	7868      	ldrb	r0, [r5, #1]
c0d04026:	280f      	cmp	r0, #15
c0d04028:	dc06      	bgt.n	c0d04038 <ux_layout_pb_prepro+0x2c>
c0d0402a:	2801      	cmp	r0, #1
c0d0402c:	d00a      	beq.n	c0d04044 <ux_layout_pb_prepro+0x38>
c0d0402e:	2802      	cmp	r0, #2
c0d04030:	d112      	bne.n	c0d04058 <ux_layout_pb_prepro+0x4c>
  			return NULL;
  		}
  		break;

  	case 0x02:
  		if (ux_flow_is_last()) {
c0d04032:	f7ff fbef 	bl	c0d03814 <ux_flow_is_last>
c0d04036:	e007      	b.n	c0d04048 <ux_layout_pb_prepro+0x3c>

	// copy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d04038:	2810      	cmp	r0, #16
c0d0403a:	d00a      	beq.n	c0d04052 <ux_layout_pb_prepro+0x46>
c0d0403c:	2811      	cmp	r0, #17
c0d0403e:	d10b      	bne.n	c0d04058 <ux_layout_pb_prepro+0x4c>
    case 0x10:
  		G_ux.tmp_element.text = (const char*)params->icon;
      break;

    case 0x11:
  		G_ux.tmp_element.text = params->line1;
c0d04040:	6860      	ldr	r0, [r4, #4]
c0d04042:	e007      	b.n	c0d04054 <ux_layout_pb_prepro+0x48>
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
  	case 0x01:
  		if (ux_flow_is_first()) {
c0d04044:	f7ff fbbe 	bl	c0d037c4 <ux_flow_is_first>
c0d04048:	4601      	mov	r1, r0
c0d0404a:	2000      	movs	r0, #0
c0d0404c:	2900      	cmp	r1, #0
c0d0404e:	d003      	beq.n	c0d04058 <ux_layout_pb_prepro+0x4c>
    case 0x11:
  		G_ux.tmp_element.text = params->line1;
      break;
  }
  return &G_ux.tmp_element;
}
c0d04050:	bd70      	pop	{r4, r5, r6, pc}
  			return NULL;
  		}
  		break;

    case 0x10:
  		G_ux.tmp_element.text = (const char*)params->icon;
c0d04052:	6820      	ldr	r0, [r4, #0]
c0d04054:	21b8      	movs	r1, #184	; 0xb8
c0d04056:	5070      	str	r0, [r6, r1]
c0d04058:	369c      	adds	r6, #156	; 0x9c
c0d0405a:	4630      	mov	r0, r6
    case 0x11:
  		G_ux.tmp_element.text = params->line1;
      break;
  }
  return &G_ux.tmp_element;
}
c0d0405c:	bd70      	pop	{r4, r5, r6, pc}
c0d0405e:	46c0      	nop			; (mov r8, r8)
c0d04060:	2000186c 	.word	0x2000186c

c0d04064 <ux_layout_pb_init>:

void ux_layout_pb_init(unsigned int stack_slot) {
c0d04064:	b510      	push	{r4, lr}
c0d04066:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d04068:	f000 f984 	bl	c0d04374 <ux_stack_init>
c0d0406c:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pb_elements;
c0d0406e:	4360      	muls	r0, r4
c0d04070:	490b      	ldr	r1, [pc, #44]	; (c0d040a0 <ux_layout_pb_init+0x3c>)
c0d04072:	1808      	adds	r0, r1, r0
c0d04074:	21c4      	movs	r1, #196	; 0xc4
c0d04076:	2205      	movs	r2, #5
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pb_elements);
c0d04078:	5442      	strb	r2, [r0, r1]
c0d0407a:	21c0      	movs	r1, #192	; 0xc0
  return &G_ux.tmp_element;
}

void ux_layout_pb_init(unsigned int stack_slot) {
  ux_stack_init(stack_slot);
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pb_elements;
c0d0407c:	4a09      	ldr	r2, [pc, #36]	; (c0d040a4 <ux_layout_pb_init+0x40>)
c0d0407e:	447a      	add	r2, pc
c0d04080:	5042      	str	r2, [r0, r1]
c0d04082:	21bd      	movs	r1, #189	; 0xbd
c0d04084:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pb_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d04086:	5442      	strb	r2, [r0, r1]
c0d04088:	21cc      	movs	r1, #204	; 0xcc
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_pb_prepro;
c0d0408a:	4a07      	ldr	r2, [pc, #28]	; (c0d040a8 <ux_layout_pb_init+0x44>)
c0d0408c:	447a      	add	r2, pc
c0d0408e:	5042      	str	r2, [r0, r1]
c0d04090:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d04092:	4a06      	ldr	r2, [pc, #24]	; (c0d040ac <ux_layout_pb_init+0x48>)
c0d04094:	447a      	add	r2, pc
c0d04096:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d04098:	4620      	mov	r0, r4
c0d0409a:	f000 f945 	bl	c0d04328 <ux_stack_display>
}
c0d0409e:	bd10      	pop	{r4, pc}
c0d040a0:	2000186c 	.word	0x2000186c
c0d040a4:	00001016 	.word	0x00001016
c0d040a8:	ffffff7d 	.word	0xffffff7d
c0d040ac:	fffffa75 	.word	0xfffffa75

c0d040b0 <ux_layout_pbb_prepro>:
  {{BAGL_LABELINE                       , 0x10,  41,  12, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px, 0  }, NULL},
  {{BAGL_LABELINE                       , 0x11,  41,  26, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px, 0  }, NULL},
#endif // TARGET_NANOX
};

const bagl_element_t* ux_layout_pbb_prepro(const bagl_element_t* element) {
c0d040b0:	b570      	push	{r4, r5, r6, lr}
c0d040b2:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_icon_strings_params_t* params = (const ux_layout_icon_strings_params_t*)ux_stack_get_current_step_params();
c0d040b4:	f7ff fd5e 	bl	c0d03b74 <ux_stack_get_current_step_params>
c0d040b8:	4604      	mov	r4, r0

	// ocpy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d040ba:	4e16      	ldr	r6, [pc, #88]	; (c0d04114 <ux_layout_pbb_prepro+0x64>)
c0d040bc:	4630      	mov	r0, r6
c0d040be:	309c      	adds	r0, #156	; 0x9c
c0d040c0:	2220      	movs	r2, #32
c0d040c2:	4629      	mov	r1, r5
c0d040c4:	f7fc fcf6 	bl	c0d00ab4 <os_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d040c8:	7868      	ldrb	r0, [r5, #1]
c0d040ca:	280f      	cmp	r0, #15
c0d040cc:	dc07      	bgt.n	c0d040de <ux_layout_pbb_prepro+0x2e>
c0d040ce:	2801      	cmp	r0, #1
c0d040d0:	d012      	beq.n	c0d040f8 <ux_layout_pbb_prepro+0x48>
c0d040d2:	2802      	cmp	r0, #2
c0d040d4:	d013      	beq.n	c0d040fe <ux_layout_pbb_prepro+0x4e>
c0d040d6:	280f      	cmp	r0, #15
c0d040d8:	d118      	bne.n	c0d0410c <ux_layout_pbb_prepro+0x5c>
  			return NULL;
  		}
  		break;

    case 0x0F:
  		G_ux.tmp_element.text = (const char*)params->icon;
c0d040da:	6820      	ldr	r0, [r4, #0]
c0d040dc:	e009      	b.n	c0d040f2 <ux_layout_pbb_prepro+0x42>

	// ocpy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d040de:	3810      	subs	r0, #16
c0d040e0:	2802      	cmp	r0, #2
c0d040e2:	d213      	bcs.n	c0d0410c <ux_layout_pbb_prepro+0x5c>
c0d040e4:	209d      	movs	r0, #157	; 0x9d
  		G_ux.tmp_element.text = (const char*)params->icon;
      break;

    case 0x10:
    case 0x11:
      G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
c0d040e6:	5c30      	ldrb	r0, [r6, r0]
c0d040e8:	210f      	movs	r1, #15
c0d040ea:	4001      	ands	r1, r0
c0d040ec:	0088      	lsls	r0, r1, #2
c0d040ee:	1820      	adds	r0, r4, r0
c0d040f0:	6840      	ldr	r0, [r0, #4]
c0d040f2:	21b8      	movs	r1, #184	; 0xb8
c0d040f4:	5070      	str	r0, [r6, r1]
c0d040f6:	e009      	b.n	c0d0410c <ux_layout_pbb_prepro+0x5c>
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
  	case 0x01:
  		if (ux_flow_is_first()) {
c0d040f8:	f7ff fb64 	bl	c0d037c4 <ux_flow_is_first>
c0d040fc:	e001      	b.n	c0d04102 <ux_layout_pbb_prepro+0x52>
  			return NULL;
  		}
  		break;

  	case 0x02:
  		if (ux_flow_is_last()) {
c0d040fe:	f7ff fb89 	bl	c0d03814 <ux_flow_is_last>
c0d04102:	4601      	mov	r1, r0
c0d04104:	2000      	movs	r0, #0
c0d04106:	2900      	cmp	r1, #0
c0d04108:	d000      	beq.n	c0d0410c <ux_layout_pbb_prepro+0x5c>
      G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
      break;

  }
  return &G_ux.tmp_element;
}
c0d0410a:	bd70      	pop	{r4, r5, r6, pc}
c0d0410c:	369c      	adds	r6, #156	; 0x9c
c0d0410e:	4630      	mov	r0, r6
c0d04110:	bd70      	pop	{r4, r5, r6, pc}
c0d04112:	46c0      	nop			; (mov r8, r8)
c0d04114:	2000186c 	.word	0x2000186c

c0d04118 <ux_layout_pbb_init_common>:


void ux_layout_pbb_init_common(unsigned int stack_slot) {
c0d04118:	b510      	push	{r4, lr}
c0d0411a:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d0411c:	f000 f92a 	bl	c0d04374 <ux_stack_init>
c0d04120:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pbb_elements;
c0d04122:	4360      	muls	r0, r4
c0d04124:	4908      	ldr	r1, [pc, #32]	; (c0d04148 <ux_layout_pbb_init_common+0x30>)
c0d04126:	1808      	adds	r0, r1, r0
c0d04128:	21c4      	movs	r1, #196	; 0xc4
c0d0412a:	2206      	movs	r2, #6
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pbb_elements);
c0d0412c:	5442      	strb	r2, [r0, r1]
c0d0412e:	21c0      	movs	r1, #192	; 0xc0
}


void ux_layout_pbb_init_common(unsigned int stack_slot) {
  ux_stack_init(stack_slot);
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pbb_elements;
c0d04130:	4a06      	ldr	r2, [pc, #24]	; (c0d0414c <ux_layout_pbb_init_common+0x34>)
c0d04132:	447a      	add	r2, pc
c0d04134:	5042      	str	r2, [r0, r1]
c0d04136:	21bd      	movs	r1, #189	; 0xbd
c0d04138:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pbb_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d0413a:	5442      	strb	r2, [r0, r1]
c0d0413c:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d0413e:	4a04      	ldr	r2, [pc, #16]	; (c0d04150 <ux_layout_pbb_init_common+0x38>)
c0d04140:	447a      	add	r2, pc
c0d04142:	5042      	str	r2, [r0, r1]
}
c0d04144:	bd10      	pop	{r4, pc}
c0d04146:	46c0      	nop			; (mov r8, r8)
c0d04148:	2000186c 	.word	0x2000186c
c0d0414c:	00001002 	.word	0x00001002
c0d04150:	fffff9c9 	.word	0xfffff9c9

c0d04154 <ux_layout_pnn_prepro>:
#endif // TARGET_NANOX

};
*/

const bagl_element_t* ux_layout_pnn_prepro(const bagl_element_t* element) {
c0d04154:	b580      	push	{r7, lr}
      G_ux.tmp_element.text = params->line2;
      break;
  }
  return &G_ux.tmp_element;
  */
  const bagl_element_t* e = ux_layout_pbb_prepro(element);
c0d04156:	f7ff ffab 	bl	c0d040b0 <ux_layout_pbb_prepro>
c0d0415a:	229d      	movs	r2, #157	; 0x9d
  if (e && G_ux.tmp_element.component.userid >= 0x10) {
c0d0415c:	2800      	cmp	r0, #0
c0d0415e:	d006      	beq.n	c0d0416e <ux_layout_pnn_prepro+0x1a>
c0d04160:	4903      	ldr	r1, [pc, #12]	; (c0d04170 <ux_layout_pnn_prepro+0x1c>)
c0d04162:	5c8a      	ldrb	r2, [r1, r2]
c0d04164:	2a10      	cmp	r2, #16
c0d04166:	d302      	bcc.n	c0d0416e <ux_layout_pnn_prepro+0x1a>
c0d04168:	22b4      	movs	r2, #180	; 0xb4
c0d0416a:	230a      	movs	r3, #10
    G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_REGULAR_11px;
c0d0416c:	528b      	strh	r3, [r1, r2]
  }
  return e;
c0d0416e:	bd80      	pop	{r7, pc}
c0d04170:	2000186c 	.word	0x2000186c

c0d04174 <ux_layout_pnn_init>:
}

void ux_layout_pnn_init(unsigned int stack_slot) { 
c0d04174:	b510      	push	{r4, lr}
c0d04176:	4604      	mov	r4, r0
  ux_layout_pbb_init_common(stack_slot);
c0d04178:	f7ff ffce 	bl	c0d04118 <ux_layout_pbb_init_common>
c0d0417c:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_pnn_prepro;
c0d0417e:	4360      	muls	r0, r4
c0d04180:	4904      	ldr	r1, [pc, #16]	; (c0d04194 <ux_layout_pnn_init+0x20>)
c0d04182:	1808      	adds	r0, r1, r0
c0d04184:	21cc      	movs	r1, #204	; 0xcc
c0d04186:	4a04      	ldr	r2, [pc, #16]	; (c0d04198 <ux_layout_pnn_init+0x24>)
c0d04188:	447a      	add	r2, pc
c0d0418a:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d0418c:	4620      	mov	r0, r4
c0d0418e:	f000 f8cb 	bl	c0d04328 <ux_stack_display>
}
c0d04192:	bd10      	pop	{r4, pc}
c0d04194:	2000186c 	.word	0x2000186c
c0d04198:	ffffffc9 	.word	0xffffffc9

c0d0419c <ux_layout_strings_prepro>:
    G_ux.stack[stack_slot].ticker_value = ms;
    G_ux.stack[stack_slot].ticker_interval = ms; // restart
  }
}

const bagl_element_t* ux_layout_strings_prepro(const bagl_element_t* element) {
c0d0419c:	b570      	push	{r4, r5, r6, lr}
c0d0419e:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_strings_params_t* params = (const ux_layout_strings_params_t*)ux_stack_get_current_step_params();
c0d041a0:	f7ff fce8 	bl	c0d03b74 <ux_stack_get_current_step_params>
c0d041a4:	4604      	mov	r4, r0
  // ocpy element before any mod
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d041a6:	4e12      	ldr	r6, [pc, #72]	; (c0d041f0 <ux_layout_strings_prepro+0x54>)
c0d041a8:	4630      	mov	r0, r6
c0d041aa:	309c      	adds	r0, #156	; 0x9c
c0d041ac:	2220      	movs	r2, #32
c0d041ae:	4629      	mov	r1, r5
c0d041b0:	f7fc fc80 	bl	c0d00ab4 <os_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d041b4:	7868      	ldrb	r0, [r5, #1]
c0d041b6:	2802      	cmp	r0, #2
c0d041b8:	d004      	beq.n	c0d041c4 <ux_layout_strings_prepro+0x28>
c0d041ba:	2801      	cmp	r0, #1
c0d041bc:	d109      	bne.n	c0d041d2 <ux_layout_strings_prepro+0x36>
    case 0x01:
      if (ux_flow_is_first()) {
c0d041be:	f7ff fb01 	bl	c0d037c4 <ux_flow_is_first>
c0d041c2:	e001      	b.n	c0d041c8 <ux_layout_strings_prepro+0x2c>
        return NULL;
      }
      break;

    case 0x02:
      if (ux_flow_is_last()) {
c0d041c4:	f7ff fb26 	bl	c0d03814 <ux_flow_is_last>
c0d041c8:	4601      	mov	r1, r0
c0d041ca:	2000      	movs	r0, #0
c0d041cc:	2900      	cmp	r1, #0
c0d041ce:	d00b      	beq.n	c0d041e8 <ux_layout_strings_prepro+0x4c>
        G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
      }
      break;
  }
  return &G_ux.tmp_element;
}
c0d041d0:	bd70      	pop	{r4, r5, r6, pc}
c0d041d2:	209d      	movs	r0, #157	; 0x9d
        return NULL;
      }
      break;

    default:
      if (G_ux.tmp_element.component.userid&0xF0) {
c0d041d4:	5c30      	ldrb	r0, [r6, r0]
c0d041d6:	0601      	lsls	r1, r0, #24
c0d041d8:	0f09      	lsrs	r1, r1, #28
c0d041da:	d005      	beq.n	c0d041e8 <ux_layout_strings_prepro+0x4c>
c0d041dc:	210f      	movs	r1, #15
        G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
c0d041de:	4008      	ands	r0, r1
c0d041e0:	0080      	lsls	r0, r0, #2
c0d041e2:	5820      	ldr	r0, [r4, r0]
c0d041e4:	21b8      	movs	r1, #184	; 0xb8
c0d041e6:	5070      	str	r0, [r6, r1]
c0d041e8:	369c      	adds	r6, #156	; 0x9c
c0d041ea:	4630      	mov	r0, r6
      }
      break;
  }
  return &G_ux.tmp_element;
}
c0d041ec:	bd70      	pop	{r4, r5, r6, pc}
c0d041ee:	46c0      	nop			; (mov r8, r8)
c0d041f0:	2000186c 	.word	0x2000186c

c0d041f4 <ux_menulist_button>:

#ifndef TARGET_BLUE

void ux_menulist_refresh(unsigned int stack_slot);

unsigned int ux_menulist_button(unsigned int button_mask, unsigned int button_mask_counter) {
c0d041f4:	b5b0      	push	{r4, r5, r7, lr}
c0d041f6:	4917      	ldr	r1, [pc, #92]	; (c0d04254 <ux_menulist_button+0x60>)
  UNUSED(button_mask_counter);

  switch(button_mask) {
c0d041f8:	4288      	cmp	r0, r1
c0d041fa:	d011      	beq.n	c0d04220 <ux_menulist_button+0x2c>
c0d041fc:	4916      	ldr	r1, [pc, #88]	; (c0d04258 <ux_menulist_button+0x64>)
c0d041fe:	4288      	cmp	r0, r1
c0d04200:	d015      	beq.n	c0d0422e <ux_menulist_button+0x3a>
c0d04202:	4916      	ldr	r1, [pc, #88]	; (c0d0425c <ux_menulist_button+0x68>)
c0d04204:	4288      	cmp	r0, r1
c0d04206:	d122      	bne.n	c0d0424e <ux_menulist_button+0x5a>
c0d04208:	20f8      	movs	r0, #248	; 0xf8
    case BUTTON_EVT_RELEASED|BUTTON_LEFT:
      if (G_ux.menulist_getter(G_ux.menulist_current-1UL)) {
c0d0420a:	4c15      	ldr	r4, [pc, #84]	; (c0d04260 <ux_menulist_button+0x6c>)
c0d0420c:	5821      	ldr	r1, [r4, r0]
c0d0420e:	25e0      	movs	r5, #224	; 0xe0
c0d04210:	5960      	ldr	r0, [r4, r5]
c0d04212:	1e40      	subs	r0, r0, #1
c0d04214:	4788      	blx	r1
c0d04216:	2800      	cmp	r0, #0
c0d04218:	d019      	beq.n	c0d0424e <ux_menulist_button+0x5a>
      	G_ux.menulist_current--;
c0d0421a:	5960      	ldr	r0, [r4, r5]
c0d0421c:	1e40      	subs	r0, r0, #1
c0d0421e:	e011      	b.n	c0d04244 <ux_menulist_button+0x50>
c0d04220:	20e0      	movs	r0, #224	; 0xe0
      	G_ux.menulist_current++;
      	ux_menulist_refresh(G_ux.stack_count-1);
      }
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      G_ux.menulist_selector(G_ux.menulist_current);
c0d04222:	490f      	ldr	r1, [pc, #60]	; (c0d04260 <ux_menulist_button+0x6c>)
c0d04224:	5808      	ldr	r0, [r1, r0]
c0d04226:	22fc      	movs	r2, #252	; 0xfc
c0d04228:	5889      	ldr	r1, [r1, r2]
c0d0422a:	4788      	blx	r1
c0d0422c:	e00f      	b.n	c0d0424e <ux_menulist_button+0x5a>
c0d0422e:	20f8      	movs	r0, #248	; 0xf8
      	G_ux.menulist_current--;
      	ux_menulist_refresh(G_ux.stack_count-1);
      }
      break;
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      if (G_ux.menulist_getter(G_ux.menulist_current+1UL)) {
c0d04230:	4c0b      	ldr	r4, [pc, #44]	; (c0d04260 <ux_menulist_button+0x6c>)
c0d04232:	5821      	ldr	r1, [r4, r0]
c0d04234:	25e0      	movs	r5, #224	; 0xe0
c0d04236:	5960      	ldr	r0, [r4, r5]
c0d04238:	1c40      	adds	r0, r0, #1
c0d0423a:	4788      	blx	r1
c0d0423c:	2800      	cmp	r0, #0
c0d0423e:	d006      	beq.n	c0d0424e <ux_menulist_button+0x5a>
      	G_ux.menulist_current++;
c0d04240:	5960      	ldr	r0, [r4, r5]
c0d04242:	1c40      	adds	r0, r0, #1
c0d04244:	5160      	str	r0, [r4, r5]
c0d04246:	7820      	ldrb	r0, [r4, #0]
c0d04248:	1e40      	subs	r0, r0, #1
c0d0424a:	f000 f80b 	bl	c0d04264 <ux_menulist_refresh>
c0d0424e:	2000      	movs	r0, #0
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      G_ux.menulist_selector(G_ux.menulist_current);
      break;
  }
  return 0;
c0d04250:	bdb0      	pop	{r4, r5, r7, pc}
c0d04252:	46c0      	nop			; (mov r8, r8)
c0d04254:	80000003 	.word	0x80000003
c0d04258:	80000002 	.word	0x80000002
c0d0425c:	80000001 	.word	0x80000001
c0d04260:	2000186c 	.word	0x2000186c

c0d04264 <ux_menulist_refresh>:
}

void ux_menulist_refresh(unsigned int stack_slot) {
c0d04264:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04266:	b081      	sub	sp, #4
c0d04268:	4604      	mov	r4, r0
c0d0426a:	2001      	movs	r0, #1
c0d0426c:	43c6      	mvns	r6, r0
c0d0426e:	4d0c      	ldr	r5, [pc, #48]	; (c0d042a0 <ux_menulist_refresh+0x3c>)
c0d04270:	462f      	mov	r7, r5
c0d04272:	37e4      	adds	r7, #228	; 0xe4
c0d04274:	20f8      	movs	r0, #248	; 0xf8
  // set values
  int i;
  for (i = 0; i < 5; i++) {
    G_ux.menulist_params.lines[i] = G_ux.menulist_getter(G_ux.menulist_current+i-2);
c0d04276:	5829      	ldr	r1, [r5, r0]
c0d04278:	20e0      	movs	r0, #224	; 0xe0
c0d0427a:	5828      	ldr	r0, [r5, r0]
c0d0427c:	1830      	adds	r0, r6, r0
c0d0427e:	4788      	blx	r1
c0d04280:	c701      	stmia	r7!, {r0}
}

void ux_menulist_refresh(unsigned int stack_slot) {
  // set values
  int i;
  for (i = 0; i < 5; i++) {
c0d04282:	1c76      	adds	r6, r6, #1
c0d04284:	2e03      	cmp	r6, #3
c0d04286:	d1f5      	bne.n	c0d04274 <ux_menulist_refresh+0x10>
    G_ux.menulist_params.lines[i] = G_ux.menulist_getter(G_ux.menulist_current+i-2);
  }
  // display
  ux_layout_nnbnn_init(stack_slot);
c0d04288:	4620      	mov	r0, r4
c0d0428a:	f7ff fceb 	bl	c0d03c64 <ux_layout_nnbnn_init>
c0d0428e:	2024      	movs	r0, #36	; 0x24
  // change callback to the menulist one
  G_ux.stack[stack_slot].button_push_callback = ux_menulist_button;
c0d04290:	4360      	muls	r0, r4
c0d04292:	1828      	adds	r0, r5, r0
c0d04294:	21d0      	movs	r1, #208	; 0xd0
c0d04296:	4a03      	ldr	r2, [pc, #12]	; (c0d042a4 <ux_menulist_refresh+0x40>)
c0d04298:	447a      	add	r2, pc
c0d0429a:	5042      	str	r2, [r0, r1]
}
c0d0429c:	b001      	add	sp, #4
c0d0429e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d042a0:	2000186c 	.word	0x2000186c
c0d042a4:	ffffff59 	.word	0xffffff59

c0d042a8 <ux_menulist_init_select>:
  );

void ux_menulist_init_select(unsigned int stack_slot, 
                      list_item_value_t getter, 
                      list_item_select_t selector, 
                      unsigned int selected_item_idx) {
c0d042a8:	b5b0      	push	{r4, r5, r7, lr}
c0d042aa:	4604      	mov	r4, r0
c0d042ac:	20f8      	movs	r0, #248	; 0xf8
  G_ux.menulist_current  = selected_item_idx;
c0d042ae:	4d0b      	ldr	r5, [pc, #44]	; (c0d042dc <ux_menulist_init_select+0x34>)
  G_ux.menulist_getter = getter;
c0d042b0:	5029      	str	r1, [r5, r0]
c0d042b2:	20e0      	movs	r0, #224	; 0xe0

void ux_menulist_init_select(unsigned int stack_slot, 
                      list_item_value_t getter, 
                      list_item_select_t selector, 
                      unsigned int selected_item_idx) {
  G_ux.menulist_current  = selected_item_idx;
c0d042b4:	502b      	str	r3, [r5, r0]
c0d042b6:	20fc      	movs	r0, #252	; 0xfc
  G_ux.menulist_getter = getter;
  G_ux.menulist_selector = selector;
c0d042b8:	502a      	str	r2, [r5, r0]

  // ensure the current flow step reference the G_ux.menulist_params to ensure strings displayed correctly.
  // if not, then use the forged step (and display it if top of ux stack)
  if (ux_stack_get_step_params(stack_slot) != (void*)&G_ux.menulist_params) {
c0d042ba:	4620      	mov	r0, r4
c0d042bc:	f7ff fc42 	bl	c0d03b44 <ux_stack_get_step_params>
c0d042c0:	35e4      	adds	r5, #228	; 0xe4
c0d042c2:	42a8      	cmp	r0, r5
c0d042c4:	d006      	beq.n	c0d042d4 <ux_menulist_init_select+0x2c>
    ux_flow_init(stack_slot, ux_menulist_constflow, NULL);
c0d042c6:	4906      	ldr	r1, [pc, #24]	; (c0d042e0 <ux_menulist_init_select+0x38>)
c0d042c8:	4479      	add	r1, pc
c0d042ca:	2200      	movs	r2, #0
c0d042cc:	4620      	mov	r0, r4
c0d042ce:	f7ff fbd3 	bl	c0d03a78 <ux_flow_init>
  }
  else {
    ux_menulist_refresh(stack_slot);
  }
}
c0d042d2:	bdb0      	pop	{r4, r5, r7, pc}
  // if not, then use the forged step (and display it if top of ux stack)
  if (ux_stack_get_step_params(stack_slot) != (void*)&G_ux.menulist_params) {
    ux_flow_init(stack_slot, ux_menulist_constflow, NULL);
  }
  else {
    ux_menulist_refresh(stack_slot);
c0d042d4:	4620      	mov	r0, r4
c0d042d6:	f7ff ffc5 	bl	c0d04264 <ux_menulist_refresh>
  }
}
c0d042da:	bdb0      	pop	{r4, r5, r7, pc}
c0d042dc:	2000186c 	.word	0x2000186c
c0d042e0:	00000f3c 	.word	0x00000f3c

c0d042e4 <ux_menulist_init>:

// based on a nnbnn layout
void ux_menulist_init(unsigned int stack_slot, 
                             list_item_value_t getter, 
                             list_item_select_t selector) {
c0d042e4:	b580      	push	{r7, lr}
c0d042e6:	2300      	movs	r3, #0
	ux_menulist_init_select(stack_slot, getter, selector, 0);
c0d042e8:	f7ff ffde 	bl	c0d042a8 <ux_menulist_init_select>
}
c0d042ec:	bd80      	pop	{r7, pc}
	...

c0d042f0 <ux_stack_push>:
    }
  }
  return 0;
}

unsigned int ux_stack_push(void) {
c0d042f0:	b5b0      	push	{r4, r5, r7, lr}
  // only push if an available slot exists
  if (G_ux.stack_count < ARRAYLEN(G_ux.stack)) {
c0d042f2:	4d0c      	ldr	r5, [pc, #48]	; (c0d04324 <ux_stack_push+0x34>)
c0d042f4:	7828      	ldrb	r0, [r5, #0]
c0d042f6:	2800      	cmp	r0, #0
c0d042f8:	d111      	bne.n	c0d0431e <ux_stack_push+0x2e>
    os_memset(&G_ux.stack[G_ux.stack_count], 0, sizeof(G_ux.stack[0]));
c0d042fa:	4628      	mov	r0, r5
c0d042fc:	30bc      	adds	r0, #188	; 0xbc
c0d042fe:	2400      	movs	r4, #0
c0d04300:	2224      	movs	r2, #36	; 0x24
c0d04302:	4621      	mov	r1, r4
c0d04304:	f7fc fbec 	bl	c0d00ae0 <os_memset>
#ifdef HAVE_UX_FLOW
    os_memset(&G_ux.flow_stack[G_ux.stack_count], 0, sizeof(G_ux.flow_stack[0]));
c0d04308:	7828      	ldrb	r0, [r5, #0]
c0d0430a:	220c      	movs	r2, #12
c0d0430c:	4350      	muls	r0, r2
c0d0430e:	1828      	adds	r0, r5, r0
c0d04310:	3010      	adds	r0, #16
c0d04312:	4621      	mov	r1, r4
c0d04314:	f7fc fbe4 	bl	c0d00ae0 <os_memset>
#endif // HAVE_UX_FLOW
    G_ux.stack_count++;
c0d04318:	7828      	ldrb	r0, [r5, #0]
c0d0431a:	1c40      	adds	r0, r0, #1
c0d0431c:	7028      	strb	r0, [r5, #0]
  }
  // return the stack top index
  return G_ux.stack_count-1;
c0d0431e:	b2c0      	uxtb	r0, r0
c0d04320:	1e40      	subs	r0, r0, #1
c0d04322:	bdb0      	pop	{r4, r5, r7, pc}
c0d04324:	2000186c 	.word	0x2000186c

c0d04328 <ux_stack_display>:
}
#endif // UX_STACK_SLOT_ARRAY_COUNT == 1
#endif // TARGET_NANOX

// common code for all screens
void ux_stack_display(unsigned int stack_slot) {
c0d04328:	b5b0      	push	{r4, r5, r7, lr}
c0d0432a:	4604      	mov	r4, r0
  // don't display any elements of a previous screen replacement
  if(G_ux.stack_count > 0 && stack_slot+1 == G_ux.stack_count) {
c0d0432c:	4810      	ldr	r0, [pc, #64]	; (c0d04370 <ux_stack_display+0x48>)
c0d0432e:	7801      	ldrb	r1, [r0, #0]
c0d04330:	2900      	cmp	r1, #0
c0d04332:	d00e      	beq.n	c0d04352 <ux_stack_display+0x2a>
c0d04334:	1c62      	adds	r2, r4, #1
c0d04336:	428a      	cmp	r2, r1
c0d04338:	d10b      	bne.n	c0d04352 <ux_stack_display+0x2a>
c0d0433a:	2124      	movs	r1, #36	; 0x24
    io_seproxyhal_init_ux();
    // at worse a redisplay of the current screen has been requested, ensure to redraw it correctly
    G_ux.stack[stack_slot].element_index = 0;
c0d0433c:	4361      	muls	r1, r4
c0d0433e:	1845      	adds	r5, r0, r1

// common code for all screens
void ux_stack_display(unsigned int stack_slot) {
  // don't display any elements of a previous screen replacement
  if(G_ux.stack_count > 0 && stack_slot+1 == G_ux.stack_count) {
    io_seproxyhal_init_ux();
c0d04340:	f7fc fd3a 	bl	c0d00db8 <io_seproxyhal_init_ux>
c0d04344:	20be      	movs	r0, #190	; 0xbe
c0d04346:	2100      	movs	r1, #0
    // at worse a redisplay of the current screen has been requested, ensure to redraw it correctly
    G_ux.stack[stack_slot].element_index = 0;
c0d04348:	5229      	strh	r1, [r5, r0]
#ifdef TARGET_NANOX
    ux_stack_display_elements(&G_ux.stack[stack_slot]); // on balenos, no need to wait for the display processed event
#else // TARGET_NANOX
    ux_stack_al_display_next_element(stack_slot);
c0d0434a:	4620      	mov	r0, r4
c0d0434c:	f000 f826 	bl	c0d0439c <ux_stack_al_display_next_element>
    if (G_ux.exit_code == BOLOS_UX_OK) {
      G_ux.exit_code = BOLOS_UX_REDRAW;
    }
  }
  // else don't draw (in stack insertion)
}
c0d04350:	bdb0      	pop	{r4, r5, r7, pc}
c0d04352:	2200      	movs	r2, #0
#endif // TARGET_NANOX

// common code for all screens
void ux_stack_display(unsigned int stack_slot) {
  // don't display any elements of a previous screen replacement
  if(G_ux.stack_count > 0 && stack_slot+1 == G_ux.stack_count) {
c0d04354:	1a53      	subs	r3, r2, r1
c0d04356:	414b      	adcs	r3, r1
#else // TARGET_NANOX
    ux_stack_al_display_next_element(stack_slot);
#endif // TARGET_NANOX
  }
  // asking to redraw below top screen (likely the app below the ux)
  else if (stack_slot == -1UL || G_ux.stack_count == 0) {
c0d04358:	1c61      	adds	r1, r4, #1
c0d0435a:	1a52      	subs	r2, r2, r1
c0d0435c:	414a      	adcs	r2, r1
c0d0435e:	431a      	orrs	r2, r3
c0d04360:	2a01      	cmp	r2, #1
c0d04362:	d104      	bne.n	c0d0436e <ux_stack_display+0x46>
c0d04364:	7841      	ldrb	r1, [r0, #1]
c0d04366:	29aa      	cmp	r1, #170	; 0xaa
c0d04368:	d101      	bne.n	c0d0436e <ux_stack_display+0x46>
c0d0436a:	2169      	movs	r1, #105	; 0x69
    if (G_ux.exit_code == BOLOS_UX_OK) {
      G_ux.exit_code = BOLOS_UX_REDRAW;
c0d0436c:	7041      	strb	r1, [r0, #1]
    }
  }
  // else don't draw (in stack insertion)
}
c0d0436e:	bdb0      	pop	{r4, r5, r7, pc}
c0d04370:	2000186c 	.word	0x2000186c

c0d04374 <ux_stack_init>:
  // wipe last slot
  ux_stack_pop();
}

// common code for all screens
void ux_stack_init(unsigned int stack_slot) {
c0d04374:	b570      	push	{r4, r5, r6, lr}
c0d04376:	2424      	movs	r4, #36	; 0x24
    reset();
  }
  */

  // wipe the slot to be displayed just in case
  os_memset(&G_ux.stack[stack_slot], 0, sizeof(G_ux.stack[0]));
c0d04378:	4360      	muls	r0, r4
c0d0437a:	4907      	ldr	r1, [pc, #28]	; (c0d04398 <ux_stack_init+0x24>)
c0d0437c:	180e      	adds	r6, r1, r0
}

// common code for all screens
void ux_stack_init(unsigned int stack_slot) {
  // reinit ux behavior (previous touched element, button push state)
  io_seproxyhal_init_ux(); // glitch upon ux_stack_display for a button being pressed in a previous screen
c0d0437e:	f7fc fd1b 	bl	c0d00db8 <io_seproxyhal_init_ux>
    reset();
  }
  */

  // wipe the slot to be displayed just in case
  os_memset(&G_ux.stack[stack_slot], 0, sizeof(G_ux.stack[0]));
c0d04382:	4630      	mov	r0, r6
c0d04384:	30bc      	adds	r0, #188	; 0xbc
c0d04386:	2500      	movs	r5, #0
c0d04388:	4629      	mov	r1, r5
c0d0438a:	4622      	mov	r2, r4
c0d0438c:	f7fc fba8 	bl	c0d00ae0 <os_memset>
c0d04390:	20bc      	movs	r0, #188	; 0xbc
  
  // init current screen state
  G_ux.stack[stack_slot].exit_code_after_elements_displayed = BOLOS_UX_CONTINUE;
c0d04392:	5435      	strb	r5, [r6, r0]
}
c0d04394:	bd70      	pop	{r4, r5, r6, pc}
c0d04396:	46c0      	nop			; (mov r8, r8)
c0d04398:	2000186c 	.word	0x2000186c

c0d0439c <ux_stack_al_display_next_element>:
#endif // TARGET_NANOX

#ifndef TARGET_NANOX
#if UX_STACK_SLOT_ARRAY_COUNT == 1
void ux_stack_al_display_next_element(unsigned int stack_slot) __attribute__((weak));
void ux_stack_al_display_next_element(unsigned int stack_slot) {
c0d0439c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0439e:	b081      	sub	sp, #4
c0d043a0:	4604      	mov	r4, r0
c0d043a2:	2004      	movs	r0, #4
  unsigned int status = os_sched_last_status(TASK_BOLOS_UX);
c0d043a4:	f7fd fc36 	bl	c0d01c14 <os_sched_last_status>
  if (status != BOLOS_UX_IGNORE && status != BOLOS_UX_CONTINUE) {
c0d043a8:	2800      	cmp	r0, #0
c0d043aa:	d03c      	beq.n	c0d04426 <ux_stack_al_display_next_element+0x8a>
c0d043ac:	2897      	cmp	r0, #151	; 0x97
c0d043ae:	d03a      	beq.n	c0d04426 <ux_stack_al_display_next_element+0x8a>
c0d043b0:	2024      	movs	r0, #36	; 0x24
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
c0d043b2:	4360      	muls	r0, r4
c0d043b4:	491d      	ldr	r1, [pc, #116]	; (c0d0442c <ux_stack_al_display_next_element+0x90>)
c0d043b6:	180c      	adds	r4, r1, r0
c0d043b8:	20c0      	movs	r0, #192	; 0xc0
#if UX_STACK_SLOT_ARRAY_COUNT == 1
void ux_stack_al_display_next_element(unsigned int stack_slot) __attribute__((weak));
void ux_stack_al_display_next_element(unsigned int stack_slot) {
  unsigned int status = os_sched_last_status(TASK_BOLOS_UX);
  if (status != BOLOS_UX_IGNORE && status != BOLOS_UX_CONTINUE) {
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
c0d043ba:	5820      	ldr	r0, [r4, r0]
c0d043bc:	4625      	mov	r5, r4
c0d043be:	35c0      	adds	r5, #192	; 0xc0
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
c0d043c0:	4626      	mov	r6, r4
c0d043c2:	36be      	adds	r6, #190	; 0xbe
c0d043c4:	2800      	cmp	r0, #0
c0d043c6:	d02e      	beq.n	c0d04426 <ux_stack_al_display_next_element+0x8a>
c0d043c8:	4620      	mov	r0, r4
c0d043ca:	30cc      	adds	r0, #204	; 0xcc
c0d043cc:	9000      	str	r0, [sp, #0]
c0d043ce:	34c4      	adds	r4, #196	; 0xc4
c0d043d0:	8830      	ldrh	r0, [r6, #0]
c0d043d2:	27aa      	movs	r7, #170	; 0xaa
c0d043d4:	7821      	ldrb	r1, [r4, #0]
c0d043d6:	b280      	uxth	r0, r0
      && ! io_seproxyhal_spi_is_status_sent()
c0d043d8:	4288      	cmp	r0, r1
c0d043da:	d224      	bcs.n	c0d04426 <ux_stack_al_display_next_element+0x8a>
c0d043dc:	f7fd fbe6 	bl	c0d01bac <io_seph_is_status_sent>
      && (os_perso_isonboarded() != BOLOS_UX_OK || os_global_pin_is_validated() == BOLOS_UX_OK)) {
c0d043e0:	2800      	cmp	r0, #0
c0d043e2:	d120      	bne.n	c0d04426 <ux_stack_al_display_next_element+0x8a>
c0d043e4:	f7fd fb68 	bl	c0d01ab8 <os_perso_isonboarded>
c0d043e8:	42b8      	cmp	r0, r7
c0d043ea:	d103      	bne.n	c0d043f4 <ux_stack_al_display_next_element+0x58>
c0d043ec:	f7fd fb94 	bl	c0d01b18 <os_global_pin_is_validated>
#if UX_STACK_SLOT_ARRAY_COUNT == 1
void ux_stack_al_display_next_element(unsigned int stack_slot) __attribute__((weak));
void ux_stack_al_display_next_element(unsigned int stack_slot) {
  unsigned int status = os_sched_last_status(TASK_BOLOS_UX);
  if (status != BOLOS_UX_IGNORE && status != BOLOS_UX_CONTINUE) {
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
c0d043f0:	42b8      	cmp	r0, r7
c0d043f2:	d118      	bne.n	c0d04426 <ux_stack_al_display_next_element+0x8a>
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
      && ! io_seproxyhal_spi_is_status_sent()
      && (os_perso_isonboarded() != BOLOS_UX_OK || os_global_pin_is_validated() == BOLOS_UX_OK)) {
      const bagl_element_t* element = &G_ux.stack[stack_slot].element_arrays[0].element_array[G_ux.stack[stack_slot].element_index];
c0d043f4:	6828      	ldr	r0, [r5, #0]
c0d043f6:	8831      	ldrh	r1, [r6, #0]
c0d043f8:	0149      	lsls	r1, r1, #5
c0d043fa:	1840      	adds	r0, r0, r1
      if (!G_ux.stack[stack_slot].screen_before_element_display_callback || (element = G_ux.stack[stack_slot].screen_before_element_display_callback(element)) ) {
c0d043fc:	9900      	ldr	r1, [sp, #0]
c0d043fe:	6809      	ldr	r1, [r1, #0]
c0d04400:	2900      	cmp	r1, #0
c0d04402:	d002      	beq.n	c0d0440a <ux_stack_al_display_next_element+0x6e>
c0d04404:	4788      	blx	r1
c0d04406:	2800      	cmp	r0, #0
c0d04408:	d007      	beq.n	c0d0441a <ux_stack_al_display_next_element+0x7e>
        if ((unsigned int)element == 1) { /*backward compat with coding to avoid smashing everything*/
c0d0440a:	2801      	cmp	r0, #1
c0d0440c:	d103      	bne.n	c0d04416 <ux_stack_al_display_next_element+0x7a>
          element = &G_ux.stack[stack_slot].element_arrays[0].element_array[G_ux.stack[stack_slot].element_index];
c0d0440e:	6828      	ldr	r0, [r5, #0]
c0d04410:	8831      	ldrh	r1, [r6, #0]
c0d04412:	0149      	lsls	r1, r1, #5
c0d04414:	1840      	adds	r0, r0, r1
        }
        io_seproxyhal_display(element);
c0d04416:	f7fb ffad 	bl	c0d00374 <io_seproxyhal_display>
      } \
      G_ux.stack[stack_slot].element_index++;
c0d0441a:	8830      	ldrh	r0, [r6, #0]
c0d0441c:	1c40      	adds	r0, r0, #1
c0d0441e:	8030      	strh	r0, [r6, #0]
#if UX_STACK_SLOT_ARRAY_COUNT == 1
void ux_stack_al_display_next_element(unsigned int stack_slot) __attribute__((weak));
void ux_stack_al_display_next_element(unsigned int stack_slot) {
  unsigned int status = os_sched_last_status(TASK_BOLOS_UX);
  if (status != BOLOS_UX_IGNORE && status != BOLOS_UX_CONTINUE) {
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
c0d04420:	6829      	ldr	r1, [r5, #0]
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
c0d04422:	2900      	cmp	r1, #0
c0d04424:	d1d6      	bne.n	c0d043d4 <ux_stack_al_display_next_element+0x38>
        io_seproxyhal_display(element);
      } \
      G_ux.stack[stack_slot].element_index++;
    }
  }
}
c0d04426:	b001      	add	sp, #4
c0d04428:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0442a:	46c0      	nop			; (mov r8, r8)
c0d0442c:	2000186c 	.word	0x2000186c

c0d04430 <__aeabi_uidiv>:
c0d04430:	2200      	movs	r2, #0
c0d04432:	0843      	lsrs	r3, r0, #1
c0d04434:	428b      	cmp	r3, r1
c0d04436:	d374      	bcc.n	c0d04522 <__aeabi_uidiv+0xf2>
c0d04438:	0903      	lsrs	r3, r0, #4
c0d0443a:	428b      	cmp	r3, r1
c0d0443c:	d35f      	bcc.n	c0d044fe <__aeabi_uidiv+0xce>
c0d0443e:	0a03      	lsrs	r3, r0, #8
c0d04440:	428b      	cmp	r3, r1
c0d04442:	d344      	bcc.n	c0d044ce <__aeabi_uidiv+0x9e>
c0d04444:	0b03      	lsrs	r3, r0, #12
c0d04446:	428b      	cmp	r3, r1
c0d04448:	d328      	bcc.n	c0d0449c <__aeabi_uidiv+0x6c>
c0d0444a:	0c03      	lsrs	r3, r0, #16
c0d0444c:	428b      	cmp	r3, r1
c0d0444e:	d30d      	bcc.n	c0d0446c <__aeabi_uidiv+0x3c>
c0d04450:	22ff      	movs	r2, #255	; 0xff
c0d04452:	0209      	lsls	r1, r1, #8
c0d04454:	ba12      	rev	r2, r2
c0d04456:	0c03      	lsrs	r3, r0, #16
c0d04458:	428b      	cmp	r3, r1
c0d0445a:	d302      	bcc.n	c0d04462 <__aeabi_uidiv+0x32>
c0d0445c:	1212      	asrs	r2, r2, #8
c0d0445e:	0209      	lsls	r1, r1, #8
c0d04460:	d065      	beq.n	c0d0452e <__aeabi_uidiv+0xfe>
c0d04462:	0b03      	lsrs	r3, r0, #12
c0d04464:	428b      	cmp	r3, r1
c0d04466:	d319      	bcc.n	c0d0449c <__aeabi_uidiv+0x6c>
c0d04468:	e000      	b.n	c0d0446c <__aeabi_uidiv+0x3c>
c0d0446a:	0a09      	lsrs	r1, r1, #8
c0d0446c:	0bc3      	lsrs	r3, r0, #15
c0d0446e:	428b      	cmp	r3, r1
c0d04470:	d301      	bcc.n	c0d04476 <__aeabi_uidiv+0x46>
c0d04472:	03cb      	lsls	r3, r1, #15
c0d04474:	1ac0      	subs	r0, r0, r3
c0d04476:	4152      	adcs	r2, r2
c0d04478:	0b83      	lsrs	r3, r0, #14
c0d0447a:	428b      	cmp	r3, r1
c0d0447c:	d301      	bcc.n	c0d04482 <__aeabi_uidiv+0x52>
c0d0447e:	038b      	lsls	r3, r1, #14
c0d04480:	1ac0      	subs	r0, r0, r3
c0d04482:	4152      	adcs	r2, r2
c0d04484:	0b43      	lsrs	r3, r0, #13
c0d04486:	428b      	cmp	r3, r1
c0d04488:	d301      	bcc.n	c0d0448e <__aeabi_uidiv+0x5e>
c0d0448a:	034b      	lsls	r3, r1, #13
c0d0448c:	1ac0      	subs	r0, r0, r3
c0d0448e:	4152      	adcs	r2, r2
c0d04490:	0b03      	lsrs	r3, r0, #12
c0d04492:	428b      	cmp	r3, r1
c0d04494:	d301      	bcc.n	c0d0449a <__aeabi_uidiv+0x6a>
c0d04496:	030b      	lsls	r3, r1, #12
c0d04498:	1ac0      	subs	r0, r0, r3
c0d0449a:	4152      	adcs	r2, r2
c0d0449c:	0ac3      	lsrs	r3, r0, #11
c0d0449e:	428b      	cmp	r3, r1
c0d044a0:	d301      	bcc.n	c0d044a6 <__aeabi_uidiv+0x76>
c0d044a2:	02cb      	lsls	r3, r1, #11
c0d044a4:	1ac0      	subs	r0, r0, r3
c0d044a6:	4152      	adcs	r2, r2
c0d044a8:	0a83      	lsrs	r3, r0, #10
c0d044aa:	428b      	cmp	r3, r1
c0d044ac:	d301      	bcc.n	c0d044b2 <__aeabi_uidiv+0x82>
c0d044ae:	028b      	lsls	r3, r1, #10
c0d044b0:	1ac0      	subs	r0, r0, r3
c0d044b2:	4152      	adcs	r2, r2
c0d044b4:	0a43      	lsrs	r3, r0, #9
c0d044b6:	428b      	cmp	r3, r1
c0d044b8:	d301      	bcc.n	c0d044be <__aeabi_uidiv+0x8e>
c0d044ba:	024b      	lsls	r3, r1, #9
c0d044bc:	1ac0      	subs	r0, r0, r3
c0d044be:	4152      	adcs	r2, r2
c0d044c0:	0a03      	lsrs	r3, r0, #8
c0d044c2:	428b      	cmp	r3, r1
c0d044c4:	d301      	bcc.n	c0d044ca <__aeabi_uidiv+0x9a>
c0d044c6:	020b      	lsls	r3, r1, #8
c0d044c8:	1ac0      	subs	r0, r0, r3
c0d044ca:	4152      	adcs	r2, r2
c0d044cc:	d2cd      	bcs.n	c0d0446a <__aeabi_uidiv+0x3a>
c0d044ce:	09c3      	lsrs	r3, r0, #7
c0d044d0:	428b      	cmp	r3, r1
c0d044d2:	d301      	bcc.n	c0d044d8 <__aeabi_uidiv+0xa8>
c0d044d4:	01cb      	lsls	r3, r1, #7
c0d044d6:	1ac0      	subs	r0, r0, r3
c0d044d8:	4152      	adcs	r2, r2
c0d044da:	0983      	lsrs	r3, r0, #6
c0d044dc:	428b      	cmp	r3, r1
c0d044de:	d301      	bcc.n	c0d044e4 <__aeabi_uidiv+0xb4>
c0d044e0:	018b      	lsls	r3, r1, #6
c0d044e2:	1ac0      	subs	r0, r0, r3
c0d044e4:	4152      	adcs	r2, r2
c0d044e6:	0943      	lsrs	r3, r0, #5
c0d044e8:	428b      	cmp	r3, r1
c0d044ea:	d301      	bcc.n	c0d044f0 <__aeabi_uidiv+0xc0>
c0d044ec:	014b      	lsls	r3, r1, #5
c0d044ee:	1ac0      	subs	r0, r0, r3
c0d044f0:	4152      	adcs	r2, r2
c0d044f2:	0903      	lsrs	r3, r0, #4
c0d044f4:	428b      	cmp	r3, r1
c0d044f6:	d301      	bcc.n	c0d044fc <__aeabi_uidiv+0xcc>
c0d044f8:	010b      	lsls	r3, r1, #4
c0d044fa:	1ac0      	subs	r0, r0, r3
c0d044fc:	4152      	adcs	r2, r2
c0d044fe:	08c3      	lsrs	r3, r0, #3
c0d04500:	428b      	cmp	r3, r1
c0d04502:	d301      	bcc.n	c0d04508 <__aeabi_uidiv+0xd8>
c0d04504:	00cb      	lsls	r3, r1, #3
c0d04506:	1ac0      	subs	r0, r0, r3
c0d04508:	4152      	adcs	r2, r2
c0d0450a:	0883      	lsrs	r3, r0, #2
c0d0450c:	428b      	cmp	r3, r1
c0d0450e:	d301      	bcc.n	c0d04514 <__aeabi_uidiv+0xe4>
c0d04510:	008b      	lsls	r3, r1, #2
c0d04512:	1ac0      	subs	r0, r0, r3
c0d04514:	4152      	adcs	r2, r2
c0d04516:	0843      	lsrs	r3, r0, #1
c0d04518:	428b      	cmp	r3, r1
c0d0451a:	d301      	bcc.n	c0d04520 <__aeabi_uidiv+0xf0>
c0d0451c:	004b      	lsls	r3, r1, #1
c0d0451e:	1ac0      	subs	r0, r0, r3
c0d04520:	4152      	adcs	r2, r2
c0d04522:	1a41      	subs	r1, r0, r1
c0d04524:	d200      	bcs.n	c0d04528 <__aeabi_uidiv+0xf8>
c0d04526:	4601      	mov	r1, r0
c0d04528:	4152      	adcs	r2, r2
c0d0452a:	4610      	mov	r0, r2
c0d0452c:	4770      	bx	lr
c0d0452e:	e7ff      	b.n	c0d04530 <__aeabi_uidiv+0x100>
c0d04530:	b501      	push	{r0, lr}
c0d04532:	2000      	movs	r0, #0
c0d04534:	f000 f806 	bl	c0d04544 <__aeabi_idiv0>
c0d04538:	bd02      	pop	{r1, pc}
c0d0453a:	46c0      	nop			; (mov r8, r8)

c0d0453c <__aeabi_uidivmod>:
c0d0453c:	2900      	cmp	r1, #0
c0d0453e:	d0f7      	beq.n	c0d04530 <__aeabi_uidiv+0x100>
c0d04540:	e776      	b.n	c0d04430 <__aeabi_uidiv>
c0d04542:	4770      	bx	lr

c0d04544 <__aeabi_idiv0>:
c0d04544:	4770      	bx	lr
c0d04546:	46c0      	nop			; (mov r8, r8)

c0d04548 <__aeabi_memclr>:
c0d04548:	b510      	push	{r4, lr}
c0d0454a:	2200      	movs	r2, #0
c0d0454c:	f000 f806 	bl	c0d0455c <__aeabi_memset>
c0d04550:	bd10      	pop	{r4, pc}
c0d04552:	46c0      	nop			; (mov r8, r8)

c0d04554 <__aeabi_memmove>:
c0d04554:	b510      	push	{r4, lr}
c0d04556:	f000 f809 	bl	c0d0456c <memmove>
c0d0455a:	bd10      	pop	{r4, pc}

c0d0455c <__aeabi_memset>:
c0d0455c:	0013      	movs	r3, r2
c0d0455e:	b510      	push	{r4, lr}
c0d04560:	000a      	movs	r2, r1
c0d04562:	0019      	movs	r1, r3
c0d04564:	f000 f84e 	bl	c0d04604 <memset>
c0d04568:	bd10      	pop	{r4, pc}
c0d0456a:	46c0      	nop			; (mov r8, r8)

c0d0456c <memmove>:
c0d0456c:	b570      	push	{r4, r5, r6, lr}
c0d0456e:	4288      	cmp	r0, r1
c0d04570:	d90b      	bls.n	c0d0458a <memmove+0x1e>
c0d04572:	188b      	adds	r3, r1, r2
c0d04574:	4298      	cmp	r0, r3
c0d04576:	d208      	bcs.n	c0d0458a <memmove+0x1e>
c0d04578:	1a99      	subs	r1, r3, r2
c0d0457a:	1e53      	subs	r3, r2, #1
c0d0457c:	2a00      	cmp	r2, #0
c0d0457e:	d003      	beq.n	c0d04588 <memmove+0x1c>
c0d04580:	5cca      	ldrb	r2, [r1, r3]
c0d04582:	54c2      	strb	r2, [r0, r3]
c0d04584:	3b01      	subs	r3, #1
c0d04586:	d2fb      	bcs.n	c0d04580 <memmove+0x14>
c0d04588:	bd70      	pop	{r4, r5, r6, pc}
c0d0458a:	2a0f      	cmp	r2, #15
c0d0458c:	d809      	bhi.n	c0d045a2 <memmove+0x36>
c0d0458e:	0005      	movs	r5, r0
c0d04590:	2a00      	cmp	r2, #0
c0d04592:	d0f9      	beq.n	c0d04588 <memmove+0x1c>
c0d04594:	2300      	movs	r3, #0
c0d04596:	5ccc      	ldrb	r4, [r1, r3]
c0d04598:	54ec      	strb	r4, [r5, r3]
c0d0459a:	3301      	adds	r3, #1
c0d0459c:	429a      	cmp	r2, r3
c0d0459e:	d1fa      	bne.n	c0d04596 <memmove+0x2a>
c0d045a0:	e7f2      	b.n	c0d04588 <memmove+0x1c>
c0d045a2:	000c      	movs	r4, r1
c0d045a4:	4304      	orrs	r4, r0
c0d045a6:	000b      	movs	r3, r1
c0d045a8:	07a4      	lsls	r4, r4, #30
c0d045aa:	d126      	bne.n	c0d045fa <memmove+0x8e>
c0d045ac:	0015      	movs	r5, r2
c0d045ae:	0004      	movs	r4, r0
c0d045b0:	3d10      	subs	r5, #16
c0d045b2:	092d      	lsrs	r5, r5, #4
c0d045b4:	3501      	adds	r5, #1
c0d045b6:	012d      	lsls	r5, r5, #4
c0d045b8:	1949      	adds	r1, r1, r5
c0d045ba:	681e      	ldr	r6, [r3, #0]
c0d045bc:	6026      	str	r6, [r4, #0]
c0d045be:	685e      	ldr	r6, [r3, #4]
c0d045c0:	6066      	str	r6, [r4, #4]
c0d045c2:	689e      	ldr	r6, [r3, #8]
c0d045c4:	60a6      	str	r6, [r4, #8]
c0d045c6:	68de      	ldr	r6, [r3, #12]
c0d045c8:	3310      	adds	r3, #16
c0d045ca:	60e6      	str	r6, [r4, #12]
c0d045cc:	3410      	adds	r4, #16
c0d045ce:	4299      	cmp	r1, r3
c0d045d0:	d1f3      	bne.n	c0d045ba <memmove+0x4e>
c0d045d2:	240f      	movs	r4, #15
c0d045d4:	1945      	adds	r5, r0, r5
c0d045d6:	4014      	ands	r4, r2
c0d045d8:	2c03      	cmp	r4, #3
c0d045da:	d910      	bls.n	c0d045fe <memmove+0x92>
c0d045dc:	2300      	movs	r3, #0
c0d045de:	3c04      	subs	r4, #4
c0d045e0:	08a4      	lsrs	r4, r4, #2
c0d045e2:	3401      	adds	r4, #1
c0d045e4:	00a4      	lsls	r4, r4, #2
c0d045e6:	58ce      	ldr	r6, [r1, r3]
c0d045e8:	50ee      	str	r6, [r5, r3]
c0d045ea:	3304      	adds	r3, #4
c0d045ec:	429c      	cmp	r4, r3
c0d045ee:	d1fa      	bne.n	c0d045e6 <memmove+0x7a>
c0d045f0:	2303      	movs	r3, #3
c0d045f2:	192d      	adds	r5, r5, r4
c0d045f4:	1909      	adds	r1, r1, r4
c0d045f6:	401a      	ands	r2, r3
c0d045f8:	e7ca      	b.n	c0d04590 <memmove+0x24>
c0d045fa:	0005      	movs	r5, r0
c0d045fc:	e7ca      	b.n	c0d04594 <memmove+0x28>
c0d045fe:	0022      	movs	r2, r4
c0d04600:	e7c6      	b.n	c0d04590 <memmove+0x24>
c0d04602:	46c0      	nop			; (mov r8, r8)

c0d04604 <memset>:
c0d04604:	b570      	push	{r4, r5, r6, lr}
c0d04606:	0783      	lsls	r3, r0, #30
c0d04608:	d03f      	beq.n	c0d0468a <memset+0x86>
c0d0460a:	1e54      	subs	r4, r2, #1
c0d0460c:	2a00      	cmp	r2, #0
c0d0460e:	d03b      	beq.n	c0d04688 <memset+0x84>
c0d04610:	b2ce      	uxtb	r6, r1
c0d04612:	0003      	movs	r3, r0
c0d04614:	2503      	movs	r5, #3
c0d04616:	e003      	b.n	c0d04620 <memset+0x1c>
c0d04618:	1e62      	subs	r2, r4, #1
c0d0461a:	2c00      	cmp	r4, #0
c0d0461c:	d034      	beq.n	c0d04688 <memset+0x84>
c0d0461e:	0014      	movs	r4, r2
c0d04620:	3301      	adds	r3, #1
c0d04622:	1e5a      	subs	r2, r3, #1
c0d04624:	7016      	strb	r6, [r2, #0]
c0d04626:	422b      	tst	r3, r5
c0d04628:	d1f6      	bne.n	c0d04618 <memset+0x14>
c0d0462a:	2c03      	cmp	r4, #3
c0d0462c:	d924      	bls.n	c0d04678 <memset+0x74>
c0d0462e:	25ff      	movs	r5, #255	; 0xff
c0d04630:	400d      	ands	r5, r1
c0d04632:	022a      	lsls	r2, r5, #8
c0d04634:	4315      	orrs	r5, r2
c0d04636:	042a      	lsls	r2, r5, #16
c0d04638:	4315      	orrs	r5, r2
c0d0463a:	2c0f      	cmp	r4, #15
c0d0463c:	d911      	bls.n	c0d04662 <memset+0x5e>
c0d0463e:	0026      	movs	r6, r4
c0d04640:	3e10      	subs	r6, #16
c0d04642:	0936      	lsrs	r6, r6, #4
c0d04644:	3601      	adds	r6, #1
c0d04646:	0136      	lsls	r6, r6, #4
c0d04648:	001a      	movs	r2, r3
c0d0464a:	199b      	adds	r3, r3, r6
c0d0464c:	6015      	str	r5, [r2, #0]
c0d0464e:	6055      	str	r5, [r2, #4]
c0d04650:	6095      	str	r5, [r2, #8]
c0d04652:	60d5      	str	r5, [r2, #12]
c0d04654:	3210      	adds	r2, #16
c0d04656:	4293      	cmp	r3, r2
c0d04658:	d1f8      	bne.n	c0d0464c <memset+0x48>
c0d0465a:	220f      	movs	r2, #15
c0d0465c:	4014      	ands	r4, r2
c0d0465e:	2c03      	cmp	r4, #3
c0d04660:	d90a      	bls.n	c0d04678 <memset+0x74>
c0d04662:	1f26      	subs	r6, r4, #4
c0d04664:	08b6      	lsrs	r6, r6, #2
c0d04666:	3601      	adds	r6, #1
c0d04668:	00b6      	lsls	r6, r6, #2
c0d0466a:	001a      	movs	r2, r3
c0d0466c:	199b      	adds	r3, r3, r6
c0d0466e:	c220      	stmia	r2!, {r5}
c0d04670:	4293      	cmp	r3, r2
c0d04672:	d1fc      	bne.n	c0d0466e <memset+0x6a>
c0d04674:	2203      	movs	r2, #3
c0d04676:	4014      	ands	r4, r2
c0d04678:	2c00      	cmp	r4, #0
c0d0467a:	d005      	beq.n	c0d04688 <memset+0x84>
c0d0467c:	b2c9      	uxtb	r1, r1
c0d0467e:	191c      	adds	r4, r3, r4
c0d04680:	7019      	strb	r1, [r3, #0]
c0d04682:	3301      	adds	r3, #1
c0d04684:	429c      	cmp	r4, r3
c0d04686:	d1fb      	bne.n	c0d04680 <memset+0x7c>
c0d04688:	bd70      	pop	{r4, r5, r6, pc}
c0d0468a:	0014      	movs	r4, r2
c0d0468c:	0003      	movs	r3, r0
c0d0468e:	e7cc      	b.n	c0d0462a <memset+0x26>

c0d04690 <setjmp>:
c0d04690:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d04692:	4641      	mov	r1, r8
c0d04694:	464a      	mov	r2, r9
c0d04696:	4653      	mov	r3, sl
c0d04698:	465c      	mov	r4, fp
c0d0469a:	466d      	mov	r5, sp
c0d0469c:	4676      	mov	r6, lr
c0d0469e:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d046a0:	3828      	subs	r0, #40	; 0x28
c0d046a2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d046a4:	2000      	movs	r0, #0
c0d046a6:	4770      	bx	lr

c0d046a8 <longjmp>:
c0d046a8:	3010      	adds	r0, #16
c0d046aa:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d046ac:	4690      	mov	r8, r2
c0d046ae:	4699      	mov	r9, r3
c0d046b0:	46a2      	mov	sl, r4
c0d046b2:	46ab      	mov	fp, r5
c0d046b4:	46b5      	mov	sp, r6
c0d046b6:	c808      	ldmia	r0!, {r3}
c0d046b8:	3828      	subs	r0, #40	; 0x28
c0d046ba:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d046bc:	1c08      	adds	r0, r1, #0
c0d046be:	d100      	bne.n	c0d046c2 <longjmp+0x1a>
c0d046c0:	2001      	movs	r0, #1
c0d046c2:	4718      	bx	r3

c0d046c4 <strlen>:
c0d046c4:	b510      	push	{r4, lr}
c0d046c6:	0783      	lsls	r3, r0, #30
c0d046c8:	d027      	beq.n	c0d0471a <strlen+0x56>
c0d046ca:	7803      	ldrb	r3, [r0, #0]
c0d046cc:	2b00      	cmp	r3, #0
c0d046ce:	d026      	beq.n	c0d0471e <strlen+0x5a>
c0d046d0:	0003      	movs	r3, r0
c0d046d2:	2103      	movs	r1, #3
c0d046d4:	e002      	b.n	c0d046dc <strlen+0x18>
c0d046d6:	781a      	ldrb	r2, [r3, #0]
c0d046d8:	2a00      	cmp	r2, #0
c0d046da:	d01c      	beq.n	c0d04716 <strlen+0x52>
c0d046dc:	3301      	adds	r3, #1
c0d046de:	420b      	tst	r3, r1
c0d046e0:	d1f9      	bne.n	c0d046d6 <strlen+0x12>
c0d046e2:	6819      	ldr	r1, [r3, #0]
c0d046e4:	4a0f      	ldr	r2, [pc, #60]	; (c0d04724 <strlen+0x60>)
c0d046e6:	4c10      	ldr	r4, [pc, #64]	; (c0d04728 <strlen+0x64>)
c0d046e8:	188a      	adds	r2, r1, r2
c0d046ea:	438a      	bics	r2, r1
c0d046ec:	4222      	tst	r2, r4
c0d046ee:	d10f      	bne.n	c0d04710 <strlen+0x4c>
c0d046f0:	3304      	adds	r3, #4
c0d046f2:	6819      	ldr	r1, [r3, #0]
c0d046f4:	4a0b      	ldr	r2, [pc, #44]	; (c0d04724 <strlen+0x60>)
c0d046f6:	188a      	adds	r2, r1, r2
c0d046f8:	438a      	bics	r2, r1
c0d046fa:	4222      	tst	r2, r4
c0d046fc:	d108      	bne.n	c0d04710 <strlen+0x4c>
c0d046fe:	3304      	adds	r3, #4
c0d04700:	6819      	ldr	r1, [r3, #0]
c0d04702:	4a08      	ldr	r2, [pc, #32]	; (c0d04724 <strlen+0x60>)
c0d04704:	188a      	adds	r2, r1, r2
c0d04706:	438a      	bics	r2, r1
c0d04708:	4222      	tst	r2, r4
c0d0470a:	d0f1      	beq.n	c0d046f0 <strlen+0x2c>
c0d0470c:	e000      	b.n	c0d04710 <strlen+0x4c>
c0d0470e:	3301      	adds	r3, #1
c0d04710:	781a      	ldrb	r2, [r3, #0]
c0d04712:	2a00      	cmp	r2, #0
c0d04714:	d1fb      	bne.n	c0d0470e <strlen+0x4a>
c0d04716:	1a18      	subs	r0, r3, r0
c0d04718:	bd10      	pop	{r4, pc}
c0d0471a:	0003      	movs	r3, r0
c0d0471c:	e7e1      	b.n	c0d046e2 <strlen+0x1e>
c0d0471e:	2000      	movs	r0, #0
c0d04720:	e7fa      	b.n	c0d04718 <strlen+0x54>
c0d04722:	46c0      	nop			; (mov r8, r8)
c0d04724:	fefefeff 	.word	0xfefefeff
c0d04728:	80808080 	.word	0x80808080
c0d0472c:	72646441 	.word	0x72646441
c0d04730:	00737365 	.word	0x00737365
c0d04734:	72707041 	.word	0x72707041
c0d04738:	0065766f 	.word	0x0065766f
c0d0473c:	656a6552 	.word	0x656a6552
c0d04740:	00007463 	.word	0x00007463

c0d04744 <ux_display_public_flow_5_step_val>:
c0d04744:	c0d0472c 20001800                       ,G..... 

c0d0474c <ux_display_public_flow_5_step>:
c0d0474c:	c0d03f85 c0d04744 00000000 00000000     .?..DG..........

c0d0475c <ux_display_public_flow_6_step_validate_step>:
c0d0475c:	c0d00069 00000000 00000000 00000000     i...............

c0d0476c <ux_display_public_flow_6_step_validate>:
c0d0476c:	c0d0475c ffffffff                       \G......

c0d04774 <ux_display_public_flow_6_step_val>:
c0d04774:	c0d04954 c0d04734                       TI..4G..

c0d0477c <ux_display_public_flow_6_step>:
c0d0477c:	c0d04065 c0d04774 c0d0476c 00000000     e@..tG..lG......

c0d0478c <ux_display_public_flow_7_step_validate_step>:
c0d0478c:	c0d00099 00000000 00000000 00000000     ................

c0d0479c <ux_display_public_flow_7_step_validate>:
c0d0479c:	c0d0478c ffffffff                       .G......

c0d047a4 <ux_display_public_flow_7_step_val>:
c0d047a4:	c0d04864 c0d0473c                       dH..<G..

c0d047ac <ux_display_public_flow_7_step>:
c0d047ac:	c0d04065 c0d047a4 c0d0479c 00000000     e@...G...G......

c0d047bc <ux_display_public_flow>:
c0d047bc:	c0d0474c c0d0477c c0d047ac ffffffff     LG..|G...G......

c0d047cc <C_oneLedger_logo_colors>:
c0d047cc:	00000000 00ffffff                       ........

c0d047d4 <C_oneLedger_logo_bitmap>:
c0d047d4:	f3cfffff c003e187 c003c003 f3cfe187     ................
c0d047e4:	e187f3cf c003c003 e187c003 fffff3cf     ................

c0d047f4 <C_oneLedger_logo>:
c0d047f4:	00000010 00000010 00000001 c0d047cc     .............G..
c0d04804:	c0d047d4                                .G..

c0d04808 <C_icon_coggle_colors>:
c0d04808:	00000000 00ffffff                       ........

c0d04810 <C_icon_coggle_bitmap>:
c0d04810:	00000000 f80b400c f3c0fc07 03f03cf0     .....@.......<..
c0d04820:	002d01fe 00000003 00000000              ..-.........

c0d0482c <C_icon_coggle>:
c0d0482c:	0000000e 0000000e 00000001 c0d04808     .............H..
c0d0483c:	c0d04810                                .H..

c0d04840 <C_icon_crossmark_colors>:
c0d04840:	00000000 00ffffff                       ........

c0d04848 <C_icon_crossmark_bitmap>:
c0d04848:	e6018000 383871c0 1e00fc07 03f00780     .....q88........
c0d04858:	38e1c1ce 00180670 00000000              ...8p.......

c0d04864 <C_icon_crossmark>:
c0d04864:	0000000e 0000000e 00000001 c0d04840     ............@H..
c0d04874:	c0d04848                                HH..

c0d04878 <C_icon_dashboard_x_colors>:
c0d04878:	00000000 00ffffff                       ........

c0d04880 <C_icon_dashboard_x_bitmap>:
c0d04880:	00000000 f007800c ffc1fe03 03f03ff0     .............?..
c0d04890:	c03300cc 0000000c 00000000              ..3.........

c0d0489c <C_icon_dashboard_x>:
c0d0489c:	0000000e 0000000e 00000001 c0d04878     ............xH..
c0d048ac:	c0d04880                                .H..

c0d048b0 <C_icon_down_colors>:
c0d048b0:	00000000 00ffffff                       ........

c0d048b8 <C_icon_down_bitmap>:
c0d048b8:	01051141                                A...

c0d048bc <C_icon_down>:
c0d048bc:	00000007 00000004 00000001 c0d048b0     .............H..
c0d048cc:	c0d048b8                                .H..

c0d048d0 <C_icon_left_colors>:
c0d048d0:	00000000 00ffffff                       ........

c0d048d8 <C_icon_left_bitmap>:
c0d048d8:	08421248                                H.B.

c0d048dc <C_icon_left>:
c0d048dc:	00000004 00000007 00000001 c0d048d0     .............H..
c0d048ec:	c0d048d8                                .H..

c0d048f0 <C_icon_right_colors>:
c0d048f0:	00000000 00ffffff                       ........

c0d048f8 <C_icon_right_bitmap>:
c0d048f8:	01248421                                !.$.

c0d048fc <C_icon_right>:
c0d048fc:	00000004 00000007 00000001 c0d048f0     .............H..
c0d0490c:	c0d048f8                                .H..

c0d04910 <C_icon_up_colors>:
c0d04910:	00000000 00ffffff                       ........

c0d04918 <C_icon_up_bitmap>:
c0d04918:	08288a08                                ..(.

c0d0491c <C_icon_up>:
c0d0491c:	00000007 00000004 00000001 c0d04910     .............I..
c0d0492c:	c0d04918                                .I..

c0d04930 <C_icon_validate_14_colors>:
c0d04930:	00000000 00ffffff                       ........

c0d04938 <C_icon_validate_14_bitmap>:
c0d04938:	00000000 00c00000 e0670038 039c1c38     ........8.g.8...
c0d04948:	800f007e 00000001 00000000              ~...........

c0d04954 <C_icon_validate_14>:
c0d04954:	0000000e 0000000e 00000001 c0d04930     ............0I..
c0d04964:	c0d04938 59006f4e 42007365 006b6361     8I..No.Yes.Back.
c0d04974:	4c656e4f 65676465 73690072 61657220     OneLedger.is rea
c0d04984:	53007964 69747465 0073676e 73726556     dy.Settings.Vers
c0d04994:	006e6f69 2e302e31 75510030 00007469     ion.1.0.0.Quit..

c0d049a4 <ux_idle_flow_1_step_val>:
c0d049a4:	c0d047f4 c0d04974 c0d0497e              .G..tI..~I..

c0d049b0 <ux_idle_flow_1_step>:
c0d049b0:	c0d04175 c0d049a4 00000000 00000000     uA...I..........

c0d049c0 <ux_idle_flow_2_step_validate_step>:
c0d049c0:	c0d00a85 00000000 00000000 00000000     ................

c0d049d0 <ux_idle_flow_2_step_validate>:
c0d049d0:	c0d049c0 ffffffff                       .I......

c0d049d8 <ux_idle_flow_2_step_val>:
c0d049d8:	c0d0482c c0d04987                       ,H...I..

c0d049e0 <ux_idle_flow_2_step>:
c0d049e0:	c0d04065 c0d049d8 c0d049d0 00000000     e@...I...I......

c0d049f0 <ux_idle_flow_3_step_val>:
c0d049f0:	c0d04990 c0d04998                       .I...I..

c0d049f8 <ux_idle_flow_3_step>:
c0d049f8:	c0d03be9 c0d049f0 00000000 00000000     .;...I..........

c0d04a08 <ux_idle_flow_4_step_validate_step>:
c0d04a08:	c0d00aa1 00000000 00000000 00000000     ................

c0d04a18 <ux_idle_flow_4_step_validate>:
c0d04a18:	c0d04a08 ffffffff                       .J......

c0d04a20 <ux_idle_flow_4_step_val>:
c0d04a20:	c0d0489c c0d0499e                       .H...I..

c0d04a28 <ux_idle_flow_4_step>:
c0d04a28:	c0d04065 c0d04a20 c0d04a18 00000000     e@.. J...J......

c0d04a38 <ux_idle_flow>:
c0d04a38:	c0d049b0 c0d049e0 c0d049f8 c0d04a28     .I...I...I..(J..
c0d04a48:	fffffffd ffffffff 000001b0 00a7b000     ................
c0d04a58:	02b00000 30000000                                .......

c0d04a5f <g_pcHex>:
c0d04a5f:	33323130 37363534 62613938 66656463     0123456789abcdef

c0d04a6f <g_pcHex_cap>:
c0d04a6f:	33323130 37363534 42413938 46454443     0123456789ABCDEF
c0d04a7f:	6e676953 72757461 69530065 6e696e67     Signature.Signin
c0d04a8f:	72542067 61736e61 6f697463 2e2e2e6e     g Transaction...
	...

c0d04aa0 <ux_display_sign_flow_1_step_val>:
c0d04aa0:	c0d04a7f c0d04a89                       .J...J..

c0d04aa8 <ux_display_sign_flow_1_step>:
c0d04aa8:	c0d03f85 c0d04aa0 00000000 00000000     .?...J..........

c0d04ab8 <ux_display_sign_flow_2_step_validate_step>:
c0d04ab8:	c0d018bd 00000000 00000000 00000000     ................

c0d04ac8 <ux_display_sign_flow_2_step_validate>:
c0d04ac8:	c0d04ab8 ffffffff                       .J......

c0d04ad0 <ux_display_sign_flow_2_step_val>:
c0d04ad0:	c0d04954 c0d04734                       TI..4G..

c0d04ad8 <ux_display_sign_flow_2_step>:
c0d04ad8:	c0d04065 c0d04ad0 c0d04ac8 00000000     e@...J...J......

c0d04ae8 <ux_display_sign_flow_3_step_validate_step>:
c0d04ae8:	c0d018e9 00000000 00000000 00000000     ................

c0d04af8 <ux_display_sign_flow_3_step_validate>:
c0d04af8:	c0d04ae8 ffffffff                       .J......

c0d04b00 <ux_display_sign_flow_3_step_val>:
c0d04b00:	c0d04864 c0d0473c                       dH..<G..

c0d04b08 <ux_display_sign_flow_3_step>:
c0d04b08:	c0d04065 c0d04b00 c0d04af8 00000000     e@...K...J......

c0d04b18 <ux_display_sign_flow>:
c0d04b18:	c0d04aa8 c0d04ad8 c0d04b08 ffffffff     .J...J...K......

c0d04b28 <SW_INTERNAL>:
c0d04b28:	0190006f                                         o.

c0d04b2a <SW_BUSY>:
c0d04b2a:	00670190                                         ..

c0d04b2c <SW_WRONG_LENGTH>:
c0d04b2c:	85690067                                         g.

c0d04b2e <SW_PROOF_OF_PRESENCE_REQUIRED>:
c0d04b2e:	d0f18569 00000000 4c494f42 90009000     i.......BOIL....
	...

c0d04b40 <SW_BAD_KEY_HANDLE>:
c0d04b40:	3255806a                                         j.

c0d04b42 <U2F_VERSION>:
c0d04b42:	5f463255 00903256                       U2F_V2..

c0d04b4a <INFO>:
c0d04b4a:	00900901                                ....

c0d04b4e <SW_UNKNOWN_CLASS>:
c0d04b4e:	006d006e                                         n.

c0d04b50 <SW_UNKNOWN_INSTRUCTION>:
c0d04b50:	ffff006d                                         m.

c0d04b52 <BROADCAST_CHANNEL>:
c0d04b52:	ffffffff                                ....

c0d04b56 <FORBIDDEN_CHANNEL>:
c0d04b56:	00000000 21090000                                ......

c0d04b5c <USBD_HID_Desc_fido>:
c0d04b5c:	01112109 22220121 00000000              .!..!.""....

c0d04b68 <USBD_HID_Desc>:
c0d04b68:	01112109 22220100 f1d00600                       .!...."".

c0d04b71 <HID_ReportDesc_fido>:
c0d04b71:	09f1d006 0901a101 26001503 087500ff     ...........&..u.
c0d04b81:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d04b91:	a006c008                                         ..

c0d04b93 <HID_ReportDesc>:
c0d04b93:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d04ba3:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d04bb3:	0317c008                                         ..

c0d04bb5 <C_webusb_url_descriptor>:
c0d04bb5:	77010317 6c2e7777 65676465 6c617772     ...www.ledgerwal
c0d04bc5:	2e74656c 056d6f63                                let.com

c0d04bcc <C_usb_bos>:
c0d04bcc:	00390f05 05101802 08b63800 a009a934     ..9......8..4...
c0d04bdc:	a0fd8b47 b6158876 1e010065 05101c01     G...v...e.......
c0d04bec:	dd60df00 c74589d8 65d29c4c 8a649e9d     ..`...E.L..e..d.
c0d04bfc:	0300009f 7700b206 00000000              .......w....

c0d04c08 <HID_Desc>:
c0d04c08:	c0d03379 c0d03389 c0d03399 c0d033a9     y3...3...3...3..
c0d04c18:	c0d033b9 c0d033c9 c0d033d9 c0d033e9     .3...3...3...3..

c0d04c28 <C_winusb_string_descriptor>:
c0d04c28:	004d0312 00460053 00310054 00300030     ..M.S.F.T.1.0.0.
c0d04c38:	00920077                                         w.

c0d04c3a <C_winusb_guid>:
c0d04c3a:	00000092 00050100 00880001 00070000     ................
c0d04c4a:	002a0000 00650044 00690076 00650063     ..*.D.e.v.i.c.e.
c0d04c5a:	006e0049 00650074 00660072 00630061     I.n.t.e.r.f.a.c.
c0d04c6a:	00470065 00490055 00730044 00500000     e.G.U.I.D.s...P.
c0d04c7a:	007b0000 00330031 00360064 00340033     ..{.1.3.d.6.3.4.
c0d04c8a:	00300030 0032002d 00390043 002d0037     0.0.-.2.C.9.7.-.
c0d04c9a:	00300030 00340030 0030002d 00300030     0.0.0.4.-.0.0.0.
c0d04caa:	002d0030 00630034 00350036 00340036     0.-.4.c.6.5.6.4.
c0d04cba:	00370036 00350036 00320037 0000007d     6.7.6.5.7.2.}...
	...

c0d04ccc <C_winusb_request_descriptor>:
c0d04ccc:	0000000a 06030000 000800b2 00000001     ................
c0d04cdc:	000800a8 00020002 001400a0 49570003     ..............WI
c0d04cec:	4253554e 00000000 00000000 00840000     NUSB............
c0d04cfc:	00070004 0044002a 00760065 00630069     ....*.D.e.v.i.c.
c0d04d0c:	00490065 0074006e 00720065 00610066     e.I.n.t.e.r.f.a.
c0d04d1c:	00650063 00550047 00440049 00000073     c.e.G.U.I.D.s...
c0d04d2c:	007b0050 00450043 00300038 00320039     P.{.C.E.8.0.9.2.
c0d04d3c:	00340036 0034002d 00320042 002d0034     6.4.-.4.B.2.4.-.
c0d04d4c:	00450034 00310038 0041002d 00420038     4.E.8.1.-.A.8.B.
c0d04d5c:	002d0032 00370035 00440045 00310030     2.-.5.7.E.D.0.1.
c0d04d6c:	00350044 00300038 00310045 0000007d     D.5.8.0.E.1.}...
c0d04d7c:	00000000                                ....

c0d04d80 <USBD_HID>:
c0d04d80:	c0d03125 c0d03157 c0d0308f 00000000     %1..W1...0......
c0d04d90:	00000000 c0d0327d c0d03295 00000000     ....}2...2......
	...
c0d04da8:	c0d03575 c0d03575 c0d03575 c0d03585     u5..u5..u5...5..

c0d04db8 <USBD_U2F>:
c0d04db8:	c0d03205 c0d03157 c0d0308f 00000000     .2..W1...0......
c0d04dc8:	00000000 c0d03239 c0d03251 00000000     ....92..Q2......
	...
c0d04de0:	c0d03575 c0d03575 c0d03575 c0d03585     u5..u5..u5...5..

c0d04df0 <USBD_WEBUSB>:
c0d04df0:	c0d032e1 c0d0330d c0d03311 00000000     .2...3...3......
c0d04e00:	00000000 c0d03315 c0d0332d 00000000     .....3..-3......
	...
c0d04e18:	c0d03575 c0d03575 c0d03575 c0d03585     u5..u5..u5...5..

c0d04e28 <USBD_DeviceDesc>:
c0d04e28:	02100112 40000000 10152c97 02010201     .......@.,......
c0d04e38:	03040103                                         ..

c0d04e3a <USBD_LangIDDesc>:
c0d04e3a:	04090304                                ....

c0d04e3e <USBD_MANUFACTURER_STRING>:
c0d04e3e:	004c030e 00640065 00650067 030e0072              ..L.e.d.g.e.r.

c0d04e4c <USBD_PRODUCT_FS_STRING>:
c0d04e4c:	004e030e 006e0061 0020006f 030a0053              ..N.a.n.o. .S.

c0d04e5a <USB_SERIAL_STRING>:
c0d04e5a:	0030030a 00300030 00280031                       ..0.0.0.1.

c0d04e64 <C_winusb_wcid>:
c0d04e64:	00000028 00040100 00000001 00000000     (...............
c0d04e74:	49570102 4253554e 00000000 00000000     ..WINUSB........
	...

c0d04e8c <USBD_CfgDesc>:
c0d04e8c:	00600209 c0020103 00040932 00030200     ..`.....2.......
c0d04e9c:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d04eac:	05070100 00400302 01040901 01030200     ......@.........
c0d04ebc:	21090201 01210111 07002222 40038105     ...!..!."".....@
c0d04ecc:	05070100 00400301 02040901 ffff0200     ......@.........
c0d04edc:	050702ff 00400383 03050701 01004003     ......@......@..

c0d04eec <USBD_DeviceQualifierDesc>:
c0d04eec:	0200060a 40000000 31300001 35343332     .......@..012345
c0d04efc:	39383736 64636261 00006665              6789abcdef..

c0d04f08 <derivePath>:
c0d04f08:	8000002c 80000193 80000000 80000000     ,...............
c0d04f18:	80000000                                ....

c0d04f1c <ux_layout_bb_elements>:
c0d04f1c:	00000003 00800000 00000020 00000001     ........ .......
c0d04f2c:	00000000 00ffffff 00000000 00000000     ................
c0d04f3c:	00020105 0004000c 00000007 00000000     ................
c0d04f4c:	00ffffff 00000000 00000000 c0d048dc     .............H..
c0d04f5c:	007a0205 0004000c 00000007 00000000     ..z.............
c0d04f6c:	00ffffff 00000000 00000000 c0d048fc     .............H..
c0d04f7c:	00001007 0080000c 00000020 00000000     ........ .......
c0d04f8c:	00ffffff 00000000 00008008 00000000     ................
c0d04f9c:	00001107 0080001a 00000020 00000000     ........ .......
c0d04fac:	00ffffff 00000000 00008008 00000000     ................

c0d04fbc <ux_layout_nnbnn_elements>:
c0d04fbc:	00000003 00800000 00000020 00000001     ........ .......
c0d04fcc:	00000000 00ffffff 00000000 00000000     ................
c0d04fdc:	00000105 0007000e 00000004 00000000     ................
c0d04fec:	00ffffff 00000000 00000000 c0d0491c     .............I..
c0d04ffc:	00780205 0007000e 00000004 00000000     ..x.............
c0d0500c:	00ffffff 00000000 00000000 c0d048bc     .............H..
c0d0501c:	00001107 00800003 00000020 00000000     ........ .......
c0d0502c:	00ffffff 00000000 0000800a 00000000     ................
c0d0503c:	00001207 00800013 00000020 00000000     ........ .......
c0d0504c:	00ffffff 00000000 00008008 00000000     ................
c0d0505c:	00001307 00800023 00000020 00000000     ....#... .......
c0d0506c:	00ffffff 00000000 0000800a 00000000     ................
c0d0507c:	28207325 252f6425 25002964 64250073     %s (%d/%d).%s.%d
c0d0508c:	0064252f 732a2e25 00000000              /%d.%.*s....

c0d05098 <ux_layout_pb_elements>:
c0d05098:	00000003 00800000 00000020 00000001     ........ .......
c0d050a8:	00000000 00ffffff 00000000 00000000     ................
c0d050b8:	00020105 0004000c 00000007 00000000     ................
c0d050c8:	00ffffff 00000000 00000000 c0d048dc     .............H..
c0d050d8:	007a0205 0004000c 00000007 00000000     ..z.............
c0d050e8:	00ffffff 00000000 00000000 c0d048fc     .............H..
c0d050f8:	00381005 00100002 00000010 00000000     ..8.............
c0d05108:	00ffffff 00000000 0000800a 00000000     ................
c0d05118:	00001107 0080001c 00000020 00000000     ........ .......
c0d05128:	00ffffff 00000000 00008008 00000000     ................

c0d05138 <ux_layout_pbb_elements>:
c0d05138:	00000003 00800000 00000020 00000001     ........ .......
c0d05148:	00000000 00ffffff 00000000 00000000     ................
c0d05158:	00020105 0004000c 00000007 00000000     ................
c0d05168:	00ffffff 00000000 00000000 c0d048dc     .............H..
c0d05178:	007a0205 0004000c 00000007 00000000     ..z.............
c0d05188:	00ffffff 00000000 00000000 c0d048fc     .............H..
c0d05198:	00100f05 00100008 00000010 00000000     ................
c0d051a8:	00ffffff 00000000 00000000 00000000     ................
c0d051b8:	00291007 0080000c 00000020 00000000     ..)..... .......
c0d051c8:	00ffffff 00000000 00000008 00000000     ................
c0d051d8:	00291107 0080001a 00000020 00000000     ..)..... .......
c0d051e8:	00ffffff 00000000 00000008 00000000     ................

c0d051f8 <ux_menulist_conststep>:
c0d051f8:	c0d04265 20001950 00000000 00000000     eB..P.. ........

c0d05208 <ux_menulist_constflow>:
c0d05208:	c0d051f8 ffffffff                       .Q......

c0d05210 <_etext>:
	...

c0d05240 <N_storage_real>:
	...
