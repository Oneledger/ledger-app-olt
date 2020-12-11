
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
c0d00012:	f004 facd 	bl	c0d045b0 <__aeabi_memclr>
c0d00016:	466d      	mov	r5, sp

        BEGIN_TRY {
            TRY {
c0d00018:	4628      	mov	r0, r5
c0d0001a:	f004 fb6d 	bl	c0d046f8 <setjmp>
c0d0001e:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d00020:	b285      	uxth	r5, r0
c0d00022:	4668      	mov	r0, sp
c0d00024:	2d00      	cmp	r5, #0
c0d00026:	d00b      	beq.n	c0d00040 <main+0x40>
c0d00028:	2100      	movs	r1, #0
c0d0002a:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d0002c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0002e:	f001 fe19 	bl	c0d01c64 <try_context_set>
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
c0d00040:	f001 fe10 	bl	c0d01c64 <try_context_set>
c0d00044:	900a      	str	r0, [sp, #40]	; 0x28
                io_seproxyhal_init();
c0d00046:	f000 fe9d 	bl	c0d00d84 <io_seproxyhal_init>

                nv_app_state_init();
c0d0004a:	f000 fccb 	bl	c0d009e4 <nv_app_state_init>
c0d0004e:	2000      	movs	r0, #0

                USB_power(0);
c0d00050:	f003 fa66 	bl	c0d03520 <USB_power>
c0d00054:	2001      	movs	r0, #1
                USB_power(1);
c0d00056:	f003 fa63 	bl	c0d03520 <USB_power>

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
c0d00086:	f003 fba1 	bl	c0d037cc <sendResponse>
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
c0d0009e:	f003 fb95 	bl	c0d037cc <sendResponse>
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
c0d000a8:	f003 fb84 	bl	c0d037b4 <readUint32BE>
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
c0d000c8:	f004 fa72 	bl	c0d045b0 <__aeabi_memclr>

    //Get Public key from ED25519 private key. This is done by creating a BIP32 path using the account number and deriving a key.
    getPublicKey(accountNum, publicKey);
c0d000cc:	4812      	ldr	r0, [pc, #72]	; (c0d00118 <handleGetAddress+0x60>)
c0d000ce:	6800      	ldr	r0, [r0, #0]
c0d000d0:	4639      	mov	r1, r7
c0d000d2:	f003 fb1b 	bl	c0d0370c <getPublicKey>

    //Get Public Key string from binary
    btox(public_key_str, (const char*)publicKey, FULL_PUBKEY_LENGTH);
c0d000d6:	4811      	ldr	r0, [pc, #68]	; (c0d0011c <handleGetAddress+0x64>)
c0d000d8:	2240      	movs	r2, #64	; 0x40
c0d000da:	4639      	mov	r1, r7
c0d000dc:	f003 fad0 	bl	c0d03680 <btox>

    //Address is generated by calculating SHA256 hash and copying first 20 bytes.
    getAddressStringFromBinary(publicKey, address_str);
c0d000e0:	490f      	ldr	r1, [pc, #60]	; (c0d00120 <handleGetAddress+0x68>)
c0d000e2:	4638      	mov	r0, r7
c0d000e4:	f003 fae6 	bl	c0d036b4 <getAddressStringFromBinary>

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
c0d000f6:	f003 fcf3 	bl	c0d03ae0 <ux_flow_init>

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
c0d00124:	00004730 	.word	0x00004730

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
c0d0015c:	f004 facc 	bl	c0d046f8 <setjmp>
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
c0d00176:	f001 fd75 	bl	c0d01c64 <try_context_set>
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
c0d0019e:	f001 fd61 	bl	c0d01c64 <try_context_set>
c0d001a2:	900b      	str	r0, [sp, #44]	; 0x2c
c0d001a4:	ad0d      	add	r5, sp, #52	; 0x34
            parseAPDU(&apdu_input);
c0d001a6:	4628      	mov	r0, r5
c0d001a8:	f003 fb2c 	bl	c0d03804 <parseAPDU>

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
c0d001cc:	f001 fbc8 	bl	c0d01960 <handleSignRawTx>
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
c0d001fe:	f001 fd25 	bl	c0d01c4c <try_context_get>
c0d00202:	a901      	add	r1, sp, #4
c0d00204:	4288      	cmp	r0, r1
c0d00206:	d102      	bne.n	c0d0020e <handleApdu+0xbe>
c0d00208:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0020a:	f001 fd2b 	bl	c0d01c64 <try_context_set>
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
c0d00222:	f001 fd1f 	bl	c0d01c64 <try_context_set>
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
c0d00284:	000050ca 	.word	0x000050ca

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
c0d0029c:	f004 fa2c 	bl	c0d046f8 <setjmp>
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
c0d002b4:	f001 fcd6 	bl	c0d01c64 <try_context_set>
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
c0d002d6:	f001 fcc5 	bl	c0d01c64 <try_context_set>
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
c0d00334:	f001 fc8a 	bl	c0d01c4c <try_context_get>
c0d00338:	4669      	mov	r1, sp
c0d0033a:	4288      	cmp	r0, r1
c0d0033c:	d102      	bne.n	c0d00344 <app_main+0xbc>
c0d0033e:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00340:	f001 fc90 	bl	c0d01c64 <try_context_set>
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
c0d00356:	f001 fc85 	bl	c0d01c64 <try_context_set>
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
c0d003c2:	f001 fbe9 	bl	c0d01b98 <os_ux>
c0d003c6:	2004      	movs	r0, #4
c0d003c8:	f001 fc58 	bl	c0d01c7c <os_sched_last_status>
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
c0d003e4:	f001 fc4a 	bl	c0d01c7c <os_sched_last_status>
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
c0d00410:	f001 fc00 	bl	c0d01c14 <io_seph_is_status_sent>
c0d00414:	2800      	cmp	r0, #0
c0d00416:	d000      	beq.n	c0d0041a <io_event+0x9e>
c0d00418:	e234      	b.n	c0d00884 <io_event+0x508>
c0d0041a:	f001 fb81 	bl	c0d01b20 <os_perso_isonboarded>
c0d0041e:	42b8      	cmp	r0, r7
c0d00420:	d104      	bne.n	c0d0042c <io_event+0xb0>
c0d00422:	f001 fbad 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d0046c:	f001 fb94 	bl	c0d01b98 <os_ux>
c0d00470:	2004      	movs	r0, #4
c0d00472:	f001 fc03 	bl	c0d01c7c <os_sched_last_status>
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
c0d004a8:	f001 fbb4 	bl	c0d01c14 <io_seph_is_status_sent>
c0d004ac:	2800      	cmp	r0, #0
c0d004ae:	d000      	beq.n	c0d004b2 <io_event+0x136>
c0d004b0:	e1e0      	b.n	c0d00874 <io_event+0x4f8>
c0d004b2:	f001 fb35 	bl	c0d01b20 <os_perso_isonboarded>
c0d004b6:	42b8      	cmp	r0, r7
c0d004b8:	d104      	bne.n	c0d004c4 <io_event+0x148>
c0d004ba:	f001 fb61 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d00504:	f001 fb48 	bl	c0d01b98 <os_ux>
c0d00508:	2004      	movs	r0, #4
c0d0050a:	f001 fbb7 	bl	c0d01c7c <os_sched_last_status>
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
c0d00526:	f001 fba9 	bl	c0d01c7c <os_sched_last_status>
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
c0d00552:	f001 fb5f 	bl	c0d01c14 <io_seph_is_status_sent>
c0d00556:	2800      	cmp	r0, #0
c0d00558:	d000      	beq.n	c0d0055c <io_event+0x1e0>
c0d0055a:	e193      	b.n	c0d00884 <io_event+0x508>
c0d0055c:	f001 fae0 	bl	c0d01b20 <os_perso_isonboarded>
c0d00560:	42b8      	cmp	r0, r7
c0d00562:	d104      	bne.n	c0d0056e <io_event+0x1f2>
c0d00564:	f001 fb0c 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d005ae:	f001 faf3 	bl	c0d01b98 <os_ux>
c0d005b2:	2004      	movs	r0, #4
c0d005b4:	f001 fb62 	bl	c0d01c7c <os_sched_last_status>
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
c0d005dc:	f001 fb4e 	bl	c0d01c7c <os_sched_last_status>
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
c0d00608:	f001 fb04 	bl	c0d01c14 <io_seph_is_status_sent>
c0d0060c:	2800      	cmp	r0, #0
c0d0060e:	d000      	beq.n	c0d00612 <io_event+0x296>
c0d00610:	e138      	b.n	c0d00884 <io_event+0x508>
c0d00612:	f001 fa85 	bl	c0d01b20 <os_perso_isonboarded>
c0d00616:	42b8      	cmp	r0, r7
c0d00618:	d104      	bne.n	c0d00624 <io_event+0x2a8>
c0d0061a:	f001 fab1 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d00676:	f001 facd 	bl	c0d01c14 <io_seph_is_status_sent>
c0d0067a:	2800      	cmp	r0, #0
c0d0067c:	d000      	beq.n	c0d00680 <io_event+0x304>
c0d0067e:	e0f9      	b.n	c0d00874 <io_event+0x4f8>
c0d00680:	f001 fa4e 	bl	c0d01b20 <os_perso_isonboarded>
c0d00684:	42b8      	cmp	r0, r7
c0d00686:	d104      	bne.n	c0d00692 <io_event+0x316>
c0d00688:	f001 fa7a 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d0071a:	f001 fa7b 	bl	c0d01c14 <io_seph_is_status_sent>
c0d0071e:	2800      	cmp	r0, #0
c0d00720:	d120      	bne.n	c0d00764 <io_event+0x3e8>
c0d00722:	f001 f9fd 	bl	c0d01b20 <os_perso_isonboarded>
c0d00726:	42b8      	cmp	r0, r7
c0d00728:	d103      	bne.n	c0d00732 <io_event+0x3b6>
c0d0072a:	f001 fa29 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d00790:	f001 fa74 	bl	c0d01c7c <os_sched_last_status>
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
c0d007b4:	f001 fa2e 	bl	c0d01c14 <io_seph_is_status_sent>
c0d007b8:	2800      	cmp	r0, #0
c0d007ba:	d163      	bne.n	c0d00884 <io_event+0x508>
c0d007bc:	f001 f9b0 	bl	c0d01b20 <os_perso_isonboarded>
c0d007c0:	42b8      	cmp	r0, r7
c0d007c2:	d103      	bne.n	c0d007cc <io_event+0x450>
c0d007c4:	f001 f9dc 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d0082a:	f001 f9f3 	bl	c0d01c14 <io_seph_is_status_sent>
c0d0082e:	2800      	cmp	r0, #0
c0d00830:	d120      	bne.n	c0d00874 <io_event+0x4f8>
c0d00832:	f001 f975 	bl	c0d01b20 <os_perso_isonboarded>
c0d00836:	42b8      	cmp	r0, r7
c0d00838:	d103      	bne.n	c0d00842 <io_event+0x4c6>
c0d0083a:	f001 f9a1 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d00880:	f001 f9c8 	bl	c0d01c14 <io_seph_is_status_sent>
            });
            break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00884:	f001 f9c6 	bl	c0d01c14 <io_seph_is_status_sent>
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
c0d008ae:	f003 fe79 	bl	c0d045a4 <__aeabi_uidivmod>
c0d008b2:	4829      	ldr	r0, [pc, #164]	; (c0d00958 <io_event+0x5dc>)
c0d008b4:	6001      	str	r1, [r0, #0]
c0d008b6:	f000 fa7f 	bl	c0d00db8 <io_seproxyhal_init_ux>
c0d008ba:	f000 fa7f 	bl	c0d00dbc <io_seproxyhal_init_button>
c0d008be:	20be      	movs	r0, #190	; 0xbe
c0d008c0:	9000      	str	r0, [sp, #0]
c0d008c2:	5237      	strh	r7, [r6, r0]
c0d008c4:	2004      	movs	r0, #4
c0d008c6:	f001 f9d9 	bl	c0d01c7c <os_sched_last_status>
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
c0d008f4:	f001 f98e 	bl	c0d01c14 <io_seph_is_status_sent>
c0d008f8:	2800      	cmp	r0, #0
c0d008fa:	d000      	beq.n	c0d008fe <io_event+0x582>
c0d008fc:	e6fb      	b.n	c0d006f6 <io_event+0x37a>
c0d008fe:	f001 f90f 	bl	c0d01b20 <os_perso_isonboarded>
c0d00902:	42b8      	cmp	r0, r7
c0d00904:	d104      	bne.n	c0d00910 <io_event+0x594>
c0d00906:	f001 f93b 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d00974:	f001 f942 	bl	c0d01bfc <io_seph_send>

                if (channel & IO_RESET_AFTER_REPLIED) {
c0d00978:	b268      	sxtb	r0, r5
c0d0097a:	2800      	cmp	r0, #0
c0d0097c:	da0a      	bge.n	c0d00994 <io_exchange_al+0x38>
                    reset();
c0d0097e:	f001 f84d 	bl	c0d01a1c <halt>
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
c0d0098e:	f001 f94d 	bl	c0d01c2c <io_seph_recv>
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
c0d009ac:	f003 fea4 	bl	c0d046f8 <setjmp>
c0d009b0:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d009b2:	0400      	lsls	r0, r0, #16
c0d009b4:	d106      	bne.n	c0d009c4 <app_exit+0x20>
c0d009b6:	4668      	mov	r0, sp
c0d009b8:	f001 f954 	bl	c0d01c64 <try_context_set>
c0d009bc:	900a      	str	r0, [sp, #40]	; 0x28
c0d009be:	20ff      	movs	r0, #255	; 0xff
            os_sched_exit(-1);
c0d009c0:	f001 f910 	bl	c0d01be4 <os_sched_exit>
        }
        FINALLY_L(exit) {
c0d009c4:	f001 f942 	bl	c0d01c4c <try_context_get>
c0d009c8:	4669      	mov	r1, sp
c0d009ca:	4288      	cmp	r0, r1
c0d009cc:	d102      	bne.n	c0d009d4 <app_exit+0x30>
c0d009ce:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d009d0:	f001 f948 	bl	c0d01c64 <try_context_set>
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
c0d00a0c:	f001 f810 	bl	c0d01a30 <nvm_write>
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
c0d00a38:	00004912 	.word	0x00004912
c0d00a3c:	000048fa 	.word	0x000048fa
c0d00a40:	000048ea 	.word	0x000048ea

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
c0d00a4e:	f003 fc83 	bl	c0d04358 <ux_stack_push>
    }
    ux_flow_init(0, ux_idle_flow, NULL);
c0d00a52:	4904      	ldr	r1, [pc, #16]	; (c0d00a64 <ui_idle+0x20>)
c0d00a54:	4479      	add	r1, pc
c0d00a56:	2000      	movs	r0, #0
c0d00a58:	4602      	mov	r2, r0
c0d00a5a:	f003 f841 	bl	c0d03ae0 <ux_flow_init>
}
c0d00a5e:	bd80      	pop	{r7, pc}
c0d00a60:	2000186c 	.word	0x2000186c
c0d00a64:	00004048 	.word	0x00004048

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
c0d00a78:	00003f61 	.word	0x00003f61

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
c0d00a90:	f003 fc5c 	bl	c0d0434c <ux_menulist_init>
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
c0d00aa4:	f001 f89e 	bl	c0d01be4 <os_sched_exit>
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
c0d00aae:	f001 f8d9 	bl	c0d01c64 <try_context_set>
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
c0d00aec:	f003 fd6a 	bl	c0d045c4 <__aeabi_memset>
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
c0d00b1c:	f001 f896 	bl	c0d01c4c <try_context_get>
c0d00b20:	4621      	mov	r1, r4
c0d00b22:	f003 fdf5 	bl	c0d04710 <longjmp>
	...

c0d00b28 <io_seproxyhal_general_status>:

#ifndef IO_RAPDU_TRANSMIT_TIMEOUT_MS 
#define IO_RAPDU_TRANSMIT_TIMEOUT_MS 2000UL
#endif // IO_RAPDU_TRANSMIT_TIMEOUT_MS

void io_seproxyhal_general_status(void) {
c0d00b28:	b580      	push	{r7, lr}
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00b2a:	f001 f873 	bl	c0d01c14 <io_seph_is_status_sent>
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
c0d00b48:	f001 f858 	bl	c0d01bfc <io_seph_send>
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
c0d00b68:	f002 f847 	bl	c0d02bfa <USBD_LL_SOF>
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
c0d00b78:	f002 f83d 	bl	c0d02bf6 <USBD_LL_Resume>
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
c0d00b84:	f002 f832 	bl	c0d02bec <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00b88:	4620      	mov	r0, r4
c0d00b8a:	f002 f810 	bl	c0d02bae <USBD_LL_Reset>
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
c0d00bb4:	f002 f81d 	bl	c0d02bf2 <USBD_LL_Suspend>
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
c0d00bc4:	20001dac 	.word	0x20001dac
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
c0d00bfa:	f001 fede 	bl	c0d029ba <USBD_LL_SetupStage>
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
c0d00c18:	f001 ff55 	bl	c0d02ac6 <USBD_LL_DataInStage>
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
c0d00c34:	f001 feef 	bl	c0d02a16 <USBD_LL_DataOutStage>
      }
      break;
  }
}
c0d00c38:	bd80      	pop	{r7, pc}
c0d00c3a:	46c0      	nop			; (mov r8, r8)
c0d00c3c:	20001a0c 	.word	0x20001a0c
c0d00c40:	20001be0 	.word	0x20001be0
c0d00c44:	20001dac 	.word	0x20001dac

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
c0d00c70:	f000 ffc4 	bl	c0d01bfc <io_seph_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00c74:	4630      	mov	r0, r6
c0d00c76:	4629      	mov	r1, r5
c0d00c78:	f000 ffc0 	bl	c0d01bfc <io_seph_send>
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
c0d00d88:	f000 fe3c 	bl	c0d01a04 <check_api_level>

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
c0d00e30:	f000 fee4 	bl	c0d01bfc <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d00e34:	4628      	mov	r0, r5
c0d00e36:	9901      	ldr	r1, [sp, #4]
c0d00e38:	f000 fee0 	bl	c0d01bfc <io_seph_send>
    G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d00e3c:	68a0      	ldr	r0, [r4, #8]
c0d00e3e:	7038      	strb	r0, [r7, #0]
c0d00e40:	2101      	movs	r1, #1
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d00e42:	4638      	mov	r0, r7
c0d00e44:	f000 feda 	bl	c0d01bfc <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d00e48:	68e0      	ldr	r0, [r4, #12]
c0d00e4a:	f000 fd21 	bl	c0d01890 <pic>
c0d00e4e:	b2b1      	uxth	r1, r6
c0d00e50:	f000 fed4 	bl	c0d01bfc <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d00e54:	9800      	ldr	r0, [sp, #0]
c0d00e56:	b285      	uxth	r5, r0
c0d00e58:	6920      	ldr	r0, [r4, #16]
c0d00e5a:	f000 fd19 	bl	c0d01890 <pic>
c0d00e5e:	4629      	mov	r1, r5
c0d00e60:	f000 fecc 	bl	c0d01bfc <io_seph_send>
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
c0d00e7a:	f000 fecb 	bl	c0d01c14 <io_seph_is_status_sent>
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
c0d00e9e:	f003 fc45 	bl	c0d0472c <strlen>
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
c0d00eb6:	f000 fea1 	bl	c0d01bfc <io_seph_send>
c0d00eba:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d00ebc:	4620      	mov	r0, r4
c0d00ebe:	f000 fe9d 	bl	c0d01bfc <io_seph_send>
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
c0d00ed8:	f000 fe90 	bl	c0d01bfc <io_seph_send>
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d00edc:	4620      	mov	r0, r4
c0d00ede:	4629      	mov	r1, r5
c0d00ee0:	f000 fe8c 	bl	c0d01bfc <io_seph_send>
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
c0d00f32:	f003 fb37 	bl	c0d045a4 <__aeabi_uidivmod>
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
c0d00f6c:	f000 fe2c 	bl	c0d01bc8 <os_registry_get_current_app_tag>
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
c0d00f7c:	f000 fe24 	bl	c0d01bc8 <os_registry_get_current_app_tag>
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
c0d00f88:	f000 fe12 	bl	c0d01bb0 <os_flags>
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
c0d00fea:	f000 fe1f 	bl	c0d01c2c <io_seph_recv>
c0d00fee:	2001      	movs	r0, #1
        // process without sending status on tickers etc, to ensure keeping the hand
        os_io_seph_recv_and_process(1);
c0d00ff0:	f000 f946 	bl	c0d01280 <os_io_seph_recv_and_process>
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
      // ensure it's our turn to send a command/status, could lag a bit before sending the reply
      while (io_seproxyhal_spi_is_status_sent()) {
c0d00ff4:	f000 fe0e 	bl	c0d01c14 <io_seph_is_status_sent>
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
c0d0101a:	f001 fae1 	bl	c0d025e0 <u2f_message_set_autoreply_wait_user_presence>
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
c0d0102a:	f000 fdff 	bl	c0d01c2c <io_seph_recv>
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
c0d0103a:	f000 fdeb 	bl	c0d01c14 <io_seph_is_status_sent>
c0d0103e:	2800      	cmp	r0, #0
c0d01040:	d1f0      	bne.n	c0d01024 <io_exchange+0x84>

            // the reply has been prepared by the application, stop sending anti timeouts
            u2f_message_set_autoreply_wait_user_presence(&G_io_u2f, false);

            // continue processing currently received command until completely received.
            while(!u2f_message_repliable(&G_io_u2f)) {
c0d01042:	4886      	ldr	r0, [pc, #536]	; (c0d0125c <io_exchange+0x2bc>)
c0d01044:	f001 f824 	bl	c0d02090 <u2f_message_repliable>
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
c0d0108c:	f001 fabc 	bl	c0d02608 <u2f_message_reply>
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
c0d010ce:	f000 fd95 	bl	c0d01bfc <io_seph_send>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d010d2:	4863      	ldr	r0, [pc, #396]	; (c0d01260 <io_exchange+0x2c0>)
c0d010d4:	9905      	ldr	r1, [sp, #20]
c0d010d6:	f000 fd91 	bl	c0d01bfc <io_seph_send>
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
c0d010fe:	f000 fd95 	bl	c0d01c2c <io_seph_recv>
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
c0d0110e:	f000 fd81 	bl	c0d01c14 <io_seph_is_status_sent>
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
c0d01154:	f000 fd5e 	bl	c0d01c14 <io_seph_is_status_sent>
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
c0d01168:	f000 fd60 	bl	c0d01c2c <io_seph_recv>

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
c0d011c6:	f000 fcdb 	bl	c0d01b80 <os_global_pin_is_validated>
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
c0d011d8:	f000 fcc4 	bl	c0d01b64 <os_perso_seed_cookie>
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
c0d01274:	00003924 	.word	0x00003924
c0d01278:	00003917 	.word	0x00003917
c0d0127c:	0000390c 	.word	0x0000390c

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
c0d01284:	f000 fcc6 	bl	c0d01c14 <io_seph_is_status_sent>
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
c0d0129a:	f000 fcc7 	bl	c0d01c2c <io_seph_recv>

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
c0d0130e:	f000 fb9d 	bl	c0d01a4c <cx_rng>
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
c0d01532:	f003 f83d 	bl	c0d045b0 <__aeabi_memclr>
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
c0d01564:	f003 f82a 	bl	c0d045bc <__aeabi_memmove>
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
c0d016c0:	f002 feea 	bl	c0d04498 <__aeabi_uidiv>
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
c0d0171a:	f002 ff53 	bl	c0d045c4 <__aeabi_memset>
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
c0d01750:	f002 fea2 	bl	c0d04498 <__aeabi_uidiv>
c0d01754:	4639      	mov	r1, r7
c0d01756:	f002 ff25 	bl	c0d045a4 <__aeabi_uidivmod>
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
c0d01766:	f002 fe97 	bl	c0d04498 <__aeabi_uidiv>
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
c0d01782:	f002 ff1b 	bl	c0d045bc <__aeabi_memmove>
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
c0d0182e:	f002 fec5 	bl	c0d045bc <__aeabi_memmove>
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
c0d01846:	f002 febd 	bl	c0d045c4 <__aeabi_memset>
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
c0d0186a:	f002 feab 	bl	c0d045c4 <__aeabi_memset>
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
c0d01880:	000032c1 	.word	0x000032c1
c0d01884:	000032d7 	.word	0x000032d7
c0d01888:	0000337b 	.word	0x0000337b
c0d0188c:	00003391 	.word	0x00003391

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
c0d018a8:	c0d05340 	.word	0xc0d05340

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
      .title = "Fee <OLT>",
      .text = sendCtx.fee,
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
      .title = "Fee <OLT>",
      .text = sendCtx.fee,
    });
UX_STEP_VALID(
c0d018d2:	b2c0      	uxtb	r0, r0
c0d018d4:	2101      	movs	r1, #1
c0d018d6:	f001 ff79 	bl	c0d037cc <sendResponse>
c0d018da:	bd10      	pop	{r4, pc}
c0d018dc:	20001d92 	.word	0x20001d92
c0d018e0:	20001a8e 	.word	0x20001a8e
c0d018e4:	20001d20 	.word	0x20001d20

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
c0d018ee:	f001 ff6d 	bl	c0d037cc <sendResponse>
c0d018f2:	bd80      	pop	{r7, pc}

c0d018f4 <parseSignRawTxData>:
);

////////// HANDLE SIGN RAW TRANSACTION REQUEST //////////

void parseSignRawTxData(struct apduMessage *apdu)
{
c0d018f4:	b570      	push	{r4, r5, r6, lr}
c0d018f6:	4604      	mov	r4, r0
    //Parse Account NUMBER
    signCtx.accountNumber = readUint32BE(&apdu->cData[ACCT_NUM_OFFSET]);
c0d018f8:	6880      	ldr	r0, [r0, #8]
c0d018fa:	f001 ff5b 	bl	c0d037b4 <readUint32BE>
c0d018fe:	4913      	ldr	r1, [pc, #76]	; (c0d0194c <parseSignRawTxData+0x58>)
c0d01900:	6008      	str	r0, [r1, #0]

    //Parse Transaction type
    signCtx.txType = apdu->p2;
c0d01902:	78e0      	ldrb	r0, [r4, #3]
c0d01904:	4912      	ldr	r1, [pc, #72]	; (c0d01950 <parseSignRawTxData+0x5c>)
c0d01906:	2201      	movs	r2, #1
c0d01908:	700a      	strb	r2, [r1, #0]
c0d0190a:	4912      	ldr	r1, [pc, #72]	; (c0d01954 <parseSignRawTxData+0x60>)
c0d0190c:	7008      	strb	r0, [r1, #0]

    //Parse Raw Tx - This should be the SHA512 hash of the raw transaction created from RPC services (OL Blockchain).
    signCtx.rawTxLen = 64;
    signCtx.rawTx = &apdu->cData[RAW_TX_OFFSET];
c0d0190e:	68a1      	ldr	r1, [r4, #8]
c0d01910:	1d0a      	adds	r2, r1, #4
c0d01912:	4b11      	ldr	r3, [pc, #68]	; (c0d01958 <parseSignRawTxData+0x64>)
c0d01914:	601a      	str	r2, [r3, #0]

    if (signCtx.txType == TX_TYPE_SEND)
c0d01916:	2801      	cmp	r0, #1
c0d01918:	d117      	bne.n	c0d0194a <parseSignRawTxData+0x56>
    {
        if (apdu->lc >= (TX_FEE_OFFSET + TX_FEE_LEN))
c0d0191a:	88a0      	ldrh	r0, [r4, #4]
c0d0191c:	28c4      	cmp	r0, #196	; 0xc4
c0d0191e:	d314      	bcc.n	c0d0194a <parseSignRawTxData+0x56>
        {
            //set send tx parameters
            os_memmove(sendCtx.amount, &apdu->cData[TX_AMT_OFFSET], TX_AMT_LEN);
c0d01920:	3144      	adds	r1, #68	; 0x44
c0d01922:	4e0e      	ldr	r6, [pc, #56]	; (c0d0195c <parseSignRawTxData+0x68>)
c0d01924:	2520      	movs	r5, #32
c0d01926:	4630      	mov	r0, r6
c0d01928:	462a      	mov	r2, r5
c0d0192a:	f7ff f8c3 	bl	c0d00ab4 <os_memmove>
            os_memmove(sendCtx.recipient, &apdu->cData[TX_REC_OFFSET], TX_REC_LEN);
c0d0192e:	68a1      	ldr	r1, [r4, #8]
c0d01930:	4630      	mov	r0, r6
c0d01932:	3020      	adds	r0, #32
c0d01934:	3164      	adds	r1, #100	; 0x64
c0d01936:	2240      	movs	r2, #64	; 0x40
c0d01938:	f7ff f8bc 	bl	c0d00ab4 <os_memmove>
            os_memmove(sendCtx.fee, &apdu->cData[TX_FEE_OFFSET], TX_FEE_LEN);
c0d0193c:	3660      	adds	r6, #96	; 0x60
c0d0193e:	68a1      	ldr	r1, [r4, #8]
c0d01940:	31a4      	adds	r1, #164	; 0xa4
c0d01942:	4630      	mov	r0, r6
c0d01944:	462a      	mov	r2, r5
c0d01946:	f7ff f8b5 	bl	c0d00ab4 <os_memmove>
        }
    }

}
c0d0194a:	bd70      	pop	{r4, r5, r6, pc}
c0d0194c:	20001d9c 	.word	0x20001d9c
c0d01950:	20001d98 	.word	0x20001d98
c0d01954:	20001da0 	.word	0x20001da0
c0d01958:	20001d94 	.word	0x20001d94
c0d0195c:	20001ca0 	.word	0x20001ca0

c0d01960 <handleSignRawTx>:

void handleSignRawTx(struct apduMessage *apdu, volatile unsigned int *flags, volatile unsigned int *tx)
{
c0d01960:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01962:	b091      	sub	sp, #68	; 0x44
c0d01964:	460c      	mov	r4, r1
c0d01966:	4605      	mov	r5, r0
c0d01968:	2600      	movs	r6, #0
    unsigned int info = 0;
c0d0196a:	9610      	str	r6, [sp, #64]	; 0x40
    cx_ecfp_private_key_t privateKey;
    size_t mpi_size = sizeof(signature);

    //Get private key using CX_CURVE_Ed25519
    getPrivateKey(signCtx.accountNumber, &privateKey);
c0d0196c:	481c      	ldr	r0, [pc, #112]	; (c0d019e0 <handleSignRawTx+0x80>)
c0d0196e:	6800      	ldr	r0, [r0, #0]
c0d01970:	af06      	add	r7, sp, #24
c0d01972:	4639      	mov	r1, r7
c0d01974:	f001 fef2 	bl	c0d0375c <getPrivateKey>

    //Get deterministic Signature of SHA512 hash of the Raw Tx.
    sizeOfSignature = cx_eddsa_sign(&privateKey, 0, CX_SHA512, signCtx.rawTx, signCtx.rawTxLen, NULL, 0, signature, mpi_size, &info);
c0d01978:	481a      	ldr	r0, [pc, #104]	; (c0d019e4 <handleSignRawTx+0x84>)
c0d0197a:	6803      	ldr	r3, [r0, #0]
c0d0197c:	481a      	ldr	r0, [pc, #104]	; (c0d019e8 <handleSignRawTx+0x88>)
c0d0197e:	7800      	ldrb	r0, [r0, #0]
c0d01980:	aa10      	add	r2, sp, #64	; 0x40
c0d01982:	4669      	mov	r1, sp
c0d01984:	614a      	str	r2, [r1, #20]
c0d01986:	2272      	movs	r2, #114	; 0x72
c0d01988:	610a      	str	r2, [r1, #16]
c0d0198a:	4a18      	ldr	r2, [pc, #96]	; (c0d019ec <handleSignRawTx+0x8c>)
c0d0198c:	60ca      	str	r2, [r1, #12]
c0d0198e:	608e      	str	r6, [r1, #8]
c0d01990:	604e      	str	r6, [r1, #4]
c0d01992:	2240      	movs	r2, #64	; 0x40
c0d01994:	2800      	cmp	r0, #0
c0d01996:	d100      	bne.n	c0d0199a <handleSignRawTx+0x3a>
c0d01998:	4602      	mov	r2, r0
c0d0199a:	600a      	str	r2, [r1, #0]
c0d0199c:	2205      	movs	r2, #5
c0d0199e:	4638      	mov	r0, r7
c0d019a0:	4631      	mov	r1, r6
c0d019a2:	f000 f891 	bl	c0d01ac8 <cx_eddsa_sign>
c0d019a6:	4912      	ldr	r1, [pc, #72]	; (c0d019f0 <handleSignRawTx+0x90>)
c0d019a8:	7008      	strb	r0, [r1, #0]
c0d019aa:	2228      	movs	r2, #40	; 0x28

    //Clear memory of Private key data.
    os_memset(&privateKey, 0, sizeof(cx_ecfp_private_key_t));
c0d019ac:	4638      	mov	r0, r7
c0d019ae:	4631      	mov	r1, r6
c0d019b0:	f7ff f896 	bl	c0d00ae0 <os_memset>

    //Register User interface flow for the signature process.
    if (signCtx.txType == TX_TYPE_SEND && apdu->lc >= (TX_FEE_OFFSET + TX_FEE_LEN))
c0d019b4:	480f      	ldr	r0, [pc, #60]	; (c0d019f4 <handleSignRawTx+0x94>)
c0d019b6:	7800      	ldrb	r0, [r0, #0]
c0d019b8:	2801      	cmp	r0, #1
c0d019ba:	d105      	bne.n	c0d019c8 <handleSignRawTx+0x68>
c0d019bc:	88a8      	ldrh	r0, [r5, #4]
c0d019be:	28c4      	cmp	r0, #196	; 0xc4
c0d019c0:	d302      	bcc.n	c0d019c8 <handleSignRawTx+0x68>
    {
        //If Transaction type is "send" and length of data received meets expectations.
        ux_flow_init(0, ux_display_send_flow, NULL);
c0d019c2:	490d      	ldr	r1, [pc, #52]	; (c0d019f8 <handleSignRawTx+0x98>)
c0d019c4:	4479      	add	r1, pc
c0d019c6:	e001      	b.n	c0d019cc <handleSignRawTx+0x6c>
    }
    else
        ux_flow_init(0, ux_display_sign_flow, NULL);
c0d019c8:	490c      	ldr	r1, [pc, #48]	; (c0d019fc <handleSignRawTx+0x9c>)
c0d019ca:	4479      	add	r1, pc
c0d019cc:	2000      	movs	r0, #0
c0d019ce:	4602      	mov	r2, r0
c0d019d0:	f002 f886 	bl	c0d03ae0 <ux_flow_init>

    //Set flags to indicate that user input is required to continue.
    *flags |= IO_ASYNCH_REPLY;
c0d019d4:	6820      	ldr	r0, [r4, #0]
c0d019d6:	2110      	movs	r1, #16
c0d019d8:	4301      	orrs	r1, r0
c0d019da:	6021      	str	r1, [r4, #0]
}
c0d019dc:	b011      	add	sp, #68	; 0x44
c0d019de:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d019e0:	20001d9c 	.word	0x20001d9c
c0d019e4:	20001d94 	.word	0x20001d94
c0d019e8:	20001d98 	.word	0x20001d98
c0d019ec:	20001d20 	.word	0x20001d20
c0d019f0:	20001d92 	.word	0x20001d92
c0d019f4:	20001da0 	.word	0x20001da0
c0d019f8:	00003230 	.word	0x00003230
c0d019fc:	0000321a 	.word	0x0000321a

c0d01a00 <SVC_Call>:

// avoid a separate asm file, but avoid any intrusion from the compiler
__attribute__((naked)) void SVC_Call(unsigned int syscall_id, volatile unsigned int * parameters);
__attribute__((naked)) void SVC_Call(__attribute__((unused)) unsigned int syscall_id, __attribute__((unused)) volatile unsigned int * parameters) {
  // delegate svc, ensure no optimization by gcc with naked and r0, r1 marked as clobbered
  asm volatile("svc #1":::"r0","r1");
c0d01a00:	df01      	svc	1
  asm volatile("bx  lr");
c0d01a02:	4770      	bx	lr

c0d01a04 <check_api_level>:
}
void check_api_level ( unsigned int apiLevel ) 
{
c0d01a04:	b580      	push	{r7, lr}
c0d01a06:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
  parameters[0] = (unsigned int)apiLevel;
c0d01a08:	9001      	str	r0, [sp, #4]
c0d01a0a:	4803      	ldr	r0, [pc, #12]	; (c0d01a18 <check_api_level+0x14>)
c0d01a0c:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
c0d01a0e:	f7ff fff7 	bl	c0d01a00 <SVC_Call>
}
c0d01a12:	b004      	add	sp, #16
c0d01a14:	bd80      	pop	{r7, pc}
c0d01a16:	46c0      	nop			; (mov r8, r8)
c0d01a18:	60000137 	.word	0x60000137

c0d01a1c <halt>:

void halt ( void ) 
{
c0d01a1c:	b580      	push	{r7, lr}
c0d01a1e:	b082      	sub	sp, #8
c0d01a20:	4802      	ldr	r0, [pc, #8]	; (c0d01a2c <halt+0x10>)
c0d01a22:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
  SVC_Call(SYSCALL_halt_ID_IN, parameters);
c0d01a24:	f7ff ffec 	bl	c0d01a00 <SVC_Call>
}
c0d01a28:	b002      	add	sp, #8
c0d01a2a:	bd80      	pop	{r7, pc}
c0d01a2c:	6000023c 	.word	0x6000023c

c0d01a30 <nvm_write>:

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d01a30:	b580      	push	{r7, lr}
c0d01a32:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)dst_adr;
c0d01a34:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)src_adr;
c0d01a36:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)src_len;
c0d01a38:	9203      	str	r2, [sp, #12]
c0d01a3a:	4803      	ldr	r0, [pc, #12]	; (c0d01a48 <nvm_write+0x18>)
c0d01a3c:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_nvm_write_ID_IN, parameters);
c0d01a3e:	f7ff ffdf 	bl	c0d01a00 <SVC_Call>
}
c0d01a42:	b006      	add	sp, #24
c0d01a44:	bd80      	pop	{r7, pc}
c0d01a46:	46c0      	nop			; (mov r8, r8)
c0d01a48:	6000037f 	.word	0x6000037f

c0d01a4c <cx_rng>:
  SVC_Call(SYSCALL_cx_rng_u8_ID_IN, parameters);
  return (unsigned char)(((volatile unsigned int*)parameters)[1]);
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01a4c:	b580      	push	{r7, lr}
c0d01a4e:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
c0d01a50:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)len;
c0d01a52:	9101      	str	r1, [sp, #4]
c0d01a54:	4803      	ldr	r0, [pc, #12]	; (c0d01a64 <cx_rng+0x18>)
c0d01a56:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_rng_ID_IN, parameters);
c0d01a58:	f7ff ffd2 	bl	c0d01a00 <SVC_Call>
  return (unsigned char *)(((volatile unsigned int*)parameters)[1]);
c0d01a5c:	9801      	ldr	r0, [sp, #4]
c0d01a5e:	b004      	add	sp, #16
c0d01a60:	bd80      	pop	{r7, pc}
c0d01a62:	46c0      	nop			; (mov r8, r8)
c0d01a64:	6000052c 	.word	0x6000052c

c0d01a68 <cx_hash_sha256>:
  SVC_Call(SYSCALL_cx_sha256_init_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_hash_sha256 ( const unsigned char * in, unsigned int len, unsigned char * out, unsigned int out_len ) 
{
c0d01a68:	b580      	push	{r7, lr}
c0d01a6a:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+4];
  parameters[0] = (unsigned int)in;
c0d01a6c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)len;
c0d01a6e:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)out;
c0d01a70:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)out_len;
c0d01a72:	9303      	str	r3, [sp, #12]
c0d01a74:	4803      	ldr	r0, [pc, #12]	; (c0d01a84 <cx_hash_sha256+0x1c>)
c0d01a76:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_hash_sha256_ID_IN, parameters);
c0d01a78:	f7ff ffc2 	bl	c0d01a00 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d01a7c:	9801      	ldr	r0, [sp, #4]
c0d01a7e:	b006      	add	sp, #24
c0d01a80:	bd80      	pop	{r7, pc}
c0d01a82:	46c0      	nop			; (mov r8, r8)
c0d01a84:	60000b2c 	.word	0x60000b2c

c0d01a88 <cx_ecfp_init_private_key>:
  SVC_Call(SYSCALL_cx_ecfp_init_public_key_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_ecfp_init_private_key ( cx_curve_t curve, const unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * pvkey ) 
{
c0d01a88:	b580      	push	{r7, lr}
c0d01a8a:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+4];
  parameters[0] = (unsigned int)curve;
c0d01a8c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)rawkey;
c0d01a8e:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)key_len;
c0d01a90:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)pvkey;
c0d01a92:	9303      	str	r3, [sp, #12]
c0d01a94:	4803      	ldr	r0, [pc, #12]	; (c0d01aa4 <cx_ecfp_init_private_key+0x1c>)
c0d01a96:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_ecfp_init_private_key_ID_IN, parameters);
c0d01a98:	f7ff ffb2 	bl	c0d01a00 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d01a9c:	9801      	ldr	r0, [sp, #4]
c0d01a9e:	b006      	add	sp, #24
c0d01aa0:	bd80      	pop	{r7, pc}
c0d01aa2:	46c0      	nop			; (mov r8, r8)
c0d01aa4:	60002eea 	.word	0x60002eea

c0d01aa8 <cx_ecfp_generate_pair>:
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d01aa8:	b580      	push	{r7, lr}
c0d01aaa:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+4];
  parameters[0] = (unsigned int)curve;
c0d01aac:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)pubkey;
c0d01aae:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)privkey;
c0d01ab0:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)keepprivate;
c0d01ab2:	9303      	str	r3, [sp, #12]
c0d01ab4:	4803      	ldr	r0, [pc, #12]	; (c0d01ac4 <cx_ecfp_generate_pair+0x1c>)
c0d01ab6:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_ecfp_generate_pair_ID_IN, parameters);
c0d01ab8:	f7ff ffa2 	bl	c0d01a00 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d01abc:	9801      	ldr	r0, [sp, #4]
c0d01abe:	b006      	add	sp, #24
c0d01ac0:	bd80      	pop	{r7, pc}
c0d01ac2:	46c0      	nop			; (mov r8, r8)
c0d01ac4:	60002f2e 	.word	0x60002f2e

c0d01ac8 <cx_eddsa_sign>:
  parameters[6] = (unsigned int)h_len;
  SVC_Call(SYSCALL_cx_eddsa_get_public_key_ID_IN, parameters);
}

int cx_eddsa_sign ( const cx_ecfp_private_key_t * pvkey, int mode, cx_md_t hashID, const unsigned char * hash, unsigned int hash_len, const unsigned char * ctx, unsigned int ctx_len, unsigned char * sig, unsigned int sig_len, unsigned int * info ) 
{
c0d01ac8:	b580      	push	{r7, lr}
c0d01aca:	b08c      	sub	sp, #48	; 0x30
  volatile unsigned int parameters [2+10];
  parameters[0] = (unsigned int)pvkey;
c0d01acc:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)mode;
c0d01ace:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)hashID;
c0d01ad0:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)hash;
c0d01ad2:	9303      	str	r3, [sp, #12]
c0d01ad4:	980e      	ldr	r0, [sp, #56]	; 0x38
  parameters[4] = (unsigned int)hash_len;
c0d01ad6:	9004      	str	r0, [sp, #16]
c0d01ad8:	980f      	ldr	r0, [sp, #60]	; 0x3c
  parameters[5] = (unsigned int)ctx;
c0d01ada:	9005      	str	r0, [sp, #20]
c0d01adc:	9810      	ldr	r0, [sp, #64]	; 0x40
  parameters[6] = (unsigned int)ctx_len;
c0d01ade:	9006      	str	r0, [sp, #24]
c0d01ae0:	9811      	ldr	r0, [sp, #68]	; 0x44
  parameters[7] = (unsigned int)sig;
c0d01ae2:	9007      	str	r0, [sp, #28]
c0d01ae4:	9812      	ldr	r0, [sp, #72]	; 0x48
  parameters[8] = (unsigned int)sig_len;
c0d01ae6:	9008      	str	r0, [sp, #32]
c0d01ae8:	9813      	ldr	r0, [sp, #76]	; 0x4c
  parameters[9] = (unsigned int)info;
c0d01aea:	9009      	str	r0, [sp, #36]	; 0x24
c0d01aec:	4803      	ldr	r0, [pc, #12]	; (c0d01afc <cx_eddsa_sign+0x34>)
c0d01aee:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_eddsa_sign_ID_IN, parameters);
c0d01af0:	f7ff ff86 	bl	c0d01a00 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d01af4:	9801      	ldr	r0, [sp, #4]
c0d01af6:	b00c      	add	sp, #48	; 0x30
c0d01af8:	bd80      	pop	{r7, pc}
c0d01afa:	46c0      	nop			; (mov r8, r8)
c0d01afc:	6000363b 	.word	0x6000363b

c0d01b00 <cx_crc16_update>:
  SVC_Call(SYSCALL_cx_crc16_ID_IN, parameters);
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
}

unsigned short cx_crc16_update ( unsigned short crc, const void * buffer, size_t len ) 
{
c0d01b00:	b580      	push	{r7, lr}
c0d01b02:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)crc;
c0d01b04:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)buffer;
c0d01b06:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)len;
c0d01b08:	9203      	str	r2, [sp, #12]
c0d01b0a:	4804      	ldr	r0, [pc, #16]	; (c0d01b1c <cx_crc16_update+0x1c>)
c0d01b0c:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_cx_crc16_update_ID_IN, parameters);
c0d01b0e:	f7ff ff77 	bl	c0d01a00 <SVC_Call>
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
c0d01b12:	9802      	ldr	r0, [sp, #8]
c0d01b14:	b280      	uxth	r0, r0
c0d01b16:	b006      	add	sp, #24
c0d01b18:	bd80      	pop	{r7, pc}
c0d01b1a:	46c0      	nop			; (mov r8, r8)
c0d01b1c:	6000926e 	.word	0x6000926e

c0d01b20 <os_perso_isonboarded>:
  volatile unsigned int parameters [2];
  SVC_Call(SYSCALL_os_perso_finalize_ID_IN, parameters);
}

bolos_bool_t os_perso_isonboarded ( void ) 
{
c0d01b20:	b580      	push	{r7, lr}
c0d01b22:	b082      	sub	sp, #8
c0d01b24:	4803      	ldr	r0, [pc, #12]	; (c0d01b34 <os_perso_isonboarded+0x14>)
c0d01b26:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_perso_isonboarded_ID_IN, parameters);
c0d01b28:	f7ff ff6a 	bl	c0d01a00 <SVC_Call>
  return (bolos_bool_t)(((volatile unsigned int*)parameters)[1]);
c0d01b2c:	9801      	ldr	r0, [sp, #4]
c0d01b2e:	b2c0      	uxtb	r0, r0
c0d01b30:	b002      	add	sp, #8
c0d01b32:	bd80      	pop	{r7, pc}
c0d01b34:	60009f4f 	.word	0x60009f4f

c0d01b38 <os_perso_derive_node_with_seed_key>:
  parameters[4] = (unsigned int)chain;
  SVC_Call(SYSCALL_os_perso_derive_node_bip32_ID_IN, parameters);
}

void os_perso_derive_node_with_seed_key ( unsigned int mode, cx_curve_t curve, const unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain, unsigned char * seed_key, unsigned int seed_key_length ) 
{
c0d01b38:	b580      	push	{r7, lr}
c0d01b3a:	b08a      	sub	sp, #40	; 0x28
  volatile unsigned int parameters [2+8];
  parameters[0] = (unsigned int)mode;
c0d01b3c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)curve;
c0d01b3e:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)path;
c0d01b40:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)pathLength;
c0d01b42:	9303      	str	r3, [sp, #12]
c0d01b44:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[4] = (unsigned int)privateKey;
c0d01b46:	9004      	str	r0, [sp, #16]
c0d01b48:	980d      	ldr	r0, [sp, #52]	; 0x34
  parameters[5] = (unsigned int)chain;
c0d01b4a:	9005      	str	r0, [sp, #20]
c0d01b4c:	980e      	ldr	r0, [sp, #56]	; 0x38
  parameters[6] = (unsigned int)seed_key;
c0d01b4e:	9006      	str	r0, [sp, #24]
c0d01b50:	980f      	ldr	r0, [sp, #60]	; 0x3c
  parameters[7] = (unsigned int)seed_key_length;
c0d01b52:	9007      	str	r0, [sp, #28]
c0d01b54:	4802      	ldr	r0, [pc, #8]	; (c0d01b60 <os_perso_derive_node_with_seed_key+0x28>)
c0d01b56:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_perso_derive_node_with_seed_key_ID_IN, parameters);
c0d01b58:	f7ff ff52 	bl	c0d01a00 <SVC_Call>
}
c0d01b5c:	b00a      	add	sp, #40	; 0x28
c0d01b5e:	bd80      	pop	{r7, pc}
c0d01b60:	6000a6d8 	.word	0x6000a6d8

c0d01b64 <os_perso_seed_cookie>:

unsigned int os_perso_seed_cookie ( unsigned char * seed_cookie, unsigned int seed_cookie_length ) 
{
c0d01b64:	b580      	push	{r7, lr}
c0d01b66:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)seed_cookie;
c0d01b68:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)seed_cookie_length;
c0d01b6a:	9101      	str	r1, [sp, #4]
c0d01b6c:	4803      	ldr	r0, [pc, #12]	; (c0d01b7c <os_perso_seed_cookie+0x18>)
c0d01b6e:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_perso_seed_cookie_ID_IN, parameters);
c0d01b70:	f7ff ff46 	bl	c0d01a00 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01b74:	9801      	ldr	r0, [sp, #4]
c0d01b76:	b004      	add	sp, #16
c0d01b78:	bd80      	pop	{r7, pc}
c0d01b7a:	46c0      	nop			; (mov r8, r8)
c0d01b7c:	6000a8fc 	.word	0x6000a8fc

c0d01b80 <os_global_pin_is_validated>:
  SVC_Call(SYSCALL_os_endorsement_key2_derive_sign_data_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

bolos_bool_t os_global_pin_is_validated ( void ) 
{
c0d01b80:	b580      	push	{r7, lr}
c0d01b82:	b082      	sub	sp, #8
c0d01b84:	4803      	ldr	r0, [pc, #12]	; (c0d01b94 <os_global_pin_is_validated+0x14>)
c0d01b86:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_global_pin_is_validated_ID_IN, parameters);
c0d01b88:	f7ff ff3a 	bl	c0d01a00 <SVC_Call>
  return (bolos_bool_t)(((volatile unsigned int*)parameters)[1]);
c0d01b8c:	9801      	ldr	r0, [sp, #4]
c0d01b8e:	b2c0      	uxtb	r0, r0
c0d01b90:	b002      	add	sp, #8
c0d01b92:	bd80      	pop	{r7, pc}
c0d01b94:	6000a03c 	.word	0x6000a03c

c0d01b98 <os_ux>:
  parameters[1] = (unsigned int)out_application_entry;
  SVC_Call(SYSCALL_os_registry_get_ID_IN, parameters);
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d01b98:	b580      	push	{r7, lr}
c0d01b9a:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)params;
c0d01b9c:	9001      	str	r0, [sp, #4]
c0d01b9e:	4803      	ldr	r0, [pc, #12]	; (c0d01bac <os_ux+0x14>)
c0d01ba0:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
c0d01ba2:	f7ff ff2d 	bl	c0d01a00 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01ba6:	9802      	ldr	r0, [sp, #8]
c0d01ba8:	b004      	add	sp, #16
c0d01baa:	bd80      	pop	{r7, pc}
c0d01bac:	60006458 	.word	0x60006458

c0d01bb0 <os_flags>:
  parameters[0] = (unsigned int)exception;
  SVC_Call(SYSCALL_os_lib_throw_ID_IN, parameters);
}

unsigned int os_flags ( void ) 
{
c0d01bb0:	b580      	push	{r7, lr}
c0d01bb2:	b082      	sub	sp, #8
c0d01bb4:	4803      	ldr	r0, [pc, #12]	; (c0d01bc4 <os_flags+0x14>)
c0d01bb6:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
c0d01bb8:	f7ff ff22 	bl	c0d01a00 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01bbc:	9801      	ldr	r0, [sp, #4]
c0d01bbe:	b002      	add	sp, #8
c0d01bc0:	bd80      	pop	{r7, pc}
c0d01bc2:	46c0      	nop			; (mov r8, r8)
c0d01bc4:	60006a6e 	.word	0x60006a6e

c0d01bc8 <os_registry_get_current_app_tag>:
  SVC_Call(SYSCALL_os_registry_get_tag_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

unsigned int os_registry_get_current_app_tag ( unsigned int tag, unsigned char * buffer, unsigned int maxlen ) 
{
c0d01bc8:	b580      	push	{r7, lr}
c0d01bca:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)tag;
c0d01bcc:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)buffer;
c0d01bce:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)maxlen;
c0d01bd0:	9203      	str	r2, [sp, #12]
c0d01bd2:	4803      	ldr	r0, [pc, #12]	; (c0d01be0 <os_registry_get_current_app_tag+0x18>)
c0d01bd4:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
c0d01bd6:	f7ff ff13 	bl	c0d01a00 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01bda:	9802      	ldr	r0, [sp, #8]
c0d01bdc:	b006      	add	sp, #24
c0d01bde:	bd80      	pop	{r7, pc}
c0d01be0:	600074d4 	.word	0x600074d4

c0d01be4 <os_sched_exit>:
  parameters[0] = (unsigned int)application_index;
  SVC_Call(SYSCALL_os_sched_exec_ID_IN, parameters);
}

void os_sched_exit ( bolos_task_status_t exit_code ) 
{
c0d01be4:	b580      	push	{r7, lr}
c0d01be6:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
  parameters[0] = (unsigned int)exit_code;
c0d01be8:	9001      	str	r0, [sp, #4]
c0d01bea:	4803      	ldr	r0, [pc, #12]	; (c0d01bf8 <os_sched_exit+0x14>)
c0d01bec:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d01bee:	f7ff ff07 	bl	c0d01a00 <SVC_Call>
}
c0d01bf2:	b004      	add	sp, #16
c0d01bf4:	bd80      	pop	{r7, pc}
c0d01bf6:	46c0      	nop			; (mov r8, r8)
c0d01bf8:	60009abe 	.word	0x60009abe

c0d01bfc <io_seph_send>:
  parameters[0] = (unsigned int)taskidx;
  SVC_Call(SYSCALL_os_sched_kill_ID_IN, parameters);
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01bfc:	b580      	push	{r7, lr}
c0d01bfe:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
c0d01c00:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)length;
c0d01c02:	9101      	str	r1, [sp, #4]
c0d01c04:	4802      	ldr	r0, [pc, #8]	; (c0d01c10 <io_seph_send+0x14>)
c0d01c06:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_io_seph_send_ID_IN, parameters);
c0d01c08:	f7ff fefa 	bl	c0d01a00 <SVC_Call>
}
c0d01c0c:	b004      	add	sp, #16
c0d01c0e:	bd80      	pop	{r7, pc}
c0d01c10:	60008381 	.word	0x60008381

c0d01c14 <io_seph_is_status_sent>:

unsigned int io_seph_is_status_sent ( void ) 
{
c0d01c14:	b580      	push	{r7, lr}
c0d01c16:	b082      	sub	sp, #8
c0d01c18:	4803      	ldr	r0, [pc, #12]	; (c0d01c28 <io_seph_is_status_sent+0x14>)
c0d01c1a:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_io_seph_is_status_sent_ID_IN, parameters);
c0d01c1c:	f7ff fef0 	bl	c0d01a00 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d01c20:	9801      	ldr	r0, [sp, #4]
c0d01c22:	b002      	add	sp, #8
c0d01c24:	bd80      	pop	{r7, pc}
c0d01c26:	46c0      	nop			; (mov r8, r8)
c0d01c28:	600084bb 	.word	0x600084bb

c0d01c2c <io_seph_recv>:
}

unsigned short io_seph_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01c2c:	b580      	push	{r7, lr}
c0d01c2e:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)buffer;
c0d01c30:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)maxlength;
c0d01c32:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)flags;
c0d01c34:	9203      	str	r2, [sp, #12]
c0d01c36:	4804      	ldr	r0, [pc, #16]	; (c0d01c48 <io_seph_recv+0x1c>)
c0d01c38:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_io_seph_recv_ID_IN, parameters);
c0d01c3a:	f7ff fee1 	bl	c0d01a00 <SVC_Call>
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
c0d01c3e:	9802      	ldr	r0, [sp, #8]
c0d01c40:	b280      	uxth	r0, r0
c0d01c42:	b006      	add	sp, #24
c0d01c44:	bd80      	pop	{r7, pc}
c0d01c46:	46c0      	nop			; (mov r8, r8)
c0d01c48:	600085e4 	.word	0x600085e4

c0d01c4c <try_context_get>:
  parameters[0] = (unsigned int)page_adr;
  SVC_Call(SYSCALL_nvm_write_page_ID_IN, parameters);
}

try_context_t * try_context_get ( void ) 
{
c0d01c4c:	b580      	push	{r7, lr}
c0d01c4e:	b082      	sub	sp, #8
c0d01c50:	4803      	ldr	r0, [pc, #12]	; (c0d01c60 <try_context_get+0x14>)
c0d01c52:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_try_context_get_ID_IN, parameters);
c0d01c54:	f7ff fed4 	bl	c0d01a00 <SVC_Call>
  return (try_context_t *)(((volatile unsigned int*)parameters)[1]);
c0d01c58:	9801      	ldr	r0, [sp, #4]
c0d01c5a:	b002      	add	sp, #8
c0d01c5c:	bd80      	pop	{r7, pc}
c0d01c5e:	46c0      	nop			; (mov r8, r8)
c0d01c60:	600087b1 	.word	0x600087b1

c0d01c64 <try_context_set>:
}

try_context_t * try_context_set ( try_context_t * context ) 
{
c0d01c64:	b580      	push	{r7, lr}
c0d01c66:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)context;
c0d01c68:	9001      	str	r0, [sp, #4]
c0d01c6a:	4803      	ldr	r0, [pc, #12]	; (c0d01c78 <try_context_set+0x14>)
c0d01c6c:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_try_context_set_ID_IN, parameters);
c0d01c6e:	f7ff fec7 	bl	c0d01a00 <SVC_Call>
  return (try_context_t *)(((volatile unsigned int*)parameters)[1]);
c0d01c72:	9802      	ldr	r0, [sp, #8]
c0d01c74:	b004      	add	sp, #16
c0d01c76:	bd80      	pop	{r7, pc}
c0d01c78:	60008875 	.word	0x60008875

c0d01c7c <os_sched_last_status>:
  SVC_Call(SYSCALL_cx_rng_u32_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

bolos_task_status_t os_sched_last_status ( unsigned int task_idx ) 
{
c0d01c7c:	b580      	push	{r7, lr}
c0d01c7e:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)task_idx;
c0d01c80:	9001      	str	r0, [sp, #4]
c0d01c82:	4804      	ldr	r0, [pc, #16]	; (c0d01c94 <os_sched_last_status+0x18>)
c0d01c84:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_sched_last_status_ID_IN, parameters);
c0d01c86:	f7ff febb 	bl	c0d01a00 <SVC_Call>
  return (bolos_task_status_t)(((volatile unsigned int*)parameters)[1]);
c0d01c8a:	9802      	ldr	r0, [sp, #8]
c0d01c8c:	b2c0      	uxtb	r0, r0
c0d01c8e:	b004      	add	sp, #16
c0d01c90:	bd80      	pop	{r7, pc}
c0d01c92:	46c0      	nop			; (mov r8, r8)
c0d01c94:	60009c8b 	.word	0x60009c8b

c0d01c98 <u2f_apdu_sign>:

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
}

void u2f_apdu_sign(u2f_service_t *service, uint8_t p1, uint8_t p2,
                     uint8_t *buffer, uint16_t length) {
c0d01c98:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c9a:	b081      	sub	sp, #4
c0d01c9c:	4604      	mov	r4, r0
    UNUSED(p2);
    uint8_t keyHandleLength;
    uint8_t i;

    // can't process the apdu if another one is already scheduled in
    if (G_io_app.apdu_state != APDU_IDLE) {
c0d01c9e:	4834      	ldr	r0, [pc, #208]	; (c0d01d70 <u2f_apdu_sign+0xd8>)
c0d01ca0:	7800      	ldrb	r0, [r0, #0]
c0d01ca2:	2800      	cmp	r0, #0
c0d01ca4:	d003      	beq.n	c0d01cae <u2f_apdu_sign+0x16>
c0d01ca6:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01ca8:	4a33      	ldr	r2, [pc, #204]	; (c0d01d78 <u2f_apdu_sign+0xe0>)
c0d01caa:	447a      	add	r2, pc
c0d01cac:	e045      	b.n	c0d01d3a <u2f_apdu_sign+0xa2>
c0d01cae:	9806      	ldr	r0, [sp, #24]
                  (uint8_t *)SW_BUSY,
                  sizeof(SW_BUSY));
        return;        
    }

    if (length < U2F_HANDLE_SIGN_HEADER_SIZE + 5 /*at least an apdu header*/) {
c0d01cb0:	2845      	cmp	r0, #69	; 0x45
c0d01cb2:	d803      	bhi.n	c0d01cbc <u2f_apdu_sign+0x24>
c0d01cb4:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01cb6:	4a31      	ldr	r2, [pc, #196]	; (c0d01d7c <u2f_apdu_sign+0xe4>)
c0d01cb8:	447a      	add	r2, pc
c0d01cba:	e03e      	b.n	c0d01d3a <u2f_apdu_sign+0xa2>
                  sizeof(SW_WRONG_LENGTH));
        return;
    }

    // Confirm immediately if it's just a validation call
    if (p1 == P1_SIGN_CHECK_ONLY) {
c0d01cbc:	2907      	cmp	r1, #7
c0d01cbe:	d103      	bne.n	c0d01cc8 <u2f_apdu_sign+0x30>
c0d01cc0:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01cc2:	4a2f      	ldr	r2, [pc, #188]	; (c0d01d80 <u2f_apdu_sign+0xe8>)
c0d01cc4:	447a      	add	r2, pc
c0d01cc6:	e038      	b.n	c0d01d3a <u2f_apdu_sign+0xa2>
c0d01cc8:	461d      	mov	r5, r3
c0d01cca:	9000      	str	r0, [sp, #0]
c0d01ccc:	2040      	movs	r0, #64	; 0x40
                  sizeof(SW_PROOF_OF_PRESENCE_REQUIRED));
        return;
    }

    // Unwrap magic
    keyHandleLength = buffer[U2F_HANDLE_SIGN_HEADER_SIZE-1];
c0d01cce:	5c1e      	ldrb	r6, [r3, r0]
    
    // reply to the "get magic" question of the host
    if (keyHandleLength == 5) {
c0d01cd0:	2e00      	cmp	r6, #0
c0d01cd2:	d018      	beq.n	c0d01d06 <u2f_apdu_sign+0x6e>
c0d01cd4:	2e05      	cmp	r6, #5
c0d01cd6:	d108      	bne.n	c0d01cea <u2f_apdu_sign+0x52>
        // GET U2F PROXY PARAMETERS
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
c0d01cd8:	4628      	mov	r0, r5
c0d01cda:	3041      	adds	r0, #65	; 0x41
c0d01cdc:	4929      	ldr	r1, [pc, #164]	; (c0d01d84 <u2f_apdu_sign+0xec>)
c0d01cde:	4479      	add	r1, pc
c0d01ce0:	2205      	movs	r2, #5
c0d01ce2:	f7fe ff06 	bl	c0d00af2 <os_memcmp>
c0d01ce6:	2800      	cmp	r0, #0
c0d01ce8:	d02d      	beq.n	c0d01d46 <u2f_apdu_sign+0xae>
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
c0d01cea:	4628      	mov	r0, r5
c0d01cec:	3041      	adds	r0, #65	; 0x41
c0d01cee:	2100      	movs	r1, #0
c0d01cf0:	4a25      	ldr	r2, [pc, #148]	; (c0d01d88 <u2f_apdu_sign+0xf0>)
c0d01cf2:	447a      	add	r2, pc
c0d01cf4:	5c43      	ldrb	r3, [r0, r1]
c0d01cf6:	2703      	movs	r7, #3
c0d01cf8:	400f      	ands	r7, r1
c0d01cfa:	5dd7      	ldrb	r7, [r2, r7]
c0d01cfc:	405f      	eors	r7, r3
c0d01cfe:	5447      	strb	r7, [r0, r1]
            return;
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
c0d01d00:	1c49      	adds	r1, r1, #1
c0d01d02:	428e      	cmp	r6, r1
c0d01d04:	d1f6      	bne.n	c0d01cf4 <u2f_apdu_sign+0x5c>
c0d01d06:	2045      	movs	r0, #69	; 0x45
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
c0d01d08:	5c28      	ldrb	r0, [r5, r0]
c0d01d0a:	3046      	adds	r0, #70	; 0x46
c0d01d0c:	9900      	ldr	r1, [sp, #0]
c0d01d0e:	4288      	cmp	r0, r1
c0d01d10:	d110      	bne.n	c0d01d34 <u2f_apdu_sign+0x9c>
                  sizeof(SW_BAD_KEY_HANDLE));
        return;
    }

    // make the apdu available to higher layers
    os_memmove(G_io_apdu_buffer, buffer + U2F_HANDLE_SIGN_HEADER_SIZE, keyHandleLength);
c0d01d12:	3541      	adds	r5, #65	; 0x41
c0d01d14:	4817      	ldr	r0, [pc, #92]	; (c0d01d74 <u2f_apdu_sign+0xdc>)
c0d01d16:	4629      	mov	r1, r5
c0d01d18:	4632      	mov	r2, r6
c0d01d1a:	f7fe fecb 	bl	c0d00ab4 <os_memmove>
c0d01d1e:	2007      	movs	r0, #7
c0d01d20:	4913      	ldr	r1, [pc, #76]	; (c0d01d70 <u2f_apdu_sign+0xd8>)
    G_io_app.apdu_length = keyHandleLength;
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
c0d01d22:	7188      	strb	r0, [r1, #6]
        return;
    }

    // make the apdu available to higher layers
    os_memmove(G_io_apdu_buffer, buffer + U2F_HANDLE_SIGN_HEADER_SIZE, keyHandleLength);
    G_io_app.apdu_length = keyHandleLength;
c0d01d24:	804e      	strh	r6, [r1, #2]
c0d01d26:	2009      	movs	r0, #9
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
    G_io_app.apdu_state = APDU_U2F;
c0d01d28:	7008      	strb	r0, [r1, #0]
c0d01d2a:	2101      	movs	r1, #1

    // prepare for asynch reply
    u2f_message_set_autoreply_wait_user_presence(service, true);
c0d01d2c:	4620      	mov	r0, r4
c0d01d2e:	f000 fc57 	bl	c0d025e0 <u2f_message_set_autoreply_wait_user_presence>
c0d01d32:	e006      	b.n	c0d01d42 <u2f_apdu_sign+0xaa>
c0d01d34:	2183      	movs	r1, #131	; 0x83
    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01d36:	4a15      	ldr	r2, [pc, #84]	; (c0d01d8c <u2f_apdu_sign+0xf4>)
c0d01d38:	447a      	add	r2, pc
c0d01d3a:	2302      	movs	r3, #2
c0d01d3c:	4620      	mov	r0, r4
c0d01d3e:	f000 fc63 	bl	c0d02608 <u2f_message_reply>
    app_dispatch();
    if ((btchip_context_D.io_flags & IO_ASYNCH_REPLY) == 0) {
        u2f_proxy_response(service, btchip_context_D.outLength);
    }
    */
}
c0d01d42:	b001      	add	sp, #4
c0d01d44:	bdf0      	pop	{r4, r5, r6, r7, pc}
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
c0d01d46:	4d0b      	ldr	r5, [pc, #44]	; (c0d01d74 <u2f_apdu_sign+0xdc>)
c0d01d48:	2604      	movs	r6, #4
c0d01d4a:	702e      	strb	r6, [r5, #0]
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
c0d01d4c:	1c68      	adds	r0, r5, #1
c0d01d4e:	4910      	ldr	r1, [pc, #64]	; (c0d01d90 <u2f_apdu_sign+0xf8>)
c0d01d50:	4479      	add	r1, pc
c0d01d52:	4632      	mov	r2, r6
c0d01d54:	f7fe feae 	bl	c0d00ab4 <os_memmove>
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
c0d01d58:	1d68      	adds	r0, r5, #5
c0d01d5a:	490e      	ldr	r1, [pc, #56]	; (c0d01d94 <u2f_apdu_sign+0xfc>)
c0d01d5c:	4479      	add	r1, pc
c0d01d5e:	4632      	mov	r2, r6
c0d01d60:	f7fe fea8 	bl	c0d00ab4 <os_memmove>
            u2f_message_reply(service, U2F_CMD_MSG,
                              (uint8_t *)G_io_apdu_buffer,
                              G_io_apdu_buffer[0]+1+2+2);
c0d01d64:	7828      	ldrb	r0, [r5, #0]
c0d01d66:	1d43      	adds	r3, r0, #5
c0d01d68:	2183      	movs	r1, #131	; 0x83
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
            u2f_message_reply(service, U2F_CMD_MSG,
c0d01d6a:	4620      	mov	r0, r4
c0d01d6c:	462a      	mov	r2, r5
c0d01d6e:	e7e6      	b.n	c0d01d3e <u2f_apdu_sign+0xa6>
c0d01d70:	20001be0 	.word	0x20001be0
c0d01d74:	20001a8e 	.word	0x20001a8e
c0d01d78:	00002f68 	.word	0x00002f68
c0d01d7c:	00002f5c 	.word	0x00002f5c
c0d01d80:	00002f52 	.word	0x00002f52
c0d01d84:	00002f3a 	.word	0x00002f3a
c0d01d88:	00002f2c 	.word	0x00002f2c
c0d01d8c:	00002ef0 	.word	0x00002ef0
c0d01d90:	00002ece 	.word	0x00002ece
c0d01d94:	00002ec7 	.word	0x00002ec7

c0d01d98 <u2f_handle_cmd_init>:
}

#endif // U2F_PROXY_MAGIC

void u2f_handle_cmd_init(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length, uint8_t *channelInit) {
c0d01d98:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01d9a:	b081      	sub	sp, #4
c0d01d9c:	461d      	mov	r5, r3
c0d01d9e:	460e      	mov	r6, r1
c0d01da0:	4604      	mov	r4, r0
    // screen_printf("U2F init\n");
    uint8_t channel[4];
    (void)length;
    if (u2f_is_channel_broadcast(channelInit)) {
c0d01da2:	4618      	mov	r0, r3
c0d01da4:	f000 fc10 	bl	c0d025c8 <u2f_is_channel_broadcast>
c0d01da8:	2800      	cmp	r0, #0
c0d01daa:	d00e      	beq.n	c0d01dca <u2f_handle_cmd_init+0x32>
        // cx_rng(channel, 4); // not available within the IO task
        U4BE_ENCODE(channel, 0, ++service->next_channel);
c0d01dac:	6820      	ldr	r0, [r4, #0]
c0d01dae:	1cc1      	adds	r1, r0, #3
c0d01db0:	0a09      	lsrs	r1, r1, #8
c0d01db2:	466a      	mov	r2, sp
c0d01db4:	7091      	strb	r1, [r2, #2]
c0d01db6:	1c81      	adds	r1, r0, #2
c0d01db8:	0c09      	lsrs	r1, r1, #16
c0d01dba:	7051      	strb	r1, [r2, #1]
c0d01dbc:	1c41      	adds	r1, r0, #1
c0d01dbe:	0e09      	lsrs	r1, r1, #24
c0d01dc0:	7011      	strb	r1, [r2, #0]
c0d01dc2:	1d00      	adds	r0, r0, #4
c0d01dc4:	6020      	str	r0, [r4, #0]
c0d01dc6:	70d0      	strb	r0, [r2, #3]
c0d01dc8:	e004      	b.n	c0d01dd4 <u2f_handle_cmd_init+0x3c>
c0d01dca:	4668      	mov	r0, sp
c0d01dcc:	2204      	movs	r2, #4
    } else {
        os_memmove(channel, channelInit, 4);
c0d01dce:	4629      	mov	r1, r5
c0d01dd0:	f7fe fe70 	bl	c0d00ab4 <os_memmove>
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
c0d01dd4:	4f17      	ldr	r7, [pc, #92]	; (c0d01e34 <u2f_handle_cmd_init+0x9c>)
c0d01dd6:	2208      	movs	r2, #8
c0d01dd8:	4638      	mov	r0, r7
c0d01dda:	4631      	mov	r1, r6
c0d01ddc:	f7fe fe6a 	bl	c0d00ab4 <os_memmove>
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
c0d01de0:	4638      	mov	r0, r7
c0d01de2:	3008      	adds	r0, #8
c0d01de4:	4669      	mov	r1, sp
c0d01de6:	2204      	movs	r2, #4
c0d01de8:	f7fe fe64 	bl	c0d00ab4 <os_memmove>
c0d01dec:	2000      	movs	r0, #0
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
c0d01dee:	7378      	strb	r0, [r7, #13]
c0d01df0:	2102      	movs	r1, #2
    } else {
        os_memmove(channel, channelInit, 4);
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
c0d01df2:	7339      	strb	r1, [r7, #12]
c0d01df4:	2101      	movs	r1, #1
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
c0d01df6:	73b9      	strb	r1, [r7, #14]
    G_io_apdu_buffer[15] = INIT_BUILD_VERSION;
c0d01df8:	73f8      	strb	r0, [r7, #15]
    G_io_apdu_buffer[16] = INIT_CAPABILITIES;
c0d01dfa:	7438      	strb	r0, [r7, #16]

    if (u2f_is_channel_broadcast(channelInit)) {
c0d01dfc:	4628      	mov	r0, r5
c0d01dfe:	f000 fbe3 	bl	c0d025c8 <u2f_is_channel_broadcast>
c0d01e02:	4601      	mov	r1, r0
c0d01e04:	1d20      	adds	r0, r4, #4
c0d01e06:	2586      	movs	r5, #134	; 0x86
c0d01e08:	2900      	cmp	r1, #0
c0d01e0a:	d006      	beq.n	c0d01e1a <u2f_handle_cmd_init+0x82>
        os_memset(service->channel, 0xff, 4);
c0d01e0c:	4629      	mov	r1, r5
c0d01e0e:	3179      	adds	r1, #121	; 0x79
c0d01e10:	b2c9      	uxtb	r1, r1
c0d01e12:	2204      	movs	r2, #4
c0d01e14:	f7fe fe64 	bl	c0d00ae0 <os_memset>
c0d01e18:	e003      	b.n	c0d01e22 <u2f_handle_cmd_init+0x8a>
c0d01e1a:	4669      	mov	r1, sp
c0d01e1c:	2204      	movs	r2, #4
    } else {
        os_memmove(service->channel, channel, 4);
c0d01e1e:	f7fe fe49 	bl	c0d00ab4 <os_memmove>
    }
    u2f_message_reply(service, U2F_CMD_INIT, G_io_apdu_buffer, 17);
c0d01e22:	4a04      	ldr	r2, [pc, #16]	; (c0d01e34 <u2f_handle_cmd_init+0x9c>)
c0d01e24:	2311      	movs	r3, #17
c0d01e26:	4620      	mov	r0, r4
c0d01e28:	4629      	mov	r1, r5
c0d01e2a:	f000 fbed 	bl	c0d02608 <u2f_message_reply>
}
c0d01e2e:	b001      	add	sp, #4
c0d01e30:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01e32:	46c0      	nop			; (mov r8, r8)
c0d01e34:	20001a8e 	.word	0x20001a8e

c0d01e38 <u2f_handle_cmd_msg>:
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
c0d01e38:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01e3a:	b083      	sub	sp, #12
c0d01e3c:	9002      	str	r0, [sp, #8]
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
c0d01e3e:	7988      	ldrb	r0, [r1, #6]
c0d01e40:	794b      	ldrb	r3, [r1, #5]
c0d01e42:	021b      	lsls	r3, r3, #8
c0d01e44:	181f      	adds	r7, r3, r0
void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
c0d01e46:	7888      	ldrb	r0, [r1, #2]

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
c0d01e48:	9001      	str	r0, [sp, #4]
c0d01e4a:	784b      	ldrb	r3, [r1, #1]
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
c0d01e4c:	780e      	ldrb	r6, [r1, #0]
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
c0d01e4e:	4615      	mov	r5, r2
c0d01e50:	3d09      	subs	r5, #9
c0d01e52:	b2ac      	uxth	r4, r5
c0d01e54:	42a7      	cmp	r7, r4
c0d01e56:	d004      	beq.n	c0d01e62 <u2f_handle_cmd_msg+0x2a>
c0d01e58:	1fd0      	subs	r0, r2, #7
c0d01e5a:	1fd2      	subs	r2, r2, #7
c0d01e5c:	b292      	uxth	r2, r2
c0d01e5e:	4297      	cmp	r7, r2
c0d01e60:	d11b      	bne.n	c0d01e9a <u2f_handle_cmd_msg+0x62>
c0d01e62:	463d      	mov	r5, r7
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
    G_io_app.apdu_state = APDU_U2F;

#else // U2F_PROXY_MAGIC

    if (cla != FIDO_CLA) {
c0d01e64:	2e00      	cmp	r6, #0
c0d01e66:	d008      	beq.n	c0d01e7a <u2f_handle_cmd_msg+0x42>
c0d01e68:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01e6a:	4a1c      	ldr	r2, [pc, #112]	; (c0d01edc <u2f_handle_cmd_msg+0xa4>)
c0d01e6c:	447a      	add	r2, pc
c0d01e6e:	2302      	movs	r3, #2
c0d01e70:	9802      	ldr	r0, [sp, #8]
c0d01e72:	f000 fbc9 	bl	c0d02608 <u2f_message_reply>
                 sizeof(SW_UNKNOWN_INSTRUCTION));
        return;
    }

#endif // U2F_PROXY_MAGIC
}
c0d01e76:	b003      	add	sp, #12
c0d01e78:	bdf0      	pop	{r4, r5, r6, r7, pc}
        u2f_message_reply(service, U2F_CMD_MSG,
                  (uint8_t *)SW_UNKNOWN_CLASS,
                  sizeof(SW_UNKNOWN_CLASS));
        return;
    }
    switch (ins) {
c0d01e7a:	2b02      	cmp	r3, #2
c0d01e7c:	dc18      	bgt.n	c0d01eb0 <u2f_handle_cmd_msg+0x78>
c0d01e7e:	2b01      	cmp	r3, #1
c0d01e80:	d023      	beq.n	c0d01eca <u2f_handle_cmd_msg+0x92>
c0d01e82:	2b02      	cmp	r3, #2
c0d01e84:	d11d      	bne.n	c0d01ec2 <u2f_handle_cmd_msg+0x8a>
        // screen_printf("enroll\n");
        u2f_apdu_enroll(service, p1, p2, buffer + 7, dataLength);
        break;
    case FIDO_INS_SIGN:
        // screen_printf("sign\n");
        u2f_apdu_sign(service, p1, p2, buffer + 7, dataLength);
c0d01e86:	b2a8      	uxth	r0, r5
c0d01e88:	466a      	mov	r2, sp
c0d01e8a:	6010      	str	r0, [r2, #0]
c0d01e8c:	1dcb      	adds	r3, r1, #7
c0d01e8e:	2200      	movs	r2, #0
c0d01e90:	9802      	ldr	r0, [sp, #8]
c0d01e92:	9901      	ldr	r1, [sp, #4]
c0d01e94:	f7ff ff00 	bl	c0d01c98 <u2f_apdu_sign>
c0d01e98:	e7ed      	b.n	c0d01e76 <u2f_handle_cmd_msg+0x3e>
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
        // Le is optional
        // nominal case from the specification
    }
    // circumvent google chrome extended length encoding done on the last byte only (module 256) but all data being transferred
    else if (dataLength == (uint16_t)(length - 9)%256) {
c0d01e9a:	b2e4      	uxtb	r4, r4
c0d01e9c:	42a7      	cmp	r7, r4
c0d01e9e:	d0e1      	beq.n	c0d01e64 <u2f_handle_cmd_msg+0x2c>
        dataLength = length - 9;
    }
    else if (dataLength == (uint16_t)(length - 7)%256) {
c0d01ea0:	b2d2      	uxtb	r2, r2
c0d01ea2:	4297      	cmp	r7, r2
c0d01ea4:	4605      	mov	r5, r0
c0d01ea6:	d0dd      	beq.n	c0d01e64 <u2f_handle_cmd_msg+0x2c>
c0d01ea8:	2183      	movs	r1, #131	; 0x83
        dataLength = length - 7;
    }    
    else { 
        // invalid size
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01eaa:	4a0d      	ldr	r2, [pc, #52]	; (c0d01ee0 <u2f_handle_cmd_msg+0xa8>)
c0d01eac:	447a      	add	r2, pc
c0d01eae:	e7de      	b.n	c0d01e6e <u2f_handle_cmd_msg+0x36>
        u2f_message_reply(service, U2F_CMD_MSG,
                  (uint8_t *)SW_UNKNOWN_CLASS,
                  sizeof(SW_UNKNOWN_CLASS));
        return;
    }
    switch (ins) {
c0d01eb0:	2b03      	cmp	r3, #3
c0d01eb2:	d00e      	beq.n	c0d01ed2 <u2f_handle_cmd_msg+0x9a>
c0d01eb4:	2bc1      	cmp	r3, #193	; 0xc1
c0d01eb6:	d104      	bne.n	c0d01ec2 <u2f_handle_cmd_msg+0x8a>
c0d01eb8:	2183      	movs	r1, #131	; 0x83
                            uint8_t *buffer, uint16_t length) {
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)INFO, sizeof(INFO));
c0d01eba:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ee4 <u2f_handle_cmd_msg+0xac>)
c0d01ebc:	447a      	add	r2, pc
c0d01ebe:	2304      	movs	r3, #4
c0d01ec0:	e7d6      	b.n	c0d01e70 <u2f_handle_cmd_msg+0x38>
c0d01ec2:	2183      	movs	r1, #131	; 0x83
        u2f_apdu_get_info(service, p1, p2, buffer + 7, dataLength);
        break;

    default:
        // screen_printf("unsupported\n");
        u2f_message_reply(service, U2F_CMD_MSG,
c0d01ec4:	4a0a      	ldr	r2, [pc, #40]	; (c0d01ef0 <u2f_handle_cmd_msg+0xb8>)
c0d01ec6:	447a      	add	r2, pc
c0d01ec8:	e7d1      	b.n	c0d01e6e <u2f_handle_cmd_msg+0x36>
c0d01eca:	2183      	movs	r1, #131	; 0x83
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
c0d01ecc:	4a06      	ldr	r2, [pc, #24]	; (c0d01ee8 <u2f_handle_cmd_msg+0xb0>)
c0d01ece:	447a      	add	r2, pc
c0d01ed0:	e7cd      	b.n	c0d01e6e <u2f_handle_cmd_msg+0x36>
c0d01ed2:	2183      	movs	r1, #131	; 0x83
    // screen_printf("U2F version\n");
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)U2F_VERSION, sizeof(U2F_VERSION));
c0d01ed4:	4a05      	ldr	r2, [pc, #20]	; (c0d01eec <u2f_handle_cmd_msg+0xb4>)
c0d01ed6:	447a      	add	r2, pc
c0d01ed8:	2308      	movs	r3, #8
c0d01eda:	e7c9      	b.n	c0d01e70 <u2f_handle_cmd_msg+0x38>
c0d01edc:	00002dca 	.word	0x00002dca
c0d01ee0:	00002d68 	.word	0x00002d68
c0d01ee4:	00002d76 	.word	0x00002d76
c0d01ee8:	00002d42 	.word	0x00002d42
c0d01eec:	00002d54 	.word	0x00002d54
c0d01ef0:	00002d72 	.word	0x00002d72

c0d01ef4 <u2f_message_complete>:
    }

#endif // U2F_PROXY_MAGIC
}

void u2f_message_complete(u2f_service_t *service) {
c0d01ef4:	b580      	push	{r7, lr}
    uint8_t cmd = service->transportBuffer[0];
c0d01ef6:	69c1      	ldr	r1, [r0, #28]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
c0d01ef8:	788a      	ldrb	r2, [r1, #2]
c0d01efa:	784b      	ldrb	r3, [r1, #1]
c0d01efc:	021b      	lsls	r3, r3, #8
c0d01efe:	189b      	adds	r3, r3, r2

#endif // U2F_PROXY_MAGIC
}

void u2f_message_complete(u2f_service_t *service) {
    uint8_t cmd = service->transportBuffer[0];
c0d01f00:	780a      	ldrb	r2, [r1, #0]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
    switch (cmd) {
c0d01f02:	2a81      	cmp	r2, #129	; 0x81
c0d01f04:	d009      	beq.n	c0d01f1a <u2f_message_complete+0x26>
c0d01f06:	2a83      	cmp	r2, #131	; 0x83
c0d01f08:	d00d      	beq.n	c0d01f26 <u2f_message_complete+0x32>
c0d01f0a:	2a86      	cmp	r2, #134	; 0x86
c0d01f0c:	d10f      	bne.n	c0d01f2e <u2f_message_complete+0x3a>
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
c0d01f0e:	1cc9      	adds	r1, r1, #3
c0d01f10:	1d03      	adds	r3, r0, #4
c0d01f12:	2200      	movs	r2, #0
c0d01f14:	f7ff ff40 	bl	c0d01d98 <u2f_handle_cmd_init>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d01f18:	bd80      	pop	{r7, pc}
    switch (cmd) {
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
c0d01f1a:	1cca      	adds	r2, r1, #3
}

void u2f_handle_cmd_ping(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length) {
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
c0d01f1c:	b29b      	uxth	r3, r3
c0d01f1e:	2181      	movs	r1, #129	; 0x81
c0d01f20:	f000 fb72 	bl	c0d02608 <u2f_message_reply>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d01f24:	bd80      	pop	{r7, pc}
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
c0d01f26:	1cc9      	adds	r1, r1, #3
c0d01f28:	b29a      	uxth	r2, r3
c0d01f2a:	f7ff ff85 	bl	c0d01e38 <u2f_handle_cmd_msg>
        break;
    }
}
c0d01f2e:	bd80      	pop	{r7, pc}

c0d01f30 <u2f_io_send>:
#include "u2f_processing.h"
#include "u2f_impl.h"

#include "os_io_seproxyhal.h"

void u2f_io_send(uint8_t *buffer, uint16_t length, u2f_transport_media_t media) {
c0d01f30:	b570      	push	{r4, r5, r6, lr}
    if (media == U2F_MEDIA_USB) {
c0d01f32:	2a01      	cmp	r2, #1
c0d01f34:	d113      	bne.n	c0d01f5e <u2f_io_send+0x2e>
c0d01f36:	460d      	mov	r5, r1
c0d01f38:	4601      	mov	r1, r0
        os_memmove(G_io_usb_ep_buffer, buffer, length);
c0d01f3a:	4c09      	ldr	r4, [pc, #36]	; (c0d01f60 <u2f_io_send+0x30>)
c0d01f3c:	4620      	mov	r0, r4
c0d01f3e:	462a      	mov	r2, r5
c0d01f40:	f7fe fdb8 	bl	c0d00ab4 <os_memmove>
        // wipe the remaining to avoid :
        // 1/ data leaks
        // 2/ invalid junk
        os_memset(G_io_usb_ep_buffer+length, 0, sizeof(G_io_usb_ep_buffer)-length);
c0d01f44:	1960      	adds	r0, r4, r5
c0d01f46:	2640      	movs	r6, #64	; 0x40
c0d01f48:	1b72      	subs	r2, r6, r5
c0d01f4a:	2500      	movs	r5, #0
c0d01f4c:	4629      	mov	r1, r5
c0d01f4e:	f7fe fdc7 	bl	c0d00ae0 <os_memset>
c0d01f52:	2081      	movs	r0, #129	; 0x81
    }
    switch (media) {
    case U2F_MEDIA_USB:
        io_usb_send_ep(U2F_EPIN_ADDR, G_io_usb_ep_buffer, USB_SEGMENT_SIZE, 0);
c0d01f54:	4621      	mov	r1, r4
c0d01f56:	4632      	mov	r2, r6
c0d01f58:	462b      	mov	r3, r5
c0d01f5a:	f7fe fe75 	bl	c0d00c48 <io_usb_send_ep>
#endif
    default:
        PRINTF("Request to send on unsupported media %d\n", media);
        break;
    }
}
c0d01f5e:	bd70      	pop	{r4, r5, r6, pc}
c0d01f60:	20001c4c 	.word	0x20001c4c

c0d01f64 <u2f_transport_init>:
/**
 * Initialize the u2f transport and provide the buffer into which to store incoming message
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
    service->transportReceiveBufferLength = message_buffer_length;
c0d01f64:	8202      	strh	r2, [r0, #16]

/**
 * Initialize the u2f transport and provide the buffer into which to store incoming message
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
c0d01f66:	60c1      	str	r1, [r0, #12]
c0d01f68:	2200      	movs	r2, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d01f6a:	82c2      	strh	r2, [r0, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d01f6c:	7682      	strb	r2, [r0, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d01f6e:	8542      	strh	r2, [r0, #42]	; 0x2a

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d01f70:	8482      	strh	r2, [r0, #36]	; 0x24
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d01f72:	61c1      	str	r1, [r0, #28]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d01f74:	6202      	str	r2, [r0, #32]
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
    service->transportReceiveBufferLength = message_buffer_length;
    u2f_transport_reset(service);
}
c0d01f76:	4770      	bx	lr

c0d01f78 <u2f_transport_sent>:

/**
 * Function called when the previously scheduled message to be sent on the media is effectively sent.
 * And a new message can be scheduled.
 */
void u2f_transport_sent(u2f_service_t* service, u2f_transport_media_t media) {
c0d01f78:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01f7a:	b083      	sub	sp, #12
c0d01f7c:	460d      	mov	r5, r1
c0d01f7e:	4604      	mov	r4, r0
c0d01f80:	202a      	movs	r0, #42	; 0x2a

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d01f82:	5c21      	ldrb	r1, [r4, r0]
c0d01f84:	4620      	mov	r0, r4
c0d01f86:	302a      	adds	r0, #42	; 0x2a
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d01f88:	2901      	cmp	r1, #1
c0d01f8a:	d048      	beq.n	c0d0201e <u2f_transport_sent+0xa6>
c0d01f8c:	2900      	cmp	r1, #0
c0d01f8e:	d139      	bne.n	c0d02004 <u2f_transport_sent+0x8c>
c0d01f90:	212b      	movs	r1, #43	; 0x2b
c0d01f92:	2200      	movs	r2, #0
c0d01f94:	5462      	strb	r2, [r4, r1]
c0d01f96:	4622      	mov	r2, r4
c0d01f98:	322b      	adds	r2, #43	; 0x2b
c0d01f9a:	2120      	movs	r1, #32

    // previous mark packet as sent
    service->sending = false;

    // if idle (possibly after an error), then only await for a transmission 
    if (service->transportState != U2F_SENDING_RESPONSE 
c0d01f9c:	5c63      	ldrb	r3, [r4, r1]
        && service->transportState != U2F_SENDING_ERROR) {
c0d01f9e:	1edb      	subs	r3, r3, #3
c0d01fa0:	b2db      	uxtb	r3, r3

    // previous mark packet as sent
    service->sending = false;

    // if idle (possibly after an error), then only await for a transmission 
    if (service->transportState != U2F_SENDING_RESPONSE 
c0d01fa2:	4626      	mov	r6, r4
c0d01fa4:	3620      	adds	r6, #32
        && service->transportState != U2F_SENDING_ERROR) {
c0d01fa6:	2b01      	cmp	r3, #1
c0d01fa8:	d83c      	bhi.n	c0d02024 <u2f_transport_sent+0xac>
        // absorb the error, transport is erroneous but that won't hurt in the end.
        // also absorb the fake channel user presence check reply ack
        //THROW(INVALID_STATE);
        return;
    }
    if (service->transportOffset < service->transportLength) {
c0d01faa:	8b23      	ldrh	r3, [r4, #24]
c0d01fac:	8ae7      	ldrh	r7, [r4, #22]
c0d01fae:	42bb      	cmp	r3, r7
c0d01fb0:	d93a      	bls.n	c0d02028 <u2f_transport_sent+0xb0>
        uint16_t mtu = (media == U2F_MEDIA_USB) ? USB_SEGMENT_SIZE : BLE_SEGMENT_SIZE;
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
c0d01fb2:	7ea0      	ldrb	r0, [r4, #26]
c0d01fb4:	2203      	movs	r2, #3
c0d01fb6:	2601      	movs	r6, #1
c0d01fb8:	9000      	str	r0, [sp, #0]
c0d01fba:	2800      	cmp	r0, #0
c0d01fbc:	d000      	beq.n	c0d01fc0 <u2f_transport_sent+0x48>
c0d01fbe:	4632      	mov	r2, r6
        // also absorb the fake channel user presence check reply ack
        //THROW(INVALID_STATE);
        return;
    }
    if (service->transportOffset < service->transportLength) {
        uint16_t mtu = (media == U2F_MEDIA_USB) ? USB_SEGMENT_SIZE : BLE_SEGMENT_SIZE;
c0d01fc0:	1e68      	subs	r0, r5, #1
c0d01fc2:	2600      	movs	r6, #0
c0d01fc4:	9602      	str	r6, [sp, #8]
c0d01fc6:	1a36      	subs	r6, r6, r0
c0d01fc8:	4146      	adcs	r6, r0
c0d01fca:	00b0      	lsls	r0, r6, #2
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
c0d01fcc:	1810      	adds	r0, r2, r0
c0d01fce:	2240      	movs	r2, #64	; 0x40
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
                                      (mtu - headerSize)
c0d01fd0:	2d01      	cmp	r5, #1
c0d01fd2:	d000      	beq.n	c0d01fd6 <u2f_transport_sent+0x5e>
c0d01fd4:	460a      	mov	r2, r1
c0d01fd6:	1a16      	subs	r6, r2, r0
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
c0d01fd8:	1bd9      	subs	r1, r3, r7
c0d01fda:	42b1      	cmp	r1, r6
c0d01fdc:	dc00      	bgt.n	c0d01fe0 <u2f_transport_sent+0x68>
c0d01fde:	460e      	mov	r6, r1
                                      (mtu - headerSize)
                                  ? (mtu - headerSize)
                                  : service->transportLength - service->transportOffset);
        uint16_t dataSize = blockSize + headerSize;
c0d01fe0:	1831      	adds	r1, r6, r0
        uint16_t offset = 0;
        // Fragment
        if (media == U2F_MEDIA_USB) {
c0d01fe2:	9101      	str	r1, [sp, #4]
c0d01fe4:	2d01      	cmp	r5, #1
c0d01fe6:	4607      	mov	r7, r0
c0d01fe8:	9800      	ldr	r0, [sp, #0]
c0d01fea:	d106      	bne.n	c0d01ffa <u2f_transport_sent+0x82>
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d01fec:	1d21      	adds	r1, r4, #4
c0d01fee:	4827      	ldr	r0, [pc, #156]	; (c0d0208c <u2f_transport_sent+0x114>)
c0d01ff0:	2204      	movs	r2, #4
c0d01ff2:	9202      	str	r2, [sp, #8]
c0d01ff4:	f7fe fd5e 	bl	c0d00ab4 <os_memmove>
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
c0d01ff8:	7ea0      	ldrb	r0, [r4, #26]
c0d01ffa:	2800      	cmp	r0, #0
c0d01ffc:	d021      	beq.n	c0d02042 <u2f_transport_sent+0xca>
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
c0d01ffe:	1e40      	subs	r0, r0, #1
c0d02000:	9902      	ldr	r1, [sp, #8]
c0d02002:	e029      	b.n	c0d02058 <u2f_transport_sent+0xe0>
c0d02004:	2125      	movs	r1, #37	; 0x25
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d02006:	5c61      	ldrb	r1, [r4, r1]
            && service->sending == false)
c0d02008:	2906      	cmp	r1, #6
c0d0200a:	d108      	bne.n	c0d0201e <u2f_transport_sent+0xa6>
c0d0200c:	212b      	movs	r1, #43	; 0x2b
c0d0200e:	5c63      	ldrb	r3, [r4, r1]
c0d02010:	2200      	movs	r2, #0
c0d02012:	5462      	strb	r2, [r4, r1]
c0d02014:	4622      	mov	r2, r4
c0d02016:	322b      	adds	r2, #43	; 0x2b
 * And a new message can be scheduled.
 */
void u2f_transport_sent(u2f_service_t* service, u2f_transport_media_t media) {

    // don't process when replying to anti timeout requests
    if (!u2f_message_repliable(service)) {
c0d02018:	2b00      	cmp	r3, #0
c0d0201a:	d103      	bne.n	c0d02024 <u2f_transport_sent+0xac>
c0d0201c:	e7bd      	b.n	c0d01f9a <u2f_transport_sent+0x22>
c0d0201e:	202b      	movs	r0, #43	; 0x2b
c0d02020:	2100      	movs	r1, #0
c0d02022:	5421      	strb	r1, [r4, r0]
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
    }
}
c0d02024:	b003      	add	sp, #12
c0d02026:	bdf0      	pop	{r4, r5, r6, r7, pc}
        service->transportOffset += blockSize;
        service->transportPacketIndex++;
        u2f_io_send(G_io_usb_ep_buffer, dataSize, media);
    }
    // last part sent
    else if (service->transportOffset == service->transportLength) {
c0d02028:	d1fc      	bne.n	c0d02024 <u2f_transport_sent+0xac>
c0d0202a:	2100      	movs	r1, #0
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d0202c:	76a1      	strb	r1, [r4, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d0202e:	82e1      	strh	r1, [r4, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d02030:	7011      	strb	r1, [r2, #0]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d02032:	7001      	strb	r1, [r0, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d02034:	80b1      	strh	r1, [r6, #4]
c0d02036:	6031      	str	r1, [r6, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d02038:	68e0      	ldr	r0, [r4, #12]
c0d0203a:	61e0      	str	r0, [r4, #28]
    }
    // last part sent
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
c0d0203c:	4812      	ldr	r0, [pc, #72]	; (c0d02088 <u2f_transport_sent+0x110>)
c0d0203e:	7001      	strb	r1, [r0, #0]
c0d02040:	e7f0      	b.n	c0d02024 <u2f_transport_sent+0xac>
c0d02042:	2040      	movs	r0, #64	; 0x40
        if (media == U2F_MEDIA_USB) {
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
c0d02044:	5c20      	ldrb	r0, [r4, r0]
c0d02046:	4911      	ldr	r1, [pc, #68]	; (c0d0208c <u2f_transport_sent+0x114>)
c0d02048:	9a02      	ldr	r2, [sp, #8]
c0d0204a:	5488      	strb	r0, [r1, r2]
c0d0204c:	2001      	movs	r0, #1
c0d0204e:	4310      	orrs	r0, r2
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
c0d02050:	7e62      	ldrb	r2, [r4, #25]
c0d02052:	540a      	strb	r2, [r1, r0]
c0d02054:	1c41      	adds	r1, r0, #1
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
c0d02056:	7e20      	ldrb	r0, [r4, #24]
c0d02058:	4b0c      	ldr	r3, [pc, #48]	; (c0d0208c <u2f_transport_sent+0x114>)
c0d0205a:	5458      	strb	r0, [r3, r1]
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
c0d0205c:	69e1      	ldr	r1, [r4, #28]
c0d0205e:	2900      	cmp	r1, #0
c0d02060:	d005      	beq.n	c0d0206e <u2f_transport_sent+0xf6>
c0d02062:	b2b2      	uxth	r2, r6
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d02064:	19d8      	adds	r0, r3, r7
                       service->transportBuffer + service->transportOffset, blockSize);
c0d02066:	8ae3      	ldrh	r3, [r4, #22]
c0d02068:	18c9      	adds	r1, r1, r3
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d0206a:	f7fe fd23 	bl	c0d00ab4 <os_memmove>
                       service->transportBuffer + service->transportOffset, blockSize);
        }
        service->transportOffset += blockSize;
c0d0206e:	8ae0      	ldrh	r0, [r4, #22]
c0d02070:	1980      	adds	r0, r0, r6
c0d02072:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d02074:	7ea0      	ldrb	r0, [r4, #26]
c0d02076:	1c40      	adds	r0, r0, #1
c0d02078:	76a0      	strb	r0, [r4, #26]
        u2f_io_send(G_io_usb_ep_buffer, dataSize, media);
c0d0207a:	9801      	ldr	r0, [sp, #4]
c0d0207c:	b281      	uxth	r1, r0
c0d0207e:	4803      	ldr	r0, [pc, #12]	; (c0d0208c <u2f_transport_sent+0x114>)
c0d02080:	462a      	mov	r2, r5
c0d02082:	f7ff ff55 	bl	c0d01f30 <u2f_io_send>
c0d02086:	e7cd      	b.n	c0d02024 <u2f_transport_sent+0xac>
c0d02088:	20001be0 	.word	0x20001be0
c0d0208c:	20001c4c 	.word	0x20001c4c

c0d02090 <u2f_message_repliable>:
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
    }
}

bool u2f_message_repliable(u2f_service_t* service) {
c0d02090:	212a      	movs	r1, #42	; 0x2a
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d02092:	5c42      	ldrb	r2, [r0, r1]
c0d02094:	2101      	movs	r1, #1
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d02096:	2a00      	cmp	r2, #0
c0d02098:	d00d      	beq.n	c0d020b6 <u2f_message_repliable+0x26>
c0d0209a:	2a01      	cmp	r2, #1
c0d0209c:	d101      	bne.n	c0d020a2 <u2f_message_repliable+0x12>
c0d0209e:	2100      	movs	r1, #0
c0d020a0:	e009      	b.n	c0d020b6 <u2f_message_repliable+0x26>
c0d020a2:	2125      	movs	r1, #37	; 0x25
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d020a4:	5c42      	ldrb	r2, [r0, r1]
c0d020a6:	2100      	movs	r1, #0
            && service->sending == false)
c0d020a8:	2a06      	cmp	r2, #6
c0d020aa:	d104      	bne.n	c0d020b6 <u2f_message_repliable+0x26>
c0d020ac:	212b      	movs	r1, #43	; 0x2b
c0d020ae:	5c40      	ldrb	r0, [r0, r1]
c0d020b0:	2100      	movs	r1, #0
c0d020b2:	1a09      	subs	r1, r1, r0
c0d020b4:	4141      	adcs	r1, r0

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d020b6:	4608      	mov	r0, r1
c0d020b8:	4770      	bx	lr
	...

c0d020bc <u2f_transport_send_usb_user_presence_required>:
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
    }
}

void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
c0d020bc:	b5b0      	push	{r4, r5, r7, lr}
c0d020be:	212b      	movs	r1, #43	; 0x2b
c0d020c0:	2401      	movs	r4, #1
    uint16_t offset = 0;
    service->sending = true;
c0d020c2:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d020c4:	1d01      	adds	r1, r0, #4
c0d020c6:	4d0b      	ldr	r5, [pc, #44]	; (c0d020f4 <u2f_transport_send_usb_user_presence_required+0x38>)
c0d020c8:	2204      	movs	r2, #4
c0d020ca:	4628      	mov	r0, r5
c0d020cc:	f7fe fcf2 	bl	c0d00ab4 <os_memmove>
c0d020d0:	2000      	movs	r0, #0
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
    G_io_usb_ep_buffer[offset++] = 0;
c0d020d2:	7168      	strb	r0, [r5, #5]
c0d020d4:	2083      	movs	r0, #131	; 0x83
void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
c0d020d6:	7128      	strb	r0, [r5, #4]
c0d020d8:	2002      	movs	r0, #2
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 2;
c0d020da:	71a8      	strb	r0, [r5, #6]
c0d020dc:	2069      	movs	r0, #105	; 0x69
    G_io_usb_ep_buffer[offset++] = 0x69;
c0d020de:	71e8      	strb	r0, [r5, #7]
c0d020e0:	207c      	movs	r0, #124	; 0x7c
c0d020e2:	43c0      	mvns	r0, r0
    G_io_usb_ep_buffer[offset++] = 0x85;
c0d020e4:	1c80      	adds	r0, r0, #2
c0d020e6:	7228      	strb	r0, [r5, #8]
c0d020e8:	2109      	movs	r1, #9
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d020ea:	4628      	mov	r0, r5
c0d020ec:	4622      	mov	r2, r4
c0d020ee:	f7ff ff1f 	bl	c0d01f30 <u2f_io_send>
}
c0d020f2:	bdb0      	pop	{r4, r5, r7, pc}
c0d020f4:	20001c4c 	.word	0x20001c4c

c0d020f8 <u2f_transport_send_wink>:

void u2f_transport_send_wink(u2f_service_t *service) {
c0d020f8:	b5b0      	push	{r4, r5, r7, lr}
c0d020fa:	212b      	movs	r1, #43	; 0x2b
c0d020fc:	2401      	movs	r4, #1
    uint16_t offset = 0;
    service->sending = true;
c0d020fe:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d02100:	1d01      	adds	r1, r0, #4
c0d02102:	4d08      	ldr	r5, [pc, #32]	; (c0d02124 <u2f_transport_send_wink+0x2c>)
c0d02104:	2204      	movs	r2, #4
c0d02106:	4628      	mov	r0, r5
c0d02108:	f7fe fcd4 	bl	c0d00ab4 <os_memmove>
c0d0210c:	2000      	movs	r0, #0
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_WINK;
    G_io_usb_ep_buffer[offset++] = 0;
c0d0210e:	7168      	strb	r0, [r5, #5]
c0d02110:	2188      	movs	r1, #136	; 0x88
void u2f_transport_send_wink(u2f_service_t *service) {
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_WINK;
c0d02112:	7129      	strb	r1, [r5, #4]
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 0;
c0d02114:	71a8      	strb	r0, [r5, #6]
c0d02116:	2107      	movs	r1, #7
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d02118:	4628      	mov	r0, r5
c0d0211a:	4622      	mov	r2, r4
c0d0211c:	f7ff ff08 	bl	c0d01f30 <u2f_io_send>
}
c0d02120:	bdb0      	pop	{r4, r5, r7, pc}
c0d02122:	46c0      	nop			; (mov r8, r8)
c0d02124:	20001c4c 	.word	0x20001c4c

c0d02128 <u2f_transport_receive_fakeChannel>:

bool u2f_transport_receive_fakeChannel(u2f_service_t *service, uint8_t *buffer, uint16_t size) {
c0d02128:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0212a:	b081      	sub	sp, #4
c0d0212c:	4604      	mov	r4, r0
c0d0212e:	2025      	movs	r0, #37	; 0x25
    if (service->fakeChannelTransportState == U2F_INTERNAL_ERROR) {
c0d02130:	5c20      	ldrb	r0, [r4, r0]
c0d02132:	4626      	mov	r6, r4
c0d02134:	3625      	adds	r6, #37	; 0x25
c0d02136:	2500      	movs	r5, #0
c0d02138:	2805      	cmp	r0, #5
c0d0213a:	d06a      	beq.n	c0d02212 <u2f_transport_receive_fakeChannel+0xea>
        return false;
    }
    if (memcmp(service->channel, buffer, 4) != 0) {
c0d0213c:	7808      	ldrb	r0, [r1, #0]
c0d0213e:	784b      	ldrb	r3, [r1, #1]
c0d02140:	021b      	lsls	r3, r3, #8
c0d02142:	1818      	adds	r0, r3, r0
c0d02144:	788b      	ldrb	r3, [r1, #2]
c0d02146:	78cd      	ldrb	r5, [r1, #3]
c0d02148:	022d      	lsls	r5, r5, #8
c0d0214a:	18eb      	adds	r3, r5, r3
c0d0214c:	041b      	lsls	r3, r3, #16
c0d0214e:	1818      	adds	r0, r3, r0
c0d02150:	7923      	ldrb	r3, [r4, #4]
c0d02152:	7965      	ldrb	r5, [r4, #5]
c0d02154:	022d      	lsls	r5, r5, #8
c0d02156:	18eb      	adds	r3, r5, r3
c0d02158:	79a5      	ldrb	r5, [r4, #6]
c0d0215a:	79e7      	ldrb	r7, [r4, #7]
c0d0215c:	023f      	lsls	r7, r7, #8
c0d0215e:	197d      	adds	r5, r7, r5
c0d02160:	042d      	lsls	r5, r5, #16
c0d02162:	18eb      	adds	r3, r5, r3
c0d02164:	4283      	cmp	r3, r0
c0d02166:	d157      	bne.n	c0d02218 <u2f_transport_receive_fakeChannel+0xf0>
c0d02168:	7908      	ldrb	r0, [r1, #4]
c0d0216a:	1d0b      	adds	r3, r1, #4
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
c0d0216c:	8c65      	ldrh	r5, [r4, #34]	; 0x22
c0d0216e:	2d00      	cmp	r5, #0
c0d02170:	d013      	beq.n	c0d0219a <u2f_transport_receive_fakeChannel+0x72>
c0d02172:	2324      	movs	r3, #36	; 0x24
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
        service->fakeChannelTransportPacketIndex = 0;
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
c0d02174:	5ce7      	ldrb	r7, [r4, r3]
c0d02176:	4623      	mov	r3, r4
c0d02178:	3324      	adds	r3, #36	; 0x24
c0d0217a:	42b8      	cmp	r0, r7
c0d0217c:	d14c      	bne.n	c0d02218 <u2f_transport_receive_fakeChannel+0xf0>
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d0217e:	8b27      	ldrh	r7, [r4, #24]
        service->fakeChannelTransportPacketIndex++;
c0d02180:	1c40      	adds	r0, r0, #1
c0d02182:	7018      	strb	r0, [r3, #0]
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d02184:	1b7b      	subs	r3, r7, r5
c0d02186:	1f50      	subs	r0, r2, #5
c0d02188:	4298      	cmp	r0, r3
c0d0218a:	db00      	blt.n	c0d0218e <u2f_transport_receive_fakeChannel+0x66>
c0d0218c:	4618      	mov	r0, r3
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
c0d0218e:	182a      	adds	r2, r5, r0
c0d02190:	8462      	strh	r2, [r4, #34]	; 0x22
c0d02192:	b282      	uxth	r2, r0
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
c0d02194:	8d20      	ldrh	r0, [r4, #40]	; 0x28
c0d02196:	1d49      	adds	r1, r1, #5
c0d02198:	e023      	b.n	c0d021e2 <u2f_transport_receive_fakeChannel+0xba>
c0d0219a:	257c      	movs	r5, #124	; 0x7c
c0d0219c:	43ed      	mvns	r5, r5
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
        uint16_t commandLength = U2BE(buffer, 4+1) + U2F_COMMAND_HEADER_SIZE;
        // Some buggy implementations can send a WINK here, reply it gently
        if (buffer[4] == U2F_CMD_WINK) {
c0d0219e:	1d6d      	adds	r5, r5, #5
c0d021a0:	b2ef      	uxtb	r7, r5
c0d021a2:	2583      	movs	r5, #131	; 0x83
c0d021a4:	42b8      	cmp	r0, r7
c0d021a6:	d104      	bne.n	c0d021b2 <u2f_transport_receive_fakeChannel+0x8a>
            u2f_transport_send_wink(service);
c0d021a8:	4620      	mov	r0, r4
c0d021aa:	f7ff ffa5 	bl	c0d020f8 <u2f_transport_send_wink>
c0d021ae:	2501      	movs	r5, #1
c0d021b0:	e02f      	b.n	c0d02212 <u2f_transport_receive_fakeChannel+0xea>
    }
    if (memcmp(service->channel, buffer, 4) != 0) {
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
        uint16_t commandLength = U2BE(buffer, 4+1) + U2F_COMMAND_HEADER_SIZE;
c0d021b2:	798f      	ldrb	r7, [r1, #6]
c0d021b4:	7949      	ldrb	r1, [r1, #5]
c0d021b6:	0209      	lsls	r1, r1, #8
c0d021b8:	19c9      	adds	r1, r1, r7
c0d021ba:	1cc9      	adds	r1, r1, #3
        if (buffer[4] == U2F_CMD_WINK) {
            u2f_transport_send_wink(service);
            return true;
        }

        if (commandLength != service->transportLength) {
c0d021bc:	42a8      	cmp	r0, r5
c0d021be:	d12b      	bne.n	c0d02218 <u2f_transport_receive_fakeChannel+0xf0>
c0d021c0:	8b20      	ldrh	r0, [r4, #24]
c0d021c2:	b28d      	uxth	r5, r1
c0d021c4:	42a8      	cmp	r0, r5
c0d021c6:	d127      	bne.n	c0d02218 <u2f_transport_receive_fakeChannel+0xf0>
c0d021c8:	b289      	uxth	r1, r1
c0d021ca:	4d16      	ldr	r5, [pc, #88]	; (c0d02224 <u2f_transport_receive_fakeChannel+0xfc>)
c0d021cc:	2724      	movs	r7, #36	; 0x24
c0d021ce:	2000      	movs	r0, #0
        }
        if (buffer[4] != U2F_CMD_MSG) {
            goto error;
        }
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
        service->fakeChannelTransportPacketIndex = 0;
c0d021d0:	55e0      	strb	r0, [r4, r7]
            goto error;
        }
        if (buffer[4] != U2F_CMD_MSG) {
            goto error;
        }
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
c0d021d2:	1f12      	subs	r2, r2, #4
c0d021d4:	428a      	cmp	r2, r1
c0d021d6:	db00      	blt.n	c0d021da <u2f_transport_receive_fakeChannel+0xb2>
c0d021d8:	460a      	mov	r2, r1
c0d021da:	8462      	strh	r2, [r4, #34]	; 0x22
        service->fakeChannelTransportPacketIndex = 0;
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
c0d021dc:	4015      	ands	r5, r2
c0d021de:	4619      	mov	r1, r3
c0d021e0:	462a      	mov	r2, r5
c0d021e2:	f7ff fc8d 	bl	c0d01b00 <cx_crc16_update>
c0d021e6:	8520      	strh	r0, [r4, #40]	; 0x28
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
    }
    if (service->fakeChannelTransportOffset >= service->transportLength) {
c0d021e8:	8b21      	ldrh	r1, [r4, #24]
c0d021ea:	8c62      	ldrh	r2, [r4, #34]	; 0x22
c0d021ec:	2501      	movs	r5, #1
c0d021ee:	428a      	cmp	r2, r1
c0d021f0:	d30f      	bcc.n	c0d02212 <u2f_transport_receive_fakeChannel+0xea>
        if (service->fakeChannelCrc != service->commandCrc) {
c0d021f2:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d021f4:	4288      	cmp	r0, r1
c0d021f6:	d10f      	bne.n	c0d02218 <u2f_transport_receive_fakeChannel+0xf0>
c0d021f8:	2006      	movs	r0, #6
            goto error;
        }
        service->fakeChannelTransportState = U2F_FAKE_RECEIVED;
c0d021fa:	7030      	strb	r0, [r6, #0]
c0d021fc:	2000      	movs	r0, #0
        service->fakeChannelTransportOffset = 0;
c0d021fe:	8460      	strh	r0, [r4, #34]	; 0x22
c0d02200:	202a      	movs	r0, #42	; 0x2a
        // reply immediately when the asynch response is not yet ready
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d02202:	5c20      	ldrb	r0, [r4, r0]
c0d02204:	2801      	cmp	r0, #1
c0d02206:	d104      	bne.n	c0d02212 <u2f_transport_receive_fakeChannel+0xea>
            u2f_transport_send_usb_user_presence_required(service);
c0d02208:	4620      	mov	r0, r4
c0d0220a:	f7ff ff57 	bl	c0d020bc <u2f_transport_send_usb_user_presence_required>
c0d0220e:	2000      	movs	r0, #0
            // response sent
            service->fakeChannelTransportState = U2F_IDLE;
c0d02210:	7030      	strb	r0, [r6, #0]
error:
    service->fakeChannelTransportState = U2F_INTERNAL_ERROR;
    // don't hesitate here, the user will have to exit/rerun the app otherwise.
    THROW(EXCEPTION_IO_RESET);
    return false;    
}
c0d02212:	4628      	mov	r0, r5
c0d02214:	b001      	add	sp, #4
c0d02216:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02218:	2005      	movs	r0, #5
            service->fakeChannelTransportState = U2F_IDLE;
        }
    }
    return true;
error:
    service->fakeChannelTransportState = U2F_INTERNAL_ERROR;
c0d0221a:	7030      	strb	r0, [r6, #0]
c0d0221c:	2010      	movs	r0, #16
    // don't hesitate here, the user will have to exit/rerun the app otherwise.
    THROW(EXCEPTION_IO_RESET);
c0d0221e:	f7fe fc7c 	bl	c0d00b1a <os_longjmp>
c0d02222:	46c0      	nop			; (mov r8, r8)
c0d02224:	0000ffff 	.word	0x0000ffff

c0d02228 <u2f_transport_received>:
/** 
 * Function that process every message received on a media.
 * Performs message concatenation when message is splitted.
 */
void u2f_transport_received(u2f_service_t *service, uint8_t *buffer,
                          uint16_t size, u2f_transport_media_t media) {
c0d02228:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0222a:	b089      	sub	sp, #36	; 0x24
c0d0222c:	4604      	mov	r4, r0
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
    uint16_t xfer_len;
    service->media = media;
c0d0222e:	7203      	strb	r3, [r0, #8]
c0d02230:	2020      	movs	r0, #32

    // Handle a busy channel and avoid reentry
    if (service->transportState == U2F_SENDING_RESPONSE) {
c0d02232:	5c20      	ldrb	r0, [r4, r0]
c0d02234:	4626      	mov	r6, r4
c0d02236:	3620      	adds	r6, #32
c0d02238:	2803      	cmp	r0, #3
c0d0223a:	d00c      	beq.n	c0d02256 <u2f_transport_received+0x2e>
c0d0223c:	460f      	mov	r7, r1
c0d0223e:	212a      	movs	r1, #42	; 0x2a
        u2f_transport_error(service, ERROR_CHANNEL_BUSY);
        goto error;
    }
    if (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_IDLE) {
c0d02240:	5c61      	ldrb	r1, [r4, r1]
c0d02242:	4625      	mov	r5, r4
c0d02244:	352a      	adds	r5, #42	; 0x2a
c0d02246:	2900      	cmp	r1, #0
c0d02248:	d015      	beq.n	c0d02276 <u2f_transport_received+0x4e>
        if (!u2f_transport_receive_fakeChannel(service, buffer, size)) {
c0d0224a:	4620      	mov	r0, r4
c0d0224c:	4639      	mov	r1, r7
c0d0224e:	f7ff ff6b 	bl	c0d02128 <u2f_transport_receive_fakeChannel>
c0d02252:	2800      	cmp	r0, #0
c0d02254:	d174      	bne.n	c0d02340 <u2f_transport_received+0x118>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02256:	48d8      	ldr	r0, [pc, #864]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d02258:	2106      	movs	r1, #6
c0d0225a:	7201      	strb	r1, [r0, #8]
c0d0225c:	2104      	movs	r1, #4

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d0225e:	7031      	strb	r1, [r6, #0]
c0d02260:	217a      	movs	r1, #122	; 0x7a
c0d02262:	43c9      	mvns	r1, r1
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d02264:	313a      	adds	r1, #58	; 0x3a
c0d02266:	2240      	movs	r2, #64	; 0x40
c0d02268:	54a1      	strb	r1, [r4, r2]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d0226a:	3008      	adds	r0, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d0226c:	61e0      	str	r0, [r4, #28]
c0d0226e:	2000      	movs	r0, #0
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
c0d02270:	76a0      	strb	r0, [r4, #26]
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
c0d02272:	82e0      	strh	r0, [r4, #22]
c0d02274:	e05e      	b.n	c0d02334 <u2f_transport_received+0x10c>
c0d02276:	9208      	str	r2, [sp, #32]
        }
        return;
    }
    
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
c0d02278:	2804      	cmp	r0, #4
c0d0227a:	d109      	bne.n	c0d02290 <u2f_transport_received+0x68>
c0d0227c:	202b      	movs	r0, #43	; 0x2b
c0d0227e:	2100      	movs	r1, #0
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d02280:	5421      	strb	r1, [r4, r0]
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d02282:	76a1      	strb	r1, [r4, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d02284:	82e1      	strh	r1, [r4, #22]
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d02286:	7029      	strb	r1, [r5, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d02288:	80b1      	strh	r1, [r6, #4]
c0d0228a:	6031      	str	r1, [r6, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d0228c:	68e0      	ldr	r0, [r4, #12]
c0d0228e:	61e0      	str	r0, [r4, #28]
 * Function that process every message received on a media.
 * Performs message concatenation when message is splitted.
 */
void u2f_transport_received(u2f_service_t *service, uint8_t *buffer,
                          uint16_t size, u2f_transport_media_t media) {
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
c0d02290:	1e58      	subs	r0, r3, #1
c0d02292:	461a      	mov	r2, r3
c0d02294:	2300      	movs	r3, #0
c0d02296:	1a19      	subs	r1, r3, r0
c0d02298:	4141      	adcs	r1, r0
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
        u2f_transport_reset(service);
    }

    if (size < (1 + channelHeader)) {
c0d0229a:	0088      	lsls	r0, r1, #2
c0d0229c:	9007      	str	r0, [sp, #28]
c0d0229e:	1c41      	adds	r1, r0, #1
c0d022a0:	9808      	ldr	r0, [sp, #32]
c0d022a2:	4281      	cmp	r1, r0
c0d022a4:	d838      	bhi.n	c0d02318 <u2f_transport_received+0xf0>
c0d022a6:	9104      	str	r1, [sp, #16]
c0d022a8:	9206      	str	r2, [sp, #24]
        // Message to short, abort
        u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
        goto error;
    }
    if (media == U2F_MEDIA_USB) {
c0d022aa:	2a01      	cmp	r2, #1
c0d022ac:	9305      	str	r3, [sp, #20]
c0d022ae:	d105      	bne.n	c0d022bc <u2f_transport_received+0x94>
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
c0d022b0:	1d20      	adds	r0, r4, #4
c0d022b2:	2204      	movs	r2, #4
c0d022b4:	4639      	mov	r1, r7
c0d022b6:	f7fe fbfd 	bl	c0d00ab4 <os_memmove>
c0d022ba:	9b05      	ldr	r3, [sp, #20]
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d022bc:	8ae0      	ldrh	r0, [r4, #22]
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
c0d022be:	2800      	cmp	r0, #0
c0d022c0:	d00b      	beq.n	c0d022da <u2f_transport_received+0xb2>
c0d022c2:	9806      	ldr	r0, [sp, #24]
c0d022c4:	2801      	cmp	r0, #1
c0d022c6:	d121      	bne.n	c0d0230c <u2f_transport_received+0xe4>
c0d022c8:	4620      	mov	r0, r4
c0d022ca:	3012      	adds	r0, #18
c0d022cc:	1d21      	adds	r1, r4, #4
c0d022ce:	2204      	movs	r2, #4
c0d022d0:	f7fe fc0f 	bl	c0d00af2 <os_memcmp>
c0d022d4:	9b05      	ldr	r3, [sp, #20]
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d022d6:	2800      	cmp	r0, #0
c0d022d8:	d018      	beq.n	c0d0230c <u2f_transport_received+0xe4>
c0d022da:	2503      	movs	r5, #3
c0d022dc:	9a07      	ldr	r2, [sp, #28]
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
        if (size < (channelHeader + 3)) {
c0d022de:	4610      	mov	r0, r2
c0d022e0:	4328      	orrs	r0, r5
c0d022e2:	9908      	ldr	r1, [sp, #32]
c0d022e4:	4288      	cmp	r0, r1
c0d022e6:	d817      	bhi.n	c0d02318 <u2f_transport_received+0xf0>
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        // check this is a command, cannot accept continuation without previous command
        if ((buffer[channelHeader+0]&U2F_MASK_COMMAND) == 0) {
c0d022e8:	18b8      	adds	r0, r7, r2
c0d022ea:	9003      	str	r0, [sp, #12]
c0d022ec:	56b8      	ldrsb	r0, [r7, r2]
c0d022ee:	217a      	movs	r1, #122	; 0x7a
c0d022f0:	43c9      	mvns	r1, r1
c0d022f2:	317a      	adds	r1, #122	; 0x7a
c0d022f4:	b249      	sxtb	r1, r1
c0d022f6:	2285      	movs	r2, #133	; 0x85
c0d022f8:	4288      	cmp	r0, r1
c0d022fa:	dd3f      	ble.n	c0d0237c <u2f_transport_received+0x154>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d022fc:	48ae      	ldr	r0, [pc, #696]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d022fe:	2104      	movs	r1, #4
c0d02300:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02302:	7031      	strb	r1, [r6, #0]
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d02304:	323a      	adds	r2, #58	; 0x3a
c0d02306:	2140      	movs	r1, #64	; 0x40
c0d02308:	5462      	strb	r2, [r4, r1]
c0d0230a:	e00f      	b.n	c0d0232c <u2f_transport_received+0x104>
c0d0230c:	2002      	movs	r0, #2
c0d0230e:	9a07      	ldr	r2, [sp, #28]
            service->transportPacketIndex = 0;
            os_memmove(service->transportChannel, service->channel, 4);
        }
    } else {
        // Continuation
        if (size < (channelHeader + 2)) {
c0d02310:	4310      	orrs	r0, r2
c0d02312:	9908      	ldr	r1, [sp, #32]
c0d02314:	4288      	cmp	r0, r1
c0d02316:	d915      	bls.n	c0d02344 <u2f_transport_received+0x11c>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02318:	48a7      	ldr	r0, [pc, #668]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d0231a:	2185      	movs	r1, #133	; 0x85
c0d0231c:	7201      	strb	r1, [r0, #8]
c0d0231e:	2104      	movs	r1, #4

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02320:	7031      	strb	r1, [r6, #0]
c0d02322:	217a      	movs	r1, #122	; 0x7a
c0d02324:	43c9      	mvns	r1, r1
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d02326:	313a      	adds	r1, #58	; 0x3a
c0d02328:	2240      	movs	r2, #64	; 0x40
c0d0232a:	54a1      	strb	r1, [r4, r2]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d0232c:	3008      	adds	r0, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d0232e:	61e0      	str	r0, [r4, #28]
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
c0d02330:	76a3      	strb	r3, [r4, #26]
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
c0d02332:	82e3      	strh	r3, [r4, #22]
c0d02334:	2001      	movs	r0, #1
    service->transportLength = 1;
c0d02336:	8320      	strh	r0, [r4, #24]
    service->sendCmd = U2F_STATUS_ERROR;
    // pump the first message, with the reception media
    u2f_transport_sent(service, service->media);
c0d02338:	7a21      	ldrb	r1, [r4, #8]
c0d0233a:	4620      	mov	r0, r4
c0d0233c:	f7ff fe1c 	bl	c0d01f78 <u2f_transport_sent>
        service->seqTimeout = 0;
        service->transportState = U2F_HANDLE_SEGMENTED;
    }
error:
    return;
}
c0d02340:	b009      	add	sp, #36	; 0x24
c0d02342:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02344:	2021      	movs	r0, #33	; 0x21
        if (size < (channelHeader + 2)) {
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        if (media != service->transportMedia) {
c0d02346:	5c20      	ldrb	r0, [r4, r0]
c0d02348:	9906      	ldr	r1, [sp, #24]
c0d0234a:	4288      	cmp	r0, r1
c0d0234c:	d149      	bne.n	c0d023e2 <u2f_transport_received+0x1ba>
            // Mixed medias
            u2f_transport_error(service, ERROR_PROP_MEDIA_MIXED);
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
c0d0234e:	7830      	ldrb	r0, [r6, #0]
c0d02350:	2801      	cmp	r0, #1
c0d02352:	d154      	bne.n	c0d023fe <u2f_transport_received+0x1d6>
            } else {
                u2f_transport_error(service, ERROR_INVALID_SEQ);
                goto error;
            }
        }
        if (media == U2F_MEDIA_USB) {
c0d02354:	9806      	ldr	r0, [sp, #24]
c0d02356:	2801      	cmp	r0, #1
c0d02358:	d000      	beq.n	c0d0235c <u2f_transport_received+0x134>
c0d0235a:	e080      	b.n	c0d0245e <u2f_transport_received+0x236>
            // Check the channel
            if (os_memcmp(buffer, service->channel, 4) != 0) {
c0d0235c:	1d21      	adds	r1, r4, #4
c0d0235e:	2204      	movs	r2, #4
c0d02360:	4638      	mov	r0, r7
c0d02362:	9203      	str	r2, [sp, #12]
c0d02364:	461d      	mov	r5, r3
c0d02366:	f7fe fbc4 	bl	c0d00af2 <os_memcmp>
c0d0236a:	9a07      	ldr	r2, [sp, #28]
c0d0236c:	462b      	mov	r3, r5
c0d0236e:	2800      	cmp	r0, #0
c0d02370:	d075      	beq.n	c0d0245e <u2f_transport_received+0x236>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02372:	4891      	ldr	r0, [pc, #580]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d02374:	2106      	movs	r1, #6
c0d02376:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02378:	9903      	ldr	r1, [sp, #12]
c0d0237a:	e7d1      	b.n	c0d02320 <u2f_transport_received+0xf8>
c0d0237c:	9202      	str	r2, [sp, #8]
c0d0237e:	9a06      	ldr	r2, [sp, #24]
            goto error;
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
c0d02380:	2a01      	cmp	r2, #1
c0d02382:	d114      	bne.n	c0d023ae <u2f_transport_received+0x186>
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d02384:	7830      	ldrb	r0, [r6, #0]
c0d02386:	2801      	cmp	r0, #1
c0d02388:	d11d      	bne.n	c0d023c6 <u2f_transport_received+0x19e>
                (os_memcmp(service->channel, service->transportChannel, 4) !=
c0d0238a:	1d20      	adds	r0, r4, #4
c0d0238c:	4621      	mov	r1, r4
c0d0238e:	3112      	adds	r1, #18
c0d02390:	2204      	movs	r2, #4
c0d02392:	9001      	str	r0, [sp, #4]
c0d02394:	f7fe fbad 	bl	c0d00af2 <os_memcmp>
c0d02398:	9a06      	ldr	r2, [sp, #24]
                 0) &&
c0d0239a:	2800      	cmp	r0, #0
c0d0239c:	d007      	beq.n	c0d023ae <u2f_transport_received+0x186>
                (buffer[channelHeader] != U2F_CMD_INIT)) {
c0d0239e:	9803      	ldr	r0, [sp, #12]
c0d023a0:	7800      	ldrb	r0, [r0, #0]
c0d023a2:	9902      	ldr	r1, [sp, #8]
c0d023a4:	1c49      	adds	r1, r1, #1
c0d023a6:	b2c9      	uxtb	r1, r1
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d023a8:	4288      	cmp	r0, r1
c0d023aa:	d000      	beq.n	c0d023ae <u2f_transport_received+0x186>
c0d023ac:	e0ea      	b.n	c0d02584 <u2f_transport_received+0x35c>
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d023ae:	7830      	ldrb	r0, [r6, #0]
c0d023b0:	2801      	cmp	r0, #1
c0d023b2:	d108      	bne.n	c0d023c6 <u2f_transport_received+0x19e>
            !((media == U2F_MEDIA_USB) &&
c0d023b4:	2a01      	cmp	r2, #1
c0d023b6:	d17e      	bne.n	c0d024b6 <u2f_transport_received+0x28e>
              (buffer[channelHeader] == U2F_CMD_INIT))) {
c0d023b8:	9803      	ldr	r0, [sp, #12]
c0d023ba:	7800      	ldrb	r0, [r0, #0]
c0d023bc:	9902      	ldr	r1, [sp, #8]
c0d023be:	1c49      	adds	r1, r1, #1
c0d023c0:	b2c9      	uxtb	r1, r1
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d023c2:	4288      	cmp	r0, r1
c0d023c4:	d177      	bne.n	c0d024b6 <u2f_transport_received+0x28e>
c0d023c6:	9904      	ldr	r1, [sp, #16]
            // Unexpected continuation at this stage, abort
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        // Check the length
        uint16_t commandLength = U2BE(buffer, channelHeader + 1);
c0d023c8:	1878      	adds	r0, r7, r1
c0d023ca:	7840      	ldrb	r0, [r0, #1]
c0d023cc:	5c79      	ldrb	r1, [r7, r1]
c0d023ce:	0209      	lsls	r1, r1, #8
c0d023d0:	180f      	adds	r7, r1, r0
        if (commandLength > (service->transportReceiveBufferLength - 3)) {
c0d023d2:	8a20      	ldrh	r0, [r4, #16]
c0d023d4:	1ec0      	subs	r0, r0, #3
c0d023d6:	4287      	cmp	r7, r0
c0d023d8:	dd1f      	ble.n	c0d0241a <u2f_transport_received+0x1f2>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d023da:	4877      	ldr	r0, [pc, #476]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d023dc:	7205      	strb	r5, [r0, #8]
c0d023de:	2104      	movs	r1, #4
c0d023e0:	e06c      	b.n	c0d024bc <u2f_transport_received+0x294>
c0d023e2:	207a      	movs	r0, #122	; 0x7a
c0d023e4:	43c0      	mvns	r0, r0
c0d023e6:	4601      	mov	r1, r0
c0d023e8:	3108      	adds	r1, #8
c0d023ea:	4a73      	ldr	r2, [pc, #460]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d023ec:	7211      	strb	r1, [r2, #8]
c0d023ee:	2104      	movs	r1, #4

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d023f0:	7031      	strb	r1, [r6, #0]
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d023f2:	303a      	adds	r0, #58	; 0x3a
c0d023f4:	2140      	movs	r1, #64	; 0x40
c0d023f6:	5460      	strb	r0, [r4, r1]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d023f8:	3208      	adds	r2, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d023fa:	61e2      	str	r2, [r4, #28]
c0d023fc:	e798      	b.n	c0d02330 <u2f_transport_received+0x108>
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
            // Unexpected continuation at this stage, abort
            // TODO : review the behavior is HID only
            if (media == U2F_MEDIA_USB) {
c0d023fe:	9806      	ldr	r0, [sp, #24]
c0d02400:	2801      	cmp	r0, #1
c0d02402:	d154      	bne.n	c0d024ae <u2f_transport_received+0x286>
c0d02404:	202b      	movs	r0, #43	; 0x2b
c0d02406:	2100      	movs	r1, #0
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d02408:	5421      	strb	r1, [r4, r0]
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d0240a:	76a1      	strb	r1, [r4, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d0240c:	82e1      	strh	r1, [r4, #22]
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d0240e:	7029      	strb	r1, [r5, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d02410:	80b1      	strh	r1, [r6, #4]
c0d02412:	6031      	str	r1, [r6, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d02414:	68e0      	ldr	r0, [r4, #12]
c0d02416:	61e0      	str	r0, [r4, #28]
c0d02418:	e792      	b.n	c0d02340 <u2f_transport_received+0x118>
            // Overflow in message size, abort
            u2f_transport_error(service, ERROR_INVALID_LEN);
            goto error;
        }
        // Check if the command is supported
        switch (buffer[channelHeader]) {
c0d0241a:	9803      	ldr	r0, [sp, #12]
c0d0241c:	7800      	ldrb	r0, [r0, #0]
c0d0241e:	2881      	cmp	r0, #129	; 0x81
c0d02420:	d004      	beq.n	c0d0242c <u2f_transport_received+0x204>
c0d02422:	2886      	cmp	r0, #134	; 0x86
c0d02424:	d053      	beq.n	c0d024ce <u2f_transport_received+0x2a6>
c0d02426:	2883      	cmp	r0, #131	; 0x83
c0d02428:	d000      	beq.n	c0d0242c <u2f_transport_received+0x204>
c0d0242a:	e095      	b.n	c0d02558 <u2f_transport_received+0x330>
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
c0d0242c:	2a01      	cmp	r2, #1
c0d0242e:	d159      	bne.n	c0d024e4 <u2f_transport_received+0x2bc>
                if (u2f_is_channel_broadcast(service->channel) ||
c0d02430:	1d25      	adds	r5, r4, #4
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d02432:	4962      	ldr	r1, [pc, #392]	; (c0d025bc <u2f_transport_received+0x394>)
c0d02434:	4479      	add	r1, pc
c0d02436:	2204      	movs	r2, #4
c0d02438:	4628      	mov	r0, r5
c0d0243a:	9204      	str	r2, [sp, #16]
c0d0243c:	f7fe fb59 	bl	c0d00af2 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d02440:	2800      	cmp	r0, #0
c0d02442:	d007      	beq.n	c0d02454 <u2f_transport_received+0x22c>
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d02444:	495e      	ldr	r1, [pc, #376]	; (c0d025c0 <u2f_transport_received+0x398>)
c0d02446:	4479      	add	r1, pc
c0d02448:	2204      	movs	r2, #4
c0d0244a:	4628      	mov	r0, r5
c0d0244c:	f7fe fb51 	bl	c0d00af2 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d02450:	2800      	cmp	r0, #0
c0d02452:	d147      	bne.n	c0d024e4 <u2f_transport_received+0x2bc>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02454:	4858      	ldr	r0, [pc, #352]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d02456:	210b      	movs	r1, #11
c0d02458:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d0245a:	9904      	ldr	r1, [sp, #16]
c0d0245c:	e02e      	b.n	c0d024bc <u2f_transport_received+0x294>
                u2f_transport_error(service, ERROR_CHANNEL_BUSY);
                goto error;
            }
        }
        // also discriminate invalid command sent instead of a continuation
        if (buffer[channelHeader] != service->transportPacketIndex) {
c0d0245e:	18b9      	adds	r1, r7, r2
c0d02460:	5cb8      	ldrb	r0, [r7, r2]
c0d02462:	7ea2      	ldrb	r2, [r4, #26]
c0d02464:	4290      	cmp	r0, r2
c0d02466:	d122      	bne.n	c0d024ae <u2f_transport_received+0x286>
            // Bad continuation packet, abort
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        xfer_len = MIN(size - (channelHeader + 1), service->transportLength - service->transportOffset);
c0d02468:	9808      	ldr	r0, [sp, #32]
c0d0246a:	9a04      	ldr	r2, [sp, #16]
c0d0246c:	1a85      	subs	r5, r0, r2
c0d0246e:	8ae0      	ldrh	r0, [r4, #22]
c0d02470:	8b22      	ldrh	r2, [r4, #24]
c0d02472:	1a12      	subs	r2, r2, r0
c0d02474:	4295      	cmp	r5, r2
c0d02476:	db00      	blt.n	c0d0247a <u2f_transport_received+0x252>
c0d02478:	4615      	mov	r5, r2
        os_memmove(service->transportBuffer + service->transportOffset, buffer + channelHeader + 1, xfer_len);
c0d0247a:	b2af      	uxth	r7, r5
c0d0247c:	69e2      	ldr	r2, [r4, #28]
c0d0247e:	1810      	adds	r0, r2, r0
c0d02480:	1c49      	adds	r1, r1, #1
c0d02482:	463a      	mov	r2, r7
c0d02484:	f7fe fb16 	bl	c0d00ab4 <os_memmove>
c0d02488:	9906      	ldr	r1, [sp, #24]
        if (media == U2F_MEDIA_USB) {
c0d0248a:	2901      	cmp	r1, #1
c0d0248c:	d108      	bne.n	c0d024a0 <u2f_transport_received+0x278>
            service->commandCrc = cx_crc16_update(service->commandCrc, service->transportBuffer + service->transportOffset, xfer_len);
c0d0248e:	8ae0      	ldrh	r0, [r4, #22]
c0d02490:	69e1      	ldr	r1, [r4, #28]
c0d02492:	1809      	adds	r1, r1, r0
c0d02494:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d02496:	463a      	mov	r2, r7
c0d02498:	f7ff fb32 	bl	c0d01b00 <cx_crc16_update>
c0d0249c:	9906      	ldr	r1, [sp, #24]
c0d0249e:	84e0      	strh	r0, [r4, #38]	; 0x26
        }        
        service->transportOffset += xfer_len;
c0d024a0:	8ae0      	ldrh	r0, [r4, #22]
c0d024a2:	1940      	adds	r0, r0, r5
c0d024a4:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d024a6:	7ea0      	ldrb	r0, [r4, #26]
c0d024a8:	1c40      	adds	r0, r0, #1
c0d024aa:	76a0      	strb	r0, [r4, #26]
c0d024ac:	e040      	b.n	c0d02530 <u2f_transport_received+0x308>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d024ae:	4842      	ldr	r0, [pc, #264]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d024b0:	2104      	movs	r1, #4
c0d024b2:	7201      	strb	r1, [r0, #8]
c0d024b4:	e734      	b.n	c0d02320 <u2f_transport_received+0xf8>
c0d024b6:	4840      	ldr	r0, [pc, #256]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d024b8:	2104      	movs	r1, #4
c0d024ba:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d024bc:	7031      	strb	r1, [r6, #0]
c0d024be:	9a02      	ldr	r2, [sp, #8]
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d024c0:	323a      	adds	r2, #58	; 0x3a
c0d024c2:	2140      	movs	r1, #64	; 0x40
c0d024c4:	5462      	strb	r2, [r4, r1]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d024c6:	3008      	adds	r0, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d024c8:	61e0      	str	r0, [r4, #28]
c0d024ca:	9805      	ldr	r0, [sp, #20]
c0d024cc:	e6d0      	b.n	c0d02270 <u2f_transport_received+0x48>
                }
            }
            // no channel for BLE
            break;
        case U2F_CMD_INIT:
            if (media != U2F_MEDIA_USB) {
c0d024ce:	2a01      	cmp	r2, #1
c0d024d0:	d142      	bne.n	c0d02558 <u2f_transport_received+0x330>
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d024d2:	1d20      	adds	r0, r4, #4
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d024d4:	493b      	ldr	r1, [pc, #236]	; (c0d025c4 <u2f_transport_received+0x39c>)
c0d024d6:	4479      	add	r1, pc
c0d024d8:	2504      	movs	r5, #4
c0d024da:	462a      	mov	r2, r5
c0d024dc:	f7fe fb09 	bl	c0d00af2 <os_memcmp>
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d024e0:	2800      	cmp	r0, #0
c0d024e2:	d063      	beq.n	c0d025ac <u2f_transport_received+0x384>
        }

        // Ok, initialize the buffer
        //if (buffer[channelHeader] != U2F_CMD_INIT) 
        {
            xfer_len = MIN(size - (channelHeader), U2F_COMMAND_HEADER_SIZE+commandLength);
c0d024e4:	9808      	ldr	r0, [sp, #32]
c0d024e6:	9907      	ldr	r1, [sp, #28]
c0d024e8:	1a45      	subs	r5, r0, r1
c0d024ea:	1cf8      	adds	r0, r7, #3
c0d024ec:	4285      	cmp	r5, r0
c0d024ee:	db00      	blt.n	c0d024f2 <u2f_transport_received+0x2ca>
c0d024f0:	4605      	mov	r5, r0
c0d024f2:	9008      	str	r0, [sp, #32]
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
c0d024f4:	b2af      	uxth	r7, r5
c0d024f6:	69e0      	ldr	r0, [r4, #28]
c0d024f8:	9903      	ldr	r1, [sp, #12]
c0d024fa:	463a      	mov	r2, r7
c0d024fc:	f7fe fada 	bl	c0d00ab4 <os_memmove>
c0d02500:	9906      	ldr	r1, [sp, #24]
            if (media == U2F_MEDIA_USB) {
c0d02502:	2901      	cmp	r1, #1
c0d02504:	d106      	bne.n	c0d02514 <u2f_transport_received+0x2ec>
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
c0d02506:	69e1      	ldr	r1, [r4, #28]
c0d02508:	2000      	movs	r0, #0
c0d0250a:	463a      	mov	r2, r7
c0d0250c:	f7ff faf8 	bl	c0d01b00 <cx_crc16_update>
c0d02510:	9906      	ldr	r1, [sp, #24]
c0d02512:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d02514:	2021      	movs	r0, #33	; 0x21
            }
            service->transportOffset = xfer_len;
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
            service->transportMedia = media;
c0d02516:	5421      	strb	r1, [r4, r0]
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
            if (media == U2F_MEDIA_USB) {
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
            }
            service->transportOffset = xfer_len;
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
c0d02518:	9808      	ldr	r0, [sp, #32]
c0d0251a:	8320      	strh	r0, [r4, #24]
            xfer_len = MIN(size - (channelHeader), U2F_COMMAND_HEADER_SIZE+commandLength);
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
            if (media == U2F_MEDIA_USB) {
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
            }
            service->transportOffset = xfer_len;
c0d0251c:	82e5      	strh	r5, [r4, #22]
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
            service->transportMedia = media;
            // initialize the response
            service->transportPacketIndex = 0;
c0d0251e:	9805      	ldr	r0, [sp, #20]
c0d02520:	76a0      	strb	r0, [r4, #26]
            os_memmove(service->transportChannel, service->channel, 4);
c0d02522:	4620      	mov	r0, r4
c0d02524:	3012      	adds	r0, #18
c0d02526:	1d21      	adds	r1, r4, #4
c0d02528:	2204      	movs	r2, #4
c0d0252a:	f7fe fac3 	bl	c0d00ab4 <os_memmove>
c0d0252e:	9906      	ldr	r1, [sp, #24]
c0d02530:	8ae0      	ldrh	r0, [r4, #22]
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d02532:	2901      	cmp	r1, #1
c0d02534:	d102      	bne.n	c0d0253c <u2f_transport_received+0x314>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
c0d02536:	8b21      	ldrh	r1, [r4, #24]
c0d02538:	9b05      	ldr	r3, [sp, #20]
c0d0253a:	e007      	b.n	c0d0254c <u2f_transport_received+0x324>
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
c0d0253c:	8b21      	ldrh	r1, [r4, #24]
c0d0253e:	1cca      	adds	r2, r1, #3
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d02540:	4282      	cmp	r2, r0
c0d02542:	9b05      	ldr	r3, [sp, #20]
c0d02544:	d202      	bcs.n	c0d0254c <u2f_transport_received+0x324>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02546:	481c      	ldr	r0, [pc, #112]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d02548:	2103      	movs	r1, #3
c0d0254a:	e6e7      	b.n	c0d0231c <u2f_transport_received+0xf4>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
c0d0254c:	4288      	cmp	r0, r1
c0d0254e:	d213      	bcs.n	c0d02578 <u2f_transport_received+0x350>
        service->transportState = U2F_PROCESSING_COMMAND;
        // internal notification of a complete message received
        u2f_message_complete(service);
    } else {
        // new segment received, reset the timeout for the current piece
        service->seqTimeout = 0;
c0d02550:	6363      	str	r3, [r4, #52]	; 0x34
c0d02552:	2001      	movs	r0, #1
        service->transportState = U2F_HANDLE_SEGMENTED;
c0d02554:	7030      	strb	r0, [r6, #0]
c0d02556:	e6f3      	b.n	c0d02340 <u2f_transport_received+0x118>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02558:	4817      	ldr	r0, [pc, #92]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d0255a:	2101      	movs	r1, #1
c0d0255c:	7201      	strb	r1, [r0, #8]
c0d0255e:	2204      	movs	r2, #4

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02560:	7032      	strb	r2, [r6, #0]
c0d02562:	9b02      	ldr	r3, [sp, #8]
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
    service->transportLength = 1;
    service->sendCmd = U2F_STATUS_ERROR;
c0d02564:	333a      	adds	r3, #58	; 0x3a
c0d02566:	2240      	movs	r2, #64	; 0x40
c0d02568:	54a3      	strb	r3, [r4, r2]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d0256a:	3008      	adds	r0, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d0256c:	61e0      	str	r0, [r4, #28]
c0d0256e:	2000      	movs	r0, #0
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
c0d02570:	76a0      	strb	r0, [r4, #26]
    service->transportBuffer = G_io_usb_ep_buffer + 8;
    service->transportOffset = 0;
c0d02572:	82e0      	strh	r0, [r4, #22]
    service->transportLength = 1;
c0d02574:	8321      	strh	r1, [r4, #24]
c0d02576:	e6df      	b.n	c0d02338 <u2f_transport_received+0x110>
c0d02578:	2002      	movs	r0, #2
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
        // switch before the handler gets the opportunity to change it again
        service->transportState = U2F_PROCESSING_COMMAND;
c0d0257a:	7030      	strb	r0, [r6, #0]
        // internal notification of a complete message received
        u2f_message_complete(service);
c0d0257c:	4620      	mov	r0, r4
c0d0257e:	f7ff fcb9 	bl	c0d01ef4 <u2f_message_complete>
c0d02582:	e6dd      	b.n	c0d02340 <u2f_transport_received+0x118>
                // special error case, we reply but don't change the current state of the transport (ongoing message for example)
                //u2f_transport_error_no_reset(service, ERROR_CHANNEL_BUSY);
                uint16_t offset = 0;
                // Fragment
                if (media == U2F_MEDIA_USB) {
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d02584:	4c0c      	ldr	r4, [pc, #48]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d02586:	2204      	movs	r2, #4
c0d02588:	4620      	mov	r0, r4
c0d0258a:	9901      	ldr	r1, [sp, #4]
c0d0258c:	f7fe fa92 	bl	c0d00ab4 <os_memmove>
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
                G_io_usb_ep_buffer[offset++] = 0;
c0d02590:	9805      	ldr	r0, [sp, #20]
c0d02592:	7160      	strb	r0, [r4, #5]
c0d02594:	9802      	ldr	r0, [sp, #8]
                // Fragment
                if (media == U2F_MEDIA_USB) {
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
c0d02596:	303a      	adds	r0, #58	; 0x3a
c0d02598:	7120      	strb	r0, [r4, #4]
c0d0259a:	2201      	movs	r2, #1
                G_io_usb_ep_buffer[offset++] = 0;
                G_io_usb_ep_buffer[offset++] = 1;
c0d0259c:	71a2      	strb	r2, [r4, #6]
c0d0259e:	2006      	movs	r0, #6
                G_io_usb_ep_buffer[offset++] = ERROR_CHANNEL_BUSY;
c0d025a0:	71e0      	strb	r0, [r4, #7]
c0d025a2:	2108      	movs	r1, #8
                u2f_io_send(G_io_usb_ep_buffer, offset, media);
c0d025a4:	4620      	mov	r0, r4
c0d025a6:	f7ff fcc3 	bl	c0d01f30 <u2f_io_send>
c0d025aa:	e6c9      	b.n	c0d02340 <u2f_transport_received+0x118>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d025ac:	4802      	ldr	r0, [pc, #8]	; (c0d025b8 <u2f_transport_received+0x390>)
c0d025ae:	210b      	movs	r1, #11
c0d025b0:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d025b2:	7035      	strb	r5, [r6, #0]
c0d025b4:	e783      	b.n	c0d024be <u2f_transport_received+0x296>
c0d025b6:	46c0      	nop			; (mov r8, r8)
c0d025b8:	20001c4c 	.word	0x20001c4c
c0d025bc:	00002806 	.word	0x00002806
c0d025c0:	000027f8 	.word	0x000027f8
c0d025c4:	00002768 	.word	0x00002768

c0d025c8 <u2f_is_channel_broadcast>:
    }
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
c0d025c8:	b580      	push	{r7, lr}
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d025ca:	4904      	ldr	r1, [pc, #16]	; (c0d025dc <u2f_is_channel_broadcast+0x14>)
c0d025cc:	4479      	add	r1, pc
c0d025ce:	2204      	movs	r2, #4
c0d025d0:	f7fe fa8f 	bl	c0d00af2 <os_memcmp>
c0d025d4:	2100      	movs	r1, #0
c0d025d6:	1a09      	subs	r1, r1, r0
c0d025d8:	4148      	adcs	r0, r1
c0d025da:	bd80      	pop	{r7, pc}
c0d025dc:	0000266e 	.word	0x0000266e

c0d025e0 <u2f_message_set_autoreply_wait_user_presence>:
}

/**
 * Auto reply hodl until the real reply is prepared and sent
 */
void u2f_message_set_autoreply_wait_user_presence(u2f_service_t* service, bool enabled) {
c0d025e0:	b580      	push	{r7, lr}
c0d025e2:	222a      	movs	r2, #42	; 0x2a
c0d025e4:	5c83      	ldrb	r3, [r0, r2]
c0d025e6:	4602      	mov	r2, r0
c0d025e8:	322a      	adds	r2, #42	; 0x2a

    if (enabled) {
c0d025ea:	2900      	cmp	r1, #0
c0d025ec:	d006      	beq.n	c0d025fc <u2f_message_set_autoreply_wait_user_presence+0x1c>
        // start replying placeholder until user presence validated
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE) {
c0d025ee:	2b00      	cmp	r3, #0
c0d025f0:	d108      	bne.n	c0d02604 <u2f_message_set_autoreply_wait_user_presence+0x24>
c0d025f2:	2101      	movs	r1, #1
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
c0d025f4:	7011      	strb	r1, [r2, #0]
            u2f_transport_send_usb_user_presence_required(service);
c0d025f6:	f7ff fd61 	bl	c0d020bc <u2f_transport_send_usb_user_presence_required>
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
    }
}
c0d025fa:	bd80      	pop	{r7, pc}
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
            u2f_transport_send_usb_user_presence_required(service);
        }
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d025fc:	2b01      	cmp	r3, #1
c0d025fe:	d101      	bne.n	c0d02604 <u2f_message_set_autoreply_wait_user_presence+0x24>
c0d02600:	2002      	movs	r0, #2
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
c0d02602:	7010      	strb	r0, [r2, #0]
    }
}
c0d02604:	bd80      	pop	{r7, pc}
	...

c0d02608 <u2f_message_reply>:
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
            && service->sending == false)
        ;
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {
c0d02608:	b570      	push	{r4, r5, r6, lr}
c0d0260a:	4604      	mov	r4, r0
c0d0260c:	202a      	movs	r0, #42	; 0x2a

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d0260e:	5c20      	ldrb	r0, [r4, r0]
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d02610:	2800      	cmp	r0, #0
c0d02612:	d009      	beq.n	c0d02628 <u2f_message_reply+0x20>
c0d02614:	2801      	cmp	r0, #1
c0d02616:	d024      	beq.n	c0d02662 <u2f_message_reply+0x5a>
c0d02618:	2025      	movs	r0, #37	; 0x25
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d0261a:	5c20      	ldrb	r0, [r4, r0]
            && service->sending == false)
c0d0261c:	2806      	cmp	r0, #6
c0d0261e:	d120      	bne.n	c0d02662 <u2f_message_reply+0x5a>
c0d02620:	202b      	movs	r0, #43	; 0x2b
c0d02622:	5c20      	ldrb	r0, [r4, r0]
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {

    // if U2F is not ready to reply, then gently avoid replying
    if (u2f_message_repliable(service)) 
c0d02624:	2800      	cmp	r0, #0
c0d02626:	d11c      	bne.n	c0d02662 <u2f_message_reply+0x5a>
c0d02628:	2020      	movs	r0, #32
c0d0262a:	2503      	movs	r5, #3
    {
        service->transportState = U2F_SENDING_RESPONSE;
c0d0262c:	5425      	strb	r5, [r4, r0]
c0d0262e:	2040      	movs	r0, #64	; 0x40
        service->transportPacketIndex = 0;
        service->transportBuffer = buffer;
        service->transportOffset = 0;
        service->transportLength = len;
        service->sendCmd = cmd;
c0d02630:	5421      	strb	r1, [r4, r0]
c0d02632:	2000      	movs	r0, #0

    // if U2F is not ready to reply, then gently avoid replying
    if (u2f_message_repliable(service)) 
    {
        service->transportState = U2F_SENDING_RESPONSE;
        service->transportPacketIndex = 0;
c0d02634:	76a0      	strb	r0, [r4, #26]
        service->transportBuffer = buffer;
c0d02636:	61e2      	str	r2, [r4, #28]
        service->transportOffset = 0;
c0d02638:	82e0      	strh	r0, [r4, #22]
        service->transportLength = len;
c0d0263a:	8323      	strh	r3, [r4, #24]
c0d0263c:	2021      	movs	r0, #33	; 0x21
        service->sendCmd = cmd;
        if (service->transportMedia != U2F_MEDIA_BLE) {
c0d0263e:	5c21      	ldrb	r1, [r4, r0]
c0d02640:	4625      	mov	r5, r4
c0d02642:	3521      	adds	r5, #33	; 0x21
c0d02644:	2903      	cmp	r1, #3
c0d02646:	d10d      	bne.n	c0d02664 <u2f_message_reply+0x5c>
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
        }
        else {
            while (G_io_app.apdu_state != APDU_IDLE) {
c0d02648:	4e08      	ldr	r6, [pc, #32]	; (c0d0266c <u2f_message_reply+0x64>)
c0d0264a:	7830      	ldrb	r0, [r6, #0]
c0d0264c:	2800      	cmp	r0, #0
c0d0264e:	d008      	beq.n	c0d02662 <u2f_message_reply+0x5a>
c0d02650:	2103      	movs	r1, #3
c0d02652:	e000      	b.n	c0d02656 <u2f_message_reply+0x4e>
                u2f_transport_sent(service, service->transportMedia);       
c0d02654:	7829      	ldrb	r1, [r5, #0]
c0d02656:	4620      	mov	r0, r4
c0d02658:	f7ff fc8e 	bl	c0d01f78 <u2f_transport_sent>
        if (service->transportMedia != U2F_MEDIA_BLE) {
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
        }
        else {
            while (G_io_app.apdu_state != APDU_IDLE) {
c0d0265c:	7830      	ldrb	r0, [r6, #0]
c0d0265e:	2800      	cmp	r0, #0
c0d02660:	d1f8      	bne.n	c0d02654 <u2f_message_reply+0x4c>
                u2f_transport_sent(service, service->transportMedia);       
            }
        }
    }
}
c0d02662:	bd70      	pop	{r4, r5, r6, pc}
        service->transportOffset = 0;
        service->transportLength = len;
        service->sendCmd = cmd;
        if (service->transportMedia != U2F_MEDIA_BLE) {
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
c0d02664:	4620      	mov	r0, r4
c0d02666:	f7ff fc87 	bl	c0d01f78 <u2f_transport_sent>
            while (G_io_app.apdu_state != APDU_IDLE) {
                u2f_transport_sent(service, service->transportMedia);       
            }
        }
    }
}
c0d0266a:	bd70      	pop	{r4, r5, r6, pc}
c0d0266c:	20001be0 	.word	0x20001be0

c0d02670 <USBD_LL_Init>:
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
  ep_out_stall = 0;
c0d02670:	4902      	ldr	r1, [pc, #8]	; (c0d0267c <USBD_LL_Init+0xc>)
c0d02672:	2000      	movs	r0, #0
c0d02674:	6008      	str	r0, [r1, #0]
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02676:	4902      	ldr	r1, [pc, #8]	; (c0d02680 <USBD_LL_Init+0x10>)
c0d02678:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
  return USBD_OK;
c0d0267a:	4770      	bx	lr
c0d0267c:	20001da8 	.word	0x20001da8
c0d02680:	20001da4 	.word	0x20001da4

c0d02684 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02684:	b510      	push	{r4, lr}
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02686:	4807      	ldr	r0, [pc, #28]	; (c0d026a4 <USBD_LL_DeInit+0x20>)
c0d02688:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0268a:	7044      	strb	r4, [r0, #1]
c0d0268c:	214f      	movs	r1, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0268e:	7001      	strb	r1, [r0, #0]
c0d02690:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02692:	7081      	strb	r1, [r0, #2]
c0d02694:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02696:	70c1      	strb	r1, [r0, #3]
c0d02698:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0269a:	f7ff faaf 	bl	c0d01bfc <io_seph_send>

  return USBD_OK; 
c0d0269e:	4620      	mov	r0, r4
c0d026a0:	bd10      	pop	{r4, pc}
c0d026a2:	46c0      	nop			; (mov r8, r8)
c0d026a4:	20001a0c 	.word	0x20001a0c

c0d026a8 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d026a8:	b570      	push	{r4, r5, r6, lr}
c0d026aa:	b082      	sub	sp, #8
c0d026ac:	466d      	mov	r5, sp
c0d026ae:	2400      	movs	r4, #0
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d026b0:	706c      	strb	r4, [r5, #1]
c0d026b2:	264f      	movs	r6, #79	; 0x4f
{
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d026b4:	702e      	strb	r6, [r5, #0]
c0d026b6:	2002      	movs	r0, #2
  buffer[1] = 0;
  buffer[2] = 2;
c0d026b8:	70a8      	strb	r0, [r5, #2]
c0d026ba:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d026bc:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d026be:	712c      	strb	r4, [r5, #4]
c0d026c0:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(buffer, 5);
c0d026c2:	4628      	mov	r0, r5
c0d026c4:	f7ff fa9a 	bl	c0d01bfc <io_seph_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d026c8:	706c      	strb	r4, [r5, #1]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = 0;
  io_seproxyhal_spi_send(buffer, 5);
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d026ca:	702e      	strb	r6, [r5, #0]
c0d026cc:	2001      	movs	r0, #1
  buffer[1] = 0;
  buffer[2] = 1;
c0d026ce:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d026d0:	70e8      	strb	r0, [r5, #3]
c0d026d2:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d026d4:	4628      	mov	r0, r5
c0d026d6:	f7ff fa91 	bl	c0d01bfc <io_seph_send>
  return USBD_OK; 
c0d026da:	4620      	mov	r0, r4
c0d026dc:	b002      	add	sp, #8
c0d026de:	bd70      	pop	{r4, r5, r6, pc}

c0d026e0 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d026e0:	b510      	push	{r4, lr}
c0d026e2:	b082      	sub	sp, #8
c0d026e4:	a801      	add	r0, sp, #4
c0d026e6:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d026e8:	7044      	strb	r4, [r0, #1]
c0d026ea:	214f      	movs	r1, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d026ec:	7001      	strb	r1, [r0, #0]
c0d026ee:	2101      	movs	r1, #1
  buffer[1] = 0;
  buffer[2] = 1;
c0d026f0:	7081      	strb	r1, [r0, #2]
c0d026f2:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d026f4:	70c1      	strb	r1, [r0, #3]
c0d026f6:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d026f8:	f7ff fa80 	bl	c0d01bfc <io_seph_send>
  return USBD_OK; 
c0d026fc:	4620      	mov	r0, r4
c0d026fe:	b002      	add	sp, #8
c0d02700:	bd10      	pop	{r4, pc}
	...

c0d02704 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d02704:	b5b0      	push	{r4, r5, r7, lr}
c0d02706:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
  ep_out_stall = 0;
c0d02708:	4814      	ldr	r0, [pc, #80]	; (c0d0275c <USBD_LL_OpenEP+0x58>)
c0d0270a:	2400      	movs	r4, #0
c0d0270c:	6004      	str	r4, [r0, #0]
                                      uint16_t ep_mps)
{
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d0270e:	4814      	ldr	r0, [pc, #80]	; (c0d02760 <USBD_LL_OpenEP+0x5c>)
c0d02710:	6004      	str	r4, [r0, #0]
c0d02712:	466d      	mov	r5, sp
c0d02714:	204f      	movs	r0, #79	; 0x4f
  ep_out_stall = 0;

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02716:	7028      	strb	r0, [r5, #0]
  buffer[1] = 0;
c0d02718:	706c      	strb	r4, [r5, #1]
c0d0271a:	2005      	movs	r0, #5
  buffer[2] = 5;
c0d0271c:	70a8      	strb	r0, [r5, #2]
c0d0271e:	2004      	movs	r0, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02720:	70e8      	strb	r0, [r5, #3]
c0d02722:	2001      	movs	r0, #1
  buffer[4] = 1;
c0d02724:	7128      	strb	r0, [r5, #4]
  buffer[5] = ep_addr;
c0d02726:	7169      	strb	r1, [r5, #5]
  buffer[6] = 0;
c0d02728:	71ac      	strb	r4, [r5, #6]
  switch(ep_type) {
c0d0272a:	2a01      	cmp	r2, #1
c0d0272c:	dc05      	bgt.n	c0d0273a <USBD_LL_OpenEP+0x36>
c0d0272e:	2a00      	cmp	r2, #0
c0d02730:	d00a      	beq.n	c0d02748 <USBD_LL_OpenEP+0x44>
c0d02732:	2a01      	cmp	r2, #1
c0d02734:	d10a      	bne.n	c0d0274c <USBD_LL_OpenEP+0x48>
c0d02736:	2004      	movs	r0, #4
c0d02738:	e006      	b.n	c0d02748 <USBD_LL_OpenEP+0x44>
c0d0273a:	2a02      	cmp	r2, #2
c0d0273c:	d003      	beq.n	c0d02746 <USBD_LL_OpenEP+0x42>
c0d0273e:	2a03      	cmp	r2, #3
c0d02740:	d104      	bne.n	c0d0274c <USBD_LL_OpenEP+0x48>
c0d02742:	2002      	movs	r0, #2
c0d02744:	e000      	b.n	c0d02748 <USBD_LL_OpenEP+0x44>
c0d02746:	2003      	movs	r0, #3
c0d02748:	4669      	mov	r1, sp
c0d0274a:	7188      	strb	r0, [r1, #6]
c0d0274c:	4668      	mov	r0, sp
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d0274e:	71c3      	strb	r3, [r0, #7]
c0d02750:	2108      	movs	r1, #8
  io_seproxyhal_spi_send(buffer, 8);
c0d02752:	f7ff fa53 	bl	c0d01bfc <io_seph_send>
c0d02756:	2000      	movs	r0, #0
  return USBD_OK; 
c0d02758:	b002      	add	sp, #8
c0d0275a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0275c:	20001da8 	.word	0x20001da8
c0d02760:	20001da4 	.word	0x20001da4

c0d02764 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02764:	b510      	push	{r4, lr}
c0d02766:	b082      	sub	sp, #8
c0d02768:	4668      	mov	r0, sp
c0d0276a:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d0276c:	7044      	strb	r4, [r0, #1]
c0d0276e:	224f      	movs	r2, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02770:	7002      	strb	r2, [r0, #0]
c0d02772:	2205      	movs	r2, #5
  buffer[1] = 0;
  buffer[2] = 5;
c0d02774:	7082      	strb	r2, [r0, #2]
c0d02776:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02778:	70c2      	strb	r2, [r0, #3]
c0d0277a:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d0277c:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d0277e:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02780:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d02782:	71c4      	strb	r4, [r0, #7]
c0d02784:	2108      	movs	r1, #8
  io_seproxyhal_spi_send(buffer, 8);
c0d02786:	f7ff fa39 	bl	c0d01bfc <io_seph_send>
  return USBD_OK; 
c0d0278a:	4620      	mov	r0, r4
c0d0278c:	b002      	add	sp, #8
c0d0278e:	bd10      	pop	{r4, pc}

c0d02790 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02790:	b5b0      	push	{r4, r5, r7, lr}
c0d02792:	b082      	sub	sp, #8
c0d02794:	460d      	mov	r5, r1
c0d02796:	4668      	mov	r0, sp
c0d02798:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
c0d0279a:	7044      	strb	r4, [r0, #1]
c0d0279c:	2150      	movs	r1, #80	; 0x50
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0279e:	7001      	strb	r1, [r0, #0]
c0d027a0:	2103      	movs	r1, #3
  buffer[1] = 0;
  buffer[2] = 3;
c0d027a2:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d027a4:	70c5      	strb	r5, [r0, #3]
c0d027a6:	2140      	movs	r1, #64	; 0x40
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d027a8:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d027aa:	7144      	strb	r4, [r0, #5]
c0d027ac:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d027ae:	f7ff fa25 	bl	c0d01bfc <io_seph_send>
  if (ep_addr & 0x80) {
c0d027b2:	0628      	lsls	r0, r5, #24
c0d027b4:	d501      	bpl.n	c0d027ba <USBD_LL_StallEP+0x2a>
c0d027b6:	4807      	ldr	r0, [pc, #28]	; (c0d027d4 <USBD_LL_StallEP+0x44>)
c0d027b8:	e000      	b.n	c0d027bc <USBD_LL_StallEP+0x2c>
c0d027ba:	4805      	ldr	r0, [pc, #20]	; (c0d027d0 <USBD_LL_StallEP+0x40>)
c0d027bc:	6801      	ldr	r1, [r0, #0]
c0d027be:	227f      	movs	r2, #127	; 0x7f
c0d027c0:	4015      	ands	r5, r2
c0d027c2:	2201      	movs	r2, #1
c0d027c4:	40aa      	lsls	r2, r5
c0d027c6:	430a      	orrs	r2, r1
c0d027c8:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d027ca:	4620      	mov	r0, r4
c0d027cc:	b002      	add	sp, #8
c0d027ce:	bdb0      	pop	{r4, r5, r7, pc}
c0d027d0:	20001da8 	.word	0x20001da8
c0d027d4:	20001da4 	.word	0x20001da4

c0d027d8 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d027d8:	b5b0      	push	{r4, r5, r7, lr}
c0d027da:	b082      	sub	sp, #8
c0d027dc:	460d      	mov	r5, r1
c0d027de:	4668      	mov	r0, sp
c0d027e0:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
c0d027e2:	7044      	strb	r4, [r0, #1]
c0d027e4:	2150      	movs	r1, #80	; 0x50
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d027e6:	7001      	strb	r1, [r0, #0]
c0d027e8:	2103      	movs	r1, #3
  buffer[1] = 0;
  buffer[2] = 3;
c0d027ea:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d027ec:	70c5      	strb	r5, [r0, #3]
c0d027ee:	2180      	movs	r1, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d027f0:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d027f2:	7144      	strb	r4, [r0, #5]
c0d027f4:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d027f6:	f7ff fa01 	bl	c0d01bfc <io_seph_send>
  if (ep_addr & 0x80) {
c0d027fa:	0628      	lsls	r0, r5, #24
c0d027fc:	d501      	bpl.n	c0d02802 <USBD_LL_ClearStallEP+0x2a>
c0d027fe:	4807      	ldr	r0, [pc, #28]	; (c0d0281c <USBD_LL_ClearStallEP+0x44>)
c0d02800:	e000      	b.n	c0d02804 <USBD_LL_ClearStallEP+0x2c>
c0d02802:	4805      	ldr	r0, [pc, #20]	; (c0d02818 <USBD_LL_ClearStallEP+0x40>)
c0d02804:	6801      	ldr	r1, [r0, #0]
c0d02806:	227f      	movs	r2, #127	; 0x7f
c0d02808:	4015      	ands	r5, r2
c0d0280a:	2201      	movs	r2, #1
c0d0280c:	40aa      	lsls	r2, r5
c0d0280e:	4391      	bics	r1, r2
c0d02810:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02812:	4620      	mov	r0, r4
c0d02814:	b002      	add	sp, #8
c0d02816:	bdb0      	pop	{r4, r5, r7, pc}
c0d02818:	20001da8 	.word	0x20001da8
c0d0281c:	20001da4 	.word	0x20001da4

c0d02820 <USBD_LL_IsStallEP>:
c0d02820:	0608      	lsls	r0, r1, #24
c0d02822:	d501      	bpl.n	c0d02828 <USBD_LL_IsStallEP+0x8>
c0d02824:	4805      	ldr	r0, [pc, #20]	; (c0d0283c <USBD_LL_IsStallEP+0x1c>)
c0d02826:	e000      	b.n	c0d0282a <USBD_LL_IsStallEP+0xa>
c0d02828:	4803      	ldr	r0, [pc, #12]	; (c0d02838 <USBD_LL_IsStallEP+0x18>)
c0d0282a:	7802      	ldrb	r2, [r0, #0]
c0d0282c:	207f      	movs	r0, #127	; 0x7f
c0d0282e:	4001      	ands	r1, r0
c0d02830:	2001      	movs	r0, #1
c0d02832:	4088      	lsls	r0, r1
c0d02834:	4010      	ands	r0, r2
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d02836:	4770      	bx	lr
c0d02838:	20001da8 	.word	0x20001da8
c0d0283c:	20001da4 	.word	0x20001da4

c0d02840 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02840:	b510      	push	{r4, lr}
c0d02842:	b082      	sub	sp, #8
c0d02844:	4668      	mov	r0, sp
c0d02846:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02848:	7044      	strb	r4, [r0, #1]
c0d0284a:	224f      	movs	r2, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0284c:	7002      	strb	r2, [r0, #0]
c0d0284e:	2202      	movs	r2, #2
  buffer[1] = 0;
  buffer[2] = 2;
c0d02850:	7082      	strb	r2, [r0, #2]
c0d02852:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02854:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d02856:	7101      	strb	r1, [r0, #4]
c0d02858:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(buffer, 5);
c0d0285a:	f7ff f9cf 	bl	c0d01bfc <io_seph_send>
  return USBD_OK; 
c0d0285e:	4620      	mov	r0, r4
c0d02860:	b002      	add	sp, #8
c0d02862:	bd10      	pop	{r4, pc}

c0d02864 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02864:	b5b0      	push	{r4, r5, r7, lr}
c0d02866:	b082      	sub	sp, #8
c0d02868:	461c      	mov	r4, r3
c0d0286a:	4615      	mov	r5, r2
c0d0286c:	4668      	mov	r0, sp
c0d0286e:	2250      	movs	r2, #80	; 0x50
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02870:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
c0d02872:	70c1      	strb	r1, [r0, #3]
c0d02874:	2120      	movs	r1, #32
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02876:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d02878:	7143      	strb	r3, [r0, #5]
                                      uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
c0d0287a:	1cd9      	adds	r1, r3, #3
  buffer[2] = (3+size);
c0d0287c:	7081      	strb	r1, [r0, #2]
                                      uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
c0d0287e:	0a09      	lsrs	r1, r1, #8
c0d02880:	7041      	strb	r1, [r0, #1]
c0d02882:	2106      	movs	r1, #6
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  buffer[5] = size;
  io_seproxyhal_spi_send(buffer, 6);
c0d02884:	f7ff f9ba 	bl	c0d01bfc <io_seph_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02888:	4628      	mov	r0, r5
c0d0288a:	4621      	mov	r1, r4
c0d0288c:	f7ff f9b6 	bl	c0d01bfc <io_seph_send>
c0d02890:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02892:	b002      	add	sp, #8
c0d02894:	bdb0      	pop	{r4, r5, r7, pc}

c0d02896 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02896:	b510      	push	{r4, lr}
c0d02898:	b082      	sub	sp, #8
c0d0289a:	4668      	mov	r0, sp
c0d0289c:	2400      	movs	r4, #0
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3/*+size*/)>>8;
c0d0289e:	7044      	strb	r4, [r0, #1]
c0d028a0:	2350      	movs	r3, #80	; 0x50
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d028a2:	7003      	strb	r3, [r0, #0]
c0d028a4:	2303      	movs	r3, #3
  buffer[1] = (3/*+size*/)>>8;
  buffer[2] = (3/*+size*/);
c0d028a6:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d028a8:	70c1      	strb	r1, [r0, #3]
c0d028aa:	2130      	movs	r1, #48	; 0x30
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d028ac:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d028ae:	7142      	strb	r2, [r0, #5]
c0d028b0:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d028b2:	f7ff f9a3 	bl	c0d01bfc <io_seph_send>
  return USBD_OK;   
c0d028b6:	4620      	mov	r0, r4
c0d028b8:	b002      	add	sp, #8
c0d028ba:	bd10      	pop	{r4, pc}

c0d028bc <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d028bc:	b570      	push	{r4, r5, r6, lr}
c0d028be:	4604      	mov	r4, r0
c0d028c0:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d028c2:	2c00      	cmp	r4, #0
c0d028c4:	d012      	beq.n	c0d028ec <USBD_Init+0x30>
c0d028c6:	4615      	mov	r5, r2
c0d028c8:	460e      	mov	r6, r1
c0d028ca:	2045      	movs	r0, #69	; 0x45
c0d028cc:	0081      	lsls	r1, r0, #2
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d028ce:	4620      	mov	r0, r4
c0d028d0:	f001 fe6e 	bl	c0d045b0 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d028d4:	2e00      	cmp	r6, #0
c0d028d6:	d001      	beq.n	c0d028dc <USBD_Init+0x20>
c0d028d8:	20f0      	movs	r0, #240	; 0xf0
  {
    pdev->pDesc = pdesc;
c0d028da:	5026      	str	r6, [r4, r0]
c0d028dc:	20dc      	movs	r0, #220	; 0xdc
c0d028de:	2101      	movs	r1, #1
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d028e0:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d028e2:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d028e4:	4620      	mov	r0, r4
c0d028e6:	f7ff fec3 	bl	c0d02670 <USBD_LL_Init>
c0d028ea:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d028ec:	bd70      	pop	{r4, r5, r6, pc}

c0d028ee <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d028ee:	b5b0      	push	{r4, r5, r7, lr}
c0d028f0:	4604      	mov	r4, r0
c0d028f2:	20dc      	movs	r0, #220	; 0xdc
c0d028f4:	2101      	movs	r1, #1
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d028f6:	5421      	strb	r1, [r4, r0]
c0d028f8:	2017      	movs	r0, #23
c0d028fa:	43c5      	mvns	r5, r0
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(pdev->interfacesClass[intf].pClass != NULL) {
c0d028fc:	1960      	adds	r0, r4, r5
c0d028fe:	2143      	movs	r1, #67	; 0x43
c0d02900:	0089      	lsls	r1, r1, #2
c0d02902:	5840      	ldr	r0, [r0, r1]
c0d02904:	2800      	cmp	r0, #0
c0d02906:	d006      	beq.n	c0d02916 <USBD_DeInit+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
c0d02908:	6840      	ldr	r0, [r0, #4]
c0d0290a:	f7fe ffc1 	bl	c0d01890 <pic>
c0d0290e:	4602      	mov	r2, r0
c0d02910:	7921      	ldrb	r1, [r4, #4]
c0d02912:	4620      	mov	r0, r4
c0d02914:	4790      	blx	r2
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02916:	3508      	adds	r5, #8
c0d02918:	d1f0      	bne.n	c0d028fc <USBD_DeInit+0xe>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
    }
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d0291a:	4620      	mov	r0, r4
c0d0291c:	f7ff fee0 	bl	c0d026e0 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02920:	4620      	mov	r0, r4
c0d02922:	f7ff feaf 	bl	c0d02684 <USBD_LL_DeInit>
c0d02926:	2000      	movs	r0, #0
  
  return USBD_OK;
c0d02928:	bdb0      	pop	{r4, r5, r7, pc}

c0d0292a <USBD_RegisterClassForInterface>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef USBD_RegisterClassForInterface(uint8_t interfaceidx, USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d0292a:	4603      	mov	r3, r0
c0d0292c:	2002      	movs	r0, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d0292e:	2a00      	cmp	r2, #0
c0d02930:	d007      	beq.n	c0d02942 <USBD_RegisterClassForInterface+0x18>
c0d02932:	2000      	movs	r0, #0
  {
    if (interfaceidx < USBD_MAX_NUM_INTERFACES) {
c0d02934:	2b02      	cmp	r3, #2
c0d02936:	d804      	bhi.n	c0d02942 <USBD_RegisterClassForInterface+0x18>
      /* link the class to the USB Device handle */
      pdev->interfacesClass[interfaceidx].pClass = pclass;
c0d02938:	00d8      	lsls	r0, r3, #3
c0d0293a:	1808      	adds	r0, r1, r0
c0d0293c:	21f4      	movs	r1, #244	; 0xf4
c0d0293e:	5042      	str	r2, [r0, r1]
c0d02940:	2000      	movs	r0, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02942:	4770      	bx	lr

c0d02944 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02944:	b580      	push	{r7, lr}
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02946:	f7ff feaf 	bl	c0d026a8 <USBD_LL_Start>
c0d0294a:	2000      	movs	r0, #0
  
  return USBD_OK;  
c0d0294c:	bd80      	pop	{r7, pc}

c0d0294e <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d0294e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02950:	b081      	sub	sp, #4
c0d02952:	460c      	mov	r4, r1
c0d02954:	4605      	mov	r5, r0
c0d02956:	2600      	movs	r6, #0
c0d02958:	27f4      	movs	r7, #244	; 0xf4
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d0295a:	4628      	mov	r0, r5
c0d0295c:	4631      	mov	r1, r6
c0d0295e:	f000 f969 	bl	c0d02c34 <usbd_is_valid_intf>
c0d02962:	2800      	cmp	r0, #0
c0d02964:	d007      	beq.n	c0d02976 <USBD_SetClassConfig+0x28>
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
c0d02966:	59e8      	ldr	r0, [r5, r7]
c0d02968:	6800      	ldr	r0, [r0, #0]
c0d0296a:	f7fe ff91 	bl	c0d01890 <pic>
c0d0296e:	4602      	mov	r2, r0
c0d02970:	4628      	mov	r0, r5
c0d02972:	4621      	mov	r1, r4
c0d02974:	4790      	blx	r2

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02976:	3708      	adds	r7, #8
c0d02978:	1c76      	adds	r6, r6, #1
c0d0297a:	2e03      	cmp	r6, #3
c0d0297c:	d1ed      	bne.n	c0d0295a <USBD_SetClassConfig+0xc>
c0d0297e:	2000      	movs	r0, #0
    if(usbd_is_valid_intf(pdev, intf)) {
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
    }
  }

  return USBD_OK; 
c0d02980:	b001      	add	sp, #4
c0d02982:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02984 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02984:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02986:	b081      	sub	sp, #4
c0d02988:	460c      	mov	r4, r1
c0d0298a:	4605      	mov	r5, r0
c0d0298c:	2600      	movs	r6, #0
c0d0298e:	27f4      	movs	r7, #244	; 0xf4
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d02990:	4628      	mov	r0, r5
c0d02992:	4631      	mov	r1, r6
c0d02994:	f000 f94e 	bl	c0d02c34 <usbd_is_valid_intf>
c0d02998:	2800      	cmp	r0, #0
c0d0299a:	d007      	beq.n	c0d029ac <USBD_ClrClassConfig+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
c0d0299c:	59e8      	ldr	r0, [r5, r7]
c0d0299e:	6840      	ldr	r0, [r0, #4]
c0d029a0:	f7fe ff76 	bl	c0d01890 <pic>
c0d029a4:	4602      	mov	r2, r0
c0d029a6:	4628      	mov	r0, r5
c0d029a8:	4621      	mov	r1, r4
c0d029aa:	4790      	blx	r2
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d029ac:	3708      	adds	r7, #8
c0d029ae:	1c76      	adds	r6, r6, #1
c0d029b0:	2e03      	cmp	r6, #3
c0d029b2:	d1ed      	bne.n	c0d02990 <USBD_ClrClassConfig+0xc>
c0d029b4:	2000      	movs	r0, #0
    if(usbd_is_valid_intf(pdev, intf)) {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
    }
  }
  return USBD_OK;
c0d029b6:	b001      	add	sp, #4
c0d029b8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d029ba <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d029ba:	b5b0      	push	{r4, r5, r7, lr}
c0d029bc:	4604      	mov	r4, r0
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d029be:	4605      	mov	r5, r0
c0d029c0:	35e8      	adds	r5, #232	; 0xe8
c0d029c2:	4628      	mov	r0, r5
c0d029c4:	f000 fb79 	bl	c0d030ba <USBD_ParseSetupRequest>
c0d029c8:	20d4      	movs	r0, #212	; 0xd4
c0d029ca:	2101      	movs	r1, #1
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d029cc:	5021      	str	r1, [r4, r0]
c0d029ce:	20ee      	movs	r0, #238	; 0xee
  pdev->ep0_data_len = pdev->request.wLength;
c0d029d0:	5a20      	ldrh	r0, [r4, r0]
c0d029d2:	21d8      	movs	r1, #216	; 0xd8
c0d029d4:	5060      	str	r0, [r4, r1]
c0d029d6:	20e8      	movs	r0, #232	; 0xe8
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d029d8:	5c21      	ldrb	r1, [r4, r0]
c0d029da:	201f      	movs	r0, #31
c0d029dc:	4008      	ands	r0, r1
c0d029de:	2802      	cmp	r0, #2
c0d029e0:	d008      	beq.n	c0d029f4 <USBD_LL_SetupStage+0x3a>
c0d029e2:	2801      	cmp	r0, #1
c0d029e4:	d00b      	beq.n	c0d029fe <USBD_LL_SetupStage+0x44>
c0d029e6:	2800      	cmp	r0, #0
c0d029e8:	d10e      	bne.n	c0d02a08 <USBD_LL_SetupStage+0x4e>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d029ea:	4620      	mov	r0, r4
c0d029ec:	4629      	mov	r1, r5
c0d029ee:	f000 f92e 	bl	c0d02c4e <USBD_StdDevReq>
c0d029f2:	e00e      	b.n	c0d02a12 <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d029f4:	4620      	mov	r0, r4
c0d029f6:	4629      	mov	r1, r5
c0d029f8:	f000 fadb 	bl	c0d02fb2 <USBD_StdEPReq>
c0d029fc:	e009      	b.n	c0d02a12 <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d029fe:	4620      	mov	r0, r4
c0d02a00:	4629      	mov	r1, r5
c0d02a02:	f000 fab2 	bl	c0d02f6a <USBD_StdItfReq>
c0d02a06:	e004      	b.n	c0d02a12 <USBD_LL_SetupStage+0x58>
c0d02a08:	2080      	movs	r0, #128	; 0x80
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d02a0a:	4001      	ands	r1, r0
c0d02a0c:	4620      	mov	r0, r4
c0d02a0e:	f7ff febf 	bl	c0d02790 <USBD_LL_StallEP>
c0d02a12:	2000      	movs	r0, #0
    break;
  }  
  return USBD_OK;  
c0d02a14:	bdb0      	pop	{r4, r5, r7, pc}

c0d02a16 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d02a16:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a18:	b083      	sub	sp, #12
c0d02a1a:	9202      	str	r2, [sp, #8]
c0d02a1c:	4604      	mov	r4, r0
c0d02a1e:	9101      	str	r1, [sp, #4]
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d02a20:	2900      	cmp	r1, #0
c0d02a22:	d01c      	beq.n	c0d02a5e <USBD_LL_DataOutStage+0x48>
c0d02a24:	4625      	mov	r5, r4
c0d02a26:	35dc      	adds	r5, #220	; 0xdc
c0d02a28:	2700      	movs	r7, #0
c0d02a2a:	26f4      	movs	r6, #244	; 0xf4
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d02a2c:	4620      	mov	r0, r4
c0d02a2e:	4639      	mov	r1, r7
c0d02a30:	f000 f900 	bl	c0d02c34 <usbd_is_valid_intf>
c0d02a34:	2800      	cmp	r0, #0
c0d02a36:	d00d      	beq.n	c0d02a54 <USBD_LL_DataOutStage+0x3e>
c0d02a38:	59a0      	ldr	r0, [r4, r6]
c0d02a3a:	6980      	ldr	r0, [r0, #24]
c0d02a3c:	2800      	cmp	r0, #0
c0d02a3e:	d009      	beq.n	c0d02a54 <USBD_LL_DataOutStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02a40:	7829      	ldrb	r1, [r5, #0]
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d02a42:	2903      	cmp	r1, #3
c0d02a44:	d106      	bne.n	c0d02a54 <USBD_LL_DataOutStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
c0d02a46:	f7fe ff23 	bl	c0d01890 <pic>
c0d02a4a:	4603      	mov	r3, r0
c0d02a4c:	4620      	mov	r0, r4
c0d02a4e:	9901      	ldr	r1, [sp, #4]
c0d02a50:	9a02      	ldr	r2, [sp, #8]
c0d02a52:	4798      	blx	r3
    }
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02a54:	3608      	adds	r6, #8
c0d02a56:	1c7f      	adds	r7, r7, #1
c0d02a58:	2f03      	cmp	r7, #3
c0d02a5a:	d1e7      	bne.n	c0d02a2c <USBD_LL_DataOutStage+0x16>
c0d02a5c:	e030      	b.n	c0d02ac0 <USBD_LL_DataOutStage+0xaa>
c0d02a5e:	20d4      	movs	r0, #212	; 0xd4
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d02a60:	5820      	ldr	r0, [r4, r0]
c0d02a62:	2803      	cmp	r0, #3
c0d02a64:	d12c      	bne.n	c0d02ac0 <USBD_LL_DataOutStage+0xaa>
c0d02a66:	2080      	movs	r0, #128	; 0x80
    {
      if(pep->rem_length > pep->maxpacket)
c0d02a68:	5820      	ldr	r0, [r4, r0]
c0d02a6a:	6fe1      	ldr	r1, [r4, #124]	; 0x7c
c0d02a6c:	4281      	cmp	r1, r0
c0d02a6e:	d90a      	bls.n	c0d02a86 <USBD_LL_DataOutStage+0x70>
      {
        pep->rem_length -=  pep->maxpacket;
c0d02a70:	1a09      	subs	r1, r1, r0
c0d02a72:	67e1      	str	r1, [r4, #124]	; 0x7c
       
        USBD_CtlContinueRx (pdev, 
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
c0d02a74:	4281      	cmp	r1, r0
c0d02a76:	d300      	bcc.n	c0d02a7a <USBD_LL_DataOutStage+0x64>
c0d02a78:	4601      	mov	r1, r0
    {
      if(pep->rem_length > pep->maxpacket)
      {
        pep->rem_length -=  pep->maxpacket;
       
        USBD_CtlContinueRx (pdev, 
c0d02a7a:	b28a      	uxth	r2, r1
c0d02a7c:	4620      	mov	r0, r4
c0d02a7e:	9902      	ldr	r1, [sp, #8]
c0d02a80:	f000 fde0 	bl	c0d03644 <USBD_CtlContinueRx>
c0d02a84:	e01c      	b.n	c0d02ac0 <USBD_LL_DataOutStage+0xaa>
c0d02a86:	4626      	mov	r6, r4
c0d02a88:	36dc      	adds	r6, #220	; 0xdc
c0d02a8a:	2500      	movs	r5, #0
c0d02a8c:	27f4      	movs	r7, #244	; 0xf4
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d02a8e:	4620      	mov	r0, r4
c0d02a90:	4629      	mov	r1, r5
c0d02a92:	f000 f8cf 	bl	c0d02c34 <usbd_is_valid_intf>
c0d02a96:	2800      	cmp	r0, #0
c0d02a98:	d00b      	beq.n	c0d02ab2 <USBD_LL_DataOutStage+0x9c>
c0d02a9a:	59e0      	ldr	r0, [r4, r7]
c0d02a9c:	6900      	ldr	r0, [r0, #16]
c0d02a9e:	2800      	cmp	r0, #0
c0d02aa0:	d007      	beq.n	c0d02ab2 <USBD_LL_DataOutStage+0x9c>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02aa2:	7831      	ldrb	r1, [r6, #0]
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d02aa4:	2903      	cmp	r1, #3
c0d02aa6:	d104      	bne.n	c0d02ab2 <USBD_LL_DataOutStage+0x9c>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
c0d02aa8:	f7fe fef2 	bl	c0d01890 <pic>
c0d02aac:	4601      	mov	r1, r0
c0d02aae:	4620      	mov	r0, r4
c0d02ab0:	4788      	blx	r1
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02ab2:	3708      	adds	r7, #8
c0d02ab4:	1c6d      	adds	r5, r5, #1
c0d02ab6:	2d03      	cmp	r5, #3
c0d02ab8:	d1e9      	bne.n	c0d02a8e <USBD_LL_DataOutStage+0x78>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
          }
        }
        USBD_CtlSendStatus(pdev);
c0d02aba:	4620      	mov	r0, r4
c0d02abc:	f000 fdc9 	bl	c0d03652 <USBD_CtlSendStatus>
c0d02ac0:	2000      	movs	r0, #0
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
      }
    }
  }  
  return USBD_OK;
c0d02ac2:	b003      	add	sp, #12
c0d02ac4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02ac6 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d02ac6:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02ac8:	b081      	sub	sp, #4
c0d02aca:	4604      	mov	r4, r0
c0d02acc:	9100      	str	r1, [sp, #0]
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d02ace:	2900      	cmp	r1, #0
c0d02ad0:	d01b      	beq.n	c0d02b0a <USBD_LL_DataInStage+0x44>
c0d02ad2:	4627      	mov	r7, r4
c0d02ad4:	37dc      	adds	r7, #220	; 0xdc
c0d02ad6:	2600      	movs	r6, #0
c0d02ad8:	25f4      	movs	r5, #244	; 0xf4
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d02ada:	4620      	mov	r0, r4
c0d02adc:	4631      	mov	r1, r6
c0d02ade:	f000 f8a9 	bl	c0d02c34 <usbd_is_valid_intf>
c0d02ae2:	2800      	cmp	r0, #0
c0d02ae4:	d00c      	beq.n	c0d02b00 <USBD_LL_DataInStage+0x3a>
c0d02ae6:	5960      	ldr	r0, [r4, r5]
c0d02ae8:	6940      	ldr	r0, [r0, #20]
c0d02aea:	2800      	cmp	r0, #0
c0d02aec:	d008      	beq.n	c0d02b00 <USBD_LL_DataInStage+0x3a>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02aee:	7839      	ldrb	r1, [r7, #0]
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d02af0:	2903      	cmp	r1, #3
c0d02af2:	d105      	bne.n	c0d02b00 <USBD_LL_DataInStage+0x3a>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
c0d02af4:	f7fe fecc 	bl	c0d01890 <pic>
c0d02af8:	4602      	mov	r2, r0
c0d02afa:	4620      	mov	r0, r4
c0d02afc:	9900      	ldr	r1, [sp, #0]
c0d02afe:	4790      	blx	r2
      pdev->dev_test_mode = 0;
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02b00:	3508      	adds	r5, #8
c0d02b02:	1c76      	adds	r6, r6, #1
c0d02b04:	2e03      	cmp	r6, #3
c0d02b06:	d1e8      	bne.n	c0d02ada <USBD_LL_DataInStage+0x14>
c0d02b08:	e04e      	b.n	c0d02ba8 <USBD_LL_DataInStage+0xe2>
c0d02b0a:	20d4      	movs	r0, #212	; 0xd4
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d02b0c:	5820      	ldr	r0, [r4, r0]
c0d02b0e:	2802      	cmp	r0, #2
c0d02b10:	d143      	bne.n	c0d02b9a <USBD_LL_DataInStage+0xd4>
    {
      if(pep->rem_length > pep->maxpacket)
c0d02b12:	69e0      	ldr	r0, [r4, #28]
c0d02b14:	6a25      	ldr	r5, [r4, #32]
c0d02b16:	42a8      	cmp	r0, r5
c0d02b18:	d90b      	bls.n	c0d02b32 <USBD_LL_DataInStage+0x6c>
c0d02b1a:	2111      	movs	r1, #17
c0d02b1c:	010a      	lsls	r2, r1, #4
      {
        pep->rem_length -=  pep->maxpacket;
        pdev->pData += pep->maxpacket;
c0d02b1e:	58a1      	ldr	r1, [r4, r2]
c0d02b20:	1949      	adds	r1, r1, r5
c0d02b22:	50a1      	str	r1, [r4, r2]
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
    {
      if(pep->rem_length > pep->maxpacket)
      {
        pep->rem_length -=  pep->maxpacket;
c0d02b24:	1b40      	subs	r0, r0, r5
c0d02b26:	61e0      	str	r0, [r4, #28]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d02b28:	b282      	uxth	r2, r0
c0d02b2a:	4620      	mov	r0, r4
c0d02b2c:	f000 fd7c 	bl	c0d03628 <USBD_CtlContinueSendData>
c0d02b30:	e033      	b.n	c0d02b9a <USBD_LL_DataInStage+0xd4>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02b32:	69a6      	ldr	r6, [r4, #24]
c0d02b34:	4630      	mov	r0, r6
c0d02b36:	4629      	mov	r1, r5
c0d02b38:	f001 fd34 	bl	c0d045a4 <__aeabi_uidivmod>
c0d02b3c:	42ae      	cmp	r6, r5
c0d02b3e:	d30f      	bcc.n	c0d02b60 <USBD_LL_DataInStage+0x9a>
c0d02b40:	2900      	cmp	r1, #0
c0d02b42:	d10d      	bne.n	c0d02b60 <USBD_LL_DataInStage+0x9a>
c0d02b44:	20d8      	movs	r0, #216	; 0xd8
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d02b46:	5820      	ldr	r0, [r4, r0]
c0d02b48:	4627      	mov	r7, r4
c0d02b4a:	37d8      	adds	r7, #216	; 0xd8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d02b4c:	4286      	cmp	r6, r0
c0d02b4e:	d207      	bcs.n	c0d02b60 <USBD_LL_DataInStage+0x9a>
c0d02b50:	2500      	movs	r5, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d02b52:	4620      	mov	r0, r4
c0d02b54:	4629      	mov	r1, r5
c0d02b56:	462a      	mov	r2, r5
c0d02b58:	f000 fd66 	bl	c0d03628 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d02b5c:	603d      	str	r5, [r7, #0]
c0d02b5e:	e01c      	b.n	c0d02b9a <USBD_LL_DataInStage+0xd4>
c0d02b60:	4626      	mov	r6, r4
c0d02b62:	36dc      	adds	r6, #220	; 0xdc
c0d02b64:	2500      	movs	r5, #0
c0d02b66:	27f4      	movs	r7, #244	; 0xf4
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d02b68:	4620      	mov	r0, r4
c0d02b6a:	4629      	mov	r1, r5
c0d02b6c:	f000 f862 	bl	c0d02c34 <usbd_is_valid_intf>
c0d02b70:	2800      	cmp	r0, #0
c0d02b72:	d00b      	beq.n	c0d02b8c <USBD_LL_DataInStage+0xc6>
c0d02b74:	59e0      	ldr	r0, [r4, r7]
c0d02b76:	68c0      	ldr	r0, [r0, #12]
c0d02b78:	2800      	cmp	r0, #0
c0d02b7a:	d007      	beq.n	c0d02b8c <USBD_LL_DataInStage+0xc6>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d02b7c:	7831      	ldrb	r1, [r6, #0]
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d02b7e:	2903      	cmp	r1, #3
c0d02b80:	d104      	bne.n	c0d02b8c <USBD_LL_DataInStage+0xc6>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
c0d02b82:	f7fe fe85 	bl	c0d01890 <pic>
c0d02b86:	4601      	mov	r1, r0
c0d02b88:	4620      	mov	r0, r4
c0d02b8a:	4788      	blx	r1
          
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02b8c:	3708      	adds	r7, #8
c0d02b8e:	1c6d      	adds	r5, r5, #1
c0d02b90:	2d03      	cmp	r5, #3
c0d02b92:	d1e9      	bne.n	c0d02b68 <USBD_LL_DataInStage+0xa2>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
            }
          }
          USBD_CtlReceiveStatus(pdev);
c0d02b94:	4620      	mov	r0, r4
c0d02b96:	f000 fd68 	bl	c0d0366a <USBD_CtlReceiveStatus>
c0d02b9a:	20e0      	movs	r0, #224	; 0xe0
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d02b9c:	5c20      	ldrb	r0, [r4, r0]
c0d02b9e:	34e0      	adds	r4, #224	; 0xe0
c0d02ba0:	2801      	cmp	r0, #1
c0d02ba2:	d101      	bne.n	c0d02ba8 <USBD_LL_DataInStage+0xe2>
c0d02ba4:	2000      	movs	r0, #0
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d02ba6:	7020      	strb	r0, [r4, #0]
c0d02ba8:	2000      	movs	r0, #0
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
      }
    }
  }
  return USBD_OK;
c0d02baa:	b001      	add	sp, #4
c0d02bac:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02bae <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d02bae:	b570      	push	{r4, r5, r6, lr}
c0d02bb0:	4604      	mov	r4, r0
c0d02bb2:	2080      	movs	r0, #128	; 0x80
c0d02bb4:	2140      	movs	r1, #64	; 0x40
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02bb6:	5021      	str	r1, [r4, r0]
c0d02bb8:	20dc      	movs	r0, #220	; 0xdc
c0d02bba:	2201      	movs	r2, #1
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d02bbc:	5422      	strb	r2, [r4, r0]
USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d02bbe:	6221      	str	r1, [r4, #32]
c0d02bc0:	2500      	movs	r5, #0
c0d02bc2:	26f4      	movs	r6, #244	; 0xf4
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if( usbd_is_valid_intf(pdev, intf))
c0d02bc4:	4620      	mov	r0, r4
c0d02bc6:	4629      	mov	r1, r5
c0d02bc8:	f000 f834 	bl	c0d02c34 <usbd_is_valid_intf>
c0d02bcc:	2800      	cmp	r0, #0
c0d02bce:	d007      	beq.n	c0d02be0 <USBD_LL_Reset+0x32>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
c0d02bd0:	59a0      	ldr	r0, [r4, r6]
c0d02bd2:	6840      	ldr	r0, [r0, #4]
c0d02bd4:	f7fe fe5c 	bl	c0d01890 <pic>
c0d02bd8:	4602      	mov	r2, r0
c0d02bda:	7921      	ldrb	r1, [r4, #4]
c0d02bdc:	4620      	mov	r0, r4
c0d02bde:	4790      	blx	r2
  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02be0:	3608      	adds	r6, #8
c0d02be2:	1c6d      	adds	r5, r5, #1
c0d02be4:	2d03      	cmp	r5, #3
c0d02be6:	d1ed      	bne.n	c0d02bc4 <USBD_LL_Reset+0x16>
c0d02be8:	2000      	movs	r0, #0
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
    }
  }
  
  return USBD_OK;
c0d02bea:	bd70      	pop	{r4, r5, r6, pc}

c0d02bec <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d02bec:	7401      	strb	r1, [r0, #16]
c0d02bee:	2000      	movs	r0, #0
  return USBD_OK;
c0d02bf0:	4770      	bx	lr

c0d02bf2 <USBD_LL_Suspend>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Suspend(USBD_HandleTypeDef  *pdev)
{
c0d02bf2:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d02bf4:	4770      	bx	lr

c0d02bf6 <USBD_LL_Resume>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
c0d02bf6:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d02bf8:	4770      	bx	lr

c0d02bfa <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d02bfa:	b570      	push	{r4, r5, r6, lr}
c0d02bfc:	4604      	mov	r4, r0
c0d02bfe:	20dc      	movs	r0, #220	; 0xdc
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d02c00:	5c20      	ldrb	r0, [r4, r0]
c0d02c02:	2803      	cmp	r0, #3
c0d02c04:	d114      	bne.n	c0d02c30 <USBD_LL_SOF+0x36>
c0d02c06:	2500      	movs	r5, #0
c0d02c08:	26f4      	movs	r6, #244	; 0xf4
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && pdev->interfacesClass[intf].pClass->SOF != NULL)
c0d02c0a:	4620      	mov	r0, r4
c0d02c0c:	4629      	mov	r1, r5
c0d02c0e:	f000 f811 	bl	c0d02c34 <usbd_is_valid_intf>
c0d02c12:	2800      	cmp	r0, #0
c0d02c14:	d008      	beq.n	c0d02c28 <USBD_LL_SOF+0x2e>
c0d02c16:	59a0      	ldr	r0, [r4, r6]
c0d02c18:	69c0      	ldr	r0, [r0, #28]
c0d02c1a:	2800      	cmp	r0, #0
c0d02c1c:	d004      	beq.n	c0d02c28 <USBD_LL_SOF+0x2e>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
c0d02c1e:	f7fe fe37 	bl	c0d01890 <pic>
c0d02c22:	4601      	mov	r1, r0
c0d02c24:	4620      	mov	r0, r4
c0d02c26:	4788      	blx	r1
USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02c28:	3608      	adds	r6, #8
c0d02c2a:	1c6d      	adds	r5, r5, #1
c0d02c2c:	2d03      	cmp	r5, #3
c0d02c2e:	d1ec      	bne.n	c0d02c0a <USBD_LL_SOF+0x10>
c0d02c30:	2000      	movs	r0, #0
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
      }
    }
  }
  return USBD_OK;
c0d02c32:	bd70      	pop	{r4, r5, r6, pc}

c0d02c34 <usbd_is_valid_intf>:

/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
c0d02c34:	4602      	mov	r2, r0
c0d02c36:	2000      	movs	r0, #0
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02c38:	2902      	cmp	r1, #2
c0d02c3a:	d807      	bhi.n	c0d02c4c <usbd_is_valid_intf+0x18>
c0d02c3c:	00c8      	lsls	r0, r1, #3
c0d02c3e:	1810      	adds	r0, r2, r0
c0d02c40:	21f4      	movs	r1, #244	; 0xf4
c0d02c42:	5841      	ldr	r1, [r0, r1]
c0d02c44:	2001      	movs	r0, #1
c0d02c46:	2900      	cmp	r1, #0
c0d02c48:	d100      	bne.n	c0d02c4c <usbd_is_valid_intf+0x18>
c0d02c4a:	4608      	mov	r0, r1
c0d02c4c:	4770      	bx	lr

c0d02c4e <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02c4e:	b580      	push	{r7, lr}
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02c50:	784a      	ldrb	r2, [r1, #1]
c0d02c52:	2a04      	cmp	r2, #4
c0d02c54:	dd08      	ble.n	c0d02c68 <USBD_StdDevReq+0x1a>
c0d02c56:	2a07      	cmp	r2, #7
c0d02c58:	dc0f      	bgt.n	c0d02c7a <USBD_StdDevReq+0x2c>
c0d02c5a:	2a05      	cmp	r2, #5
c0d02c5c:	d014      	beq.n	c0d02c88 <USBD_StdDevReq+0x3a>
c0d02c5e:	2a06      	cmp	r2, #6
c0d02c60:	d11b      	bne.n	c0d02c9a <USBD_StdDevReq+0x4c>
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d02c62:	f000 f821 	bl	c0d02ca8 <USBD_GetDescriptor>
c0d02c66:	e01d      	b.n	c0d02ca4 <USBD_StdDevReq+0x56>
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02c68:	2a00      	cmp	r2, #0
c0d02c6a:	d010      	beq.n	c0d02c8e <USBD_StdDevReq+0x40>
c0d02c6c:	2a01      	cmp	r2, #1
c0d02c6e:	d017      	beq.n	c0d02ca0 <USBD_StdDevReq+0x52>
c0d02c70:	2a03      	cmp	r2, #3
c0d02c72:	d112      	bne.n	c0d02c9a <USBD_StdDevReq+0x4c>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d02c74:	f000 f934 	bl	c0d02ee0 <USBD_SetFeature>
c0d02c78:	e014      	b.n	c0d02ca4 <USBD_StdDevReq+0x56>
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d02c7a:	2a08      	cmp	r2, #8
c0d02c7c:	d00a      	beq.n	c0d02c94 <USBD_StdDevReq+0x46>
c0d02c7e:	2a09      	cmp	r2, #9
c0d02c80:	d10b      	bne.n	c0d02c9a <USBD_StdDevReq+0x4c>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d02c82:	f000 f8bd 	bl	c0d02e00 <USBD_SetConfig>
c0d02c86:	e00d      	b.n	c0d02ca4 <USBD_StdDevReq+0x56>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d02c88:	f000 f894 	bl	c0d02db4 <USBD_SetAddress>
c0d02c8c:	e00a      	b.n	c0d02ca4 <USBD_StdDevReq+0x56>
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d02c8e:	f000 f905 	bl	c0d02e9c <USBD_GetStatus>
c0d02c92:	e007      	b.n	c0d02ca4 <USBD_StdDevReq+0x56>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d02c94:	f000 f8eb 	bl	c0d02e6e <USBD_GetConfig>
c0d02c98:	e004      	b.n	c0d02ca4 <USBD_StdDevReq+0x56>
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
    break;
    
  default:  
    USBD_CtlError(pdev , req);
c0d02c9a:	f000 fbe1 	bl	c0d03460 <USBD_CtlError>
c0d02c9e:	e001      	b.n	c0d02ca4 <USBD_StdDevReq+0x56>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d02ca0:	f000 f93b 	bl	c0d02f1a <USBD_ClrFeature>
c0d02ca4:	2000      	movs	r0, #0
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d02ca6:	bd80      	pop	{r7, pc}

c0d02ca8 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d02ca8:	b5b0      	push	{r4, r5, r7, lr}
c0d02caa:	b082      	sub	sp, #8
c0d02cac:	460d      	mov	r5, r1
c0d02cae:	4604      	mov	r4, r0
c0d02cb0:	a801      	add	r0, sp, #4
c0d02cb2:	2100      	movs	r1, #0
  uint16_t len = 0;
c0d02cb4:	8001      	strh	r1, [r0, #0]
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d02cb6:	886a      	ldrh	r2, [r5, #2]
c0d02cb8:	0a10      	lsrs	r0, r2, #8
c0d02cba:	2805      	cmp	r0, #5
c0d02cbc:	dc12      	bgt.n	c0d02ce4 <USBD_GetDescriptor+0x3c>
c0d02cbe:	2801      	cmp	r0, #1
c0d02cc0:	d01c      	beq.n	c0d02cfc <USBD_GetDescriptor+0x54>
c0d02cc2:	2802      	cmp	r0, #2
c0d02cc4:	d024      	beq.n	c0d02d10 <USBD_GetDescriptor+0x68>
c0d02cc6:	2803      	cmp	r0, #3
c0d02cc8:	d137      	bne.n	c0d02d3a <USBD_GetDescriptor+0x92>
c0d02cca:	b2d0      	uxtb	r0, r2
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02ccc:	2802      	cmp	r0, #2
c0d02cce:	dc39      	bgt.n	c0d02d44 <USBD_GetDescriptor+0x9c>
c0d02cd0:	2800      	cmp	r0, #0
c0d02cd2:	d05f      	beq.n	c0d02d94 <USBD_GetDescriptor+0xec>
c0d02cd4:	2801      	cmp	r0, #1
c0d02cd6:	d065      	beq.n	c0d02da4 <USBD_GetDescriptor+0xfc>
c0d02cd8:	2802      	cmp	r0, #2
c0d02cda:	d12e      	bne.n	c0d02d3a <USBD_GetDescriptor+0x92>
c0d02cdc:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d02cde:	5820      	ldr	r0, [r4, r0]
c0d02ce0:	68c0      	ldr	r0, [r0, #12]
c0d02ce2:	e00e      	b.n	c0d02d02 <USBD_GetDescriptor+0x5a>
{
  uint16_t len = 0;
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d02ce4:	2806      	cmp	r0, #6
c0d02ce6:	d01c      	beq.n	c0d02d22 <USBD_GetDescriptor+0x7a>
c0d02ce8:	2807      	cmp	r0, #7
c0d02cea:	d023      	beq.n	c0d02d34 <USBD_GetDescriptor+0x8c>
c0d02cec:	280f      	cmp	r0, #15
c0d02cee:	d124      	bne.n	c0d02d3a <USBD_GetDescriptor+0x92>
c0d02cf0:	20f0      	movs	r0, #240	; 0xf0
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    if(pdev->pDesc->GetBOSDescriptor != NULL) {
c0d02cf2:	5820      	ldr	r0, [r4, r0]
c0d02cf4:	69c0      	ldr	r0, [r0, #28]
c0d02cf6:	2800      	cmp	r0, #0
c0d02cf8:	d103      	bne.n	c0d02d02 <USBD_GetDescriptor+0x5a>
c0d02cfa:	e01e      	b.n	c0d02d3a <USBD_GetDescriptor+0x92>
c0d02cfc:	20f0      	movs	r0, #240	; 0xf0
      goto default_error;
    }
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d02cfe:	5820      	ldr	r0, [r4, r0]
c0d02d00:	6800      	ldr	r0, [r0, #0]
c0d02d02:	f7fe fdc5 	bl	c0d01890 <pic>
c0d02d06:	4602      	mov	r2, r0
c0d02d08:	7c20      	ldrb	r0, [r4, #16]
c0d02d0a:	a901      	add	r1, sp, #4
c0d02d0c:	4790      	blx	r2
c0d02d0e:	e02f      	b.n	c0d02d70 <USBD_GetDescriptor+0xc8>
c0d02d10:	20f4      	movs	r0, #244	; 0xf4
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
c0d02d12:	5820      	ldr	r0, [r4, r0]
c0d02d14:	2800      	cmp	r0, #0
c0d02d16:	d02c      	beq.n	c0d02d72 <USBD_GetDescriptor+0xca>
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d02d18:	7c21      	ldrb	r1, [r4, #16]
c0d02d1a:	2900      	cmp	r1, #0
c0d02d1c:	d022      	beq.n	c0d02d64 <USBD_GetDescriptor+0xbc>
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
        //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
      }
      else
      {
        pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetFSConfigDescriptor))(&len);
c0d02d1e:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d02d20:	e021      	b.n	c0d02d66 <USBD_GetDescriptor+0xbe>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL )   
c0d02d22:	7c20      	ldrb	r0, [r4, #16]
c0d02d24:	2800      	cmp	r0, #0
c0d02d26:	d108      	bne.n	c0d02d3a <USBD_GetDescriptor+0x92>
c0d02d28:	20f4      	movs	r0, #244	; 0xf4
c0d02d2a:	5820      	ldr	r0, [r4, r0]
c0d02d2c:	2800      	cmp	r0, #0
c0d02d2e:	d004      	beq.n	c0d02d3a <USBD_GetDescriptor+0x92>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetDeviceQualifierDescriptor))(&len);
c0d02d30:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d02d32:	e018      	b.n	c0d02d66 <USBD_GetDescriptor+0xbe>
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d02d34:	7c20      	ldrb	r0, [r4, #16]
c0d02d36:	2800      	cmp	r0, #0
c0d02d38:	d00e      	beq.n	c0d02d58 <USBD_GetDescriptor+0xb0>
      goto default_error;
    }

  default: 
  default_error:
     USBD_CtlError(pdev , req);
c0d02d3a:	4620      	mov	r0, r4
c0d02d3c:	4629      	mov	r1, r5
c0d02d3e:	f000 fb8f 	bl	c0d03460 <USBD_CtlError>
c0d02d42:	e025      	b.n	c0d02d90 <USBD_GetDescriptor+0xe8>
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d02d44:	2803      	cmp	r0, #3
c0d02d46:	d029      	beq.n	c0d02d9c <USBD_GetDescriptor+0xf4>
c0d02d48:	2804      	cmp	r0, #4
c0d02d4a:	d02f      	beq.n	c0d02dac <USBD_GetDescriptor+0x104>
c0d02d4c:	2805      	cmp	r0, #5
c0d02d4e:	d1f4      	bne.n	c0d02d3a <USBD_GetDescriptor+0x92>
c0d02d50:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d02d52:	5820      	ldr	r0, [r4, r0]
c0d02d54:	6980      	ldr	r0, [r0, #24]
c0d02d56:	e7d4      	b.n	c0d02d02 <USBD_GetDescriptor+0x5a>
c0d02d58:	20f4      	movs	r0, #244	; 0xf4
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d02d5a:	5820      	ldr	r0, [r4, r0]
c0d02d5c:	2800      	cmp	r0, #0
c0d02d5e:	d0ec      	beq.n	c0d02d3a <USBD_GetDescriptor+0x92>
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d02d60:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d02d62:	e000      	b.n	c0d02d66 <USBD_GetDescriptor+0xbe>
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
      {
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
c0d02d64:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02d66:	f7fe fd93 	bl	c0d01890 <pic>
c0d02d6a:	4601      	mov	r1, r0
c0d02d6c:	a801      	add	r0, sp, #4
c0d02d6e:	4788      	blx	r1
c0d02d70:	4601      	mov	r1, r0
c0d02d72:	a801      	add	r0, sp, #4
  default_error:
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02d74:	8802      	ldrh	r2, [r0, #0]
c0d02d76:	2a00      	cmp	r2, #0
c0d02d78:	d00a      	beq.n	c0d02d90 <USBD_GetDescriptor+0xe8>
c0d02d7a:	88e8      	ldrh	r0, [r5, #6]
c0d02d7c:	2800      	cmp	r0, #0
c0d02d7e:	d007      	beq.n	c0d02d90 <USBD_GetDescriptor+0xe8>
  {
    
    len = MIN(len , req->wLength);
c0d02d80:	4282      	cmp	r2, r0
c0d02d82:	d300      	bcc.n	c0d02d86 <USBD_GetDescriptor+0xde>
c0d02d84:	4602      	mov	r2, r0
c0d02d86:	a801      	add	r0, sp, #4
c0d02d88:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02d8a:	4620      	mov	r0, r4
c0d02d8c:	f000 fc36 	bl	c0d035fc <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d02d90:	b002      	add	sp, #8
c0d02d92:	bdb0      	pop	{r4, r5, r7, pc}
c0d02d94:	20f0      	movs	r0, #240	; 0xf0
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02d96:	5820      	ldr	r0, [r4, r0]
c0d02d98:	6840      	ldr	r0, [r0, #4]
c0d02d9a:	e7b2      	b.n	c0d02d02 <USBD_GetDescriptor+0x5a>
c0d02d9c:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02d9e:	5820      	ldr	r0, [r4, r0]
c0d02da0:	6900      	ldr	r0, [r0, #16]
c0d02da2:	e7ae      	b.n	c0d02d02 <USBD_GetDescriptor+0x5a>
c0d02da4:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d02da6:	5820      	ldr	r0, [r4, r0]
c0d02da8:	6880      	ldr	r0, [r0, #8]
c0d02daa:	e7aa      	b.n	c0d02d02 <USBD_GetDescriptor+0x5a>
c0d02dac:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02dae:	5820      	ldr	r0, [r4, r0]
c0d02db0:	6940      	ldr	r0, [r0, #20]
c0d02db2:	e7a6      	b.n	c0d02d02 <USBD_GetDescriptor+0x5a>

c0d02db4 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02db4:	b570      	push	{r4, r5, r6, lr}
c0d02db6:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d02db8:	8888      	ldrh	r0, [r1, #4]
c0d02dba:	2800      	cmp	r0, #0
c0d02dbc:	d10b      	bne.n	c0d02dd6 <USBD_SetAddress+0x22>
c0d02dbe:	88c8      	ldrh	r0, [r1, #6]
c0d02dc0:	2800      	cmp	r0, #0
c0d02dc2:	d108      	bne.n	c0d02dd6 <USBD_SetAddress+0x22>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d02dc4:	8848      	ldrh	r0, [r1, #2]
c0d02dc6:	257f      	movs	r5, #127	; 0x7f
c0d02dc8:	4005      	ands	r5, r0
c0d02dca:	20dc      	movs	r0, #220	; 0xdc
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d02dcc:	5c20      	ldrb	r0, [r4, r0]
c0d02dce:	4626      	mov	r6, r4
c0d02dd0:	36dc      	adds	r6, #220	; 0xdc
c0d02dd2:	2803      	cmp	r0, #3
c0d02dd4:	d103      	bne.n	c0d02dde <USBD_SetAddress+0x2a>
c0d02dd6:	4620      	mov	r0, r4
c0d02dd8:	f000 fb42 	bl	c0d03460 <USBD_CtlError>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02ddc:	bd70      	pop	{r4, r5, r6, pc}
c0d02dde:	20de      	movs	r0, #222	; 0xde
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d02de0:	5425      	strb	r5, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02de2:	4620      	mov	r0, r4
c0d02de4:	4629      	mov	r1, r5
c0d02de6:	f7ff fd2b 	bl	c0d02840 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d02dea:	4620      	mov	r0, r4
c0d02dec:	f000 fc31 	bl	c0d03652 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d02df0:	2d00      	cmp	r5, #0
c0d02df2:	d002      	beq.n	c0d02dfa <USBD_SetAddress+0x46>
c0d02df4:	2002      	movs	r0, #2
      {
        pdev->dev_state  = USBD_STATE_ADDRESSED;
c0d02df6:	7030      	strb	r0, [r6, #0]
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02df8:	bd70      	pop	{r4, r5, r6, pc}
c0d02dfa:	2001      	movs	r0, #1
      {
        pdev->dev_state  = USBD_STATE_ADDRESSED;
      } 
      else 
      {
        pdev->dev_state  = USBD_STATE_DEFAULT; 
c0d02dfc:	7030      	strb	r0, [r6, #0]
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02dfe:	bd70      	pop	{r4, r5, r6, pc}

c0d02e00 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02e00:	b570      	push	{r4, r5, r6, lr}
c0d02e02:	460d      	mov	r5, r1
c0d02e04:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02e06:	788e      	ldrb	r6, [r1, #2]
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02e08:	2e02      	cmp	r6, #2
c0d02e0a:	d21d      	bcs.n	c0d02e48 <USBD_SetConfig+0x48>
c0d02e0c:	20dc      	movs	r0, #220	; 0xdc
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d02e0e:	5c21      	ldrb	r1, [r4, r0]
c0d02e10:	4620      	mov	r0, r4
c0d02e12:	30dc      	adds	r0, #220	; 0xdc
c0d02e14:	2903      	cmp	r1, #3
c0d02e16:	d007      	beq.n	c0d02e28 <USBD_SetConfig+0x28>
c0d02e18:	2902      	cmp	r1, #2
c0d02e1a:	d115      	bne.n	c0d02e48 <USBD_SetConfig+0x48>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d02e1c:	2e00      	cmp	r6, #0
c0d02e1e:	d022      	beq.n	c0d02e66 <USBD_SetConfig+0x66>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d02e20:	6066      	str	r6, [r4, #4]
c0d02e22:	2103      	movs	r1, #3
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d02e24:	7001      	strb	r1, [r0, #0]
c0d02e26:	e009      	b.n	c0d02e3c <USBD_SetConfig+0x3c>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d02e28:	2e00      	cmp	r6, #0
c0d02e2a:	d012      	beq.n	c0d02e52 <USBD_SetConfig+0x52>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d02e2c:	6860      	ldr	r0, [r4, #4]
c0d02e2e:	42b0      	cmp	r0, r6
c0d02e30:	d019      	beq.n	c0d02e66 <USBD_SetConfig+0x66>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d02e32:	b2c1      	uxtb	r1, r0
c0d02e34:	4620      	mov	r0, r4
c0d02e36:	f7ff fda5 	bl	c0d02984 <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d02e3a:	6066      	str	r6, [r4, #4]
c0d02e3c:	4620      	mov	r0, r4
c0d02e3e:	4631      	mov	r1, r6
c0d02e40:	f7ff fd85 	bl	c0d0294e <USBD_SetClassConfig>
c0d02e44:	2802      	cmp	r0, #2
c0d02e46:	d10e      	bne.n	c0d02e66 <USBD_SetConfig+0x66>
c0d02e48:	4620      	mov	r0, r4
c0d02e4a:	4629      	mov	r1, r5
c0d02e4c:	f000 fb08 	bl	c0d03460 <USBD_CtlError>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02e50:	bd70      	pop	{r4, r5, r6, pc}
c0d02e52:	2102      	movs	r1, #2
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d02e54:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d02e56:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d02e58:	4620      	mov	r0, r4
c0d02e5a:	4631      	mov	r1, r6
c0d02e5c:	f7ff fd92 	bl	c0d02984 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d02e60:	4620      	mov	r0, r4
c0d02e62:	f000 fbf6 	bl	c0d03652 <USBD_CtlSendStatus>
c0d02e66:	4620      	mov	r0, r4
c0d02e68:	f000 fbf3 	bl	c0d03652 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d02e6c:	bd70      	pop	{r4, r5, r6, pc}

c0d02e6e <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02e6e:	b580      	push	{r7, lr}

  if (req->wLength != 1) 
c0d02e70:	88ca      	ldrh	r2, [r1, #6]
c0d02e72:	2a01      	cmp	r2, #1
c0d02e74:	d10a      	bne.n	c0d02e8c <USBD_GetConfig+0x1e>
c0d02e76:	22dc      	movs	r2, #220	; 0xdc
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02e78:	5c82      	ldrb	r2, [r0, r2]
c0d02e7a:	2a03      	cmp	r2, #3
c0d02e7c:	d009      	beq.n	c0d02e92 <USBD_GetConfig+0x24>
c0d02e7e:	2a02      	cmp	r2, #2
c0d02e80:	d104      	bne.n	c0d02e8c <USBD_GetConfig+0x1e>
c0d02e82:	2100      	movs	r1, #0
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02e84:	6081      	str	r1, [r0, #8]
c0d02e86:	4601      	mov	r1, r0
c0d02e88:	3108      	adds	r1, #8
c0d02e8a:	e003      	b.n	c0d02e94 <USBD_GetConfig+0x26>
c0d02e8c:	f000 fae8 	bl	c0d03460 <USBD_CtlError>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02e90:	bd80      	pop	{r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d02e92:	1d01      	adds	r1, r0, #4
c0d02e94:	2201      	movs	r2, #1
c0d02e96:	f000 fbb1 	bl	c0d035fc <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d02e9a:	bd80      	pop	{r7, pc}

c0d02e9c <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d02e9c:	b5b0      	push	{r4, r5, r7, lr}
c0d02e9e:	4604      	mov	r4, r0
c0d02ea0:	20dc      	movs	r0, #220	; 0xdc
  
    
  switch (pdev->dev_state) 
c0d02ea2:	5c20      	ldrb	r0, [r4, r0]
c0d02ea4:	22fe      	movs	r2, #254	; 0xfe
c0d02ea6:	4002      	ands	r2, r0
c0d02ea8:	2a02      	cmp	r2, #2
c0d02eaa:	d115      	bne.n	c0d02ed8 <USBD_GetStatus+0x3c>
c0d02eac:	2001      	movs	r0, #1
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02eae:	60e0      	str	r0, [r4, #12]
c0d02eb0:	20e4      	movs	r0, #228	; 0xe4
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02eb2:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02eb4:	4625      	mov	r5, r4
c0d02eb6:	350c      	adds	r5, #12
c0d02eb8:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02eba:	2900      	cmp	r1, #0
c0d02ebc:	d005      	beq.n	c0d02eca <USBD_GetStatus+0x2e>
c0d02ebe:	4620      	mov	r0, r4
c0d02ec0:	f000 fbd3 	bl	c0d0366a <USBD_CtlReceiveStatus>
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02ec4:	68e1      	ldr	r1, [r4, #12]
c0d02ec6:	2002      	movs	r0, #2
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02ec8:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02eca:	60e0      	str	r0, [r4, #12]
c0d02ecc:	2202      	movs	r2, #2
    }
    
    USBD_CtlSendData (pdev, 
c0d02ece:	4620      	mov	r0, r4
c0d02ed0:	4629      	mov	r1, r5
c0d02ed2:	f000 fb93 	bl	c0d035fc <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d02ed6:	bdb0      	pop	{r4, r5, r7, pc}
                      (uint8_t *)& pdev->dev_config_status,
                      2);
    break;
    
  default :
    USBD_CtlError(pdev , req);                        
c0d02ed8:	4620      	mov	r0, r4
c0d02eda:	f000 fac1 	bl	c0d03460 <USBD_CtlError>
    break;
  }
}
c0d02ede:	bdb0      	pop	{r4, r5, r7, pc}

c0d02ee0 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02ee0:	b5b0      	push	{r4, r5, r7, lr}
c0d02ee2:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02ee4:	8848      	ldrh	r0, [r1, #2]
c0d02ee6:	2801      	cmp	r0, #1
c0d02ee8:	d116      	bne.n	c0d02f18 <USBD_SetFeature+0x38>
c0d02eea:	460d      	mov	r5, r1
c0d02eec:	20e4      	movs	r0, #228	; 0xe4
c0d02eee:	2101      	movs	r1, #1
  {
    pdev->dev_remote_wakeup = 1;  
c0d02ef0:	5021      	str	r1, [r4, r0]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02ef2:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02ef4:	2802      	cmp	r0, #2
c0d02ef6:	d80c      	bhi.n	c0d02f12 <USBD_SetFeature+0x32>
c0d02ef8:	00c0      	lsls	r0, r0, #3
c0d02efa:	1820      	adds	r0, r4, r0
c0d02efc:	21f4      	movs	r1, #244	; 0xf4
c0d02efe:	5840      	ldr	r0, [r0, r1]
{

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
  {
    pdev->dev_remote_wakeup = 1;  
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02f00:	2800      	cmp	r0, #0
c0d02f02:	d006      	beq.n	c0d02f12 <USBD_SetFeature+0x32>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d02f04:	6880      	ldr	r0, [r0, #8]
c0d02f06:	f7fe fcc3 	bl	c0d01890 <pic>
c0d02f0a:	4602      	mov	r2, r0
c0d02f0c:	4620      	mov	r0, r4
c0d02f0e:	4629      	mov	r1, r5
c0d02f10:	4790      	blx	r2
    }
    USBD_CtlSendStatus(pdev);
c0d02f12:	4620      	mov	r0, r4
c0d02f14:	f000 fb9d 	bl	c0d03652 <USBD_CtlSendStatus>
  }

}
c0d02f18:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f1a <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02f1a:	b5b0      	push	{r4, r5, r7, lr}
c0d02f1c:	460d      	mov	r5, r1
c0d02f1e:	4604      	mov	r4, r0
c0d02f20:	20dc      	movs	r0, #220	; 0xdc
  switch (pdev->dev_state)
c0d02f22:	5c20      	ldrb	r0, [r4, r0]
c0d02f24:	21fe      	movs	r1, #254	; 0xfe
c0d02f26:	4001      	ands	r1, r0
c0d02f28:	2902      	cmp	r1, #2
c0d02f2a:	d119      	bne.n	c0d02f60 <USBD_ClrFeature+0x46>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d02f2c:	8868      	ldrh	r0, [r5, #2]
c0d02f2e:	2801      	cmp	r0, #1
c0d02f30:	d11a      	bne.n	c0d02f68 <USBD_ClrFeature+0x4e>
c0d02f32:	20e4      	movs	r0, #228	; 0xe4
c0d02f34:	2100      	movs	r1, #0
    {
      pdev->dev_remote_wakeup = 0; 
c0d02f36:	5021      	str	r1, [r4, r0]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02f38:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02f3a:	2802      	cmp	r0, #2
c0d02f3c:	d80c      	bhi.n	c0d02f58 <USBD_ClrFeature+0x3e>
c0d02f3e:	00c0      	lsls	r0, r0, #3
c0d02f40:	1820      	adds	r0, r4, r0
c0d02f42:	21f4      	movs	r1, #244	; 0xf4
c0d02f44:	5840      	ldr	r0, [r0, r1]
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
    {
      pdev->dev_remote_wakeup = 0; 
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02f46:	2800      	cmp	r0, #0
c0d02f48:	d006      	beq.n	c0d02f58 <USBD_ClrFeature+0x3e>
        ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d02f4a:	6880      	ldr	r0, [r0, #8]
c0d02f4c:	f7fe fca0 	bl	c0d01890 <pic>
c0d02f50:	4602      	mov	r2, r0
c0d02f52:	4620      	mov	r0, r4
c0d02f54:	4629      	mov	r1, r5
c0d02f56:	4790      	blx	r2
      }
      USBD_CtlSendStatus(pdev);
c0d02f58:	4620      	mov	r0, r4
c0d02f5a:	f000 fb7a 	bl	c0d03652 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02f5e:	bdb0      	pop	{r4, r5, r7, pc}
      USBD_CtlSendStatus(pdev);
    }
    break;
    
  default :
     USBD_CtlError(pdev , req);
c0d02f60:	4620      	mov	r0, r4
c0d02f62:	4629      	mov	r1, r5
c0d02f64:	f000 fa7c 	bl	c0d03460 <USBD_CtlError>
    break;
  }
}
c0d02f68:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f6a <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02f6a:	b5b0      	push	{r4, r5, r7, lr}
c0d02f6c:	460d      	mov	r5, r1
c0d02f6e:	4604      	mov	r4, r0
c0d02f70:	20dc      	movs	r0, #220	; 0xdc
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02f72:	5c20      	ldrb	r0, [r4, r0]
c0d02f74:	2803      	cmp	r0, #3
c0d02f76:	d116      	bne.n	c0d02fa6 <USBD_StdItfReq+0x3c>
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d02f78:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02f7a:	2802      	cmp	r0, #2
c0d02f7c:	d813      	bhi.n	c0d02fa6 <USBD_StdItfReq+0x3c>
c0d02f7e:	00c0      	lsls	r0, r0, #3
c0d02f80:	1820      	adds	r0, r4, r0
c0d02f82:	21f4      	movs	r1, #244	; 0xf4
c0d02f84:	5840      	ldr	r0, [r0, r1]
  
  switch (pdev->dev_state) 
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d02f86:	2800      	cmp	r0, #0
c0d02f88:	d00d      	beq.n	c0d02fa6 <USBD_StdItfReq+0x3c>
    {
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d02f8a:	6880      	ldr	r0, [r0, #8]
c0d02f8c:	f7fe fc80 	bl	c0d01890 <pic>
c0d02f90:	4602      	mov	r2, r0
c0d02f92:	4620      	mov	r0, r4
c0d02f94:	4629      	mov	r1, r5
c0d02f96:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d02f98:	88e8      	ldrh	r0, [r5, #6]
c0d02f9a:	2800      	cmp	r0, #0
c0d02f9c:	d107      	bne.n	c0d02fae <USBD_StdItfReq+0x44>
      {
         USBD_CtlSendStatus(pdev);
c0d02f9e:	4620      	mov	r0, r4
c0d02fa0:	f000 fb57 	bl	c0d03652 <USBD_CtlSendStatus>
c0d02fa4:	e003      	b.n	c0d02fae <USBD_StdItfReq+0x44>
c0d02fa6:	4620      	mov	r0, r4
c0d02fa8:	4629      	mov	r1, r5
c0d02faa:	f000 fa59 	bl	c0d03460 <USBD_CtlError>
c0d02fae:	2000      	movs	r0, #0
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d02fb0:	bdb0      	pop	{r4, r5, r7, pc}

c0d02fb2 <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d02fb2:	b5b0      	push	{r4, r5, r7, lr}
c0d02fb4:	460d      	mov	r5, r1
c0d02fb6:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d02fb8:	7808      	ldrb	r0, [r1, #0]
c0d02fba:	2260      	movs	r2, #96	; 0x60
c0d02fbc:	4002      	ands	r2, r0
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02fbe:	7909      	ldrb	r1, [r1, #4]
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d02fc0:	2a20      	cmp	r2, #32
c0d02fc2:	d10f      	bne.n	c0d02fe4 <USBD_StdEPReq+0x32>
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02fc4:	2902      	cmp	r1, #2
c0d02fc6:	d80d      	bhi.n	c0d02fe4 <USBD_StdEPReq+0x32>
c0d02fc8:	00c8      	lsls	r0, r1, #3
c0d02fca:	1820      	adds	r0, r4, r0
c0d02fcc:	22f4      	movs	r2, #244	; 0xf4
c0d02fce:	5880      	ldr	r0, [r0, r2]
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d02fd0:	2800      	cmp	r0, #0
c0d02fd2:	d007      	beq.n	c0d02fe4 <USBD_StdEPReq+0x32>
  {
    ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d02fd4:	6880      	ldr	r0, [r0, #8]
c0d02fd6:	f7fe fc5b 	bl	c0d01890 <pic>
c0d02fda:	4602      	mov	r2, r0
c0d02fdc:	4620      	mov	r0, r4
c0d02fde:	4629      	mov	r1, r5
c0d02fe0:	4790      	blx	r2
c0d02fe2:	e068      	b.n	c0d030b6 <USBD_StdEPReq+0x104>
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d02fe4:	7868      	ldrb	r0, [r5, #1]
c0d02fe6:	2800      	cmp	r0, #0
c0d02fe8:	d016      	beq.n	c0d03018 <USBD_StdEPReq+0x66>
c0d02fea:	2801      	cmp	r0, #1
c0d02fec:	d01d      	beq.n	c0d0302a <USBD_StdEPReq+0x78>
c0d02fee:	2803      	cmp	r0, #3
c0d02ff0:	d161      	bne.n	c0d030b6 <USBD_StdEPReq+0x104>
c0d02ff2:	20dc      	movs	r0, #220	; 0xdc
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d02ff4:	5c20      	ldrb	r0, [r4, r0]
c0d02ff6:	2803      	cmp	r0, #3
c0d02ff8:	d11b      	bne.n	c0d03032 <USBD_StdEPReq+0x80>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02ffa:	8868      	ldrh	r0, [r5, #2]
c0d02ffc:	2800      	cmp	r0, #0
c0d02ffe:	d107      	bne.n	c0d03010 <USBD_StdEPReq+0x5e>
c0d03000:	2080      	movs	r0, #128	; 0x80
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d03002:	4308      	orrs	r0, r1
c0d03004:	2880      	cmp	r0, #128	; 0x80
c0d03006:	d003      	beq.n	c0d03010 <USBD_StdEPReq+0x5e>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d03008:	4620      	mov	r0, r4
c0d0300a:	f7ff fbc1 	bl	c0d02790 <USBD_LL_StallEP>
          
        }
c0d0300e:	7929      	ldrb	r1, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d03010:	2902      	cmp	r1, #2
c0d03012:	d84d      	bhi.n	c0d030b0 <USBD_StdEPReq+0xfe>
c0d03014:	00c8      	lsls	r0, r1, #3
c0d03016:	e03f      	b.n	c0d03098 <USBD_StdEPReq+0xe6>
c0d03018:	20dc      	movs	r0, #220	; 0xdc
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d0301a:	5c20      	ldrb	r0, [r4, r0]
c0d0301c:	2803      	cmp	r0, #3
c0d0301e:	d017      	beq.n	c0d03050 <USBD_StdEPReq+0x9e>
c0d03020:	2802      	cmp	r0, #2
c0d03022:	d110      	bne.n	c0d03046 <USBD_StdEPReq+0x94>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d03024:	0648      	lsls	r0, r1, #25
c0d03026:	d10a      	bne.n	c0d0303e <USBD_StdEPReq+0x8c>
c0d03028:	e045      	b.n	c0d030b6 <USBD_StdEPReq+0x104>
c0d0302a:	20dc      	movs	r0, #220	; 0xdc
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d0302c:	5c20      	ldrb	r0, [r4, r0]
c0d0302e:	2803      	cmp	r0, #3
c0d03030:	d026      	beq.n	c0d03080 <USBD_StdEPReq+0xce>
c0d03032:	2802      	cmp	r0, #2
c0d03034:	d107      	bne.n	c0d03046 <USBD_StdEPReq+0x94>
c0d03036:	2080      	movs	r0, #128	; 0x80
c0d03038:	4308      	orrs	r0, r1
c0d0303a:	2880      	cmp	r0, #128	; 0x80
c0d0303c:	d03b      	beq.n	c0d030b6 <USBD_StdEPReq+0x104>
c0d0303e:	4620      	mov	r0, r4
c0d03040:	f7ff fba6 	bl	c0d02790 <USBD_LL_StallEP>
c0d03044:	e037      	b.n	c0d030b6 <USBD_StdEPReq+0x104>
c0d03046:	4620      	mov	r0, r4
c0d03048:	4629      	mov	r1, r5
c0d0304a:	f000 fa09 	bl	c0d03460 <USBD_CtlError>
c0d0304e:	e032      	b.n	c0d030b6 <USBD_StdEPReq+0x104>
c0d03050:	207f      	movs	r0, #127	; 0x7f
c0d03052:	4008      	ands	r0, r1
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d03054:	0100      	lsls	r0, r0, #4
c0d03056:	1820      	adds	r0, r4, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d03058:	4605      	mov	r5, r0
c0d0305a:	3574      	adds	r5, #116	; 0x74
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d0305c:	3014      	adds	r0, #20
c0d0305e:	060a      	lsls	r2, r1, #24
c0d03060:	d500      	bpl.n	c0d03064 <USBD_StdEPReq+0xb2>
c0d03062:	4605      	mov	r5, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d03064:	4620      	mov	r0, r4
c0d03066:	f7ff fbdb 	bl	c0d02820 <USBD_LL_IsStallEP>
c0d0306a:	2101      	movs	r1, #1
c0d0306c:	2800      	cmp	r0, #0
c0d0306e:	d100      	bne.n	c0d03072 <USBD_StdEPReq+0xc0>
c0d03070:	4601      	mov	r1, r0
c0d03072:	6029      	str	r1, [r5, #0]
c0d03074:	2202      	movs	r2, #2
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d03076:	4620      	mov	r0, r4
c0d03078:	4629      	mov	r1, r5
c0d0307a:	f000 fabf 	bl	c0d035fc <USBD_CtlSendData>
c0d0307e:	e01a      	b.n	c0d030b6 <USBD_StdEPReq+0x104>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d03080:	8868      	ldrh	r0, [r5, #2]
c0d03082:	2800      	cmp	r0, #0
c0d03084:	d117      	bne.n	c0d030b6 <USBD_StdEPReq+0x104>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d03086:	0648      	lsls	r0, r1, #25
c0d03088:	d012      	beq.n	c0d030b0 <USBD_StdEPReq+0xfe>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d0308a:	4620      	mov	r0, r4
c0d0308c:	f7ff fba4 	bl	c0d027d8 <USBD_LL_ClearStallEP>
          if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d03090:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d03092:	2802      	cmp	r0, #2
c0d03094:	d80c      	bhi.n	c0d030b0 <USBD_StdEPReq+0xfe>
c0d03096:	00c0      	lsls	r0, r0, #3
c0d03098:	1820      	adds	r0, r4, r0
c0d0309a:	21f4      	movs	r1, #244	; 0xf4
c0d0309c:	5840      	ldr	r0, [r0, r1]
c0d0309e:	2800      	cmp	r0, #0
c0d030a0:	d006      	beq.n	c0d030b0 <USBD_StdEPReq+0xfe>
c0d030a2:	6880      	ldr	r0, [r0, #8]
c0d030a4:	f7fe fbf4 	bl	c0d01890 <pic>
c0d030a8:	4602      	mov	r2, r0
c0d030aa:	4620      	mov	r0, r4
c0d030ac:	4629      	mov	r1, r5
c0d030ae:	4790      	blx	r2
c0d030b0:	4620      	mov	r0, r4
c0d030b2:	f000 face 	bl	c0d03652 <USBD_CtlSendStatus>
c0d030b6:	2000      	movs	r0, #0
    
  default:
    break;
  }
  return ret;
}
c0d030b8:	bdb0      	pop	{r4, r5, r7, pc}

c0d030ba <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d030ba:	780a      	ldrb	r2, [r1, #0]
c0d030bc:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d030be:	784a      	ldrb	r2, [r1, #1]
c0d030c0:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d030c2:	788a      	ldrb	r2, [r1, #2]
c0d030c4:	78cb      	ldrb	r3, [r1, #3]
c0d030c6:	021b      	lsls	r3, r3, #8
c0d030c8:	189a      	adds	r2, r3, r2
c0d030ca:	8042      	strh	r2, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d030cc:	790a      	ldrb	r2, [r1, #4]
c0d030ce:	794b      	ldrb	r3, [r1, #5]
c0d030d0:	021b      	lsls	r3, r3, #8
c0d030d2:	189a      	adds	r2, r3, r2
c0d030d4:	8082      	strh	r2, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d030d6:	798a      	ldrb	r2, [r1, #6]
c0d030d8:	79c9      	ldrb	r1, [r1, #7]
c0d030da:	0209      	lsls	r1, r1, #8
c0d030dc:	1889      	adds	r1, r1, r2
c0d030de:	80c1      	strh	r1, [r0, #6]

}
c0d030e0:	4770      	bx	lr

c0d030e2 <USBD_CtlStall>:
* @param  pdev: device instance
* @param  req: usb request
* @retval None
*/
void USBD_CtlStall( USBD_HandleTypeDef *pdev)
{
c0d030e2:	b510      	push	{r4, lr}
c0d030e4:	4604      	mov	r4, r0
c0d030e6:	2180      	movs	r1, #128	; 0x80
  USBD_LL_StallEP(pdev , 0x80);
c0d030e8:	f7ff fb52 	bl	c0d02790 <USBD_LL_StallEP>
c0d030ec:	2100      	movs	r1, #0
  USBD_LL_StallEP(pdev , 0);
c0d030ee:	4620      	mov	r0, r4
c0d030f0:	f7ff fb4e 	bl	c0d02790 <USBD_LL_StallEP>
}
c0d030f4:	bd10      	pop	{r4, pc}

c0d030f6 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d030f6:	b570      	push	{r4, r5, r6, lr}
c0d030f8:	b082      	sub	sp, #8
c0d030fa:	460d      	mov	r5, r1
c0d030fc:	4604      	mov	r4, r0
c0d030fe:	a901      	add	r1, sp, #4
c0d03100:	2000      	movs	r0, #0
  uint16_t len = 0;
c0d03102:	8008      	strh	r0, [r1, #0]
c0d03104:	4669      	mov	r1, sp
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d03106:	7008      	strb	r0, [r1, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d03108:	782a      	ldrb	r2, [r5, #0]
c0d0310a:	2160      	movs	r1, #96	; 0x60
c0d0310c:	4011      	ands	r1, r2
c0d0310e:	2900      	cmp	r1, #0
c0d03110:	d010      	beq.n	c0d03134 <USBD_HID_Setup+0x3e>
c0d03112:	2920      	cmp	r1, #32
c0d03114:	d138      	bne.n	c0d03188 <USBD_HID_Setup+0x92>
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d03116:	7869      	ldrb	r1, [r5, #1]
c0d03118:	460a      	mov	r2, r1
c0d0311a:	3a0a      	subs	r2, #10
c0d0311c:	2a02      	cmp	r2, #2
c0d0311e:	d333      	bcc.n	c0d03188 <USBD_HID_Setup+0x92>
c0d03120:	2902      	cmp	r1, #2
c0d03122:	d01b      	beq.n	c0d0315c <USBD_HID_Setup+0x66>
c0d03124:	2903      	cmp	r1, #3
c0d03126:	d019      	beq.n	c0d0315c <USBD_HID_Setup+0x66>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d03128:	4620      	mov	r0, r4
c0d0312a:	4629      	mov	r1, r5
c0d0312c:	f000 f998 	bl	c0d03460 <USBD_CtlError>
c0d03130:	2002      	movs	r0, #2
c0d03132:	e029      	b.n	c0d03188 <USBD_HID_Setup+0x92>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d03134:	7869      	ldrb	r1, [r5, #1]
c0d03136:	290b      	cmp	r1, #11
c0d03138:	d013      	beq.n	c0d03162 <USBD_HID_Setup+0x6c>
c0d0313a:	290a      	cmp	r1, #10
c0d0313c:	d00e      	beq.n	c0d0315c <USBD_HID_Setup+0x66>
c0d0313e:	2906      	cmp	r1, #6
c0d03140:	d122      	bne.n	c0d03188 <USBD_HID_Setup+0x92>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d03142:	8868      	ldrh	r0, [r5, #2]
c0d03144:	0a00      	lsrs	r0, r0, #8
c0d03146:	2200      	movs	r2, #0
c0d03148:	2821      	cmp	r0, #33	; 0x21
c0d0314a:	d00e      	beq.n	c0d0316a <USBD_HID_Setup+0x74>
c0d0314c:	2822      	cmp	r0, #34	; 0x22
c0d0314e:	4611      	mov	r1, r2
c0d03150:	d116      	bne.n	c0d03180 <USBD_HID_Setup+0x8a>
c0d03152:	ae01      	add	r6, sp, #4
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d03154:	4630      	mov	r0, r6
c0d03156:	f000 f857 	bl	c0d03208 <USBD_HID_GetReportDescriptor_impl>
c0d0315a:	e00a      	b.n	c0d03172 <USBD_HID_Setup+0x7c>
c0d0315c:	4669      	mov	r1, sp
c0d0315e:	2201      	movs	r2, #1
c0d03160:	e00e      	b.n	c0d03180 <USBD_HID_Setup+0x8a>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d03162:	4620      	mov	r0, r4
c0d03164:	f000 fa75 	bl	c0d03652 <USBD_CtlSendStatus>
c0d03168:	e00d      	b.n	c0d03186 <USBD_HID_Setup+0x90>
c0d0316a:	ae01      	add	r6, sp, #4
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d0316c:	4630      	mov	r0, r6
c0d0316e:	f000 f831 	bl	c0d031d4 <USBD_HID_GetHidDescriptor_impl>
c0d03172:	4601      	mov	r1, r0
c0d03174:	8832      	ldrh	r2, [r6, #0]
c0d03176:	88e8      	ldrh	r0, [r5, #6]
c0d03178:	4282      	cmp	r2, r0
c0d0317a:	d300      	bcc.n	c0d0317e <USBD_HID_Setup+0x88>
c0d0317c:	4602      	mov	r2, r0
c0d0317e:	8032      	strh	r2, [r6, #0]
c0d03180:	4620      	mov	r0, r4
c0d03182:	f000 fa3b 	bl	c0d035fc <USBD_CtlSendData>
c0d03186:	2000      	movs	r0, #0
      
    }
  }

  return USBD_OK;
}
c0d03188:	b002      	add	sp, #8
c0d0318a:	bd70      	pop	{r4, r5, r6, pc}

c0d0318c <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d0318c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0318e:	b081      	sub	sp, #4
c0d03190:	4604      	mov	r4, r0
c0d03192:	2182      	movs	r1, #130	; 0x82
c0d03194:	2603      	movs	r6, #3
c0d03196:	2540      	movs	r5, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d03198:	4632      	mov	r2, r6
c0d0319a:	462b      	mov	r3, r5
c0d0319c:	f7ff fab2 	bl	c0d02704 <USBD_LL_OpenEP>
c0d031a0:	2702      	movs	r7, #2
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d031a2:	4620      	mov	r0, r4
c0d031a4:	4639      	mov	r1, r7
c0d031a6:	4632      	mov	r2, r6
c0d031a8:	462b      	mov	r3, r5
c0d031aa:	f7ff faab 	bl	c0d02704 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d031ae:	4620      	mov	r0, r4
c0d031b0:	4639      	mov	r1, r7
c0d031b2:	462a      	mov	r2, r5
c0d031b4:	f7ff fb6f 	bl	c0d02896 <USBD_LL_PrepareReceive>
c0d031b8:	2000      	movs	r0, #0
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d031ba:	b001      	add	sp, #4
c0d031bc:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d031be <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d031be:	b510      	push	{r4, lr}
c0d031c0:	4604      	mov	r4, r0
c0d031c2:	2182      	movs	r1, #130	; 0x82
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d031c4:	f7ff face 	bl	c0d02764 <USBD_LL_CloseEP>
c0d031c8:	2102      	movs	r1, #2
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d031ca:	4620      	mov	r0, r4
c0d031cc:	f7ff faca 	bl	c0d02764 <USBD_LL_CloseEP>
c0d031d0:	2000      	movs	r0, #0
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d031d2:	bd10      	pop	{r4, pc}

c0d031d4 <USBD_HID_GetHidDescriptor_impl>:
{
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
c0d031d4:	21ec      	movs	r1, #236	; 0xec
  switch (USBD_Device.request.wIndex&0xFF) {
c0d031d6:	4a09      	ldr	r2, [pc, #36]	; (c0d031fc <USBD_HID_GetHidDescriptor_impl+0x28>)
c0d031d8:	5c51      	ldrb	r1, [r2, r1]
c0d031da:	2209      	movs	r2, #9
c0d031dc:	2901      	cmp	r1, #1
c0d031de:	d005      	beq.n	c0d031ec <USBD_HID_GetHidDescriptor_impl+0x18>
c0d031e0:	2900      	cmp	r1, #0
c0d031e2:	d106      	bne.n	c0d031f2 <USBD_HID_GetHidDescriptor_impl+0x1e>
c0d031e4:	4907      	ldr	r1, [pc, #28]	; (c0d03204 <USBD_HID_GetHidDescriptor_impl+0x30>)
c0d031e6:	4479      	add	r1, pc
c0d031e8:	2209      	movs	r2, #9
c0d031ea:	e004      	b.n	c0d031f6 <USBD_HID_GetHidDescriptor_impl+0x22>
c0d031ec:	4904      	ldr	r1, [pc, #16]	; (c0d03200 <USBD_HID_GetHidDescriptor_impl+0x2c>)
c0d031ee:	4479      	add	r1, pc
c0d031f0:	e001      	b.n	c0d031f6 <USBD_HID_GetHidDescriptor_impl+0x22>
c0d031f2:	2200      	movs	r2, #0
c0d031f4:	4611      	mov	r1, r2
c0d031f6:	8002      	strh	r2, [r0, #0]
      *len = sizeof(USBD_HID_Desc);
      return (uint8_t*)USBD_HID_Desc; 
  }
  *len = 0;
  return 0;
}
c0d031f8:	4608      	mov	r0, r1
c0d031fa:	4770      	bx	lr
c0d031fc:	20001dac 	.word	0x20001dac
c0d03200:	00001a56 	.word	0x00001a56
c0d03204:	00001a6a 	.word	0x00001a6a

c0d03208 <USBD_HID_GetReportDescriptor_impl>:

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
c0d03208:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0320a:	b081      	sub	sp, #4
c0d0320c:	4604      	mov	r4, r0
c0d0320e:	20ec      	movs	r0, #236	; 0xec
  switch (USBD_Device.request.wIndex&0xFF) {
c0d03210:	4913      	ldr	r1, [pc, #76]	; (c0d03260 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d03212:	5c08      	ldrb	r0, [r1, r0]
c0d03214:	2122      	movs	r1, #34	; 0x22
c0d03216:	2800      	cmp	r0, #0
c0d03218:	d019      	beq.n	c0d0324e <USBD_HID_GetReportDescriptor_impl+0x46>
c0d0321a:	2801      	cmp	r0, #1
c0d0321c:	d11a      	bne.n	c0d03254 <USBD_HID_GetReportDescriptor_impl+0x4c>
#ifdef HAVE_IO_U2F
  case U2F_INTF:

    // very dirty work due to lack of callback when USB_HID_Init is called
    USBD_LL_OpenEP(&USBD_Device,
c0d0321e:	4810      	ldr	r0, [pc, #64]	; (c0d03260 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d03220:	2181      	movs	r1, #129	; 0x81
c0d03222:	2703      	movs	r7, #3
c0d03224:	2640      	movs	r6, #64	; 0x40
c0d03226:	463a      	mov	r2, r7
c0d03228:	4633      	mov	r3, r6
c0d0322a:	f7ff fa6b 	bl	c0d02704 <USBD_LL_OpenEP>
c0d0322e:	2501      	movs	r5, #1
                   U2F_EPIN_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPIN_SIZE);
    
    USBD_LL_OpenEP(&USBD_Device,
c0d03230:	480b      	ldr	r0, [pc, #44]	; (c0d03260 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d03232:	4629      	mov	r1, r5
c0d03234:	463a      	mov	r2, r7
c0d03236:	4633      	mov	r3, r6
c0d03238:	f7ff fa64 	bl	c0d02704 <USBD_LL_OpenEP>
                   U2F_EPOUT_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPOUT_SIZE);

    /* Prepare Out endpoint to receive 1st packet */ 
    USBD_LL_PrepareReceive(&USBD_Device, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d0323c:	4808      	ldr	r0, [pc, #32]	; (c0d03260 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d0323e:	4629      	mov	r1, r5
c0d03240:	4632      	mov	r2, r6
c0d03242:	f7ff fb28 	bl	c0d02896 <USBD_LL_PrepareReceive>
c0d03246:	4808      	ldr	r0, [pc, #32]	; (c0d03268 <USBD_HID_GetReportDescriptor_impl+0x60>)
c0d03248:	4478      	add	r0, pc
c0d0324a:	2122      	movs	r1, #34	; 0x22
c0d0324c:	e004      	b.n	c0d03258 <USBD_HID_GetReportDescriptor_impl+0x50>
c0d0324e:	4805      	ldr	r0, [pc, #20]	; (c0d03264 <USBD_HID_GetReportDescriptor_impl+0x5c>)
c0d03250:	4478      	add	r0, pc
c0d03252:	e001      	b.n	c0d03258 <USBD_HID_GetReportDescriptor_impl+0x50>
c0d03254:	2100      	movs	r1, #0
c0d03256:	4608      	mov	r0, r1
c0d03258:	8021      	strh	r1, [r4, #0]
    *len = sizeof(HID_ReportDesc);
    return (uint8_t*)HID_ReportDesc;
  }
  *len = 0;
  return 0;
}
c0d0325a:	b001      	add	sp, #4
c0d0325c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0325e:	46c0      	nop			; (mov r8, r8)
c0d03260:	20001dac 	.word	0x20001dac
c0d03264:	00001a2b 	.word	0x00001a2b
c0d03268:	00001a11 	.word	0x00001a11

c0d0326c <USBD_U2F_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_U2F_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d0326c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0326e:	b081      	sub	sp, #4
c0d03270:	4604      	mov	r4, r0
c0d03272:	2181      	movs	r1, #129	; 0x81
c0d03274:	2603      	movs	r6, #3
c0d03276:	2540      	movs	r5, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d03278:	4632      	mov	r2, r6
c0d0327a:	462b      	mov	r3, r5
c0d0327c:	f7ff fa42 	bl	c0d02704 <USBD_LL_OpenEP>
c0d03280:	2701      	movs	r7, #1
                 U2F_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d03282:	4620      	mov	r0, r4
c0d03284:	4639      	mov	r1, r7
c0d03286:	4632      	mov	r2, r6
c0d03288:	462b      	mov	r3, r5
c0d0328a:	f7ff fa3b 	bl	c0d02704 <USBD_LL_OpenEP>
                 U2F_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d0328e:	4620      	mov	r0, r4
c0d03290:	4639      	mov	r1, r7
c0d03292:	462a      	mov	r2, r5
c0d03294:	f7ff faff 	bl	c0d02896 <USBD_LL_PrepareReceive>
c0d03298:	2000      	movs	r0, #0

  return USBD_OK;
c0d0329a:	b001      	add	sp, #4
c0d0329c:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d032a0 <USBD_U2F_DataIn_impl>:
}

uint8_t  USBD_U2F_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d032a0:	b580      	push	{r7, lr}
  UNUSED(pdev);
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d032a2:	2901      	cmp	r1, #1
c0d032a4:	d103      	bne.n	c0d032ae <USBD_U2F_DataIn_impl+0xe>
  // FIDO endpoint
  case (U2F_EPIN_ADDR&0x7F):
    // advance the u2f sending machine state
    u2f_transport_sent(&G_io_u2f, U2F_MEDIA_USB);
c0d032a6:	4803      	ldr	r0, [pc, #12]	; (c0d032b4 <USBD_U2F_DataIn_impl+0x14>)
c0d032a8:	2101      	movs	r1, #1
c0d032aa:	f7fe fe65 	bl	c0d01f78 <u2f_transport_sent>
c0d032ae:	2000      	movs	r0, #0
    break;
  } 
  return USBD_OK;
c0d032b0:	bd80      	pop	{r7, pc}
c0d032b2:	46c0      	nop			; (mov r8, r8)
c0d032b4:	20001c08 	.word	0x20001c08

c0d032b8 <USBD_U2F_DataOut_impl>:
}

uint8_t  USBD_U2F_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d032b8:	b5b0      	push	{r4, r5, r7, lr}
  switch (epnum) {
c0d032ba:	2901      	cmp	r1, #1
c0d032bc:	d10e      	bne.n	c0d032dc <USBD_U2F_DataOut_impl+0x24>
c0d032be:	4614      	mov	r4, r2
c0d032c0:	2501      	movs	r5, #1
c0d032c2:	2240      	movs	r2, #64	; 0x40
  // FIDO endpoint
  case (U2F_EPOUT_ADDR&0x7F):
      USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR , U2F_EPOUT_SIZE);
c0d032c4:	4629      	mov	r1, r5
c0d032c6:	f7ff fae6 	bl	c0d02896 <USBD_LL_PrepareReceive>
      u2f_transport_received(&G_io_u2f, buffer, io_seproxyhal_get_ep_rx_size(U2F_EPOUT_ADDR), U2F_MEDIA_USB);
c0d032ca:	4628      	mov	r0, r5
c0d032cc:	f7fd fc7e 	bl	c0d00bcc <io_seproxyhal_get_ep_rx_size>
c0d032d0:	4602      	mov	r2, r0
c0d032d2:	4803      	ldr	r0, [pc, #12]	; (c0d032e0 <USBD_U2F_DataOut_impl+0x28>)
c0d032d4:	4621      	mov	r1, r4
c0d032d6:	462b      	mov	r3, r5
c0d032d8:	f7fe ffa6 	bl	c0d02228 <u2f_transport_received>
c0d032dc:	2000      	movs	r0, #0
    break;
  }

  return USBD_OK;
c0d032de:	bdb0      	pop	{r4, r5, r7, pc}
c0d032e0:	20001c08 	.word	0x20001c08

c0d032e4 <USBD_HID_DataIn_impl>:
}
#endif // HAVE_IO_U2F

uint8_t  USBD_HID_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d032e4:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d032e6:	2902      	cmp	r1, #2
c0d032e8:	d103      	bne.n	c0d032f2 <USBD_HID_DataIn_impl+0xe>
    // HID gen endpoint
    case (HID_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data);
c0d032ea:	4803      	ldr	r0, [pc, #12]	; (c0d032f8 <USBD_HID_DataIn_impl+0x14>)
c0d032ec:	4478      	add	r0, pc
c0d032ee:	f7fe f899 	bl	c0d01424 <io_usb_hid_sent>
c0d032f2:	2000      	movs	r0, #0
      break;
  }

  return USBD_OK;
c0d032f4:	bd80      	pop	{r7, pc}
c0d032f6:	46c0      	nop			; (mov r8, r8)
c0d032f8:	ffffd9a9 	.word	0xffffd9a9

c0d032fc <USBD_HID_DataOut_impl>:
}

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d032fc:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d032fe:	2902      	cmp	r1, #2
c0d03300:	d11a      	bne.n	c0d03338 <USBD_HID_DataOut_impl+0x3c>
c0d03302:	4614      	mov	r4, r2
c0d03304:	2102      	movs	r1, #2
c0d03306:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (HID_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d03308:	f7ff fac5 	bl	c0d02896 <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d0330c:	4d0b      	ldr	r5, [pc, #44]	; (c0d0333c <USBD_HID_DataOut_impl+0x40>)
c0d0330e:	79a8      	ldrb	r0, [r5, #6]
c0d03310:	2800      	cmp	r0, #0
c0d03312:	d111      	bne.n	c0d03338 <USBD_HID_DataOut_impl+0x3c>
c0d03314:	2002      	movs	r0, #2
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d03316:	f7fd fc59 	bl	c0d00bcc <io_seproxyhal_get_ep_rx_size>
c0d0331a:	4602      	mov	r2, r0
c0d0331c:	4809      	ldr	r0, [pc, #36]	; (c0d03344 <USBD_HID_DataOut_impl+0x48>)
c0d0331e:	4478      	add	r0, pc
c0d03320:	4621      	mov	r1, r4
c0d03322:	f7fd ffd3 	bl	c0d012cc <io_usb_hid_receive>
c0d03326:	2802      	cmp	r0, #2
c0d03328:	d106      	bne.n	c0d03338 <USBD_HID_DataOut_impl+0x3c>
c0d0332a:	2007      	movs	r0, #7
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
          G_io_app.apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d0332c:	7028      	strb	r0, [r5, #0]
c0d0332e:	2001      	movs	r0, #1
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d03330:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_state = APDU_USB_HID; // for next call to io_exchange
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d03332:	4803      	ldr	r0, [pc, #12]	; (c0d03340 <USBD_HID_DataOut_impl+0x44>)
c0d03334:	6800      	ldr	r0, [r0, #0]
c0d03336:	8068      	strh	r0, [r5, #2]
c0d03338:	2000      	movs	r0, #0
      }
    }
    break;
  }

  return USBD_OK;
c0d0333a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0333c:	20001be0 	.word	0x20001be0
c0d03340:	20001c90 	.word	0x20001c90
c0d03344:	ffffd977 	.word	0xffffd977

c0d03348 <USBD_WEBUSB_Init>:

#ifdef HAVE_WEBUSB

uint8_t  USBD_WEBUSB_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d03348:	b570      	push	{r4, r5, r6, lr}
c0d0334a:	4604      	mov	r4, r0
c0d0334c:	2183      	movs	r1, #131	; 0x83
c0d0334e:	2503      	movs	r5, #3
c0d03350:	2640      	movs	r6, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d03352:	462a      	mov	r2, r5
c0d03354:	4633      	mov	r3, r6
c0d03356:	f7ff f9d5 	bl	c0d02704 <USBD_LL_OpenEP>
                 WEBUSB_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d0335a:	4620      	mov	r0, r4
c0d0335c:	4629      	mov	r1, r5
c0d0335e:	462a      	mov	r2, r5
c0d03360:	4633      	mov	r3, r6
c0d03362:	f7ff f9cf 	bl	c0d02704 <USBD_LL_OpenEP>
                 WEBUSB_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d03366:	4620      	mov	r0, r4
c0d03368:	4629      	mov	r1, r5
c0d0336a:	4632      	mov	r2, r6
c0d0336c:	f7ff fa93 	bl	c0d02896 <USBD_LL_PrepareReceive>
c0d03370:	2000      	movs	r0, #0

  return USBD_OK;
c0d03372:	bd70      	pop	{r4, r5, r6, pc}

c0d03374 <USBD_WEBUSB_DeInit>:
}

uint8_t  USBD_WEBUSB_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx) {
c0d03374:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(cfgidx);
  return USBD_OK;
c0d03376:	4770      	bx	lr

c0d03378 <USBD_WEBUSB_Setup>:
}

uint8_t  USBD_WEBUSB_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d03378:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(req);
  return USBD_OK;
c0d0337a:	4770      	bx	lr

c0d0337c <USBD_WEBUSB_DataIn>:
}

uint8_t  USBD_WEBUSB_DataIn (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d0337c:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d0337e:	2903      	cmp	r1, #3
c0d03380:	d103      	bne.n	c0d0338a <USBD_WEBUSB_DataIn+0xe>
    // HID gen endpoint
    case (WEBUSB_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data_ep0x83);
c0d03382:	4803      	ldr	r0, [pc, #12]	; (c0d03390 <USBD_WEBUSB_DataIn+0x14>)
c0d03384:	4478      	add	r0, pc
c0d03386:	f7fe f84d 	bl	c0d01424 <io_usb_hid_sent>
c0d0338a:	2000      	movs	r0, #0
      break;
  }
  return USBD_OK;
c0d0338c:	bd80      	pop	{r7, pc}
c0d0338e:	46c0      	nop			; (mov r8, r8)
c0d03390:	ffffd921 	.word	0xffffd921

c0d03394 <USBD_WEBUSB_DataOut>:
}

uint8_t USBD_WEBUSB_DataOut (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03394:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d03396:	2903      	cmp	r1, #3
c0d03398:	d11a      	bne.n	c0d033d0 <USBD_WEBUSB_DataOut+0x3c>
c0d0339a:	4614      	mov	r4, r2
c0d0339c:	2103      	movs	r1, #3
c0d0339e:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (WEBUSB_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d033a0:	f7ff fa79 	bl	c0d02896 <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d033a4:	4d0b      	ldr	r5, [pc, #44]	; (c0d033d4 <USBD_WEBUSB_DataOut+0x40>)
c0d033a6:	79a8      	ldrb	r0, [r5, #6]
c0d033a8:	2800      	cmp	r0, #0
c0d033aa:	d111      	bne.n	c0d033d0 <USBD_WEBUSB_DataOut+0x3c>
c0d033ac:	2003      	movs	r0, #3
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data_ep0x83, buffer, io_seproxyhal_get_ep_rx_size(WEBUSB_EPOUT_ADDR))) {
c0d033ae:	f7fd fc0d 	bl	c0d00bcc <io_seproxyhal_get_ep_rx_size>
c0d033b2:	4602      	mov	r2, r0
c0d033b4:	4809      	ldr	r0, [pc, #36]	; (c0d033dc <USBD_WEBUSB_DataOut+0x48>)
c0d033b6:	4478      	add	r0, pc
c0d033b8:	4621      	mov	r1, r4
c0d033ba:	f7fd ff87 	bl	c0d012cc <io_usb_hid_receive>
c0d033be:	2802      	cmp	r0, #2
c0d033c0:	d106      	bne.n	c0d033d0 <USBD_WEBUSB_DataOut+0x3c>
c0d033c2:	200b      	movs	r0, #11
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
          G_io_app.apdu_state = APDU_USB_WEBUSB; // for next call to io_exchange
c0d033c4:	7028      	strb	r0, [r5, #0]
c0d033c6:	2005      	movs	r0, #5
      switch(io_usb_hid_receive(io_usb_send_apdu_data_ep0x83, buffer, io_seproxyhal_get_ep_rx_size(WEBUSB_EPOUT_ADDR))) {
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
c0d033c8:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_state = APDU_USB_WEBUSB; // for next call to io_exchange
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d033ca:	4803      	ldr	r0, [pc, #12]	; (c0d033d8 <USBD_WEBUSB_DataOut+0x44>)
c0d033cc:	6800      	ldr	r0, [r0, #0]
c0d033ce:	8068      	strh	r0, [r5, #2]
c0d033d0:	2000      	movs	r0, #0
      }
    }
    break;
  }

  return USBD_OK;
c0d033d2:	bdb0      	pop	{r4, r5, r7, pc}
c0d033d4:	20001be0 	.word	0x20001be0
c0d033d8:	20001c90 	.word	0x20001c90
c0d033dc:	ffffd8ef 	.word	0xffffd8ef

c0d033e0 <USBD_DeviceDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d033e0:	2012      	movs	r0, #18
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d033e2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d033e4:	4801      	ldr	r0, [pc, #4]	; (c0d033ec <USBD_DeviceDescriptor+0xc>)
c0d033e6:	4478      	add	r0, pc
c0d033e8:	4770      	bx	lr
c0d033ea:	46c0      	nop			; (mov r8, r8)
c0d033ec:	00001b2a 	.word	0x00001b2a

c0d033f0 <USBD_LangIDStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d033f0:	2004      	movs	r0, #4
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d033f2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d033f4:	4801      	ldr	r0, [pc, #4]	; (c0d033fc <USBD_LangIDStrDescriptor+0xc>)
c0d033f6:	4478      	add	r0, pc
c0d033f8:	4770      	bx	lr
c0d033fa:	46c0      	nop			; (mov r8, r8)
c0d033fc:	00001b2c 	.word	0x00001b2c

c0d03400 <USBD_ManufacturerStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03400:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d03402:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03404:	4801      	ldr	r0, [pc, #4]	; (c0d0340c <USBD_ManufacturerStrDescriptor+0xc>)
c0d03406:	4478      	add	r0, pc
c0d03408:	4770      	bx	lr
c0d0340a:	46c0      	nop			; (mov r8, r8)
c0d0340c:	00001b20 	.word	0x00001b20

c0d03410 <USBD_ProductStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03410:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d03412:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03414:	4801      	ldr	r0, [pc, #4]	; (c0d0341c <USBD_ProductStrDescriptor+0xc>)
c0d03416:	4478      	add	r0, pc
c0d03418:	4770      	bx	lr
c0d0341a:	46c0      	nop			; (mov r8, r8)
c0d0341c:	00001b1e 	.word	0x00001b1e

c0d03420 <USBD_SerialStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03420:	200a      	movs	r0, #10
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d03422:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d03424:	4801      	ldr	r0, [pc, #4]	; (c0d0342c <USBD_SerialStrDescriptor+0xc>)
c0d03426:	4478      	add	r0, pc
c0d03428:	4770      	bx	lr
c0d0342a:	46c0      	nop			; (mov r8, r8)
c0d0342c:	00001b1c 	.word	0x00001b1c

c0d03430 <USBD_ConfigStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03430:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d03432:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d03434:	4801      	ldr	r0, [pc, #4]	; (c0d0343c <USBD_ConfigStrDescriptor+0xc>)
c0d03436:	4478      	add	r0, pc
c0d03438:	4770      	bx	lr
c0d0343a:	46c0      	nop			; (mov r8, r8)
c0d0343c:	00001afe 	.word	0x00001afe

c0d03440 <USBD_InterfaceStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03440:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d03442:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d03444:	4801      	ldr	r0, [pc, #4]	; (c0d0344c <USBD_InterfaceStrDescriptor+0xc>)
c0d03446:	4478      	add	r0, pc
c0d03448:	4770      	bx	lr
c0d0344a:	46c0      	nop			; (mov r8, r8)
c0d0344c:	00001aee 	.word	0x00001aee

c0d03450 <USBD_BOSDescriptor>:
};

#endif // HAVE_WEBUSB

static uint8_t *USBD_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03450:	2039      	movs	r0, #57	; 0x39
  UNUSED(speed);
#ifdef HAVE_WEBUSB
  *length = sizeof(C_usb_bos);
c0d03452:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)C_usb_bos;
c0d03454:	4801      	ldr	r0, [pc, #4]	; (c0d0345c <USBD_BOSDescriptor+0xc>)
c0d03456:	4478      	add	r0, pc
c0d03458:	4770      	bx	lr
c0d0345a:	46c0      	nop			; (mov r8, r8)
c0d0345c:	0000185e 	.word	0x0000185e

c0d03460 <USBD_CtlError>:
  '4', 0x00, '6', 0x00, '7', 0x00, '6', 0x00, '5', 0x00, '7', 0x00,
  '2', 0x00, '}', 0x00, 0x00, 0x00, 0x00, 0x00 // propertyData, double unicode nul terminated
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
c0d03460:	b580      	push	{r7, lr}
#if WEBUSB_URL_SIZE_B > 0
  if ((req->bmRequest & 0x80) && req->bRequest == WEBUSB_VENDOR_CODE && req->wIndex == WEBUSB_REQ_GET_URL
c0d03462:	780a      	ldrb	r2, [r1, #0]
c0d03464:	b252      	sxtb	r2, r2
c0d03466:	2a00      	cmp	r2, #0
c0d03468:	db02      	blt.n	c0d03470 <USBD_CtlError+0x10>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
c0d0346a:	f7ff fe3a 	bl	c0d030e2 <USBD_CtlStall>
  }
}
c0d0346e:	bd80      	pop	{r7, pc}
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
#if WEBUSB_URL_SIZE_B > 0
  if ((req->bmRequest & 0x80) && req->bRequest == WEBUSB_VENDOR_CODE && req->wIndex == WEBUSB_REQ_GET_URL
c0d03470:	784a      	ldrb	r2, [r1, #1]
c0d03472:	2a06      	cmp	r2, #6
c0d03474:	d013      	beq.n	c0d0349e <USBD_CtlError+0x3e>
c0d03476:	2a77      	cmp	r2, #119	; 0x77
c0d03478:	d01f      	beq.n	c0d034ba <USBD_CtlError+0x5a>
c0d0347a:	2a1e      	cmp	r2, #30
c0d0347c:	d1f5      	bne.n	c0d0346a <USBD_CtlError+0xa>
c0d0347e:	888a      	ldrh	r2, [r1, #4]
    // HTTPS url
    && req->wValue == 1) {
c0d03480:	2a02      	cmp	r2, #2
c0d03482:	d1f2      	bne.n	c0d0346a <USBD_CtlError+0xa>
c0d03484:	884a      	ldrh	r2, [r1, #2]
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
#if WEBUSB_URL_SIZE_B > 0
  if ((req->bmRequest & 0x80) && req->bRequest == WEBUSB_VENDOR_CODE && req->wIndex == WEBUSB_REQ_GET_URL
c0d03486:	2a01      	cmp	r2, #1
c0d03488:	d1ef      	bne.n	c0d0346a <USBD_CtlError+0xa>
    // HTTPS url
    && req->wValue == 1) {
    // return the URL descriptor
    USBD_CtlSendData (pdev, (unsigned char*)C_webusb_url_descriptor, MIN(req->wLength, sizeof(C_webusb_url_descriptor)));
c0d0348a:	88ca      	ldrh	r2, [r1, #6]
c0d0348c:	2117      	movs	r1, #23
c0d0348e:	2a17      	cmp	r2, #23
c0d03490:	d300      	bcc.n	c0d03494 <USBD_CtlError+0x34>
c0d03492:	460a      	mov	r2, r1
c0d03494:	491d      	ldr	r1, [pc, #116]	; (c0d0350c <USBD_CtlError+0xac>)
c0d03496:	4479      	add	r1, pc
c0d03498:	f000 f8b0 	bl	c0d035fc <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d0349c:	bd80      	pop	{r7, pc}
  else 
#endif // WEBUSB_URL_SIZE_B
    // SETUP (LE): 0x80 0x06 0x03 0x77 0x00 0x00 0xXX 0xXX
    if ((req->bmRequest & 0x80) 
    && req->bRequest == USB_REQ_GET_DESCRIPTOR 
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
c0d0349e:	884a      	ldrh	r2, [r1, #2]
c0d034a0:	4b19      	ldr	r3, [pc, #100]	; (c0d03508 <USBD_CtlError+0xa8>)
    && (req->wValue & 0xFF) == 0xEE) {
c0d034a2:	429a      	cmp	r2, r3
c0d034a4:	d1e1      	bne.n	c0d0346a <USBD_CtlError+0xa>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
c0d034a6:	88ca      	ldrh	r2, [r1, #6]
c0d034a8:	2112      	movs	r1, #18
c0d034aa:	2a12      	cmp	r2, #18
c0d034ac:	d300      	bcc.n	c0d034b0 <USBD_CtlError+0x50>
c0d034ae:	460a      	mov	r2, r1
c0d034b0:	4917      	ldr	r1, [pc, #92]	; (c0d03510 <USBD_CtlError+0xb0>)
c0d034b2:	4479      	add	r1, pc
c0d034b4:	f000 f8a2 	bl	c0d035fc <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d034b8:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
  }
  // SETUP (LE): 0x80 0x77 0x04 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
c0d034ba:	888a      	ldrh	r2, [r1, #4]
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
    && (req->wValue & 0xFF) == 0xEE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
  }
  // SETUP (LE): 0x80 0x77 0x04 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
c0d034bc:	2a04      	cmp	r2, #4
c0d034be:	d109      	bne.n	c0d034d4 <USBD_CtlError+0x74>
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
c0d034c0:	88ca      	ldrh	r2, [r1, #6]
c0d034c2:	2128      	movs	r1, #40	; 0x28
c0d034c4:	2a28      	cmp	r2, #40	; 0x28
c0d034c6:	d300      	bcc.n	c0d034ca <USBD_CtlError+0x6a>
c0d034c8:	460a      	mov	r2, r1
c0d034ca:	4912      	ldr	r1, [pc, #72]	; (c0d03514 <USBD_CtlError+0xb4>)
c0d034cc:	4479      	add	r1, pc
c0d034ce:	f000 f895 	bl	c0d035fc <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d034d2:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
  }
  // SETUP (LE): 0x80 0x77 0x05 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
c0d034d4:	888a      	ldrh	r2, [r1, #4]
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
  }
  // SETUP (LE): 0x80 0x77 0x05 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
c0d034d6:	2a05      	cmp	r2, #5
c0d034d8:	d109      	bne.n	c0d034ee <USBD_CtlError+0x8e>
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
  ) {        
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
c0d034da:	88ca      	ldrh	r2, [r1, #6]
c0d034dc:	2192      	movs	r1, #146	; 0x92
c0d034de:	2a92      	cmp	r2, #146	; 0x92
c0d034e0:	d300      	bcc.n	c0d034e4 <USBD_CtlError+0x84>
c0d034e2:	460a      	mov	r2, r1
c0d034e4:	490c      	ldr	r1, [pc, #48]	; (c0d03518 <USBD_CtlError+0xb8>)
c0d034e6:	4479      	add	r1, pc
c0d034e8:	f000 f888 	bl	c0d035fc <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d034ec:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
  }
  // Microsoft OS 2.0 Descriptors for Windows 8.1 and Windows 10
  else if ((req->bmRequest & 0x80)
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
c0d034ee:	888a      	ldrh	r2, [r1, #4]
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
  ) {        
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
  }
  // Microsoft OS 2.0 Descriptors for Windows 8.1 and Windows 10
  else if ((req->bmRequest & 0x80)
c0d034f0:	2a07      	cmp	r2, #7
c0d034f2:	d1ba      	bne.n	c0d0346a <USBD_CtlError+0xa>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
c0d034f4:	88ca      	ldrh	r2, [r1, #6]
c0d034f6:	21b2      	movs	r1, #178	; 0xb2
c0d034f8:	2ab2      	cmp	r2, #178	; 0xb2
c0d034fa:	d300      	bcc.n	c0d034fe <USBD_CtlError+0x9e>
c0d034fc:	460a      	mov	r2, r1
c0d034fe:	4907      	ldr	r1, [pc, #28]	; (c0d0351c <USBD_CtlError+0xbc>)
c0d03500:	4479      	add	r1, pc
c0d03502:	f000 f87b 	bl	c0d035fc <USBD_CtlSendData>
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d03506:	bd80      	pop	{r7, pc}
c0d03508:	000003ee 	.word	0x000003ee
c0d0350c:	00001807 	.word	0x00001807
c0d03510:	0000185e 	.word	0x0000185e
c0d03514:	00001a80 	.word	0x00001a80
c0d03518:	0000183c 	.word	0x0000183c
c0d0351c:	000018b4 	.word	0x000018b4

c0d03520 <USB_power>:
  // nothing to do ?
  return 0;
}
#endif // HAVE_USB_CLASS_CCID

void USB_power(unsigned char enabled) {
c0d03520:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03522:	b081      	sub	sp, #4
c0d03524:	4604      	mov	r4, r0
c0d03526:	2045      	movs	r0, #69	; 0x45
c0d03528:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0352a:	4824      	ldr	r0, [pc, #144]	; (c0d035bc <USB_power+0x9c>)
c0d0352c:	2600      	movs	r6, #0
c0d0352e:	4631      	mov	r1, r6
c0d03530:	462a      	mov	r2, r5
c0d03532:	f7fd fad5 	bl	c0d00ae0 <os_memset>

  // init timeouts and other global fields
  os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
c0d03536:	4f22      	ldr	r7, [pc, #136]	; (c0d035c0 <USB_power+0xa0>)
c0d03538:	4638      	mov	r0, r7
c0d0353a:	300c      	adds	r0, #12
c0d0353c:	2206      	movs	r2, #6
c0d0353e:	4631      	mov	r1, r6
c0d03540:	f7fd face 	bl	c0d00ae0 <os_memset>
  os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d03544:	3712      	adds	r7, #18
c0d03546:	220c      	movs	r2, #12
c0d03548:	4638      	mov	r0, r7
c0d0354a:	4631      	mov	r1, r6
c0d0354c:	f7fd fac8 	bl	c0d00ae0 <os_memset>

  if (enabled) {
c0d03550:	2c00      	cmp	r4, #0
c0d03552:	d02d      	beq.n	c0d035b0 <USB_power+0x90>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d03554:	4c19      	ldr	r4, [pc, #100]	; (c0d035bc <USB_power+0x9c>)
c0d03556:	2600      	movs	r6, #0
c0d03558:	4620      	mov	r0, r4
c0d0355a:	4631      	mov	r1, r6
c0d0355c:	462a      	mov	r2, r5
c0d0355e:	f7fd fabf 	bl	c0d00ae0 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d03562:	491a      	ldr	r1, [pc, #104]	; (c0d035cc <USB_power+0xac>)
c0d03564:	4479      	add	r1, pc
c0d03566:	4620      	mov	r0, r4
c0d03568:	4632      	mov	r2, r6
c0d0356a:	f7ff f9a7 	bl	c0d028bc <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClassForInterface(HID_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d0356e:	4a18      	ldr	r2, [pc, #96]	; (c0d035d0 <USB_power+0xb0>)
c0d03570:	447a      	add	r2, pc
c0d03572:	4630      	mov	r0, r6
c0d03574:	4621      	mov	r1, r4
c0d03576:	f7ff f9d8 	bl	c0d0292a <USBD_RegisterClassForInterface>
c0d0357a:	2001      	movs	r0, #1
#ifdef HAVE_IO_U2F
    USBD_RegisterClassForInterface(U2F_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_U2F);
c0d0357c:	4a15      	ldr	r2, [pc, #84]	; (c0d035d4 <USB_power+0xb4>)
c0d0357e:	447a      	add	r2, pc
c0d03580:	4621      	mov	r1, r4
c0d03582:	f7ff f9d2 	bl	c0d0292a <USBD_RegisterClassForInterface>
c0d03586:	22ff      	movs	r2, #255	; 0xff
c0d03588:	3252      	adds	r2, #82	; 0x52
    // initialize the U2F tunnel transport
    u2f_transport_init(&G_io_u2f, G_io_apdu_buffer, IO_APDU_BUFFER_SIZE);
c0d0358a:	480e      	ldr	r0, [pc, #56]	; (c0d035c4 <USB_power+0xa4>)
c0d0358c:	490e      	ldr	r1, [pc, #56]	; (c0d035c8 <USB_power+0xa8>)
c0d0358e:	f7fe fce9 	bl	c0d01f64 <u2f_transport_init>
c0d03592:	2002      	movs	r0, #2
#ifdef HAVE_USB_CLASS_CCID
    USBD_RegisterClassForInterface(CCID_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_CCID);
#endif // HAVE_USB_CLASS_CCID

#ifdef HAVE_WEBUSB
    USBD_RegisterClassForInterface(WEBUSB_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_WEBUSB);
c0d03594:	4a10      	ldr	r2, [pc, #64]	; (c0d035d8 <USB_power+0xb8>)
c0d03596:	447a      	add	r2, pc
c0d03598:	4621      	mov	r1, r4
c0d0359a:	f7ff f9c6 	bl	c0d0292a <USBD_RegisterClassForInterface>
c0d0359e:	2103      	movs	r1, #3
c0d035a0:	2240      	movs	r2, #64	; 0x40
    USBD_LL_PrepareReceive(&USBD_Device, WEBUSB_EPOUT_ADDR , WEBUSB_EPOUT_SIZE);
c0d035a2:	4620      	mov	r0, r4
c0d035a4:	f7ff f977 	bl	c0d02896 <USBD_LL_PrepareReceive>
#endif // HAVE_WEBUSB

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d035a8:	4620      	mov	r0, r4
c0d035aa:	f7ff f9cb 	bl	c0d02944 <USBD_Start>
c0d035ae:	e002      	b.n	c0d035b6 <USB_power+0x96>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d035b0:	4802      	ldr	r0, [pc, #8]	; (c0d035bc <USB_power+0x9c>)
c0d035b2:	f7ff f99c 	bl	c0d028ee <USBD_DeInit>
  }
}
c0d035b6:	b001      	add	sp, #4
c0d035b8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d035ba:	46c0      	nop			; (mov r8, r8)
c0d035bc:	20001dac 	.word	0x20001dac
c0d035c0:	20001be0 	.word	0x20001be0
c0d035c4:	20001c08 	.word	0x20001c08
c0d035c8:	20001a8e 	.word	0x20001a8e
c0d035cc:	0000178c 	.word	0x0000178c
c0d035d0:	000018f8 	.word	0x000018f8
c0d035d4:	00001922 	.word	0x00001922
c0d035d8:	00001942 	.word	0x00001942

c0d035dc <USBD_GetCfgDesc_impl>:
  * @param  speed : current device speed
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
c0d035dc:	2160      	movs	r1, #96	; 0x60
  *length = sizeof (USBD_CfgDesc);
c0d035de:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d035e0:	4801      	ldr	r0, [pc, #4]	; (c0d035e8 <USBD_GetCfgDesc_impl+0xc>)
c0d035e2:	4478      	add	r0, pc
c0d035e4:	4770      	bx	lr
c0d035e6:	46c0      	nop			; (mov r8, r8)
c0d035e8:	00001992 	.word	0x00001992

c0d035ec <USBD_GetDeviceQualifierDesc_impl>:
*         return Device Qualifier descriptor
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
c0d035ec:	210a      	movs	r1, #10
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d035ee:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d035f0:	4801      	ldr	r0, [pc, #4]	; (c0d035f8 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d035f2:	4478      	add	r0, pc
c0d035f4:	4770      	bx	lr
c0d035f6:	46c0      	nop			; (mov r8, r8)
c0d035f8:	000019e2 	.word	0x000019e2

c0d035fc <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d035fc:	b5b0      	push	{r4, r5, r7, lr}
c0d035fe:	460c      	mov	r4, r1
c0d03600:	21d4      	movs	r1, #212	; 0xd4
c0d03602:	2302      	movs	r3, #2
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d03604:	5043      	str	r3, [r0, r1]
c0d03606:	2111      	movs	r1, #17
c0d03608:	0109      	lsls	r1, r1, #4
  pdev->ep_in[0].total_length = len;
  pdev->ep_in[0].rem_length   = len;
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d0360a:	5044      	str	r4, [r0, r1]
                               uint8_t *pbuf,
                               uint16_t len)
{
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
  pdev->ep_in[0].total_length = len;
c0d0360c:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d0360e:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d03610:	6a01      	ldr	r1, [r0, #32]
c0d03612:	4291      	cmp	r1, r2
c0d03614:	d800      	bhi.n	c0d03618 <USBD_CtlSendData+0x1c>
c0d03616:	460a      	mov	r2, r1
c0d03618:	b293      	uxth	r3, r2
c0d0361a:	2500      	movs	r5, #0
c0d0361c:	4629      	mov	r1, r5
c0d0361e:	4622      	mov	r2, r4
c0d03620:	f7ff f920 	bl	c0d02864 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03624:	4628      	mov	r0, r5
c0d03626:	bdb0      	pop	{r4, r5, r7, pc}

c0d03628 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d03628:	b5b0      	push	{r4, r5, r7, lr}
c0d0362a:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d0362c:	6a01      	ldr	r1, [r0, #32]
c0d0362e:	4291      	cmp	r1, r2
c0d03630:	d800      	bhi.n	c0d03634 <USBD_CtlContinueSendData+0xc>
c0d03632:	460a      	mov	r2, r1
c0d03634:	b293      	uxth	r3, r2
c0d03636:	2500      	movs	r5, #0
c0d03638:	4629      	mov	r1, r5
c0d0363a:	4622      	mov	r2, r4
c0d0363c:	f7ff f912 	bl	c0d02864 <USBD_LL_Transmit>
  return USBD_OK;
c0d03640:	4628      	mov	r0, r5
c0d03642:	bdb0      	pop	{r4, r5, r7, pc}

c0d03644 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d03644:	b510      	push	{r4, lr}
c0d03646:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d03648:	4621      	mov	r1, r4
c0d0364a:	f7ff f924 	bl	c0d02896 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d0364e:	4620      	mov	r0, r4
c0d03650:	bd10      	pop	{r4, pc}

c0d03652 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d03652:	b510      	push	{r4, lr}
c0d03654:	21d4      	movs	r1, #212	; 0xd4
c0d03656:	2204      	movs	r2, #4

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d03658:	5042      	str	r2, [r0, r1]
c0d0365a:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d0365c:	4621      	mov	r1, r4
c0d0365e:	4622      	mov	r2, r4
c0d03660:	4623      	mov	r3, r4
c0d03662:	f7ff f8ff 	bl	c0d02864 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03666:	4620      	mov	r0, r4
c0d03668:	bd10      	pop	{r4, pc}

c0d0366a <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d0366a:	b510      	push	{r4, lr}
c0d0366c:	21d4      	movs	r1, #212	; 0xd4
c0d0366e:	2205      	movs	r2, #5
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d03670:	5042      	str	r2, [r0, r1]
c0d03672:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d03674:	4621      	mov	r1, r4
c0d03676:	4622      	mov	r2, r4
c0d03678:	f7ff f90d 	bl	c0d02896 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d0367c:	4620      	mov	r0, r4
c0d0367e:	bd10      	pop	{r4, pc}

c0d03680 <btox>:
#include "menu.h"

#define ACCOUNT_ADDRESS_PREFIX 1

void btox(char *xp, const char *bb, int n)
{
c0d03680:	b570      	push	{r4, r5, r6, lr}
    const char xx[]= "0123456789abcdef";
    while (--n >= 0) xp[n] = xx[(bb[n>>1] >> ((1 - (n&1)) << 2)) & 0xF];
c0d03682:	2a01      	cmp	r2, #1
c0d03684:	db13      	blt.n	c0d036ae <btox+0x2e>
c0d03686:	1e54      	subs	r4, r2, #1
c0d03688:	0092      	lsls	r2, r2, #2
c0d0368a:	1f12      	subs	r2, r2, #4
c0d0368c:	4b08      	ldr	r3, [pc, #32]	; (c0d036b0 <btox+0x30>)
c0d0368e:	447b      	add	r3, pc
c0d03690:	2504      	movs	r5, #4
c0d03692:	4395      	bics	r5, r2
c0d03694:	1066      	asrs	r6, r4, #1
c0d03696:	5d8e      	ldrb	r6, [r1, r6]
c0d03698:	40ee      	lsrs	r6, r5
c0d0369a:	250f      	movs	r5, #15
c0d0369c:	4035      	ands	r5, r6
c0d0369e:	5d5d      	ldrb	r5, [r3, r5]
c0d036a0:	5505      	strb	r5, [r0, r4]
c0d036a2:	1f12      	subs	r2, r2, #4
c0d036a4:	1e65      	subs	r5, r4, #1
c0d036a6:	1c64      	adds	r4, r4, #1
c0d036a8:	2c01      	cmp	r4, #1
c0d036aa:	462c      	mov	r4, r5
c0d036ac:	dcf0      	bgt.n	c0d03690 <btox+0x10>
}
c0d036ae:	bd70      	pop	{r4, r5, r6, pc}
c0d036b0:	00001950 	.word	0x00001950

c0d036b4 <getAddressStringFromBinary>:

void getAddressStringFromBinary(uint8_t *publicKey, char *address) {
c0d036b4:	b570      	push	{r4, r5, r6, lr}
c0d036b6:	b092      	sub	sp, #72	; 0x48
c0d036b8:	460c      	mov	r4, r1
c0d036ba:	4601      	mov	r1, r0
c0d036bc:	ad09      	add	r5, sp, #36	; 0x24
c0d036be:	2620      	movs	r6, #32
    uint8_t buffer[36];
    uint8_t hashAddress[32];

    os_memmove(buffer, publicKey, 32);
c0d036c0:	4628      	mov	r0, r5
c0d036c2:	4632      	mov	r2, r6
c0d036c4:	f7fd f9f6 	bl	c0d00ab4 <os_memmove>
c0d036c8:	aa01      	add	r2, sp, #4
    cx_hash_sha256(buffer, 32, hashAddress, 32);
c0d036ca:	4628      	mov	r0, r5
c0d036cc:	4631      	mov	r1, r6
c0d036ce:	4633      	mov	r3, r6
c0d036d0:	f7fe f9ca 	bl	c0d01a68 <cx_hash_sha256>
c0d036d4:	2227      	movs	r2, #39	; 0x27
c0d036d6:	209c      	movs	r0, #156	; 0x9c
c0d036d8:	490b      	ldr	r1, [pc, #44]	; (c0d03708 <getAddressStringFromBinary+0x54>)
c0d036da:	4479      	add	r1, pc
c0d036dc:	2304      	movs	r3, #4
#define ACCOUNT_ADDRESS_PREFIX 1

void btox(char *xp, const char *bb, int n)
{
    const char xx[]= "0123456789abcdef";
    while (--n >= 0) xp[n] = xx[(bb[n>>1] >> ((1 - (n&1)) << 2)) & 0xF];
c0d036de:	4383      	bics	r3, r0
c0d036e0:	1055      	asrs	r5, r2, #1
c0d036e2:	ae01      	add	r6, sp, #4
c0d036e4:	5d75      	ldrb	r5, [r6, r5]
c0d036e6:	40dd      	lsrs	r5, r3
c0d036e8:	230f      	movs	r3, #15
c0d036ea:	402b      	ands	r3, r5
c0d036ec:	5ccb      	ldrb	r3, [r1, r3]
c0d036ee:	54a3      	strb	r3, [r4, r2]
c0d036f0:	1f00      	subs	r0, r0, #4
c0d036f2:	1e53      	subs	r3, r2, #1
c0d036f4:	1c52      	adds	r2, r2, #1
c0d036f6:	2a01      	cmp	r2, #1
c0d036f8:	461a      	mov	r2, r3
c0d036fa:	d8ef      	bhi.n	c0d036dc <getAddressStringFromBinary+0x28>
c0d036fc:	2028      	movs	r0, #40	; 0x28
c0d036fe:	2100      	movs	r1, #0
    os_memmove(buffer, publicKey, 32);
    cx_hash_sha256(buffer, 32, hashAddress, 32);

    //Only copy first 20 bytes of hashAddress as the User's address.
    btox(address, (const char*)hashAddress, 40);
    address[40] = 0;
c0d03700:	5421      	strb	r1, [r4, r0]
}
c0d03702:	b012      	add	sp, #72	; 0x48
c0d03704:	bd70      	pop	{r4, r5, r6, pc}
c0d03706:	46c0      	nop			; (mov r8, r8)
c0d03708:	00001904 	.word	0x00001904

c0d0370c <getPublicKey>:

void getPublicKey(uint32_t accountNumber, uint8_t *publicKeyArray) {
c0d0370c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0370e:	b09d      	sub	sp, #116	; 0x74
c0d03710:	460c      	mov	r4, r1
c0d03712:	ae13      	add	r6, sp, #76	; 0x4c
    cx_ecfp_private_key_t privateKey;
    cx_ecfp_public_key_t publicKey;

    getPrivateKey(accountNumber, &privateKey);
c0d03714:	4631      	mov	r1, r6
c0d03716:	f000 f821 	bl	c0d0375c <getPrivateKey>
c0d0371a:	2041      	movs	r0, #65	; 0x41
c0d0371c:	466d      	mov	r5, sp
c0d0371e:	2301      	movs	r3, #1
    cx_ecfp_generate_pair(CX_CURVE_Ed25519, &publicKey, &privateKey, 1);
c0d03720:	4629      	mov	r1, r5
c0d03722:	4632      	mov	r2, r6
c0d03724:	f7fe f9c0 	bl	c0d01aa8 <cx_ecfp_generate_pair>
c0d03728:	2700      	movs	r7, #0
c0d0372a:	2128      	movs	r1, #40	; 0x28
    os_memset(&privateKey, 0, sizeof(privateKey));
c0d0372c:	4630      	mov	r0, r6
c0d0372e:	460e      	mov	r6, r1
c0d03730:	4639      	mov	r1, r7
c0d03732:	4632      	mov	r2, r6
c0d03734:	f7fd f9d4 	bl	c0d00ae0 <os_memset>

    for (int i = 0; i < 32; i++) {
c0d03738:	3548      	adds	r5, #72	; 0x48
        publicKeyArray[i] = publicKey.W[64 - i];
c0d0373a:	7828      	ldrb	r0, [r5, #0]
c0d0373c:	55e0      	strb	r0, [r4, r7]

    getPrivateKey(accountNumber, &privateKey);
    cx_ecfp_generate_pair(CX_CURVE_Ed25519, &publicKey, &privateKey, 1);
    os_memset(&privateKey, 0, sizeof(privateKey));

    for (int i = 0; i < 32; i++) {
c0d0373e:	1e6d      	subs	r5, r5, #1
c0d03740:	1c7f      	adds	r7, r7, #1
c0d03742:	2f20      	cmp	r7, #32
c0d03744:	d1f9      	bne.n	c0d0373a <getPublicKey+0x2e>
c0d03746:	4668      	mov	r0, sp
        publicKeyArray[i] = publicKey.W[64 - i];
    }
    if ((publicKey.W[32] & 1) != 0) {
c0d03748:	5d80      	ldrb	r0, [r0, r6]
c0d0374a:	07c0      	lsls	r0, r0, #31
c0d0374c:	d003      	beq.n	c0d03756 <getPublicKey+0x4a>
        publicKeyArray[31] |= 0x80;
c0d0374e:	7fe0      	ldrb	r0, [r4, #31]
c0d03750:	2180      	movs	r1, #128	; 0x80
c0d03752:	4301      	orrs	r1, r0
c0d03754:	77e1      	strb	r1, [r4, #31]
    }
}
c0d03756:	b01d      	add	sp, #116	; 0x74
c0d03758:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d0375c <getPrivateKey>:
  0 | HARDENED_OFFSET,
  0 | HARDENED_OFFSET,
  0 | HARDENED_OFFSET
};

void getPrivateKey(uint32_t accountNumber, cx_ecfp_private_key_t *privateKey) {
c0d0375c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0375e:	b093      	sub	sp, #76	; 0x4c
c0d03760:	9105      	str	r1, [sp, #20]
c0d03762:	4606      	mov	r6, r0
c0d03764:	ad06      	add	r5, sp, #24
    uint8_t privateKeyData[32];
    uint32_t bip32Path[BIP32_PATH];

    os_memmove(bip32Path, derivePath, sizeof(derivePath));
c0d03766:	4912      	ldr	r1, [pc, #72]	; (c0d037b0 <getPrivateKey+0x54>)
c0d03768:	4479      	add	r1, pc
c0d0376a:	2214      	movs	r2, #20
c0d0376c:	4628      	mov	r0, r5
c0d0376e:	f7fd f9a1 	bl	c0d00ab4 <os_memmove>
c0d03772:	2001      	movs	r0, #1
c0d03774:	07c1      	lsls	r1, r0, #31
    bip32Path[2] = accountNumber | HARDENED_OFFSET;
c0d03776:	4331      	orrs	r1, r6
c0d03778:	9108      	str	r1, [sp, #32]
c0d0377a:	2600      	movs	r6, #0
    PRINTF("BIP32: %.*H\n", BIP32_PATH*4, bip32Path);
    os_perso_derive_node_bip32_seed_key(HDW_ED25519_SLIP10, CX_CURVE_Ed25519, bip32Path, BIP32_PATH, privateKeyData, NULL, NULL, 0);
c0d0377c:	4669      	mov	r1, sp
c0d0377e:	60ce      	str	r6, [r1, #12]
c0d03780:	608e      	str	r6, [r1, #8]
c0d03782:	604e      	str	r6, [r1, #4]
c0d03784:	af0b      	add	r7, sp, #44	; 0x2c
c0d03786:	600f      	str	r7, [r1, #0]
c0d03788:	2441      	movs	r4, #65	; 0x41
c0d0378a:	2305      	movs	r3, #5
c0d0378c:	4621      	mov	r1, r4
c0d0378e:	462a      	mov	r2, r5
c0d03790:	f7fe f9d2 	bl	c0d01b38 <os_perso_derive_node_with_seed_key>
c0d03794:	2520      	movs	r5, #32
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, privateKey);
c0d03796:	4620      	mov	r0, r4
c0d03798:	4639      	mov	r1, r7
c0d0379a:	462a      	mov	r2, r5
c0d0379c:	9b05      	ldr	r3, [sp, #20]
c0d0379e:	f7fe f973 	bl	c0d01a88 <cx_ecfp_init_private_key>
    os_memset(privateKeyData, 0, sizeof(privateKeyData));
c0d037a2:	4638      	mov	r0, r7
c0d037a4:	4631      	mov	r1, r6
c0d037a6:	462a      	mov	r2, r5
c0d037a8:	f7fd f99a 	bl	c0d00ae0 <os_memset>
}
c0d037ac:	b013      	add	sp, #76	; 0x4c
c0d037ae:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d037b0:	00001888 	.word	0x00001888

c0d037b4 <readUint32BE>:
        publicKeyArray[31] |= 0x80;
    }
}

uint32_t readUint32BE(uint8_t *buffer) {
  return (buffer[0] << 24) | (buffer[1] << 16) | (buffer[2] << 8) | (buffer[3]);
c0d037b4:	7801      	ldrb	r1, [r0, #0]
c0d037b6:	0609      	lsls	r1, r1, #24
c0d037b8:	7842      	ldrb	r2, [r0, #1]
c0d037ba:	0412      	lsls	r2, r2, #16
c0d037bc:	1851      	adds	r1, r2, r1
c0d037be:	7882      	ldrb	r2, [r0, #2]
c0d037c0:	0212      	lsls	r2, r2, #8
c0d037c2:	1889      	adds	r1, r1, r2
c0d037c4:	78c0      	ldrb	r0, [r0, #3]
c0d037c6:	1808      	adds	r0, r1, r0
c0d037c8:	4770      	bx	lr
	...

c0d037cc <sendResponse>:
    os_perso_derive_node_bip32_seed_key(HDW_ED25519_SLIP10, CX_CURVE_Ed25519, bip32Path, BIP32_PATH, privateKeyData, NULL, NULL, 0);
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, privateKey);
    os_memset(privateKeyData, 0, sizeof(privateKeyData));
}

void sendResponse(uint8_t tx, bool approve) {
c0d037cc:	b510      	push	{r4, lr}
c0d037ce:	227a      	movs	r2, #122	; 0x7a
c0d037d0:	43d2      	mvns	r2, r2
    G_io_apdu_buffer[tx++] = approve? 0x90 : 0x69;
c0d037d2:	4614      	mov	r4, r2
c0d037d4:	340b      	adds	r4, #11
c0d037d6:	2369      	movs	r3, #105	; 0x69
c0d037d8:	2900      	cmp	r1, #0
c0d037da:	d100      	bne.n	c0d037de <sendResponse+0x12>
c0d037dc:	461c      	mov	r4, r3
c0d037de:	4b08      	ldr	r3, [pc, #32]	; (c0d03800 <sendResponse+0x34>)
c0d037e0:	541c      	strb	r4, [r3, r0]
c0d037e2:	2400      	movs	r4, #0
    G_io_apdu_buffer[tx++] = approve? 0x00 : 0x85;
c0d037e4:	2900      	cmp	r1, #0
c0d037e6:	d100      	bne.n	c0d037ea <sendResponse+0x1e>
c0d037e8:	4614      	mov	r4, r2
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, privateKey);
    os_memset(privateKeyData, 0, sizeof(privateKeyData));
}

void sendResponse(uint8_t tx, bool approve) {
    G_io_apdu_buffer[tx++] = approve? 0x90 : 0x69;
c0d037ea:	1c41      	adds	r1, r0, #1
    G_io_apdu_buffer[tx++] = approve? 0x00 : 0x85;
c0d037ec:	b2c9      	uxtb	r1, r1
c0d037ee:	545c      	strb	r4, [r3, r1]
c0d037f0:	1c80      	adds	r0, r0, #2
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d037f2:	b2c1      	uxtb	r1, r0
c0d037f4:	2020      	movs	r0, #32
c0d037f6:	f7fd fbd3 	bl	c0d00fa0 <io_exchange>
    // Display back the original UX
    ui_idle();
c0d037fa:	f7fd f923 	bl	c0d00a44 <ui_idle>
}
c0d037fe:	bd10      	pop	{r4, pc}
c0d03800:	20001a8e 	.word	0x20001a8e

c0d03804 <parseAPDU>:
    return (buffer[0] << 8) | (buffer[1]);
}

void parseAPDU(struct apduMessage* apdu) {

    apdu->cla = G_io_apdu_buffer[OFFSET_CLA];
c0d03804:	4908      	ldr	r1, [pc, #32]	; (c0d03828 <parseAPDU+0x24>)
c0d03806:	780a      	ldrb	r2, [r1, #0]
c0d03808:	7002      	strb	r2, [r0, #0]
    apdu->ins = G_io_apdu_buffer[OFFSET_INS];
c0d0380a:	784a      	ldrb	r2, [r1, #1]
c0d0380c:	7042      	strb	r2, [r0, #1]
    apdu->p1 = G_io_apdu_buffer[OFFSET_P1];
c0d0380e:	788a      	ldrb	r2, [r1, #2]
c0d03810:	7082      	strb	r2, [r0, #2]
    apdu->p2 = G_io_apdu_buffer[OFFSET_P2];
c0d03812:	78ca      	ldrb	r2, [r1, #3]
c0d03814:	70c2      	strb	r2, [r0, #3]
    }
    return display;
}

uint16_t readUint16BE(uint8_t *buffer) {
    return (buffer[0] << 8) | (buffer[1]);
c0d03816:	798a      	ldrb	r2, [r1, #6]
c0d03818:	794b      	ldrb	r3, [r1, #5]

    //Parse Length of Data
    apdu->lc = readUint16BE(&G_io_apdu_buffer[OFFSET_LC + 1]);
    PRINTF("Length of APDU CDATA: %d", apdu->lc);

    apdu->cData = &G_io_apdu_buffer[OFFSET_CDATA];
c0d0381a:	1dc9      	adds	r1, r1, #7
c0d0381c:	6081      	str	r1, [r0, #8]
    }
    return display;
}

uint16_t readUint16BE(uint8_t *buffer) {
    return (buffer[0] << 8) | (buffer[1]);
c0d0381e:	0219      	lsls	r1, r3, #8
c0d03820:	1889      	adds	r1, r1, r2
    apdu->ins = G_io_apdu_buffer[OFFSET_INS];
    apdu->p1 = G_io_apdu_buffer[OFFSET_P1];
    apdu->p2 = G_io_apdu_buffer[OFFSET_P2];

    //Parse Length of Data
    apdu->lc = readUint16BE(&G_io_apdu_buffer[OFFSET_LC + 1]);
c0d03822:	8081      	strh	r1, [r0, #4]
    PRINTF("Length of APDU CDATA: %d", apdu->lc);

    apdu->cData = &G_io_apdu_buffer[OFFSET_CDATA];
}
c0d03824:	4770      	bx	lr
c0d03826:	46c0      	nop			; (mov r8, r8)
c0d03828:	20001a8e 	.word	0x20001a8e

c0d0382c <ux_flow_is_first>:
	}
	return 1;
}

// to hide the left tick or not
unsigned int ux_flow_is_first(void) {
c0d0382c:	b5b0      	push	{r4, r5, r7, lr}
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d0382e:	4912      	ldr	r1, [pc, #72]	; (c0d03878 <ux_flow_is_first+0x4c>)
c0d03830:	780a      	ldrb	r2, [r1, #0]
c0d03832:	2001      	movs	r0, #1
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d03834:	2a01      	cmp	r2, #1
c0d03836:	d81d      	bhi.n	c0d03874 <ux_flow_is_first+0x48>
c0d03838:	1e52      	subs	r2, r2, #1
c0d0383a:	230c      	movs	r3, #12
c0d0383c:	4353      	muls	r3, r2
c0d0383e:	18cb      	adds	r3, r1, r3
c0d03840:	8b1a      	ldrh	r2, [r3, #24]

// to hide the left tick or not
unsigned int ux_flow_is_first(void) {
	// no previous ?
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d03842:	2a00      	cmp	r2, #0
c0d03844:	d016      	beq.n	c0d03874 <ux_flow_is_first+0x48>
c0d03846:	6919      	ldr	r1, [r3, #16]
		|| (G_ux.flow_stack[G_ux.stack_count-1].index == 0 
c0d03848:	2900      	cmp	r1, #0
c0d0384a:	d013      	beq.n	c0d03874 <ux_flow_is_first+0x48>
c0d0384c:	8a9b      	ldrh	r3, [r3, #20]
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
c0d0384e:	2b00      	cmp	r3, #0
c0d03850:	d106      	bne.n	c0d03860 <ux_flow_is_first+0x34>
c0d03852:	0094      	lsls	r4, r2, #2
c0d03854:	190c      	adds	r4, r1, r4
c0d03856:	2503      	movs	r5, #3
c0d03858:	43ed      	mvns	r5, r5
c0d0385a:	5964      	ldr	r4, [r4, r5]
}

// to hide the left tick or not
unsigned int ux_flow_is_first(void) {
	// no previous ?
	if (!ux_flow_check_valid()
c0d0385c:	1ce4      	adds	r4, r4, #3
c0d0385e:	d109      	bne.n	c0d03874 <ux_flow_is_first+0x48>
		return 1;
	}

	// previous is a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
		&& G_ux.flow_stack[G_ux.stack_count-1].index < G_ux.flow_stack[G_ux.stack_count-1].length
c0d03860:	4293      	cmp	r3, r2
c0d03862:	d206      	bcs.n	c0d03872 <ux_flow_is_first+0x46>
		&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index-1] == FLOW_BARRIER) {
c0d03864:	009a      	lsls	r2, r3, #2
c0d03866:	1889      	adds	r1, r1, r2
c0d03868:	2203      	movs	r2, #3
c0d0386a:	43d2      	mvns	r2, r2
c0d0386c:	5889      	ldr	r1, [r1, r2]
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
		return 1;
	}

	// previous is a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d0386e:	1c89      	adds	r1, r1, #2
c0d03870:	d000      	beq.n	c0d03874 <ux_flow_is_first+0x48>
c0d03872:	2000      	movs	r0, #0
		return 1;
	}

	// not the first, for sure
	return 0;
}
c0d03874:	bdb0      	pop	{r4, r5, r7, pc}
c0d03876:	46c0      	nop			; (mov r8, r8)
c0d03878:	2000186c 	.word	0x2000186c

c0d0387c <ux_flow_is_last>:

unsigned int ux_flow_is_last(void){
c0d0387c:	b510      	push	{r4, lr}
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d0387e:	490e      	ldr	r1, [pc, #56]	; (c0d038b8 <ux_flow_is_last+0x3c>)
c0d03880:	780a      	ldrb	r2, [r1, #0]
c0d03882:	2001      	movs	r0, #1
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d03884:	2a01      	cmp	r2, #1
c0d03886:	d816      	bhi.n	c0d038b6 <ux_flow_is_last+0x3a>
c0d03888:	1e52      	subs	r2, r2, #1
c0d0388a:	230c      	movs	r3, #12
c0d0388c:	4353      	muls	r3, r2
c0d0388e:	18cb      	adds	r3, r1, r3
c0d03890:	8b1a      	ldrh	r2, [r3, #24]
}

unsigned int ux_flow_is_last(void){
	// last ?
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d03892:	2a00      	cmp	r2, #0
c0d03894:	d00f      	beq.n	c0d038b6 <ux_flow_is_last+0x3a>
c0d03896:	6919      	ldr	r1, [r3, #16]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0
c0d03898:	2900      	cmp	r1, #0
c0d0389a:	d00c      	beq.n	c0d038b6 <ux_flow_is_last+0x3a>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
c0d0389c:	8a9b      	ldrh	r3, [r3, #20]
c0d0389e:	1e54      	subs	r4, r2, #1
	return 0;
}

unsigned int ux_flow_is_last(void){
	// last ?
	if (!ux_flow_check_valid()
c0d038a0:	429c      	cmp	r4, r3
c0d038a2:	dd08      	ble.n	c0d038b6 <ux_flow_is_last+0x3a>
		return 1;
	}

	// followed by a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
		&& G_ux.flow_stack[G_ux.stack_count-1].index < G_ux.flow_stack[G_ux.stack_count-1].length - 2
c0d038a4:	1e92      	subs	r2, r2, #2
c0d038a6:	429a      	cmp	r2, r3
c0d038a8:	dd04      	ble.n	c0d038b4 <ux_flow_is_last+0x38>
		&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d038aa:	009a      	lsls	r2, r3, #2
c0d038ac:	1889      	adds	r1, r1, r2
c0d038ae:	6849      	ldr	r1, [r1, #4]
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
		return 1;
	}

	// followed by a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d038b0:	1c89      	adds	r1, r1, #2
c0d038b2:	d000      	beq.n	c0d038b6 <ux_flow_is_last+0x3a>
c0d038b4:	2000      	movs	r0, #0
		return 1;
	}

	// is not last
	return 0;
}
c0d038b6:	bd10      	pop	{r4, pc}
c0d038b8:	2000186c 	.word	0x2000186c

c0d038bc <ux_flow_direction>:

ux_flow_direction_t ux_flow_direction(void) {
	if (G_ux.stack_count) {
c0d038bc:	4808      	ldr	r0, [pc, #32]	; (c0d038e0 <ux_flow_direction+0x24>)
c0d038be:	7801      	ldrb	r1, [r0, #0]
c0d038c0:	2900      	cmp	r1, #0
c0d038c2:	d00a      	beq.n	c0d038da <ux_flow_direction+0x1e>
c0d038c4:	220c      	movs	r2, #12
		if (G_ux.flow_stack[G_ux.stack_count-1].index > G_ux.flow_stack[G_ux.stack_count-1].prev_index) {
c0d038c6:	434a      	muls	r2, r1
c0d038c8:	1880      	adds	r0, r0, r2
c0d038ca:	8941      	ldrh	r1, [r0, #10]
c0d038cc:	8902      	ldrh	r2, [r0, #8]
c0d038ce:	2001      	movs	r0, #1
c0d038d0:	428a      	cmp	r2, r1
c0d038d2:	d803      	bhi.n	c0d038dc <ux_flow_direction+0x20>
c0d038d4:	20ff      	movs	r0, #255	; 0xff
		return FLOW_DIRECTION_FORWARD;
		}
		else if (G_ux.flow_stack[G_ux.stack_count-1].index < G_ux.flow_stack[G_ux.stack_count-1].prev_index) {
c0d038d6:	428a      	cmp	r2, r1
c0d038d8:	d300      	bcc.n	c0d038dc <ux_flow_direction+0x20>
c0d038da:	2000      	movs	r0, #0
			return FLOW_DIRECTION_BACKWARD;
		}
	}
  return FLOW_DIRECTION_START;
}
c0d038dc:	b240      	sxtb	r0, r0
c0d038de:	4770      	bx	lr
c0d038e0:	2000186c 	.word	0x2000186c

c0d038e4 <ux_flow_next_internal>:
			           STEPSPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->validate_flow), 
			           (const ux_flow_step_t*) PIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->params));
	}
}

static void ux_flow_next_internal(unsigned int display_step) {
c0d038e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d038e6:	b081      	sub	sp, #4
c0d038e8:	4601      	mov	r1, r0
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d038ea:	4a16      	ldr	r2, [pc, #88]	; (c0d03944 <ux_flow_next_internal+0x60>)
c0d038ec:	7810      	ldrb	r0, [r2, #0]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d038ee:	2801      	cmp	r0, #1
c0d038f0:	d826      	bhi.n	c0d03940 <ux_flow_next_internal+0x5c>
c0d038f2:	1e40      	subs	r0, r0, #1
c0d038f4:	230c      	movs	r3, #12
c0d038f6:	4343      	muls	r3, r0
c0d038f8:	18d2      	adds	r2, r2, r3
c0d038fa:	8b16      	ldrh	r6, [r2, #24]
}

static void ux_flow_next_internal(unsigned int display_step) {
	// last reached already (need validation, not next)
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d038fc:	2e00      	cmp	r6, #0
c0d038fe:	d01f      	beq.n	c0d03940 <ux_flow_next_internal+0x5c>
c0d03900:	6915      	ldr	r5, [r2, #16]
		|| G_ux.flow_stack[G_ux.stack_count-1].length <= 1
c0d03902:	2d00      	cmp	r5, #0
c0d03904:	d01c      	beq.n	c0d03940 <ux_flow_next_internal+0x5c>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
c0d03906:	2e02      	cmp	r6, #2
c0d03908:	d31a      	bcc.n	c0d03940 <ux_flow_next_internal+0x5c>
c0d0390a:	8a94      	ldrh	r4, [r2, #20]
c0d0390c:	4613      	mov	r3, r2
c0d0390e:	3314      	adds	r3, #20
c0d03910:	1e77      	subs	r7, r6, #1
	}
}

static void ux_flow_next_internal(unsigned int display_step) {
	// last reached already (need validation, not next)
	if (!ux_flow_check_valid()
c0d03912:	42a7      	cmp	r7, r4
c0d03914:	dd14      	ble.n	c0d03940 <ux_flow_next_internal+0x5c>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
		return;
	}

	// followed by a flow barrier ? => need validation instead of next
	if (G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {
c0d03916:	1eb6      	subs	r6, r6, #2
c0d03918:	42a6      	cmp	r6, r4
c0d0391a:	db0a      	blt.n	c0d03932 <ux_flow_next_internal+0x4e>
		if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d0391c:	00a6      	lsls	r6, r4, #2
c0d0391e:	19ad      	adds	r5, r5, r6
c0d03920:	686d      	ldr	r5, [r5, #4]
c0d03922:	1cae      	adds	r6, r5, #2
c0d03924:	d00c      	beq.n	c0d03940 <ux_flow_next_internal+0x5c>
c0d03926:	1ced      	adds	r5, r5, #3
c0d03928:	d103      	bne.n	c0d03932 <ux_flow_next_internal+0x4e>
c0d0392a:	2100      	movs	r1, #0
		}

		// followed by a flow barrier ? => need validation instead of next
		if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_LOOP) {
			// display first step, fake direction as forward
			G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index = 0;
c0d0392c:	8019      	strh	r1, [r3, #0]
c0d0392e:	82d1      	strh	r1, [r2, #22]
c0d03930:	e004      	b.n	c0d0393c <ux_flow_next_internal+0x58>
			return;
		}
	}

	// advance flow pointer and display it (skip META STEPS)
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
c0d03932:	82d4      	strh	r4, [r2, #22]
	G_ux.flow_stack[G_ux.stack_count-1].index++;
c0d03934:	1c62      	adds	r2, r4, #1
c0d03936:	801a      	strh	r2, [r3, #0]
	if (display_step) {
c0d03938:	2900      	cmp	r1, #0
c0d0393a:	d001      	beq.n	c0d03940 <ux_flow_next_internal+0x5c>
c0d0393c:	f000 f83c 	bl	c0d039b8 <ux_flow_engine_init_step>
		ux_flow_engine_init_step(G_ux.stack_count-1);
	}
}
c0d03940:	b001      	add	sp, #4
c0d03942:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03944:	2000186c 	.word	0x2000186c

c0d03948 <ux_flow_next>:

void ux_flow_next_no_display(void) {
	ux_flow_next_internal(0);
}

void ux_flow_next(void) {
c0d03948:	b580      	push	{r7, lr}
c0d0394a:	2001      	movs	r0, #1
	ux_flow_next_internal(1);
c0d0394c:	f7ff ffca 	bl	c0d038e4 <ux_flow_next_internal>
}
c0d03950:	bd80      	pop	{r7, pc}
	...

c0d03954 <ux_flow_prev>:

void ux_flow_prev(void) {
c0d03954:	b5b0      	push	{r4, r5, r7, lr}
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d03956:	4917      	ldr	r1, [pc, #92]	; (c0d039b4 <ux_flow_prev+0x60>)
c0d03958:	7808      	ldrb	r0, [r1, #0]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d0395a:	2801      	cmp	r0, #1
c0d0395c:	d828      	bhi.n	c0d039b0 <ux_flow_prev+0x5c>
c0d0395e:	1e40      	subs	r0, r0, #1
c0d03960:	220c      	movs	r2, #12
c0d03962:	4342      	muls	r2, r0
c0d03964:	1889      	adds	r1, r1, r2
c0d03966:	8b0a      	ldrh	r2, [r1, #24]
}

void ux_flow_prev(void) {
	// first reached already
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d03968:	2a00      	cmp	r2, #0
c0d0396a:	d021      	beq.n	c0d039b0 <ux_flow_prev+0x5c>
c0d0396c:	690c      	ldr	r4, [r1, #16]
		|| G_ux.flow_stack[G_ux.stack_count-1].length <= 1
c0d0396e:	2c00      	cmp	r4, #0
c0d03970:	d01e      	beq.n	c0d039b0 <ux_flow_prev+0x5c>
		|| (G_ux.flow_stack[G_ux.stack_count-1].index == 0 
c0d03972:	2a02      	cmp	r2, #2
c0d03974:	d31c      	bcc.n	c0d039b0 <ux_flow_prev+0x5c>
c0d03976:	8a8d      	ldrh	r5, [r1, #20]
c0d03978:	460b      	mov	r3, r1
c0d0397a:	3314      	adds	r3, #20
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
c0d0397c:	2d00      	cmp	r5, #0
c0d0397e:	d00a      	beq.n	c0d03996 <ux_flow_prev+0x42>
		ux_flow_engine_init_step(G_ux.stack_count-1);
		return;
	}

	// previous item is a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index-1] == FLOW_BARRIER) {
c0d03980:	00aa      	lsls	r2, r5, #2
c0d03982:	18a2      	adds	r2, r4, r2
c0d03984:	2403      	movs	r4, #3
c0d03986:	43e4      	mvns	r4, r4
c0d03988:	5912      	ldr	r2, [r2, r4]
c0d0398a:	1c92      	adds	r2, r2, #2
c0d0398c:	d010      	beq.n	c0d039b0 <ux_flow_prev+0x5c>
		return;
	}

	// advance flow pointer and display it (skip META STEPS)
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
c0d0398e:	82cd      	strh	r5, [r1, #22]
	G_ux.flow_stack[G_ux.stack_count-1].index--;
c0d03990:	1e69      	subs	r1, r5, #1
c0d03992:	8019      	strh	r1, [r3, #0]
c0d03994:	e00a      	b.n	c0d039ac <ux_flow_prev+0x58>
	// first reached already
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
		|| G_ux.flow_stack[G_ux.stack_count-1].length <= 1
		|| (G_ux.flow_stack[G_ux.stack_count-1].index == 0 
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
c0d03996:	0095      	lsls	r5, r2, #2
c0d03998:	1964      	adds	r4, r4, r5
c0d0399a:	2503      	movs	r5, #3
c0d0399c:	43ed      	mvns	r5, r5
c0d0399e:	5964      	ldr	r4, [r4, r5]
	ux_flow_next_internal(1);
}

void ux_flow_prev(void) {
	// first reached already
	if (!ux_flow_check_valid()
c0d039a0:	1ce4      	adds	r4, r4, #3
c0d039a2:	d105      	bne.n	c0d039b0 <ux_flow_prev+0x5c>

	// loop in flow (before checking barrier as there is no prestep when looping)
	if (G_ux.flow_stack[G_ux.stack_count-1].index == 0
		&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] == FLOW_LOOP) {
		// display last step (shall skip BARRIER if any, but a flow finishing with a BARRIER is cryptic)
		G_ux.flow_stack[G_ux.stack_count-1].index = G_ux.flow_stack[G_ux.stack_count-1].length-2;
c0d039a4:	1e94      	subs	r4, r2, #2
c0d039a6:	801c      	strh	r4, [r3, #0]
		// fact direction as backward
		G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index+1;
c0d039a8:	1e52      	subs	r2, r2, #1
c0d039aa:	82ca      	strh	r2, [r1, #22]
c0d039ac:	f000 f804 	bl	c0d039b8 <ux_flow_engine_init_step>
	// advance flow pointer and display it (skip META STEPS)
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
	G_ux.flow_stack[G_ux.stack_count-1].index--;

	ux_flow_engine_init_step(G_ux.stack_count-1);
}
c0d039b0:	bdb0      	pop	{r4, r5, r7, pc}
c0d039b2:	46c0      	nop			; (mov r8, r8)
c0d039b4:	2000186c 	.word	0x2000186c

c0d039b8 <ux_flow_engine_init_step>:
		return NULL;
	}
	return STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index]);
}

static void ux_flow_engine_init_step(unsigned int stack_slot) {
c0d039b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d039ba:	b081      	sub	sp, #4
c0d039bc:	4604      	mov	r4, r0
c0d039be:	200c      	movs	r0, #12
	// invalid ux_flow_length ??? (previous check shall have exited earlier)
	if (G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] == FLOW_END_STEP) {
c0d039c0:	4360      	muls	r0, r4
c0d039c2:	491a      	ldr	r1, [pc, #104]	; (c0d03a2c <ux_flow_engine_init_step+0x74>)
c0d039c4:	180e      	adds	r6, r1, r0
c0d039c6:	6930      	ldr	r0, [r6, #16]
c0d039c8:	8ab1      	ldrh	r1, [r6, #20]
c0d039ca:	0089      	lsls	r1, r1, #2
c0d039cc:	5840      	ldr	r0, [r0, r1]
c0d039ce:	4637      	mov	r7, r6
c0d039d0:	3714      	adds	r7, #20
c0d039d2:	3610      	adds	r6, #16
c0d039d4:	2103      	movs	r1, #3
c0d039d6:	43c9      	mvns	r1, r1
c0d039d8:	4288      	cmp	r0, r1
c0d039da:	d824      	bhi.n	c0d03a26 <ux_flow_engine_init_step+0x6e>
	// this shall not have occured due to previous checks
	if (G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] == FLOW_LOOP) {
		return;
	}
	// if init function is set, call it
	if (STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init) {
c0d039dc:	f7fd ff58 	bl	c0d01890 <pic>
c0d039e0:	6831      	ldr	r1, [r6, #0]
c0d039e2:	883a      	ldrh	r2, [r7, #0]
c0d039e4:	0092      	lsls	r2, r2, #2
c0d039e6:	5889      	ldr	r1, [r1, r2]
c0d039e8:	6805      	ldr	r5, [r0, #0]
c0d039ea:	4608      	mov	r0, r1
c0d039ec:	f7fd ff50 	bl	c0d01890 <pic>
c0d039f0:	2d00      	cmp	r5, #0
c0d039f2:	d006      	beq.n	c0d03a02 <ux_flow_engine_init_step+0x4a>
		INITPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init)(stack_slot);
c0d039f4:	6800      	ldr	r0, [r0, #0]
c0d039f6:	f7fd ff4b 	bl	c0d01890 <pic>
c0d039fa:	4601      	mov	r1, r0
c0d039fc:	4620      	mov	r0, r4
c0d039fe:	4788      	blx	r1
c0d03a00:	e011      	b.n	c0d03a26 <ux_flow_engine_init_step+0x6e>
	}
	else {
		// if init method is not set, jump to referenced flow and step
		ux_flow_init(stack_slot,
			           STEPSPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->validate_flow), 
c0d03a02:	6880      	ldr	r0, [r0, #8]
c0d03a04:	f7fd ff44 	bl	c0d01890 <pic>
c0d03a08:	4605      	mov	r5, r0
			           (const ux_flow_step_t*) PIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->params));
c0d03a0a:	6830      	ldr	r0, [r6, #0]
c0d03a0c:	8839      	ldrh	r1, [r7, #0]
c0d03a0e:	0089      	lsls	r1, r1, #2
c0d03a10:	5840      	ldr	r0, [r0, r1]
c0d03a12:	f7fd ff3d 	bl	c0d01890 <pic>
c0d03a16:	6840      	ldr	r0, [r0, #4]
c0d03a18:	f7fd ff3a 	bl	c0d01890 <pic>
c0d03a1c:	4602      	mov	r2, r0
	if (STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init) {
		INITPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init)(stack_slot);
	}
	else {
		// if init method is not set, jump to referenced flow and step
		ux_flow_init(stack_slot,
c0d03a1e:	4620      	mov	r0, r4
c0d03a20:	4629      	mov	r1, r5
c0d03a22:	f000 f85d 	bl	c0d03ae0 <ux_flow_init>
			           STEPSPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->validate_flow), 
			           (const ux_flow_step_t*) PIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->params));
	}
}
c0d03a26:	b001      	add	sp, #4
c0d03a28:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03a2a:	46c0      	nop			; (mov r8, r8)
c0d03a2c:	2000186c 	.word	0x2000186c

c0d03a30 <ux_flow_validate>:
	G_ux.flow_stack[G_ux.stack_count-1].index--;

	ux_flow_engine_init_step(G_ux.stack_count-1);
}

void ux_flow_validate(void) {
c0d03a30:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03a32:	b081      	sub	sp, #4
#include "string.h"

#ifdef HAVE_UX_FLOW

static unsigned int ux_flow_check_valid(void) {
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d03a34:	4d29      	ldr	r5, [pc, #164]	; (c0d03adc <ux_flow_validate+0xac>)
c0d03a36:	7828      	ldrb	r0, [r5, #0]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d03a38:	2801      	cmp	r0, #1
c0d03a3a:	d825      	bhi.n	c0d03a88 <ux_flow_validate+0x58>
c0d03a3c:	1e40      	subs	r0, r0, #1
c0d03a3e:	260c      	movs	r6, #12
c0d03a40:	4370      	muls	r0, r6
c0d03a42:	182a      	adds	r2, r5, r0
c0d03a44:	8b10      	ldrh	r0, [r2, #24]
}

void ux_flow_validate(void) {
	// no flow ?
	if (!ux_flow_check_valid()
	  || G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d03a46:	2800      	cmp	r0, #0
c0d03a48:	d01e      	beq.n	c0d03a88 <ux_flow_validate+0x58>
c0d03a4a:	6911      	ldr	r1, [r2, #16]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0
c0d03a4c:	2900      	cmp	r1, #0
c0d03a4e:	d01b      	beq.n	c0d03a88 <ux_flow_validate+0x58>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length) {
c0d03a50:	8a92      	ldrh	r2, [r2, #20]
	ux_flow_engine_init_step(G_ux.stack_count-1);
}

void ux_flow_validate(void) {
	// no flow ?
	if (!ux_flow_check_valid()
c0d03a52:	4282      	cmp	r2, r0
c0d03a54:	d218      	bcs.n	c0d03a88 <ux_flow_validate+0x58>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length) {
		return;
	}

	// no validation flow ?
	if (STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index])->validate_flow != NULL) {
c0d03a56:	0090      	lsls	r0, r2, #2
c0d03a58:	5808      	ldr	r0, [r1, r0]
c0d03a5a:	f7fd ff19 	bl	c0d01890 <pic>
c0d03a5e:	6880      	ldr	r0, [r0, #8]
c0d03a60:	7829      	ldrb	r1, [r5, #0]
c0d03a62:	1e4c      	subs	r4, r1, #1
	}
	else {
		// if next is a barrier, then proceed to the item after the barrier
		// if NOT followed by a barrier, then validation is only performed through 
		// a validate_flow specified in the step, else ignored
		if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d03a64:	4366      	muls	r6, r4
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length) {
		return;
	}

	// no validation flow ?
	if (STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index])->validate_flow != NULL) {
c0d03a66:	2800      	cmp	r0, #0
c0d03a68:	d010      	beq.n	c0d03a8c <ux_flow_validate+0x5c>
		// execute validation flow
		ux_flow_init(G_ux.stack_count-1, STEPSPIC(STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index])->validate_flow), NULL);
c0d03a6a:	19a8      	adds	r0, r5, r6
c0d03a6c:	6901      	ldr	r1, [r0, #16]
c0d03a6e:	8a80      	ldrh	r0, [r0, #20]
c0d03a70:	0080      	lsls	r0, r0, #2
c0d03a72:	5808      	ldr	r0, [r1, r0]
c0d03a74:	f7fd ff0c 	bl	c0d01890 <pic>
c0d03a78:	6880      	ldr	r0, [r0, #8]
c0d03a7a:	f7fd ff09 	bl	c0d01890 <pic>
c0d03a7e:	4601      	mov	r1, r0
c0d03a80:	2200      	movs	r2, #0
c0d03a82:	4620      	mov	r0, r4
c0d03a84:	f000 f82c 	bl	c0d03ae0 <ux_flow_init>
				// execute reached step
				ux_flow_engine_init_step(G_ux.stack_count-1);
			}
		}
	}
}
c0d03a88:	b001      	add	sp, #4
c0d03a8a:	bdf0      	pop	{r4, r5, r6, r7, pc}
	}
	else {
		// if next is a barrier, then proceed to the item after the barrier
		// if NOT followed by a barrier, then validation is only performed through 
		// a validate_flow specified in the step, else ignored
		if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d03a8c:	19a8      	adds	r0, r5, r6
c0d03a8e:	8b03      	ldrh	r3, [r0, #24]
			&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {
c0d03a90:	2b00      	cmp	r3, #0
c0d03a92:	d0f9      	beq.n	c0d03a88 <ux_flow_validate+0x58>
c0d03a94:	8a82      	ldrh	r2, [r0, #20]
c0d03a96:	4601      	mov	r1, r0
c0d03a98:	3114      	adds	r1, #20
c0d03a9a:	1e9b      	subs	r3, r3, #2
	}
	else {
		// if next is a barrier, then proceed to the item after the barrier
		// if NOT followed by a barrier, then validation is only performed through 
		// a validate_flow specified in the step, else ignored
		if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d03a9c:	4293      	cmp	r3, r2
c0d03a9e:	dbf3      	blt.n	c0d03a88 <ux_flow_validate+0x58>
			&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {

			if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d03aa0:	6905      	ldr	r5, [r0, #16]
c0d03aa2:	0096      	lsls	r6, r2, #2
c0d03aa4:	19ae      	adds	r6, r5, r6
c0d03aa6:	6876      	ldr	r6, [r6, #4]
c0d03aa8:	1cf7      	adds	r7, r6, #3
c0d03aaa:	d010      	beq.n	c0d03ace <ux_flow_validate+0x9e>
c0d03aac:	1cb6      	adds	r6, r6, #2
c0d03aae:	d1eb      	bne.n	c0d03a88 <ux_flow_validate+0x58>
c0d03ab0:	4616      	mov	r6, r2

				// take into account multi barrier at once, kthx poor code review
				while (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
					&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2
					&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d03ab2:	00b6      	lsls	r6, r6, #2
c0d03ab4:	19ae      	adds	r6, r5, r6
c0d03ab6:	6876      	ldr	r6, [r6, #4]
			&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {

			if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {

				// take into account multi barrier at once, kthx poor code review
				while (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d03ab8:	1cb6      	adds	r6, r6, #2
c0d03aba:	d104      	bne.n	c0d03ac6 <ux_flow_validate+0x96>
					&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2
					&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
					G_ux.flow_stack[G_ux.stack_count-1].index++;
c0d03abc:	1c52      	adds	r2, r2, #1
c0d03abe:	800a      	strh	r2, [r1, #0]

			if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {

				// take into account multi barrier at once, kthx poor code review
				while (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
					&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2
c0d03ac0:	b296      	uxth	r6, r2
					&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d03ac2:	42b3      	cmp	r3, r6
c0d03ac4:	daf5      	bge.n	c0d03ab2 <ux_flow_validate+0x82>
					G_ux.flow_stack[G_ux.stack_count-1].index++;
				}
				// skip to next step
				G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
c0d03ac6:	82c2      	strh	r2, [r0, #22]
				G_ux.flow_stack[G_ux.stack_count-1].index++;
c0d03ac8:	1c50      	adds	r0, r2, #1
c0d03aca:	8008      	strh	r0, [r1, #0]
c0d03acc:	e002      	b.n	c0d03ad4 <ux_flow_validate+0xa4>
c0d03ace:	2200      	movs	r2, #0
				ux_flow_engine_init_step(G_ux.stack_count-1);
			}
			// reached the last step, but step if FLOW_LOOP
			else if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_LOOP) {
				// we go the forward direction
				G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index = 0;
c0d03ad0:	800a      	strh	r2, [r1, #0]
c0d03ad2:	82c2      	strh	r2, [r0, #22]
c0d03ad4:	4620      	mov	r0, r4
c0d03ad6:	f7ff ff6f 	bl	c0d039b8 <ux_flow_engine_init_step>
c0d03ada:	e7d5      	b.n	c0d03a88 <ux_flow_validate+0x58>
c0d03adc:	2000186c 	.word	0x2000186c

c0d03ae0 <ux_flow_init>:
 * Last step is marked with a FLOW_END_STEP value
 */
#define FLOW_END_STEP ((void*)0xFFFFFFFFUL)
#define FLOW_BARRIER  ((void*)0xFFFFFFFEUL)
#define FLOW_START    ((void*)0xFFFFFFFDUL)
void ux_flow_init(unsigned int stack_slot, const ux_flow_step_t* const * steps, const ux_flow_step_t* const start_step) {
c0d03ae0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03ae2:	b083      	sub	sp, #12
c0d03ae4:	9201      	str	r2, [sp, #4]
c0d03ae6:	460c      	mov	r4, r1
c0d03ae8:	220c      	movs	r2, #12
	G_ux.flow_stack[stack_slot].length = G_ux.flow_stack[stack_slot].prev_index = G_ux.flow_stack[stack_slot].index = 0;
c0d03aea:	4611      	mov	r1, r2
c0d03aec:	9002      	str	r0, [sp, #8]
c0d03aee:	4341      	muls	r1, r0
c0d03af0:	4b1f      	ldr	r3, [pc, #124]	; (c0d03b70 <ux_flow_init+0x90>)
c0d03af2:	185f      	adds	r7, r3, r1
c0d03af4:	2100      	movs	r1, #0
	G_ux.flow_stack[stack_slot].steps = NULL;
c0d03af6:	8339      	strh	r1, [r7, #24]
c0d03af8:	6139      	str	r1, [r7, #16]
c0d03afa:	6179      	str	r1, [r7, #20]
	
	// reset paging to avoid troubles if first step is a paginated step
	os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d03afc:	1d18      	adds	r0, r3, #4
c0d03afe:	f7fc ffef 	bl	c0d00ae0 <os_memset>
c0d03b02:	4620      	mov	r0, r4
 */
#define FLOW_END_STEP ((void*)0xFFFFFFFFUL)
#define FLOW_BARRIER  ((void*)0xFFFFFFFEUL)
#define FLOW_START    ((void*)0xFFFFFFFDUL)
void ux_flow_init(unsigned int stack_slot, const ux_flow_step_t* const * steps, const ux_flow_step_t* const start_step) {
	G_ux.flow_stack[stack_slot].length = G_ux.flow_stack[stack_slot].prev_index = G_ux.flow_stack[stack_slot].index = 0;
c0d03b04:	463c      	mov	r4, r7
c0d03b06:	3410      	adds	r4, #16
c0d03b08:	463d      	mov	r5, r7
c0d03b0a:	3518      	adds	r5, #24
c0d03b0c:	463e      	mov	r6, r7
c0d03b0e:	3616      	adds	r6, #22
c0d03b10:	3714      	adds	r7, #20
	G_ux.flow_stack[stack_slot].steps = NULL;
	
	// reset paging to avoid troubles if first step is a paginated step
	os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));

	if (steps) {
c0d03b12:	2800      	cmp	r0, #0
c0d03b14:	d02a      	beq.n	c0d03b6c <ux_flow_init+0x8c>
		G_ux.flow_stack[stack_slot].steps = STEPSPIC(steps);
c0d03b16:	f7fd febb 	bl	c0d01890 <pic>
c0d03b1a:	6020      	str	r0, [r4, #0]
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
c0d03b1c:	8829      	ldrh	r1, [r5, #0]
c0d03b1e:	008a      	lsls	r2, r1, #2
c0d03b20:	5882      	ldr	r2, [r0, r2]
c0d03b22:	1c52      	adds	r2, r2, #1
c0d03b24:	d006      	beq.n	c0d03b34 <ux_flow_init+0x54>
			G_ux.flow_stack[stack_slot].length++;
c0d03b26:	1c49      	adds	r1, r1, #1
	// reset paging to avoid troubles if first step is a paginated step
	os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));

	if (steps) {
		G_ux.flow_stack[stack_slot].steps = STEPSPIC(steps);
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
c0d03b28:	b28a      	uxth	r2, r1
c0d03b2a:	0092      	lsls	r2, r2, #2
c0d03b2c:	5882      	ldr	r2, [r0, r2]
c0d03b2e:	1c52      	adds	r2, r2, #1
c0d03b30:	d1f9      	bne.n	c0d03b26 <ux_flow_init+0x46>
c0d03b32:	8029      	strh	r1, [r5, #0]
c0d03b34:	9801      	ldr	r0, [sp, #4]
			G_ux.flow_stack[stack_slot].length++;
		}
		if (start_step != NULL) {
c0d03b36:	2800      	cmp	r0, #0
c0d03b38:	d015      	beq.n	c0d03b66 <ux_flow_init+0x86>
			const ux_flow_step_t* const start_step2  = STEPPIC(start_step);
c0d03b3a:	f7fd fea9 	bl	c0d01890 <pic>
c0d03b3e:	4605      	mov	r5, r0
			while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] != FLOW_END_STEP
c0d03b40:	6820      	ldr	r0, [r4, #0]
c0d03b42:	8839      	ldrh	r1, [r7, #0]
c0d03b44:	0089      	lsls	r1, r1, #2
c0d03b46:	5840      	ldr	r0, [r0, r1]
c0d03b48:	e00b      	b.n	c0d03b62 <ux_flow_init+0x82>
				 && STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index]) != start_step2) {
c0d03b4a:	f7fd fea1 	bl	c0d01890 <pic>
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
			G_ux.flow_stack[stack_slot].length++;
		}
		if (start_step != NULL) {
			const ux_flow_step_t* const start_step2  = STEPPIC(start_step);
			while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] != FLOW_END_STEP
c0d03b4e:	42a8      	cmp	r0, r5
c0d03b50:	d009      	beq.n	c0d03b66 <ux_flow_init+0x86>
				 && STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index]) != start_step2) {
				G_ux.flow_stack[stack_slot].prev_index = G_ux.flow_stack[stack_slot].index;
c0d03b52:	8838      	ldrh	r0, [r7, #0]
c0d03b54:	8030      	strh	r0, [r6, #0]
				G_ux.flow_stack[stack_slot].index++;
c0d03b56:	1c40      	adds	r0, r0, #1
c0d03b58:	8038      	strh	r0, [r7, #0]
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
			G_ux.flow_stack[stack_slot].length++;
		}
		if (start_step != NULL) {
			const ux_flow_step_t* const start_step2  = STEPPIC(start_step);
			while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] != FLOW_END_STEP
c0d03b5a:	b280      	uxth	r0, r0
c0d03b5c:	0080      	lsls	r0, r0, #2
c0d03b5e:	6821      	ldr	r1, [r4, #0]
c0d03b60:	5808      	ldr	r0, [r1, r0]
				 && STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index]) != start_step2) {
c0d03b62:	1c41      	adds	r1, r0, #1
c0d03b64:	d1f1      	bne.n	c0d03b4a <ux_flow_init+0x6a>
				G_ux.flow_stack[stack_slot].index++;
			}
		}

		// init step
		ux_flow_engine_init_step(stack_slot);
c0d03b66:	9802      	ldr	r0, [sp, #8]
c0d03b68:	f7ff ff26 	bl	c0d039b8 <ux_flow_engine_init_step>
	}
}
c0d03b6c:	b003      	add	sp, #12
c0d03b6e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03b70:	2000186c 	.word	0x2000186c

c0d03b74 <ux_flow_button_callback>:

void ux_flow_uninit(unsigned int stack_slot) {
	memset(&G_ux.flow_stack[stack_slot], 0, sizeof(G_ux.flow_stack[stack_slot]));
}

unsigned int ux_flow_button_callback(unsigned int button_mask, unsigned int button_mask_counter) {
c0d03b74:	b580      	push	{r7, lr}
c0d03b76:	490a      	ldr	r1, [pc, #40]	; (c0d03ba0 <ux_flow_button_callback+0x2c>)
  UNUSED(button_mask_counter);
  switch(button_mask) {
c0d03b78:	4288      	cmp	r0, r1
c0d03b7a:	d008      	beq.n	c0d03b8e <ux_flow_button_callback+0x1a>
c0d03b7c:	4909      	ldr	r1, [pc, #36]	; (c0d03ba4 <ux_flow_button_callback+0x30>)
c0d03b7e:	4288      	cmp	r0, r1
c0d03b80:	d008      	beq.n	c0d03b94 <ux_flow_button_callback+0x20>
c0d03b82:	4909      	ldr	r1, [pc, #36]	; (c0d03ba8 <ux_flow_button_callback+0x34>)
c0d03b84:	4288      	cmp	r0, r1
c0d03b86:	d108      	bne.n	c0d03b9a <ux_flow_button_callback+0x26>
    case BUTTON_EVT_RELEASED|BUTTON_LEFT:
      ux_flow_prev();
c0d03b88:	f7ff fee4 	bl	c0d03954 <ux_flow_prev>
c0d03b8c:	e005      	b.n	c0d03b9a <ux_flow_button_callback+0x26>
      break;
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      ux_flow_next();
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      ux_flow_validate();
c0d03b8e:	f7ff ff4f 	bl	c0d03a30 <ux_flow_validate>
c0d03b92:	e002      	b.n	c0d03b9a <ux_flow_button_callback+0x26>
c0d03b94:	2001      	movs	r0, #1
void ux_flow_next_no_display(void) {
	ux_flow_next_internal(0);
}

void ux_flow_next(void) {
	ux_flow_next_internal(1);
c0d03b96:	f7ff fea5 	bl	c0d038e4 <ux_flow_next_internal>
c0d03b9a:	2000      	movs	r0, #0
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      ux_flow_validate();
      break;
  }
  return 0;
c0d03b9c:	bd80      	pop	{r7, pc}
c0d03b9e:	46c0      	nop			; (mov r8, r8)
c0d03ba0:	80000003 	.word	0x80000003
c0d03ba4:	80000002 	.word	0x80000002
c0d03ba8:	80000001 	.word	0x80000001

c0d03bac <ux_stack_get_step_params>:
}

void* ux_stack_get_step_params(unsigned int stack_slot) {
c0d03bac:	b510      	push	{r4, lr}
c0d03bae:	4601      	mov	r1, r0
c0d03bb0:	2000      	movs	r0, #0
	if (stack_slot >= UX_STACK_SLOT_COUNT) {
c0d03bb2:	2900      	cmp	r1, #0
c0d03bb4:	d10f      	bne.n	c0d03bd6 <ux_stack_get_step_params+0x2a>
		return NULL;
	}

	if (G_ux.flow_stack[stack_slot].length == 0) {
c0d03bb6:	4c08      	ldr	r4, [pc, #32]	; (c0d03bd8 <ux_stack_get_step_params+0x2c>)
c0d03bb8:	8b21      	ldrh	r1, [r4, #24]
		return NULL;
	}

	if (G_ux.flow_stack[stack_slot].index >= G_ux.flow_stack[stack_slot].length) {
c0d03bba:	8aa2      	ldrh	r2, [r4, #20]
void* ux_stack_get_step_params(unsigned int stack_slot) {
	if (stack_slot >= UX_STACK_SLOT_COUNT) {
		return NULL;
	}

	if (G_ux.flow_stack[stack_slot].length == 0) {
c0d03bbc:	428a      	cmp	r2, r1
c0d03bbe:	d20a      	bcs.n	c0d03bd6 <ux_stack_get_step_params+0x2a>

	if (G_ux.flow_stack[stack_slot].index >= G_ux.flow_stack[stack_slot].length) {
		return NULL;
	}

	return (void*)PIC(STEPPIC(STEPSPIC(G_ux.flow_stack[stack_slot].steps)[G_ux.flow_stack[stack_slot].index])->params);
c0d03bc0:	6920      	ldr	r0, [r4, #16]
c0d03bc2:	f7fd fe65 	bl	c0d01890 <pic>
c0d03bc6:	8aa1      	ldrh	r1, [r4, #20]
c0d03bc8:	0089      	lsls	r1, r1, #2
c0d03bca:	5840      	ldr	r0, [r0, r1]
c0d03bcc:	f7fd fe60 	bl	c0d01890 <pic>
c0d03bd0:	6840      	ldr	r0, [r0, #4]
c0d03bd2:	f7fd fe5d 	bl	c0d01890 <pic>
}
c0d03bd6:	bd10      	pop	{r4, pc}
c0d03bd8:	2000186c 	.word	0x2000186c

c0d03bdc <ux_stack_get_current_step_params>:

void* ux_stack_get_current_step_params(void) {
c0d03bdc:	b580      	push	{r7, lr}
	return ux_stack_get_step_params(G_ux.stack_count-1);
c0d03bde:	4803      	ldr	r0, [pc, #12]	; (c0d03bec <ux_stack_get_current_step_params+0x10>)
c0d03be0:	7800      	ldrb	r0, [r0, #0]
c0d03be2:	1e40      	subs	r0, r0, #1
c0d03be4:	f7ff ffe2 	bl	c0d03bac <ux_stack_get_step_params>
c0d03be8:	bd80      	pop	{r7, pc}
c0d03bea:	46c0      	nop			; (mov r8, r8)
c0d03bec:	2000186c 	.word	0x2000186c

c0d03bf0 <ux_layout_bb_init_common>:
  }
  return &G_ux.tmp_element;
}
*/

void ux_layout_bb_init_common(unsigned int stack_slot) {
c0d03bf0:	b510      	push	{r4, lr}
c0d03bf2:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d03bf4:	f000 fbf2 	bl	c0d043dc <ux_stack_init>
c0d03bf8:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_bb_elements;
c0d03bfa:	4360      	muls	r0, r4
c0d03bfc:	4908      	ldr	r1, [pc, #32]	; (c0d03c20 <ux_layout_bb_init_common+0x30>)
c0d03bfe:	1808      	adds	r0, r1, r0
c0d03c00:	21c4      	movs	r1, #196	; 0xc4
c0d03c02:	2205      	movs	r2, #5
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_bb_elements);
c0d03c04:	5442      	strb	r2, [r0, r1]
c0d03c06:	21c0      	movs	r1, #192	; 0xc0
}
*/

void ux_layout_bb_init_common(unsigned int stack_slot) {
  ux_stack_init(stack_slot);
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_bb_elements;
c0d03c08:	4a06      	ldr	r2, [pc, #24]	; (c0d03c24 <ux_layout_bb_init_common+0x34>)
c0d03c0a:	447a      	add	r2, pc
c0d03c0c:	5042      	str	r2, [r0, r1]
c0d03c0e:	21bd      	movs	r1, #189	; 0xbd
c0d03c10:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_bb_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d03c12:	5442      	strb	r2, [r0, r1]
c0d03c14:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d03c16:	4a04      	ldr	r2, [pc, #16]	; (c0d03c28 <ux_layout_bb_init_common+0x38>)
c0d03c18:	447a      	add	r2, pc
c0d03c1a:	5042      	str	r2, [r0, r1]
}
c0d03c1c:	bd10      	pop	{r4, pc}
c0d03c1e:	46c0      	nop			; (mov r8, r8)
c0d03c20:	2000186c 	.word	0x2000186c
c0d03c24:	000013fa 	.word	0x000013fa
c0d03c28:	ffffff59 	.word	0xffffff59

c0d03c2c <ux_layout_bn_prepro>:
#endif
#endif
};
*/

const bagl_element_t* ux_layout_bn_prepro(const bagl_element_t* element) {
c0d03c2c:	b580      	push	{r7, lr}
      G_ux.tmp_element.text = params->line2;
      break;
  }
  return &G_ux.tmp_element;
*/
  const bagl_element_t* e = ux_layout_strings_prepro(element);
c0d03c2e:	f000 fae9 	bl	c0d04204 <ux_layout_strings_prepro>
c0d03c32:	229d      	movs	r2, #157	; 0x9d
  if (e && G_ux.tmp_element.component.userid == 0x11) {
c0d03c34:	2800      	cmp	r0, #0
c0d03c36:	d006      	beq.n	c0d03c46 <ux_layout_bn_prepro+0x1a>
c0d03c38:	4903      	ldr	r1, [pc, #12]	; (c0d03c48 <ux_layout_bn_prepro+0x1c>)
c0d03c3a:	5c8a      	ldrb	r2, [r1, r2]
c0d03c3c:	2a11      	cmp	r2, #17
c0d03c3e:	d102      	bne.n	c0d03c46 <ux_layout_bn_prepro+0x1a>
c0d03c40:	22b4      	movs	r2, #180	; 0xb4
c0d03c42:	4b02      	ldr	r3, [pc, #8]	; (c0d03c4c <ux_layout_bn_prepro+0x20>)
    G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_REGULAR_11px|BAGL_FONT_ALIGNMENT_CENTER;
c0d03c44:	528b      	strh	r3, [r1, r2]
  }
  return e;
c0d03c46:	bd80      	pop	{r7, pc}
c0d03c48:	2000186c 	.word	0x2000186c
c0d03c4c:	0000800a 	.word	0x0000800a

c0d03c50 <ux_layout_bn_init>:
}

void ux_layout_bn_init(unsigned int stack_slot) { 
c0d03c50:	b510      	push	{r4, lr}
c0d03c52:	4604      	mov	r4, r0
  ux_layout_bb_init_common(stack_slot);
c0d03c54:	f7ff ffcc 	bl	c0d03bf0 <ux_layout_bb_init_common>
c0d03c58:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_bn_prepro;
c0d03c5a:	4360      	muls	r0, r4
c0d03c5c:	4904      	ldr	r1, [pc, #16]	; (c0d03c70 <ux_layout_bn_init+0x20>)
c0d03c5e:	1808      	adds	r0, r1, r0
c0d03c60:	21cc      	movs	r1, #204	; 0xcc
c0d03c62:	4a04      	ldr	r2, [pc, #16]	; (c0d03c74 <ux_layout_bn_init+0x24>)
c0d03c64:	447a      	add	r2, pc
c0d03c66:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d03c68:	4620      	mov	r0, r4
c0d03c6a:	f000 fb91 	bl	c0d04390 <ux_stack_display>
}
c0d03c6e:	bd10      	pop	{r4, pc}
c0d03c70:	2000186c 	.word	0x2000186c
c0d03c74:	ffffffc5 	.word	0xffffffc5

c0d03c78 <ux_layout_nnbnn_prepro>:
  {{BAGL_LABELINE                       , 0x12,   0,  19, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},  
  {{BAGL_LABELINE                       , 0x13,   0,  35, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_REGULAR_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
#endif // TARGET_NANOX
};

const bagl_element_t* ux_layout_nnbnn_prepro(const bagl_element_t* element) {
c0d03c78:	b570      	push	{r4, r5, r6, lr}
c0d03c7a:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_strings_params_t* params = (const ux_layout_strings_params_t*)ux_stack_get_current_step_params();
c0d03c7c:	f7ff ffae 	bl	c0d03bdc <ux_stack_get_current_step_params>
c0d03c80:	4604      	mov	r4, r0

	// ocpy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d03c82:	4e11      	ldr	r6, [pc, #68]	; (c0d03cc8 <ux_layout_nnbnn_prepro+0x50>)
c0d03c84:	4630      	mov	r0, r6
c0d03c86:	309c      	adds	r0, #156	; 0x9c
c0d03c88:	2220      	movs	r2, #32
c0d03c8a:	4629      	mov	r1, r5
c0d03c8c:	f7fc ff12 	bl	c0d00ab4 <os_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d03c90:	7868      	ldrb	r0, [r5, #1]
c0d03c92:	4601      	mov	r1, r0
c0d03c94:	3910      	subs	r1, #16
c0d03c96:	2905      	cmp	r1, #5
c0d03c98:	d20a      	bcs.n	c0d03cb0 <ux_layout_nnbnn_prepro+0x38>
c0d03c9a:	209d      	movs	r0, #157	; 0x9d
    case 0x10:
    case 0x11:
    case 0x12:
    case 0x13:
    case 0x14:
      G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
c0d03c9c:	5c30      	ldrb	r0, [r6, r0]
c0d03c9e:	210f      	movs	r1, #15
c0d03ca0:	4001      	ands	r1, r0
c0d03ca2:	0088      	lsls	r0, r1, #2
c0d03ca4:	5820      	ldr	r0, [r4, r0]
c0d03ca6:	21b8      	movs	r1, #184	; 0xb8
c0d03ca8:	5070      	str	r0, [r6, r1]
c0d03caa:	369c      	adds	r6, #156	; 0x9c
c0d03cac:	4630      	mov	r0, r6
      break;
  }
  return &G_ux.tmp_element;
}
c0d03cae:	bd70      	pop	{r4, r5, r6, pc}

	// ocpy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d03cb0:	2802      	cmp	r0, #2
c0d03cb2:	d003      	beq.n	c0d03cbc <ux_layout_nnbnn_prepro+0x44>
c0d03cb4:	2801      	cmp	r0, #1
c0d03cb6:	d1f8      	bne.n	c0d03caa <ux_layout_nnbnn_prepro+0x32>

    case 0x01:
  		if (!params->lines[1]) {
c0d03cb8:	6861      	ldr	r1, [r4, #4]
c0d03cba:	e000      	b.n	c0d03cbe <ux_layout_nnbnn_prepro+0x46>
  			return NULL;
  		}
  		break;

  	case 0x02:
  		if (!params->lines[3]) {
c0d03cbc:	68e1      	ldr	r1, [r4, #12]
c0d03cbe:	2000      	movs	r0, #0
c0d03cc0:	2900      	cmp	r1, #0
c0d03cc2:	d1f2      	bne.n	c0d03caa <ux_layout_nnbnn_prepro+0x32>
c0d03cc4:	e7f3      	b.n	c0d03cae <ux_layout_nnbnn_prepro+0x36>
c0d03cc6:	46c0      	nop			; (mov r8, r8)
c0d03cc8:	2000186c 	.word	0x2000186c

c0d03ccc <ux_layout_nnbnn_init>:
      break;
  }
  return &G_ux.tmp_element;
}

void ux_layout_nnbnn_init(unsigned int stack_slot) {
c0d03ccc:	b510      	push	{r4, lr}
c0d03cce:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d03cd0:	f000 fb84 	bl	c0d043dc <ux_stack_init>
c0d03cd4:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_nnbnn_elements;
c0d03cd6:	4360      	muls	r0, r4
c0d03cd8:	490b      	ldr	r1, [pc, #44]	; (c0d03d08 <ux_layout_nnbnn_init+0x3c>)
c0d03cda:	1808      	adds	r0, r1, r0
c0d03cdc:	21c4      	movs	r1, #196	; 0xc4
c0d03cde:	2206      	movs	r2, #6
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_nnbnn_elements);
c0d03ce0:	5442      	strb	r2, [r0, r1]
c0d03ce2:	21c0      	movs	r1, #192	; 0xc0
  return &G_ux.tmp_element;
}

void ux_layout_nnbnn_init(unsigned int stack_slot) {
  ux_stack_init(stack_slot);
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_nnbnn_elements;
c0d03ce4:	4a09      	ldr	r2, [pc, #36]	; (c0d03d0c <ux_layout_nnbnn_init+0x40>)
c0d03ce6:	447a      	add	r2, pc
c0d03ce8:	5042      	str	r2, [r0, r1]
c0d03cea:	21bd      	movs	r1, #189	; 0xbd
c0d03cec:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_nnbnn_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d03cee:	5442      	strb	r2, [r0, r1]
c0d03cf0:	21cc      	movs	r1, #204	; 0xcc
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_nnbnn_prepro;
c0d03cf2:	4a07      	ldr	r2, [pc, #28]	; (c0d03d10 <ux_layout_nnbnn_init+0x44>)
c0d03cf4:	447a      	add	r2, pc
c0d03cf6:	5042      	str	r2, [r0, r1]
c0d03cf8:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d03cfa:	4a06      	ldr	r2, [pc, #24]	; (c0d03d14 <ux_layout_nnbnn_init+0x48>)
c0d03cfc:	447a      	add	r2, pc
c0d03cfe:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d03d00:	4620      	mov	r0, r4
c0d03d02:	f000 fb45 	bl	c0d04390 <ux_stack_display>
}
c0d03d06:	bd10      	pop	{r4, pc}
c0d03d08:	2000186c 	.word	0x2000186c
c0d03d0c:	000013be 	.word	0x000013be
c0d03d10:	ffffff81 	.word	0xffffff81
c0d03d14:	fffffe75 	.word	0xfffffe75

c0d03d18 <ux_layout_paging_compute>:
  //       || (c >= '0' && c <= '9'));
  return c == ' ' || c == '\n' || c == '\t' || c == '-' || c == '_';
}

// return the number of pages to be displayed when current page to show is -1
unsigned int ux_layout_paging_compute(unsigned int stack_slot, unsigned int page_to_display) {
c0d03d18:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03d1a:	b085      	sub	sp, #20
c0d03d1c:	460e      	mov	r6, r1
  const ux_layout_paging_params_t* params = (const ux_layout_paging_params_t*)ux_stack_get_step_params(stack_slot);
c0d03d1e:	f7ff ff45 	bl	c0d03bac <ux_stack_get_step_params>
c0d03d22:	9004      	str	r0, [sp, #16]

  // reset length and offset of lines
  os_memset(&G_ux.layout_paging.offsets, 0, sizeof(G_ux.layout_paging.offsets));
c0d03d24:	4c45      	ldr	r4, [pc, #276]	; (c0d03e3c <ux_layout_paging_compute+0x124>)
c0d03d26:	4620      	mov	r0, r4
c0d03d28:	300c      	adds	r0, #12
c0d03d2a:	2500      	movs	r5, #0
c0d03d2c:	2702      	movs	r7, #2
c0d03d2e:	4629      	mov	r1, r5
c0d03d30:	463a      	mov	r2, r7
c0d03d32:	f7fc fed5 	bl	c0d00ae0 <os_memset>
  os_memset(&G_ux.layout_paging.lengths, 0, sizeof(G_ux.layout_paging.lengths));
c0d03d36:	4620      	mov	r0, r4
c0d03d38:	300e      	adds	r0, #14
c0d03d3a:	9503      	str	r5, [sp, #12]
c0d03d3c:	4629      	mov	r1, r5
c0d03d3e:	463a      	mov	r2, r7
c0d03d40:	f7fc fece 	bl	c0d00ae0 <os_memset>

  // a page has been asked, but no page exists
  if (page_to_display != -1UL && G_ux.layout_paging.count == 0) {
c0d03d44:	1c70      	adds	r0, r6, #1
c0d03d46:	9002      	str	r0, [sp, #8]
c0d03d48:	d002      	beq.n	c0d03d50 <ux_layout_paging_compute+0x38>
c0d03d4a:	68a0      	ldr	r0, [r4, #8]
c0d03d4c:	2800      	cmp	r0, #0
c0d03d4e:	d072      	beq.n	c0d03e36 <ux_layout_paging_compute+0x11e>
  }

  // compute offset/length of text of each line for the current page
  unsigned int page = 0;
  unsigned int line = 0;
  const char* start = STRPIC(params->text);
c0d03d50:	9804      	ldr	r0, [sp, #16]
c0d03d52:	6840      	ldr	r0, [r0, #4]
c0d03d54:	f7fd fd9c 	bl	c0d01890 <pic>
c0d03d58:	4607      	mov	r7, r0
  const char* start2 = start;
  const char* end = start + strlen(start);
c0d03d5a:	f000 fce7 	bl	c0d0472c <strlen>
c0d03d5e:	1839      	adds	r1, r7, r0
c0d03d60:	2201      	movs	r2, #1
  while (start < end) {
c0d03d62:	9203      	str	r2, [sp, #12]
c0d03d64:	2801      	cmp	r0, #1
c0d03d66:	db66      	blt.n	c0d03e36 <ux_layout_paging_compute+0x11e>
c0d03d68:	6860      	ldr	r0, [r4, #4]
c0d03d6a:	9003      	str	r0, [sp, #12]
c0d03d6c:	68a0      	ldr	r0, [r4, #8]
c0d03d6e:	9000      	str	r0, [sp, #0]
c0d03d70:	2000      	movs	r0, #0
c0d03d72:	463c      	mov	r4, r7
c0d03d74:	9701      	str	r7, [sp, #4]
c0d03d76:	9004      	str	r0, [sp, #16]
c0d03d78:	2000      	movs	r0, #0
c0d03d7a:	4607      	mov	r7, r0
c0d03d7c:	4625      	mov	r5, r4
c0d03d7e:	463e      	mov	r6, r7
    unsigned int len = 0;
    unsigned int linew = 0; 
    const char* last_word_delim = start;
    // not reached end of content
    while (start + len < end
c0d03d80:	19e2      	adds	r2, r4, r7
c0d03d82:	428a      	cmp	r2, r1
c0d03d84:	d215      	bcs.n	c0d03db2 <ux_layout_paging_compute+0x9a>
      #else // TARGET_NANOX
      // nano s does not have the bagl lib o nthe SE side
      linew = (len+1)*7 /* width of a capitalized W (the largest char in each font) */;
      #endif //TARGET_NANOX
      //if (start[len] )
      if (linew > PIXEL_PER_LINE) {
c0d03d86:	1dc0      	adds	r0, r0, #7
      // compute new line length
      #ifdef TARGET_NANOX
      linew = bagl_compute_line_width(LINE_FONT, 0, start, len+1, BAGL_ENCODING_LATIN1);
      #else // TARGET_NANOX
      // nano s does not have the bagl lib o nthe SE side
      linew = (len+1)*7 /* width of a capitalized W (the largest char in each font) */;
c0d03d88:	1c77      	adds	r7, r6, #1
      #endif //TARGET_NANOX
      //if (start[len] )
      if (linew > PIXEL_PER_LINE) {
c0d03d8a:	2872      	cmp	r0, #114	; 0x72
c0d03d8c:	d811      	bhi.n	c0d03db2 <ux_layout_paging_compute+0x9a>
        // we got a full line
        break;
      }
      unsigned char c = start[len];
c0d03d8e:	7813      	ldrb	r3, [r2, #0]

static unsigned int is_word_delim(unsigned char c) {
  // return !((c >= 'a' && c <= 'z') 
  //       || (c >= 'A' && c <= 'Z')
  //       || (c >= '0' && c <= '9'));
  return c == ' ' || c == '\n' || c == '\t' || c == '-' || c == '_';
c0d03d90:	461e      	mov	r6, r3
c0d03d92:	3e09      	subs	r6, #9
c0d03d94:	2e02      	cmp	r6, #2
c0d03d96:	d306      	bcc.n	c0d03da6 <ux_layout_paging_compute+0x8e>
c0d03d98:	2b20      	cmp	r3, #32
c0d03d9a:	d004      	beq.n	c0d03da6 <ux_layout_paging_compute+0x8e>
c0d03d9c:	2b2d      	cmp	r3, #45	; 0x2d
c0d03d9e:	d002      	beq.n	c0d03da6 <ux_layout_paging_compute+0x8e>
      if (linew > PIXEL_PER_LINE) {
        // we got a full line
        break;
      }
      unsigned char c = start[len];
      if (is_word_delim(c)) {
c0d03da0:	2b5f      	cmp	r3, #95	; 0x5f
c0d03da2:	d000      	beq.n	c0d03da6 <ux_layout_paging_compute+0x8e>
c0d03da4:	462a      	mov	r2, r5
c0d03da6:	4615      	mov	r5, r2
c0d03da8:	2b0a      	cmp	r3, #10
c0d03daa:	d1e8      	bne.n	c0d03d7e <ux_layout_paging_compute+0x66>
c0d03dac:	19e0      	adds	r0, r4, r7
c0d03dae:	463e      	mov	r6, r7
c0d03db0:	e000      	b.n	c0d03db4 <ux_layout_paging_compute+0x9c>
        break;
      }
    }

    // if not splitting line onto a word delimiter, then cut at the previous word_delim, adjust len accordingly (and a wor delim has been found already)
    if (start + len < end && last_word_delim != start && len) {
c0d03db2:	19a0      	adds	r0, r4, r6
c0d03db4:	9f01      	ldr	r7, [sp, #4]
c0d03db6:	4288      	cmp	r0, r1
c0d03db8:	d223      	bcs.n	c0d03e02 <ux_layout_paging_compute+0xea>
c0d03dba:	2e00      	cmp	r6, #0
c0d03dbc:	d021      	beq.n	c0d03e02 <ux_layout_paging_compute+0xea>
c0d03dbe:	42a5      	cmp	r5, r4
c0d03dc0:	d01f      	beq.n	c0d03e02 <ux_layout_paging_compute+0xea>
      // if line split within a word
      if ((!is_word_delim(start[len-1]) && !is_word_delim(start[len]))) {
c0d03dc2:	19a0      	adds	r0, r4, r6
c0d03dc4:	2200      	movs	r2, #0
c0d03dc6:	43d2      	mvns	r2, r2
c0d03dc8:	5c80      	ldrb	r0, [r0, r2]

static unsigned int is_word_delim(unsigned char c) {
  // return !((c >= 'a' && c <= 'z') 
  //       || (c >= 'A' && c <= 'Z')
  //       || (c >= '0' && c <= '9'));
  return c == ' ' || c == '\n' || c == '\t' || c == '-' || c == '_';
c0d03dca:	282c      	cmp	r0, #44	; 0x2c
c0d03dcc:	dc06      	bgt.n	c0d03ddc <ux_layout_paging_compute+0xc4>
c0d03dce:	4602      	mov	r2, r0
c0d03dd0:	3a09      	subs	r2, #9
c0d03dd2:	2a02      	cmp	r2, #2
c0d03dd4:	d315      	bcc.n	c0d03e02 <ux_layout_paging_compute+0xea>
c0d03dd6:	2820      	cmp	r0, #32
c0d03dd8:	d013      	beq.n	c0d03e02 <ux_layout_paging_compute+0xea>
c0d03dda:	e003      	b.n	c0d03de4 <ux_layout_paging_compute+0xcc>
c0d03ddc:	282d      	cmp	r0, #45	; 0x2d
c0d03dde:	d010      	beq.n	c0d03e02 <ux_layout_paging_compute+0xea>
c0d03de0:	285f      	cmp	r0, #95	; 0x5f
c0d03de2:	d00e      	beq.n	c0d03e02 <ux_layout_paging_compute+0xea>
    }

    // if not splitting line onto a word delimiter, then cut at the previous word_delim, adjust len accordingly (and a wor delim has been found already)
    if (start + len < end && last_word_delim != start && len) {
      // if line split within a word
      if ((!is_word_delim(start[len-1]) && !is_word_delim(start[len]))) {
c0d03de4:	5da0      	ldrb	r0, [r4, r6]

static unsigned int is_word_delim(unsigned char c) {
  // return !((c >= 'a' && c <= 'z') 
  //       || (c >= 'A' && c <= 'Z')
  //       || (c >= '0' && c <= '9'));
  return c == ' ' || c == '\n' || c == '\t' || c == '-' || c == '_';
c0d03de6:	282c      	cmp	r0, #44	; 0x2c
c0d03de8:	dc06      	bgt.n	c0d03df8 <ux_layout_paging_compute+0xe0>
c0d03dea:	4602      	mov	r2, r0
c0d03dec:	3a09      	subs	r2, #9
c0d03dee:	2a02      	cmp	r2, #2
c0d03df0:	d307      	bcc.n	c0d03e02 <ux_layout_paging_compute+0xea>
c0d03df2:	2820      	cmp	r0, #32
c0d03df4:	d005      	beq.n	c0d03e02 <ux_layout_paging_compute+0xea>
c0d03df6:	e003      	b.n	c0d03e00 <ux_layout_paging_compute+0xe8>
c0d03df8:	282d      	cmp	r0, #45	; 0x2d
c0d03dfa:	d002      	beq.n	c0d03e02 <ux_layout_paging_compute+0xea>
c0d03dfc:	285f      	cmp	r0, #95	; 0x5f
c0d03dfe:	d000      	beq.n	c0d03e02 <ux_layout_paging_compute+0xea>

    // if not splitting line onto a word delimiter, then cut at the previous word_delim, adjust len accordingly (and a wor delim has been found already)
    if (start + len < end && last_word_delim != start && len) {
      // if line split within a word
      if ((!is_word_delim(start[len-1]) && !is_word_delim(start[len]))) {
        len = last_word_delim - start;
c0d03e00:	1b2e      	subs	r6, r5, r4
      }
    }

    // fill up the paging structure
    if (page_to_display != -1UL && G_ux.layout_paging.current == page && G_ux.layout_paging.current < G_ux.layout_paging.count) {
c0d03e02:	9802      	ldr	r0, [sp, #8]
c0d03e04:	2800      	cmp	r0, #0
c0d03e06:	9b04      	ldr	r3, [sp, #16]
c0d03e08:	d006      	beq.n	c0d03e18 <ux_layout_paging_compute+0x100>
c0d03e0a:	9803      	ldr	r0, [sp, #12]
c0d03e0c:	4298      	cmp	r0, r3
c0d03e0e:	d103      	bne.n	c0d03e18 <ux_layout_paging_compute+0x100>
c0d03e10:	9803      	ldr	r0, [sp, #12]
c0d03e12:	9a00      	ldr	r2, [sp, #0]
c0d03e14:	4290      	cmp	r0, r2
c0d03e16:	d309      	bcc.n	c0d03e2c <ux_layout_paging_compute+0x114>
        return page;
      }
    }

    // prepare for next line
    start += len;
c0d03e18:	19a4      	adds	r4, r4, r6
    line++;
    if (
#if UX_LAYOUT_PAGING_LINE > 1
      line >= UX_LAYOUT_PAGING_LINE && 
#endif // UX_LAYOUT_PAGING_LINE
      start < end) {
c0d03e1a:	1c58      	adds	r0, r3, #1
c0d03e1c:	428c      	cmp	r4, r1
c0d03e1e:	d300      	bcc.n	c0d03e22 <ux_layout_paging_compute+0x10a>
c0d03e20:	4618      	mov	r0, r3
  unsigned int page = 0;
  unsigned int line = 0;
  const char* start = STRPIC(params->text);
  const char* start2 = start;
  const char* end = start + strlen(start);
  while (start < end) {
c0d03e22:	428c      	cmp	r4, r1
c0d03e24:	d3a7      	bcc.n	c0d03d76 <ux_layout_paging_compute+0x5e>
      start < end) {
      page++;
      line = 0;
    }
  }
  return page+1;
c0d03e26:	1c40      	adds	r0, r0, #1
c0d03e28:	9003      	str	r0, [sp, #12]
c0d03e2a:	e004      	b.n	c0d03e36 <ux_layout_paging_compute+0x11e>
c0d03e2c:	4803      	ldr	r0, [pc, #12]	; (c0d03e3c <ux_layout_paging_compute+0x124>)
c0d03e2e:	4601      	mov	r1, r0
    }

    // fill up the paging structure
    if (page_to_display != -1UL && G_ux.layout_paging.current == page && G_ux.layout_paging.current < G_ux.layout_paging.count) {
      G_ux.layout_paging.offsets[line] = start - start2;
      G_ux.layout_paging.lengths[line] = len;
c0d03e30:	81c6      	strh	r6, [r0, #14]
      }
    }

    // fill up the paging structure
    if (page_to_display != -1UL && G_ux.layout_paging.current == page && G_ux.layout_paging.current < G_ux.layout_paging.count) {
      G_ux.layout_paging.offsets[line] = start - start2;
c0d03e32:	1be0      	subs	r0, r4, r7
c0d03e34:	8188      	strh	r0, [r1, #12]
      page++;
      line = 0;
    }
  }
  return page+1;
}
c0d03e36:	9803      	ldr	r0, [sp, #12]
c0d03e38:	b005      	add	sp, #20
c0d03e3a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03e3c:	2000186c 	.word	0x2000186c

c0d03e40 <ux_layout_paging_redisplay>:

// redisplay current page
void ux_layout_paging_redisplay(unsigned int stack_slot) {
c0d03e40:	b5b0      	push	{r4, r5, r7, lr}
c0d03e42:	4604      	mov	r4, r0

#ifndef TARGET_NANOX
  ux_layout_bb_init_common(stack_slot);
c0d03e44:	f7ff fed4 	bl	c0d03bf0 <ux_layout_bb_init_common>
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_paging_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
#endif // TARGET_NANOX

  // request offsets and lengths of lines for the current page
  ux_layout_paging_compute(stack_slot, G_ux.layout_paging.current);
c0d03e48:	4d09      	ldr	r5, [pc, #36]	; (c0d03e70 <ux_layout_paging_redisplay+0x30>)
c0d03e4a:	6869      	ldr	r1, [r5, #4]
c0d03e4c:	4620      	mov	r0, r4
c0d03e4e:	f7ff ff63 	bl	c0d03d18 <ux_layout_paging_compute>
c0d03e52:	2024      	movs	r0, #36	; 0x24

  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_paging_prepro;
c0d03e54:	4360      	muls	r0, r4
c0d03e56:	1828      	adds	r0, r5, r0
c0d03e58:	21cc      	movs	r1, #204	; 0xcc
c0d03e5a:	4a06      	ldr	r2, [pc, #24]	; (c0d03e74 <ux_layout_paging_redisplay+0x34>)
c0d03e5c:	447a      	add	r2, pc
c0d03e5e:	5042      	str	r2, [r0, r1]
c0d03e60:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_layout_paging_button_callback;
c0d03e62:	4a05      	ldr	r2, [pc, #20]	; (c0d03e78 <ux_layout_paging_redisplay+0x38>)
c0d03e64:	447a      	add	r2, pc
c0d03e66:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d03e68:	4620      	mov	r0, r4
c0d03e6a:	f000 fa91 	bl	c0d04390 <ux_stack_display>
}
c0d03e6e:	bdb0      	pop	{r4, r5, r7, pc}
c0d03e70:	2000186c 	.word	0x2000186c
c0d03e74:	0000001d 	.word	0x0000001d
c0d03e78:	00000115 	.word	0x00000115

c0d03e7c <ux_layout_paging_prepro>:
  {{BAGL_LABELINE                       , 0x12,   (128-PIXEL_PER_LINE)/2,  43, PIXEL_PER_LINE,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, LINE_FONT|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
  {{BAGL_LABELINE                       , 0x13,   (128-PIXEL_PER_LINE)/2,  57, PIXEL_PER_LINE,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, LINE_FONT|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
};
#endif // TARGET_NANOX

static const bagl_element_t* ux_layout_paging_prepro(const bagl_element_t* element) {
c0d03e7c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03e7e:	b083      	sub	sp, #12
c0d03e80:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_paging_params_t* params = (const ux_layout_paging_params_t*)ux_stack_get_current_step_params();
c0d03e82:	f7ff feab 	bl	c0d03bdc <ux_stack_get_current_step_params>
c0d03e86:	4604      	mov	r4, r0
  
  // copy element before any mod
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d03e88:	4e37      	ldr	r6, [pc, #220]	; (c0d03f68 <ux_layout_paging_prepro+0xec>)
c0d03e8a:	4630      	mov	r0, r6
c0d03e8c:	309c      	adds	r0, #156	; 0x9c
c0d03e8e:	2220      	movs	r2, #32
c0d03e90:	4629      	mov	r1, r5
c0d03e92:	f7fc fe0f 	bl	c0d00ab4 <os_memmove>

  switch (element->component.userid) {
c0d03e96:	7868      	ldrb	r0, [r5, #1]
c0d03e98:	2810      	cmp	r0, #16
c0d03e9a:	dc16      	bgt.n	c0d03eca <ux_layout_paging_prepro+0x4e>
c0d03e9c:	2801      	cmp	r0, #1
c0d03e9e:	d033      	beq.n	c0d03f08 <ux_layout_paging_prepro+0x8c>
c0d03ea0:	2802      	cmp	r0, #2
c0d03ea2:	d03b      	beq.n	c0d03f1c <ux_layout_paging_prepro+0xa0>
c0d03ea4:	2810      	cmp	r0, #16
c0d03ea6:	d15a      	bne.n	c0d03f5e <ux_layout_paging_prepro+0xe2>
  		}
  		break;

    case 0x10:
      // display 
    	if (params->title) {
c0d03ea8:	6820      	ldr	r0, [r4, #0]
c0d03eaa:	2800      	cmp	r0, #0
c0d03eac:	d041      	beq.n	c0d03f32 <ux_layout_paging_prepro+0xb6>
        SPRINTF(G_ux.string_buffer, (G_ux.layout_paging.count>1)?"%s (%d/%d)":"%s", STRPIC(params->title), G_ux.layout_paging.current+1, G_ux.layout_paging.count);
c0d03eae:	68b4      	ldr	r4, [r6, #8]
c0d03eb0:	f7fd fcee 	bl	c0d01890 <pic>
c0d03eb4:	4603      	mov	r3, r0
c0d03eb6:	6870      	ldr	r0, [r6, #4]
c0d03eb8:	68b1      	ldr	r1, [r6, #8]
c0d03eba:	466a      	mov	r2, sp
c0d03ebc:	1c40      	adds	r0, r0, #1
c0d03ebe:	c203      	stmia	r2!, {r0, r1}
c0d03ec0:	2c01      	cmp	r4, #1
c0d03ec2:	d841      	bhi.n	c0d03f48 <ux_layout_paging_prepro+0xcc>
c0d03ec4:	4a2a      	ldr	r2, [pc, #168]	; (c0d03f70 <ux_layout_paging_prepro+0xf4>)
c0d03ec6:	447a      	add	r2, pc
c0d03ec8:	e040      	b.n	c0d03f4c <ux_layout_paging_prepro+0xd0>
  const ux_layout_paging_params_t* params = (const ux_layout_paging_params_t*)ux_stack_get_current_step_params();
  
  // copy element before any mod
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  switch (element->component.userid) {
c0d03eca:	4601      	mov	r1, r0
c0d03ecc:	3911      	subs	r1, #17
c0d03ece:	2903      	cmp	r1, #3
c0d03ed0:	d245      	bcs.n	c0d03f5e <ux_layout_paging_prepro+0xe2>
c0d03ed2:	210f      	movs	r1, #15
      break;

    case 0x11:
    case 0x12:
    case 0x13: {
      unsigned int lineidx = (element->component.userid&0xF)-1;
c0d03ed4:	4008      	ands	r0, r1
c0d03ed6:	1e40      	subs	r0, r0, #1
      if (G_ux.layout_paging.lengths[lineidx]) {
c0d03ed8:	0040      	lsls	r0, r0, #1
c0d03eda:	1837      	adds	r7, r6, r0
c0d03edc:	89fd      	ldrh	r5, [r7, #14]
c0d03ede:	2d00      	cmp	r5, #0
c0d03ee0:	d03d      	beq.n	c0d03f5e <ux_layout_paging_prepro+0xe2>
        SPRINTF(G_ux.string_buffer, "%.*s", G_ux.layout_paging.lengths[lineidx], STRPIC(params->text) + G_ux.layout_paging.offsets[lineidx]);
c0d03ee2:	6860      	ldr	r0, [r4, #4]
c0d03ee4:	f7fd fcd4 	bl	c0d01890 <pic>
c0d03ee8:	89b9      	ldrh	r1, [r7, #12]
c0d03eea:	1840      	adds	r0, r0, r1
c0d03eec:	4669      	mov	r1, sp
c0d03eee:	6008      	str	r0, [r1, #0]
c0d03ef0:	4634      	mov	r4, r6
c0d03ef2:	341c      	adds	r4, #28
c0d03ef4:	2180      	movs	r1, #128	; 0x80
c0d03ef6:	4a20      	ldr	r2, [pc, #128]	; (c0d03f78 <ux_layout_paging_prepro+0xfc>)
c0d03ef8:	447a      	add	r2, pc
c0d03efa:	4620      	mov	r0, r4
c0d03efc:	462b      	mov	r3, r5
c0d03efe:	f7fd fb07 	bl	c0d01510 <snprintf>
c0d03f02:	20b8      	movs	r0, #184	; 0xb8
        G_ux.tmp_element.text = G_ux.string_buffer;
c0d03f04:	5034      	str	r4, [r6, r0]
c0d03f06:	e02a      	b.n	c0d03f5e <ux_layout_paging_prepro+0xe2>
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  switch (element->component.userid) {
  	case 0x01:
      // no step before AND no pages before
  		if (ux_flow_is_first() && G_ux.layout_paging.current == 0) {
c0d03f08:	f7ff fc90 	bl	c0d0382c <ux_flow_is_first>
c0d03f0c:	4601      	mov	r1, r0
c0d03f0e:	2000      	movs	r0, #0
c0d03f10:	2900      	cmp	r1, #0
c0d03f12:	d024      	beq.n	c0d03f5e <ux_layout_paging_prepro+0xe2>
c0d03f14:	6871      	ldr	r1, [r6, #4]
c0d03f16:	2900      	cmp	r1, #0
c0d03f18:	d023      	beq.n	c0d03f62 <ux_layout_paging_prepro+0xe6>
c0d03f1a:	e020      	b.n	c0d03f5e <ux_layout_paging_prepro+0xe2>
  			return NULL;
  		}
  		break;

  	case 0x02:
  		if (ux_flow_is_last() && G_ux.layout_paging.current == G_ux.layout_paging.count -1 ) {
c0d03f1c:	f7ff fcae 	bl	c0d0387c <ux_flow_is_last>
c0d03f20:	2800      	cmp	r0, #0
c0d03f22:	d01c      	beq.n	c0d03f5e <ux_layout_paging_prepro+0xe2>
c0d03f24:	6871      	ldr	r1, [r6, #4]
c0d03f26:	68b0      	ldr	r0, [r6, #8]
c0d03f28:	1e42      	subs	r2, r0, #1
c0d03f2a:	2000      	movs	r0, #0
c0d03f2c:	4291      	cmp	r1, r2
c0d03f2e:	d116      	bne.n	c0d03f5e <ux_layout_paging_prepro+0xe2>
c0d03f30:	e017      	b.n	c0d03f62 <ux_layout_paging_prepro+0xe6>
      // display 
    	if (params->title) {
        SPRINTF(G_ux.string_buffer, (G_ux.layout_paging.count>1)?"%s (%d/%d)":"%s", STRPIC(params->title), G_ux.layout_paging.current+1, G_ux.layout_paging.count);
    	}
      else {
        SPRINTF(G_ux.string_buffer, "%d/%d", G_ux.layout_paging.current+1, G_ux.layout_paging.count);
c0d03f32:	6871      	ldr	r1, [r6, #4]
c0d03f34:	68b0      	ldr	r0, [r6, #8]
c0d03f36:	466a      	mov	r2, sp
c0d03f38:	6010      	str	r0, [r2, #0]
c0d03f3a:	4630      	mov	r0, r6
c0d03f3c:	301c      	adds	r0, #28
c0d03f3e:	1c4b      	adds	r3, r1, #1
c0d03f40:	2180      	movs	r1, #128	; 0x80
c0d03f42:	4a0c      	ldr	r2, [pc, #48]	; (c0d03f74 <ux_layout_paging_prepro+0xf8>)
c0d03f44:	447a      	add	r2, pc
c0d03f46:	e004      	b.n	c0d03f52 <ux_layout_paging_prepro+0xd6>
c0d03f48:	4a08      	ldr	r2, [pc, #32]	; (c0d03f6c <ux_layout_paging_prepro+0xf0>)
c0d03f4a:	447a      	add	r2, pc
  		break;

    case 0x10:
      // display 
    	if (params->title) {
        SPRINTF(G_ux.string_buffer, (G_ux.layout_paging.count>1)?"%s (%d/%d)":"%s", STRPIC(params->title), G_ux.layout_paging.current+1, G_ux.layout_paging.count);
c0d03f4c:	4630      	mov	r0, r6
c0d03f4e:	301c      	adds	r0, #28
c0d03f50:	2180      	movs	r1, #128	; 0x80
c0d03f52:	f7fd fadd 	bl	c0d01510 <snprintf>
    	}
      else {
        SPRINTF(G_ux.string_buffer, "%d/%d", G_ux.layout_paging.current+1, G_ux.layout_paging.count);
      }
      G_ux.tmp_element.text = G_ux.string_buffer;
c0d03f56:	4630      	mov	r0, r6
c0d03f58:	301c      	adds	r0, #28
c0d03f5a:	21b8      	movs	r1, #184	; 0xb8
c0d03f5c:	5070      	str	r0, [r6, r1]
c0d03f5e:	369c      	adds	r6, #156	; 0x9c
c0d03f60:	4630      	mov	r0, r6
      }
      break;
    }
  }
  return &G_ux.tmp_element;
}
c0d03f62:	b003      	add	sp, #12
c0d03f64:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03f66:	46c0      	nop			; (mov r8, r8)
c0d03f68:	2000186c 	.word	0x2000186c
c0d03f6c:	0000121a 	.word	0x0000121a
c0d03f70:	000012a9 	.word	0x000012a9
c0d03f74:	0000122e 	.word	0x0000122e
c0d03f78:	00001280 	.word	0x00001280

c0d03f7c <ux_layout_paging_button_callback>:
    G_ux.layout_paging.current--;
    ux_layout_paging_redisplay(G_ux.stack_count-1);
  }
}

static unsigned int ux_layout_paging_button_callback(unsigned int button_mask, unsigned int button_mask_counter) {
c0d03f7c:	b580      	push	{r7, lr}
c0d03f7e:	4917      	ldr	r1, [pc, #92]	; (c0d03fdc <ux_layout_paging_button_callback+0x60>)
  UNUSED(button_mask_counter);
  switch(button_mask) {
c0d03f80:	4288      	cmp	r0, r1
c0d03f82:	d00b      	beq.n	c0d03f9c <ux_layout_paging_button_callback+0x20>
c0d03f84:	4916      	ldr	r1, [pc, #88]	; (c0d03fe0 <ux_layout_paging_button_callback+0x64>)
c0d03f86:	4288      	cmp	r0, r1
c0d03f88:	d013      	beq.n	c0d03fb2 <ux_layout_paging_button_callback+0x36>
c0d03f8a:	4916      	ldr	r1, [pc, #88]	; (c0d03fe4 <ux_layout_paging_button_callback+0x68>)
c0d03f8c:	4288      	cmp	r0, r1
c0d03f8e:	d122      	bne.n	c0d03fd6 <ux_layout_paging_button_callback+0x5a>
    ux_layout_paging_redisplay(G_ux.stack_count-1);
  }
}

static void ux_layout_paging_prev(void) {
  if (G_ux.layout_paging.current == 0) {
c0d03f90:	4815      	ldr	r0, [pc, #84]	; (c0d03fe8 <ux_layout_paging_button_callback+0x6c>)
c0d03f92:	6841      	ldr	r1, [r0, #4]
c0d03f94:	2900      	cmp	r1, #0
c0d03f96:	d01c      	beq.n	c0d03fd2 <ux_layout_paging_button_callback+0x56>
    ux_flow_prev();
  }
  else {
    // display previous page, count the number of char to fit in the previous page
    G_ux.layout_paging.current--;
c0d03f98:	1e49      	subs	r1, r1, #1
c0d03f9a:	e014      	b.n	c0d03fc6 <ux_layout_paging_button_callback+0x4a>
      break;
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      ux_layout_paging_next();
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      if (G_ux.layout_paging.count == 0 
c0d03f9c:	4912      	ldr	r1, [pc, #72]	; (c0d03fe8 <ux_layout_paging_button_callback+0x6c>)
c0d03f9e:	6888      	ldr	r0, [r1, #8]
        || G_ux.layout_paging.count-1 == G_ux.layout_paging.current) {
c0d03fa0:	2800      	cmp	r0, #0
c0d03fa2:	d003      	beq.n	c0d03fac <ux_layout_paging_button_callback+0x30>
c0d03fa4:	6849      	ldr	r1, [r1, #4]
c0d03fa6:	1e40      	subs	r0, r0, #1
      break;
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      ux_layout_paging_next();
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      if (G_ux.layout_paging.count == 0 
c0d03fa8:	4288      	cmp	r0, r1
c0d03faa:	d114      	bne.n	c0d03fd6 <ux_layout_paging_button_callback+0x5a>
        || G_ux.layout_paging.count-1 == G_ux.layout_paging.current) {
        ux_flow_validate();
c0d03fac:	f7ff fd40 	bl	c0d03a30 <ux_flow_validate>
c0d03fb0:	e011      	b.n	c0d03fd6 <ux_layout_paging_button_callback+0x5a>
  G_ux.stack[stack_slot].button_push_callback = ux_layout_paging_button_callback;
  ux_stack_display(stack_slot);
}

static void ux_layout_paging_next(void) {
  if (G_ux.layout_paging.current == G_ux.layout_paging.count-1) {
c0d03fb2:	480d      	ldr	r0, [pc, #52]	; (c0d03fe8 <ux_layout_paging_button_callback+0x6c>)
c0d03fb4:	6841      	ldr	r1, [r0, #4]
c0d03fb6:	6882      	ldr	r2, [r0, #8]
c0d03fb8:	1e52      	subs	r2, r2, #1
c0d03fba:	4291      	cmp	r1, r2
c0d03fbc:	d102      	bne.n	c0d03fc4 <ux_layout_paging_button_callback+0x48>
    ux_flow_next();
c0d03fbe:	f7ff fcc3 	bl	c0d03948 <ux_flow_next>
c0d03fc2:	e008      	b.n	c0d03fd6 <ux_layout_paging_button_callback+0x5a>
  }
  else {
    // display next page, count the number of char to fit in the next page
    G_ux.layout_paging.current++;
c0d03fc4:	1c49      	adds	r1, r1, #1
c0d03fc6:	6041      	str	r1, [r0, #4]
c0d03fc8:	7800      	ldrb	r0, [r0, #0]
c0d03fca:	1e40      	subs	r0, r0, #1
c0d03fcc:	f7ff ff38 	bl	c0d03e40 <ux_layout_paging_redisplay>
c0d03fd0:	e001      	b.n	c0d03fd6 <ux_layout_paging_button_callback+0x5a>
  }
}

static void ux_layout_paging_prev(void) {
  if (G_ux.layout_paging.current == 0) {
    ux_flow_prev();
c0d03fd2:	f7ff fcbf 	bl	c0d03954 <ux_flow_prev>
c0d03fd6:	2000      	movs	r0, #0
        || G_ux.layout_paging.count-1 == G_ux.layout_paging.current) {
        ux_flow_validate();
      }
      break;
  }
  return 0;
c0d03fd8:	bd80      	pop	{r7, pc}
c0d03fda:	46c0      	nop			; (mov r8, r8)
c0d03fdc:	80000003 	.word	0x80000003
c0d03fe0:	80000002 	.word	0x80000002
c0d03fe4:	80000001 	.word	0x80000001
c0d03fe8:	2000186c 	.word	0x2000186c

c0d03fec <ux_layout_paging_init>:
}

unsigned short bagl_compute_line_width(unsigned short font_id, unsigned short width, const void * text, unsigned char text_length, unsigned char text_encoding);

void ux_layout_paging_init(unsigned int stack_slot) {
c0d03fec:	b570      	push	{r4, r5, r6, lr}
c0d03fee:	4604      	mov	r4, r0

  // depending flow browsing direction, select the correct page to display
  switch(ux_flow_direction()) {
c0d03ff0:	f7ff fc64 	bl	c0d038bc <ux_flow_direction>
c0d03ff4:	2801      	cmp	r0, #1
c0d03ff6:	d00b      	beq.n	c0d04010 <ux_layout_paging_init+0x24>
c0d03ff8:	1c40      	adds	r0, r0, #1
c0d03ffa:	d10f      	bne.n	c0d0401c <ux_layout_paging_init+0x30>
  ux_layout_paging_redisplay(stack_slot);
}

// function callable externally which reset the paging (to be called before init when willing to redisplay the first page)
void ux_layout_paging_reset(void) {
  os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d03ffc:	4e1c      	ldr	r6, [pc, #112]	; (c0d04070 <ux_layout_paging_init+0x84>)
c0d03ffe:	1d30      	adds	r0, r6, #4
c0d04000:	2500      	movs	r5, #0
c0d04002:	220c      	movs	r2, #12
c0d04004:	4629      	mov	r1, r5
c0d04006:	f7fc fd6b 	bl	c0d00ae0 <os_memset>
c0d0400a:	43e8      	mvns	r0, r5
  // depending flow browsing direction, select the correct page to display
  switch(ux_flow_direction()) {
    case FLOW_DIRECTION_BACKWARD:
      // ask the paging to start at the last page
      ux_layout_paging_reset();
      G_ux.layout_paging.current = -1UL;
c0d0400c:	6070      	str	r0, [r6, #4]
c0d0400e:	e005      	b.n	c0d0401c <ux_layout_paging_init+0x30>
  ux_layout_paging_redisplay(stack_slot);
}

// function callable externally which reset the paging (to be called before init when willing to redisplay the first page)
void ux_layout_paging_reset(void) {
  os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d04010:	4817      	ldr	r0, [pc, #92]	; (c0d04070 <ux_layout_paging_init+0x84>)
c0d04012:	1d00      	adds	r0, r0, #4
c0d04014:	2100      	movs	r1, #0
c0d04016:	220c      	movs	r2, #12
c0d04018:	f7fc fd62 	bl	c0d00ae0 <os_memset>
    case FLOW_DIRECTION_START:
      break;
  }

  // store params
  ux_stack_init(stack_slot);
c0d0401c:	4620      	mov	r0, r4
c0d0401e:	f000 f9dd 	bl	c0d043dc <ux_stack_init>
  const ux_layout_paging_params_t* params = (const ux_layout_paging_params_t*)ux_stack_get_step_params(stack_slot);
c0d04022:	4620      	mov	r0, r4
c0d04024:	f7ff fdc2 	bl	c0d03bac <ux_stack_get_step_params>

  // compute number of chars to display from the params complete string 
  if (params->text == NULL /*|| strlen(STRPIC(params->text)) == 0*/) {
c0d04028:	6840      	ldr	r0, [r0, #4]
c0d0402a:	2800      	cmp	r0, #0
c0d0402c:	d019      	beq.n	c0d04062 <ux_layout_paging_init+0x76>
c0d0402e:	2000      	movs	r0, #0
c0d04030:	43c1      	mvns	r1, r0
    ux_layout_paging_reset();
    return;
  }

  // count total number of pages
  G_ux.layout_paging.count = ux_layout_paging_compute(stack_slot, -1UL); // at least one page
c0d04032:	4620      	mov	r0, r4
c0d04034:	f7ff fe70 	bl	c0d03d18 <ux_layout_paging_compute>
c0d04038:	4d0d      	ldr	r5, [pc, #52]	; (c0d04070 <ux_layout_paging_init+0x84>)
c0d0403a:	60a8      	str	r0, [r5, #8]

  if (G_ux.layout_paging.count == 0) {
c0d0403c:	2800      	cmp	r0, #0
c0d0403e:	d107      	bne.n	c0d04050 <ux_layout_paging_init+0x64>
  ux_layout_paging_redisplay(stack_slot);
}

// function callable externally which reset the paging (to be called before init when willing to redisplay the first page)
void ux_layout_paging_reset(void) {
  os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d04040:	1d28      	adds	r0, r5, #4
c0d04042:	2100      	movs	r1, #0
c0d04044:	220c      	movs	r2, #12
c0d04046:	f7fc fd4b 	bl	c0d00ae0 <os_memset>
  // if (start != end) {
  //   ux_layout_paging_reset();
  // }

  // perform displaying the last page as requested (-1UL in prevstep hook does this)
  if (G_ux.layout_paging.count && G_ux.layout_paging.current > G_ux.layout_paging.count-1UL) {
c0d0404a:	68a8      	ldr	r0, [r5, #8]
c0d0404c:	2800      	cmp	r0, #0
c0d0404e:	d004      	beq.n	c0d0405a <ux_layout_paging_init+0x6e>
c0d04050:	1e40      	subs	r0, r0, #1
c0d04052:	6869      	ldr	r1, [r5, #4]
c0d04054:	4281      	cmp	r1, r0
c0d04056:	d900      	bls.n	c0d0405a <ux_layout_paging_init+0x6e>
    G_ux.layout_paging.current = G_ux.layout_paging.count-1;
c0d04058:	6068      	str	r0, [r5, #4]
  }

  ux_layout_paging_redisplay(stack_slot);
c0d0405a:	4620      	mov	r0, r4
c0d0405c:	f7ff fef0 	bl	c0d03e40 <ux_layout_paging_redisplay>
}
c0d04060:	bd70      	pop	{r4, r5, r6, pc}

// function callable externally which reset the paging (to be called before init when willing to redisplay the first page)
void ux_layout_paging_reset(void) {
  os_memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d04062:	4803      	ldr	r0, [pc, #12]	; (c0d04070 <ux_layout_paging_init+0x84>)
c0d04064:	1d00      	adds	r0, r0, #4
c0d04066:	2100      	movs	r1, #0
c0d04068:	220c      	movs	r2, #12
c0d0406a:	f7fc fd39 	bl	c0d00ae0 <os_memset>
  if (G_ux.layout_paging.count && G_ux.layout_paging.current > G_ux.layout_paging.count-1UL) {
    G_ux.layout_paging.current = G_ux.layout_paging.count-1;
  }

  ux_layout_paging_redisplay(stack_slot);
}
c0d0406e:	bd70      	pop	{r4, r5, r6, pc}
c0d04070:	2000186c 	.word	0x2000186c

c0d04074 <ux_layout_pb_prepro>:
  {{BAGL_ICON                           , 0x10,  56,  2,  16,  16, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_REGULAR_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
  {{BAGL_LABELINE                       , 0x11,   0, 28, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
#endif // TARGET_NANOX
};

const bagl_element_t* ux_layout_pb_prepro(const bagl_element_t* element) {
c0d04074:	b570      	push	{r4, r5, r6, lr}
c0d04076:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_pb_params_t* params = (const ux_layout_pb_params_t*)ux_stack_get_current_step_params();
c0d04078:	f7ff fdb0 	bl	c0d03bdc <ux_stack_get_current_step_params>
c0d0407c:	4604      	mov	r4, r0

	// copy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d0407e:	4e12      	ldr	r6, [pc, #72]	; (c0d040c8 <ux_layout_pb_prepro+0x54>)
c0d04080:	4630      	mov	r0, r6
c0d04082:	309c      	adds	r0, #156	; 0x9c
c0d04084:	2220      	movs	r2, #32
c0d04086:	4629      	mov	r1, r5
c0d04088:	f7fc fd14 	bl	c0d00ab4 <os_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d0408c:	7868      	ldrb	r0, [r5, #1]
c0d0408e:	280f      	cmp	r0, #15
c0d04090:	dc06      	bgt.n	c0d040a0 <ux_layout_pb_prepro+0x2c>
c0d04092:	2801      	cmp	r0, #1
c0d04094:	d00a      	beq.n	c0d040ac <ux_layout_pb_prepro+0x38>
c0d04096:	2802      	cmp	r0, #2
c0d04098:	d112      	bne.n	c0d040c0 <ux_layout_pb_prepro+0x4c>
  			return NULL;
  		}
  		break;

  	case 0x02:
  		if (ux_flow_is_last()) {
c0d0409a:	f7ff fbef 	bl	c0d0387c <ux_flow_is_last>
c0d0409e:	e007      	b.n	c0d040b0 <ux_layout_pb_prepro+0x3c>

	// copy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d040a0:	2810      	cmp	r0, #16
c0d040a2:	d00a      	beq.n	c0d040ba <ux_layout_pb_prepro+0x46>
c0d040a4:	2811      	cmp	r0, #17
c0d040a6:	d10b      	bne.n	c0d040c0 <ux_layout_pb_prepro+0x4c>
    case 0x10:
  		G_ux.tmp_element.text = (const char*)params->icon;
      break;

    case 0x11:
  		G_ux.tmp_element.text = params->line1;
c0d040a8:	6860      	ldr	r0, [r4, #4]
c0d040aa:	e007      	b.n	c0d040bc <ux_layout_pb_prepro+0x48>
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
  	case 0x01:
  		if (ux_flow_is_first()) {
c0d040ac:	f7ff fbbe 	bl	c0d0382c <ux_flow_is_first>
c0d040b0:	4601      	mov	r1, r0
c0d040b2:	2000      	movs	r0, #0
c0d040b4:	2900      	cmp	r1, #0
c0d040b6:	d003      	beq.n	c0d040c0 <ux_layout_pb_prepro+0x4c>
    case 0x11:
  		G_ux.tmp_element.text = params->line1;
      break;
  }
  return &G_ux.tmp_element;
}
c0d040b8:	bd70      	pop	{r4, r5, r6, pc}
  			return NULL;
  		}
  		break;

    case 0x10:
  		G_ux.tmp_element.text = (const char*)params->icon;
c0d040ba:	6820      	ldr	r0, [r4, #0]
c0d040bc:	21b8      	movs	r1, #184	; 0xb8
c0d040be:	5070      	str	r0, [r6, r1]
c0d040c0:	369c      	adds	r6, #156	; 0x9c
c0d040c2:	4630      	mov	r0, r6
    case 0x11:
  		G_ux.tmp_element.text = params->line1;
      break;
  }
  return &G_ux.tmp_element;
}
c0d040c4:	bd70      	pop	{r4, r5, r6, pc}
c0d040c6:	46c0      	nop			; (mov r8, r8)
c0d040c8:	2000186c 	.word	0x2000186c

c0d040cc <ux_layout_pb_init>:

void ux_layout_pb_init(unsigned int stack_slot) {
c0d040cc:	b510      	push	{r4, lr}
c0d040ce:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d040d0:	f000 f984 	bl	c0d043dc <ux_stack_init>
c0d040d4:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pb_elements;
c0d040d6:	4360      	muls	r0, r4
c0d040d8:	490b      	ldr	r1, [pc, #44]	; (c0d04108 <ux_layout_pb_init+0x3c>)
c0d040da:	1808      	adds	r0, r1, r0
c0d040dc:	21c4      	movs	r1, #196	; 0xc4
c0d040de:	2205      	movs	r2, #5
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pb_elements);
c0d040e0:	5442      	strb	r2, [r0, r1]
c0d040e2:	21c0      	movs	r1, #192	; 0xc0
  return &G_ux.tmp_element;
}

void ux_layout_pb_init(unsigned int stack_slot) {
  ux_stack_init(stack_slot);
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pb_elements;
c0d040e4:	4a09      	ldr	r2, [pc, #36]	; (c0d0410c <ux_layout_pb_init+0x40>)
c0d040e6:	447a      	add	r2, pc
c0d040e8:	5042      	str	r2, [r0, r1]
c0d040ea:	21bd      	movs	r1, #189	; 0xbd
c0d040ec:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pb_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d040ee:	5442      	strb	r2, [r0, r1]
c0d040f0:	21cc      	movs	r1, #204	; 0xcc
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_pb_prepro;
c0d040f2:	4a07      	ldr	r2, [pc, #28]	; (c0d04110 <ux_layout_pb_init+0x44>)
c0d040f4:	447a      	add	r2, pc
c0d040f6:	5042      	str	r2, [r0, r1]
c0d040f8:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d040fa:	4a06      	ldr	r2, [pc, #24]	; (c0d04114 <ux_layout_pb_init+0x48>)
c0d040fc:	447a      	add	r2, pc
c0d040fe:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d04100:	4620      	mov	r0, r4
c0d04102:	f000 f945 	bl	c0d04390 <ux_stack_display>
}
c0d04106:	bd10      	pop	{r4, pc}
c0d04108:	2000186c 	.word	0x2000186c
c0d0410c:	0000109a 	.word	0x0000109a
c0d04110:	ffffff7d 	.word	0xffffff7d
c0d04114:	fffffa75 	.word	0xfffffa75

c0d04118 <ux_layout_pbb_prepro>:
  {{BAGL_LABELINE                       , 0x10,  41,  12, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px, 0  }, NULL},
  {{BAGL_LABELINE                       , 0x11,  41,  26, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px, 0  }, NULL},
#endif // TARGET_NANOX
};

const bagl_element_t* ux_layout_pbb_prepro(const bagl_element_t* element) {
c0d04118:	b570      	push	{r4, r5, r6, lr}
c0d0411a:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_icon_strings_params_t* params = (const ux_layout_icon_strings_params_t*)ux_stack_get_current_step_params();
c0d0411c:	f7ff fd5e 	bl	c0d03bdc <ux_stack_get_current_step_params>
c0d04120:	4604      	mov	r4, r0

	// ocpy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d04122:	4e16      	ldr	r6, [pc, #88]	; (c0d0417c <ux_layout_pbb_prepro+0x64>)
c0d04124:	4630      	mov	r0, r6
c0d04126:	309c      	adds	r0, #156	; 0x9c
c0d04128:	2220      	movs	r2, #32
c0d0412a:	4629      	mov	r1, r5
c0d0412c:	f7fc fcc2 	bl	c0d00ab4 <os_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d04130:	7868      	ldrb	r0, [r5, #1]
c0d04132:	280f      	cmp	r0, #15
c0d04134:	dc07      	bgt.n	c0d04146 <ux_layout_pbb_prepro+0x2e>
c0d04136:	2801      	cmp	r0, #1
c0d04138:	d012      	beq.n	c0d04160 <ux_layout_pbb_prepro+0x48>
c0d0413a:	2802      	cmp	r0, #2
c0d0413c:	d013      	beq.n	c0d04166 <ux_layout_pbb_prepro+0x4e>
c0d0413e:	280f      	cmp	r0, #15
c0d04140:	d118      	bne.n	c0d04174 <ux_layout_pbb_prepro+0x5c>
  			return NULL;
  		}
  		break;

    case 0x0F:
  		G_ux.tmp_element.text = (const char*)params->icon;
c0d04142:	6820      	ldr	r0, [r4, #0]
c0d04144:	e009      	b.n	c0d0415a <ux_layout_pbb_prepro+0x42>

	// ocpy element before any mod
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d04146:	3810      	subs	r0, #16
c0d04148:	2802      	cmp	r0, #2
c0d0414a:	d213      	bcs.n	c0d04174 <ux_layout_pbb_prepro+0x5c>
c0d0414c:	209d      	movs	r0, #157	; 0x9d
  		G_ux.tmp_element.text = (const char*)params->icon;
      break;

    case 0x10:
    case 0x11:
      G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
c0d0414e:	5c30      	ldrb	r0, [r6, r0]
c0d04150:	210f      	movs	r1, #15
c0d04152:	4001      	ands	r1, r0
c0d04154:	0088      	lsls	r0, r1, #2
c0d04156:	1820      	adds	r0, r4, r0
c0d04158:	6840      	ldr	r0, [r0, #4]
c0d0415a:	21b8      	movs	r1, #184	; 0xb8
c0d0415c:	5070      	str	r0, [r6, r1]
c0d0415e:	e009      	b.n	c0d04174 <ux_layout_pbb_prepro+0x5c>
	os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
  	case 0x01:
  		if (ux_flow_is_first()) {
c0d04160:	f7ff fb64 	bl	c0d0382c <ux_flow_is_first>
c0d04164:	e001      	b.n	c0d0416a <ux_layout_pbb_prepro+0x52>
  			return NULL;
  		}
  		break;

  	case 0x02:
  		if (ux_flow_is_last()) {
c0d04166:	f7ff fb89 	bl	c0d0387c <ux_flow_is_last>
c0d0416a:	4601      	mov	r1, r0
c0d0416c:	2000      	movs	r0, #0
c0d0416e:	2900      	cmp	r1, #0
c0d04170:	d000      	beq.n	c0d04174 <ux_layout_pbb_prepro+0x5c>
      G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
      break;

  }
  return &G_ux.tmp_element;
}
c0d04172:	bd70      	pop	{r4, r5, r6, pc}
c0d04174:	369c      	adds	r6, #156	; 0x9c
c0d04176:	4630      	mov	r0, r6
c0d04178:	bd70      	pop	{r4, r5, r6, pc}
c0d0417a:	46c0      	nop			; (mov r8, r8)
c0d0417c:	2000186c 	.word	0x2000186c

c0d04180 <ux_layout_pbb_init_common>:


void ux_layout_pbb_init_common(unsigned int stack_slot) {
c0d04180:	b510      	push	{r4, lr}
c0d04182:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d04184:	f000 f92a 	bl	c0d043dc <ux_stack_init>
c0d04188:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pbb_elements;
c0d0418a:	4360      	muls	r0, r4
c0d0418c:	4908      	ldr	r1, [pc, #32]	; (c0d041b0 <ux_layout_pbb_init_common+0x30>)
c0d0418e:	1808      	adds	r0, r1, r0
c0d04190:	21c4      	movs	r1, #196	; 0xc4
c0d04192:	2206      	movs	r2, #6
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pbb_elements);
c0d04194:	5442      	strb	r2, [r0, r1]
c0d04196:	21c0      	movs	r1, #192	; 0xc0
}


void ux_layout_pbb_init_common(unsigned int stack_slot) {
  ux_stack_init(stack_slot);
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pbb_elements;
c0d04198:	4a06      	ldr	r2, [pc, #24]	; (c0d041b4 <ux_layout_pbb_init_common+0x34>)
c0d0419a:	447a      	add	r2, pc
c0d0419c:	5042      	str	r2, [r0, r1]
c0d0419e:	21bd      	movs	r1, #189	; 0xbd
c0d041a0:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pbb_elements);
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d041a2:	5442      	strb	r2, [r0, r1]
c0d041a4:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d041a6:	4a04      	ldr	r2, [pc, #16]	; (c0d041b8 <ux_layout_pbb_init_common+0x38>)
c0d041a8:	447a      	add	r2, pc
c0d041aa:	5042      	str	r2, [r0, r1]
}
c0d041ac:	bd10      	pop	{r4, pc}
c0d041ae:	46c0      	nop			; (mov r8, r8)
c0d041b0:	2000186c 	.word	0x2000186c
c0d041b4:	00001086 	.word	0x00001086
c0d041b8:	fffff9c9 	.word	0xfffff9c9

c0d041bc <ux_layout_pnn_prepro>:
#endif // TARGET_NANOX

};
*/

const bagl_element_t* ux_layout_pnn_prepro(const bagl_element_t* element) {
c0d041bc:	b580      	push	{r7, lr}
      G_ux.tmp_element.text = params->line2;
      break;
  }
  return &G_ux.tmp_element;
  */
  const bagl_element_t* e = ux_layout_pbb_prepro(element);
c0d041be:	f7ff ffab 	bl	c0d04118 <ux_layout_pbb_prepro>
c0d041c2:	229d      	movs	r2, #157	; 0x9d
  if (e && G_ux.tmp_element.component.userid >= 0x10) {
c0d041c4:	2800      	cmp	r0, #0
c0d041c6:	d006      	beq.n	c0d041d6 <ux_layout_pnn_prepro+0x1a>
c0d041c8:	4903      	ldr	r1, [pc, #12]	; (c0d041d8 <ux_layout_pnn_prepro+0x1c>)
c0d041ca:	5c8a      	ldrb	r2, [r1, r2]
c0d041cc:	2a10      	cmp	r2, #16
c0d041ce:	d302      	bcc.n	c0d041d6 <ux_layout_pnn_prepro+0x1a>
c0d041d0:	22b4      	movs	r2, #180	; 0xb4
c0d041d2:	230a      	movs	r3, #10
    G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_REGULAR_11px;
c0d041d4:	528b      	strh	r3, [r1, r2]
  }
  return e;
c0d041d6:	bd80      	pop	{r7, pc}
c0d041d8:	2000186c 	.word	0x2000186c

c0d041dc <ux_layout_pnn_init>:
}

void ux_layout_pnn_init(unsigned int stack_slot) { 
c0d041dc:	b510      	push	{r4, lr}
c0d041de:	4604      	mov	r4, r0
  ux_layout_pbb_init_common(stack_slot);
c0d041e0:	f7ff ffce 	bl	c0d04180 <ux_layout_pbb_init_common>
c0d041e4:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_pnn_prepro;
c0d041e6:	4360      	muls	r0, r4
c0d041e8:	4904      	ldr	r1, [pc, #16]	; (c0d041fc <ux_layout_pnn_init+0x20>)
c0d041ea:	1808      	adds	r0, r1, r0
c0d041ec:	21cc      	movs	r1, #204	; 0xcc
c0d041ee:	4a04      	ldr	r2, [pc, #16]	; (c0d04200 <ux_layout_pnn_init+0x24>)
c0d041f0:	447a      	add	r2, pc
c0d041f2:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d041f4:	4620      	mov	r0, r4
c0d041f6:	f000 f8cb 	bl	c0d04390 <ux_stack_display>
}
c0d041fa:	bd10      	pop	{r4, pc}
c0d041fc:	2000186c 	.word	0x2000186c
c0d04200:	ffffffc9 	.word	0xffffffc9

c0d04204 <ux_layout_strings_prepro>:
    G_ux.stack[stack_slot].ticker_value = ms;
    G_ux.stack[stack_slot].ticker_interval = ms; // restart
  }
}

const bagl_element_t* ux_layout_strings_prepro(const bagl_element_t* element) {
c0d04204:	b570      	push	{r4, r5, r6, lr}
c0d04206:	4605      	mov	r5, r0
  // don't display if null
  const ux_layout_strings_params_t* params = (const ux_layout_strings_params_t*)ux_stack_get_current_step_params();
c0d04208:	f7ff fce8 	bl	c0d03bdc <ux_stack_get_current_step_params>
c0d0420c:	4604      	mov	r4, r0
  // ocpy element before any mod
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d0420e:	4e12      	ldr	r6, [pc, #72]	; (c0d04258 <ux_layout_strings_prepro+0x54>)
c0d04210:	4630      	mov	r0, r6
c0d04212:	309c      	adds	r0, #156	; 0x9c
c0d04214:	2220      	movs	r2, #32
c0d04216:	4629      	mov	r1, r5
c0d04218:	f7fc fc4c 	bl	c0d00ab4 <os_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d0421c:	7868      	ldrb	r0, [r5, #1]
c0d0421e:	2802      	cmp	r0, #2
c0d04220:	d004      	beq.n	c0d0422c <ux_layout_strings_prepro+0x28>
c0d04222:	2801      	cmp	r0, #1
c0d04224:	d109      	bne.n	c0d0423a <ux_layout_strings_prepro+0x36>
    case 0x01:
      if (ux_flow_is_first()) {
c0d04226:	f7ff fb01 	bl	c0d0382c <ux_flow_is_first>
c0d0422a:	e001      	b.n	c0d04230 <ux_layout_strings_prepro+0x2c>
        return NULL;
      }
      break;

    case 0x02:
      if (ux_flow_is_last()) {
c0d0422c:	f7ff fb26 	bl	c0d0387c <ux_flow_is_last>
c0d04230:	4601      	mov	r1, r0
c0d04232:	2000      	movs	r0, #0
c0d04234:	2900      	cmp	r1, #0
c0d04236:	d00b      	beq.n	c0d04250 <ux_layout_strings_prepro+0x4c>
        G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
      }
      break;
  }
  return &G_ux.tmp_element;
}
c0d04238:	bd70      	pop	{r4, r5, r6, pc}
c0d0423a:	209d      	movs	r0, #157	; 0x9d
        return NULL;
      }
      break;

    default:
      if (G_ux.tmp_element.component.userid&0xF0) {
c0d0423c:	5c30      	ldrb	r0, [r6, r0]
c0d0423e:	0601      	lsls	r1, r0, #24
c0d04240:	0f09      	lsrs	r1, r1, #28
c0d04242:	d005      	beq.n	c0d04250 <ux_layout_strings_prepro+0x4c>
c0d04244:	210f      	movs	r1, #15
        G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
c0d04246:	4008      	ands	r0, r1
c0d04248:	0080      	lsls	r0, r0, #2
c0d0424a:	5820      	ldr	r0, [r4, r0]
c0d0424c:	21b8      	movs	r1, #184	; 0xb8
c0d0424e:	5070      	str	r0, [r6, r1]
c0d04250:	369c      	adds	r6, #156	; 0x9c
c0d04252:	4630      	mov	r0, r6
      }
      break;
  }
  return &G_ux.tmp_element;
}
c0d04254:	bd70      	pop	{r4, r5, r6, pc}
c0d04256:	46c0      	nop			; (mov r8, r8)
c0d04258:	2000186c 	.word	0x2000186c

c0d0425c <ux_menulist_button>:

#ifndef TARGET_BLUE

void ux_menulist_refresh(unsigned int stack_slot);

unsigned int ux_menulist_button(unsigned int button_mask, unsigned int button_mask_counter) {
c0d0425c:	b5b0      	push	{r4, r5, r7, lr}
c0d0425e:	4917      	ldr	r1, [pc, #92]	; (c0d042bc <ux_menulist_button+0x60>)
  UNUSED(button_mask_counter);

  switch(button_mask) {
c0d04260:	4288      	cmp	r0, r1
c0d04262:	d011      	beq.n	c0d04288 <ux_menulist_button+0x2c>
c0d04264:	4916      	ldr	r1, [pc, #88]	; (c0d042c0 <ux_menulist_button+0x64>)
c0d04266:	4288      	cmp	r0, r1
c0d04268:	d015      	beq.n	c0d04296 <ux_menulist_button+0x3a>
c0d0426a:	4916      	ldr	r1, [pc, #88]	; (c0d042c4 <ux_menulist_button+0x68>)
c0d0426c:	4288      	cmp	r0, r1
c0d0426e:	d122      	bne.n	c0d042b6 <ux_menulist_button+0x5a>
c0d04270:	20f8      	movs	r0, #248	; 0xf8
    case BUTTON_EVT_RELEASED|BUTTON_LEFT:
      if (G_ux.menulist_getter(G_ux.menulist_current-1UL)) {
c0d04272:	4c15      	ldr	r4, [pc, #84]	; (c0d042c8 <ux_menulist_button+0x6c>)
c0d04274:	5821      	ldr	r1, [r4, r0]
c0d04276:	25e0      	movs	r5, #224	; 0xe0
c0d04278:	5960      	ldr	r0, [r4, r5]
c0d0427a:	1e40      	subs	r0, r0, #1
c0d0427c:	4788      	blx	r1
c0d0427e:	2800      	cmp	r0, #0
c0d04280:	d019      	beq.n	c0d042b6 <ux_menulist_button+0x5a>
      	G_ux.menulist_current--;
c0d04282:	5960      	ldr	r0, [r4, r5]
c0d04284:	1e40      	subs	r0, r0, #1
c0d04286:	e011      	b.n	c0d042ac <ux_menulist_button+0x50>
c0d04288:	20e0      	movs	r0, #224	; 0xe0
      	G_ux.menulist_current++;
      	ux_menulist_refresh(G_ux.stack_count-1);
      }
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      G_ux.menulist_selector(G_ux.menulist_current);
c0d0428a:	490f      	ldr	r1, [pc, #60]	; (c0d042c8 <ux_menulist_button+0x6c>)
c0d0428c:	5808      	ldr	r0, [r1, r0]
c0d0428e:	22fc      	movs	r2, #252	; 0xfc
c0d04290:	5889      	ldr	r1, [r1, r2]
c0d04292:	4788      	blx	r1
c0d04294:	e00f      	b.n	c0d042b6 <ux_menulist_button+0x5a>
c0d04296:	20f8      	movs	r0, #248	; 0xf8
      	G_ux.menulist_current--;
      	ux_menulist_refresh(G_ux.stack_count-1);
      }
      break;
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      if (G_ux.menulist_getter(G_ux.menulist_current+1UL)) {
c0d04298:	4c0b      	ldr	r4, [pc, #44]	; (c0d042c8 <ux_menulist_button+0x6c>)
c0d0429a:	5821      	ldr	r1, [r4, r0]
c0d0429c:	25e0      	movs	r5, #224	; 0xe0
c0d0429e:	5960      	ldr	r0, [r4, r5]
c0d042a0:	1c40      	adds	r0, r0, #1
c0d042a2:	4788      	blx	r1
c0d042a4:	2800      	cmp	r0, #0
c0d042a6:	d006      	beq.n	c0d042b6 <ux_menulist_button+0x5a>
      	G_ux.menulist_current++;
c0d042a8:	5960      	ldr	r0, [r4, r5]
c0d042aa:	1c40      	adds	r0, r0, #1
c0d042ac:	5160      	str	r0, [r4, r5]
c0d042ae:	7820      	ldrb	r0, [r4, #0]
c0d042b0:	1e40      	subs	r0, r0, #1
c0d042b2:	f000 f80b 	bl	c0d042cc <ux_menulist_refresh>
c0d042b6:	2000      	movs	r0, #0
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      G_ux.menulist_selector(G_ux.menulist_current);
      break;
  }
  return 0;
c0d042b8:	bdb0      	pop	{r4, r5, r7, pc}
c0d042ba:	46c0      	nop			; (mov r8, r8)
c0d042bc:	80000003 	.word	0x80000003
c0d042c0:	80000002 	.word	0x80000002
c0d042c4:	80000001 	.word	0x80000001
c0d042c8:	2000186c 	.word	0x2000186c

c0d042cc <ux_menulist_refresh>:
}

void ux_menulist_refresh(unsigned int stack_slot) {
c0d042cc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d042ce:	b081      	sub	sp, #4
c0d042d0:	4604      	mov	r4, r0
c0d042d2:	2001      	movs	r0, #1
c0d042d4:	43c6      	mvns	r6, r0
c0d042d6:	4d0c      	ldr	r5, [pc, #48]	; (c0d04308 <ux_menulist_refresh+0x3c>)
c0d042d8:	462f      	mov	r7, r5
c0d042da:	37e4      	adds	r7, #228	; 0xe4
c0d042dc:	20f8      	movs	r0, #248	; 0xf8
  // set values
  int i;
  for (i = 0; i < 5; i++) {
    G_ux.menulist_params.lines[i] = G_ux.menulist_getter(G_ux.menulist_current+i-2);
c0d042de:	5829      	ldr	r1, [r5, r0]
c0d042e0:	20e0      	movs	r0, #224	; 0xe0
c0d042e2:	5828      	ldr	r0, [r5, r0]
c0d042e4:	1830      	adds	r0, r6, r0
c0d042e6:	4788      	blx	r1
c0d042e8:	c701      	stmia	r7!, {r0}
}

void ux_menulist_refresh(unsigned int stack_slot) {
  // set values
  int i;
  for (i = 0; i < 5; i++) {
c0d042ea:	1c76      	adds	r6, r6, #1
c0d042ec:	2e03      	cmp	r6, #3
c0d042ee:	d1f5      	bne.n	c0d042dc <ux_menulist_refresh+0x10>
    G_ux.menulist_params.lines[i] = G_ux.menulist_getter(G_ux.menulist_current+i-2);
  }
  // display
  ux_layout_nnbnn_init(stack_slot);
c0d042f0:	4620      	mov	r0, r4
c0d042f2:	f7ff fceb 	bl	c0d03ccc <ux_layout_nnbnn_init>
c0d042f6:	2024      	movs	r0, #36	; 0x24
  // change callback to the menulist one
  G_ux.stack[stack_slot].button_push_callback = ux_menulist_button;
c0d042f8:	4360      	muls	r0, r4
c0d042fa:	1828      	adds	r0, r5, r0
c0d042fc:	21d0      	movs	r1, #208	; 0xd0
c0d042fe:	4a03      	ldr	r2, [pc, #12]	; (c0d0430c <ux_menulist_refresh+0x40>)
c0d04300:	447a      	add	r2, pc
c0d04302:	5042      	str	r2, [r0, r1]
}
c0d04304:	b001      	add	sp, #4
c0d04306:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d04308:	2000186c 	.word	0x2000186c
c0d0430c:	ffffff59 	.word	0xffffff59

c0d04310 <ux_menulist_init_select>:
  );

void ux_menulist_init_select(unsigned int stack_slot, 
                      list_item_value_t getter, 
                      list_item_select_t selector, 
                      unsigned int selected_item_idx) {
c0d04310:	b5b0      	push	{r4, r5, r7, lr}
c0d04312:	4604      	mov	r4, r0
c0d04314:	20f8      	movs	r0, #248	; 0xf8
  G_ux.menulist_current  = selected_item_idx;
c0d04316:	4d0b      	ldr	r5, [pc, #44]	; (c0d04344 <ux_menulist_init_select+0x34>)
  G_ux.menulist_getter = getter;
c0d04318:	5029      	str	r1, [r5, r0]
c0d0431a:	20e0      	movs	r0, #224	; 0xe0

void ux_menulist_init_select(unsigned int stack_slot, 
                      list_item_value_t getter, 
                      list_item_select_t selector, 
                      unsigned int selected_item_idx) {
  G_ux.menulist_current  = selected_item_idx;
c0d0431c:	502b      	str	r3, [r5, r0]
c0d0431e:	20fc      	movs	r0, #252	; 0xfc
  G_ux.menulist_getter = getter;
  G_ux.menulist_selector = selector;
c0d04320:	502a      	str	r2, [r5, r0]

  // ensure the current flow step reference the G_ux.menulist_params to ensure strings displayed correctly.
  // if not, then use the forged step (and display it if top of ux stack)
  if (ux_stack_get_step_params(stack_slot) != (void*)&G_ux.menulist_params) {
c0d04322:	4620      	mov	r0, r4
c0d04324:	f7ff fc42 	bl	c0d03bac <ux_stack_get_step_params>
c0d04328:	35e4      	adds	r5, #228	; 0xe4
c0d0432a:	42a8      	cmp	r0, r5
c0d0432c:	d006      	beq.n	c0d0433c <ux_menulist_init_select+0x2c>
    ux_flow_init(stack_slot, ux_menulist_constflow, NULL);
c0d0432e:	4906      	ldr	r1, [pc, #24]	; (c0d04348 <ux_menulist_init_select+0x38>)
c0d04330:	4479      	add	r1, pc
c0d04332:	2200      	movs	r2, #0
c0d04334:	4620      	mov	r0, r4
c0d04336:	f7ff fbd3 	bl	c0d03ae0 <ux_flow_init>
  }
  else {
    ux_menulist_refresh(stack_slot);
  }
}
c0d0433a:	bdb0      	pop	{r4, r5, r7, pc}
  // if not, then use the forged step (and display it if top of ux stack)
  if (ux_stack_get_step_params(stack_slot) != (void*)&G_ux.menulist_params) {
    ux_flow_init(stack_slot, ux_menulist_constflow, NULL);
  }
  else {
    ux_menulist_refresh(stack_slot);
c0d0433c:	4620      	mov	r0, r4
c0d0433e:	f7ff ffc5 	bl	c0d042cc <ux_menulist_refresh>
  }
}
c0d04342:	bdb0      	pop	{r4, r5, r7, pc}
c0d04344:	2000186c 	.word	0x2000186c
c0d04348:	00000fc0 	.word	0x00000fc0

c0d0434c <ux_menulist_init>:

// based on a nnbnn layout
void ux_menulist_init(unsigned int stack_slot, 
                             list_item_value_t getter, 
                             list_item_select_t selector) {
c0d0434c:	b580      	push	{r7, lr}
c0d0434e:	2300      	movs	r3, #0
	ux_menulist_init_select(stack_slot, getter, selector, 0);
c0d04350:	f7ff ffde 	bl	c0d04310 <ux_menulist_init_select>
}
c0d04354:	bd80      	pop	{r7, pc}
	...

c0d04358 <ux_stack_push>:
    }
  }
  return 0;
}

unsigned int ux_stack_push(void) {
c0d04358:	b5b0      	push	{r4, r5, r7, lr}
  // only push if an available slot exists
  if (G_ux.stack_count < ARRAYLEN(G_ux.stack)) {
c0d0435a:	4d0c      	ldr	r5, [pc, #48]	; (c0d0438c <ux_stack_push+0x34>)
c0d0435c:	7828      	ldrb	r0, [r5, #0]
c0d0435e:	2800      	cmp	r0, #0
c0d04360:	d111      	bne.n	c0d04386 <ux_stack_push+0x2e>
    os_memset(&G_ux.stack[G_ux.stack_count], 0, sizeof(G_ux.stack[0]));
c0d04362:	4628      	mov	r0, r5
c0d04364:	30bc      	adds	r0, #188	; 0xbc
c0d04366:	2400      	movs	r4, #0
c0d04368:	2224      	movs	r2, #36	; 0x24
c0d0436a:	4621      	mov	r1, r4
c0d0436c:	f7fc fbb8 	bl	c0d00ae0 <os_memset>
#ifdef HAVE_UX_FLOW
    os_memset(&G_ux.flow_stack[G_ux.stack_count], 0, sizeof(G_ux.flow_stack[0]));
c0d04370:	7828      	ldrb	r0, [r5, #0]
c0d04372:	220c      	movs	r2, #12
c0d04374:	4350      	muls	r0, r2
c0d04376:	1828      	adds	r0, r5, r0
c0d04378:	3010      	adds	r0, #16
c0d0437a:	4621      	mov	r1, r4
c0d0437c:	f7fc fbb0 	bl	c0d00ae0 <os_memset>
#endif // HAVE_UX_FLOW
    G_ux.stack_count++;
c0d04380:	7828      	ldrb	r0, [r5, #0]
c0d04382:	1c40      	adds	r0, r0, #1
c0d04384:	7028      	strb	r0, [r5, #0]
  }
  // return the stack top index
  return G_ux.stack_count-1;
c0d04386:	b2c0      	uxtb	r0, r0
c0d04388:	1e40      	subs	r0, r0, #1
c0d0438a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0438c:	2000186c 	.word	0x2000186c

c0d04390 <ux_stack_display>:
}
#endif // UX_STACK_SLOT_ARRAY_COUNT == 1
#endif // TARGET_NANOX

// common code for all screens
void ux_stack_display(unsigned int stack_slot) {
c0d04390:	b5b0      	push	{r4, r5, r7, lr}
c0d04392:	4604      	mov	r4, r0
  // don't display any elements of a previous screen replacement
  if(G_ux.stack_count > 0 && stack_slot+1 == G_ux.stack_count) {
c0d04394:	4810      	ldr	r0, [pc, #64]	; (c0d043d8 <ux_stack_display+0x48>)
c0d04396:	7801      	ldrb	r1, [r0, #0]
c0d04398:	2900      	cmp	r1, #0
c0d0439a:	d00e      	beq.n	c0d043ba <ux_stack_display+0x2a>
c0d0439c:	1c62      	adds	r2, r4, #1
c0d0439e:	428a      	cmp	r2, r1
c0d043a0:	d10b      	bne.n	c0d043ba <ux_stack_display+0x2a>
c0d043a2:	2124      	movs	r1, #36	; 0x24
    io_seproxyhal_init_ux();
    // at worse a redisplay of the current screen has been requested, ensure to redraw it correctly
    G_ux.stack[stack_slot].element_index = 0;
c0d043a4:	4361      	muls	r1, r4
c0d043a6:	1845      	adds	r5, r0, r1

// common code for all screens
void ux_stack_display(unsigned int stack_slot) {
  // don't display any elements of a previous screen replacement
  if(G_ux.stack_count > 0 && stack_slot+1 == G_ux.stack_count) {
    io_seproxyhal_init_ux();
c0d043a8:	f7fc fd06 	bl	c0d00db8 <io_seproxyhal_init_ux>
c0d043ac:	20be      	movs	r0, #190	; 0xbe
c0d043ae:	2100      	movs	r1, #0
    // at worse a redisplay of the current screen has been requested, ensure to redraw it correctly
    G_ux.stack[stack_slot].element_index = 0;
c0d043b0:	5229      	strh	r1, [r5, r0]
#ifdef TARGET_NANOX
    ux_stack_display_elements(&G_ux.stack[stack_slot]); // on balenos, no need to wait for the display processed event
#else // TARGET_NANOX
    ux_stack_al_display_next_element(stack_slot);
c0d043b2:	4620      	mov	r0, r4
c0d043b4:	f000 f826 	bl	c0d04404 <ux_stack_al_display_next_element>
    if (G_ux.exit_code == BOLOS_UX_OK) {
      G_ux.exit_code = BOLOS_UX_REDRAW;
    }
  }
  // else don't draw (in stack insertion)
}
c0d043b8:	bdb0      	pop	{r4, r5, r7, pc}
c0d043ba:	2200      	movs	r2, #0
#endif // TARGET_NANOX

// common code for all screens
void ux_stack_display(unsigned int stack_slot) {
  // don't display any elements of a previous screen replacement
  if(G_ux.stack_count > 0 && stack_slot+1 == G_ux.stack_count) {
c0d043bc:	1a53      	subs	r3, r2, r1
c0d043be:	414b      	adcs	r3, r1
#else // TARGET_NANOX
    ux_stack_al_display_next_element(stack_slot);
#endif // TARGET_NANOX
  }
  // asking to redraw below top screen (likely the app below the ux)
  else if (stack_slot == -1UL || G_ux.stack_count == 0) {
c0d043c0:	1c61      	adds	r1, r4, #1
c0d043c2:	1a52      	subs	r2, r2, r1
c0d043c4:	414a      	adcs	r2, r1
c0d043c6:	431a      	orrs	r2, r3
c0d043c8:	2a01      	cmp	r2, #1
c0d043ca:	d104      	bne.n	c0d043d6 <ux_stack_display+0x46>
c0d043cc:	7841      	ldrb	r1, [r0, #1]
c0d043ce:	29aa      	cmp	r1, #170	; 0xaa
c0d043d0:	d101      	bne.n	c0d043d6 <ux_stack_display+0x46>
c0d043d2:	2169      	movs	r1, #105	; 0x69
    if (G_ux.exit_code == BOLOS_UX_OK) {
      G_ux.exit_code = BOLOS_UX_REDRAW;
c0d043d4:	7041      	strb	r1, [r0, #1]
    }
  }
  // else don't draw (in stack insertion)
}
c0d043d6:	bdb0      	pop	{r4, r5, r7, pc}
c0d043d8:	2000186c 	.word	0x2000186c

c0d043dc <ux_stack_init>:
  // wipe last slot
  ux_stack_pop();
}

// common code for all screens
void ux_stack_init(unsigned int stack_slot) {
c0d043dc:	b570      	push	{r4, r5, r6, lr}
c0d043de:	2424      	movs	r4, #36	; 0x24
    reset();
  }
  */

  // wipe the slot to be displayed just in case
  os_memset(&G_ux.stack[stack_slot], 0, sizeof(G_ux.stack[0]));
c0d043e0:	4360      	muls	r0, r4
c0d043e2:	4907      	ldr	r1, [pc, #28]	; (c0d04400 <ux_stack_init+0x24>)
c0d043e4:	180e      	adds	r6, r1, r0
}

// common code for all screens
void ux_stack_init(unsigned int stack_slot) {
  // reinit ux behavior (previous touched element, button push state)
  io_seproxyhal_init_ux(); // glitch upon ux_stack_display for a button being pressed in a previous screen
c0d043e6:	f7fc fce7 	bl	c0d00db8 <io_seproxyhal_init_ux>
    reset();
  }
  */

  // wipe the slot to be displayed just in case
  os_memset(&G_ux.stack[stack_slot], 0, sizeof(G_ux.stack[0]));
c0d043ea:	4630      	mov	r0, r6
c0d043ec:	30bc      	adds	r0, #188	; 0xbc
c0d043ee:	2500      	movs	r5, #0
c0d043f0:	4629      	mov	r1, r5
c0d043f2:	4622      	mov	r2, r4
c0d043f4:	f7fc fb74 	bl	c0d00ae0 <os_memset>
c0d043f8:	20bc      	movs	r0, #188	; 0xbc
  
  // init current screen state
  G_ux.stack[stack_slot].exit_code_after_elements_displayed = BOLOS_UX_CONTINUE;
c0d043fa:	5435      	strb	r5, [r6, r0]
}
c0d043fc:	bd70      	pop	{r4, r5, r6, pc}
c0d043fe:	46c0      	nop			; (mov r8, r8)
c0d04400:	2000186c 	.word	0x2000186c

c0d04404 <ux_stack_al_display_next_element>:
#endif // TARGET_NANOX

#ifndef TARGET_NANOX
#if UX_STACK_SLOT_ARRAY_COUNT == 1
void ux_stack_al_display_next_element(unsigned int stack_slot) __attribute__((weak));
void ux_stack_al_display_next_element(unsigned int stack_slot) {
c0d04404:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04406:	b081      	sub	sp, #4
c0d04408:	4604      	mov	r4, r0
c0d0440a:	2004      	movs	r0, #4
  unsigned int status = os_sched_last_status(TASK_BOLOS_UX);
c0d0440c:	f7fd fc36 	bl	c0d01c7c <os_sched_last_status>
  if (status != BOLOS_UX_IGNORE && status != BOLOS_UX_CONTINUE) {
c0d04410:	2800      	cmp	r0, #0
c0d04412:	d03c      	beq.n	c0d0448e <ux_stack_al_display_next_element+0x8a>
c0d04414:	2897      	cmp	r0, #151	; 0x97
c0d04416:	d03a      	beq.n	c0d0448e <ux_stack_al_display_next_element+0x8a>
c0d04418:	2024      	movs	r0, #36	; 0x24
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
c0d0441a:	4360      	muls	r0, r4
c0d0441c:	491d      	ldr	r1, [pc, #116]	; (c0d04494 <ux_stack_al_display_next_element+0x90>)
c0d0441e:	180c      	adds	r4, r1, r0
c0d04420:	20c0      	movs	r0, #192	; 0xc0
#if UX_STACK_SLOT_ARRAY_COUNT == 1
void ux_stack_al_display_next_element(unsigned int stack_slot) __attribute__((weak));
void ux_stack_al_display_next_element(unsigned int stack_slot) {
  unsigned int status = os_sched_last_status(TASK_BOLOS_UX);
  if (status != BOLOS_UX_IGNORE && status != BOLOS_UX_CONTINUE) {
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
c0d04422:	5820      	ldr	r0, [r4, r0]
c0d04424:	4625      	mov	r5, r4
c0d04426:	35c0      	adds	r5, #192	; 0xc0
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
c0d04428:	4626      	mov	r6, r4
c0d0442a:	36be      	adds	r6, #190	; 0xbe
c0d0442c:	2800      	cmp	r0, #0
c0d0442e:	d02e      	beq.n	c0d0448e <ux_stack_al_display_next_element+0x8a>
c0d04430:	4620      	mov	r0, r4
c0d04432:	30cc      	adds	r0, #204	; 0xcc
c0d04434:	9000      	str	r0, [sp, #0]
c0d04436:	34c4      	adds	r4, #196	; 0xc4
c0d04438:	8830      	ldrh	r0, [r6, #0]
c0d0443a:	27aa      	movs	r7, #170	; 0xaa
c0d0443c:	7821      	ldrb	r1, [r4, #0]
c0d0443e:	b280      	uxth	r0, r0
      && ! io_seproxyhal_spi_is_status_sent()
c0d04440:	4288      	cmp	r0, r1
c0d04442:	d224      	bcs.n	c0d0448e <ux_stack_al_display_next_element+0x8a>
c0d04444:	f7fd fbe6 	bl	c0d01c14 <io_seph_is_status_sent>
      && (os_perso_isonboarded() != BOLOS_UX_OK || os_global_pin_is_validated() == BOLOS_UX_OK)) {
c0d04448:	2800      	cmp	r0, #0
c0d0444a:	d120      	bne.n	c0d0448e <ux_stack_al_display_next_element+0x8a>
c0d0444c:	f7fd fb68 	bl	c0d01b20 <os_perso_isonboarded>
c0d04450:	42b8      	cmp	r0, r7
c0d04452:	d103      	bne.n	c0d0445c <ux_stack_al_display_next_element+0x58>
c0d04454:	f7fd fb94 	bl	c0d01b80 <os_global_pin_is_validated>
#if UX_STACK_SLOT_ARRAY_COUNT == 1
void ux_stack_al_display_next_element(unsigned int stack_slot) __attribute__((weak));
void ux_stack_al_display_next_element(unsigned int stack_slot) {
  unsigned int status = os_sched_last_status(TASK_BOLOS_UX);
  if (status != BOLOS_UX_IGNORE && status != BOLOS_UX_CONTINUE) {
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
c0d04458:	42b8      	cmp	r0, r7
c0d0445a:	d118      	bne.n	c0d0448e <ux_stack_al_display_next_element+0x8a>
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
      && ! io_seproxyhal_spi_is_status_sent()
      && (os_perso_isonboarded() != BOLOS_UX_OK || os_global_pin_is_validated() == BOLOS_UX_OK)) {
      const bagl_element_t* element = &G_ux.stack[stack_slot].element_arrays[0].element_array[G_ux.stack[stack_slot].element_index];
c0d0445c:	6828      	ldr	r0, [r5, #0]
c0d0445e:	8831      	ldrh	r1, [r6, #0]
c0d04460:	0149      	lsls	r1, r1, #5
c0d04462:	1840      	adds	r0, r0, r1
      if (!G_ux.stack[stack_slot].screen_before_element_display_callback || (element = G_ux.stack[stack_slot].screen_before_element_display_callback(element)) ) {
c0d04464:	9900      	ldr	r1, [sp, #0]
c0d04466:	6809      	ldr	r1, [r1, #0]
c0d04468:	2900      	cmp	r1, #0
c0d0446a:	d002      	beq.n	c0d04472 <ux_stack_al_display_next_element+0x6e>
c0d0446c:	4788      	blx	r1
c0d0446e:	2800      	cmp	r0, #0
c0d04470:	d007      	beq.n	c0d04482 <ux_stack_al_display_next_element+0x7e>
        if ((unsigned int)element == 1) { /*backward compat with coding to avoid smashing everything*/
c0d04472:	2801      	cmp	r0, #1
c0d04474:	d103      	bne.n	c0d0447e <ux_stack_al_display_next_element+0x7a>
          element = &G_ux.stack[stack_slot].element_arrays[0].element_array[G_ux.stack[stack_slot].element_index];
c0d04476:	6828      	ldr	r0, [r5, #0]
c0d04478:	8831      	ldrh	r1, [r6, #0]
c0d0447a:	0149      	lsls	r1, r1, #5
c0d0447c:	1840      	adds	r0, r0, r1
        }
        io_seproxyhal_display(element);
c0d0447e:	f7fb ff79 	bl	c0d00374 <io_seproxyhal_display>
      } \
      G_ux.stack[stack_slot].element_index++;
c0d04482:	8830      	ldrh	r0, [r6, #0]
c0d04484:	1c40      	adds	r0, r0, #1
c0d04486:	8030      	strh	r0, [r6, #0]
#if UX_STACK_SLOT_ARRAY_COUNT == 1
void ux_stack_al_display_next_element(unsigned int stack_slot) __attribute__((weak));
void ux_stack_al_display_next_element(unsigned int stack_slot) {
  unsigned int status = os_sched_last_status(TASK_BOLOS_UX);
  if (status != BOLOS_UX_IGNORE && status != BOLOS_UX_CONTINUE) {
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
c0d04488:	6829      	ldr	r1, [r5, #0]
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
c0d0448a:	2900      	cmp	r1, #0
c0d0448c:	d1d6      	bne.n	c0d0443c <ux_stack_al_display_next_element+0x38>
        io_seproxyhal_display(element);
      } \
      G_ux.stack[stack_slot].element_index++;
    }
  }
}
c0d0448e:	b001      	add	sp, #4
c0d04490:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d04492:	46c0      	nop			; (mov r8, r8)
c0d04494:	2000186c 	.word	0x2000186c

c0d04498 <__aeabi_uidiv>:
c0d04498:	2200      	movs	r2, #0
c0d0449a:	0843      	lsrs	r3, r0, #1
c0d0449c:	428b      	cmp	r3, r1
c0d0449e:	d374      	bcc.n	c0d0458a <__aeabi_uidiv+0xf2>
c0d044a0:	0903      	lsrs	r3, r0, #4
c0d044a2:	428b      	cmp	r3, r1
c0d044a4:	d35f      	bcc.n	c0d04566 <__aeabi_uidiv+0xce>
c0d044a6:	0a03      	lsrs	r3, r0, #8
c0d044a8:	428b      	cmp	r3, r1
c0d044aa:	d344      	bcc.n	c0d04536 <__aeabi_uidiv+0x9e>
c0d044ac:	0b03      	lsrs	r3, r0, #12
c0d044ae:	428b      	cmp	r3, r1
c0d044b0:	d328      	bcc.n	c0d04504 <__aeabi_uidiv+0x6c>
c0d044b2:	0c03      	lsrs	r3, r0, #16
c0d044b4:	428b      	cmp	r3, r1
c0d044b6:	d30d      	bcc.n	c0d044d4 <__aeabi_uidiv+0x3c>
c0d044b8:	22ff      	movs	r2, #255	; 0xff
c0d044ba:	0209      	lsls	r1, r1, #8
c0d044bc:	ba12      	rev	r2, r2
c0d044be:	0c03      	lsrs	r3, r0, #16
c0d044c0:	428b      	cmp	r3, r1
c0d044c2:	d302      	bcc.n	c0d044ca <__aeabi_uidiv+0x32>
c0d044c4:	1212      	asrs	r2, r2, #8
c0d044c6:	0209      	lsls	r1, r1, #8
c0d044c8:	d065      	beq.n	c0d04596 <__aeabi_uidiv+0xfe>
c0d044ca:	0b03      	lsrs	r3, r0, #12
c0d044cc:	428b      	cmp	r3, r1
c0d044ce:	d319      	bcc.n	c0d04504 <__aeabi_uidiv+0x6c>
c0d044d0:	e000      	b.n	c0d044d4 <__aeabi_uidiv+0x3c>
c0d044d2:	0a09      	lsrs	r1, r1, #8
c0d044d4:	0bc3      	lsrs	r3, r0, #15
c0d044d6:	428b      	cmp	r3, r1
c0d044d8:	d301      	bcc.n	c0d044de <__aeabi_uidiv+0x46>
c0d044da:	03cb      	lsls	r3, r1, #15
c0d044dc:	1ac0      	subs	r0, r0, r3
c0d044de:	4152      	adcs	r2, r2
c0d044e0:	0b83      	lsrs	r3, r0, #14
c0d044e2:	428b      	cmp	r3, r1
c0d044e4:	d301      	bcc.n	c0d044ea <__aeabi_uidiv+0x52>
c0d044e6:	038b      	lsls	r3, r1, #14
c0d044e8:	1ac0      	subs	r0, r0, r3
c0d044ea:	4152      	adcs	r2, r2
c0d044ec:	0b43      	lsrs	r3, r0, #13
c0d044ee:	428b      	cmp	r3, r1
c0d044f0:	d301      	bcc.n	c0d044f6 <__aeabi_uidiv+0x5e>
c0d044f2:	034b      	lsls	r3, r1, #13
c0d044f4:	1ac0      	subs	r0, r0, r3
c0d044f6:	4152      	adcs	r2, r2
c0d044f8:	0b03      	lsrs	r3, r0, #12
c0d044fa:	428b      	cmp	r3, r1
c0d044fc:	d301      	bcc.n	c0d04502 <__aeabi_uidiv+0x6a>
c0d044fe:	030b      	lsls	r3, r1, #12
c0d04500:	1ac0      	subs	r0, r0, r3
c0d04502:	4152      	adcs	r2, r2
c0d04504:	0ac3      	lsrs	r3, r0, #11
c0d04506:	428b      	cmp	r3, r1
c0d04508:	d301      	bcc.n	c0d0450e <__aeabi_uidiv+0x76>
c0d0450a:	02cb      	lsls	r3, r1, #11
c0d0450c:	1ac0      	subs	r0, r0, r3
c0d0450e:	4152      	adcs	r2, r2
c0d04510:	0a83      	lsrs	r3, r0, #10
c0d04512:	428b      	cmp	r3, r1
c0d04514:	d301      	bcc.n	c0d0451a <__aeabi_uidiv+0x82>
c0d04516:	028b      	lsls	r3, r1, #10
c0d04518:	1ac0      	subs	r0, r0, r3
c0d0451a:	4152      	adcs	r2, r2
c0d0451c:	0a43      	lsrs	r3, r0, #9
c0d0451e:	428b      	cmp	r3, r1
c0d04520:	d301      	bcc.n	c0d04526 <__aeabi_uidiv+0x8e>
c0d04522:	024b      	lsls	r3, r1, #9
c0d04524:	1ac0      	subs	r0, r0, r3
c0d04526:	4152      	adcs	r2, r2
c0d04528:	0a03      	lsrs	r3, r0, #8
c0d0452a:	428b      	cmp	r3, r1
c0d0452c:	d301      	bcc.n	c0d04532 <__aeabi_uidiv+0x9a>
c0d0452e:	020b      	lsls	r3, r1, #8
c0d04530:	1ac0      	subs	r0, r0, r3
c0d04532:	4152      	adcs	r2, r2
c0d04534:	d2cd      	bcs.n	c0d044d2 <__aeabi_uidiv+0x3a>
c0d04536:	09c3      	lsrs	r3, r0, #7
c0d04538:	428b      	cmp	r3, r1
c0d0453a:	d301      	bcc.n	c0d04540 <__aeabi_uidiv+0xa8>
c0d0453c:	01cb      	lsls	r3, r1, #7
c0d0453e:	1ac0      	subs	r0, r0, r3
c0d04540:	4152      	adcs	r2, r2
c0d04542:	0983      	lsrs	r3, r0, #6
c0d04544:	428b      	cmp	r3, r1
c0d04546:	d301      	bcc.n	c0d0454c <__aeabi_uidiv+0xb4>
c0d04548:	018b      	lsls	r3, r1, #6
c0d0454a:	1ac0      	subs	r0, r0, r3
c0d0454c:	4152      	adcs	r2, r2
c0d0454e:	0943      	lsrs	r3, r0, #5
c0d04550:	428b      	cmp	r3, r1
c0d04552:	d301      	bcc.n	c0d04558 <__aeabi_uidiv+0xc0>
c0d04554:	014b      	lsls	r3, r1, #5
c0d04556:	1ac0      	subs	r0, r0, r3
c0d04558:	4152      	adcs	r2, r2
c0d0455a:	0903      	lsrs	r3, r0, #4
c0d0455c:	428b      	cmp	r3, r1
c0d0455e:	d301      	bcc.n	c0d04564 <__aeabi_uidiv+0xcc>
c0d04560:	010b      	lsls	r3, r1, #4
c0d04562:	1ac0      	subs	r0, r0, r3
c0d04564:	4152      	adcs	r2, r2
c0d04566:	08c3      	lsrs	r3, r0, #3
c0d04568:	428b      	cmp	r3, r1
c0d0456a:	d301      	bcc.n	c0d04570 <__aeabi_uidiv+0xd8>
c0d0456c:	00cb      	lsls	r3, r1, #3
c0d0456e:	1ac0      	subs	r0, r0, r3
c0d04570:	4152      	adcs	r2, r2
c0d04572:	0883      	lsrs	r3, r0, #2
c0d04574:	428b      	cmp	r3, r1
c0d04576:	d301      	bcc.n	c0d0457c <__aeabi_uidiv+0xe4>
c0d04578:	008b      	lsls	r3, r1, #2
c0d0457a:	1ac0      	subs	r0, r0, r3
c0d0457c:	4152      	adcs	r2, r2
c0d0457e:	0843      	lsrs	r3, r0, #1
c0d04580:	428b      	cmp	r3, r1
c0d04582:	d301      	bcc.n	c0d04588 <__aeabi_uidiv+0xf0>
c0d04584:	004b      	lsls	r3, r1, #1
c0d04586:	1ac0      	subs	r0, r0, r3
c0d04588:	4152      	adcs	r2, r2
c0d0458a:	1a41      	subs	r1, r0, r1
c0d0458c:	d200      	bcs.n	c0d04590 <__aeabi_uidiv+0xf8>
c0d0458e:	4601      	mov	r1, r0
c0d04590:	4152      	adcs	r2, r2
c0d04592:	4610      	mov	r0, r2
c0d04594:	4770      	bx	lr
c0d04596:	e7ff      	b.n	c0d04598 <__aeabi_uidiv+0x100>
c0d04598:	b501      	push	{r0, lr}
c0d0459a:	2000      	movs	r0, #0
c0d0459c:	f000 f806 	bl	c0d045ac <__aeabi_idiv0>
c0d045a0:	bd02      	pop	{r1, pc}
c0d045a2:	46c0      	nop			; (mov r8, r8)

c0d045a4 <__aeabi_uidivmod>:
c0d045a4:	2900      	cmp	r1, #0
c0d045a6:	d0f7      	beq.n	c0d04598 <__aeabi_uidiv+0x100>
c0d045a8:	e776      	b.n	c0d04498 <__aeabi_uidiv>
c0d045aa:	4770      	bx	lr

c0d045ac <__aeabi_idiv0>:
c0d045ac:	4770      	bx	lr
c0d045ae:	46c0      	nop			; (mov r8, r8)

c0d045b0 <__aeabi_memclr>:
c0d045b0:	b510      	push	{r4, lr}
c0d045b2:	2200      	movs	r2, #0
c0d045b4:	f000 f806 	bl	c0d045c4 <__aeabi_memset>
c0d045b8:	bd10      	pop	{r4, pc}
c0d045ba:	46c0      	nop			; (mov r8, r8)

c0d045bc <__aeabi_memmove>:
c0d045bc:	b510      	push	{r4, lr}
c0d045be:	f000 f809 	bl	c0d045d4 <memmove>
c0d045c2:	bd10      	pop	{r4, pc}

c0d045c4 <__aeabi_memset>:
c0d045c4:	0013      	movs	r3, r2
c0d045c6:	b510      	push	{r4, lr}
c0d045c8:	000a      	movs	r2, r1
c0d045ca:	0019      	movs	r1, r3
c0d045cc:	f000 f84e 	bl	c0d0466c <memset>
c0d045d0:	bd10      	pop	{r4, pc}
c0d045d2:	46c0      	nop			; (mov r8, r8)

c0d045d4 <memmove>:
c0d045d4:	b570      	push	{r4, r5, r6, lr}
c0d045d6:	4288      	cmp	r0, r1
c0d045d8:	d90b      	bls.n	c0d045f2 <memmove+0x1e>
c0d045da:	188b      	adds	r3, r1, r2
c0d045dc:	4298      	cmp	r0, r3
c0d045de:	d208      	bcs.n	c0d045f2 <memmove+0x1e>
c0d045e0:	1a99      	subs	r1, r3, r2
c0d045e2:	1e53      	subs	r3, r2, #1
c0d045e4:	2a00      	cmp	r2, #0
c0d045e6:	d003      	beq.n	c0d045f0 <memmove+0x1c>
c0d045e8:	5cca      	ldrb	r2, [r1, r3]
c0d045ea:	54c2      	strb	r2, [r0, r3]
c0d045ec:	3b01      	subs	r3, #1
c0d045ee:	d2fb      	bcs.n	c0d045e8 <memmove+0x14>
c0d045f0:	bd70      	pop	{r4, r5, r6, pc}
c0d045f2:	2a0f      	cmp	r2, #15
c0d045f4:	d809      	bhi.n	c0d0460a <memmove+0x36>
c0d045f6:	0005      	movs	r5, r0
c0d045f8:	2a00      	cmp	r2, #0
c0d045fa:	d0f9      	beq.n	c0d045f0 <memmove+0x1c>
c0d045fc:	2300      	movs	r3, #0
c0d045fe:	5ccc      	ldrb	r4, [r1, r3]
c0d04600:	54ec      	strb	r4, [r5, r3]
c0d04602:	3301      	adds	r3, #1
c0d04604:	429a      	cmp	r2, r3
c0d04606:	d1fa      	bne.n	c0d045fe <memmove+0x2a>
c0d04608:	e7f2      	b.n	c0d045f0 <memmove+0x1c>
c0d0460a:	000c      	movs	r4, r1
c0d0460c:	4304      	orrs	r4, r0
c0d0460e:	000b      	movs	r3, r1
c0d04610:	07a4      	lsls	r4, r4, #30
c0d04612:	d126      	bne.n	c0d04662 <memmove+0x8e>
c0d04614:	0015      	movs	r5, r2
c0d04616:	0004      	movs	r4, r0
c0d04618:	3d10      	subs	r5, #16
c0d0461a:	092d      	lsrs	r5, r5, #4
c0d0461c:	3501      	adds	r5, #1
c0d0461e:	012d      	lsls	r5, r5, #4
c0d04620:	1949      	adds	r1, r1, r5
c0d04622:	681e      	ldr	r6, [r3, #0]
c0d04624:	6026      	str	r6, [r4, #0]
c0d04626:	685e      	ldr	r6, [r3, #4]
c0d04628:	6066      	str	r6, [r4, #4]
c0d0462a:	689e      	ldr	r6, [r3, #8]
c0d0462c:	60a6      	str	r6, [r4, #8]
c0d0462e:	68de      	ldr	r6, [r3, #12]
c0d04630:	3310      	adds	r3, #16
c0d04632:	60e6      	str	r6, [r4, #12]
c0d04634:	3410      	adds	r4, #16
c0d04636:	4299      	cmp	r1, r3
c0d04638:	d1f3      	bne.n	c0d04622 <memmove+0x4e>
c0d0463a:	240f      	movs	r4, #15
c0d0463c:	1945      	adds	r5, r0, r5
c0d0463e:	4014      	ands	r4, r2
c0d04640:	2c03      	cmp	r4, #3
c0d04642:	d910      	bls.n	c0d04666 <memmove+0x92>
c0d04644:	2300      	movs	r3, #0
c0d04646:	3c04      	subs	r4, #4
c0d04648:	08a4      	lsrs	r4, r4, #2
c0d0464a:	3401      	adds	r4, #1
c0d0464c:	00a4      	lsls	r4, r4, #2
c0d0464e:	58ce      	ldr	r6, [r1, r3]
c0d04650:	50ee      	str	r6, [r5, r3]
c0d04652:	3304      	adds	r3, #4
c0d04654:	429c      	cmp	r4, r3
c0d04656:	d1fa      	bne.n	c0d0464e <memmove+0x7a>
c0d04658:	2303      	movs	r3, #3
c0d0465a:	192d      	adds	r5, r5, r4
c0d0465c:	1909      	adds	r1, r1, r4
c0d0465e:	401a      	ands	r2, r3
c0d04660:	e7ca      	b.n	c0d045f8 <memmove+0x24>
c0d04662:	0005      	movs	r5, r0
c0d04664:	e7ca      	b.n	c0d045fc <memmove+0x28>
c0d04666:	0022      	movs	r2, r4
c0d04668:	e7c6      	b.n	c0d045f8 <memmove+0x24>
c0d0466a:	46c0      	nop			; (mov r8, r8)

c0d0466c <memset>:
c0d0466c:	b570      	push	{r4, r5, r6, lr}
c0d0466e:	0783      	lsls	r3, r0, #30
c0d04670:	d03f      	beq.n	c0d046f2 <memset+0x86>
c0d04672:	1e54      	subs	r4, r2, #1
c0d04674:	2a00      	cmp	r2, #0
c0d04676:	d03b      	beq.n	c0d046f0 <memset+0x84>
c0d04678:	b2ce      	uxtb	r6, r1
c0d0467a:	0003      	movs	r3, r0
c0d0467c:	2503      	movs	r5, #3
c0d0467e:	e003      	b.n	c0d04688 <memset+0x1c>
c0d04680:	1e62      	subs	r2, r4, #1
c0d04682:	2c00      	cmp	r4, #0
c0d04684:	d034      	beq.n	c0d046f0 <memset+0x84>
c0d04686:	0014      	movs	r4, r2
c0d04688:	3301      	adds	r3, #1
c0d0468a:	1e5a      	subs	r2, r3, #1
c0d0468c:	7016      	strb	r6, [r2, #0]
c0d0468e:	422b      	tst	r3, r5
c0d04690:	d1f6      	bne.n	c0d04680 <memset+0x14>
c0d04692:	2c03      	cmp	r4, #3
c0d04694:	d924      	bls.n	c0d046e0 <memset+0x74>
c0d04696:	25ff      	movs	r5, #255	; 0xff
c0d04698:	400d      	ands	r5, r1
c0d0469a:	022a      	lsls	r2, r5, #8
c0d0469c:	4315      	orrs	r5, r2
c0d0469e:	042a      	lsls	r2, r5, #16
c0d046a0:	4315      	orrs	r5, r2
c0d046a2:	2c0f      	cmp	r4, #15
c0d046a4:	d911      	bls.n	c0d046ca <memset+0x5e>
c0d046a6:	0026      	movs	r6, r4
c0d046a8:	3e10      	subs	r6, #16
c0d046aa:	0936      	lsrs	r6, r6, #4
c0d046ac:	3601      	adds	r6, #1
c0d046ae:	0136      	lsls	r6, r6, #4
c0d046b0:	001a      	movs	r2, r3
c0d046b2:	199b      	adds	r3, r3, r6
c0d046b4:	6015      	str	r5, [r2, #0]
c0d046b6:	6055      	str	r5, [r2, #4]
c0d046b8:	6095      	str	r5, [r2, #8]
c0d046ba:	60d5      	str	r5, [r2, #12]
c0d046bc:	3210      	adds	r2, #16
c0d046be:	4293      	cmp	r3, r2
c0d046c0:	d1f8      	bne.n	c0d046b4 <memset+0x48>
c0d046c2:	220f      	movs	r2, #15
c0d046c4:	4014      	ands	r4, r2
c0d046c6:	2c03      	cmp	r4, #3
c0d046c8:	d90a      	bls.n	c0d046e0 <memset+0x74>
c0d046ca:	1f26      	subs	r6, r4, #4
c0d046cc:	08b6      	lsrs	r6, r6, #2
c0d046ce:	3601      	adds	r6, #1
c0d046d0:	00b6      	lsls	r6, r6, #2
c0d046d2:	001a      	movs	r2, r3
c0d046d4:	199b      	adds	r3, r3, r6
c0d046d6:	c220      	stmia	r2!, {r5}
c0d046d8:	4293      	cmp	r3, r2
c0d046da:	d1fc      	bne.n	c0d046d6 <memset+0x6a>
c0d046dc:	2203      	movs	r2, #3
c0d046de:	4014      	ands	r4, r2
c0d046e0:	2c00      	cmp	r4, #0
c0d046e2:	d005      	beq.n	c0d046f0 <memset+0x84>
c0d046e4:	b2c9      	uxtb	r1, r1
c0d046e6:	191c      	adds	r4, r3, r4
c0d046e8:	7019      	strb	r1, [r3, #0]
c0d046ea:	3301      	adds	r3, #1
c0d046ec:	429c      	cmp	r4, r3
c0d046ee:	d1fb      	bne.n	c0d046e8 <memset+0x7c>
c0d046f0:	bd70      	pop	{r4, r5, r6, pc}
c0d046f2:	0014      	movs	r4, r2
c0d046f4:	0003      	movs	r3, r0
c0d046f6:	e7cc      	b.n	c0d04692 <memset+0x26>

c0d046f8 <setjmp>:
c0d046f8:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d046fa:	4641      	mov	r1, r8
c0d046fc:	464a      	mov	r2, r9
c0d046fe:	4653      	mov	r3, sl
c0d04700:	465c      	mov	r4, fp
c0d04702:	466d      	mov	r5, sp
c0d04704:	4676      	mov	r6, lr
c0d04706:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d04708:	3828      	subs	r0, #40	; 0x28
c0d0470a:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d0470c:	2000      	movs	r0, #0
c0d0470e:	4770      	bx	lr

c0d04710 <longjmp>:
c0d04710:	3010      	adds	r0, #16
c0d04712:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d04714:	4690      	mov	r8, r2
c0d04716:	4699      	mov	r9, r3
c0d04718:	46a2      	mov	sl, r4
c0d0471a:	46ab      	mov	fp, r5
c0d0471c:	46b5      	mov	sp, r6
c0d0471e:	c808      	ldmia	r0!, {r3}
c0d04720:	3828      	subs	r0, #40	; 0x28
c0d04722:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d04724:	1c08      	adds	r0, r1, #0
c0d04726:	d100      	bne.n	c0d0472a <longjmp+0x1a>
c0d04728:	2001      	movs	r0, #1
c0d0472a:	4718      	bx	r3

c0d0472c <strlen>:
c0d0472c:	b510      	push	{r4, lr}
c0d0472e:	0783      	lsls	r3, r0, #30
c0d04730:	d027      	beq.n	c0d04782 <strlen+0x56>
c0d04732:	7803      	ldrb	r3, [r0, #0]
c0d04734:	2b00      	cmp	r3, #0
c0d04736:	d026      	beq.n	c0d04786 <strlen+0x5a>
c0d04738:	0003      	movs	r3, r0
c0d0473a:	2103      	movs	r1, #3
c0d0473c:	e002      	b.n	c0d04744 <strlen+0x18>
c0d0473e:	781a      	ldrb	r2, [r3, #0]
c0d04740:	2a00      	cmp	r2, #0
c0d04742:	d01c      	beq.n	c0d0477e <strlen+0x52>
c0d04744:	3301      	adds	r3, #1
c0d04746:	420b      	tst	r3, r1
c0d04748:	d1f9      	bne.n	c0d0473e <strlen+0x12>
c0d0474a:	6819      	ldr	r1, [r3, #0]
c0d0474c:	4a0f      	ldr	r2, [pc, #60]	; (c0d0478c <strlen+0x60>)
c0d0474e:	4c10      	ldr	r4, [pc, #64]	; (c0d04790 <strlen+0x64>)
c0d04750:	188a      	adds	r2, r1, r2
c0d04752:	438a      	bics	r2, r1
c0d04754:	4222      	tst	r2, r4
c0d04756:	d10f      	bne.n	c0d04778 <strlen+0x4c>
c0d04758:	3304      	adds	r3, #4
c0d0475a:	6819      	ldr	r1, [r3, #0]
c0d0475c:	4a0b      	ldr	r2, [pc, #44]	; (c0d0478c <strlen+0x60>)
c0d0475e:	188a      	adds	r2, r1, r2
c0d04760:	438a      	bics	r2, r1
c0d04762:	4222      	tst	r2, r4
c0d04764:	d108      	bne.n	c0d04778 <strlen+0x4c>
c0d04766:	3304      	adds	r3, #4
c0d04768:	6819      	ldr	r1, [r3, #0]
c0d0476a:	4a08      	ldr	r2, [pc, #32]	; (c0d0478c <strlen+0x60>)
c0d0476c:	188a      	adds	r2, r1, r2
c0d0476e:	438a      	bics	r2, r1
c0d04770:	4222      	tst	r2, r4
c0d04772:	d0f1      	beq.n	c0d04758 <strlen+0x2c>
c0d04774:	e000      	b.n	c0d04778 <strlen+0x4c>
c0d04776:	3301      	adds	r3, #1
c0d04778:	781a      	ldrb	r2, [r3, #0]
c0d0477a:	2a00      	cmp	r2, #0
c0d0477c:	d1fb      	bne.n	c0d04776 <strlen+0x4a>
c0d0477e:	1a18      	subs	r0, r3, r0
c0d04780:	bd10      	pop	{r4, pc}
c0d04782:	0003      	movs	r3, r0
c0d04784:	e7e1      	b.n	c0d0474a <strlen+0x1e>
c0d04786:	2000      	movs	r0, #0
c0d04788:	e7fa      	b.n	c0d04780 <strlen+0x54>
c0d0478a:	46c0      	nop			; (mov r8, r8)
c0d0478c:	fefefeff 	.word	0xfefefeff
c0d04790:	80808080 	.word	0x80808080
c0d04794:	72646441 	.word	0x72646441
c0d04798:	00737365 	.word	0x00737365
c0d0479c:	72707041 	.word	0x72707041
c0d047a0:	0065766f 	.word	0x0065766f
c0d047a4:	656a6552 	.word	0x656a6552
c0d047a8:	00007463 	.word	0x00007463

c0d047ac <ux_display_public_flow_5_step_val>:
c0d047ac:	c0d04794 20001800                       .G..... 

c0d047b4 <ux_display_public_flow_5_step>:
c0d047b4:	c0d03fed c0d047ac 00000000 00000000     .?...G..........

c0d047c4 <ux_display_public_flow_6_step_validate_step>:
c0d047c4:	c0d00069 00000000 00000000 00000000     i...............

c0d047d4 <ux_display_public_flow_6_step_validate>:
c0d047d4:	c0d047c4 ffffffff                       .G......

c0d047dc <ux_display_public_flow_6_step_val>:
c0d047dc:	c0d049bc c0d0479c                       .I...G..

c0d047e4 <ux_display_public_flow_6_step>:
c0d047e4:	c0d040cd c0d047dc c0d047d4 00000000     .@...G...G......

c0d047f4 <ux_display_public_flow_7_step_validate_step>:
c0d047f4:	c0d00099 00000000 00000000 00000000     ................

c0d04804 <ux_display_public_flow_7_step_validate>:
c0d04804:	c0d047f4 ffffffff                       .G......

c0d0480c <ux_display_public_flow_7_step_val>:
c0d0480c:	c0d048cc c0d047a4                       .H...G..

c0d04814 <ux_display_public_flow_7_step>:
c0d04814:	c0d040cd c0d0480c c0d04804 00000000     .@...H...H......

c0d04824 <ux_display_public_flow>:
c0d04824:	c0d047b4 c0d047e4 c0d04814 ffffffff     .G...G...H......

c0d04834 <C_oneLedger_logo_colors>:
c0d04834:	00000000 00ffffff                       ........

c0d0483c <C_oneLedger_logo_bitmap>:
c0d0483c:	f3cfffff c003e187 c003c003 f3cfe187     ................
c0d0484c:	e187f3cf c003c003 e187c003 fffff3cf     ................

c0d0485c <C_oneLedger_logo>:
c0d0485c:	00000010 00000010 00000001 c0d04834     ............4H..
c0d0486c:	c0d0483c                                <H..

c0d04870 <C_icon_coggle_colors>:
c0d04870:	00000000 00ffffff                       ........

c0d04878 <C_icon_coggle_bitmap>:
c0d04878:	00000000 f80b400c f3c0fc07 03f03cf0     .....@.......<..
c0d04888:	002d01fe 00000003 00000000              ..-.........

c0d04894 <C_icon_coggle>:
c0d04894:	0000000e 0000000e 00000001 c0d04870     ............pH..
c0d048a4:	c0d04878                                xH..

c0d048a8 <C_icon_crossmark_colors>:
c0d048a8:	00000000 00ffffff                       ........

c0d048b0 <C_icon_crossmark_bitmap>:
c0d048b0:	e6018000 383871c0 1e00fc07 03f00780     .....q88........
c0d048c0:	38e1c1ce 00180670 00000000              ...8p.......

c0d048cc <C_icon_crossmark>:
c0d048cc:	0000000e 0000000e 00000001 c0d048a8     .............H..
c0d048dc:	c0d048b0                                .H..

c0d048e0 <C_icon_dashboard_x_colors>:
c0d048e0:	00000000 00ffffff                       ........

c0d048e8 <C_icon_dashboard_x_bitmap>:
c0d048e8:	00000000 f007800c ffc1fe03 03f03ff0     .............?..
c0d048f8:	c03300cc 0000000c 00000000              ..3.........

c0d04904 <C_icon_dashboard_x>:
c0d04904:	0000000e 0000000e 00000001 c0d048e0     .............H..
c0d04914:	c0d048e8                                .H..

c0d04918 <C_icon_down_colors>:
c0d04918:	00000000 00ffffff                       ........

c0d04920 <C_icon_down_bitmap>:
c0d04920:	01051141                                A...

c0d04924 <C_icon_down>:
c0d04924:	00000007 00000004 00000001 c0d04918     .............I..
c0d04934:	c0d04920                                 I..

c0d04938 <C_icon_left_colors>:
c0d04938:	00000000 00ffffff                       ........

c0d04940 <C_icon_left_bitmap>:
c0d04940:	08421248                                H.B.

c0d04944 <C_icon_left>:
c0d04944:	00000004 00000007 00000001 c0d04938     ............8I..
c0d04954:	c0d04940                                @I..

c0d04958 <C_icon_right_colors>:
c0d04958:	00000000 00ffffff                       ........

c0d04960 <C_icon_right_bitmap>:
c0d04960:	01248421                                !.$.

c0d04964 <C_icon_right>:
c0d04964:	00000004 00000007 00000001 c0d04958     ............XI..
c0d04974:	c0d04960                                `I..

c0d04978 <C_icon_up_colors>:
c0d04978:	00000000 00ffffff                       ........

c0d04980 <C_icon_up_bitmap>:
c0d04980:	08288a08                                ..(.

c0d04984 <C_icon_up>:
c0d04984:	00000007 00000004 00000001 c0d04978     ............xI..
c0d04994:	c0d04980                                .I..

c0d04998 <C_icon_validate_14_colors>:
c0d04998:	00000000 00ffffff                       ........

c0d049a0 <C_icon_validate_14_bitmap>:
c0d049a0:	00000000 00c00000 e0670038 039c1c38     ........8.g.8...
c0d049b0:	800f007e 00000001 00000000              ~...........

c0d049bc <C_icon_validate_14>:
c0d049bc:	0000000e 0000000e 00000001 c0d04998     .............I..
c0d049cc:	c0d049a0 59006f4e 42007365 006b6361     .I..No.Yes.Back.
c0d049dc:	4c656e4f 65676465 73690072 61657220     OneLedger.is rea
c0d049ec:	53007964 69747465 0073676e 73726556     dy.Settings.Vers
c0d049fc:	006e6f69 2e302e31 75510030 00007469     ion.1.0.0.Quit..

c0d04a0c <ux_idle_flow_1_step_val>:
c0d04a0c:	c0d0485c c0d049dc c0d049e6              \H...I...I..

c0d04a18 <ux_idle_flow_1_step>:
c0d04a18:	c0d041dd c0d04a0c 00000000 00000000     .A...J..........

c0d04a28 <ux_idle_flow_2_step_validate_step>:
c0d04a28:	c0d00a85 00000000 00000000 00000000     ................

c0d04a38 <ux_idle_flow_2_step_validate>:
c0d04a38:	c0d04a28 ffffffff                       (J......

c0d04a40 <ux_idle_flow_2_step_val>:
c0d04a40:	c0d04894 c0d049ef                       .H...I..

c0d04a48 <ux_idle_flow_2_step>:
c0d04a48:	c0d040cd c0d04a40 c0d04a38 00000000     .@..@J..8J......

c0d04a58 <ux_idle_flow_3_step_val>:
c0d04a58:	c0d049f8 c0d04a00                       .I...J..

c0d04a60 <ux_idle_flow_3_step>:
c0d04a60:	c0d03c51 c0d04a58 00000000 00000000     Q<..XJ..........

c0d04a70 <ux_idle_flow_4_step_validate_step>:
c0d04a70:	c0d00aa1 00000000 00000000 00000000     ................

c0d04a80 <ux_idle_flow_4_step_validate>:
c0d04a80:	c0d04a70 ffffffff                       pJ......

c0d04a88 <ux_idle_flow_4_step_val>:
c0d04a88:	c0d04904 c0d04a06                       .I...J..

c0d04a90 <ux_idle_flow_4_step>:
c0d04a90:	c0d040cd c0d04a88 c0d04a80 00000000     .@...J...J......

c0d04aa0 <ux_idle_flow>:
c0d04aa0:	c0d04a18 c0d04a48 c0d04a60 c0d04a90     .J..HJ..`J...J..
c0d04ab0:	fffffffd ffffffff 000001b0 00a7b000     ................
c0d04ac0:	02b00000 30000000                                .......

c0d04ac7 <g_pcHex>:
c0d04ac7:	33323130 37363534 62613938 66656463     0123456789abcdef

c0d04ad7 <g_pcHex_cap>:
c0d04ad7:	33323130 37363534 42413938 46454443     0123456789ABCDEF
c0d04ae7:	6e676953 72757461 69530065 6e696e67     Signature.Signin
c0d04af7:	72542067 61736e61 6f697463 2e2e2e6e     g Transaction...
c0d04b07:	6f6d4100 00746e75 69636552 6e656970     .Amount.Recipien
c0d04b17:	64412074 46007264 3c206565 3e544c4f     t Addr.Fee <OLT>
	...

c0d04b28 <ux_display_sign_flow_1_step_val>:
c0d04b28:	c0d04ae7 c0d04af1                       .J...J..

c0d04b30 <ux_display_sign_flow_1_step>:
c0d04b30:	c0d03fed c0d04b28 00000000 00000000     .?..(K..........

c0d04b40 <ux_display_sign_amount_step_val>:
c0d04b40:	c0d04b08 20001ca0                       .K..... 

c0d04b48 <ux_display_sign_amount_step>:
c0d04b48:	c0d03fed c0d04b40 00000000 00000000     .?..@K..........

c0d04b58 <ux_display_sign_recipient_step_val>:
c0d04b58:	c0d04b0f 20001cc0                       .K..... 

c0d04b60 <ux_display_sign_recipient_step>:
c0d04b60:	c0d03fed c0d04b58 00000000 00000000     .?..XK..........

c0d04b70 <ux_display_sign_fee_step_val>:
c0d04b70:	c0d04b1e 20001d00                       .K..... 

c0d04b78 <ux_display_sign_fee_step>:
c0d04b78:	c0d03fed c0d04b70 00000000 00000000     .?..pK..........

c0d04b88 <ux_display_sign_flow_2_step_validate_step>:
c0d04b88:	c0d018bd 00000000 00000000 00000000     ................

c0d04b98 <ux_display_sign_flow_2_step_validate>:
c0d04b98:	c0d04b88 ffffffff                       .K......

c0d04ba0 <ux_display_sign_flow_2_step_val>:
c0d04ba0:	c0d049bc c0d0479c                       .I...G..

c0d04ba8 <ux_display_sign_flow_2_step>:
c0d04ba8:	c0d040cd c0d04ba0 c0d04b98 00000000     .@...K...K......

c0d04bb8 <ux_display_sign_flow_3_step_validate_step>:
c0d04bb8:	c0d018e9 00000000 00000000 00000000     ................

c0d04bc8 <ux_display_sign_flow_3_step_validate>:
c0d04bc8:	c0d04bb8 ffffffff                       .K......

c0d04bd0 <ux_display_sign_flow_3_step_val>:
c0d04bd0:	c0d048cc c0d047a4                       .H...G..

c0d04bd8 <ux_display_sign_flow_3_step>:
c0d04bd8:	c0d040cd c0d04bd0 c0d04bc8 00000000     .@...K...K......

c0d04be8 <ux_display_sign_flow>:
c0d04be8:	c0d04b30 c0d04ba8 c0d04bd8 ffffffff     0K...K...K......

c0d04bf8 <ux_display_send_flow>:
c0d04bf8:	c0d04b30 c0d04b48 c0d04b60 c0d04b78     0K..HK..`K..xK..
c0d04c08:	c0d04ba8 c0d04bd8 ffffffff              .K...K......

c0d04c14 <SW_INTERNAL>:
c0d04c14:	0190006f                                         o.

c0d04c16 <SW_BUSY>:
c0d04c16:	00670190                                         ..

c0d04c18 <SW_WRONG_LENGTH>:
c0d04c18:	85690067                                         g.

c0d04c1a <SW_PROOF_OF_PRESENCE_REQUIRED>:
c0d04c1a:	d0f18569 00000000 4c494f42 90009000     i.......BOIL....
	...

c0d04c2c <SW_BAD_KEY_HANDLE>:
c0d04c2c:	3255806a                                         j.

c0d04c2e <U2F_VERSION>:
c0d04c2e:	5f463255 00903256                       U2F_V2..

c0d04c36 <INFO>:
c0d04c36:	00900901                                ....

c0d04c3a <SW_UNKNOWN_CLASS>:
c0d04c3a:	006d006e                                         n.

c0d04c3c <SW_UNKNOWN_INSTRUCTION>:
c0d04c3c:	ffff006d                                         m.

c0d04c3e <BROADCAST_CHANNEL>:
c0d04c3e:	ffffffff                                ....

c0d04c42 <FORBIDDEN_CHANNEL>:
c0d04c42:	00000000 21090000                                ......

c0d04c48 <USBD_HID_Desc_fido>:
c0d04c48:	01112109 22220121 00000000              .!..!.""....

c0d04c54 <USBD_HID_Desc>:
c0d04c54:	01112109 22220100 f1d00600                       .!...."".

c0d04c5d <HID_ReportDesc_fido>:
c0d04c5d:	09f1d006 0901a101 26001503 087500ff     ...........&..u.
c0d04c6d:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d04c7d:	a006c008                                         ..

c0d04c7f <HID_ReportDesc>:
c0d04c7f:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d04c8f:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d04c9f:	0317c008                                         ..

c0d04ca1 <C_webusb_url_descriptor>:
c0d04ca1:	77010317 6c2e7777 65676465 6c617772     ...www.ledgerwal
c0d04cb1:	2e74656c 056d6f63                                let.com

c0d04cb8 <C_usb_bos>:
c0d04cb8:	00390f05 05101802 08b63800 a009a934     ..9......8..4...
c0d04cc8:	a0fd8b47 b6158876 1e010065 05101c01     G...v...e.......
c0d04cd8:	dd60df00 c74589d8 65d29c4c 8a649e9d     ..`...E.L..e..d.
c0d04ce8:	0300009f 7700b206 00000000              .......w....

c0d04cf4 <HID_Desc>:
c0d04cf4:	c0d033e1 c0d033f1 c0d03401 c0d03411     .3...3...4...4..
c0d04d04:	c0d03421 c0d03431 c0d03441 c0d03451     !4..14..A4..Q4..

c0d04d14 <C_winusb_string_descriptor>:
c0d04d14:	004d0312 00460053 00310054 00300030     ..M.S.F.T.1.0.0.
c0d04d24:	00920077                                         w.

c0d04d26 <C_winusb_guid>:
c0d04d26:	00000092 00050100 00880001 00070000     ................
c0d04d36:	002a0000 00650044 00690076 00650063     ..*.D.e.v.i.c.e.
c0d04d46:	006e0049 00650074 00660072 00630061     I.n.t.e.r.f.a.c.
c0d04d56:	00470065 00490055 00730044 00500000     e.G.U.I.D.s...P.
c0d04d66:	007b0000 00330031 00360064 00340033     ..{.1.3.d.6.3.4.
c0d04d76:	00300030 0032002d 00390043 002d0037     0.0.-.2.C.9.7.-.
c0d04d86:	00300030 00340030 0030002d 00300030     0.0.0.4.-.0.0.0.
c0d04d96:	002d0030 00630034 00350036 00340036     0.-.4.c.6.5.6.4.
c0d04da6:	00370036 00350036 00320037 0000007d     6.7.6.5.7.2.}...
	...

c0d04db8 <C_winusb_request_descriptor>:
c0d04db8:	0000000a 06030000 000800b2 00000001     ................
c0d04dc8:	000800a8 00020002 001400a0 49570003     ..............WI
c0d04dd8:	4253554e 00000000 00000000 00840000     NUSB............
c0d04de8:	00070004 0044002a 00760065 00630069     ....*.D.e.v.i.c.
c0d04df8:	00490065 0074006e 00720065 00610066     e.I.n.t.e.r.f.a.
c0d04e08:	00650063 00550047 00440049 00000073     c.e.G.U.I.D.s...
c0d04e18:	007b0050 00450043 00300038 00320039     P.{.C.E.8.0.9.2.
c0d04e28:	00340036 0034002d 00320042 002d0034     6.4.-.4.B.2.4.-.
c0d04e38:	00450034 00310038 0041002d 00420038     4.E.8.1.-.A.8.B.
c0d04e48:	002d0032 00370035 00440045 00310030     2.-.5.7.E.D.0.1.
c0d04e58:	00350044 00300038 00310045 0000007d     D.5.8.0.E.1.}...
c0d04e68:	00000000                                ....

c0d04e6c <USBD_HID>:
c0d04e6c:	c0d0318d c0d031bf c0d030f7 00000000     .1...1...0......
c0d04e7c:	00000000 c0d032e5 c0d032fd 00000000     .....2...2......
	...
c0d04e94:	c0d035dd c0d035dd c0d035dd c0d035ed     .5...5...5...5..

c0d04ea4 <USBD_U2F>:
c0d04ea4:	c0d0326d c0d031bf c0d030f7 00000000     m2...1...0......
c0d04eb4:	00000000 c0d032a1 c0d032b9 00000000     .....2...2......
	...
c0d04ecc:	c0d035dd c0d035dd c0d035dd c0d035ed     .5...5...5...5..

c0d04edc <USBD_WEBUSB>:
c0d04edc:	c0d03349 c0d03375 c0d03379 00000000     I3..u3..y3......
c0d04eec:	00000000 c0d0337d c0d03395 00000000     ....}3...3......
	...
c0d04f04:	c0d035dd c0d035dd c0d035dd c0d035ed     .5...5...5...5..

c0d04f14 <USBD_DeviceDesc>:
c0d04f14:	02100112 40000000 10152c97 02010201     .......@.,......
c0d04f24:	03040103                                         ..

c0d04f26 <USBD_LangIDDesc>:
c0d04f26:	04090304                                ....

c0d04f2a <USBD_MANUFACTURER_STRING>:
c0d04f2a:	004c030e 00640065 00650067 030e0072              ..L.e.d.g.e.r.

c0d04f38 <USBD_PRODUCT_FS_STRING>:
c0d04f38:	004e030e 006e0061 0020006f 030a0053              ..N.a.n.o. .S.

c0d04f46 <USB_SERIAL_STRING>:
c0d04f46:	0030030a 00300030 00280031                       ..0.0.0.1.

c0d04f50 <C_winusb_wcid>:
c0d04f50:	00000028 00040100 00000001 00000000     (...............
c0d04f60:	49570102 4253554e 00000000 00000000     ..WINUSB........
	...

c0d04f78 <USBD_CfgDesc>:
c0d04f78:	00600209 c0020103 00040932 00030200     ..`.....2.......
c0d04f88:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d04f98:	05070100 00400302 01040901 01030200     ......@.........
c0d04fa8:	21090201 01210111 07002222 40038105     ...!..!."".....@
c0d04fb8:	05070100 00400301 02040901 ffff0200     ......@.........
c0d04fc8:	050702ff 00400383 03050701 01004003     ......@......@..

c0d04fd8 <USBD_DeviceQualifierDesc>:
c0d04fd8:	0200060a 40000000 31300001 35343332     .......@..012345
c0d04fe8:	39383736 64636261 00006665              6789abcdef..

c0d04ff4 <derivePath>:
c0d04ff4:	8000002c 80000193 80000000 80000000     ,...............
c0d05004:	80000000                                ....

c0d05008 <ux_layout_bb_elements>:
c0d05008:	00000003 00800000 00000020 00000001     ........ .......
c0d05018:	00000000 00ffffff 00000000 00000000     ................
c0d05028:	00020105 0004000c 00000007 00000000     ................
c0d05038:	00ffffff 00000000 00000000 c0d04944     ............DI..
c0d05048:	007a0205 0004000c 00000007 00000000     ..z.............
c0d05058:	00ffffff 00000000 00000000 c0d04964     ............dI..
c0d05068:	00001007 0080000c 00000020 00000000     ........ .......
c0d05078:	00ffffff 00000000 00008008 00000000     ................
c0d05088:	00001107 0080001a 00000020 00000000     ........ .......
c0d05098:	00ffffff 00000000 00008008 00000000     ................

c0d050a8 <ux_layout_nnbnn_elements>:
c0d050a8:	00000003 00800000 00000020 00000001     ........ .......
c0d050b8:	00000000 00ffffff 00000000 00000000     ................
c0d050c8:	00000105 0007000e 00000004 00000000     ................
c0d050d8:	00ffffff 00000000 00000000 c0d04984     .............I..
c0d050e8:	00780205 0007000e 00000004 00000000     ..x.............
c0d050f8:	00ffffff 00000000 00000000 c0d04924     ............$I..
c0d05108:	00001107 00800003 00000020 00000000     ........ .......
c0d05118:	00ffffff 00000000 0000800a 00000000     ................
c0d05128:	00001207 00800013 00000020 00000000     ........ .......
c0d05138:	00ffffff 00000000 00008008 00000000     ................
c0d05148:	00001307 00800023 00000020 00000000     ....#... .......
c0d05158:	00ffffff 00000000 0000800a 00000000     ................
c0d05168:	28207325 252f6425 25002964 64250073     %s (%d/%d).%s.%d
c0d05178:	0064252f 732a2e25 00000000              /%d.%.*s....

c0d05184 <ux_layout_pb_elements>:
c0d05184:	00000003 00800000 00000020 00000001     ........ .......
c0d05194:	00000000 00ffffff 00000000 00000000     ................
c0d051a4:	00020105 0004000c 00000007 00000000     ................
c0d051b4:	00ffffff 00000000 00000000 c0d04944     ............DI..
c0d051c4:	007a0205 0004000c 00000007 00000000     ..z.............
c0d051d4:	00ffffff 00000000 00000000 c0d04964     ............dI..
c0d051e4:	00381005 00100002 00000010 00000000     ..8.............
c0d051f4:	00ffffff 00000000 0000800a 00000000     ................
c0d05204:	00001107 0080001c 00000020 00000000     ........ .......
c0d05214:	00ffffff 00000000 00008008 00000000     ................

c0d05224 <ux_layout_pbb_elements>:
c0d05224:	00000003 00800000 00000020 00000001     ........ .......
c0d05234:	00000000 00ffffff 00000000 00000000     ................
c0d05244:	00020105 0004000c 00000007 00000000     ................
c0d05254:	00ffffff 00000000 00000000 c0d04944     ............DI..
c0d05264:	007a0205 0004000c 00000007 00000000     ..z.............
c0d05274:	00ffffff 00000000 00000000 c0d04964     ............dI..
c0d05284:	00100f05 00100008 00000010 00000000     ................
c0d05294:	00ffffff 00000000 00000000 00000000     ................
c0d052a4:	00291007 0080000c 00000020 00000000     ..)..... .......
c0d052b4:	00ffffff 00000000 00000008 00000000     ................
c0d052c4:	00291107 0080001a 00000020 00000000     ..)..... .......
c0d052d4:	00ffffff 00000000 00000008 00000000     ................

c0d052e4 <ux_menulist_conststep>:
c0d052e4:	c0d042cd 20001950 00000000 00000000     .B..P.. ........

c0d052f4 <ux_menulist_constflow>:
c0d052f4:	c0d052e4 ffffffff                       .R......

c0d052fc <_etext>:
c0d052fc:	00000000 	.word	0x00000000

c0d05300 <N_storage_real>:
	...
