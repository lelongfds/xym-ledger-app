
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
        }
    }
    END_TRY_L(exit);
}

__attribute__((section(".boot"))) int main(void) {
c0d00000:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00002:	b08d      	sub	sp, #52	; 0x34
    // exit critical section
    __asm volatile("cpsie i");
c0d00004:	b662      	cpsie	i

    raw_tx_ix = 0;
	hashTainted = 1;
c0d00006:	481b      	ldr	r0, [pc, #108]	; (c0d00074 <main+0x74>)
c0d00008:	2101      	movs	r1, #1
c0d0000a:	7001      	strb	r1, [r0, #0]

__attribute__((section(".boot"))) int main(void) {
    // exit critical section
    __asm volatile("cpsie i");

    raw_tx_ix = 0;
c0d0000c:	481a      	ldr	r0, [pc, #104]	; (c0d00078 <main+0x78>)
c0d0000e:	2100      	movs	r1, #0
c0d00010:	6001      	str	r1, [r0, #0]
	hashTainted = 1;

    // ensure exception will work as planned
    os_boot();
c0d00012:	f001 f91b 	bl	c0d0124c <os_boot>
c0d00016:	4c19      	ldr	r4, [pc, #100]	; (c0d0007c <main+0x7c>)
c0d00018:	4d19      	ldr	r5, [pc, #100]	; (c0d00080 <main+0x80>)
c0d0001a:	2600      	movs	r6, #0
c0d0001c:	2212      	movs	r2, #18

    for (;;) {
	    os_memset(&txContent, 0, sizeof(txContent));
c0d0001e:	4620      	mov	r0, r4
c0d00020:	4631      	mov	r1, r6
c0d00022:	f001 f92e 	bl	c0d01282 <os_memset>
c0d00026:	21fc      	movs	r1, #252	; 0xfc
	
        UX_INIT();
c0d00028:	4628      	mov	r0, r5
c0d0002a:	f004 f90f 	bl	c0d0424c <__aeabi_memclr>
c0d0002e:	f004 f86d 	bl	c0d0410c <ux_stack_push>
c0d00032:	af01      	add	r7, sp, #4
        BEGIN_TRY {
            TRY {
c0d00034:	4638      	mov	r0, r7
c0d00036:	f004 f99f 	bl	c0d04378 <setjmp>
c0d0003a:	85b8      	strh	r0, [r7, #44]	; 0x2c
c0d0003c:	b287      	uxth	r7, r0
c0d0003e:	2f00      	cmp	r7, #0
c0d00040:	d00b      	beq.n	c0d0005a <main+0x5a>
c0d00042:	a801      	add	r0, sp, #4
c0d00044:	8586      	strh	r6, [r0, #44]	; 0x2c
c0d00046:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00048:	f002 f99e 	bl	c0d02388 <try_context_set>
c0d0004c:	2f10      	cmp	r7, #16
c0d0004e:	d0e4      	beq.n	c0d0001a <main+0x1a>
            FINALLY {
            }
        }
        END_TRY;
    }
    app_exit();
c0d00050:	f001 f82e 	bl	c0d010b0 <app_exit>
c0d00054:	2000      	movs	r0, #0

    return 0;
c0d00056:	b00d      	add	sp, #52	; 0x34
c0d00058:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0005a:	a801      	add	r0, sp, #4
    for (;;) {
	    os_memset(&txContent, 0, sizeof(txContent));
	
        UX_INIT();
        BEGIN_TRY {
            TRY {
c0d0005c:	f002 f994 	bl	c0d02388 <try_context_set>
c0d00060:	900b      	str	r0, [sp, #44]	; 0x2c
                io_seproxyhal_init();
c0d00062:	f001 fa65 	bl	c0d01530 <io_seproxyhal_init>
c0d00066:	2001      	movs	r0, #1

                USB_power(1);
c0d00068:	f003 fda2 	bl	c0d03bb0 <USB_power>

                ui_idle();
c0d0006c:	f000 f944 	bl	c0d002f8 <ui_idle>
                nem_main();
c0d00070:	f000 fcc0 	bl	c0d009f4 <nem_main>
c0d00074:	20001d68 	.word	0x20001d68
c0d00078:	20001d6c 	.word	0x20001d6c
c0d0007c:	20001d56 	.word	0x20001d56
c0d00080:	2000182c 	.word	0x2000182c

c0d00084 <base32_encode>:
*  limitations under the License.
********************************************************************************/

#include "base32.h"

int base32_encode(const uint8_t *data, int length, char *result, int bufSize) {
c0d00084:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00086:	b085      	sub	sp, #20
c0d00088:	461e      	mov	r6, r3
c0d0008a:	9204      	str	r2, [sp, #16]
c0d0008c:	4604      	mov	r4, r0
c0d0008e:	2700      	movs	r7, #0
c0d00090:	43f8      	mvns	r0, r7
c0d00092:	2201      	movs	r2, #1
c0d00094:	0713      	lsls	r3, r2, #28
    int count = 0;
    int quantum = 8;

    if (length < 0 || length > (1 << 28)) {
c0d00096:	4299      	cmp	r1, r3
c0d00098:	d84f      	bhi.n	c0d0013a <base32_encode+0xb6>
        return -1;
    }

    if (length > 0) {
c0d0009a:	2900      	cmp	r1, #0
c0d0009c:	d047      	beq.n	c0d0012e <base32_encode+0xaa>
c0d0009e:	2e01      	cmp	r6, #1
c0d000a0:	db45      	blt.n	c0d0012e <base32_encode+0xaa>
c0d000a2:	9001      	str	r0, [sp, #4]
c0d000a4:	9402      	str	r4, [sp, #8]
        int buffer = data[0];
c0d000a6:	7820      	ldrb	r0, [r4, #0]
c0d000a8:	2508      	movs	r5, #8
c0d000aa:	2700      	movs	r7, #0
c0d000ac:	462c      	mov	r4, r5
c0d000ae:	9603      	str	r6, [sp, #12]
        int next = 1;
        int bitsLeft = 8;

        while (count < bufSize && (bitsLeft > 0 || next < length)) {
c0d000b0:	428a      	cmp	r2, r1
c0d000b2:	db01      	blt.n	c0d000b8 <base32_encode+0x34>
c0d000b4:	2d01      	cmp	r5, #1
c0d000b6:	db1f      	blt.n	c0d000f8 <base32_encode+0x74>
            if (bitsLeft < 5) {
c0d000b8:	2d04      	cmp	r5, #4
c0d000ba:	dc0c      	bgt.n	c0d000d6 <base32_encode+0x52>
                if (next < length) {
c0d000bc:	428a      	cmp	r2, r1
c0d000be:	da06      	bge.n	c0d000ce <base32_encode+0x4a>
                    buffer <<= 8;
                    buffer |= data[next++] & 0xFF;
c0d000c0:	9b02      	ldr	r3, [sp, #8]
c0d000c2:	5c9e      	ldrb	r6, [r3, r2]
        int bitsLeft = 8;

        while (count < bufSize && (bitsLeft > 0 || next < length)) {
            if (bitsLeft < 5) {
                if (next < length) {
                    buffer <<= 8;
c0d000c4:	0203      	lsls	r3, r0, #8
                    buffer |= data[next++] & 0xFF;
c0d000c6:	1998      	adds	r0, r3, r6
                    bitsLeft += 8;
c0d000c8:	3508      	adds	r5, #8

        while (count < bufSize && (bitsLeft > 0 || next < length)) {
            if (bitsLeft < 5) {
                if (next < length) {
                    buffer <<= 8;
                    buffer |= data[next++] & 0xFF;
c0d000ca:	1c52      	adds	r2, r2, #1
c0d000cc:	e003      	b.n	c0d000d6 <base32_encode+0x52>
c0d000ce:	2605      	movs	r6, #5
                    bitsLeft += 8;
                } else {
                    int pad = 5 - bitsLeft;
c0d000d0:	1b75      	subs	r5, r6, r5
                    buffer <<= pad;
c0d000d2:	40a8      	lsls	r0, r5
c0d000d4:	4635      	mov	r5, r6
                    bitsLeft += pad;
                }
            }

            int index = 0x1F & (buffer >> (bitsLeft - 5));
c0d000d6:	1f6d      	subs	r5, r5, #5
c0d000d8:	4606      	mov	r6, r0
c0d000da:	412e      	asrs	r6, r5
c0d000dc:	231f      	movs	r3, #31
c0d000de:	4033      	ands	r3, r6
            bitsLeft -= 5;
            //result[count++] = "0123456789ABCDEFGHJKLMNPQRSTUVXY"[index];
            result[count++] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"[index];
c0d000e0:	4e17      	ldr	r6, [pc, #92]	; (c0d00140 <base32_encode+0xbc>)
c0d000e2:	447e      	add	r6, pc
c0d000e4:	5cf3      	ldrb	r3, [r6, r3]
c0d000e6:	9e04      	ldr	r6, [sp, #16]
c0d000e8:	55f3      	strb	r3, [r6, r7]

            // Track the characters which make up a single quantum of 8 characters
            quantum--;
c0d000ea:	1e64      	subs	r4, r4, #1
            if (quantum == 0) {
c0d000ec:	d100      	bne.n	c0d000f0 <base32_encode+0x6c>
c0d000ee:	2408      	movs	r4, #8
c0d000f0:	9e03      	ldr	r6, [sp, #12]
            }

            int index = 0x1F & (buffer >> (bitsLeft - 5));
            bitsLeft -= 5;
            //result[count++] = "0123456789ABCDEFGHJKLMNPQRSTUVXY"[index];
            result[count++] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"[index];
c0d000f2:	1c7f      	adds	r7, r7, #1
    if (length > 0) {
        int buffer = data[0];
        int next = 1;
        int bitsLeft = 8;

        while (count < bufSize && (bitsLeft > 0 || next < length)) {
c0d000f4:	42b7      	cmp	r7, r6
c0d000f6:	dbdb      	blt.n	c0d000b0 <base32_encode+0x2c>
                quantum = 8;
            }
        }

        // If the number of encoded characters does not make a full quantum, insert padding
        if (quantum != 8) {
c0d000f8:	2c08      	cmp	r4, #8
c0d000fa:	d017      	beq.n	c0d0012c <base32_encode+0xa8>
            while (quantum > 0 && count < bufSize) {
c0d000fc:	2c01      	cmp	r4, #1
c0d000fe:	db15      	blt.n	c0d0012c <base32_encode+0xa8>
c0d00100:	42b7      	cmp	r7, r6
c0d00102:	da13      	bge.n	c0d0012c <base32_encode+0xa8>
                result[count++] = '=';
c0d00104:	9804      	ldr	r0, [sp, #16]
c0d00106:	19c0      	adds	r0, r0, r7
c0d00108:	1bba      	subs	r2, r7, r6
c0d0010a:	4261      	negs	r1, r4
c0d0010c:	428a      	cmp	r2, r1
c0d0010e:	d300      	bcc.n	c0d00112 <base32_encode+0x8e>
c0d00110:	4611      	mov	r1, r2
c0d00112:	4249      	negs	r1, r1
c0d00114:	223d      	movs	r2, #61	; 0x3d
c0d00116:	f004 f8a3 	bl	c0d04260 <__aeabi_memset>
c0d0011a:	1e61      	subs	r1, r4, #1
c0d0011c:	9801      	ldr	r0, [sp, #4]
c0d0011e:	1c7f      	adds	r7, r7, #1
            }
        }

        // If the number of encoded characters does not make a full quantum, insert padding
        if (quantum != 8) {
            while (quantum > 0 && count < bufSize) {
c0d00120:	2901      	cmp	r1, #1
c0d00122:	db04      	blt.n	c0d0012e <base32_encode+0xaa>
c0d00124:	1e49      	subs	r1, r1, #1
c0d00126:	42b7      	cmp	r7, r6
c0d00128:	dbf9      	blt.n	c0d0011e <base32_encode+0x9a>
c0d0012a:	e000      	b.n	c0d0012e <base32_encode+0xaa>
c0d0012c:	9801      	ldr	r0, [sp, #4]
            }
        }
    }

    // Finally check if we exceeded buffer size.
    if (count < bufSize) {
c0d0012e:	42b7      	cmp	r7, r6
c0d00130:	da03      	bge.n	c0d0013a <base32_encode+0xb6>
c0d00132:	2000      	movs	r0, #0
        result[count] = '\000';
c0d00134:	9904      	ldr	r1, [sp, #16]
c0d00136:	55c8      	strb	r0, [r1, r7]
c0d00138:	4638      	mov	r0, r7
        return count;
    } else {
        return -1;
    }
c0d0013a:	b005      	add	sp, #20
c0d0013c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0013e:	46c0      	nop			; (mov r8, r8)
c0d00140:	0000432e 	.word	0x0000432e

c0d00144 <cx_hash_X>:
}

int cx_hash_X(cx_hash_t *hash ,
              int mode,
              unsigned char WIDE *in , unsigned int len,
              unsigned char *out) {
c0d00144:	b570      	push	{r4, r5, r6, lr}
c0d00146:	b082      	sub	sp, #8
   unsigned int hsz = 0;

    switch (hash->algo) {
c0d00148:	7804      	ldrb	r4, [r0, #0]
c0d0014a:	2c05      	cmp	r4, #5
c0d0014c:	dc07      	bgt.n	c0d0015e <cx_hash_X+0x1a>
c0d0014e:	2c02      	cmp	r4, #2
c0d00150:	dd0d      	ble.n	c0d0016e <cx_hash_X+0x2a>
c0d00152:	2c03      	cmp	r4, #3
c0d00154:	d01c      	beq.n	c0d00190 <cx_hash_X+0x4c>
c0d00156:	2c04      	cmp	r4, #4
c0d00158:	d11c      	bne.n	c0d00194 <cx_hash_X+0x50>
c0d0015a:	2430      	movs	r4, #48	; 0x30
c0d0015c:	e010      	b.n	c0d00180 <cx_hash_X+0x3c>
c0d0015e:	2c08      	cmp	r4, #8
c0d00160:	dc09      	bgt.n	c0d00176 <cx_hash_X+0x32>
c0d00162:	1fa5      	subs	r5, r4, #6
c0d00164:	2d02      	cmp	r5, #2
c0d00166:	d30a      	bcc.n	c0d0017e <cx_hash_X+0x3a>
c0d00168:	2c08      	cmp	r4, #8
c0d0016a:	d008      	beq.n	c0d0017e <cx_hash_X+0x3a>
c0d0016c:	e01a      	b.n	c0d001a4 <cx_hash_X+0x60>
c0d0016e:	2c01      	cmp	r4, #1
c0d00170:	d114      	bne.n	c0d0019c <cx_hash_X+0x58>
c0d00172:	2414      	movs	r4, #20
c0d00174:	e004      	b.n	c0d00180 <cx_hash_X+0x3c>
c0d00176:	2c09      	cmp	r4, #9
c0d00178:	d001      	beq.n	c0d0017e <cx_hash_X+0x3a>
c0d0017a:	2c0b      	cmp	r4, #11
c0d0017c:	d112      	bne.n	c0d001a4 <cx_hash_X+0x60>
c0d0017e:	6884      	ldr	r4, [r0, #8]
c0d00180:	9d06      	ldr	r5, [sp, #24]
    default:
        THROW(INVALID_PARAMETER);
        return 0;
    }

    return cx_hash(hash, mode, in, len, out, hsz);
c0d00182:	466e      	mov	r6, sp
c0d00184:	6035      	str	r5, [r6, #0]
c0d00186:	6074      	str	r4, [r6, #4]
c0d00188:	f001 ffe6 	bl	c0d02158 <cx_hash>
c0d0018c:	b002      	add	sp, #8
c0d0018e:	bd70      	pop	{r4, r5, r6, pc}
c0d00190:	2420      	movs	r4, #32
c0d00192:	e7f5      	b.n	c0d00180 <cx_hash_X+0x3c>
              int mode,
              unsigned char WIDE *in , unsigned int len,
              unsigned char *out) {
   unsigned int hsz = 0;

    switch (hash->algo) {
c0d00194:	2c05      	cmp	r4, #5
c0d00196:	d105      	bne.n	c0d001a4 <cx_hash_X+0x60>
c0d00198:	2440      	movs	r4, #64	; 0x40
c0d0019a:	e7f1      	b.n	c0d00180 <cx_hash_X+0x3c>
c0d0019c:	2c02      	cmp	r4, #2
c0d0019e:	d101      	bne.n	c0d001a4 <cx_hash_X+0x60>
c0d001a0:	241c      	movs	r4, #28
c0d001a2:	e7ed      	b.n	c0d00180 <cx_hash_X+0x3c>
c0d001a4:	2002      	movs	r0, #2
        break;  
    case CX_BLAKE2B:
        hsz =   ((cx_blake2b_t*)hash)->output_size;
        break;
    default:
        THROW(INVALID_PARAMETER);
c0d001a6:	f001 f88b 	bl	c0d012c0 <os_longjmp>

c0d001aa <cx_ecfp_get_domain_length>:
    exponent[3] = pub_exponent>>0;

    return cx_rsa_generate_pair(modulus_len, public_key, private_key, exponent, 4, externalPQ);
}

static unsigned int cx_ecfp_get_domain_length(cx_curve_t curve) {
c0d001aa:	b580      	push	{r7, lr}
c0d001ac:	4601      	mov	r1, r0
c0d001ae:	2020      	movs	r0, #32
    switch(curve) {
c0d001b0:	2928      	cmp	r1, #40	; 0x28
c0d001b2:	dd0b      	ble.n	c0d001cc <cx_ecfp_get_domain_length+0x22>
c0d001b4:	292c      	cmp	r1, #44	; 0x2c
c0d001b6:	dd15      	ble.n	c0d001e4 <cx_ecfp_get_domain_length+0x3a>
c0d001b8:	2941      	cmp	r1, #65	; 0x41
c0d001ba:	dd2a      	ble.n	c0d00212 <cx_ecfp_get_domain_length+0x68>
c0d001bc:	2942      	cmp	r1, #66	; 0x42
c0d001be:	d02d      	beq.n	c0d0021c <cx_ecfp_get_domain_length+0x72>
c0d001c0:	2961      	cmp	r1, #97	; 0x61
c0d001c2:	d02a      	beq.n	c0d0021a <cx_ecfp_get_domain_length+0x70>
c0d001c4:	2962      	cmp	r1, #98	; 0x62
c0d001c6:	d12b      	bne.n	c0d00220 <cx_ecfp_get_domain_length+0x76>
c0d001c8:	2038      	movs	r0, #56	; 0x38
    default:
        break;
    }
    THROW(INVALID_PARAMETER);
    return 0;
}
c0d001ca:	bd80      	pop	{r7, pc}

    return cx_rsa_generate_pair(modulus_len, public_key, private_key, exponent, 4, externalPQ);
}

static unsigned int cx_ecfp_get_domain_length(cx_curve_t curve) {
    switch(curve) {
c0d001cc:	460a      	mov	r2, r1
c0d001ce:	2924      	cmp	r1, #36	; 0x24
c0d001d0:	dc10      	bgt.n	c0d001f4 <cx_ecfp_get_domain_length+0x4a>
c0d001d2:	3a21      	subs	r2, #33	; 0x21
c0d001d4:	2a02      	cmp	r2, #2
c0d001d6:	d320      	bcc.n	c0d0021a <cx_ecfp_get_domain_length+0x70>
c0d001d8:	2923      	cmp	r1, #35	; 0x23
c0d001da:	d009      	beq.n	c0d001f0 <cx_ecfp_get_domain_length+0x46>
c0d001dc:	2924      	cmp	r1, #36	; 0x24
c0d001de:	d11f      	bne.n	c0d00220 <cx_ecfp_get_domain_length+0x76>
c0d001e0:	2042      	movs	r0, #66	; 0x42
    default:
        break;
    }
    THROW(INVALID_PARAMETER);
    return 0;
}
c0d001e2:	bd80      	pop	{r7, pc}

    return cx_rsa_generate_pair(modulus_len, public_key, private_key, exponent, 4, externalPQ);
}

static unsigned int cx_ecfp_get_domain_length(cx_curve_t curve) {
    switch(curve) {
c0d001e4:	292a      	cmp	r1, #42	; 0x2a
c0d001e6:	dc0e      	bgt.n	c0d00206 <cx_ecfp_get_domain_length+0x5c>
c0d001e8:	2929      	cmp	r1, #41	; 0x29
c0d001ea:	d001      	beq.n	c0d001f0 <cx_ecfp_get_domain_length+0x46>
c0d001ec:	292a      	cmp	r1, #42	; 0x2a
c0d001ee:	d117      	bne.n	c0d00220 <cx_ecfp_get_domain_length+0x76>
c0d001f0:	2030      	movs	r0, #48	; 0x30
    default:
        break;
    }
    THROW(INVALID_PARAMETER);
    return 0;
}
c0d001f2:	bd80      	pop	{r7, pc}

    return cx_rsa_generate_pair(modulus_len, public_key, private_key, exponent, 4, externalPQ);
}

static unsigned int cx_ecfp_get_domain_length(cx_curve_t curve) {
    switch(curve) {
c0d001f4:	3a25      	subs	r2, #37	; 0x25
c0d001f6:	2a02      	cmp	r2, #2
c0d001f8:	d30f      	bcc.n	c0d0021a <cx_ecfp_get_domain_length+0x70>
c0d001fa:	2927      	cmp	r1, #39	; 0x27
c0d001fc:	d001      	beq.n	c0d00202 <cx_ecfp_get_domain_length+0x58>
c0d001fe:	2928      	cmp	r1, #40	; 0x28
c0d00200:	d10e      	bne.n	c0d00220 <cx_ecfp_get_domain_length+0x76>
c0d00202:	2028      	movs	r0, #40	; 0x28
    default:
        break;
    }
    THROW(INVALID_PARAMETER);
    return 0;
}
c0d00204:	bd80      	pop	{r7, pc}

    return cx_rsa_generate_pair(modulus_len, public_key, private_key, exponent, 4, externalPQ);
}

static unsigned int cx_ecfp_get_domain_length(cx_curve_t curve) {
    switch(curve) {
c0d00206:	292b      	cmp	r1, #43	; 0x2b
c0d00208:	d001      	beq.n	c0d0020e <cx_ecfp_get_domain_length+0x64>
c0d0020a:	292c      	cmp	r1, #44	; 0x2c
c0d0020c:	d108      	bne.n	c0d00220 <cx_ecfp_get_domain_length+0x76>
c0d0020e:	2040      	movs	r0, #64	; 0x40
    default:
        break;
    }
    THROW(INVALID_PARAMETER);
    return 0;
}
c0d00210:	bd80      	pop	{r7, pc}

    return cx_rsa_generate_pair(modulus_len, public_key, private_key, exponent, 4, externalPQ);
}

static unsigned int cx_ecfp_get_domain_length(cx_curve_t curve) {
    switch(curve) {
c0d00212:	292d      	cmp	r1, #45	; 0x2d
c0d00214:	d001      	beq.n	c0d0021a <cx_ecfp_get_domain_length+0x70>
c0d00216:	2941      	cmp	r1, #65	; 0x41
c0d00218:	d102      	bne.n	c0d00220 <cx_ecfp_get_domain_length+0x76>
    default:
        break;
    }
    THROW(INVALID_PARAMETER);
    return 0;
}
c0d0021a:	bd80      	pop	{r7, pc}
c0d0021c:	2039      	movs	r0, #57	; 0x39
c0d0021e:	bd80      	pop	{r7, pc}
c0d00220:	2002      	movs	r0, #2
    case CX_CURVE_Curve448:
        return 56;
    default:
        break;
    }
    THROW(INVALID_PARAMETER);
c0d00222:	f001 f84d 	bl	c0d012c0 <os_longjmp>

c0d00226 <cx_eddsa_sign_X>:
}

int cx_eddsa_sign_X(cx_ecfp_private_key_t WIDE *pv_key, 
                    int mode,  cx_md_t hashID,  unsigned char  WIDE *hash, unsigned int hash_len,
                    unsigned char  WIDE *ctx, unsigned int ctx_len,
                    unsigned char *sig, unsigned int *info) {
c0d00226:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00228:	b087      	sub	sp, #28
c0d0022a:	461c      	mov	r4, r3
c0d0022c:	4615      	mov	r5, r2
c0d0022e:	460e      	mov	r6, r1
c0d00230:	4607      	mov	r7, r0
    const unsigned int  domain_length =  cx_ecfp_get_domain_length(pv_key->curve);
c0d00232:	7800      	ldrb	r0, [r0, #0]
c0d00234:	f7ff ffb9 	bl	c0d001aa <cx_ecfp_get_domain_length>
c0d00238:	9910      	ldr	r1, [sp, #64]	; 0x40
    return cx_eddsa_sign(pv_key, mode, hashID, hash, hash_len, ctx, ctx_len, sig,  6+2*(domain_length+1), info);
c0d0023a:	466a      	mov	r2, sp
c0d0023c:	6151      	str	r1, [r2, #20]
c0d0023e:	0040      	lsls	r0, r0, #1
c0d00240:	3008      	adds	r0, #8
c0d00242:	6110      	str	r0, [r2, #16]
c0d00244:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d00246:	60d0      	str	r0, [r2, #12]
c0d00248:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d0024a:	6090      	str	r0, [r2, #8]
c0d0024c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0024e:	6050      	str	r0, [r2, #4]
c0d00250:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00252:	6010      	str	r0, [r2, #0]
c0d00254:	4638      	mov	r0, r7
c0d00256:	4631      	mov	r1, r6
c0d00258:	462a      	mov	r2, r5
c0d0025a:	4623      	mov	r3, r4
c0d0025c:	f001 ffcc 	bl	c0d021f8 <cx_eddsa_sign>
c0d00260:	b007      	add	sp, #28
c0d00262:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d00264 <ui_address_prepro>:
     NULL,
     NULL,
     NULL},
};

unsigned int ui_address_prepro(const bagl_element_t *element) {
c0d00264:	b570      	push	{r4, r5, r6, lr}
c0d00266:	4605      	mov	r5, r0
    if (element->component.userid > 0) {
c0d00268:	7840      	ldrb	r0, [r0, #1]
c0d0026a:	2401      	movs	r4, #1
c0d0026c:	2800      	cmp	r0, #0
c0d0026e:	d025      	beq.n	c0d002bc <ui_address_prepro+0x58>
        unsigned int display = (ux_step == element->component.userid - 1);
c0d00270:	1e41      	subs	r1, r0, #1
c0d00272:	4a1b      	ldr	r2, [pc, #108]	; (c0d002e0 <ui_address_prepro+0x7c>)
c0d00274:	6812      	ldr	r2, [r2, #0]
        if (display) {
c0d00276:	428a      	cmp	r2, r1
c0d00278:	d106      	bne.n	c0d00288 <ui_address_prepro+0x24>
            switch (element->component.userid) {
c0d0027a:	2802      	cmp	r0, #2
c0d0027c:	d006      	beq.n	c0d0028c <ui_address_prepro+0x28>
c0d0027e:	2801      	cmp	r0, #1
c0d00280:	d11c      	bne.n	c0d002bc <ui_address_prepro+0x58>
c0d00282:	207d      	movs	r0, #125	; 0x7d
c0d00284:	0100      	lsls	r0, r0, #4
c0d00286:	e017      	b.n	c0d002b8 <ui_address_prepro+0x54>
c0d00288:	2400      	movs	r4, #0
c0d0028a:	e017      	b.n	c0d002bc <ui_address_prepro+0x58>
                break;
            case 2:                
                //back home
                //UX_CALLBACK_SET_INTERVAL(MAX(
                //    3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));     
                if(maxInterval == 0){
c0d0028c:	4815      	ldr	r0, [pc, #84]	; (c0d002e4 <ui_address_prepro+0x80>)
c0d0028e:	6801      	ldr	r1, [r0, #0]
c0d00290:	2900      	cmp	r1, #0
c0d00292:	d015      	beq.n	c0d002c0 <ui_address_prepro+0x5c>
                    // Send back the response, do not restart the event loop
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
                    ui_idle();

                }else{
                    maxInterval--;
c0d00294:	6801      	ldr	r1, [r0, #0]
c0d00296:	1e49      	subs	r1, r1, #1
c0d00298:	6001      	str	r1, [r0, #0]
c0d0029a:	2107      	movs	r1, #7
                    UX_CALLBACK_SET_INTERVAL(MAX(
c0d0029c:	4628      	mov	r0, r5
c0d0029e:	f001 f9ff 	bl	c0d016a0 <bagl_label_roundtrip_duration_ms>
c0d002a2:	217d      	movs	r1, #125	; 0x7d
c0d002a4:	00ce      	lsls	r6, r1, #3
c0d002a6:	1981      	adds	r1, r0, r6
c0d002a8:	480f      	ldr	r0, [pc, #60]	; (c0d002e8 <ui_address_prepro+0x84>)
c0d002aa:	4281      	cmp	r1, r0
c0d002ac:	d304      	bcc.n	c0d002b8 <ui_address_prepro+0x54>
c0d002ae:	2107      	movs	r1, #7
c0d002b0:	4628      	mov	r0, r5
c0d002b2:	f001 f9f5 	bl	c0d016a0 <bagl_label_roundtrip_duration_ms>
c0d002b6:	1980      	adds	r0, r0, r6
c0d002b8:	490c      	ldr	r1, [pc, #48]	; (c0d002ec <ui_address_prepro+0x88>)
c0d002ba:	63c8      	str	r0, [r1, #60]	; 0x3c
            }
        }
        return display;
    }
    return 1;
}
c0d002bc:	4620      	mov	r0, r4
c0d002be:	bd70      	pop	{r4, r5, r6, pc}
            case 2:                
                //back home
                //UX_CALLBACK_SET_INTERVAL(MAX(
                //    3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));     
                if(maxInterval == 0){
                    G_io_apdu_buffer[0] = 0x69; //0x9000 timeout
c0d002c0:	480b      	ldr	r0, [pc, #44]	; (c0d002f0 <ui_address_prepro+0x8c>)
c0d002c2:	2185      	movs	r1, #133	; 0x85
                    G_io_apdu_buffer[1] = 0x85;
c0d002c4:	7041      	strb	r1, [r0, #1]
c0d002c6:	2169      	movs	r1, #105	; 0x69
            case 2:                
                //back home
                //UX_CALLBACK_SET_INTERVAL(MAX(
                //    3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));     
                if(maxInterval == 0){
                    G_io_apdu_buffer[0] = 0x69; //0x9000 timeout
c0d002c8:	7001      	strb	r1, [r0, #0]
c0d002ca:	2020      	movs	r0, #32
c0d002cc:	2102      	movs	r1, #2
                    G_io_apdu_buffer[1] = 0x85;
                    // Send back the response, do not restart the event loop
                    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d002ce:	f001 fa67 	bl	c0d017a0 <io_exchange>

#endif // #if defined(TARGET_NANOS)

void ui_idle(void) {
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d002d2:	4908      	ldr	r1, [pc, #32]	; (c0d002f4 <ui_address_prepro+0x90>)
c0d002d4:	4479      	add	r1, pc
c0d002d6:	2000      	movs	r0, #0
c0d002d8:	4602      	mov	r2, r0
c0d002da:	f003 fe83 	bl	c0d03fe4 <ux_menu_display>
c0d002de:	e7ed      	b.n	c0d002bc <ui_address_prepro+0x58>
c0d002e0:	20001828 	.word	0x20001828
c0d002e4:	20001928 	.word	0x20001928
c0d002e8:	00000bb8 	.word	0x00000bb8
c0d002ec:	2000182c 	.word	0x2000182c
c0d002f0:	20001df4 	.word	0x20001df4
c0d002f4:	00004308 	.word	0x00004308

c0d002f8 <ui_idle>:
unsigned int ui_approval_nanos_button(unsigned int button_mask,
                                      unsigned int button_mask_counter);

#endif // #if defined(TARGET_NANOS)

void ui_idle(void) {
c0d002f8:	b580      	push	{r7, lr}
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d002fa:	4903      	ldr	r1, [pc, #12]	; (c0d00308 <ui_idle+0x10>)
c0d002fc:	4479      	add	r1, pc
c0d002fe:	2000      	movs	r0, #0
c0d00300:	4602      	mov	r2, r0
c0d00302:	f003 fe6f 	bl	c0d03fe4 <ux_menu_display>
#endif // #if TARGET_ID
}
c0d00306:	bd80      	pop	{r7, pc}
c0d00308:	000042e0 	.word	0x000042e0

c0d0030c <ui_approval_prepro>:
unsigned int ui_approval_prepro(const bagl_element_t *element) {
    unsigned int display = 1;
    return display;
}*/

unsigned int ui_approval_prepro(const bagl_element_t *element) {
c0d0030c:	b570      	push	{r4, r5, r6, lr}
c0d0030e:	4605      	mov	r5, r0
    unsigned int display = 1;
    if (element->component.userid > 0) {
c0d00310:	7841      	ldrb	r1, [r0, #1]
c0d00312:	2001      	movs	r0, #1
c0d00314:	2900      	cmp	r1, #0
c0d00316:	d013      	beq.n	c0d00340 <ui_approval_prepro+0x34>
        // display the meta element when at least bigger
        display = (ux_step == element->component.userid - 1) || (element->component.userid >= 0x02 && ux_step >= 1);
c0d00318:	4e2d      	ldr	r6, [pc, #180]	; (c0d003d0 <ui_approval_prepro+0xc4>)
c0d0031a:	6832      	ldr	r2, [r6, #0]
c0d0031c:	1e4b      	subs	r3, r1, #1
c0d0031e:	429a      	cmp	r2, r3
c0d00320:	d004      	beq.n	c0d0032c <ui_approval_prepro+0x20>
c0d00322:	2400      	movs	r4, #0
        if (display) {
c0d00324:	2902      	cmp	r1, #2
c0d00326:	d30c      	bcc.n	c0d00342 <ui_approval_prepro+0x36>
c0d00328:	2a00      	cmp	r2, #0
c0d0032a:	d00a      	beq.n	c0d00342 <ui_approval_prepro+0x36>
            switch (element->component.userid) {
c0d0032c:	2912      	cmp	r1, #18
c0d0032e:	d01c      	beq.n	c0d0036a <ui_approval_prepro+0x5e>
c0d00330:	2902      	cmp	r1, #2
c0d00332:	d01a      	beq.n	c0d0036a <ui_approval_prepro+0x5e>
c0d00334:	2901      	cmp	r1, #1
c0d00336:	d103      	bne.n	c0d00340 <ui_approval_prepro+0x34>
c0d00338:	217d      	movs	r1, #125	; 0x7d
c0d0033a:	0109      	lsls	r1, r1, #4
            case 0x01:                           
                UX_CALLBACK_SET_INTERVAL(2000);                
c0d0033c:	4a29      	ldr	r2, [pc, #164]	; (c0d003e4 <ui_approval_prepro+0xd8>)
c0d0033e:	63d1      	str	r1, [r2, #60]	; 0x3c
c0d00340:	4604      	mov	r4, r0
                    3000, 1000 + bagl_label_roundtrip_duration_ms(&tmp_element, 7)));
                return &tmp_element;
            }
        }      
    }
    if(maxInterval < 0) { //back home     
c0d00342:	4826      	ldr	r0, [pc, #152]	; (c0d003dc <ui_approval_prepro+0xd0>)
c0d00344:	6800      	ldr	r0, [r0, #0]
c0d00346:	2800      	cmp	r0, #0
c0d00348:	da3d      	bge.n	c0d003c6 <ui_approval_prepro+0xba>
        G_io_apdu_buffer[0] = 0x69; //0x9000 timeout
c0d0034a:	4827      	ldr	r0, [pc, #156]	; (c0d003e8 <ui_approval_prepro+0xdc>)
c0d0034c:	2185      	movs	r1, #133	; 0x85
        G_io_apdu_buffer[1] = 0x85;
c0d0034e:	7041      	strb	r1, [r0, #1]
c0d00350:	2169      	movs	r1, #105	; 0x69
                return &tmp_element;
            }
        }      
    }
    if(maxInterval < 0) { //back home     
        G_io_apdu_buffer[0] = 0x69; //0x9000 timeout
c0d00352:	7001      	strb	r1, [r0, #0]
c0d00354:	2020      	movs	r0, #32
c0d00356:	2102      	movs	r1, #2
        G_io_apdu_buffer[1] = 0x85;
        // Send back the response, do not restart the event loop
        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d00358:	f001 fa22 	bl	c0d017a0 <io_exchange>

#endif // #if defined(TARGET_NANOS)

void ui_idle(void) {
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d0035c:	4923      	ldr	r1, [pc, #140]	; (c0d003ec <ui_approval_prepro+0xe0>)
c0d0035e:	4479      	add	r1, pc
c0d00360:	2000      	movs	r0, #0
c0d00362:	4602      	mov	r2, r0
c0d00364:	f003 fe3e 	bl	c0d03fe4 <ux_menu_display>
c0d00368:	e02d      	b.n	c0d003c6 <ui_approval_prepro+0xba>
            case 0x01:                           
                UX_CALLBACK_SET_INTERVAL(2000);                
                break;
            case 0x02:
            case 0x12:
                os_memmove(&tmp_element, element, sizeof(bagl_element_t));                
c0d0036a:	4c1a      	ldr	r4, [pc, #104]	; (c0d003d4 <ui_approval_prepro+0xc8>)
c0d0036c:	2220      	movs	r2, #32
c0d0036e:	4620      	mov	r0, r4
c0d00370:	4629      	mov	r1, r5
c0d00372:	f000 ff70 	bl	c0d01256 <os_memmove>
                display = ux_step - 1;
c0d00376:	6830      	ldr	r0, [r6, #0]
                switch(display) {
c0d00378:	1e81      	subs	r1, r0, #2
c0d0037a:	290b      	cmp	r1, #11
c0d0037c:	d225      	bcs.n	c0d003ca <ui_approval_prepro+0xbe>
                    case 7:                     
                    case 8:                     
                    case 9:                   
                    case 10:                     
                    case 11:                     
                        if (display == (ux_step_count - 1)) {
c0d0037e:	4916      	ldr	r1, [pc, #88]	; (c0d003d8 <ui_approval_prepro+0xcc>)
c0d00380:	6809      	ldr	r1, [r1, #0]
c0d00382:	4288      	cmp	r0, r1
c0d00384:	d103      	bne.n	c0d0038e <ui_approval_prepro+0x82>
                            maxInterval--;//back home 
c0d00386:	4915      	ldr	r1, [pc, #84]	; (c0d003dc <ui_approval_prepro+0xd0>)
c0d00388:	680a      	ldr	r2, [r1, #0]
c0d0038a:	1e52      	subs	r2, r2, #1
c0d0038c:	600a      	str	r2, [r1, #0]
c0d0038e:	1e40      	subs	r0, r0, #1
                os_memmove(&tmp_element, element, sizeof(bagl_element_t));                
                display = ux_step - 1;
                switch(display) {
                    case 0:
                    display_detail:
                        tmp_element.text = ui_approval_details[display][(element->component.userid)>>4];
c0d00390:	00c0      	lsls	r0, r0, #3
c0d00392:	4917      	ldr	r1, [pc, #92]	; (c0d003f0 <ui_approval_prepro+0xe4>)
c0d00394:	4479      	add	r1, pc
c0d00396:	1808      	adds	r0, r1, r0
c0d00398:	7869      	ldrb	r1, [r5, #1]
c0d0039a:	0909      	lsrs	r1, r1, #4
c0d0039c:	0089      	lsls	r1, r1, #2
c0d0039e:	5840      	ldr	r0, [r0, r1]
c0d003a0:	61e0      	str	r0, [r4, #28]
                        if (display == (ux_step_count - 1)) {
                            maxInterval--;//back home 
                        }                     
                        goto display_detail;
                }                                    
                UX_CALLBACK_SET_INTERVAL(MAX(
c0d003a2:	4c0c      	ldr	r4, [pc, #48]	; (c0d003d4 <ui_approval_prepro+0xc8>)
c0d003a4:	2107      	movs	r1, #7
c0d003a6:	4620      	mov	r0, r4
c0d003a8:	f001 f97a 	bl	c0d016a0 <bagl_label_roundtrip_duration_ms>
c0d003ac:	217d      	movs	r1, #125	; 0x7d
c0d003ae:	00cd      	lsls	r5, r1, #3
c0d003b0:	1941      	adds	r1, r0, r5
c0d003b2:	480b      	ldr	r0, [pc, #44]	; (c0d003e0 <ui_approval_prepro+0xd4>)
c0d003b4:	4281      	cmp	r1, r0
c0d003b6:	d304      	bcc.n	c0d003c2 <ui_approval_prepro+0xb6>
c0d003b8:	4806      	ldr	r0, [pc, #24]	; (c0d003d4 <ui_approval_prepro+0xc8>)
c0d003ba:	2107      	movs	r1, #7
c0d003bc:	f001 f970 	bl	c0d016a0 <bagl_label_roundtrip_duration_ms>
c0d003c0:	1940      	adds	r0, r0, r5
c0d003c2:	4908      	ldr	r1, [pc, #32]	; (c0d003e4 <ui_approval_prepro+0xd8>)
c0d003c4:	63c8      	str	r0, [r1, #60]	; 0x3c
        // Send back the response, do not restart the event loop
        io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
        ui_idle();        
    }
    return display;
}
c0d003c6:	4620      	mov	r0, r4
c0d003c8:	bd70      	pop	{r4, r5, r6, pc}
                break;
            case 0x02:
            case 0x12:
                os_memmove(&tmp_element, element, sizeof(bagl_element_t));                
                display = ux_step - 1;
                switch(display) {
c0d003ca:	2801      	cmp	r0, #1
c0d003cc:	d0df      	beq.n	c0d0038e <ui_approval_prepro+0x82>
c0d003ce:	e7e8      	b.n	c0d003a2 <ui_approval_prepro+0x96>
c0d003d0:	20001828 	.word	0x20001828
c0d003d4:	20001a9c 	.word	0x20001a9c
c0d003d8:	20001abc 	.word	0x20001abc
c0d003dc:	20001928 	.word	0x20001928
c0d003e0:	00000bb8 	.word	0x00000bb8
c0d003e4:	2000182c 	.word	0x2000182c
c0d003e8:	20001df4 	.word	0x20001df4
c0d003ec:	0000427e 	.word	0x0000427e
c0d003f0:	00004398 	.word	0x00004398

c0d003f4 <io_seproxyhal_touch_address_ok>:
    // Go back to the dashboard
    os_sched_exit(0);
    return 0; // do not redraw the widget
}

unsigned int io_seproxyhal_touch_address_ok(const bagl_element_t *e) {
c0d003f4:	b570      	push	{r4, r5, r6, lr}
uint32_t set_result_get_publicKey() {
    uint32_t tx = 0;
    uint32_t addressLength = sizeof(tmpCtx.publicKeyContext.address);

    //address
    G_io_apdu_buffer[tx++] = addressLength;
c0d003f6:	4e12      	ldr	r6, [pc, #72]	; (c0d00440 <io_seproxyhal_touch_address_ok+0x4c>)
c0d003f8:	2228      	movs	r2, #40	; 0x28
c0d003fa:	7032      	strb	r2, [r6, #0]
    os_memmove(G_io_apdu_buffer + tx, tmpCtx.publicKeyContext.address, addressLength);
c0d003fc:	1c70      	adds	r0, r6, #1
c0d003fe:	4d11      	ldr	r5, [pc, #68]	; (c0d00444 <io_seproxyhal_touch_address_ok+0x50>)
c0d00400:	4629      	mov	r1, r5
c0d00402:	316e      	adds	r1, #110	; 0x6e
c0d00404:	f000 ff27 	bl	c0d01256 <os_memmove>
c0d00408:	2029      	movs	r0, #41	; 0x29
c0d0040a:	2420      	movs	r4, #32
    tx += addressLength;

    //publicKey
    G_io_apdu_buffer[tx++] = 32;
c0d0040c:	5434      	strb	r4, [r6, r0]
    os_memmove(G_io_apdu_buffer + tx, tmpCtx.publicKeyContext.nemPublicKey, 32);
c0d0040e:	4630      	mov	r0, r6
c0d00410:	302a      	adds	r0, #42	; 0x2a
c0d00412:	354e      	adds	r5, #78	; 0x4e
c0d00414:	4629      	mov	r1, r5
c0d00416:	4622      	mov	r2, r4
c0d00418:	f000 ff1d 	bl	c0d01256 <os_memmove>
c0d0041c:	204b      	movs	r0, #75	; 0x4b
c0d0041e:	2500      	movs	r5, #0
}

unsigned int io_seproxyhal_touch_address_ok(const bagl_element_t *e) {
    uint32_t tx = set_result_get_publicKey();
    G_io_apdu_buffer[tx++] = 0x90;
    G_io_apdu_buffer[tx++] = 0x00;
c0d00420:	5435      	strb	r5, [r6, r0]
c0d00422:	204a      	movs	r0, #74	; 0x4a
c0d00424:	2190      	movs	r1, #144	; 0x90
    return 0; // do not redraw the widget
}

unsigned int io_seproxyhal_touch_address_ok(const bagl_element_t *e) {
    uint32_t tx = set_result_get_publicKey();
    G_io_apdu_buffer[tx++] = 0x90;
c0d00426:	5431      	strb	r1, [r6, r0]
c0d00428:	214c      	movs	r1, #76	; 0x4c
    G_io_apdu_buffer[tx++] = 0x00;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d0042a:	4620      	mov	r0, r4
c0d0042c:	f001 f9b8 	bl	c0d017a0 <io_exchange>

#endif // #if defined(TARGET_NANOS)

void ui_idle(void) {
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d00430:	4905      	ldr	r1, [pc, #20]	; (c0d00448 <io_seproxyhal_touch_address_ok+0x54>)
c0d00432:	4479      	add	r1, pc
c0d00434:	4628      	mov	r0, r5
c0d00436:	462a      	mov	r2, r5
c0d00438:	f003 fdd4 	bl	c0d03fe4 <ux_menu_display>
    G_io_apdu_buffer[tx++] = 0x00;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
    // Display back the original UX
    ui_idle();
    return 0; // do not redraw the widget
c0d0043c:	4628      	mov	r0, r5
c0d0043e:	bd70      	pop	{r4, r5, r6, pc}
c0d00440:	20001df4 	.word	0x20001df4
c0d00444:	20001ac0 	.word	0x20001ac0
c0d00448:	000041aa 	.word	0x000041aa

c0d0044c <ui_address_nanos_button>:
    return 0; // do not redraw the widget
}

#if defined(TARGET_NANOS)
unsigned int ui_address_nanos_button(unsigned int button_mask,
                                     unsigned int button_mask_counter) {
c0d0044c:	b580      	push	{r7, lr}
c0d0044e:	490d      	ldr	r1, [pc, #52]	; (c0d00484 <ui_address_nanos_button+0x38>)
    switch (button_mask) {
c0d00450:	4288      	cmp	r0, r1
c0d00452:	d012      	beq.n	c0d0047a <ui_address_nanos_button+0x2e>
c0d00454:	490c      	ldr	r1, [pc, #48]	; (c0d00488 <ui_address_nanos_button+0x3c>)
c0d00456:	4288      	cmp	r0, r1
c0d00458:	d111      	bne.n	c0d0047e <ui_address_nanos_button+0x32>
    ui_idle();
    return 0; // do not redraw the widget
}

unsigned int io_seproxyhal_touch_address_cancel(const bagl_element_t *e) {
    G_io_apdu_buffer[0] = 0x69;
c0d0045a:	480c      	ldr	r0, [pc, #48]	; (c0d0048c <ui_address_nanos_button+0x40>)
c0d0045c:	2185      	movs	r1, #133	; 0x85
    G_io_apdu_buffer[1] = 0x85;
c0d0045e:	7041      	strb	r1, [r0, #1]
c0d00460:	2169      	movs	r1, #105	; 0x69
    ui_idle();
    return 0; // do not redraw the widget
}

unsigned int io_seproxyhal_touch_address_cancel(const bagl_element_t *e) {
    G_io_apdu_buffer[0] = 0x69;
c0d00462:	7001      	strb	r1, [r0, #0]
c0d00464:	2020      	movs	r0, #32
c0d00466:	2102      	movs	r1, #2
    G_io_apdu_buffer[1] = 0x85;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d00468:	f001 f99a 	bl	c0d017a0 <io_exchange>

#endif // #if defined(TARGET_NANOS)

void ui_idle(void) {
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d0046c:	4908      	ldr	r1, [pc, #32]	; (c0d00490 <ui_address_nanos_button+0x44>)
c0d0046e:	4479      	add	r1, pc
c0d00470:	2000      	movs	r0, #0
c0d00472:	4602      	mov	r2, r0
c0d00474:	f003 fdb6 	bl	c0d03fe4 <ux_menu_display>
c0d00478:	e001      	b.n	c0d0047e <ui_address_nanos_button+0x32>
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // CANCEL
        io_seproxyhal_touch_address_cancel(NULL);
        break;

    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: { // OK
        io_seproxyhal_touch_address_ok(NULL);
c0d0047a:	f7ff ffbb 	bl	c0d003f4 <io_seproxyhal_touch_address_ok>
c0d0047e:	2000      	movs	r0, #0
        break;
    }
    }
    return 0;
c0d00480:	bd80      	pop	{r7, pc}
c0d00482:	46c0      	nop			; (mov r8, r8)
c0d00484:	80000002 	.word	0x80000002
c0d00488:	80000001 	.word	0x80000001
c0d0048c:	20001df4 	.word	0x20001df4
c0d00490:	0000416e 	.word	0x0000416e

c0d00494 <io_seproxyhal_touch_tx_ok>:
}
#endif // #if defined(TARGET_NANOS)

unsigned int io_seproxyhal_touch_tx_ok(const bagl_element_t *e) {
c0d00494:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00496:	b097      	sub	sp, #92	; 0x5c
    cx_ecfp_private_key_t privateKey;
    // cx_ecfp_public_key_t publicKey;
    uint32_t tx = 0;

    //Get keyseed
    os_perso_derive_node_bip32(CX_CURVE_256K1, tmpCtx.transactionContext.bip32Path, tmpCtx.transactionContext.pathLength, privateKeyData, NULL);    
c0d00498:	4d28      	ldr	r5, [pc, #160]	; (c0d0053c <io_seproxyhal_touch_tx_ok+0xa8>)
c0d0049a:	782a      	ldrb	r2, [r5, #0]
c0d0049c:	2600      	movs	r6, #0
c0d0049e:	4668      	mov	r0, sp
c0d004a0:	6006      	str	r6, [r0, #0]
c0d004a2:	4629      	mov	r1, r5
c0d004a4:	3124      	adds	r1, #36	; 0x24
c0d004a6:	2021      	movs	r0, #33	; 0x21
c0d004a8:	ac0f      	add	r4, sp, #60	; 0x3c
c0d004aa:	4623      	mov	r3, r4
c0d004ac:	f001 fedc 	bl	c0d02268 <os_perso_derive_node_bip32>
c0d004b0:	2041      	movs	r0, #65	; 0x41
c0d004b2:	2220      	movs	r2, #32
c0d004b4:	ab05      	add	r3, sp, #20
    
    // cx_ecfp_init_public_key(CX_CURVE_Ed25519, NULL, 0, &publicKey);
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, &privateKey);
c0d004b6:	4621      	mov	r1, r4
c0d004b8:	f001 fe7c 	bl	c0d021b4 <cx_ecfp_init_private_key>
c0d004bc:	2005      	movs	r0, #5
    tmpCtx.transactionContext.algo = CX_SHA3;
    tmpCtx.transactionContext.algo = CX_SHA512;
c0d004be:	70a8      	strb	r0, [r5, #2]
    
    //signature 128
    int index;
    PRINTF("priv: \n");
c0d004c0:	4821      	ldr	r0, [pc, #132]	; (c0d00548 <io_seproxyhal_touch_tx_ok+0xb4>)
c0d004c2:	4478      	add	r0, pc
c0d004c4:	f001 fc62 	bl	c0d01d8c <mcu_usb_printf>
c0d004c8:	4c20      	ldr	r4, [pc, #128]	; (c0d0054c <io_seproxyhal_touch_tx_ok+0xb8>)
c0d004ca:	447c      	add	r4, pc
c0d004cc:	a80f      	add	r0, sp, #60	; 0x3c
    for (index = 0; index < 32; index++) {
        PRINTF("%20x", privateKeyData[index]);
c0d004ce:	5d81      	ldrb	r1, [r0, r6]
c0d004d0:	4620      	mov	r0, r4
c0d004d2:	f001 fc5b 	bl	c0d01d8c <mcu_usb_printf>
    tmpCtx.transactionContext.algo = CX_SHA512;
    
    //signature 128
    int index;
    PRINTF("priv: \n");
    for (index = 0; index < 32; index++) {
c0d004d6:	1c76      	adds	r6, r6, #1
c0d004d8:	2e20      	cmp	r6, #32
c0d004da:	d1f7      	bne.n	c0d004cc <io_seproxyhal_touch_tx_ok+0x38>
        PRINTF("%20x", privateKeyData[index]);
    }
    // tmpCtx.publicKeyContext.algo = CX_SHA512;

    G_io_apdu_buffer[tx++] = 128;
c0d004dc:	4f18      	ldr	r7, [pc, #96]	; (c0d00540 <io_seproxyhal_touch_tx_ok+0xac>)
c0d004de:	2080      	movs	r0, #128	; 0x80
c0d004e0:	7038      	strb	r0, [r7, #0]
    tx = cx_eddsa_sign(&privateKey, 
c0d004e2:	78aa      	ldrb	r2, [r5, #2]
c0d004e4:	6ba8      	ldr	r0, [r5, #56]	; 0x38
c0d004e6:	2400      	movs	r4, #0
c0d004e8:	4669      	mov	r1, sp
c0d004ea:	c111      	stmia	r1!, {r0, r4}
c0d004ec:	600c      	str	r4, [r1, #0]
c0d004ee:	604f      	str	r7, [r1, #4]
c0d004f0:	608c      	str	r4, [r1, #8]
c0d004f2:	4b14      	ldr	r3, [pc, #80]	; (c0d00544 <io_seproxyhal_touch_tx_ok+0xb0>)
c0d004f4:	3315      	adds	r3, #21
c0d004f6:	ae05      	add	r6, sp, #20
c0d004f8:	2101      	movs	r1, #1
c0d004fa:	4630      	mov	r0, r6
c0d004fc:	f7ff fe93 	bl	c0d00226 <cx_eddsa_sign_X>
c0d00500:	4605      	mov	r5, r0
c0d00502:	2228      	movs	r2, #40	; 0x28
                       G_io_apdu_buffer, 
                       NULL);
    // cx_ecfp_generate_pair2(CX_CURVE_Ed25519, &publicKey, &privateKey, 1, tmpCtx.transactionContext.algo);

    //public 64
    os_memset(&privateKey, 0, sizeof(privateKey));
c0d00504:	4630      	mov	r0, r6
c0d00506:	4621      	mov	r1, r4
c0d00508:	f000 febb 	bl	c0d01282 <os_memset>
c0d0050c:	a80f      	add	r0, sp, #60	; 0x3c
c0d0050e:	2620      	movs	r6, #32
    os_memset(privateKeyData, 0, sizeof(privateKeyData));
c0d00510:	4621      	mov	r1, r4
c0d00512:	4632      	mov	r2, r6
c0d00514:	f000 feb5 	bl	c0d01282 <os_memset>
c0d00518:	2090      	movs	r0, #144	; 0x90

    G_io_apdu_buffer[tx++] = 0x90;
c0d0051a:	5578      	strb	r0, [r7, r5]
    for (index = 0; index < 32; index++) {
        PRINTF("%20x", privateKeyData[index]);
    }
    // tmpCtx.publicKeyContext.algo = CX_SHA512;

    G_io_apdu_buffer[tx++] = 128;
c0d0051c:	1978      	adds	r0, r7, r5
    //public 64
    os_memset(&privateKey, 0, sizeof(privateKey));
    os_memset(privateKeyData, 0, sizeof(privateKeyData));

    G_io_apdu_buffer[tx++] = 0x90;
    G_io_apdu_buffer[tx++] = 0x00;
c0d0051e:	7044      	strb	r4, [r0, #1]
    
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00520:	1ca8      	adds	r0, r5, #2
c0d00522:	b281      	uxth	r1, r0
c0d00524:	4630      	mov	r0, r6
c0d00526:	f001 f93b 	bl	c0d017a0 <io_exchange>

#endif // #if defined(TARGET_NANOS)

void ui_idle(void) {
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d0052a:	4909      	ldr	r1, [pc, #36]	; (c0d00550 <io_seproxyhal_touch_tx_ok+0xbc>)
c0d0052c:	4479      	add	r1, pc
c0d0052e:	4620      	mov	r0, r4
c0d00530:	4622      	mov	r2, r4
c0d00532:	f003 fd57 	bl	c0d03fe4 <ux_menu_display>
    
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
    // Display back the original UX
    ui_idle();
    return 0; // do not redraw the widget
c0d00536:	4620      	mov	r0, r4
c0d00538:	b017      	add	sp, #92	; 0x5c
c0d0053a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0053c:	20001ac0 	.word	0x20001ac0
c0d00540:	20001df4 	.word	0x20001df4
c0d00544:	20001b6c 	.word	0x20001b6c
c0d00548:	00004083 	.word	0x00004083
c0d0054c:	00004083 	.word	0x00004083
c0d00550:	000040b0 	.word	0x000040b0

c0d00554 <ui_approval_nanos_button>:
}

#if defined(TARGET_NANOS)

unsigned int ui_approval_nanos_button(unsigned int button_mask,
                                      unsigned int button_mask_counter) {
c0d00554:	b580      	push	{r7, lr}
c0d00556:	490d      	ldr	r1, [pc, #52]	; (c0d0058c <ui_approval_nanos_button+0x38>)
    switch (button_mask) {
c0d00558:	4288      	cmp	r0, r1
c0d0055a:	d012      	beq.n	c0d00582 <ui_approval_nanos_button+0x2e>
c0d0055c:	490c      	ldr	r1, [pc, #48]	; (c0d00590 <ui_approval_nanos_button+0x3c>)
c0d0055e:	4288      	cmp	r0, r1
c0d00560:	d111      	bne.n	c0d00586 <ui_approval_nanos_button+0x32>
    ui_idle();
    return 0; // do not redraw the widget
}

unsigned int io_seproxyhal_touch_tx_cancel(const bagl_element_t *e) {
    G_io_apdu_buffer[0] = 0x69;
c0d00562:	480c      	ldr	r0, [pc, #48]	; (c0d00594 <ui_approval_nanos_button+0x40>)
c0d00564:	2185      	movs	r1, #133	; 0x85
    G_io_apdu_buffer[1] = 0x85;
c0d00566:	7041      	strb	r1, [r0, #1]
c0d00568:	2169      	movs	r1, #105	; 0x69
    ui_idle();
    return 0; // do not redraw the widget
}

unsigned int io_seproxyhal_touch_tx_cancel(const bagl_element_t *e) {
    G_io_apdu_buffer[0] = 0x69;
c0d0056a:	7001      	strb	r1, [r0, #0]
c0d0056c:	2020      	movs	r0, #32
c0d0056e:	2102      	movs	r1, #2
    G_io_apdu_buffer[1] = 0x85;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d00570:	f001 f916 	bl	c0d017a0 <io_exchange>

#endif // #if defined(TARGET_NANOS)

void ui_idle(void) {
#if defined(TARGET_NANOS)
    UX_MENU_DISPLAY(0, menu_main, NULL);
c0d00574:	4908      	ldr	r1, [pc, #32]	; (c0d00598 <ui_approval_nanos_button+0x44>)
c0d00576:	4479      	add	r1, pc
c0d00578:	2000      	movs	r0, #0
c0d0057a:	4602      	mov	r2, r0
c0d0057c:	f003 fd32 	bl	c0d03fe4 <ux_menu_display>
c0d00580:	e001      	b.n	c0d00586 <ui_approval_nanos_button+0x32>
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        io_seproxyhal_touch_tx_cancel(NULL);
        break;

    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: {
        io_seproxyhal_touch_tx_ok(NULL);
c0d00582:	f7ff ff87 	bl	c0d00494 <io_seproxyhal_touch_tx_ok>
c0d00586:	2000      	movs	r0, #0
        break;
    }
    }
    return 0;
c0d00588:	bd80      	pop	{r7, pc}
c0d0058a:	46c0      	nop			; (mov r8, r8)
c0d0058c:	80000002 	.word	0x80000002
c0d00590:	80000001 	.word	0x80000001
c0d00594:	20001df4 	.word	0x20001df4
c0d00598:	00004066 	.word	0x00004066

c0d0059c <io_exchange_al>:
}

#endif // #if defined(TARGET_NANOS)

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d0059c:	b5b0      	push	{r4, r5, r7, lr}
c0d0059e:	4605      	mov	r5, r0
c0d005a0:	2007      	movs	r0, #7
    switch (channel & ~(IO_FLAGS)) {
c0d005a2:	4028      	ands	r0, r5
c0d005a4:	2400      	movs	r4, #0
c0d005a6:	2801      	cmp	r0, #1
c0d005a8:	d012      	beq.n	c0d005d0 <io_exchange_al+0x34>
c0d005aa:	2802      	cmp	r0, #2
c0d005ac:	d112      	bne.n	c0d005d4 <io_exchange_al+0x38>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d005ae:	2900      	cmp	r1, #0
c0d005b0:	d007      	beq.n	c0d005c2 <io_exchange_al+0x26>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d005b2:	480a      	ldr	r0, [pc, #40]	; (c0d005dc <io_exchange_al+0x40>)
c0d005b4:	f001 feb4 	bl	c0d02320 <io_seph_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d005b8:	0628      	lsls	r0, r5, #24
c0d005ba:	d509      	bpl.n	c0d005d0 <io_exchange_al+0x34>
                reset();
c0d005bc:	f001 fdb4 	bl	c0d02128 <halt>
c0d005c0:	e006      	b.n	c0d005d0 <io_exchange_al+0x34>
c0d005c2:	21ff      	movs	r1, #255	; 0xff
c0d005c4:	3152      	adds	r1, #82	; 0x52
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d005c6:	4805      	ldr	r0, [pc, #20]	; (c0d005dc <io_exchange_al+0x40>)
c0d005c8:	2200      	movs	r2, #0
c0d005ca:	f001 fec1 	bl	c0d02350 <io_seph_recv>
c0d005ce:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d005d0:	4620      	mov	r0, r4
c0d005d2:	bdb0      	pop	{r4, r5, r7, pc}
c0d005d4:	2002      	movs	r0, #2
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d005d6:	f000 fe73 	bl	c0d012c0 <os_longjmp>
c0d005da:	46c0      	nop			; (mov r8, r8)
c0d005dc:	20001df4 	.word	0x20001df4

c0d005e0 <handleGetPublicKey>:
    return tx;
}

void handleGetPublicKey(uint8_t p1, uint8_t p2, uint8_t *dataBuffer,
                        uint16_t dataLength, volatile unsigned int *flags,
                        volatile unsigned int *tx) {
c0d005e0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d005e2:	b09d      	sub	sp, #116	; 0x74
    UNUSED(dataLength);
    uint8_t privateKeyData[32];
    uint32_t bip32Path[MAX_BIP32_PATH];
    uint32_t i;
    uint8_t bip32PathLength = *(dataBuffer++);
c0d005e4:	7810      	ldrb	r0, [r2, #0]

    //set default need confirm
    p1 = P1_CONFIRM;

    //bip32PathLength shold be 5
    if (bip32PathLength != MAX_BIP32_PATH) {
c0d005e6:	2805      	cmp	r0, #5
c0d005e8:	d000      	beq.n	c0d005ec <handleGetPublicKey+0xc>
c0d005ea:	e0c7      	b.n	c0d0077c <handleGetPublicKey+0x19c>
    }

    if ((p1 != P1_CONFIRM) && (p1 != P1_NON_CONFIRM)) {
        THROW(0x6B00);
    }
    if ((p2Chain != P2_CHAINCODE) && (p2Chain != P2_NO_CHAINCODE)) {
c0d005ec:	0688      	lsls	r0, r1, #26
c0d005ee:	0ec0      	lsrs	r0, r0, #27
c0d005f0:	d000      	beq.n	c0d005f4 <handleGetPublicKey+0x14>
c0d005f2:	e0c7      	b.n	c0d00784 <handleGetPublicKey+0x1a4>
c0d005f4:	9822      	ldr	r0, [sp, #136]	; 0x88
                        volatile unsigned int *tx) {
    UNUSED(dataLength);
    uint8_t privateKeyData[32];
    uint32_t bip32Path[MAX_BIP32_PATH];
    uint32_t i;
    uint8_t bip32PathLength = *(dataBuffer++);
c0d005f6:	9004      	str	r0, [sp, #16]
c0d005f8:	1c50      	adds	r0, r2, #1
c0d005fa:	2100      	movs	r1, #0
    if ((p2Chain != P2_CHAINCODE) && (p2Chain != P2_NO_CHAINCODE)) {
        THROW(0x6B00);
    }
   
    for (i = 0; i < bip32PathLength; i++) {
        bip32Path[i] = (dataBuffer[0] << 24) | (dataBuffer[1] << 16) |
c0d005fc:	5c42      	ldrb	r2, [r0, r1]
c0d005fe:	0612      	lsls	r2, r2, #24
c0d00600:	1843      	adds	r3, r0, r1
c0d00602:	785c      	ldrb	r4, [r3, #1]
c0d00604:	0424      	lsls	r4, r4, #16
c0d00606:	18a2      	adds	r2, r4, r2
                       (dataBuffer[2] << 8) | (dataBuffer[3]);
c0d00608:	789c      	ldrb	r4, [r3, #2]
c0d0060a:	0224      	lsls	r4, r4, #8
    if ((p2Chain != P2_CHAINCODE) && (p2Chain != P2_NO_CHAINCODE)) {
        THROW(0x6B00);
    }
   
    for (i = 0; i < bip32PathLength; i++) {
        bip32Path[i] = (dataBuffer[0] << 24) | (dataBuffer[1] << 16) |
c0d0060c:	1912      	adds	r2, r2, r4
                       (dataBuffer[2] << 8) | (dataBuffer[3]);
c0d0060e:	78db      	ldrb	r3, [r3, #3]
c0d00610:	18d2      	adds	r2, r2, r3
c0d00612:	ab10      	add	r3, sp, #64	; 0x40
    if ((p2Chain != P2_CHAINCODE) && (p2Chain != P2_NO_CHAINCODE)) {
        THROW(0x6B00);
    }
   
    for (i = 0; i < bip32PathLength; i++) {
        bip32Path[i] = (dataBuffer[0] << 24) | (dataBuffer[1] << 16) |
c0d00614:	505a      	str	r2, [r3, r1]
    }
    if ((p2Chain != P2_CHAINCODE) && (p2Chain != P2_NO_CHAINCODE)) {
        THROW(0x6B00);
    }
   
    for (i = 0; i < bip32PathLength; i++) {
c0d00616:	1d09      	adds	r1, r1, #4
c0d00618:	2914      	cmp	r1, #20
c0d0061a:	d1ef      	bne.n	c0d005fc <handleGetPublicKey+0x1c>
c0d0061c:	ac10      	add	r4, sp, #64	; 0x40
        bip32Path[i] = (dataBuffer[0] << 24) | (dataBuffer[1] << 16) |
                       (dataBuffer[2] << 8) | (dataBuffer[3]);
        dataBuffer += 4;
    }

    tmpCtx.publicKeyContext.networkId = readNetworkIdFromBip32path(bip32Path);
c0d0061e:	4620      	mov	r0, r4
c0d00620:	f000 fd66 	bl	c0d010f0 <readNetworkIdFromBip32path>
c0d00624:	214d      	movs	r1, #77	; 0x4d
c0d00626:	9105      	str	r1, [sp, #20]
c0d00628:	4b59      	ldr	r3, [pc, #356]	; (c0d00790 <handleGetPublicKey+0x1b0>)
c0d0062a:	2205      	movs	r2, #5
    tmpCtx.publicKeyContext.algo = CX_SHA512;
c0d0062c:	545a      	strb	r2, [r3, r1]
c0d0062e:	214c      	movs	r1, #76	; 0x4c
        bip32Path[i] = (dataBuffer[0] << 24) | (dataBuffer[1] << 16) |
                       (dataBuffer[2] << 8) | (dataBuffer[3]);
        dataBuffer += 4;
    }

    tmpCtx.publicKeyContext.networkId = readNetworkIdFromBip32path(bip32Path);
c0d00630:	9103      	str	r1, [sp, #12]
c0d00632:	5458      	strb	r0, [r3, r1]
c0d00634:	2100      	movs	r1, #0
    tmpCtx.publicKeyContext.algo = CX_SHA512;
    
    //tmpCtx.publicKeyContext.getChaincode = (p2Chain == P2_CHAINCODE);   
    os_perso_derive_node_bip32(CX_CURVE_256K1, bip32Path, bip32PathLength, privateKeyData, NULL);
c0d00636:	9102      	str	r1, [sp, #8]
c0d00638:	4668      	mov	r0, sp
c0d0063a:	6001      	str	r1, [r0, #0]
c0d0063c:	2021      	movs	r0, #33	; 0x21
c0d0063e:	ae15      	add	r6, sp, #84	; 0x54
c0d00640:	4621      	mov	r1, r4
c0d00642:	4633      	mov	r3, r6
c0d00644:	f001 fe10 	bl	c0d02268 <os_perso_derive_node_bip32>
c0d00648:	2541      	movs	r5, #65	; 0x41
c0d0064a:	2420      	movs	r4, #32
c0d0064c:	af06      	add	r7, sp, #24
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, &privateKey);
c0d0064e:	4628      	mov	r0, r5
c0d00650:	4631      	mov	r1, r6
c0d00652:	4622      	mov	r2, r4
c0d00654:	463b      	mov	r3, r7
c0d00656:	f001 fdad 	bl	c0d021b4 <cx_ecfp_init_private_key>
    cx_ecfp_generate_pair2(CX_CURVE_Ed25519, 
                            &tmpCtx.publicKeyContext.publicKey, 
                            &privateKey, 
                            1, 
                            tmpCtx.publicKeyContext.algo);
c0d0065a:	9805      	ldr	r0, [sp, #20]
c0d0065c:	494c      	ldr	r1, [pc, #304]	; (c0d00790 <handleGetPublicKey+0x1b0>)
c0d0065e:	5c08      	ldrb	r0, [r1, r0]
    tmpCtx.publicKeyContext.algo = CX_SHA512;
    
    //tmpCtx.publicKeyContext.getChaincode = (p2Chain == P2_CHAINCODE);   
    os_perso_derive_node_bip32(CX_CURVE_256K1, bip32Path, bip32PathLength, privateKeyData, NULL);
    cx_ecfp_init_private_key(CX_CURVE_Ed25519, privateKeyData, 32, &privateKey);
    cx_ecfp_generate_pair2(CX_CURVE_Ed25519, 
c0d00660:	466a      	mov	r2, sp
c0d00662:	6010      	str	r0, [r2, #0]
c0d00664:	2301      	movs	r3, #1
c0d00666:	4628      	mov	r0, r5
c0d00668:	463a      	mov	r2, r7
c0d0066a:	f001 fdb3 	bl	c0d021d4 <cx_ecfp_generate_pair2>
                            &tmpCtx.publicKeyContext.publicKey, 
                            &privateKey, 
                            1, 
                            tmpCtx.publicKeyContext.algo);

    os_memset(privateKeyData, 0, sizeof(privateKeyData));
c0d0066e:	4630      	mov	r0, r6
c0d00670:	9d02      	ldr	r5, [sp, #8]
c0d00672:	4629      	mov	r1, r5
c0d00674:	4622      	mov	r2, r4
c0d00676:	f000 fe04 	bl	c0d01282 <os_memset>
c0d0067a:	2628      	movs	r6, #40	; 0x28
    os_memset(&privateKey, 0, sizeof(privateKey));
c0d0067c:	4638      	mov	r0, r7
c0d0067e:	4629      	mov	r1, r5
c0d00680:	462f      	mov	r7, r5
c0d00682:	4632      	mov	r2, r6
c0d00684:	f000 fdfd 	bl	c0d01282 <os_memset>
c0d00688:	4d41      	ldr	r5, [pc, #260]	; (c0d00790 <handleGetPublicKey+0x1b0>)

    to_nem_public_key_and_address(
                                  &tmpCtx.publicKeyContext.publicKey, 
                                  tmpCtx.publicKeyContext.networkId, 
                                  tmpCtx.publicKeyContext.algo, 
c0d0068a:	9805      	ldr	r0, [sp, #20]
c0d0068c:	5c2a      	ldrb	r2, [r5, r0]
    os_memset(privateKeyData, 0, sizeof(privateKeyData));
    os_memset(&privateKey, 0, sizeof(privateKey));

    to_nem_public_key_and_address(
                                  &tmpCtx.publicKeyContext.publicKey, 
                                  tmpCtx.publicKeyContext.networkId, 
c0d0068e:	9803      	ldr	r0, [sp, #12]
c0d00690:	5c29      	ldrb	r1, [r5, r0]
                            tmpCtx.publicKeyContext.algo);

    os_memset(privateKeyData, 0, sizeof(privateKeyData));
    os_memset(&privateKey, 0, sizeof(privateKey));

    to_nem_public_key_and_address(
c0d00692:	462c      	mov	r4, r5
c0d00694:	346e      	adds	r4, #110	; 0x6e
c0d00696:	4668      	mov	r0, sp
c0d00698:	6004      	str	r4, [r0, #0]
c0d0069a:	462b      	mov	r3, r5
c0d0069c:	4628      	mov	r0, r5
c0d0069e:	334e      	adds	r3, #78	; 0x4e
c0d006a0:	f000 fd66 	bl	c0d01170 <to_nem_public_key_and_address>
                                  &tmpCtx.publicKeyContext.address
                                  );

    uint8_t addressLength = sizeof(tmpCtx.publicKeyContext.address);

    os_memset(fullAddress, 0, sizeof(fullAddress));
c0d006a4:	4d3b      	ldr	r5, [pc, #236]	; (c0d00794 <handleGetPublicKey+0x1b4>)
c0d006a6:	4628      	mov	r0, r5
c0d006a8:	4639      	mov	r1, r7
c0d006aa:	4632      	mov	r2, r6
c0d006ac:	f000 fde9 	bl	c0d01282 <os_memset>
    os_memmove((void *)fullAddress, tmpCtx.publicKeyContext.address, 40);
c0d006b0:	4628      	mov	r0, r5
c0d006b2:	4621      	mov	r1, r4
c0d006b4:	4632      	mov	r2, r6
c0d006b6:	f000 fdce 	bl	c0d01256 <os_memmove>
c0d006ba:	242c      	movs	r4, #44	; 0x2c
             tmpCtx.publicKeyContext.address);
#endif                 
    ux_step = 0;
    ux_step_count = 2;
    maxInterval = MAX_UX_CALLBACK_INTERVAL + 1 + 1;
    UX_DISPLAY(ui_address_nanos, ui_address_prepro);
c0d006bc:	4e36      	ldr	r6, [pc, #216]	; (c0d00798 <handleGetPublicKey+0x1b8>)
c0d006be:	2007      	movs	r0, #7
c0d006c0:	5530      	strb	r0, [r6, r4]
c0d006c2:	2064      	movs	r0, #100	; 0x64
c0d006c4:	2103      	movs	r1, #3
c0d006c6:	5431      	strb	r1, [r6, r0]
#if 0        
    snprintf(fullAddress, sizeof(fullAddress), " 0x%.*s ", 40,
             tmpCtx.publicKeyContext.address);
#endif                 
    ux_step = 0;
    ux_step_count = 2;
c0d006c8:	4834      	ldr	r0, [pc, #208]	; (c0d0079c <handleGetPublicKey+0x1bc>)
c0d006ca:	2102      	movs	r1, #2
c0d006cc:	6001      	str	r1, [r0, #0]
#if defined(TARGET_NANOS)
#if 0        
    snprintf(fullAddress, sizeof(fullAddress), " 0x%.*s ", 40,
             tmpCtx.publicKeyContext.address);
#endif                 
    ux_step = 0;
c0d006ce:	4834      	ldr	r0, [pc, #208]	; (c0d007a0 <handleGetPublicKey+0x1c0>)
c0d006d0:	6007      	str	r7, [r0, #0]
    ux_step_count = 2;
    maxInterval = MAX_UX_CALLBACK_INTERVAL + 1 + 1;
c0d006d2:	4834      	ldr	r0, [pc, #208]	; (c0d007a4 <handleGetPublicKey+0x1c4>)
c0d006d4:	2504      	movs	r5, #4
c0d006d6:	6005      	str	r5, [r0, #0]
    UX_DISPLAY(ui_address_nanos, ui_address_prepro);
c0d006d8:	4833      	ldr	r0, [pc, #204]	; (c0d007a8 <handleGetPublicKey+0x1c8>)
c0d006da:	4478      	add	r0, pc
c0d006dc:	4933      	ldr	r1, [pc, #204]	; (c0d007ac <handleGetPublicKey+0x1cc>)
c0d006de:	4479      	add	r1, pc
c0d006e0:	62b1      	str	r1, [r6, #40]	; 0x28
c0d006e2:	66b7      	str	r7, [r6, #104]	; 0x68
c0d006e4:	4932      	ldr	r1, [pc, #200]	; (c0d007b0 <handleGetPublicKey+0x1d0>)
c0d006e6:	4479      	add	r1, pc
c0d006e8:	6331      	str	r1, [r6, #48]	; 0x30
c0d006ea:	6370      	str	r0, [r6, #52]	; 0x34
c0d006ec:	4630      	mov	r0, r6
c0d006ee:	3064      	adds	r0, #100	; 0x64
c0d006f0:	f001 fde4 	bl	c0d022bc <os_ux>
c0d006f4:	4628      	mov	r0, r5
c0d006f6:	f001 fe53 	bl	c0d023a0 <os_sched_last_status>
c0d006fa:	66b0      	str	r0, [r6, #104]	; 0x68
c0d006fc:	f000 ff32 	bl	c0d01564 <io_seproxyhal_init_ux>
c0d00700:	f000 ff32 	bl	c0d01568 <io_seproxyhal_init_button>
c0d00704:	84f7      	strh	r7, [r6, #38]	; 0x26
c0d00706:	4628      	mov	r0, r5
c0d00708:	f001 fe4a 	bl	c0d023a0 <os_sched_last_status>
c0d0070c:	66b0      	str	r0, [r6, #104]	; 0x68
c0d0070e:	2800      	cmp	r0, #0
c0d00710:	d02d      	beq.n	c0d0076e <handleGetPublicKey+0x18e>
c0d00712:	2897      	cmp	r0, #151	; 0x97
c0d00714:	d02b      	beq.n	c0d0076e <handleGetPublicKey+0x18e>
c0d00716:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d00718:	2800      	cmp	r0, #0
c0d0071a:	d028      	beq.n	c0d0076e <handleGetPublicKey+0x18e>
c0d0071c:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d0071e:	5d31      	ldrb	r1, [r6, r4]
c0d00720:	b280      	uxth	r0, r0
c0d00722:	4288      	cmp	r0, r1
c0d00724:	d223      	bcs.n	c0d0076e <handleGetPublicKey+0x18e>
c0d00726:	f001 fe07 	bl	c0d02338 <io_seph_is_status_sent>
c0d0072a:	2800      	cmp	r0, #0
c0d0072c:	d11f      	bne.n	c0d0076e <handleGetPublicKey+0x18e>
c0d0072e:	f001 fd8f 	bl	c0d02250 <os_perso_isonboarded>
c0d00732:	28aa      	cmp	r0, #170	; 0xaa
c0d00734:	d103      	bne.n	c0d0073e <handleGetPublicKey+0x15e>
c0d00736:	f001 fdb5 	bl	c0d022a4 <os_global_pin_is_validated>
c0d0073a:	28aa      	cmp	r0, #170	; 0xaa
c0d0073c:	d117      	bne.n	c0d0076e <handleGetPublicKey+0x18e>
c0d0073e:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d00740:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d00742:	0149      	lsls	r1, r1, #5
c0d00744:	1840      	adds	r0, r0, r1
c0d00746:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d00748:	2900      	cmp	r1, #0
c0d0074a:	d002      	beq.n	c0d00752 <handleGetPublicKey+0x172>
c0d0074c:	4788      	blx	r1
c0d0074e:	2800      	cmp	r0, #0
c0d00750:	d007      	beq.n	c0d00762 <handleGetPublicKey+0x182>
c0d00752:	2801      	cmp	r0, #1
c0d00754:	d103      	bne.n	c0d0075e <handleGetPublicKey+0x17e>
c0d00756:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d00758:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d0075a:	0149      	lsls	r1, r1, #5
c0d0075c:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d0075e:	f000 ff5b 	bl	c0d01618 <io_seproxyhal_display_default>
             tmpCtx.publicKeyContext.address);
#endif                 
    ux_step = 0;
    ux_step_count = 2;
    maxInterval = MAX_UX_CALLBACK_INTERVAL + 1 + 1;
    UX_DISPLAY(ui_address_nanos, ui_address_prepro);
c0d00762:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00764:	1c40      	adds	r0, r0, #1
c0d00766:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d00768:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d0076a:	2900      	cmp	r1, #0
c0d0076c:	d1d7      	bne.n	c0d0071e <handleGetPublicKey+0x13e>
c0d0076e:	9a04      	ldr	r2, [sp, #16]
#endif // #if TARGET

    *flags |= IO_ASYNCH_REPLY;
c0d00770:	6810      	ldr	r0, [r2, #0]
c0d00772:	2110      	movs	r1, #16
c0d00774:	4301      	orrs	r1, r0
c0d00776:	6011      	str	r1, [r2, #0]
    //end: Go show address on ledger
}
c0d00778:	b01d      	add	sp, #116	; 0x74
c0d0077a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0077c:	20d5      	movs	r0, #213	; 0xd5
c0d0077e:	01c0      	lsls	r0, r0, #7
    //set default need confirm
    p1 = P1_CONFIRM;

    //bip32PathLength shold be 5
    if (bip32PathLength != MAX_BIP32_PATH) {
        THROW(0x6a80);
c0d00780:	f000 fd9e 	bl	c0d012c0 <os_longjmp>
c0d00784:	20d5      	movs	r0, #213	; 0xd5
c0d00786:	01c0      	lsls	r0, r0, #7

    if ((p1 != P1_CONFIRM) && (p1 != P1_NON_CONFIRM)) {
        THROW(0x6B00);
    }
    if ((p2Chain != P2_CHAINCODE) && (p2Chain != P2_NO_CHAINCODE)) {
        THROW(0x6B00);
c0d00788:	3080      	adds	r0, #128	; 0x80
c0d0078a:	f000 fd99 	bl	c0d012c0 <os_longjmp>
c0d0078e:	46c0      	nop			; (mov r8, r8)
c0d00790:	20001ac0 	.word	0x20001ac0
c0d00794:	20001800 	.word	0x20001800
c0d00798:	2000182c 	.word	0x2000182c
c0d0079c:	20001abc 	.word	0x20001abc
c0d007a0:	20001828 	.word	0x20001828
c0d007a4:	20001928 	.word	0x20001928
c0d007a8:	fffffd6f 	.word	0xfffffd6f
c0d007ac:	00003f6e 	.word	0x00003f6e
c0d007b0:	fffffb7b 	.word	0xfffffb7b

c0d007b4 <io_seproxyhal_display>:
    // return_to_dashboard:
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
c0d007b4:	b580      	push	{r7, lr}
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d007b6:	f000 ff2f 	bl	c0d01618 <io_seproxyhal_display_default>
}
c0d007ba:	bd80      	pop	{r7, pc}

c0d007bc <display_tx>:
    *flags |= IO_ASYNCH_REPLY;
    //end: Go show address on ledger
}

void display_tx(uint8_t *raw_tx, uint16_t dataLength, 
                volatile unsigned int *flags, volatile unsigned int *tx ) {
c0d007bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007be:	b083      	sub	sp, #12
c0d007c0:	9101      	str	r1, [sp, #4]
c0d007c2:	4605      	mov	r5, r0
    UNUSED(tx);
    uint8_t addressLength;
    uint32_t i;

    tmpCtx.transactionContext.pathLength = raw_tx[0];
c0d007c4:	7800      	ldrb	r0, [r0, #0]
c0d007c6:	494d      	ldr	r1, [pc, #308]	; (c0d008fc <display_tx+0x140>)
c0d007c8:	7008      	strb	r0, [r1, #0]
    if (tmpCtx.transactionContext.pathLength != MAX_BIP32_PATH) {
c0d007ca:	2805      	cmp	r0, #5
c0d007cc:	d000      	beq.n	c0d007d0 <display_tx+0x14>
c0d007ce:	e090      	b.n	c0d008f2 <display_tx+0x136>
c0d007d0:	9202      	str	r2, [sp, #8]
c0d007d2:	4608      	mov	r0, r1
c0d007d4:	3024      	adds	r0, #36	; 0x24
        THROW(0x6a80);
    }

    for (i = 0; i < tmpCtx.transactionContext.pathLength; i++) {
        tmpCtx.transactionContext.bip32Path[i] =
            (raw_tx[1 + i*4] << 24) | (raw_tx[2 + i*4] << 16) |
c0d007d6:	1d29      	adds	r1, r5, #4
c0d007d8:	2202      	movs	r2, #2
c0d007da:	43d2      	mvns	r2, r2
c0d007dc:	2300      	movs	r3, #0
c0d007de:	5c8c      	ldrb	r4, [r1, r2]
c0d007e0:	0624      	lsls	r4, r4, #24
c0d007e2:	188f      	adds	r7, r1, r2
c0d007e4:	787e      	ldrb	r6, [r7, #1]
c0d007e6:	0436      	lsls	r6, r6, #16
c0d007e8:	1934      	adds	r4, r6, r4
            (raw_tx[3 + i*4] << 8) | (raw_tx[4 + i*4]);
c0d007ea:	78be      	ldrb	r6, [r7, #2]
c0d007ec:	0236      	lsls	r6, r6, #8
        THROW(0x6a80);
    }

    for (i = 0; i < tmpCtx.transactionContext.pathLength; i++) {
        tmpCtx.transactionContext.bip32Path[i] =
            (raw_tx[1 + i*4] << 24) | (raw_tx[2 + i*4] << 16) |
c0d007ee:	19a4      	adds	r4, r4, r6
            (raw_tx[3 + i*4] << 8) | (raw_tx[4 + i*4]);
c0d007f0:	780e      	ldrb	r6, [r1, #0]
c0d007f2:	19a4      	adds	r4, r4, r6
    if (tmpCtx.transactionContext.pathLength != MAX_BIP32_PATH) {
        THROW(0x6a80);
    }

    for (i = 0; i < tmpCtx.transactionContext.pathLength; i++) {
        tmpCtx.transactionContext.bip32Path[i] =
c0d007f4:	c010      	stmia	r0!, {r4}
    tmpCtx.transactionContext.pathLength = raw_tx[0];
    if (tmpCtx.transactionContext.pathLength != MAX_BIP32_PATH) {
        THROW(0x6a80);
    }

    for (i = 0; i < tmpCtx.transactionContext.pathLength; i++) {
c0d007f6:	1d09      	adds	r1, r1, #4
c0d007f8:	1c5b      	adds	r3, r3, #1
c0d007fa:	2b05      	cmp	r3, #5
c0d007fc:	d3ef      	bcc.n	c0d007de <display_tx+0x22>
c0d007fe:	4c3f      	ldr	r4, [pc, #252]	; (c0d008fc <display_tx+0x140>)
        tmpCtx.transactionContext.bip32Path[i] =
            (raw_tx[1 + i*4] << 24) | (raw_tx[2 + i*4] << 16) |
            (raw_tx[3 + i*4] << 8) | (raw_tx[4 + i*4]);
    }

    tmpCtx.transactionContext.networkId = readNetworkIdFromBip32path(tmpCtx.transactionContext.bip32Path);
c0d00800:	4620      	mov	r0, r4
c0d00802:	3024      	adds	r0, #36	; 0x24
c0d00804:	f000 fc74 	bl	c0d010f0 <readNetworkIdFromBip32path>
c0d00808:	9901      	ldr	r1, [sp, #4]
    
    // Load dataLength of tx
    tmpCtx.transactionContext.rawTxLength = dataLength - 21; 
c0d0080a:	3915      	subs	r1, #21
c0d0080c:	63a1      	str	r1, [r4, #56]	; 0x38
        tmpCtx.transactionContext.bip32Path[i] =
            (raw_tx[1 + i*4] << 24) | (raw_tx[2 + i*4] << 16) |
            (raw_tx[3 + i*4] << 8) | (raw_tx[4 + i*4]);
    }

    tmpCtx.transactionContext.networkId = readNetworkIdFromBip32path(tmpCtx.transactionContext.bip32Path);
c0d0080e:	7060      	strb	r0, [r4, #1]
    // Load dataLength of tx
    tmpCtx.transactionContext.rawTxLength = dataLength - 21; 
  
    uint8_t disIndex;
    uint8_t networkGenerationHashLength = 32;
    txContent.txType = getUint16(reverseBytes(&raw_tx[21 + networkGenerationHashLength + 2], 2));
c0d00810:	3537      	adds	r5, #55	; 0x37
c0d00812:	2102      	movs	r1, #2
c0d00814:	4628      	mov	r0, r5
c0d00816:	f000 fc89 	bl	c0d0112c <reverseBytes>
c0d0081a:	f000 fca2 	bl	c0d01162 <getUint16>
c0d0081e:	4938      	ldr	r1, [pc, #224]	; (c0d00900 <display_tx+0x144>)
c0d00820:	8008      	strh	r0, [r1, #0]

    SPRINTF(txTypeName, "%s", "Transfer TX");
c0d00822:	4838      	ldr	r0, [pc, #224]	; (c0d00904 <display_tx+0x148>)
c0d00824:	493c      	ldr	r1, [pc, #240]	; (c0d00918 <display_tx+0x15c>)
c0d00826:	4479      	add	r1, pc
c0d00828:	220c      	movs	r2, #12
c0d0082a:	f003 fd15 	bl	c0d04258 <__aeabi_memcpy>
c0d0082e:	262c      	movs	r6, #44	; 0x2c
    /*
    if (txContent.txtype) {
        ux_step_count++;
    }*/
    maxInterval = MAX_UX_CALLBACK_INTERVAL + 1;
    UX_DISPLAY(ui_approval_nanos, ui_approval_prepro);
c0d00830:	4f35      	ldr	r7, [pc, #212]	; (c0d00908 <display_tx+0x14c>)
c0d00832:	2007      	movs	r0, #7
c0d00834:	55b8      	strb	r0, [r7, r6]
c0d00836:	2064      	movs	r0, #100	; 0x64
c0d00838:	2103      	movs	r1, #3
c0d0083a:	5439      	strb	r1, [r7, r0]
    uint8_t disIndex;
    uint8_t networkGenerationHashLength = 32;
    txContent.txType = getUint16(reverseBytes(&raw_tx[21 + networkGenerationHashLength + 2], 2));

    SPRINTF(txTypeName, "%s", "Transfer TX");
    ux_step_count = 1;
c0d0083c:	4833      	ldr	r0, [pc, #204]	; (c0d0090c <display_tx+0x150>)
c0d0083e:	2201      	movs	r2, #1
c0d00840:	6002      	str	r2, [r0, #0]
    //         SPRINTF(txTypeName, "Tx type %x", txContent.txType); 
    //         break; 
    // } 

#if defined(TARGET_NANOS)
    ux_step = 0;
c0d00842:	4833      	ldr	r0, [pc, #204]	; (c0d00910 <display_tx+0x154>)
c0d00844:	2400      	movs	r4, #0
c0d00846:	6004      	str	r4, [r0, #0]
    //ux_step_count = 5;
    /*
    if (txContent.txtype) {
        ux_step_count++;
    }*/
    maxInterval = MAX_UX_CALLBACK_INTERVAL + 1;
c0d00848:	4832      	ldr	r0, [pc, #200]	; (c0d00914 <display_tx+0x158>)
c0d0084a:	6001      	str	r1, [r0, #0]
    UX_DISPLAY(ui_approval_nanos, ui_approval_prepro);
c0d0084c:	4833      	ldr	r0, [pc, #204]	; (c0d0091c <display_tx+0x160>)
c0d0084e:	4478      	add	r0, pc
c0d00850:	4933      	ldr	r1, [pc, #204]	; (c0d00920 <display_tx+0x164>)
c0d00852:	4479      	add	r1, pc
c0d00854:	62b9      	str	r1, [r7, #40]	; 0x28
c0d00856:	66bc      	str	r4, [r7, #104]	; 0x68
c0d00858:	4932      	ldr	r1, [pc, #200]	; (c0d00924 <display_tx+0x168>)
c0d0085a:	4479      	add	r1, pc
c0d0085c:	6339      	str	r1, [r7, #48]	; 0x30
c0d0085e:	6378      	str	r0, [r7, #52]	; 0x34
c0d00860:	4638      	mov	r0, r7
c0d00862:	3064      	adds	r0, #100	; 0x64
c0d00864:	f001 fd2a 	bl	c0d022bc <os_ux>
c0d00868:	2504      	movs	r5, #4
c0d0086a:	4628      	mov	r0, r5
c0d0086c:	f001 fd98 	bl	c0d023a0 <os_sched_last_status>
c0d00870:	66b8      	str	r0, [r7, #104]	; 0x68
c0d00872:	f000 fe77 	bl	c0d01564 <io_seproxyhal_init_ux>
c0d00876:	f000 fe77 	bl	c0d01568 <io_seproxyhal_init_button>
c0d0087a:	84fc      	strh	r4, [r7, #38]	; 0x26
c0d0087c:	4628      	mov	r0, r5
c0d0087e:	f001 fd8f 	bl	c0d023a0 <os_sched_last_status>
c0d00882:	66b8      	str	r0, [r7, #104]	; 0x68
c0d00884:	2800      	cmp	r0, #0
c0d00886:	9c02      	ldr	r4, [sp, #8]
c0d00888:	d02d      	beq.n	c0d008e6 <display_tx+0x12a>
c0d0088a:	2897      	cmp	r0, #151	; 0x97
c0d0088c:	d02b      	beq.n	c0d008e6 <display_tx+0x12a>
c0d0088e:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d00890:	2800      	cmp	r0, #0
c0d00892:	d028      	beq.n	c0d008e6 <display_tx+0x12a>
c0d00894:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d00896:	5db9      	ldrb	r1, [r7, r6]
c0d00898:	b280      	uxth	r0, r0
c0d0089a:	4288      	cmp	r0, r1
c0d0089c:	d223      	bcs.n	c0d008e6 <display_tx+0x12a>
c0d0089e:	f001 fd4b 	bl	c0d02338 <io_seph_is_status_sent>
c0d008a2:	2800      	cmp	r0, #0
c0d008a4:	d11f      	bne.n	c0d008e6 <display_tx+0x12a>
c0d008a6:	f001 fcd3 	bl	c0d02250 <os_perso_isonboarded>
c0d008aa:	28aa      	cmp	r0, #170	; 0xaa
c0d008ac:	d103      	bne.n	c0d008b6 <display_tx+0xfa>
c0d008ae:	f001 fcf9 	bl	c0d022a4 <os_global_pin_is_validated>
c0d008b2:	28aa      	cmp	r0, #170	; 0xaa
c0d008b4:	d117      	bne.n	c0d008e6 <display_tx+0x12a>
c0d008b6:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d008b8:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
c0d008ba:	0149      	lsls	r1, r1, #5
c0d008bc:	1840      	adds	r0, r0, r1
c0d008be:	6b39      	ldr	r1, [r7, #48]	; 0x30
c0d008c0:	2900      	cmp	r1, #0
c0d008c2:	d002      	beq.n	c0d008ca <display_tx+0x10e>
c0d008c4:	4788      	blx	r1
c0d008c6:	2800      	cmp	r0, #0
c0d008c8:	d007      	beq.n	c0d008da <display_tx+0x11e>
c0d008ca:	2801      	cmp	r0, #1
c0d008cc:	d103      	bne.n	c0d008d6 <display_tx+0x11a>
c0d008ce:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d008d0:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
c0d008d2:	0149      	lsls	r1, r1, #5
c0d008d4:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d008d6:	f000 fe9f 	bl	c0d01618 <io_seproxyhal_display_default>
    /*
    if (txContent.txtype) {
        ux_step_count++;
    }*/
    maxInterval = MAX_UX_CALLBACK_INTERVAL + 1;
    UX_DISPLAY(ui_approval_nanos, ui_approval_prepro);
c0d008da:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d008dc:	1c40      	adds	r0, r0, #1
c0d008de:	84f8      	strh	r0, [r7, #38]	; 0x26
c0d008e0:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d008e2:	2900      	cmp	r1, #0
c0d008e4:	d1d7      	bne.n	c0d00896 <display_tx+0xda>
#endif // #if TARGET

    *flags |= IO_ASYNCH_REPLY;
c0d008e6:	6820      	ldr	r0, [r4, #0]
c0d008e8:	2110      	movs	r1, #16
c0d008ea:	4301      	orrs	r1, r0
c0d008ec:	6021      	str	r1, [r4, #0]
}
c0d008ee:	b003      	add	sp, #12
c0d008f0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d008f2:	20d5      	movs	r0, #213	; 0xd5
c0d008f4:	01c0      	lsls	r0, r0, #7
    uint8_t addressLength;
    uint32_t i;

    tmpCtx.transactionContext.pathLength = raw_tx[0];
    if (tmpCtx.transactionContext.pathLength != MAX_BIP32_PATH) {
        THROW(0x6a80);
c0d008f6:	f000 fce3 	bl	c0d012c0 <os_longjmp>
c0d008fa:	46c0      	nop			; (mov r8, r8)
c0d008fc:	20001ac0 	.word	0x20001ac0
c0d00900:	20001d56 	.word	0x20001d56
c0d00904:	20001a7b 	.word	0x20001a7b
c0d00908:	2000182c 	.word	0x2000182c
c0d0090c:	20001abc 	.word	0x20001abc
c0d00910:	20001828 	.word	0x20001828
c0d00914:	20001928 	.word	0x20001928
c0d00918:	0000403e 	.word	0x0000403e
c0d0091c:	fffffd03 	.word	0xfffffd03
c0d00920:	00003f32 	.word	0x00003f32
c0d00924:	fffffaaf 	.word	0xfffffaaf

c0d00928 <handleSign>:
#endif // #if TARGET

    *flags |= IO_ASYNCH_REPLY;
}

void handleSign(volatile unsigned int *flags, volatile unsigned int *tx) {
c0d00928:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0092a:	b081      	sub	sp, #4
c0d0092c:	4604      	mov	r4, r0
    // check the third byte (0x02) for the instruction subtype.
    if ((G_io_apdu_buffer[OFFSET_P1] == P1_FIRST) || (G_io_apdu_buffer[OFFSET_P1] == P1_LAST)) {
c0d0092e:	4e23      	ldr	r6, [pc, #140]	; (c0d009bc <handleSign+0x94>)
c0d00930:	78b0      	ldrb	r0, [r6, #2]
c0d00932:	2890      	cmp	r0, #144	; 0x90
c0d00934:	d001      	beq.n	c0d0093a <handleSign+0x12>
c0d00936:	2800      	cmp	r0, #0
c0d00938:	d106      	bne.n	c0d00948 <handleSign+0x20>
        clean_raw_tx(raw_tx);
c0d0093a:	4821      	ldr	r0, [pc, #132]	; (c0d009c0 <handleSign+0x98>)
c0d0093c:	f000 fc80 	bl	c0d01240 <clean_raw_tx>
        hashTainted = 1;
c0d00940:	4820      	ldr	r0, [pc, #128]	; (c0d009c4 <handleSign+0x9c>)
c0d00942:	2101      	movs	r1, #1
c0d00944:	7001      	strb	r1, [r0, #0]
c0d00946:	e003      	b.n	c0d00950 <handleSign+0x28>
    }

    // if this is the first transaction part, reset the hash and all the other temporary variables.
    if (hashTainted) {
c0d00948:	481e      	ldr	r0, [pc, #120]	; (c0d009c4 <handleSign+0x9c>)
c0d0094a:	7800      	ldrb	r0, [r0, #0]
c0d0094c:	2800      	cmp	r0, #0
c0d0094e:	d006      	beq.n	c0d0095e <handleSign+0x36>
        hashTainted = 0;
        raw_tx_ix = 0;
c0d00950:	481d      	ldr	r0, [pc, #116]	; (c0d009c8 <handleSign+0xa0>)
c0d00952:	2100      	movs	r1, #0
c0d00954:	6001      	str	r1, [r0, #0]
        hashTainted = 1;
    }

    // if this is the first transaction part, reset the hash and all the other temporary variables.
    if (hashTainted) {
        hashTainted = 0;
c0d00956:	481b      	ldr	r0, [pc, #108]	; (c0d009c4 <handleSign+0x9c>)
c0d00958:	7001      	strb	r1, [r0, #0]
        raw_tx_ix = 0;
        raw_tx_len = 0;
c0d0095a:	481c      	ldr	r0, [pc, #112]	; (c0d009cc <handleSign+0xa4>)
c0d0095c:	6001      	str	r1, [r0, #0]
    }

    // move the contents of the buffer into raw_tx, and update raw_tx_ix to the end of the buffer, 
    // to be ready for the next part of the tx.
    unsigned int len = get_apdu_buffer_length();
c0d0095e:	f000 fc69 	bl	c0d01234 <get_apdu_buffer_length>
c0d00962:	4605      	mov	r5, r0
    unsigned char * in = G_io_apdu_buffer + OFFSET_CDATA;
    unsigned char * out = raw_tx + raw_tx_ix;
c0d00964:	4f18      	ldr	r7, [pc, #96]	; (c0d009c8 <handleSign+0xa0>)
c0d00966:	6838      	ldr	r0, [r7, #0]
    if (raw_tx_ix + len > MAX_TX_RAW_LENGTH) {
c0d00968:	1941      	adds	r1, r0, r5
c0d0096a:	22ff      	movs	r2, #255	; 0xff
c0d0096c:	32ec      	adds	r2, #236	; 0xec
c0d0096e:	4291      	cmp	r1, r2
c0d00970:	d21a      	bcs.n	c0d009a8 <handleSign+0x80>

    // move the contents of the buffer into raw_tx, and update raw_tx_ix to the end of the buffer, 
    // to be ready for the next part of the tx.
    unsigned int len = get_apdu_buffer_length();
    unsigned char * in = G_io_apdu_buffer + OFFSET_CDATA;
    unsigned char * out = raw_tx + raw_tx_ix;
c0d00972:	4913      	ldr	r1, [pc, #76]	; (c0d009c0 <handleSign+0x98>)
c0d00974:	1808      	adds	r0, r1, r0
    if (raw_tx_ix + len > MAX_TX_RAW_LENGTH) {
        hashTainted = 1;
        THROW(0x6D08);
    }
    os_memmove(out, in, len);
c0d00976:	1d71      	adds	r1, r6, #5
c0d00978:	462a      	mov	r2, r5
c0d0097a:	f000 fc6c 	bl	c0d01256 <os_memmove>
    raw_tx_ix += len;
c0d0097e:	6838      	ldr	r0, [r7, #0]
c0d00980:	1940      	adds	r0, r0, r5
c0d00982:	6038      	str	r0, [r7, #0]
    unsigned char * out = raw_tx + raw_tx_ix;
    if (raw_tx_ix + len > MAX_TX_RAW_LENGTH) {
        hashTainted = 1;
        THROW(0x6D08);
    }
    os_memmove(out, in, len);
c0d00984:	1972      	adds	r2, r6, r5
c0d00986:	2100      	movs	r1, #0
    raw_tx_ix += len;

    // set the buffer to end with a zero.
    G_io_apdu_buffer[OFFSET_CDATA + len] = '\0';
c0d00988:	7151      	strb	r1, [r2, #5]

    // if this is the last part of the transaction, parse the transaction into human readable text, and display it.
    if ((G_io_apdu_buffer[OFFSET_P1] == P1_MORE) || (G_io_apdu_buffer[OFFSET_P1] == P1_LAST))  {
c0d0098a:	78b2      	ldrb	r2, [r6, #2]
c0d0098c:	2310      	movs	r3, #16
c0d0098e:	4313      	orrs	r3, r2
c0d00990:	2b90      	cmp	r3, #144	; 0x90
c0d00992:	d10f      	bne.n	c0d009b4 <handleSign+0x8c>
        raw_tx_len = raw_tx_ix;
        raw_tx_ix = 0;
c0d00994:	6039      	str	r1, [r7, #0]
    // set the buffer to end with a zero.
    G_io_apdu_buffer[OFFSET_CDATA + len] = '\0';

    // if this is the last part of the transaction, parse the transaction into human readable text, and display it.
    if ((G_io_apdu_buffer[OFFSET_P1] == P1_MORE) || (G_io_apdu_buffer[OFFSET_P1] == P1_LAST))  {
        raw_tx_len = raw_tx_ix;
c0d00996:	490d      	ldr	r1, [pc, #52]	; (c0d009cc <handleSign+0xa4>)
c0d00998:	6008      	str	r0, [r1, #0]
        raw_tx_ix = 0;

        // parse the transaction into human readable text.
        display_tx(&raw_tx, raw_tx_len, flags, tx);
c0d0099a:	b281      	uxth	r1, r0
c0d0099c:	4808      	ldr	r0, [pc, #32]	; (c0d009c0 <handleSign+0x98>)
c0d0099e:	4622      	mov	r2, r4
c0d009a0:	f7ff ff0c 	bl	c0d007bc <display_tx>
    } else {
        // continue reading the tx
        THROW(0x9000);  
    }
}
c0d009a4:	b001      	add	sp, #4
c0d009a6:	bdf0      	pop	{r4, r5, r6, r7, pc}
    // to be ready for the next part of the tx.
    unsigned int len = get_apdu_buffer_length();
    unsigned char * in = G_io_apdu_buffer + OFFSET_CDATA;
    unsigned char * out = raw_tx + raw_tx_ix;
    if (raw_tx_ix + len > MAX_TX_RAW_LENGTH) {
        hashTainted = 1;
c0d009a8:	4806      	ldr	r0, [pc, #24]	; (c0d009c4 <handleSign+0x9c>)
c0d009aa:	2101      	movs	r1, #1
c0d009ac:	7001      	strb	r1, [r0, #0]
c0d009ae:	4808      	ldr	r0, [pc, #32]	; (c0d009d0 <handleSign+0xa8>)
        THROW(0x6D08);
c0d009b0:	f000 fc86 	bl	c0d012c0 <os_longjmp>
c0d009b4:	2009      	movs	r0, #9
c0d009b6:	0300      	lsls	r0, r0, #12

        // parse the transaction into human readable text.
        display_tx(&raw_tx, raw_tx_len, flags, tx);
    } else {
        // continue reading the tx
        THROW(0x9000);  
c0d009b8:	f000 fc82 	bl	c0d012c0 <os_longjmp>
c0d009bc:	20001df4 	.word	0x20001df4
c0d009c0:	20001b6c 	.word	0x20001b6c
c0d009c4:	20001d68 	.word	0x20001d68
c0d009c8:	20001d6c 	.word	0x20001d6c
c0d009cc:	20001d70 	.word	0x20001d70
c0d009d0:	00006d08 	.word	0x00006d08

c0d009d4 <handleGetAppConfiguration>:
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(workBuffer);
    UNUSED(dataLength);
    UNUSED(flags);
    G_io_apdu_buffer[0] = 0x00;
c0d009d4:	4806      	ldr	r0, [pc, #24]	; (c0d009f0 <handleGetAppConfiguration+0x1c>)
c0d009d6:	2101      	movs	r1, #1
    G_io_apdu_buffer[1] = LEDGER_MAJOR_VERSION;
    G_io_apdu_buffer[2] = LEDGER_MINOR_VERSION;
    G_io_apdu_buffer[3] = LEDGER_PATCH_VERSION;
c0d009d8:	70c1      	strb	r1, [r0, #3]
c0d009da:	2100      	movs	r1, #0
    UNUSED(workBuffer);
    UNUSED(dataLength);
    UNUSED(flags);
    G_io_apdu_buffer[0] = 0x00;
    G_io_apdu_buffer[1] = LEDGER_MAJOR_VERSION;
    G_io_apdu_buffer[2] = LEDGER_MINOR_VERSION;
c0d009dc:	7081      	strb	r1, [r0, #2]
    UNUSED(p2);
    UNUSED(workBuffer);
    UNUSED(dataLength);
    UNUSED(flags);
    G_io_apdu_buffer[0] = 0x00;
    G_io_apdu_buffer[1] = LEDGER_MAJOR_VERSION;
c0d009de:	7041      	strb	r1, [r0, #1]
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(workBuffer);
    UNUSED(dataLength);
    UNUSED(flags);
    G_io_apdu_buffer[0] = 0x00;
c0d009e0:	7001      	strb	r1, [r0, #0]
c0d009e2:	9801      	ldr	r0, [sp, #4]
c0d009e4:	2104      	movs	r1, #4
    G_io_apdu_buffer[1] = LEDGER_MAJOR_VERSION;
    G_io_apdu_buffer[2] = LEDGER_MINOR_VERSION;
    G_io_apdu_buffer[3] = LEDGER_PATCH_VERSION;
    *tx = 4;
c0d009e6:	6001      	str	r1, [r0, #0]
c0d009e8:	2009      	movs	r0, #9
c0d009ea:	0300      	lsls	r0, r0, #12
    THROW(0x9000);
c0d009ec:	f000 fc68 	bl	c0d012c0 <os_longjmp>
c0d009f0:	20001df4 	.word	0x20001df4

c0d009f4 <nem_main>:
}

void nem_main(void) {
c0d009f4:	b094      	sub	sp, #80	; 0x50
c0d009f6:	2400      	movs	r4, #0
    volatile unsigned int rx = 0;
c0d009f8:	9413      	str	r4, [sp, #76]	; 0x4c
    volatile unsigned int tx = 0;
c0d009fa:	9412      	str	r4, [sp, #72]	; 0x48
    volatile unsigned int flags = 0;
c0d009fc:	9411      	str	r4, [sp, #68]	; 0x44
c0d009fe:	484d      	ldr	r0, [pc, #308]	; (c0d00b34 <nem_main+0x140>)
c0d00a00:	4478      	add	r0, pc
c0d00a02:	9003      	str	r0, [sp, #12]
c0d00a04:	4d48      	ldr	r5, [pc, #288]	; (c0d00b28 <nem_main+0x134>)
c0d00a06:	a810      	add	r0, sp, #64	; 0x40
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00a08:	8004      	strh	r4, [r0, #0]
c0d00a0a:	ae04      	add	r6, sp, #16

        BEGIN_TRY {
            TRY {
c0d00a0c:	4630      	mov	r0, r6
c0d00a0e:	f003 fcb3 	bl	c0d04378 <setjmp>
c0d00a12:	4607      	mov	r7, r0
c0d00a14:	85b0      	strh	r0, [r6, #44]	; 0x2c
c0d00a16:	0400      	lsls	r0, r0, #16
c0d00a18:	d017      	beq.n	c0d00a4a <nem_main+0x56>
c0d00a1a:	a804      	add	r0, sp, #16
                default:
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00a1c:	8584      	strh	r4, [r0, #44]	; 0x2c
c0d00a1e:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00a20:	f001 fcb2 	bl	c0d02388 <try_context_set>
c0d00a24:	200f      	movs	r0, #15
c0d00a26:	0300      	lsls	r0, r0, #12
                switch (e & 0xF000) {
c0d00a28:	4038      	ands	r0, r7
c0d00a2a:	2109      	movs	r1, #9
c0d00a2c:	0309      	lsls	r1, r1, #12
c0d00a2e:	4288      	cmp	r0, r1
c0d00a30:	d02e      	beq.n	c0d00a90 <nem_main+0x9c>
c0d00a32:	2103      	movs	r1, #3
c0d00a34:	0349      	lsls	r1, r1, #13
c0d00a36:	4288      	cmp	r0, r1
c0d00a38:	d12d      	bne.n	c0d00a96 <nem_main+0xa2>
c0d00a3a:	a810      	add	r0, sp, #64	; 0x40
                case 0x6000:
                    // Wipe the transaction context and report the exception
                    sw = e;
c0d00a3c:	8007      	strh	r7, [r0, #0]
c0d00a3e:	2100      	movs	r1, #0
c0d00a40:	2212      	movs	r2, #18
                    os_memset(&txContent, 0, sizeof(txContent));
c0d00a42:	4837      	ldr	r0, [pc, #220]	; (c0d00b20 <nem_main+0x12c>)
c0d00a44:	f000 fc1d 	bl	c0d01282 <os_memset>
c0d00a48:	e02c      	b.n	c0d00aa4 <nem_main+0xb0>
c0d00a4a:	a804      	add	r0, sp, #16
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
c0d00a4c:	f001 fc9c 	bl	c0d02388 <try_context_set>
                rx = tx;
c0d00a50:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d00a52:	9113      	str	r1, [sp, #76]	; 0x4c
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00a54:	9412      	str	r4, [sp, #72]	; 0x48
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
c0d00a56:	900e      	str	r0, [sp, #56]	; 0x38
                rx = tx;
                tx = 0; // ensure no race in catch_other if io_exchange throws
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00a58:	9811      	ldr	r0, [sp, #68]	; 0x44
c0d00a5a:	9913      	ldr	r1, [sp, #76]	; 0x4c
c0d00a5c:	b2c0      	uxtb	r0, r0
c0d00a5e:	b289      	uxth	r1, r1
c0d00a60:	f000 fe9e 	bl	c0d017a0 <io_exchange>
c0d00a64:	9013      	str	r0, [sp, #76]	; 0x4c
                flags = 0;
c0d00a66:	9411      	str	r4, [sp, #68]	; 0x44

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00a68:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d00a6a:	2800      	cmp	r0, #0
c0d00a6c:	d047      	beq.n	c0d00afe <nem_main+0x10a>
                    hashTainted = 1;
                    THROW(0x6982);
                }

                PRINTF("New APDU received:\n%.*H\n", rx, G_io_apdu_buffer);
c0d00a6e:	9913      	ldr	r1, [sp, #76]	; 0x4c
c0d00a70:	9803      	ldr	r0, [sp, #12]
c0d00a72:	462a      	mov	r2, r5
c0d00a74:	f001 f98a 	bl	c0d01d8c <mcu_usb_printf>

                // if the buffer doesn't start with the magic byte, return an error.
                if (G_io_apdu_buffer[OFFSET_CLA] != CLA) {
c0d00a78:	7828      	ldrb	r0, [r5, #0]
c0d00a7a:	28e0      	cmp	r0, #224	; 0xe0
c0d00a7c:	d145      	bne.n	c0d00b0a <nem_main+0x116>
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check the second byte (0x01) for the instruction.
				switch (G_io_apdu_buffer[OFFSET_INS]) {
c0d00a7e:	7868      	ldrb	r0, [r5, #1]
c0d00a80:	2802      	cmp	r0, #2
c0d00a82:	d01b      	beq.n	c0d00abc <nem_main+0xc8>
c0d00a84:	2804      	cmp	r0, #4
c0d00a86:	d130      	bne.n	c0d00aea <nem_main+0xf6>
c0d00a88:	a811      	add	r0, sp, #68	; 0x44
                                G_io_apdu_buffer[OFFSET_LC], &flags, &tx);
                break;

                //Sign a transaction
                case INS_SIGN: 
                handleSign(&flags, &tx);
c0d00a8a:	f7ff ff4d 	bl	c0d00928 <handleSign>
c0d00a8e:	e01e      	b.n	c0d00ace <nem_main+0xda>
c0d00a90:	a810      	add	r0, sp, #64	; 0x40
                    sw = e;
                    os_memset(&txContent, 0, sizeof(txContent));
                    break;
                case 0x9000:
                    // All is well
                    sw = e;
c0d00a92:	8007      	strh	r7, [r0, #0]
c0d00a94:	e006      	b.n	c0d00aa4 <nem_main+0xb0>
                    break;
                default:
                    // Internal error
                    sw = 0x6800 | (e & 0x7FF);
c0d00a96:	4823      	ldr	r0, [pc, #140]	; (c0d00b24 <nem_main+0x130>)
c0d00a98:	4007      	ands	r7, r0
c0d00a9a:	200d      	movs	r0, #13
c0d00a9c:	02c0      	lsls	r0, r0, #11
c0d00a9e:	1838      	adds	r0, r7, r0
c0d00aa0:	a910      	add	r1, sp, #64	; 0x40
c0d00aa2:	8008      	strh	r0, [r1, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00aa4:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d00aa6:	0a00      	lsrs	r0, r0, #8
c0d00aa8:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d00aaa:	5468      	strb	r0, [r5, r1]
                G_io_apdu_buffer[tx + 1] = sw;
c0d00aac:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d00aae:	9912      	ldr	r1, [sp, #72]	; 0x48
                    // Internal error
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00ab0:	1869      	adds	r1, r5, r1
                G_io_apdu_buffer[tx + 1] = sw;
c0d00ab2:	7048      	strb	r0, [r1, #1]
                tx += 2;
c0d00ab4:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d00ab6:	1c80      	adds	r0, r0, #2
c0d00ab8:	9012      	str	r0, [sp, #72]	; 0x48
c0d00aba:	e008      	b.n	c0d00ace <nem_main+0xda>
                // check the second byte (0x01) for the instruction.
				switch (G_io_apdu_buffer[OFFSET_INS]) {
                
                case INS_GET_PUBLIC_KEY: 
                handleGetPublicKey(G_io_apdu_buffer[OFFSET_P1],
                                G_io_apdu_buffer[OFFSET_P2],
c0d00abc:	78e9      	ldrb	r1, [r5, #3]
c0d00abe:	a811      	add	r0, sp, #68	; 0x44

                // check the second byte (0x01) for the instruction.
				switch (G_io_apdu_buffer[OFFSET_INS]) {
                
                case INS_GET_PUBLIC_KEY: 
                handleGetPublicKey(G_io_apdu_buffer[OFFSET_P1],
c0d00ac0:	466a      	mov	r2, sp
c0d00ac2:	6010      	str	r0, [r2, #0]
c0d00ac4:	1d6a      	adds	r2, r5, #5
c0d00ac6:	2000      	movs	r0, #0
c0d00ac8:	4603      	mov	r3, r0
c0d00aca:	f7ff fd89 	bl	c0d005e0 <handleGetPublicKey>
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
                G_io_apdu_buffer[tx + 1] = sw;
                tx += 2;
            }
            FINALLY {
c0d00ace:	f001 fc4f 	bl	c0d02370 <try_context_get>
c0d00ad2:	a904      	add	r1, sp, #16
c0d00ad4:	4288      	cmp	r0, r1
c0d00ad6:	d102      	bne.n	c0d00ade <nem_main+0xea>
c0d00ad8:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00ada:	f001 fc55 	bl	c0d02388 <try_context_set>
c0d00ade:	a804      	add	r0, sp, #16
            }
        }
        END_TRY;
c0d00ae0:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d00ae2:	2800      	cmp	r0, #0
c0d00ae4:	d08f      	beq.n	c0d00a06 <nem_main+0x12>
c0d00ae6:	f000 fbeb 	bl	c0d012c0 <os_longjmp>
                    hashTainted = 1;
                    THROW(0x6E00);
                }

                // check the second byte (0x01) for the instruction.
				switch (G_io_apdu_buffer[OFFSET_INS]) {
c0d00aea:	2806      	cmp	r0, #6
c0d00aec:	d114      	bne.n	c0d00b18 <nem_main+0x124>
c0d00aee:	a812      	add	r0, sp, #72	; 0x48
                case INS_SIGN: 
                handleSign(&flags, &tx);
                break;

                case INS_GET_APP_CONFIGURATION:
                handleGetAppConfiguration(
c0d00af0:	4669      	mov	r1, sp
c0d00af2:	6048      	str	r0, [r1, #4]
c0d00af4:	2000      	movs	r0, #0
c0d00af6:	4601      	mov	r1, r0
c0d00af8:	4603      	mov	r3, r0
c0d00afa:	f7ff ff6b 	bl	c0d009d4 <handleGetAppConfiguration>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    hashTainted = 1;
c0d00afe:	480b      	ldr	r0, [pc, #44]	; (c0d00b2c <nem_main+0x138>)
c0d00b00:	2101      	movs	r1, #1
c0d00b02:	7001      	strb	r1, [r0, #0]
c0d00b04:	480a      	ldr	r0, [pc, #40]	; (c0d00b30 <nem_main+0x13c>)
                    THROW(0x6982);
c0d00b06:	f000 fbdb 	bl	c0d012c0 <os_longjmp>

                PRINTF("New APDU received:\n%.*H\n", rx, G_io_apdu_buffer);

                // if the buffer doesn't start with the magic byte, return an error.
                if (G_io_apdu_buffer[OFFSET_CLA] != CLA) {
                    hashTainted = 1;
c0d00b0a:	4808      	ldr	r0, [pc, #32]	; (c0d00b2c <nem_main+0x138>)
c0d00b0c:	2101      	movs	r1, #1
c0d00b0e:	7001      	strb	r1, [r0, #0]
c0d00b10:	2037      	movs	r0, #55	; 0x37
c0d00b12:	0240      	lsls	r0, r0, #9
                    THROW(0x6E00);
c0d00b14:	f000 fbd4 	bl	c0d012c0 <os_longjmp>
c0d00b18:	206d      	movs	r0, #109	; 0x6d
c0d00b1a:	0200      	lsls	r0, r0, #8
                    G_io_apdu_buffer + OFFSET_CDATA,
                    G_io_apdu_buffer[OFFSET_LC], &flags, &tx);
                break;

                default:
                    THROW(0x6D00);
c0d00b1c:	f000 fbd0 	bl	c0d012c0 <os_longjmp>
c0d00b20:	20001d56 	.word	0x20001d56
c0d00b24:	000007ff 	.word	0x000007ff
c0d00b28:	20001df4 	.word	0x20001df4
c0d00b2c:	20001d68 	.word	0x20001d68
c0d00b30:	00006982 	.word	0x00006982
c0d00b34:	00003b52 	.word	0x00003b52

c0d00b38 <io_event>:
// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
}

unsigned char io_event(unsigned char channel) {
c0d00b38:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00b3a:	b081      	sub	sp, #4
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00b3c:	4ded      	ldr	r5, [pc, #948]	; (c0d00ef4 <io_event+0x3bc>)
c0d00b3e:	7828      	ldrb	r0, [r5, #0]
c0d00b40:	280c      	cmp	r0, #12
c0d00b42:	dd10      	ble.n	c0d00b66 <io_event+0x2e>
c0d00b44:	280d      	cmp	r0, #13
c0d00b46:	d066      	beq.n	c0d00c16 <io_event+0xde>
c0d00b48:	280e      	cmp	r0, #14
c0d00b4a:	d100      	bne.n	c0d00b4e <io_event+0x16>
c0d00b4c:	e0ac      	b.n	c0d00ca8 <io_event+0x170>
c0d00b4e:	2815      	cmp	r0, #21
c0d00b50:	d10f      	bne.n	c0d00b72 <io_event+0x3a>
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_STATUS_EVENT:
        if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID &&
c0d00b52:	48e9      	ldr	r0, [pc, #932]	; (c0d00ef8 <io_event+0x3c0>)
c0d00b54:	7980      	ldrb	r0, [r0, #6]
c0d00b56:	2801      	cmp	r0, #1
c0d00b58:	d10b      	bne.n	c0d00b72 <io_event+0x3a>
            !(U4BE(G_io_seproxyhal_spi_buffer, 3) &
c0d00b5a:	79a8      	ldrb	r0, [r5, #6]
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_STATUS_EVENT:
        if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID &&
c0d00b5c:	0700      	lsls	r0, r0, #28
c0d00b5e:	d408      	bmi.n	c0d00b72 <io_event+0x3a>
c0d00b60:	2010      	movs	r0, #16
            !(U4BE(G_io_seproxyhal_spi_buffer, 3) &
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
c0d00b62:	f000 fbad 	bl	c0d012c0 <os_longjmp>
unsigned char io_event(unsigned char channel) {
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d00b66:	2805      	cmp	r0, #5
c0d00b68:	d100      	bne.n	c0d00b6c <io_event+0x34>
c0d00b6a:	e0ef      	b.n	c0d00d4c <io_event+0x214>
c0d00b6c:	280c      	cmp	r0, #12
c0d00b6e:	d100      	bne.n	c0d00b72 <io_event+0x3a>
c0d00b70:	e23f      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00b72:	2064      	movs	r0, #100	; 0x64
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
        }
    // no break is intentional
    default:
        UX_DEFAULT_EVENT();
c0d00b74:	4ce1      	ldr	r4, [pc, #900]	; (c0d00efc <io_event+0x3c4>)
c0d00b76:	2101      	movs	r1, #1
c0d00b78:	5421      	strb	r1, [r4, r0]
c0d00b7a:	2500      	movs	r5, #0
c0d00b7c:	66a5      	str	r5, [r4, #104]	; 0x68
c0d00b7e:	4620      	mov	r0, r4
c0d00b80:	3064      	adds	r0, #100	; 0x64
c0d00b82:	f001 fb9b 	bl	c0d022bc <os_ux>
c0d00b86:	2004      	movs	r0, #4
c0d00b88:	f001 fc0a 	bl	c0d023a0 <os_sched_last_status>
c0d00b8c:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00b8e:	2869      	cmp	r0, #105	; 0x69
c0d00b90:	d000      	beq.n	c0d00b94 <io_event+0x5c>
c0d00b92:	e133      	b.n	c0d00dfc <io_event+0x2c4>
c0d00b94:	f000 fce6 	bl	c0d01564 <io_seproxyhal_init_ux>
c0d00b98:	f000 fce6 	bl	c0d01568 <io_seproxyhal_init_button>
c0d00b9c:	84e5      	strh	r5, [r4, #38]	; 0x26
c0d00b9e:	2004      	movs	r0, #4
c0d00ba0:	f001 fbfe 	bl	c0d023a0 <os_sched_last_status>
c0d00ba4:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00ba6:	2800      	cmp	r0, #0
c0d00ba8:	d100      	bne.n	c0d00bac <io_event+0x74>
c0d00baa:	e222      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00bac:	2897      	cmp	r0, #151	; 0x97
c0d00bae:	d100      	bne.n	c0d00bb2 <io_event+0x7a>
c0d00bb0:	e21f      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00bb2:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00bb4:	2800      	cmp	r0, #0
c0d00bb6:	d100      	bne.n	c0d00bba <io_event+0x82>
c0d00bb8:	e21b      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00bba:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00bbc:	212c      	movs	r1, #44	; 0x2c
c0d00bbe:	5c61      	ldrb	r1, [r4, r1]
c0d00bc0:	b280      	uxth	r0, r0
c0d00bc2:	4288      	cmp	r0, r1
c0d00bc4:	d300      	bcc.n	c0d00bc8 <io_event+0x90>
c0d00bc6:	e214      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00bc8:	f001 fbb6 	bl	c0d02338 <io_seph_is_status_sent>
c0d00bcc:	2800      	cmp	r0, #0
c0d00bce:	d000      	beq.n	c0d00bd2 <io_event+0x9a>
c0d00bd0:	e20f      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00bd2:	f001 fb3d 	bl	c0d02250 <os_perso_isonboarded>
c0d00bd6:	28aa      	cmp	r0, #170	; 0xaa
c0d00bd8:	d104      	bne.n	c0d00be4 <io_event+0xac>
c0d00bda:	f001 fb63 	bl	c0d022a4 <os_global_pin_is_validated>
c0d00bde:	28aa      	cmp	r0, #170	; 0xaa
c0d00be0:	d000      	beq.n	c0d00be4 <io_event+0xac>
c0d00be2:	e206      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00be4:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00be6:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00be8:	0149      	lsls	r1, r1, #5
c0d00bea:	1840      	adds	r0, r0, r1
c0d00bec:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00bee:	2900      	cmp	r1, #0
c0d00bf0:	d002      	beq.n	c0d00bf8 <io_event+0xc0>
c0d00bf2:	4788      	blx	r1
c0d00bf4:	2800      	cmp	r0, #0
c0d00bf6:	d007      	beq.n	c0d00c08 <io_event+0xd0>
c0d00bf8:	2801      	cmp	r0, #1
c0d00bfa:	d103      	bne.n	c0d00c04 <io_event+0xcc>
c0d00bfc:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00bfe:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00c00:	0149      	lsls	r1, r1, #5
c0d00c02:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00c04:	f000 fd08 	bl	c0d01618 <io_seproxyhal_display_default>
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
        }
    // no break is intentional
    default:
        UX_DEFAULT_EVENT();
c0d00c08:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00c0a:	1c40      	adds	r0, r0, #1
c0d00c0c:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00c0e:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00c10:	2900      	cmp	r1, #0
c0d00c12:	d1d3      	bne.n	c0d00bbc <io_event+0x84>
c0d00c14:	e1ed      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00c16:	2064      	movs	r0, #100	; 0x64
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT({});
c0d00c18:	4cd7      	ldr	r4, [pc, #860]	; (c0d00f78 <io_event+0x440>)
c0d00c1a:	2101      	movs	r1, #1
c0d00c1c:	5421      	strb	r1, [r4, r0]
c0d00c1e:	2500      	movs	r5, #0
c0d00c20:	66a5      	str	r5, [r4, #104]	; 0x68
c0d00c22:	4620      	mov	r0, r4
c0d00c24:	3064      	adds	r0, #100	; 0x64
c0d00c26:	f001 fb49 	bl	c0d022bc <os_ux>
c0d00c2a:	2004      	movs	r0, #4
c0d00c2c:	f001 fbb8 	bl	c0d023a0 <os_sched_last_status>
c0d00c30:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00c32:	2800      	cmp	r0, #0
c0d00c34:	d100      	bne.n	c0d00c38 <io_event+0x100>
c0d00c36:	e1dc      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00c38:	2869      	cmp	r0, #105	; 0x69
c0d00c3a:	d100      	bne.n	c0d00c3e <io_event+0x106>
c0d00c3c:	e160      	b.n	c0d00f00 <io_event+0x3c8>
c0d00c3e:	2897      	cmp	r0, #151	; 0x97
c0d00c40:	d100      	bne.n	c0d00c44 <io_event+0x10c>
c0d00c42:	e1d6      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00c44:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00c46:	2800      	cmp	r0, #0
c0d00c48:	d100      	bne.n	c0d00c4c <io_event+0x114>
c0d00c4a:	e1cb      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00c4c:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00c4e:	212c      	movs	r1, #44	; 0x2c
c0d00c50:	5c61      	ldrb	r1, [r4, r1]
c0d00c52:	b280      	uxth	r0, r0
c0d00c54:	4288      	cmp	r0, r1
c0d00c56:	d300      	bcc.n	c0d00c5a <io_event+0x122>
c0d00c58:	e1c4      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00c5a:	f001 fb6d 	bl	c0d02338 <io_seph_is_status_sent>
c0d00c5e:	2800      	cmp	r0, #0
c0d00c60:	d000      	beq.n	c0d00c64 <io_event+0x12c>
c0d00c62:	e1bf      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00c64:	f001 faf4 	bl	c0d02250 <os_perso_isonboarded>
c0d00c68:	28aa      	cmp	r0, #170	; 0xaa
c0d00c6a:	d104      	bne.n	c0d00c76 <io_event+0x13e>
c0d00c6c:	f001 fb1a 	bl	c0d022a4 <os_global_pin_is_validated>
c0d00c70:	28aa      	cmp	r0, #170	; 0xaa
c0d00c72:	d000      	beq.n	c0d00c76 <io_event+0x13e>
c0d00c74:	e1b6      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00c76:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00c78:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00c7a:	0149      	lsls	r1, r1, #5
c0d00c7c:	1840      	adds	r0, r0, r1
c0d00c7e:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00c80:	2900      	cmp	r1, #0
c0d00c82:	d002      	beq.n	c0d00c8a <io_event+0x152>
c0d00c84:	4788      	blx	r1
c0d00c86:	2800      	cmp	r0, #0
c0d00c88:	d007      	beq.n	c0d00c9a <io_event+0x162>
c0d00c8a:	2801      	cmp	r0, #1
c0d00c8c:	d103      	bne.n	c0d00c96 <io_event+0x15e>
c0d00c8e:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00c90:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00c92:	0149      	lsls	r1, r1, #5
c0d00c94:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00c96:	f000 fcbf 	bl	c0d01618 <io_seproxyhal_display_default>
    default:
        UX_DEFAULT_EVENT();
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT({});
c0d00c9a:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00c9c:	1c40      	adds	r0, r0, #1
c0d00c9e:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00ca0:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00ca2:	2900      	cmp	r1, #0
c0d00ca4:	d1d3      	bne.n	c0d00c4e <io_event+0x116>
c0d00ca6:	e19d      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00ca8:	2764      	movs	r7, #100	; 0x64
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00caa:	4db3      	ldr	r5, [pc, #716]	; (c0d00f78 <io_event+0x440>)
c0d00cac:	2001      	movs	r0, #1
c0d00cae:	55e8      	strb	r0, [r5, r7]
c0d00cb0:	2600      	movs	r6, #0
c0d00cb2:	66ae      	str	r6, [r5, #104]	; 0x68
c0d00cb4:	4628      	mov	r0, r5
c0d00cb6:	3064      	adds	r0, #100	; 0x64
c0d00cb8:	f001 fb00 	bl	c0d022bc <os_ux>
c0d00cbc:	2004      	movs	r0, #4
c0d00cbe:	f001 fb6f 	bl	c0d023a0 <os_sched_last_status>
c0d00cc2:	66a8      	str	r0, [r5, #104]	; 0x68
c0d00cc4:	2869      	cmp	r0, #105	; 0x69
c0d00cc6:	d000      	beq.n	c0d00cca <io_event+0x192>
c0d00cc8:	e0ca      	b.n	c0d00e60 <io_event+0x328>
c0d00cca:	f000 fc4b 	bl	c0d01564 <io_seproxyhal_init_ux>
c0d00cce:	f000 fc4b 	bl	c0d01568 <io_seproxyhal_init_button>
c0d00cd2:	84ee      	strh	r6, [r5, #38]	; 0x26
c0d00cd4:	2004      	movs	r0, #4
c0d00cd6:	f001 fb63 	bl	c0d023a0 <os_sched_last_status>
c0d00cda:	66a8      	str	r0, [r5, #104]	; 0x68
c0d00cdc:	2800      	cmp	r0, #0
c0d00cde:	d100      	bne.n	c0d00ce2 <io_event+0x1aa>
c0d00ce0:	e187      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00ce2:	2897      	cmp	r0, #151	; 0x97
c0d00ce4:	d100      	bne.n	c0d00ce8 <io_event+0x1b0>
c0d00ce6:	e184      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00ce8:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00cea:	2800      	cmp	r0, #0
c0d00cec:	d100      	bne.n	c0d00cf0 <io_event+0x1b8>
c0d00cee:	e180      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00cf0:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d00cf2:	212c      	movs	r1, #44	; 0x2c
c0d00cf4:	5c69      	ldrb	r1, [r5, r1]
c0d00cf6:	b280      	uxth	r0, r0
c0d00cf8:	4288      	cmp	r0, r1
c0d00cfa:	d300      	bcc.n	c0d00cfe <io_event+0x1c6>
c0d00cfc:	e179      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00cfe:	f001 fb1b 	bl	c0d02338 <io_seph_is_status_sent>
c0d00d02:	2800      	cmp	r0, #0
c0d00d04:	d000      	beq.n	c0d00d08 <io_event+0x1d0>
c0d00d06:	e174      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00d08:	f001 faa2 	bl	c0d02250 <os_perso_isonboarded>
c0d00d0c:	28aa      	cmp	r0, #170	; 0xaa
c0d00d0e:	d104      	bne.n	c0d00d1a <io_event+0x1e2>
c0d00d10:	f001 fac8 	bl	c0d022a4 <os_global_pin_is_validated>
c0d00d14:	28aa      	cmp	r0, #170	; 0xaa
c0d00d16:	d000      	beq.n	c0d00d1a <io_event+0x1e2>
c0d00d18:	e16b      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00d1a:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00d1c:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d00d1e:	0149      	lsls	r1, r1, #5
c0d00d20:	1840      	adds	r0, r0, r1
c0d00d22:	6b29      	ldr	r1, [r5, #48]	; 0x30
c0d00d24:	2900      	cmp	r1, #0
c0d00d26:	d002      	beq.n	c0d00d2e <io_event+0x1f6>
c0d00d28:	4788      	blx	r1
c0d00d2a:	2800      	cmp	r0, #0
c0d00d2c:	d007      	beq.n	c0d00d3e <io_event+0x206>
c0d00d2e:	2801      	cmp	r0, #1
c0d00d30:	d103      	bne.n	c0d00d3a <io_event+0x202>
c0d00d32:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00d34:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d00d36:	0149      	lsls	r1, r1, #5
c0d00d38:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00d3a:	f000 fc6d 	bl	c0d01618 <io_seproxyhal_display_default>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT({});
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00d3e:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d00d40:	1c40      	adds	r0, r0, #1
c0d00d42:	84e8      	strh	r0, [r5, #38]	; 0x26
c0d00d44:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d00d46:	2900      	cmp	r1, #0
c0d00d48:	d1d3      	bne.n	c0d00cf2 <io_event+0x1ba>
c0d00d4a:	e152      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00d4c:	2064      	movs	r0, #100	; 0x64
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00d4e:	4cd5      	ldr	r4, [pc, #852]	; (c0d010a4 <io_event+0x56c>)
c0d00d50:	2101      	movs	r1, #1
c0d00d52:	5421      	strb	r1, [r4, r0]
c0d00d54:	2600      	movs	r6, #0
c0d00d56:	66a6      	str	r6, [r4, #104]	; 0x68
c0d00d58:	4620      	mov	r0, r4
c0d00d5a:	3064      	adds	r0, #100	; 0x64
c0d00d5c:	f001 faae 	bl	c0d022bc <os_ux>
c0d00d60:	2004      	movs	r0, #4
c0d00d62:	f001 fb1d 	bl	c0d023a0 <os_sched_last_status>
c0d00d66:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00d68:	2800      	cmp	r0, #0
c0d00d6a:	d100      	bne.n	c0d00d6e <io_event+0x236>
c0d00d6c:	e141      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00d6e:	2897      	cmp	r0, #151	; 0x97
c0d00d70:	d100      	bne.n	c0d00d74 <io_event+0x23c>
c0d00d72:	e13e      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00d74:	2869      	cmp	r0, #105	; 0x69
c0d00d76:	d000      	beq.n	c0d00d7a <io_event+0x242>
c0d00d78:	e100      	b.n	c0d00f7c <io_event+0x444>
c0d00d7a:	f000 fbf3 	bl	c0d01564 <io_seproxyhal_init_ux>
c0d00d7e:	f000 fbf3 	bl	c0d01568 <io_seproxyhal_init_button>
c0d00d82:	84e6      	strh	r6, [r4, #38]	; 0x26
c0d00d84:	2004      	movs	r0, #4
c0d00d86:	f001 fb0b 	bl	c0d023a0 <os_sched_last_status>
c0d00d8a:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00d8c:	2800      	cmp	r0, #0
c0d00d8e:	d100      	bne.n	c0d00d92 <io_event+0x25a>
c0d00d90:	e12f      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00d92:	2897      	cmp	r0, #151	; 0x97
c0d00d94:	d100      	bne.n	c0d00d98 <io_event+0x260>
c0d00d96:	e12c      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00d98:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00d9a:	2800      	cmp	r0, #0
c0d00d9c:	d100      	bne.n	c0d00da0 <io_event+0x268>
c0d00d9e:	e128      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00da0:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00da2:	212c      	movs	r1, #44	; 0x2c
c0d00da4:	5c61      	ldrb	r1, [r4, r1]
c0d00da6:	b280      	uxth	r0, r0
c0d00da8:	4288      	cmp	r0, r1
c0d00daa:	d300      	bcc.n	c0d00dae <io_event+0x276>
c0d00dac:	e121      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00dae:	f001 fac3 	bl	c0d02338 <io_seph_is_status_sent>
c0d00db2:	2800      	cmp	r0, #0
c0d00db4:	d000      	beq.n	c0d00db8 <io_event+0x280>
c0d00db6:	e11c      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00db8:	f001 fa4a 	bl	c0d02250 <os_perso_isonboarded>
c0d00dbc:	28aa      	cmp	r0, #170	; 0xaa
c0d00dbe:	d104      	bne.n	c0d00dca <io_event+0x292>
c0d00dc0:	f001 fa70 	bl	c0d022a4 <os_global_pin_is_validated>
c0d00dc4:	28aa      	cmp	r0, #170	; 0xaa
c0d00dc6:	d000      	beq.n	c0d00dca <io_event+0x292>
c0d00dc8:	e113      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00dca:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00dcc:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00dce:	0149      	lsls	r1, r1, #5
c0d00dd0:	1840      	adds	r0, r0, r1
c0d00dd2:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00dd4:	2900      	cmp	r1, #0
c0d00dd6:	d002      	beq.n	c0d00dde <io_event+0x2a6>
c0d00dd8:	4788      	blx	r1
c0d00dda:	2800      	cmp	r0, #0
c0d00ddc:	d007      	beq.n	c0d00dee <io_event+0x2b6>
c0d00dde:	2801      	cmp	r0, #1
c0d00de0:	d103      	bne.n	c0d00dea <io_event+0x2b2>
c0d00de2:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00de4:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00de6:	0149      	lsls	r1, r1, #5
c0d00de8:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00dea:	f000 fc15 	bl	c0d01618 <io_seproxyhal_display_default>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00dee:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00df0:	1c40      	adds	r0, r0, #1
c0d00df2:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00df4:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00df6:	2900      	cmp	r1, #0
c0d00df8:	d1d3      	bne.n	c0d00da2 <io_event+0x26a>
c0d00dfa:	e0fa      	b.n	c0d00ff2 <io_event+0x4ba>
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
        }
    // no break is intentional
    default:
        UX_DEFAULT_EVENT();
c0d00dfc:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00dfe:	2800      	cmp	r0, #0
c0d00e00:	d100      	bne.n	c0d00e04 <io_event+0x2cc>
c0d00e02:	e0ef      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00e04:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00e06:	212c      	movs	r1, #44	; 0x2c
c0d00e08:	5c61      	ldrb	r1, [r4, r1]
c0d00e0a:	b280      	uxth	r0, r0
c0d00e0c:	4288      	cmp	r0, r1
c0d00e0e:	d300      	bcc.n	c0d00e12 <io_event+0x2da>
c0d00e10:	e0e8      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00e12:	f001 fa91 	bl	c0d02338 <io_seph_is_status_sent>
c0d00e16:	2800      	cmp	r0, #0
c0d00e18:	d000      	beq.n	c0d00e1c <io_event+0x2e4>
c0d00e1a:	e0e3      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00e1c:	f001 fa18 	bl	c0d02250 <os_perso_isonboarded>
c0d00e20:	28aa      	cmp	r0, #170	; 0xaa
c0d00e22:	d104      	bne.n	c0d00e2e <io_event+0x2f6>
c0d00e24:	f001 fa3e 	bl	c0d022a4 <os_global_pin_is_validated>
c0d00e28:	28aa      	cmp	r0, #170	; 0xaa
c0d00e2a:	d000      	beq.n	c0d00e2e <io_event+0x2f6>
c0d00e2c:	e0da      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00e2e:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00e30:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00e32:	0149      	lsls	r1, r1, #5
c0d00e34:	1840      	adds	r0, r0, r1
c0d00e36:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00e38:	2900      	cmp	r1, #0
c0d00e3a:	d002      	beq.n	c0d00e42 <io_event+0x30a>
c0d00e3c:	4788      	blx	r1
c0d00e3e:	2800      	cmp	r0, #0
c0d00e40:	d007      	beq.n	c0d00e52 <io_event+0x31a>
c0d00e42:	2801      	cmp	r0, #1
c0d00e44:	d103      	bne.n	c0d00e4e <io_event+0x316>
c0d00e46:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00e48:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00e4a:	0149      	lsls	r1, r1, #5
c0d00e4c:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00e4e:	f000 fbe3 	bl	c0d01618 <io_seproxyhal_display_default>
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
        }
    // no break is intentional
    default:
        UX_DEFAULT_EVENT();
c0d00e52:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00e54:	1c40      	adds	r0, r0, #1
c0d00e56:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00e58:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00e5a:	2900      	cmp	r1, #0
c0d00e5c:	d1d3      	bne.n	c0d00e06 <io_event+0x2ce>
c0d00e5e:	e0c1      	b.n	c0d00fe4 <io_event+0x4ac>
c0d00e60:	4604      	mov	r4, r0
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT({});
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00e62:	6be8      	ldr	r0, [r5, #60]	; 0x3c
c0d00e64:	2800      	cmp	r0, #0
c0d00e66:	d00e      	beq.n	c0d00e86 <io_event+0x34e>
c0d00e68:	2864      	cmp	r0, #100	; 0x64
c0d00e6a:	4601      	mov	r1, r0
c0d00e6c:	d300      	bcc.n	c0d00e70 <io_event+0x338>
c0d00e6e:	4639      	mov	r1, r7
c0d00e70:	1a40      	subs	r0, r0, r1
c0d00e72:	63e8      	str	r0, [r5, #60]	; 0x3c
c0d00e74:	d107      	bne.n	c0d00e86 <io_event+0x34e>
c0d00e76:	6ba9      	ldr	r1, [r5, #56]	; 0x38
c0d00e78:	2900      	cmp	r1, #0
c0d00e7a:	d100      	bne.n	c0d00e7e <io_event+0x346>
c0d00e7c:	e0c2      	b.n	c0d01004 <io_event+0x4cc>
c0d00e7e:	6c28      	ldr	r0, [r5, #64]	; 0x40
c0d00e80:	63e8      	str	r0, [r5, #60]	; 0x3c
c0d00e82:	2000      	movs	r0, #0
c0d00e84:	4788      	blx	r1
c0d00e86:	2c00      	cmp	r4, #0
c0d00e88:	d100      	bne.n	c0d00e8c <io_event+0x354>
c0d00e8a:	e0b2      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00e8c:	2c97      	cmp	r4, #151	; 0x97
c0d00e8e:	d100      	bne.n	c0d00e92 <io_event+0x35a>
c0d00e90:	e0af      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00e92:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00e94:	2800      	cmp	r0, #0
c0d00e96:	d029      	beq.n	c0d00eec <io_event+0x3b4>
c0d00e98:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d00e9a:	212c      	movs	r1, #44	; 0x2c
c0d00e9c:	5c69      	ldrb	r1, [r5, r1]
c0d00e9e:	b280      	uxth	r0, r0
c0d00ea0:	4288      	cmp	r0, r1
c0d00ea2:	d223      	bcs.n	c0d00eec <io_event+0x3b4>
c0d00ea4:	f001 fa48 	bl	c0d02338 <io_seph_is_status_sent>
c0d00ea8:	2800      	cmp	r0, #0
c0d00eaa:	d11f      	bne.n	c0d00eec <io_event+0x3b4>
c0d00eac:	f001 f9d0 	bl	c0d02250 <os_perso_isonboarded>
c0d00eb0:	28aa      	cmp	r0, #170	; 0xaa
c0d00eb2:	d103      	bne.n	c0d00ebc <io_event+0x384>
c0d00eb4:	f001 f9f6 	bl	c0d022a4 <os_global_pin_is_validated>
c0d00eb8:	28aa      	cmp	r0, #170	; 0xaa
c0d00eba:	d117      	bne.n	c0d00eec <io_event+0x3b4>
c0d00ebc:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00ebe:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d00ec0:	0149      	lsls	r1, r1, #5
c0d00ec2:	1840      	adds	r0, r0, r1
c0d00ec4:	6b29      	ldr	r1, [r5, #48]	; 0x30
c0d00ec6:	2900      	cmp	r1, #0
c0d00ec8:	d002      	beq.n	c0d00ed0 <io_event+0x398>
c0d00eca:	4788      	blx	r1
c0d00ecc:	2800      	cmp	r0, #0
c0d00ece:	d007      	beq.n	c0d00ee0 <io_event+0x3a8>
c0d00ed0:	2801      	cmp	r0, #1
c0d00ed2:	d103      	bne.n	c0d00edc <io_event+0x3a4>
c0d00ed4:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00ed6:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d00ed8:	0149      	lsls	r1, r1, #5
c0d00eda:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00edc:	f000 fb9c 	bl	c0d01618 <io_seproxyhal_display_default>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT({});
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00ee0:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d00ee2:	1c40      	adds	r0, r0, #1
c0d00ee4:	84e8      	strh	r0, [r5, #38]	; 0x26
c0d00ee6:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d00ee8:	2900      	cmp	r1, #0
c0d00eea:	d1d6      	bne.n	c0d00e9a <io_event+0x362>
c0d00eec:	202c      	movs	r0, #44	; 0x2c
c0d00eee:	5c28      	ldrb	r0, [r5, r0]
c0d00ef0:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d00ef2:	e07a      	b.n	c0d00fea <io_event+0x4b2>
c0d00ef4:	20001d74 	.word	0x20001d74
c0d00ef8:	20001f48 	.word	0x20001f48
c0d00efc:	2000182c 	.word	0x2000182c
    default:
        UX_DEFAULT_EVENT();
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT({});
c0d00f00:	f000 fb30 	bl	c0d01564 <io_seproxyhal_init_ux>
c0d00f04:	f000 fb30 	bl	c0d01568 <io_seproxyhal_init_button>
c0d00f08:	84e5      	strh	r5, [r4, #38]	; 0x26
c0d00f0a:	2004      	movs	r0, #4
c0d00f0c:	f001 fa48 	bl	c0d023a0 <os_sched_last_status>
c0d00f10:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00f12:	2800      	cmp	r0, #0
c0d00f14:	d06d      	beq.n	c0d00ff2 <io_event+0x4ba>
c0d00f16:	2897      	cmp	r0, #151	; 0x97
c0d00f18:	d06b      	beq.n	c0d00ff2 <io_event+0x4ba>
c0d00f1a:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00f1c:	2800      	cmp	r0, #0
c0d00f1e:	d068      	beq.n	c0d00ff2 <io_event+0x4ba>
c0d00f20:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00f22:	212c      	movs	r1, #44	; 0x2c
c0d00f24:	5c61      	ldrb	r1, [r4, r1]
c0d00f26:	b280      	uxth	r0, r0
c0d00f28:	4288      	cmp	r0, r1
c0d00f2a:	d262      	bcs.n	c0d00ff2 <io_event+0x4ba>
c0d00f2c:	f001 fa04 	bl	c0d02338 <io_seph_is_status_sent>
c0d00f30:	2800      	cmp	r0, #0
c0d00f32:	d15e      	bne.n	c0d00ff2 <io_event+0x4ba>
c0d00f34:	f001 f98c 	bl	c0d02250 <os_perso_isonboarded>
c0d00f38:	28aa      	cmp	r0, #170	; 0xaa
c0d00f3a:	d103      	bne.n	c0d00f44 <io_event+0x40c>
c0d00f3c:	f001 f9b2 	bl	c0d022a4 <os_global_pin_is_validated>
c0d00f40:	28aa      	cmp	r0, #170	; 0xaa
c0d00f42:	d156      	bne.n	c0d00ff2 <io_event+0x4ba>
c0d00f44:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00f46:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00f48:	0149      	lsls	r1, r1, #5
c0d00f4a:	1840      	adds	r0, r0, r1
c0d00f4c:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00f4e:	2900      	cmp	r1, #0
c0d00f50:	d002      	beq.n	c0d00f58 <io_event+0x420>
c0d00f52:	4788      	blx	r1
c0d00f54:	2800      	cmp	r0, #0
c0d00f56:	d007      	beq.n	c0d00f68 <io_event+0x430>
c0d00f58:	2801      	cmp	r0, #1
c0d00f5a:	d103      	bne.n	c0d00f64 <io_event+0x42c>
c0d00f5c:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00f5e:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00f60:	0149      	lsls	r1, r1, #5
c0d00f62:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00f64:	f000 fb58 	bl	c0d01618 <io_seproxyhal_display_default>
    default:
        UX_DEFAULT_EVENT();
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT({});
c0d00f68:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00f6a:	1c40      	adds	r0, r0, #1
c0d00f6c:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00f6e:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00f70:	2900      	cmp	r1, #0
c0d00f72:	d1d6      	bne.n	c0d00f22 <io_event+0x3ea>
c0d00f74:	e03d      	b.n	c0d00ff2 <io_event+0x4ba>
c0d00f76:	46c0      	nop			; (mov r8, r8)
c0d00f78:	2000182c 	.word	0x2000182c
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00f7c:	6b60      	ldr	r0, [r4, #52]	; 0x34
c0d00f7e:	2800      	cmp	r0, #0
c0d00f80:	d003      	beq.n	c0d00f8a <io_event+0x452>
c0d00f82:	78e9      	ldrb	r1, [r5, #3]
c0d00f84:	0849      	lsrs	r1, r1, #1
c0d00f86:	f000 fbb7 	bl	c0d016f8 <io_seproxyhal_button_push>
c0d00f8a:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00f8c:	2800      	cmp	r0, #0
c0d00f8e:	d029      	beq.n	c0d00fe4 <io_event+0x4ac>
c0d00f90:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00f92:	212c      	movs	r1, #44	; 0x2c
c0d00f94:	5c61      	ldrb	r1, [r4, r1]
c0d00f96:	b280      	uxth	r0, r0
c0d00f98:	4288      	cmp	r0, r1
c0d00f9a:	d223      	bcs.n	c0d00fe4 <io_event+0x4ac>
c0d00f9c:	f001 f9cc 	bl	c0d02338 <io_seph_is_status_sent>
c0d00fa0:	2800      	cmp	r0, #0
c0d00fa2:	d11f      	bne.n	c0d00fe4 <io_event+0x4ac>
c0d00fa4:	f001 f954 	bl	c0d02250 <os_perso_isonboarded>
c0d00fa8:	28aa      	cmp	r0, #170	; 0xaa
c0d00faa:	d103      	bne.n	c0d00fb4 <io_event+0x47c>
c0d00fac:	f001 f97a 	bl	c0d022a4 <os_global_pin_is_validated>
c0d00fb0:	28aa      	cmp	r0, #170	; 0xaa
c0d00fb2:	d117      	bne.n	c0d00fe4 <io_event+0x4ac>
c0d00fb4:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00fb6:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00fb8:	0149      	lsls	r1, r1, #5
c0d00fba:	1840      	adds	r0, r0, r1
c0d00fbc:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00fbe:	2900      	cmp	r1, #0
c0d00fc0:	d002      	beq.n	c0d00fc8 <io_event+0x490>
c0d00fc2:	4788      	blx	r1
c0d00fc4:	2800      	cmp	r0, #0
c0d00fc6:	d007      	beq.n	c0d00fd8 <io_event+0x4a0>
c0d00fc8:	2801      	cmp	r0, #1
c0d00fca:	d103      	bne.n	c0d00fd4 <io_event+0x49c>
c0d00fcc:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00fce:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00fd0:	0149      	lsls	r1, r1, #5
c0d00fd2:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00fd4:	f000 fb20 	bl	c0d01618 <io_seproxyhal_display_default>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00fd8:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00fda:	1c40      	adds	r0, r0, #1
c0d00fdc:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00fde:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00fe0:	2900      	cmp	r1, #0
c0d00fe2:	d1d6      	bne.n	c0d00f92 <io_event+0x45a>
c0d00fe4:	202c      	movs	r0, #44	; 0x2c
c0d00fe6:	5c20      	ldrb	r0, [r4, r0]
c0d00fe8:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00fea:	4281      	cmp	r1, r0
c0d00fec:	d301      	bcc.n	c0d00ff2 <io_event+0x4ba>
c0d00fee:	f001 f9a3 	bl	c0d02338 <io_seph_is_status_sent>
        });
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00ff2:	f001 f9a1 	bl	c0d02338 <io_seph_is_status_sent>
c0d00ff6:	2800      	cmp	r0, #0
c0d00ff8:	d101      	bne.n	c0d00ffe <io_event+0x4c6>
        io_seproxyhal_general_status();
c0d00ffa:	f000 f96f 	bl	c0d012dc <io_seproxyhal_general_status>
c0d00ffe:	2001      	movs	r0, #1
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d01000:	b001      	add	sp, #4
c0d01002:	bdf0      	pop	{r4, r5, r6, r7, pc}
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT({});
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d01004:	4828      	ldr	r0, [pc, #160]	; (c0d010a8 <io_event+0x570>)
c0d01006:	6801      	ldr	r1, [r0, #0]
c0d01008:	2900      	cmp	r1, #0
c0d0100a:	d100      	bne.n	c0d0100e <io_event+0x4d6>
c0d0100c:	e73b      	b.n	c0d00e86 <io_event+0x34e>
c0d0100e:	2c00      	cmp	r4, #0
c0d01010:	d0ef      	beq.n	c0d00ff2 <io_event+0x4ba>
c0d01012:	2c97      	cmp	r4, #151	; 0x97
c0d01014:	d0ed      	beq.n	c0d00ff2 <io_event+0x4ba>
c0d01016:	4f25      	ldr	r7, [pc, #148]	; (c0d010ac <io_event+0x574>)
c0d01018:	6838      	ldr	r0, [r7, #0]
c0d0101a:	1c40      	adds	r0, r0, #1
c0d0101c:	f003 f910 	bl	c0d04240 <__aeabi_uidivmod>
c0d01020:	6039      	str	r1, [r7, #0]
c0d01022:	f000 fa9f 	bl	c0d01564 <io_seproxyhal_init_ux>
c0d01026:	f000 fa9f 	bl	c0d01568 <io_seproxyhal_init_button>
c0d0102a:	84ee      	strh	r6, [r5, #38]	; 0x26
c0d0102c:	2004      	movs	r0, #4
c0d0102e:	f001 f9b7 	bl	c0d023a0 <os_sched_last_status>
c0d01032:	66a8      	str	r0, [r5, #104]	; 0x68
c0d01034:	2800      	cmp	r0, #0
c0d01036:	d100      	bne.n	c0d0103a <io_event+0x502>
c0d01038:	e725      	b.n	c0d00e86 <io_event+0x34e>
c0d0103a:	2897      	cmp	r0, #151	; 0x97
c0d0103c:	d100      	bne.n	c0d01040 <io_event+0x508>
c0d0103e:	e722      	b.n	c0d00e86 <io_event+0x34e>
c0d01040:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d01042:	2800      	cmp	r0, #0
c0d01044:	d100      	bne.n	c0d01048 <io_event+0x510>
c0d01046:	e71e      	b.n	c0d00e86 <io_event+0x34e>
c0d01048:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d0104a:	212c      	movs	r1, #44	; 0x2c
c0d0104c:	5c69      	ldrb	r1, [r5, r1]
c0d0104e:	b280      	uxth	r0, r0
c0d01050:	4288      	cmp	r0, r1
c0d01052:	d300      	bcc.n	c0d01056 <io_event+0x51e>
c0d01054:	e717      	b.n	c0d00e86 <io_event+0x34e>
c0d01056:	f001 f96f 	bl	c0d02338 <io_seph_is_status_sent>
c0d0105a:	2800      	cmp	r0, #0
c0d0105c:	d000      	beq.n	c0d01060 <io_event+0x528>
c0d0105e:	e712      	b.n	c0d00e86 <io_event+0x34e>
c0d01060:	f001 f8f6 	bl	c0d02250 <os_perso_isonboarded>
c0d01064:	28aa      	cmp	r0, #170	; 0xaa
c0d01066:	d104      	bne.n	c0d01072 <io_event+0x53a>
c0d01068:	f001 f91c 	bl	c0d022a4 <os_global_pin_is_validated>
c0d0106c:	28aa      	cmp	r0, #170	; 0xaa
c0d0106e:	d000      	beq.n	c0d01072 <io_event+0x53a>
c0d01070:	e709      	b.n	c0d00e86 <io_event+0x34e>
c0d01072:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d01074:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d01076:	0149      	lsls	r1, r1, #5
c0d01078:	1840      	adds	r0, r0, r1
c0d0107a:	6b29      	ldr	r1, [r5, #48]	; 0x30
c0d0107c:	2900      	cmp	r1, #0
c0d0107e:	d002      	beq.n	c0d01086 <io_event+0x54e>
c0d01080:	4788      	blx	r1
c0d01082:	2800      	cmp	r0, #0
c0d01084:	d007      	beq.n	c0d01096 <io_event+0x55e>
c0d01086:	2801      	cmp	r0, #1
c0d01088:	d103      	bne.n	c0d01092 <io_event+0x55a>
c0d0108a:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d0108c:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d0108e:	0149      	lsls	r1, r1, #5
c0d01090:	1840      	adds	r0, r0, r1
    return;
}

// override point, but nothing more to do
void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d01092:	f000 fac1 	bl	c0d01618 <io_seproxyhal_display_default>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        UX_DISPLAYED_EVENT({});
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d01096:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d01098:	1c40      	adds	r0, r0, #1
c0d0109a:	84e8      	strh	r0, [r5, #38]	; 0x26
c0d0109c:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d0109e:	2900      	cmp	r1, #0
c0d010a0:	d1d3      	bne.n	c0d0104a <io_event+0x512>
c0d010a2:	e6f0      	b.n	c0d00e86 <io_event+0x34e>
c0d010a4:	2000182c 	.word	0x2000182c
c0d010a8:	20001abc 	.word	0x20001abc
c0d010ac:	20001828 	.word	0x20001828

c0d010b0 <app_exit>:

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

void app_exit(void) {
c0d010b0:	b510      	push	{r4, lr}
c0d010b2:	b08c      	sub	sp, #48	; 0x30
c0d010b4:	466c      	mov	r4, sp
    BEGIN_TRY_L(exit) {
        TRY_L(exit) {
c0d010b6:	4620      	mov	r0, r4
c0d010b8:	f003 f95e 	bl	c0d04378 <setjmp>
c0d010bc:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d010be:	0400      	lsls	r0, r0, #16
c0d010c0:	d106      	bne.n	c0d010d0 <app_exit+0x20>
c0d010c2:	4668      	mov	r0, sp
c0d010c4:	f001 f960 	bl	c0d02388 <try_context_set>
c0d010c8:	900a      	str	r0, [sp, #40]	; 0x28
c0d010ca:	20ff      	movs	r0, #255	; 0xff
            os_sched_exit(-1);
c0d010cc:	f001 f91c 	bl	c0d02308 <os_sched_exit>
        }
        FINALLY_L(exit) {
c0d010d0:	f001 f94e 	bl	c0d02370 <try_context_get>
c0d010d4:	4669      	mov	r1, sp
c0d010d6:	4288      	cmp	r0, r1
c0d010d8:	d102      	bne.n	c0d010e0 <app_exit+0x30>
c0d010da:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d010dc:	f001 f954 	bl	c0d02388 <try_context_set>
c0d010e0:	4668      	mov	r0, sp
        }
    }
    END_TRY_L(exit);
c0d010e2:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d010e4:	2800      	cmp	r0, #0
c0d010e6:	d101      	bne.n	c0d010ec <app_exit+0x3c>
}
c0d010e8:	b00c      	add	sp, #48	; 0x30
c0d010ea:	bd10      	pop	{r4, pc}
            os_sched_exit(-1);
        }
        FINALLY_L(exit) {
        }
    }
    END_TRY_L(exit);
c0d010ec:	f000 f8e8 	bl	c0d012c0 <os_longjmp>

c0d010f0 <readNetworkIdFromBip32path>:
#include "nemHelpers.h"
#define MAX_SAFE_INTEGER 9007199254740991

static const uint8_t AMOUNT_MAX_SIZE = 17;

uint8_t readNetworkIdFromBip32path(uint32_t bip32Path[]) {
c0d010f0:	b580      	push	{r7, lr}
    uint8_t outNetworkId;
    switch(bip32Path[2]) {
c0d010f2:	6880      	ldr	r0, [r0, #8]
c0d010f4:	490c      	ldr	r1, [pc, #48]	; (c0d01128 <readNetworkIdFromBip32path+0x38>)
c0d010f6:	1840      	adds	r0, r0, r1
c0d010f8:	2103      	movs	r1, #3
c0d010fa:	41c8      	rors	r0, r1
c0d010fc:	2805      	cmp	r0, #5
c0d010fe:	dc03      	bgt.n	c0d01108 <readNetworkIdFromBip32path+0x18>
c0d01100:	2800      	cmp	r0, #0
c0d01102:	d105      	bne.n	c0d01110 <readNetworkIdFromBip32path+0x20>
c0d01104:	2060      	movs	r0, #96	; 0x60
            outNetworkId = 144; //S
            break;
        default:
            THROW(0x6a80);
    }
    return outNetworkId;
c0d01106:	bd80      	pop	{r7, pc}

static const uint8_t AMOUNT_MAX_SIZE = 17;

uint8_t readNetworkIdFromBip32path(uint32_t bip32Path[]) {
    uint8_t outNetworkId;
    switch(bip32Path[2]) {
c0d01108:	2806      	cmp	r0, #6
c0d0110a:	d105      	bne.n	c0d01118 <readNetworkIdFromBip32path+0x28>
c0d0110c:	2090      	movs	r0, #144	; 0x90
            outNetworkId = 144; //S
            break;
        default:
            THROW(0x6a80);
    }
    return outNetworkId;
c0d0110e:	bd80      	pop	{r7, pc}

static const uint8_t AMOUNT_MAX_SIZE = 17;

uint8_t readNetworkIdFromBip32path(uint32_t bip32Path[]) {
    uint8_t outNetworkId;
    switch(bip32Path[2]) {
c0d01110:	2801      	cmp	r0, #1
c0d01112:	d105      	bne.n	c0d01120 <readNetworkIdFromBip32path+0x30>
c0d01114:	2068      	movs	r0, #104	; 0x68
            outNetworkId = 144; //S
            break;
        default:
            THROW(0x6a80);
    }
    return outNetworkId;
c0d01116:	bd80      	pop	{r7, pc}

static const uint8_t AMOUNT_MAX_SIZE = 17;

uint8_t readNetworkIdFromBip32path(uint32_t bip32Path[]) {
    uint8_t outNetworkId;
    switch(bip32Path[2]) {
c0d01118:	2807      	cmp	r0, #7
c0d0111a:	d101      	bne.n	c0d01120 <readNetworkIdFromBip32path+0x30>
c0d0111c:	2098      	movs	r0, #152	; 0x98
            outNetworkId = 144; //S
            break;
        default:
            THROW(0x6a80);
    }
    return outNetworkId;
c0d0111e:	bd80      	pop	{r7, pc}
c0d01120:	20d5      	movs	r0, #213	; 0xd5
c0d01122:	01c0      	lsls	r0, r0, #7
            break;
        case 0x80000090:
            outNetworkId = 144; //S
            break;
        default:
            THROW(0x6a80);
c0d01124:	f000 f8cc 	bl	c0d012c0 <os_longjmp>
c0d01128:	7fffffa0 	.word	0x7fffffa0

c0d0112c <reverseBytes>:
        out[j] = tmpCh[j];
    }
    out[len] = '\0';
}

uint8_t *reverseBytes(uint8_t *sourceArray, uint16_t len){
c0d0112c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0112e:	af03      	add	r7, sp, #12
c0d01130:	b081      	sub	sp, #4
c0d01132:	466e      	mov	r6, sp
    uint8_t outArray[len];
c0d01134:	1dca      	adds	r2, r1, #7
c0d01136:	2307      	movs	r3, #7
c0d01138:	439a      	bics	r2, r3
c0d0113a:	466b      	mov	r3, sp
c0d0113c:	1a9a      	subs	r2, r3, r2
c0d0113e:	4695      	mov	sp, r2
    for (uint8_t j=0; j<len; j++) {
c0d01140:	2900      	cmp	r1, #0
c0d01142:	d009      	beq.n	c0d01158 <reverseBytes+0x2c>
c0d01144:	2300      	movs	r3, #0
c0d01146:	461c      	mov	r4, r3
        outArray[j] = sourceArray[len - j -1];
c0d01148:	43dd      	mvns	r5, r3
c0d0114a:	186d      	adds	r5, r5, r1
c0d0114c:	5d45      	ldrb	r5, [r0, r5]
c0d0114e:	54d5      	strb	r5, [r2, r3]
    out[len] = '\0';
}

uint8_t *reverseBytes(uint8_t *sourceArray, uint16_t len){
    uint8_t outArray[len];
    for (uint8_t j=0; j<len; j++) {
c0d01150:	1c64      	adds	r4, r4, #1
c0d01152:	b2e3      	uxtb	r3, r4
c0d01154:	4299      	cmp	r1, r3
c0d01156:	d8f7      	bhi.n	c0d01148 <reverseBytes+0x1c>
        outArray[j] = sourceArray[len - j -1];
    }
    return outArray;
}
c0d01158:	4610      	mov	r0, r2
c0d0115a:	1ffc      	subs	r4, r7, #7
c0d0115c:	3c05      	subs	r4, #5
c0d0115e:	46a5      	mov	sp, r4
c0d01160:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01162 <getUint16>:
    }

}

uint16_t getUint16(uint8_t *buffer) {
    return ((uint16_t)buffer[1]) | ((uint16_t)buffer[0] << 8);
c0d01162:	7841      	ldrb	r1, [r0, #1]
c0d01164:	7800      	ldrb	r0, [r0, #0]
c0d01166:	0200      	lsls	r0, r0, #8
c0d01168:	1840      	adds	r0, r0, r1
c0d0116a:	b280      	uxth	r0, r0
c0d0116c:	4770      	bx	lr
	...

c0d01170 <to_nem_public_key_and_address>:
    return ((uint64_t)data[7]) | ((uint64_t)data[6] << 8) | ((uint64_t)data[5] << 16) |
             ((uint64_t)data[4] << 24) | ((uint64_t)data[3] << 32) | ((uint64_t)data[2] << 40) |
             ((uint64_t)data[1] << 48) | ((uint64_t)data[0] << 56);
}

void to_nem_public_key_and_address(cx_ecfp_public_key_t *inPublicKey, uint8_t inNetworkId, unsigned int inAlgo, uint8_t *outNemPublicKey, unsigned char *outNemAddress) {
c0d01170:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01172:	b0ff      	sub	sp, #508	; 0x1fc
c0d01174:	b0ff      	sub	sp, #508	; 0x1fc
c0d01176:	b097      	sub	sp, #92	; 0x5c
c0d01178:	461e      	mov	r6, r3
c0d0117a:	9104      	str	r1, [sp, #16]
    uint8_t i;
    for (i=0; i<32; i++) {
c0d0117c:	4601      	mov	r1, r0
c0d0117e:	3148      	adds	r1, #72	; 0x48
c0d01180:	2200      	movs	r2, #0
c0d01182:	4b2b      	ldr	r3, [pc, #172]	; (c0d01230 <to_nem_public_key_and_address+0xc0>)
c0d01184:	446b      	add	r3, sp
c0d01186:	681b      	ldr	r3, [r3, #0]
c0d01188:	9305      	str	r3, [sp, #20]
        outNemPublicKey[i] = inPublicKey->W[64 - i];
c0d0118a:	780b      	ldrb	r3, [r1, #0]
c0d0118c:	54b3      	strb	r3, [r6, r2]
             ((uint64_t)data[1] << 48) | ((uint64_t)data[0] << 56);
}

void to_nem_public_key_and_address(cx_ecfp_public_key_t *inPublicKey, uint8_t inNetworkId, unsigned int inAlgo, uint8_t *outNemPublicKey, unsigned char *outNemAddress) {
    uint8_t i;
    for (i=0; i<32; i++) {
c0d0118e:	1e49      	subs	r1, r1, #1
c0d01190:	1c52      	adds	r2, r2, #1
c0d01192:	2a20      	cmp	r2, #32
c0d01194:	d1f9      	bne.n	c0d0118a <to_nem_public_key_and_address+0x1a>
c0d01196:	2128      	movs	r1, #40	; 0x28
        outNemPublicKey[i] = inPublicKey->W[64 - i];
    }

    if ((inPublicKey->W[32] & 1) != 0) {
c0d01198:	5c40      	ldrb	r0, [r0, r1]
c0d0119a:	07c0      	lsls	r0, r0, #31
c0d0119c:	d003      	beq.n	c0d011a6 <to_nem_public_key_and_address+0x36>
        outNemPublicKey[31] |= 0x80;
c0d0119e:	7ff0      	ldrb	r0, [r6, #31]
c0d011a0:	2180      	movs	r1, #128	; 0x80
c0d011a2:	4301      	orrs	r1, r0
c0d011a4:	77f1      	strb	r1, [r6, #31]
c0d011a6:	2501      	movs	r5, #1
c0d011a8:	022c      	lsls	r4, r5, #8
c0d011aa:	afaa      	add	r7, sp, #680	; 0x2a8
    }    

    cx_sha3_t hash1;
    cx_sha3_t temphash;
    
    cx_sha3_init(&hash1, 256);
c0d011ac:	4638      	mov	r0, r7
c0d011ae:	4621      	mov	r1, r4
c0d011b0:	f000 fff2 	bl	c0d02198 <cx_sha3_init>
c0d011b4:	a840      	add	r0, sp, #256	; 0x100
    cx_sha3_init(&temphash, 256);
c0d011b6:	9003      	str	r0, [sp, #12]
c0d011b8:	4621      	mov	r1, r4
c0d011ba:	f000 ffed 	bl	c0d02198 <cx_sha3_init>
c0d011be:	a938      	add	r1, sp, #224	; 0xe0
    
    unsigned char buffer1[32];
    cx_hash(&hash1.header, CX_LAST, outNemPublicKey, 32, buffer1);
c0d011c0:	9102      	str	r1, [sp, #8]
c0d011c2:	4668      	mov	r0, sp
c0d011c4:	6001      	str	r1, [r0, #0]
c0d011c6:	2420      	movs	r4, #32
c0d011c8:	4638      	mov	r0, r7
c0d011ca:	4629      	mov	r1, r5
c0d011cc:	4632      	mov	r2, r6
c0d011ce:	4623      	mov	r3, r4
c0d011d0:	f7fe ffb8 	bl	c0d00144 <cx_hash_X>
c0d011d4:	ae1b      	add	r6, sp, #108	; 0x6c
    unsigned char buffer2[20];
    cx_ripemd160_t hash2;
    cx_ripemd160_init(&hash2);
c0d011d6:	4630      	mov	r0, r6
c0d011d8:	f000 ffd2 	bl	c0d02180 <cx_ripemd160_init>
c0d011dc:	af33      	add	r7, sp, #204	; 0xcc
    cx_hash(&hash2.header, CX_LAST, buffer1, 32, buffer2);
c0d011de:	4668      	mov	r0, sp
c0d011e0:	6007      	str	r7, [r0, #0]
c0d011e2:	4630      	mov	r0, r6
c0d011e4:	4629      	mov	r1, r5
c0d011e6:	9a02      	ldr	r2, [sp, #8]
c0d011e8:	4623      	mov	r3, r4
c0d011ea:	f7fe ffab 	bl	c0d00144 <cx_hash_X>
c0d011ee:	ae0e      	add	r6, sp, #56	; 0x38
    unsigned char rawAddress[50];
    //step1: add network prefix char
    rawAddress[0] = inNetworkId;   //104,,,,,
c0d011f0:	9804      	ldr	r0, [sp, #16]
c0d011f2:	7030      	strb	r0, [r6, #0]
    //step2: add ripemd160 hash
    os_memmove(rawAddress + 1, buffer2, sizeof(buffer2));
c0d011f4:	1c70      	adds	r0, r6, #1
c0d011f6:	2214      	movs	r2, #20
c0d011f8:	4639      	mov	r1, r7
c0d011fa:	f000 f82c 	bl	c0d01256 <os_memmove>
c0d011fe:	ac06      	add	r4, sp, #24
    
    unsigned char buffer3[32];
    cx_hash(&temphash.header, CX_LAST, rawAddress, 21, buffer3);
c0d01200:	4668      	mov	r0, sp
c0d01202:	6004      	str	r4, [r0, #0]
c0d01204:	2315      	movs	r3, #21
c0d01206:	9803      	ldr	r0, [sp, #12]
c0d01208:	4629      	mov	r1, r5
c0d0120a:	4632      	mov	r2, r6
c0d0120c:	f7fe ff9a 	bl	c0d00144 <cx_hash_X>
    //step3: add checksum
    os_memmove(rawAddress + 21, buffer3, 4);
c0d01210:	4630      	mov	r0, r6
c0d01212:	3015      	adds	r0, #21
c0d01214:	2204      	movs	r2, #4
c0d01216:	4621      	mov	r1, r4
c0d01218:	f000 f81d 	bl	c0d01256 <os_memmove>
c0d0121c:	2132      	movs	r1, #50	; 0x32
c0d0121e:	2328      	movs	r3, #40	; 0x28
    base32_encode(rawAddress, sizeof(rawAddress), outNemAddress, 40);
c0d01220:	4630      	mov	r0, r6
c0d01222:	9a05      	ldr	r2, [sp, #20]
c0d01224:	f7fe ff2e 	bl	c0d00084 <base32_encode>
}
c0d01228:	b07f      	add	sp, #508	; 0x1fc
c0d0122a:	b07f      	add	sp, #508	; 0x1fc
c0d0122c:	b017      	add	sp, #92	; 0x5c
c0d0122e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01230:	00000468 	.word	0x00000468

c0d01234 <get_apdu_buffer_length>:
    base32_encode(rawAddress, sizeof(rawAddress), outNemAddress, 40);
}


unsigned int get_apdu_buffer_length() {
	unsigned int len0 = G_io_apdu_buffer[APDU_BODY_LENGTH_OFFSET];
c0d01234:	4801      	ldr	r0, [pc, #4]	; (c0d0123c <get_apdu_buffer_length+0x8>)
c0d01236:	7900      	ldrb	r0, [r0, #4]
	return len0;
c0d01238:	4770      	bx	lr
c0d0123a:	46c0      	nop			; (mov r8, r8)
c0d0123c:	20001df4 	.word	0x20001df4

c0d01240 <clean_raw_tx>:
}

void clean_raw_tx(unsigned char *raw_tx) {
c0d01240:	b580      	push	{r7, lr}
c0d01242:	21f5      	movs	r1, #245	; 0xf5
c0d01244:	0049      	lsls	r1, r1, #1
    uint16_t i;
    for (i = 0; i < MAX_TX_RAW_LENGTH; i++) {
        raw_tx[i] = 0;
c0d01246:	f003 f801 	bl	c0d0424c <__aeabi_memclr>
    }
}
c0d0124a:	bd80      	pop	{r7, pc}

c0d0124c <os_boot>:

// apdu buffer must hold a complete apdu to avoid troubles
unsigned char G_io_apdu_buffer[IO_APDU_BUFFER_SIZE];


void os_boot(void) {
c0d0124c:	b580      	push	{r7, lr}
c0d0124e:	2000      	movs	r0, #0
  // // TODO patch entry point when romming (f)
  // // set the default try context to nothing
#ifndef HAVE_BOLOS
  try_context_set(NULL);
c0d01250:	f001 f89a 	bl	c0d02388 <try_context_set>
#endif // HAVE_BOLOS
}
c0d01254:	bd80      	pop	{r7, pc}

c0d01256 <os_memmove>:


REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d01256:	b5b0      	push	{r4, r5, r7, lr}
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d01258:	4288      	cmp	r0, r1
c0d0125a:	d908      	bls.n	c0d0126e <os_memmove+0x18>
    while(length--) {
c0d0125c:	2a00      	cmp	r2, #0
c0d0125e:	d00f      	beq.n	c0d01280 <os_memmove+0x2a>
c0d01260:	1e49      	subs	r1, r1, #1
c0d01262:	1e40      	subs	r0, r0, #1
      DSTCHAR[length] = SRCCHAR[length];
c0d01264:	5c8b      	ldrb	r3, [r1, r2]
c0d01266:	5483      	strb	r3, [r0, r2]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d01268:	1e52      	subs	r2, r2, #1
c0d0126a:	d1fb      	bne.n	c0d01264 <os_memmove+0xe>
c0d0126c:	e008      	b.n	c0d01280 <os_memmove+0x2a>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d0126e:	2a00      	cmp	r2, #0
c0d01270:	d006      	beq.n	c0d01280 <os_memmove+0x2a>
c0d01272:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d01274:	b29c      	uxth	r4, r3
c0d01276:	5d0d      	ldrb	r5, [r1, r4]
c0d01278:	5505      	strb	r5, [r0, r4]
      l++;
c0d0127a:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d0127c:	1e52      	subs	r2, r2, #1
c0d0127e:	d1f9      	bne.n	c0d01274 <os_memmove+0x1e>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d01280:	bdb0      	pop	{r4, r5, r7, pc}

c0d01282 <os_memset>:

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d01282:	b580      	push	{r7, lr}
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d01284:	2a00      	cmp	r2, #0
c0d01286:	d004      	beq.n	c0d01292 <os_memset+0x10>
c0d01288:	460b      	mov	r3, r1
    DSTCHAR[length] = c;
c0d0128a:	4611      	mov	r1, r2
c0d0128c:	461a      	mov	r2, r3
c0d0128e:	f002 ffe7 	bl	c0d04260 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d01292:	bd80      	pop	{r7, pc}

c0d01294 <os_memcmp>:
  while(nbintval--) {
    ((unsigned int*) dst)[nbintval] = initval;
  }
}

char os_memcmp(const void WIDE * buf1, const void WIDE * buf2, unsigned int length) {
c0d01294:	b5b0      	push	{r4, r5, r7, lr}
#define BUF1 ((unsigned char const WIDE *)buf1)
#define BUF2 ((unsigned char const WIDE *)buf2)
  while(length--) {
c0d01296:	1e40      	subs	r0, r0, #1
c0d01298:	1e49      	subs	r1, r1, #1
c0d0129a:	2a00      	cmp	r2, #0
c0d0129c:	d00a      	beq.n	c0d012b4 <os_memcmp+0x20>
c0d0129e:	1e55      	subs	r5, r2, #1
    if (BUF1[length] != BUF2[length]) {
c0d012a0:	5c8b      	ldrb	r3, [r1, r2]
c0d012a2:	5c84      	ldrb	r4, [r0, r2]
c0d012a4:	429c      	cmp	r4, r3
c0d012a6:	462a      	mov	r2, r5
c0d012a8:	d0f7      	beq.n	c0d0129a <os_memcmp+0x6>
      return (BUF1[length] > BUF2[length])? 1:-1;
c0d012aa:	429c      	cmp	r4, r3
c0d012ac:	d804      	bhi.n	c0d012b8 <os_memcmp+0x24>
c0d012ae:	2000      	movs	r0, #0
c0d012b0:	43c0      	mvns	r0, r0
c0d012b2:	e002      	b.n	c0d012ba <os_memcmp+0x26>
c0d012b4:	2000      	movs	r0, #0
c0d012b6:	e000      	b.n	c0d012ba <os_memcmp+0x26>
c0d012b8:	2001      	movs	r0, #1
  }
  return 0;
#undef BUF1
#undef BUF2

}
c0d012ba:	b2c0      	uxtb	r0, r0
c0d012bc:	bdb0      	pop	{r4, r5, r7, pc}
	...

c0d012c0 <os_longjmp>:
  return (try_context_t*) current_ctx->jmp_buf[5];
}
#endif // BOLOS_EXCEPTION_OLD

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0d012c0:	4604      	mov	r4, r0
#ifdef HAVE_PRINTF  
  unsigned int lr_val;
  __asm volatile("mov %0, lr" :"=r"(lr_val));
c0d012c2:	4672      	mov	r2, lr
  PRINTF("exception[%d]: LR=0x%08X\n", exception, lr_val);
c0d012c4:	4804      	ldr	r0, [pc, #16]	; (c0d012d8 <os_longjmp+0x18>)
c0d012c6:	4478      	add	r0, pc
c0d012c8:	4621      	mov	r1, r4
c0d012ca:	f000 fd5f 	bl	c0d01d8c <mcu_usb_printf>
#endif // HAVE_PRINTF
  longjmp(try_context_get()->jmp_buf, exception);
c0d012ce:	f001 f84f 	bl	c0d02370 <try_context_get>
c0d012d2:	4621      	mov	r1, r4
c0d012d4:	f003 f85c 	bl	c0d04390 <longjmp>
c0d012d8:	000035aa 	.word	0x000035aa

c0d012dc <io_seproxyhal_general_status>:

#ifndef IO_RAPDU_TRANSMIT_TIMEOUT_MS 
#define IO_RAPDU_TRANSMIT_TIMEOUT_MS 2000UL
#endif // IO_RAPDU_TRANSMIT_TIMEOUT_MS

void io_seproxyhal_general_status(void) {
c0d012dc:	b580      	push	{r7, lr}
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d012de:	f001 f82b 	bl	c0d02338 <io_seph_is_status_sent>
c0d012e2:	2800      	cmp	r0, #0
c0d012e4:	d000      	beq.n	c0d012e8 <io_seproxyhal_general_status+0xc>
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 2;
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}
c0d012e6:	bd80      	pop	{r7, pc}
  if (io_seproxyhal_spi_is_status_sent()) {
    return;
  }

  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d012e8:	4806      	ldr	r0, [pc, #24]	; (c0d01304 <io_seproxyhal_general_status+0x28>)
c0d012ea:	2100      	movs	r1, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 2;
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d012ec:	7101      	strb	r1, [r0, #4]

  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 2;
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d012ee:	70c1      	strb	r1, [r0, #3]
c0d012f0:	2202      	movs	r2, #2
  }

  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d012f2:	7082      	strb	r2, [r0, #2]
    return;
  }

  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d012f4:	7041      	strb	r1, [r0, #1]
c0d012f6:	2160      	movs	r1, #96	; 0x60
  if (io_seproxyhal_spi_is_status_sent()) {
    return;
  }

  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d012f8:	7001      	strb	r1, [r0, #0]
c0d012fa:	2105      	movs	r1, #5
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 2;
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d012fc:	f001 f810 	bl	c0d02320 <io_seph_send>
}
c0d01300:	bd80      	pop	{r7, pc}
c0d01302:	46c0      	nop			; (mov r8, r8)
c0d01304:	20001d74 	.word	0x20001d74

c0d01308 <io_seproxyhal_handle_usb_event>:
}

#ifdef HAVE_IO_USB
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
c0d01308:	b5b0      	push	{r4, r5, r7, lr}
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d0130a:	481a      	ldr	r0, [pc, #104]	; (c0d01374 <io_seproxyhal_handle_usb_event+0x6c>)
c0d0130c:	78c0      	ldrb	r0, [r0, #3]
c0d0130e:	2803      	cmp	r0, #3
c0d01310:	dc07      	bgt.n	c0d01322 <io_seproxyhal_handle_usb_event+0x1a>
c0d01312:	2801      	cmp	r0, #1
c0d01314:	d00d      	beq.n	c0d01332 <io_seproxyhal_handle_usb_event+0x2a>
c0d01316:	2802      	cmp	r0, #2
c0d01318:	d128      	bne.n	c0d0136c <io_seproxyhal_handle_usb_event+0x64>
      }
      os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
      os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d0131a:	4817      	ldr	r0, [pc, #92]	; (c0d01378 <io_seproxyhal_handle_usb_event+0x70>)
c0d0131c:	f001 ffb9 	bl	c0d03292 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01320:	bdb0      	pop	{r4, r5, r7, pc}

#ifdef HAVE_IO_USB
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d01322:	2804      	cmp	r0, #4
c0d01324:	d01f      	beq.n	c0d01366 <io_seproxyhal_handle_usb_event+0x5e>
c0d01326:	2808      	cmp	r0, #8
c0d01328:	d120      	bne.n	c0d0136c <io_seproxyhal_handle_usb_event+0x64>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d0132a:	4813      	ldr	r0, [pc, #76]	; (c0d01378 <io_seproxyhal_handle_usb_event+0x70>)
c0d0132c:	f001 ffaf 	bl	c0d0328e <USBD_LL_Resume>
      break;
  }
}
c0d01330:	bdb0      	pop	{r4, r5, r7, pc}
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
  switch(G_io_seproxyhal_spi_buffer[3]) {
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d01332:	4c11      	ldr	r4, [pc, #68]	; (c0d01378 <io_seproxyhal_handle_usb_event+0x70>)
c0d01334:	2101      	movs	r1, #1
c0d01336:	4620      	mov	r0, r4
c0d01338:	f001 ffa4 	bl	c0d03284 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d0133c:	4620      	mov	r0, r4
c0d0133e:	f001 ff82 	bl	c0d03246 <USBD_LL_Reset>
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_app.apdu_media != IO_APDU_MEDIA_NONE) {
c0d01342:	4c0e      	ldr	r4, [pc, #56]	; (c0d0137c <io_seproxyhal_handle_usb_event+0x74>)
c0d01344:	79a0      	ldrb	r0, [r4, #6]
c0d01346:	2800      	cmp	r0, #0
c0d01348:	d111      	bne.n	c0d0136e <io_seproxyhal_handle_usb_event+0x66>
        THROW(EXCEPTION_IO_RESET);
      }
      os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
c0d0134a:	4620      	mov	r0, r4
c0d0134c:	300c      	adds	r0, #12
c0d0134e:	2500      	movs	r5, #0
c0d01350:	2206      	movs	r2, #6
c0d01352:	4629      	mov	r1, r5
c0d01354:	f7ff ff95 	bl	c0d01282 <os_memset>
      os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d01358:	3412      	adds	r4, #18
c0d0135a:	220c      	movs	r2, #12
c0d0135c:	4620      	mov	r0, r4
c0d0135e:	4629      	mov	r1, r5
c0d01360:	f7ff ff8f 	bl	c0d01282 <os_memset>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d01364:	bdb0      	pop	{r4, r5, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d01366:	4804      	ldr	r0, [pc, #16]	; (c0d01378 <io_seproxyhal_handle_usb_event+0x70>)
c0d01368:	f001 ff8f 	bl	c0d0328a <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d0136c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0136e:	2010      	movs	r0, #16
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
      USBD_LL_Reset(&USBD_Device);
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_app.apdu_media != IO_APDU_MEDIA_NONE) {
        THROW(EXCEPTION_IO_RESET);
c0d01370:	f7ff ffa6 	bl	c0d012c0 <os_longjmp>
c0d01374:	20001d74 	.word	0x20001d74
c0d01378:	20002010 	.word	0x20002010
c0d0137c:	20001f48 	.word	0x20001f48

c0d01380 <io_seproxyhal_get_ep_rx_size>:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
c0d01380:	217f      	movs	r1, #127	; 0x7f
  if ((epnum & 0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d01382:	4001      	ands	r1, r0
c0d01384:	2905      	cmp	r1, #5
c0d01386:	d803      	bhi.n	c0d01390 <io_seproxyhal_get_ep_rx_size+0x10>
  return G_io_app.usb_ep_xfer_len[epnum&0x7F];
c0d01388:	4802      	ldr	r0, [pc, #8]	; (c0d01394 <io_seproxyhal_get_ep_rx_size+0x14>)
c0d0138a:	1840      	adds	r0, r0, r1
c0d0138c:	7b00      	ldrb	r0, [r0, #12]
}
  return 0;
}
c0d0138e:	4770      	bx	lr
c0d01390:	2000      	movs	r0, #0
c0d01392:	4770      	bx	lr
c0d01394:	20001f48 	.word	0x20001f48

c0d01398 <io_seproxyhal_handle_usb_ep_xfer_event>:

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d01398:	b580      	push	{r7, lr}
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d0139a:	4815      	ldr	r0, [pc, #84]	; (c0d013f0 <io_seproxyhal_handle_usb_ep_xfer_event+0x58>)
c0d0139c:	7901      	ldrb	r1, [r0, #4]
c0d0139e:	2904      	cmp	r1, #4
c0d013a0:	d017      	beq.n	c0d013d2 <io_seproxyhal_handle_usb_ep_xfer_event+0x3a>
c0d013a2:	2902      	cmp	r1, #2
c0d013a4:	d006      	beq.n	c0d013b4 <io_seproxyhal_handle_usb_ep_xfer_event+0x1c>
c0d013a6:	2901      	cmp	r1, #1
c0d013a8:	d120      	bne.n	c0d013ec <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
    /* This event is received when a new SETUP token had been received on a control endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d013aa:	1d81      	adds	r1, r0, #6
c0d013ac:	4812      	ldr	r0, [pc, #72]	; (c0d013f8 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d013ae:	f001 fe51 	bl	c0d03054 <USBD_LL_SetupStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d013b2:	bd80      	pop	{r7, pc}
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    /* This event is received after the prepare data packet has been flushed to the usb host */
    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d013b4:	78c2      	ldrb	r2, [r0, #3]
c0d013b6:	217f      	movs	r1, #127	; 0x7f
c0d013b8:	4011      	ands	r1, r2
c0d013ba:	2905      	cmp	r1, #5
c0d013bc:	d816      	bhi.n	c0d013ec <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        // discard ep timeout as we received the sent packet confirmation
        G_io_app.usb_ep_timeouts[G_io_seproxyhal_spi_buffer[3]&0x7F].timeout = 0;
c0d013be:	004a      	lsls	r2, r1, #1
c0d013c0:	4b0c      	ldr	r3, [pc, #48]	; (c0d013f4 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d013c2:	189a      	adds	r2, r3, r2
c0d013c4:	2300      	movs	r3, #0
c0d013c6:	8253      	strh	r3, [r2, #18]
        // propagate sending ack of the data
        USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d013c8:	1d82      	adds	r2, r0, #6
c0d013ca:	480b      	ldr	r0, [pc, #44]	; (c0d013f8 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d013cc:	f001 fec8 	bl	c0d03160 <USBD_LL_DataInStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d013d0:	bd80      	pop	{r7, pc}
      }
      break;

    /* This event is received when a new DATA token is received on an endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d013d2:	78c2      	ldrb	r2, [r0, #3]
c0d013d4:	217f      	movs	r1, #127	; 0x7f
c0d013d6:	4011      	ands	r1, r2
c0d013d8:	2905      	cmp	r1, #5
c0d013da:	d807      	bhi.n	c0d013ec <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        // saved just in case it is needed ...
        G_io_app.usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d013dc:	4a05      	ldr	r2, [pc, #20]	; (c0d013f4 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d013de:	1852      	adds	r2, r2, r1
c0d013e0:	7943      	ldrb	r3, [r0, #5]
c0d013e2:	7313      	strb	r3, [r2, #12]
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d013e4:	1d82      	adds	r2, r0, #6
c0d013e6:	4804      	ldr	r0, [pc, #16]	; (c0d013f8 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d013e8:	f001 fe62 	bl	c0d030b0 <USBD_LL_DataOutStage>
      }
      break;
  }
}
c0d013ec:	bd80      	pop	{r7, pc}
c0d013ee:	46c0      	nop			; (mov r8, r8)
c0d013f0:	20001d74 	.word	0x20001d74
c0d013f4:	20001f48 	.word	0x20001f48
c0d013f8:	20002010 	.word	0x20002010

c0d013fc <io_usb_send_ep>:
#endif // HAVE_L4_USBLIB

// TODO, refactor this using the USB DataIn event like for the U2F tunnel
// TODO add a blocking parameter, for HID KBD sending, or use a USB busy flag per channel to know if 
// the transfer has been processed or not. and move on to the next transfer on the same endpoint
void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d013fc:	b570      	push	{r4, r5, r6, lr}
  if (timeout) {
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d013fe:	2aff      	cmp	r2, #255	; 0xff
c0d01400:	d81e      	bhi.n	c0d01440 <io_usb_send_ep+0x44>
c0d01402:	4615      	mov	r5, r2
c0d01404:	460e      	mov	r6, r1
c0d01406:	4604      	mov	r4, r0
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01408:	480e      	ldr	r0, [pc, #56]	; (c0d01444 <io_usb_send_ep+0x48>)
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
  G_io_seproxyhal_spi_buffer[2] = (3+length);
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  G_io_seproxyhal_spi_buffer[5] = length;
c0d0140a:	7142      	strb	r2, [r0, #5]
c0d0140c:	2120      	movs	r1, #32
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
  G_io_seproxyhal_spi_buffer[2] = (3+length);
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d0140e:	7101      	strb	r1, [r0, #4]
c0d01410:	2150      	movs	r1, #80	; 0x50
  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01412:	7001      	strb	r1, [r0, #0]
c0d01414:	2180      	movs	r1, #128	; 0x80
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
  G_io_seproxyhal_spi_buffer[2] = (3+length);
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d01416:	4321      	orrs	r1, r4
c0d01418:	70c1      	strb	r1, [r0, #3]
  if (length > 255) {
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d0141a:	1cd1      	adds	r1, r2, #3
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d0141c:	7081      	strb	r1, [r0, #2]
  if (length > 255) {
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d0141e:	0a09      	lsrs	r1, r1, #8
c0d01420:	7041      	strb	r1, [r0, #1]
c0d01422:	2106      	movs	r1, #6
  G_io_seproxyhal_spi_buffer[2] = (3+length);
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  G_io_seproxyhal_spi_buffer[5] = length;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d01424:	f000 ff7c 	bl	c0d02320 <io_seph_send>
  io_seproxyhal_spi_send(buffer, length);
c0d01428:	4630      	mov	r0, r6
c0d0142a:	4629      	mov	r1, r5
c0d0142c:	f000 ff78 	bl	c0d02320 <io_seph_send>
c0d01430:	207f      	movs	r0, #127	; 0x7f
  // setup timeout of the endpoint
  G_io_app.usb_ep_timeouts[ep&0x7F].timeout = IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d01432:	4020      	ands	r0, r4
c0d01434:	0040      	lsls	r0, r0, #1
c0d01436:	4904      	ldr	r1, [pc, #16]	; (c0d01448 <io_usb_send_ep+0x4c>)
c0d01438:	1808      	adds	r0, r1, r0
c0d0143a:	217d      	movs	r1, #125	; 0x7d
c0d0143c:	0109      	lsls	r1, r1, #4
c0d0143e:	8241      	strh	r1, [r0, #18]
}
c0d01440:	bd70      	pop	{r4, r5, r6, pc}
c0d01442:	46c0      	nop			; (mov r8, r8)
c0d01444:	20001d74 	.word	0x20001d74
c0d01448:	20001f48 	.word	0x20001f48

c0d0144c <io_usb_send_apdu_data>:

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d0144c:	b580      	push	{r7, lr}
c0d0144e:	460a      	mov	r2, r1
c0d01450:	4601      	mov	r1, r0
c0d01452:	2082      	movs	r0, #130	; 0x82
c0d01454:	2314      	movs	r3, #20
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d01456:	f7ff ffd1 	bl	c0d013fc <io_usb_send_ep>
}
c0d0145a:	bd80      	pop	{r7, pc}

c0d0145c <io_usb_send_apdu_data_ep0x83>:

#ifdef HAVE_WEBUSB
void io_usb_send_apdu_data_ep0x83(unsigned char* buffer, unsigned short length) {
c0d0145c:	b580      	push	{r7, lr}
c0d0145e:	460a      	mov	r2, r1
c0d01460:	4601      	mov	r1, r0
c0d01462:	2083      	movs	r0, #131	; 0x83
c0d01464:	2314      	movs	r3, #20
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x83, buffer, length, 20);
c0d01466:	f7ff ffc9 	bl	c0d013fc <io_usb_send_ep>
}
c0d0146a:	bd80      	pop	{r7, pc}

c0d0146c <io_seproxyhal_handle_capdu_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif // HAVE_BLUENRG

void io_seproxyhal_handle_capdu_event(void) {
c0d0146c:	b580      	push	{r7, lr}
  if (G_io_app.apdu_state == APDU_IDLE) {
c0d0146e:	480b      	ldr	r0, [pc, #44]	; (c0d0149c <io_seproxyhal_handle_capdu_event+0x30>)
c0d01470:	7801      	ldrb	r1, [r0, #0]
c0d01472:	2900      	cmp	r1, #0
c0d01474:	d000      	beq.n	c0d01478 <io_seproxyhal_handle_capdu_event+0xc>
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
    G_io_app.apdu_length = MIN(size, max);
    // copy apdu to apdu buffer
    os_memmove(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_app.apdu_length);
  }
}
c0d01476:	bd80      	pop	{r7, pc}
c0d01478:	2106      	movs	r1, #6
void io_seproxyhal_handle_capdu_event(void) {
  if (G_io_app.apdu_state == APDU_IDLE) {
    size_t max = MIN(sizeof(G_io_apdu_buffer)-3, sizeof(G_io_seproxyhal_spi_buffer)-3);
    size_t size = U2BE(G_io_seproxyhal_spi_buffer, 1);

    G_io_app.apdu_media = IO_APDU_MEDIA_RAW; // for application code
c0d0147a:	7181      	strb	r1, [r0, #6]
c0d0147c:	210a      	movs	r1, #10
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
c0d0147e:	7001      	strb	r1, [r0, #0]
#endif // HAVE_BLUENRG

void io_seproxyhal_handle_capdu_event(void) {
  if (G_io_app.apdu_state == APDU_IDLE) {
    size_t max = MIN(sizeof(G_io_apdu_buffer)-3, sizeof(G_io_seproxyhal_spi_buffer)-3);
    size_t size = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d01480:	4907      	ldr	r1, [pc, #28]	; (c0d014a0 <io_seproxyhal_handle_capdu_event+0x34>)
c0d01482:	788a      	ldrb	r2, [r1, #2]
c0d01484:	784b      	ldrb	r3, [r1, #1]
c0d01486:	021b      	lsls	r3, r3, #8
c0d01488:	189a      	adds	r2, r3, r2

    G_io_app.apdu_media = IO_APDU_MEDIA_RAW; // for application code
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
    G_io_app.apdu_length = MIN(size, max);
c0d0148a:	2a7d      	cmp	r2, #125	; 0x7d
c0d0148c:	d300      	bcc.n	c0d01490 <io_seproxyhal_handle_capdu_event+0x24>
c0d0148e:	227d      	movs	r2, #125	; 0x7d
c0d01490:	8042      	strh	r2, [r0, #2]
    // copy apdu to apdu buffer
    os_memmove(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_app.apdu_length);
c0d01492:	1cc9      	adds	r1, r1, #3
c0d01494:	4803      	ldr	r0, [pc, #12]	; (c0d014a4 <io_seproxyhal_handle_capdu_event+0x38>)
c0d01496:	f7ff fede 	bl	c0d01256 <os_memmove>
  }
}
c0d0149a:	bd80      	pop	{r7, pc}
c0d0149c:	20001f48 	.word	0x20001f48
c0d014a0:	20001d74 	.word	0x20001d74
c0d014a4:	20001df4 	.word	0x20001df4

c0d014a8 <io_seproxyhal_handle_event>:

unsigned int io_seproxyhal_handle_event(void) {
c0d014a8:	b580      	push	{r7, lr}
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d014aa:	491f      	ldr	r1, [pc, #124]	; (c0d01528 <io_seproxyhal_handle_event+0x80>)
c0d014ac:	7888      	ldrb	r0, [r1, #2]
c0d014ae:	784a      	ldrb	r2, [r1, #1]
c0d014b0:	0212      	lsls	r2, r2, #8
c0d014b2:	1810      	adds	r0, r2, r0

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d014b4:	7809      	ldrb	r1, [r1, #0]
c0d014b6:	290f      	cmp	r1, #15
c0d014b8:	dc09      	bgt.n	c0d014ce <io_seproxyhal_handle_event+0x26>
c0d014ba:	290e      	cmp	r1, #14
c0d014bc:	d00f      	beq.n	c0d014de <io_seproxyhal_handle_event+0x36>
c0d014be:	290f      	cmp	r1, #15
c0d014c0:	d120      	bne.n	c0d01504 <io_seproxyhal_handle_event+0x5c>
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 1) {
c0d014c2:	2801      	cmp	r0, #1
c0d014c4:	d124      	bne.n	c0d01510 <io_seproxyhal_handle_event+0x68>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d014c6:	f7ff ff1f 	bl	c0d01308 <io_seproxyhal_handle_usb_event>
c0d014ca:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d014cc:	bd80      	pop	{r7, pc}
}

unsigned int io_seproxyhal_handle_event(void) {
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d014ce:	2910      	cmp	r1, #16
c0d014d0:	d01c      	beq.n	c0d0150c <io_seproxyhal_handle_event+0x64>
c0d014d2:	2916      	cmp	r1, #22
c0d014d4:	d116      	bne.n	c0d01504 <io_seproxyhal_handle_event+0x5c>
      }
      return 1;
  #endif // HAVE_BLE

    case SEPROXYHAL_TAG_CAPDU_EVENT:
      io_seproxyhal_handle_capdu_event();
c0d014d6:	f7ff ffc9 	bl	c0d0146c <io_seproxyhal_handle_capdu_event>
c0d014da:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d014dc:	bd80      	pop	{r7, pc}
      return 1;

      // ask the user if not processed here
    case SEPROXYHAL_TAG_TICKER_EVENT:
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
      G_io_app.ms += 100; // value is by default, don't change the ticker configuration
c0d014de:	4813      	ldr	r0, [pc, #76]	; (c0d0152c <io_seproxyhal_handle_event+0x84>)
c0d014e0:	6881      	ldr	r1, [r0, #8]
c0d014e2:	3164      	adds	r1, #100	; 0x64
c0d014e4:	6081      	str	r1, [r0, #8]
c0d014e6:	211c      	movs	r1, #28
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
          if (G_io_app.usb_ep_timeouts[i].timeout) {
c0d014e8:	5a42      	ldrh	r2, [r0, r1]
c0d014ea:	2a00      	cmp	r2, #0
c0d014ec:	d007      	beq.n	c0d014fe <io_seproxyhal_handle_event+0x56>
            G_io_app.usb_ep_timeouts[i].timeout-=MIN(G_io_app.usb_ep_timeouts[i].timeout, 100);
c0d014ee:	2a64      	cmp	r2, #100	; 0x64
c0d014f0:	4613      	mov	r3, r2
c0d014f2:	d300      	bcc.n	c0d014f6 <io_seproxyhal_handle_event+0x4e>
c0d014f4:	2364      	movs	r3, #100	; 0x64
c0d014f6:	1ad2      	subs	r2, r2, r3
c0d014f8:	5242      	strh	r2, [r0, r1]
            if (!G_io_app.usb_ep_timeouts[i].timeout) {
c0d014fa:	0412      	lsls	r2, r2, #16
c0d014fc:	d00e      	beq.n	c0d0151c <io_seproxyhal_handle_event+0x74>
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
      G_io_app.ms += 100; // value is by default, don't change the ticker configuration
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
c0d014fe:	1e89      	subs	r1, r1, #2
c0d01500:	2910      	cmp	r1, #16
c0d01502:	d1f1      	bne.n	c0d014e8 <io_seproxyhal_handle_event+0x40>
c0d01504:	2002      	movs	r0, #2
        __attribute__((fallthrough));
      }
#endif // HAVE_BLE_APDU
      // no break is intentional
    default:
      return io_event(CHANNEL_SPI);
c0d01506:	f7ff fb17 	bl	c0d00b38 <io_event>
  }
  // defaultly return as not processed
  return 0;
}
c0d0150a:	bd80      	pop	{r7, pc}
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3) {
c0d0150c:	2803      	cmp	r0, #3
c0d0150e:	d201      	bcs.n	c0d01514 <io_seproxyhal_handle_event+0x6c>
c0d01510:	2000      	movs	r0, #0
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d01512:	bd80      	pop	{r7, pc}
    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3) {
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d01514:	f7ff ff40 	bl	c0d01398 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d01518:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d0151a:	bd80      	pop	{r7, pc}
c0d0151c:	2100      	movs	r1, #0
        while(i--) {
          if (G_io_app.usb_ep_timeouts[i].timeout) {
            G_io_app.usb_ep_timeouts[i].timeout-=MIN(G_io_app.usb_ep_timeouts[i].timeout, 100);
            if (!G_io_app.usb_ep_timeouts[i].timeout) {
              // timeout !
              G_io_app.apdu_state = APDU_IDLE;
c0d0151e:	7001      	strb	r1, [r0, #0]
c0d01520:	2010      	movs	r0, #16
              THROW(EXCEPTION_IO_RESET);
c0d01522:	f7ff fecd 	bl	c0d012c0 <os_longjmp>
c0d01526:	46c0      	nop			; (mov r8, r8)
c0d01528:	20001d74 	.word	0x20001d74
c0d0152c:	20001f48 	.word	0x20001f48

c0d01530 <io_seproxyhal_init>:
#ifdef HAVE_BOLOS_APP_STACK_CANARY
#define APP_STACK_CANARY_MAGIC 0xDEAD0031
extern unsigned int app_stack_canary;
#endif // HAVE_BOLOS_APP_STACK_CANARY

void io_seproxyhal_init(void) {
c0d01530:	b5b0      	push	{r4, r5, r7, lr}
c0d01532:	200a      	movs	r0, #10
#ifndef HAVE_BOLOS
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d01534:	f000 fdec 	bl	c0d02110 <check_api_level>

  // wipe the io structure before it's used
#ifdef TARGET_NANOX
  unsigned int plane = G_io_app.plane_mode;
#endif // TARGET_NANOX
  os_memset(&G_io_app, 0, sizeof(G_io_app));
c0d01538:	4c08      	ldr	r4, [pc, #32]	; (c0d0155c <io_seproxyhal_init+0x2c>)
c0d0153a:	2500      	movs	r5, #0
c0d0153c:	2220      	movs	r2, #32
c0d0153e:	4620      	mov	r0, r4
c0d01540:	4629      	mov	r1, r5
c0d01542:	f7ff fe9e 	bl	c0d01282 <os_memset>

  G_io_app.apdu_state = APDU_IDLE;
  G_io_app.apdu_length = 0;
  G_io_app.apdu_media = IO_APDU_MEDIA_NONE;

  G_io_app.ms = 0;
c0d01546:	60a5      	str	r5, [r4, #8]
  G_io_app.plane_mode = plane;
#endif // TARGET_NANOX

  G_io_app.apdu_state = APDU_IDLE;
  G_io_app.apdu_length = 0;
  G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d01548:	71a5      	strb	r5, [r4, #6]
#ifdef TARGET_NANOX
  G_io_app.plane_mode = plane;
#endif // TARGET_NANOX

  G_io_app.apdu_state = APDU_IDLE;
  G_io_app.apdu_length = 0;
c0d0154a:	8065      	strh	r5, [r4, #2]
  os_memset(&G_io_app, 0, sizeof(G_io_app));
#ifdef TARGET_NANOX
  G_io_app.plane_mode = plane;
#endif // TARGET_NANOX

  G_io_app.apdu_state = APDU_IDLE;
c0d0154c:	7025      	strb	r5, [r4, #0]
  #ifdef DEBUG_APDU
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU

  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d0154e:	f000 fb67 	bl	c0d01c20 <io_usb_hid_init>
// #endif // TARGET_NANOX
}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_ux_os.button_mask = 0;
c0d01552:	4803      	ldr	r0, [pc, #12]	; (c0d01560 <io_seproxyhal_init+0x30>)
c0d01554:	6005      	str	r5, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d01556:	6045      	str	r5, [r0, #4]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d01558:	bdb0      	pop	{r4, r5, r7, pc}
c0d0155a:	46c0      	nop			; (mov r8, r8)
c0d0155c:	20001f48 	.word	0x20001f48
c0d01560:	20001f68 	.word	0x20001f68

c0d01564 <io_seproxyhal_init_ux>:

// #ifdef TARGET_NANOX
//   // wipe frame buffer
//   screen_clear();
// #endif // TARGET_NANOX
}
c0d01564:	4770      	bx	lr
	...

c0d01568 <io_seproxyhal_init_button>:

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_ux_os.button_mask = 0;
c0d01568:	4802      	ldr	r0, [pc, #8]	; (c0d01574 <io_seproxyhal_init_button+0xc>)
c0d0156a:	2100      	movs	r1, #0
c0d0156c:	6001      	str	r1, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d0156e:	6041      	str	r1, [r0, #4]
}
c0d01570:	4770      	bx	lr
c0d01572:	46c0      	nop			; (mov r8, r8)
c0d01574:	20001f68 	.word	0x20001f68

c0d01578 <io_seproxyhal_display_icon>:
    }
  }
}

#else // TARGET_NANOX
void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_det) {
c0d01578:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0157a:	b089      	sub	sp, #36	; 0x24
c0d0157c:	4605      	mov	r5, r0
  bagl_component_t icon_component_mod;
  const bagl_icon_details_t* icon_details = (bagl_icon_details_t*)PIC(icon_det);
c0d0157e:	4608      	mov	r0, r1
c0d01580:	f000 fdae 	bl	c0d020e0 <pic>
  if (icon_details && icon_details->bitmap) {
c0d01584:	2800      	cmp	r0, #0
c0d01586:	d043      	beq.n	c0d01610 <io_seproxyhal_display_icon+0x98>
c0d01588:	4604      	mov	r4, r0
c0d0158a:	6900      	ldr	r0, [r0, #16]
c0d0158c:	2800      	cmp	r0, #0
c0d0158e:	d03f      	beq.n	c0d01610 <io_seproxyhal_display_icon+0x98>
    // ensure not being out of bounds in the icon component agianst the declared icon real size
    os_memmove(&icon_component_mod, PIC(icon_component), sizeof(bagl_component_t));
c0d01590:	4628      	mov	r0, r5
c0d01592:	f000 fda5 	bl	c0d020e0 <pic>
c0d01596:	4601      	mov	r1, r0
c0d01598:	ad02      	add	r5, sp, #8
c0d0159a:	221c      	movs	r2, #28
c0d0159c:	4628      	mov	r0, r5
c0d0159e:	9201      	str	r2, [sp, #4]
c0d015a0:	f7ff fe59 	bl	c0d01256 <os_memmove>
    icon_component_mod.width = icon_details->width;
c0d015a4:	6821      	ldr	r1, [r4, #0]
c0d015a6:	80e9      	strh	r1, [r5, #6]
    icon_component_mod.height = icon_details->height;
c0d015a8:	6862      	ldr	r2, [r4, #4]
c0d015aa:	812a      	strh	r2, [r5, #8]
    // component type = ICON, provided bitmap
    // => bitmap transmitted


    // color index size
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d015ac:	68a0      	ldr	r0, [r4, #8]
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
                            +w; /* image bitmap size */
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d015ae:	4f19      	ldr	r7, [pc, #100]	; (c0d01614 <io_seproxyhal_display_icon+0x9c>)
c0d015b0:	2365      	movs	r3, #101	; 0x65
c0d015b2:	463e      	mov	r6, r7
c0d015b4:	703b      	strb	r3, [r7, #0]


    // color index size
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
    // bitmap size
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d015b6:	b289      	uxth	r1, r1
c0d015b8:	b292      	uxth	r2, r2
c0d015ba:	434a      	muls	r2, r1
c0d015bc:	4342      	muls	r2, r0
c0d015be:	0751      	lsls	r1, r2, #29
c0d015c0:	08d2      	lsrs	r2, r2, #3
c0d015c2:	2900      	cmp	r1, #0
c0d015c4:	d000      	beq.n	c0d015c8 <io_seproxyhal_display_icon+0x50>
c0d015c6:	1c52      	adds	r2, r2, #1
c0d015c8:	9200      	str	r2, [sp, #0]
c0d015ca:	2704      	movs	r7, #4
    // component type = ICON, provided bitmap
    // => bitmap transmitted


    // color index size
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d015cc:	4087      	lsls	r7, r0
    // bitmap size
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
c0d015ce:	18b8      	adds	r0, r7, r2
                            +w; /* image bitmap size */
c0d015d0:	301d      	adds	r0, #29
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
    G_io_seproxyhal_spi_buffer[1] = length>>8;
    G_io_seproxyhal_spi_buffer[2] = length;
c0d015d2:	70b0      	strb	r0, [r6, #2]
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
                            +w; /* image bitmap size */
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
    G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d015d4:	0a00      	lsrs	r0, r0, #8
c0d015d6:	7070      	strb	r0, [r6, #1]
c0d015d8:	2103      	movs	r1, #3
    G_io_seproxyhal_spi_buffer[2] = length;
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d015da:	4630      	mov	r0, r6
c0d015dc:	f000 fea0 	bl	c0d02320 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d015e0:	4628      	mov	r0, r5
c0d015e2:	9901      	ldr	r1, [sp, #4]
c0d015e4:	f000 fe9c 	bl	c0d02320 <io_seph_send>
    G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d015e8:	68a0      	ldr	r0, [r4, #8]
c0d015ea:	7030      	strb	r0, [r6, #0]
c0d015ec:	2101      	movs	r1, #1
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d015ee:	4630      	mov	r0, r6
c0d015f0:	f000 fe96 	bl	c0d02320 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d015f4:	68e0      	ldr	r0, [r4, #12]
c0d015f6:	f000 fd73 	bl	c0d020e0 <pic>
c0d015fa:	b2b9      	uxth	r1, r7
c0d015fc:	f000 fe90 	bl	c0d02320 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01600:	9800      	ldr	r0, [sp, #0]
c0d01602:	b285      	uxth	r5, r0
c0d01604:	6920      	ldr	r0, [r4, #16]
c0d01606:	f000 fd6b 	bl	c0d020e0 <pic>
c0d0160a:	4629      	mov	r1, r5
c0d0160c:	f000 fe88 	bl	c0d02320 <io_seph_send>
  #endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
  }
}
c0d01610:	b009      	add	sp, #36	; 0x24
c0d01612:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01614:	20001d74 	.word	0x20001d74

c0d01618 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(const bagl_element_t * el) {
c0d01618:	b570      	push	{r4, r5, r6, lr}

  const bagl_element_t* element = (const bagl_element_t*) PIC(el);
c0d0161a:	f000 fd61 	bl	c0d020e0 <pic>
c0d0161e:	4604      	mov	r4, r0

  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d01620:	7806      	ldrb	r6, [r0, #0]

  // avoid sending another status :), fixes a lot of bugs in the end
  if (io_seproxyhal_spi_is_status_sent()) {
c0d01622:	f000 fe89 	bl	c0d02338 <io_seph_is_status_sent>
c0d01626:	2800      	cmp	r0, #0
c0d01628:	d132      	bne.n	c0d01690 <io_seproxyhal_display_default+0x78>
c0d0162a:	207f      	movs	r0, #127	; 0x7f
c0d0162c:	4006      	ands	r6, r0
c0d0162e:	2e00      	cmp	r6, #0
c0d01630:	d02e      	beq.n	c0d01690 <io_seproxyhal_display_default+0x78>
    return;
  }

  if (type != BAGL_NONE) {
    if (element->text != NULL) {
c0d01632:	69e0      	ldr	r0, [r4, #28]
c0d01634:	2800      	cmp	r0, #0
c0d01636:	d01d      	beq.n	c0d01674 <io_seproxyhal_display_default+0x5c>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01638:	f000 fd52 	bl	c0d020e0 <pic>
c0d0163c:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0163e:	2e05      	cmp	r6, #5
c0d01640:	d102      	bne.n	c0d01648 <io_seproxyhal_display_default+0x30>
c0d01642:	7ea0      	ldrb	r0, [r4, #26]
c0d01644:	2800      	cmp	r0, #0
c0d01646:	d024      	beq.n	c0d01692 <io_seproxyhal_display_default+0x7a>
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01648:	4628      	mov	r0, r5
c0d0164a:	f002 feaf 	bl	c0d043ac <strlen>
c0d0164e:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01650:	4812      	ldr	r0, [pc, #72]	; (c0d0169c <io_seproxyhal_display_default+0x84>)
c0d01652:	2165      	movs	r1, #101	; 0x65
c0d01654:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01656:	4631      	mov	r1, r6
c0d01658:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
        G_io_seproxyhal_spi_buffer[2] = length;
c0d0165a:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0165c:	0a09      	lsrs	r1, r1, #8
c0d0165e:	7041      	strb	r1, [r0, #1]
c0d01660:	2103      	movs	r1, #3
        G_io_seproxyhal_spi_buffer[2] = length;
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01662:	f000 fe5d 	bl	c0d02320 <io_seph_send>
c0d01666:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d01668:	4620      	mov	r0, r4
c0d0166a:	f000 fe59 	bl	c0d02320 <io_seph_send>
        io_seproxyhal_spi_send((unsigned char*)text_adr, length-sizeof(bagl_component_t));
c0d0166e:	b2b1      	uxth	r1, r6
c0d01670:	4628      	mov	r0, r5
c0d01672:	e00b      	b.n	c0d0168c <io_seproxyhal_display_default+0x74>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01674:	4809      	ldr	r0, [pc, #36]	; (c0d0169c <io_seproxyhal_display_default+0x84>)
c0d01676:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[1] = length>>8;
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01678:	7085      	strb	r5, [r0, #2]
c0d0167a:	2100      	movs	r1, #0
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0167c:	7041      	strb	r1, [r0, #1]
c0d0167e:	2165      	movs	r1, #101	; 0x65
        io_seproxyhal_spi_send((unsigned char*)text_adr, length-sizeof(bagl_component_t));
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01680:	7001      	strb	r1, [r0, #0]
c0d01682:	2103      	movs	r1, #3
      G_io_seproxyhal_spi_buffer[1] = length>>8;
      G_io_seproxyhal_spi_buffer[2] = length;
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01684:	f000 fe4c 	bl	c0d02320 <io_seph_send>
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d01688:	4620      	mov	r0, r4
c0d0168a:	4629      	mov	r1, r5
c0d0168c:	f000 fe48 	bl	c0d02320 <io_seph_send>
    }
  }
}
c0d01690:	bd70      	pop	{r4, r5, r6, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
c0d01692:	4620      	mov	r0, r4
c0d01694:	4629      	mov	r1, r5
c0d01696:	f7ff ff6f 	bl	c0d01578 <io_seproxyhal_display_icon>
      G_io_seproxyhal_spi_buffer[2] = length;
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
    }
  }
}
c0d0169a:	bd70      	pop	{r4, r5, r6, pc}
c0d0169c:	20001d74 	.word	0x20001d74

c0d016a0 <bagl_label_roundtrip_duration_ms>:
#endif // TARGET_NANOX

unsigned int bagl_label_roundtrip_duration_ms(const bagl_element_t* e, unsigned int average_char_width) {
c0d016a0:	b580      	push	{r7, lr}
c0d016a2:	460a      	mov	r2, r1
  return bagl_label_roundtrip_duration_ms_buf(e, e->text, average_char_width);
c0d016a4:	69c1      	ldr	r1, [r0, #28]
c0d016a6:	f000 f801 	bl	c0d016ac <bagl_label_roundtrip_duration_ms_buf>
c0d016aa:	bd80      	pop	{r7, pc}

c0d016ac <bagl_label_roundtrip_duration_ms_buf>:
}

unsigned int bagl_label_roundtrip_duration_ms_buf(const bagl_element_t* e, const char* str, unsigned int average_char_width) {
c0d016ac:	b570      	push	{r4, r5, r6, lr}
c0d016ae:	2500      	movs	r5, #0
  // not a scrollable label
  if (e == NULL || (e->component.type != BAGL_LABEL && e->component.type != BAGL_LABELINE)) {
c0d016b0:	2800      	cmp	r0, #0
c0d016b2:	d01e      	beq.n	c0d016f2 <bagl_label_roundtrip_duration_ms_buf+0x46>
c0d016b4:	4616      	mov	r6, r2
c0d016b6:	4604      	mov	r4, r0
c0d016b8:	7800      	ldrb	r0, [r0, #0]
c0d016ba:	2807      	cmp	r0, #7
c0d016bc:	d001      	beq.n	c0d016c2 <bagl_label_roundtrip_duration_ms_buf+0x16>
c0d016be:	2802      	cmp	r0, #2
c0d016c0:	d117      	bne.n	c0d016f2 <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0;
  }
  
  unsigned int text_adr = PIC((unsigned int)str);
c0d016c2:	4608      	mov	r0, r1
c0d016c4:	f000 fd0c 	bl	c0d020e0 <pic>
  unsigned int textlen = 0;
  
  // no delay, no text to display
  if (!text_adr) {
c0d016c8:	2800      	cmp	r0, #0
c0d016ca:	d012      	beq.n	c0d016f2 <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0;
  }
  textlen = strlen((const char*)text_adr);
c0d016cc:	f002 fe6e 	bl	c0d043ac <strlen>
  
  // no delay, all text fits
  textlen = textlen * average_char_width;
c0d016d0:	4346      	muls	r6, r0
  if (textlen <= e->component.width) {
c0d016d2:	88e0      	ldrh	r0, [r4, #6]
c0d016d4:	4286      	cmp	r6, r0
c0d016d6:	d90c      	bls.n	c0d016f2 <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0; 
  }
  
  // compute scrolled text length
  return 2*(textlen - e->component.width)*1000/e->component.icon_id + 2*(e->component.stroke & ~(0x80))*100;
c0d016d8:	1a31      	subs	r1, r6, r0
c0d016da:	207d      	movs	r0, #125	; 0x7d
c0d016dc:	0100      	lsls	r0, r0, #4
c0d016de:	4348      	muls	r0, r1
c0d016e0:	7ea1      	ldrb	r1, [r4, #26]
c0d016e2:	f002 fd27 	bl	c0d04134 <__aeabi_uidiv>
c0d016e6:	7aa1      	ldrb	r1, [r4, #10]
c0d016e8:	0649      	lsls	r1, r1, #25
c0d016ea:	0e09      	lsrs	r1, r1, #24
c0d016ec:	2264      	movs	r2, #100	; 0x64
c0d016ee:	434a      	muls	r2, r1
c0d016f0:	1815      	adds	r5, r2, r0
}
c0d016f2:	4628      	mov	r0, r5
c0d016f4:	bd70      	pop	{r4, r5, r6, pc}
	...

c0d016f8 <io_seproxyhal_button_push>:

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d016f8:	b570      	push	{r4, r5, r6, lr}
  if (button_callback) {
c0d016fa:	2800      	cmp	r0, #0
c0d016fc:	d027      	beq.n	c0d0174e <io_seproxyhal_button_push+0x56>
c0d016fe:	4604      	mov	r4, r0
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_ux_os.button_mask) {
c0d01700:	4813      	ldr	r0, [pc, #76]	; (c0d01750 <io_seproxyhal_button_push+0x58>)
c0d01702:	c860      	ldmia	r0!, {r5, r6}
c0d01704:	3808      	subs	r0, #8
c0d01706:	428d      	cmp	r5, r1
c0d01708:	d101      	bne.n	c0d0170e <io_seproxyhal_button_push+0x16>
      // each 100ms ~
      G_ux_os.button_same_mask_counter++;
c0d0170a:	1c76      	adds	r6, r6, #1
c0d0170c:	6046      	str	r6, [r0, #4]
    }

    // when new_button_mask is 0 and 

    // append the button mask
    button_mask = G_ux_os.button_mask | new_button_mask;
c0d0170e:	430d      	orrs	r5, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_ux_os.button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
c0d01710:	2900      	cmp	r1, #0
c0d01712:	d002      	beq.n	c0d0171a <io_seproxyhal_button_push+0x22>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_ux_os.button_mask = button_mask;
c0d01714:	6005      	str	r5, [r0, #0]
    }

    // reset counter when button mask changes
    if (new_button_mask != G_ux_os.button_mask) {
c0d01716:	462a      	mov	r2, r5
c0d01718:	e005      	b.n	c0d01726 <io_seproxyhal_button_push+0x2e>
c0d0171a:	2200      	movs	r2, #0
    button_same_mask_counter = G_ux_os.button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_ux_os.button_mask = 0;
c0d0171c:	6002      	str	r2, [r0, #0]
      G_ux_os.button_same_mask_counter=0;
c0d0171e:	6042      	str	r2, [r0, #4]
c0d01720:	4b0c      	ldr	r3, [pc, #48]	; (c0d01754 <io_seproxyhal_button_push+0x5c>)

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d01722:	1c5b      	adds	r3, r3, #1
c0d01724:	431d      	orrs	r5, r3
    else {
      G_ux_os.button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_ux_os.button_mask) {
c0d01726:	428a      	cmp	r2, r1
c0d01728:	d001      	beq.n	c0d0172e <io_seproxyhal_button_push+0x36>
c0d0172a:	2100      	movs	r1, #0
      G_ux_os.button_same_mask_counter=0;
c0d0172c:	6041      	str	r1, [r0, #4]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d0172e:	2e08      	cmp	r6, #8
c0d01730:	d30a      	bcc.n	c0d01748 <io_seproxyhal_button_push+0x50>
c0d01732:	2103      	movs	r1, #3
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01734:	4630      	mov	r0, r6
c0d01736:	f002 fd83 	bl	c0d04240 <__aeabi_uidivmod>
c0d0173a:	2001      	movs	r0, #1
c0d0173c:	2900      	cmp	r1, #0
c0d0173e:	d101      	bne.n	c0d01744 <io_seproxyhal_button_push+0x4c>
c0d01740:	0781      	lsls	r1, r0, #30
c0d01742:	430d      	orrs	r5, r1
c0d01744:	07c0      	lsls	r0, r0, #31
      }
      */

      // discard the release event after a fastskip has been detected, to avoid strange at release behavior
      // and also to enable user to cancel an operation by starting triggering the fast skip
      button_mask &= ~BUTTON_EVT_RELEASED;
c0d01746:	4385      	bics	r5, r0
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01748:	4628      	mov	r0, r5
c0d0174a:	4631      	mov	r1, r6
c0d0174c:	47a0      	blx	r4

  }
}
c0d0174e:	bd70      	pop	{r4, r5, r6, pc}
c0d01750:	20001f68 	.word	0x20001f68
c0d01754:	7fffffff 	.word	0x7fffffff

c0d01758 <os_io_seproxyhal_get_app_name_and_version>:
#ifdef HAVE_IO_U2F
u2f_service_t G_io_u2f;
#endif // HAVE_IO_U2F

unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
c0d01758:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0175a:	b081      	sub	sp, #4
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d0175c:	4e0f      	ldr	r6, [pc, #60]	; (c0d0179c <os_io_seproxyhal_get_app_name_and_version+0x44>)
c0d0175e:	2401      	movs	r4, #1
c0d01760:	7034      	strb	r4, [r6, #0]

#ifndef HAVE_BOLOS
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d01762:	1cb1      	adds	r1, r6, #2
c0d01764:	27ff      	movs	r7, #255	; 0xff
c0d01766:	3750      	adds	r7, #80	; 0x50
c0d01768:	1c7a      	adds	r2, r7, #1
c0d0176a:	4620      	mov	r0, r4
c0d0176c:	f000 fdbe 	bl	c0d022ec <os_registry_get_current_app_tag>
c0d01770:	4605      	mov	r5, r0
  G_io_apdu_buffer[tx_len++] = len;
c0d01772:	7070      	strb	r0, [r6, #1]
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d01774:	1a3a      	subs	r2, r7, r0
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d01776:	1837      	adds	r7, r6, r0
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
  G_io_apdu_buffer[tx_len++] = len;
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d01778:	1cf9      	adds	r1, r7, #3
c0d0177a:	2002      	movs	r0, #2
c0d0177c:	f000 fdb6 	bl	c0d022ec <os_registry_get_current_app_tag>
  G_io_apdu_buffer[tx_len++] = len;
c0d01780:	70b8      	strb	r0, [r7, #2]
c0d01782:	182d      	adds	r5, r5, r0
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d01784:	1976      	adds	r6, r6, r5
#endif // HAVE_BOLOS

#if !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)
  // to be fixed within io tasks
  // return OS flags to notify of platform's global state (pin lock etc)
  G_io_apdu_buffer[tx_len++] = 1; // flags length
c0d01786:	70f4      	strb	r4, [r6, #3]
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d01788:	f000 fda4 	bl	c0d022d4 <os_flags>
c0d0178c:	2100      	movs	r1, #0
#endif // !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)

  // status words
  G_io_apdu_buffer[tx_len++] = 0x90;
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d0178e:	71b1      	strb	r1, [r6, #6]
c0d01790:	2190      	movs	r1, #144	; 0x90
  G_io_apdu_buffer[tx_len++] = 1; // flags length
  G_io_apdu_buffer[tx_len++] = os_flags();
#endif // !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)

  // status words
  G_io_apdu_buffer[tx_len++] = 0x90;
c0d01792:	7171      	strb	r1, [r6, #5]

#if !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)
  // to be fixed within io tasks
  // return OS flags to notify of platform's global state (pin lock etc)
  G_io_apdu_buffer[tx_len++] = 1; // flags length
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d01794:	7130      	strb	r0, [r6, #4]
#endif // !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)

  // status words
  G_io_apdu_buffer[tx_len++] = 0x90;
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d01796:	1de8      	adds	r0, r5, #7
  return tx_len;
c0d01798:	b001      	add	sp, #4
c0d0179a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0179c:	20001df4 	.word	0x20001df4

c0d017a0 <io_exchange>:
}


unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d017a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d017a2:	b08b      	sub	sp, #44	; 0x2c
c0d017a4:	4607      	mov	r7, r0
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d017a6:	0740      	lsls	r0, r0, #29
c0d017a8:	d008      	beq.n	c0d017bc <io_exchange+0x1c>
c0d017aa:	9707      	str	r7, [sp, #28]
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d017ac:	9807      	ldr	r0, [sp, #28]
c0d017ae:	b2c0      	uxtb	r0, r0
c0d017b0:	b289      	uxth	r1, r1
c0d017b2:	f7fe fef3 	bl	c0d0059c <io_exchange_al>
  }
}
c0d017b6:	b280      	uxth	r0, r0
c0d017b8:	b00b      	add	sp, #44	; 0x2c
c0d017ba:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d017bc:	20a5      	movs	r0, #165	; 0xa5
c0d017be:	0040      	lsls	r0, r0, #1
c0d017c0:	9001      	str	r0, [sp, #4]
c0d017c2:	4ca0      	ldr	r4, [pc, #640]	; (c0d01a44 <io_exchange+0x2a4>)
c0d017c4:	4e9e      	ldr	r6, [pc, #632]	; (c0d01a40 <io_exchange+0x2a0>)
c0d017c6:	9707      	str	r7, [sp, #28]
c0d017c8:	2010      	movs	r0, #16
reply_apdu:
  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d017ca:	463d      	mov	r5, r7
c0d017cc:	4005      	ands	r5, r0
c0d017ce:	b28a      	uxth	r2, r1
c0d017d0:	2a00      	cmp	r2, #0
c0d017d2:	d100      	bne.n	c0d017d6 <io_exchange+0x36>
c0d017d4:	e0b1      	b.n	c0d0193a <io_exchange+0x19a>
c0d017d6:	2d00      	cmp	r5, #0
c0d017d8:	d000      	beq.n	c0d017dc <io_exchange+0x3c>
c0d017da:	e0ae      	b.n	c0d0193a <io_exchange+0x19a>
c0d017dc:	9206      	str	r2, [sp, #24]
c0d017de:	9103      	str	r1, [sp, #12]
c0d017e0:	9004      	str	r0, [sp, #16]
c0d017e2:	9505      	str	r5, [sp, #20]
c0d017e4:	e007      	b.n	c0d017f6 <io_exchange+0x56>
c0d017e6:	2180      	movs	r1, #128	; 0x80
c0d017e8:	2200      	movs	r2, #0
      // ensure it's our turn to send a command/status, could lag a bit before sending the reply
      while (io_seproxyhal_spi_is_status_sent()) {
        io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d017ea:	4630      	mov	r0, r6
c0d017ec:	f000 fdb0 	bl	c0d02350 <io_seph_recv>
c0d017f0:	2001      	movs	r0, #1
        // process without sending status on tickers etc, to ensure keeping the hand
        os_io_seph_recv_and_process(1);
c0d017f2:	f000 f939 	bl	c0d01a68 <os_io_seph_recv_and_process>
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
      // ensure it's our turn to send a command/status, could lag a bit before sending the reply
      while (io_seproxyhal_spi_is_status_sent()) {
c0d017f6:	f000 fd9f 	bl	c0d02338 <io_seph_is_status_sent>
c0d017fa:	2800      	cmp	r0, #0
c0d017fc:	d1f3      	bne.n	c0d017e6 <io_exchange+0x46>
c0d017fe:	207d      	movs	r0, #125	; 0x7d
c0d01800:	0100      	lsls	r0, r0, #4
        // process without sending status on tickers etc, to ensure keeping the hand
        os_io_seph_recv_and_process(1);
      }

      // reinit sending timeout for APDU replied within io_exchange
      timeout_ms = G_io_app.ms + IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d01802:	68a1      	ldr	r1, [r4, #8]
c0d01804:	180d      	adds	r5, r1, r0

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_app.apdu_state) {
c0d01806:	7820      	ldrb	r0, [r4, #0]
c0d01808:	2809      	cmp	r0, #9
c0d0180a:	dc3f      	bgt.n	c0d0188c <io_exchange+0xec>
c0d0180c:	2807      	cmp	r0, #7
c0d0180e:	9906      	ldr	r1, [sp, #24]
c0d01810:	d047      	beq.n	c0d018a2 <io_exchange+0x102>
c0d01812:	2809      	cmp	r0, #9
c0d01814:	d160      	bne.n	c0d018d8 <io_exchange+0x138>
c0d01816:	2100      	movs	r1, #0
c0d01818:	488b      	ldr	r0, [pc, #556]	; (c0d01a48 <io_exchange+0x2a8>)
c0d0181a:	9102      	str	r1, [sp, #8]
          // case to handle U2F channels. u2f apdu to be dispatched in the upper layers
          case APDU_U2F:
            // prepare reply, the remaining segments will be pumped during USB/BLE events handling while waiting for the next APDU

            // the reply has been prepared by the application, stop sending anti timeouts
            u2f_message_set_autoreply_wait_user_presence(&G_io_u2f, false);
c0d0181c:	f001 fa26 	bl	c0d02c6c <u2f_message_set_autoreply_wait_user_presence>
c0d01820:	e010      	b.n	c0d01844 <io_exchange+0xa4>

            // continue processing currently received command until completely received.
            while(!u2f_message_repliable(&G_io_u2f)) {

              io_seproxyhal_general_status();
c0d01822:	f7ff fd5b 	bl	c0d012dc <io_seproxyhal_general_status>
c0d01826:	2180      	movs	r1, #128	; 0x80
c0d01828:	2200      	movs	r2, #0
              do {
                io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0182a:	4630      	mov	r0, r6
c0d0182c:	f000 fd90 	bl	c0d02350 <io_seph_recv>
                // check for reply timeout
                if (G_io_app.ms >= timeout_ms) {
c0d01830:	68a0      	ldr	r0, [r4, #8]
c0d01832:	42a8      	cmp	r0, r5
c0d01834:	d300      	bcc.n	c0d01838 <io_exchange+0x98>
c0d01836:	e0f7      	b.n	c0d01a28 <io_exchange+0x288>
                  THROW(EXCEPTION_IO_RESET);
                }
                // avoid a general status to be replied
                io_seproxyhal_handle_event();
c0d01838:	f7ff fe36 	bl	c0d014a8 <io_seproxyhal_handle_event>
              } while (io_seproxyhal_spi_is_status_sent());
c0d0183c:	f000 fd7c 	bl	c0d02338 <io_seph_is_status_sent>
c0d01840:	2800      	cmp	r0, #0
c0d01842:	d1f0      	bne.n	c0d01826 <io_exchange+0x86>

            // the reply has been prepared by the application, stop sending anti timeouts
            u2f_message_set_autoreply_wait_user_presence(&G_io_u2f, false);

            // continue processing currently received command until completely received.
            while(!u2f_message_repliable(&G_io_u2f)) {
c0d01844:	4880      	ldr	r0, [pc, #512]	; (c0d01a48 <io_exchange+0x2a8>)
c0d01846:	f000 ffb5 	bl	c0d027b4 <u2f_message_repliable>
c0d0184a:	2800      	cmp	r0, #0
c0d0184c:	d0e9      	beq.n	c0d01822 <io_exchange+0x82>
              } while (io_seproxyhal_spi_is_status_sent());
            }
#ifdef U2F_PROXY_MAGIC

            // user presence + counter + rapdu + sw must fit the apdu buffer
            if (1U+ 4U+ tx_len +2U > sizeof(G_io_apdu_buffer)) {
c0d0184e:	9801      	ldr	r0, [sp, #4]
c0d01850:	9a06      	ldr	r2, [sp, #24]
c0d01852:	4282      	cmp	r2, r0
c0d01854:	d900      	bls.n	c0d01858 <io_exchange+0xb8>
c0d01856:	e0ed      	b.n	c0d01a34 <io_exchange+0x294>
c0d01858:	2090      	movs	r0, #144	; 0x90
c0d0185a:	497c      	ldr	r1, [pc, #496]	; (c0d01a4c <io_exchange+0x2ac>)
              THROW(INVALID_PARAMETER);
            }

            // u2F tunnel needs the status words to be included in the signature response BLOB, do it now.
            // always return 9000 in the signature to avoid error @ transport level in u2f layers. 
            G_io_apdu_buffer[tx_len] = 0x90; //G_io_apdu_buffer[tx_len-2];
c0d0185c:	5488      	strb	r0, [r1, r2]
c0d0185e:	1888      	adds	r0, r1, r2
            G_io_apdu_buffer[tx_len+1] = 0x00; //G_io_apdu_buffer[tx_len-1];
c0d01860:	9a02      	ldr	r2, [sp, #8]
c0d01862:	7042      	strb	r2, [r0, #1]
            tx_len += 2;
            os_memmove(G_io_apdu_buffer+5, G_io_apdu_buffer, tx_len);
c0d01864:	1d48      	adds	r0, r1, #5

            // u2F tunnel needs the status words to be included in the signature response BLOB, do it now.
            // always return 9000 in the signature to avoid error @ transport level in u2f layers. 
            G_io_apdu_buffer[tx_len] = 0x90; //G_io_apdu_buffer[tx_len-2];
            G_io_apdu_buffer[tx_len+1] = 0x00; //G_io_apdu_buffer[tx_len-1];
            tx_len += 2;
c0d01866:	9a03      	ldr	r2, [sp, #12]
c0d01868:	1c92      	adds	r2, r2, #2
            os_memmove(G_io_apdu_buffer+5, G_io_apdu_buffer, tx_len);
c0d0186a:	b292      	uxth	r2, r2
c0d0186c:	f7ff fcf3 	bl	c0d01256 <os_memmove>
c0d01870:	2205      	movs	r2, #5
            // zeroize user presence and counter
            os_memset(G_io_apdu_buffer, 0, 5);
c0d01872:	4876      	ldr	r0, [pc, #472]	; (c0d01a4c <io_exchange+0x2ac>)
c0d01874:	9902      	ldr	r1, [sp, #8]
c0d01876:	f7ff fd04 	bl	c0d01282 <os_memset>
            u2f_message_reply(&G_io_u2f, U2F_CMD_MSG, G_io_apdu_buffer, tx_len+5);
c0d0187a:	9803      	ldr	r0, [sp, #12]
c0d0187c:	1dc0      	adds	r0, r0, #7
c0d0187e:	b283      	uxth	r3, r0
c0d01880:	2183      	movs	r1, #131	; 0x83
c0d01882:	4871      	ldr	r0, [pc, #452]	; (c0d01a48 <io_exchange+0x2a8>)
c0d01884:	4a71      	ldr	r2, [pc, #452]	; (c0d01a4c <io_exchange+0x2ac>)
c0d01886:	f001 fa05 	bl	c0d02c94 <u2f_message_reply>
c0d0188a:	e040      	b.n	c0d0190e <io_exchange+0x16e>
      // reinit sending timeout for APDU replied within io_exchange
      timeout_ms = G_io_app.ms + IO_RAPDU_TRANSMIT_TIMEOUT_MS;

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_app.apdu_state) {
c0d0188c:	280a      	cmp	r0, #10
c0d0188e:	9a03      	ldr	r2, [sp, #12]
c0d01890:	9906      	ldr	r1, [sp, #24]
c0d01892:	d00b      	beq.n	c0d018ac <io_exchange+0x10c>
c0d01894:	280b      	cmp	r0, #11
c0d01896:	d122      	bne.n	c0d018de <io_exchange+0x13e>
            io_usb_ccid_reply(G_io_apdu_buffer, tx_len);
            goto break_send;
#endif // HAVE_USB_CLASS_CCID
#ifdef HAVE_WEBUSB
          case APDU_USB_WEBUSB:
            io_usb_hid_send(io_usb_send_apdu_data_ep0x83, tx_len);
c0d01898:	486f      	ldr	r0, [pc, #444]	; (c0d01a58 <io_exchange+0x2b8>)
c0d0189a:	4478      	add	r0, pc
c0d0189c:	f000 fa32 	bl	c0d01d04 <io_usb_hid_send>
c0d018a0:	e035      	b.n	c0d0190e <io_exchange+0x16e>
            goto break_send;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_send(io_usb_send_apdu_data, tx_len);
c0d018a2:	486c      	ldr	r0, [pc, #432]	; (c0d01a54 <io_exchange+0x2b4>)
c0d018a4:	4478      	add	r0, pc
c0d018a6:	f000 fa2d 	bl	c0d01d04 <io_usb_hid_send>
c0d018aa:	e030      	b.n	c0d0190e <io_exchange+0x16e>
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
            break;

          case APDU_RAW:
            if (tx_len > sizeof(G_io_apdu_buffer)) {
c0d018ac:	9801      	ldr	r0, [sp, #4]
c0d018ae:	1dc0      	adds	r0, r0, #7
c0d018b0:	4281      	cmp	r1, r0
c0d018b2:	d900      	bls.n	c0d018b6 <io_exchange+0x116>
c0d018b4:	e0be      	b.n	c0d01a34 <io_exchange+0x294>
c0d018b6:	460d      	mov	r5, r1
              THROW(INVALID_PARAMETER);
            }
            // reply the RAW APDU over SEPROXYHAL protocol
            G_io_seproxyhal_spi_buffer[0]  = SEPROXYHAL_TAG_RAPDU;
            G_io_seproxyhal_spi_buffer[1]  = (tx_len)>>8;
            G_io_seproxyhal_spi_buffer[2]  = (tx_len);
c0d018b8:	70b2      	strb	r2, [r6, #2]
c0d018ba:	2053      	movs	r0, #83	; 0x53
          case APDU_RAW:
            if (tx_len > sizeof(G_io_apdu_buffer)) {
              THROW(INVALID_PARAMETER);
            }
            // reply the RAW APDU over SEPROXYHAL protocol
            G_io_seproxyhal_spi_buffer[0]  = SEPROXYHAL_TAG_RAPDU;
c0d018bc:	7030      	strb	r0, [r6, #0]
            G_io_seproxyhal_spi_buffer[1]  = (tx_len)>>8;
c0d018be:	0a10      	lsrs	r0, r2, #8
c0d018c0:	7070      	strb	r0, [r6, #1]
c0d018c2:	2103      	movs	r1, #3
            G_io_seproxyhal_spi_buffer[2]  = (tx_len);
            io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d018c4:	4630      	mov	r0, r6
c0d018c6:	f000 fd2b 	bl	c0d02320 <io_seph_send>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d018ca:	4860      	ldr	r0, [pc, #384]	; (c0d01a4c <io_exchange+0x2ac>)
c0d018cc:	4629      	mov	r1, r5
c0d018ce:	f000 fd27 	bl	c0d02320 <io_seph_send>
c0d018d2:	2000      	movs	r0, #0

            // isngle packet reply, mark immediate idle
            G_io_app.apdu_state = APDU_IDLE;
c0d018d4:	7020      	strb	r0, [r4, #0]
c0d018d6:	e01d      	b.n	c0d01914 <io_exchange+0x174>
      // reinit sending timeout for APDU replied within io_exchange
      timeout_ms = G_io_app.ms + IO_RAPDU_TRANSMIT_TIMEOUT_MS;

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_app.apdu_state) {
c0d018d8:	2800      	cmp	r0, #0
c0d018da:	d100      	bne.n	c0d018de <io_exchange+0x13e>
c0d018dc:	e0a7      	b.n	c0d01a2e <io_exchange+0x28e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d018de:	9807      	ldr	r0, [sp, #28]
c0d018e0:	b2c0      	uxtb	r0, r0
c0d018e2:	f7fe fe5b 	bl	c0d0059c <io_exchange_al>
c0d018e6:	2800      	cmp	r0, #0
c0d018e8:	d011      	beq.n	c0d0190e <io_exchange+0x16e>
c0d018ea:	e0a0      	b.n	c0d01a2e <io_exchange+0x28e>
        // TODO: add timeout here to avoid spending too much time when host has disconnected
        while (G_io_app.apdu_state != APDU_IDLE) {
#ifdef HAVE_TINY_COROUTINE
          tcr_yield();
#else // HAVE_TINY_COROUTINE
          io_seproxyhal_general_status();
c0d018ec:	f7ff fcf6 	bl	c0d012dc <io_seproxyhal_general_status>
c0d018f0:	2180      	movs	r1, #128	; 0x80
c0d018f2:	2200      	movs	r2, #0
          do {
            io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d018f4:	4630      	mov	r0, r6
c0d018f6:	f000 fd2b 	bl	c0d02350 <io_seph_recv>
            // check for reply timeout (when asynch reply (over hid or u2f for example))
            // this case shall be covered by usb_ep_timeout but is not, investigate that
            if (G_io_app.ms >= timeout_ms) {
c0d018fa:	68a0      	ldr	r0, [r4, #8]
c0d018fc:	42a8      	cmp	r0, r5
c0d018fe:	d300      	bcc.n	c0d01902 <io_exchange+0x162>
c0d01900:	e092      	b.n	c0d01a28 <io_exchange+0x288>
              THROW(EXCEPTION_IO_RESET);
            }
            // avoid a general status to be replied
            io_seproxyhal_handle_event();
c0d01902:	f7ff fdd1 	bl	c0d014a8 <io_seproxyhal_handle_event>
          } while (io_seproxyhal_spi_is_status_sent());
c0d01906:	f000 fd17 	bl	c0d02338 <io_seph_is_status_sent>
c0d0190a:	2800      	cmp	r0, #0
c0d0190c:	d1f0      	bne.n	c0d018f0 <io_exchange+0x150>

      break_send:

        // wait end of reply transmission
        // TODO: add timeout here to avoid spending too much time when host has disconnected
        while (G_io_app.apdu_state != APDU_IDLE) {
c0d0190e:	7820      	ldrb	r0, [r4, #0]
c0d01910:	2800      	cmp	r0, #0
c0d01912:	d1eb      	bne.n	c0d018ec <io_exchange+0x14c>
c0d01914:	2000      	movs	r0, #0
          } while (io_seproxyhal_spi_is_status_sent());
#endif // HAVE_TINY_COROUTINE
        }
        // reset apdu state
        G_io_app.apdu_state = APDU_IDLE;
        G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d01916:	71a0      	strb	r0, [r4, #6]
            io_seproxyhal_handle_event();
          } while (io_seproxyhal_spi_is_status_sent());
#endif // HAVE_TINY_COROUTINE
        }
        // reset apdu state
        G_io_app.apdu_state = APDU_IDLE;
c0d01918:	7020      	strb	r0, [r4, #0]
        G_io_app.apdu_media = IO_APDU_MEDIA_NONE;

        G_io_app.apdu_length = 0;
c0d0191a:	8060      	strh	r0, [r4, #2]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d0191c:	06b9      	lsls	r1, r7, #26
c0d0191e:	d500      	bpl.n	c0d01922 <io_exchange+0x182>
c0d01920:	e749      	b.n	c0d017b6 <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01922:	f7ff fcdb 	bl	c0d012dc <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01926:	0638      	lsls	r0, r7, #24
c0d01928:	9d05      	ldr	r5, [sp, #20]
c0d0192a:	9804      	ldr	r0, [sp, #16]
c0d0192c:	d505      	bpl.n	c0d0193a <io_exchange+0x19a>
#define SYSCALL_os_sched_exit_ID_IN 0x60009abeUL
#define SYSCALL_os_sched_exit_ID_OUT 0x90009adeUL
__attribute__((always_inline)) inline void
os_sched_exit_inline(bolos_task_status_t exit_code) {
  volatile unsigned int parameters[2 + 1];
  parameters[0] = (unsigned int)exit_code;
c0d0192e:	9008      	str	r0, [sp, #32]
c0d01930:	aa08      	add	r2, sp, #32
  __asm volatile("mov r0, %1\n"
c0d01932:	4b47      	ldr	r3, [pc, #284]	; (c0d01a50 <io_exchange+0x2b0>)
c0d01934:	4618      	mov	r0, r3
c0d01936:	4611      	mov	r1, r2
c0d01938:	df01      	svc	1
        //reset();
      }
    }

#ifndef HAVE_TINY_COROUTINE
    if (!(channel&IO_ASYNCH_REPLY)) {
c0d0193a:	2d00      	cmp	r5, #0
c0d0193c:	d104      	bne.n	c0d01948 <io_exchange+0x1a8>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d0193e:	0678      	lsls	r0, r7, #25
c0d01940:	d46d      	bmi.n	c0d01a1e <io_exchange+0x27e>
c0d01942:	2000      	movs	r0, #0
        return G_io_app.apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_app.apdu_state = APDU_IDLE;
      G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d01944:	71a0      	strb	r0, [r4, #6]
        // return apdu data - header
        return G_io_app.apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_app.apdu_state = APDU_IDLE;
c0d01946:	7020      	strb	r0, [r4, #0]
c0d01948:	4f40      	ldr	r7, [pc, #256]	; (c0d01a4c <io_exchange+0x2ac>)
c0d0194a:	2000      	movs	r0, #0
c0d0194c:	8060      	strh	r0, [r4, #2]
#ifdef HAVE_TINY_COROUTINE
      // give back hand to the seph task which interprets all incoming events first
      tcr_yield();
#else // HAVE_TINY_COROUTINE

      if (!io_seproxyhal_spi_is_status_sent()) {
c0d0194e:	f000 fcf3 	bl	c0d02338 <io_seph_is_status_sent>
c0d01952:	2800      	cmp	r0, #0
c0d01954:	d101      	bne.n	c0d0195a <io_exchange+0x1ba>
        io_seproxyhal_general_status();
c0d01956:	f7ff fcc1 	bl	c0d012dc <io_seproxyhal_general_status>
c0d0195a:	2180      	movs	r1, #128	; 0x80
c0d0195c:	2500      	movs	r5, #0
      }
      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0195e:	4630      	mov	r0, r6
c0d01960:	462a      	mov	r2, r5
c0d01962:	f000 fcf5 	bl	c0d02350 <io_seph_recv>

      // can't process split TLV, continue
      if (rx_len < 3 && rx_len != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])+3U) {
c0d01966:	2802      	cmp	r0, #2
c0d01968:	d806      	bhi.n	c0d01978 <io_exchange+0x1d8>
c0d0196a:	78b1      	ldrb	r1, [r6, #2]
c0d0196c:	7872      	ldrb	r2, [r6, #1]
c0d0196e:	0212      	lsls	r2, r2, #8
c0d01970:	1851      	adds	r1, r2, r1
c0d01972:	1cc9      	adds	r1, r1, #3
c0d01974:	4281      	cmp	r1, r0
c0d01976:	d108      	bne.n	c0d0198a <io_exchange+0x1ea>
        G_io_app.apdu_state = APDU_IDLE;
        G_io_app.apdu_length = 0;
        continue;
      }

      io_seproxyhal_handle_event();
c0d01978:	f7ff fd96 	bl	c0d014a8 <io_seproxyhal_handle_event>
#endif // HAVE_TINY_COROUTINE

      // an apdu has been received asynchroneously, return it
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
c0d0197c:	8860      	ldrh	r0, [r4, #2]
c0d0197e:	7821      	ldrb	r1, [r4, #0]
c0d01980:	2900      	cmp	r1, #0
c0d01982:	d0e4      	beq.n	c0d0194e <io_exchange+0x1ae>
c0d01984:	2800      	cmp	r0, #0
c0d01986:	d0e2      	beq.n	c0d0194e <io_exchange+0x1ae>
c0d01988:	e002      	b.n	c0d01990 <io_exchange+0x1f0>
c0d0198a:	2000      	movs	r0, #0
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // can't process split TLV, continue
      if (rx_len < 3 && rx_len != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])+3U) {
        LOG("invalid TLV format\n");
        G_io_app.apdu_state = APDU_IDLE;
c0d0198c:	7020      	strb	r0, [r4, #0]
c0d0198e:	e7dc      	b.n	c0d0194a <io_exchange+0x1aa>
      // an apdu has been received asynchroneously, return it
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
#ifndef HAVE_BOLOS_NO_DEFAULT_APDU
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
c0d01990:	4932      	ldr	r1, [pc, #200]	; (c0d01a5c <io_exchange+0x2bc>)
c0d01992:	4479      	add	r1, pc
c0d01994:	2204      	movs	r2, #4
c0d01996:	4638      	mov	r0, r7
c0d01998:	f7ff fc7c 	bl	c0d01294 <os_memcmp>
c0d0199c:	2800      	cmp	r0, #0
c0d0199e:	d026      	beq.n	c0d019ee <io_exchange+0x24e>
          // disable 'return after tx' and 'asynch reply' flags
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
c0d019a0:	492f      	ldr	r1, [pc, #188]	; (c0d01a60 <io_exchange+0x2c0>)
c0d019a2:	4479      	add	r1, pc
c0d019a4:	2204      	movs	r2, #4
c0d019a6:	4638      	mov	r0, r7
c0d019a8:	f7ff fc74 	bl	c0d01294 <os_memcmp>
c0d019ac:	2800      	cmp	r0, #0
c0d019ae:	d022      	beq.n	c0d019f6 <io_exchange+0x256>
        }
#ifndef BOLOS_OS_UPGRADER
        // seed cookie
        // host: <nothing>
        // device: <format(1B)> <len(1B)> <seed magic cookie if pin is entered(len)> 9000 | 6985
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\x02\x00\x00", 4) == 0) {
c0d019b0:	492c      	ldr	r1, [pc, #176]	; (c0d01a64 <io_exchange+0x2c4>)
c0d019b2:	4479      	add	r1, pc
c0d019b4:	2204      	movs	r2, #4
c0d019b6:	4638      	mov	r0, r7
c0d019b8:	f7ff fc6c 	bl	c0d01294 <os_memcmp>
c0d019bc:	2800      	cmp	r0, #0
c0d019be:	d131      	bne.n	c0d01a24 <io_exchange+0x284>
          tx_len = 0;
          if (os_global_pin_is_validated() == BOLOS_UX_OK) {
c0d019c0:	f000 fc70 	bl	c0d022a4 <os_global_pin_is_validated>
c0d019c4:	28aa      	cmp	r0, #170	; 0xaa
c0d019c6:	d11f      	bne.n	c0d01a08 <io_exchange+0x268>
c0d019c8:	2001      	movs	r0, #1
            unsigned int i;
            // format
            G_io_apdu_buffer[tx_len++] = 0x01;
c0d019ca:	7038      	strb	r0, [r7, #0]

#ifndef HAVE_BOLOS
            i = os_perso_seed_cookie(G_io_apdu_buffer+1+1, MIN(64,sizeof(G_io_apdu_buffer)-1-1-2));
c0d019cc:	1cb8      	adds	r0, r7, #2
c0d019ce:	2140      	movs	r1, #64	; 0x40
c0d019d0:	f000 fc5a 	bl	c0d02288 <os_perso_seed_cookie>
#else
            i = os_perso_seed_cookie_os(G_io_apdu_buffer+1+1, MIN(64,sizeof(G_io_apdu_buffer)-1-1-2));
#endif // HAVE_BOLOS

            G_io_apdu_buffer[tx_len++] = i;
c0d019d4:	7078      	strb	r0, [r7, #1]
            tx_len += i;
c0d019d6:	1c81      	adds	r1, r0, #2
c0d019d8:	4a18      	ldr	r2, [pc, #96]	; (c0d01a3c <io_exchange+0x29c>)
c0d019da:	4613      	mov	r3, r2
            G_io_apdu_buffer[tx_len++] = 0x90;
c0d019dc:	4011      	ands	r1, r2
c0d019de:	2290      	movs	r2, #144	; 0x90
c0d019e0:	547a      	strb	r2, [r7, r1]
c0d019e2:	1cc1      	adds	r1, r0, #3
            G_io_apdu_buffer[tx_len++] = 0x00;
c0d019e4:	4019      	ands	r1, r3
c0d019e6:	2500      	movs	r5, #0
c0d019e8:	547d      	strb	r5, [r7, r1]
c0d019ea:	1d01      	adds	r1, r0, #4
c0d019ec:	e011      	b.n	c0d01a12 <io_exchange+0x272>
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
#ifndef HAVE_BOLOS_NO_DEFAULT_APDU
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
          tx_len = os_io_seproxyhal_get_app_name_and_version();
c0d019ee:	f7ff feb3 	bl	c0d01758 <os_io_seproxyhal_get_app_name_and_version>
c0d019f2:	4601      	mov	r1, r0
c0d019f4:	e00d      	b.n	c0d01a12 <io_exchange+0x272>
c0d019f6:	2000      	movs	r0, #0
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
          tx_len = 0;
          G_io_apdu_buffer[tx_len++] = 0x90;
          G_io_apdu_buffer[tx_len++] = 0x00;
c0d019f8:	7078      	strb	r0, [r7, #1]
c0d019fa:	2090      	movs	r0, #144	; 0x90
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
          tx_len = 0;
          G_io_apdu_buffer[tx_len++] = 0x90;
c0d019fc:	7038      	strb	r0, [r7, #0]
c0d019fe:	207f      	movs	r0, #127	; 0x7f
c0d01a00:	43c0      	mvns	r0, r0
c0d01a02:	9d07      	ldr	r5, [sp, #28]
          G_io_apdu_buffer[tx_len++] = 0x00;
          // exit app after replied
          channel |= IO_RESET_AFTER_REPLIED;
c0d01a04:	4305      	orrs	r5, r0
c0d01a06:	e003      	b.n	c0d01a10 <io_exchange+0x270>
c0d01a08:	2085      	movs	r0, #133	; 0x85
            G_io_apdu_buffer[tx_len++] = 0x90;
            G_io_apdu_buffer[tx_len++] = 0x00;
          }
          else {
            G_io_apdu_buffer[tx_len++] = 0x69;
            G_io_apdu_buffer[tx_len++] = 0x85;
c0d01a0a:	7078      	strb	r0, [r7, #1]
c0d01a0c:	2069      	movs	r0, #105	; 0x69
            tx_len += i;
            G_io_apdu_buffer[tx_len++] = 0x90;
            G_io_apdu_buffer[tx_len++] = 0x00;
          }
          else {
            G_io_apdu_buffer[tx_len++] = 0x69;
c0d01a0e:	7038      	strb	r0, [r7, #0]
c0d01a10:	2102      	movs	r1, #2
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d01a12:	b2ef      	uxtb	r7, r5
c0d01a14:	9507      	str	r5, [sp, #28]
c0d01a16:	0768      	lsls	r0, r5, #29
c0d01a18:	d100      	bne.n	c0d01a1c <io_exchange+0x27c>
c0d01a1a:	e6d5      	b.n	c0d017c8 <io_exchange+0x28>
c0d01a1c:	e6c6      	b.n	c0d017ac <io_exchange+0xc>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_app.apdu_length-5;
c0d01a1e:	8860      	ldrh	r0, [r4, #2]
c0d01a20:	1f40      	subs	r0, r0, #5
c0d01a22:	e6c8      	b.n	c0d017b6 <io_exchange+0x16>
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
#endif // BOLOS_OS_UPGRADER
#endif // HAVE_BOLOS_NO_DEFAULT_APDU
        return G_io_app.apdu_length;
c0d01a24:	8860      	ldrh	r0, [r4, #2]
c0d01a26:	e6c6      	b.n	c0d017b6 <io_exchange+0x16>
c0d01a28:	2010      	movs	r0, #16
c0d01a2a:	f7ff fc49 	bl	c0d012c0 <os_longjmp>
c0d01a2e:	2009      	movs	r0, #9
              goto break_send;
            }
            __attribute__((fallthrough));
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01a30:	f7ff fc46 	bl	c0d012c0 <os_longjmp>
c0d01a34:	2002      	movs	r0, #2
c0d01a36:	f7ff fc43 	bl	c0d012c0 <os_longjmp>
c0d01a3a:	46c0      	nop			; (mov r8, r8)
c0d01a3c:	0000ffff 	.word	0x0000ffff
c0d01a40:	20001d74 	.word	0x20001d74
c0d01a44:	20001f48 	.word	0x20001f48
c0d01a48:	20001f70 	.word	0x20001f70
c0d01a4c:	20001df4 	.word	0x20001df4
c0d01a50:	60009abe 	.word	0x60009abe
c0d01a54:	fffffba5 	.word	0xfffffba5
c0d01a58:	fffffbbf 	.word	0xfffffbbf
c0d01a5c:	00002ef8 	.word	0x00002ef8
c0d01a60:	00002eed 	.word	0x00002eed
c0d01a64:	00002ee2 	.word	0x00002ee2

c0d01a68 <os_io_seph_recv_and_process>:
  default:
    return io_exchange_al(channel, tx_len);
  }
}

unsigned int os_io_seph_recv_and_process(unsigned int dont_process_ux_events) {
c0d01a68:	b570      	push	{r4, r5, r6, lr}
c0d01a6a:	4605      	mov	r5, r0
  // send general status before receiving next event
  if (!io_seproxyhal_spi_is_status_sent()) {
c0d01a6c:	f000 fc64 	bl	c0d02338 <io_seph_is_status_sent>
c0d01a70:	2800      	cmp	r0, #0
c0d01a72:	d101      	bne.n	c0d01a78 <os_io_seph_recv_and_process+0x10>
    io_seproxyhal_general_status();
c0d01a74:	f7ff fc32 	bl	c0d012dc <io_seproxyhal_general_status>
  }

  io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01a78:	4e0c      	ldr	r6, [pc, #48]	; (c0d01aac <os_io_seph_recv_and_process+0x44>)
c0d01a7a:	2180      	movs	r1, #128	; 0x80
c0d01a7c:	2400      	movs	r4, #0
c0d01a7e:	4630      	mov	r0, r6
c0d01a80:	4622      	mov	r2, r4
c0d01a82:	f000 fc65 	bl	c0d02350 <io_seph_recv>

  switch (G_io_seproxyhal_spi_buffer[0]) {
c0d01a86:	7830      	ldrb	r0, [r6, #0]
c0d01a88:	2815      	cmp	r0, #21
c0d01a8a:	d806      	bhi.n	c0d01a9a <os_io_seph_recv_and_process+0x32>
c0d01a8c:	2101      	movs	r1, #1
c0d01a8e:	4081      	lsls	r1, r0
c0d01a90:	4807      	ldr	r0, [pc, #28]	; (c0d01ab0 <os_io_seph_recv_and_process+0x48>)
c0d01a92:	4201      	tst	r1, r0
c0d01a94:	d001      	beq.n	c0d01a9a <os_io_seph_recv_and_process+0x32>
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
    case SEPROXYHAL_TAG_TICKER_EVENT:
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
    case SEPROXYHAL_TAG_STATUS_EVENT:
      // perform UX event on these ones, don't process as an IO event
      if (dont_process_ux_events) {
c0d01a96:	2d00      	cmp	r5, #0
c0d01a98:	d106      	bne.n	c0d01aa8 <os_io_seph_recv_and_process+0x40>
      }
      __attribute__((fallthrough));

    default:
      // if malformed, then a stall is likely to occur
      if (io_seproxyhal_handle_event()) {
c0d01a9a:	f7ff fd05 	bl	c0d014a8 <io_seproxyhal_handle_event>
c0d01a9e:	2800      	cmp	r0, #0
c0d01aa0:	d101      	bne.n	c0d01aa6 <os_io_seph_recv_and_process+0x3e>
c0d01aa2:	4604      	mov	r4, r0
c0d01aa4:	e000      	b.n	c0d01aa8 <os_io_seph_recv_and_process+0x40>
c0d01aa6:	2401      	movs	r4, #1
        return 1;
      }
  }
  return 0;
}
c0d01aa8:	4620      	mov	r0, r4
c0d01aaa:	bd70      	pop	{r4, r5, r6, pc}
c0d01aac:	20001d74 	.word	0x20001d74
c0d01ab0:	00207020 	.word	0x00207020

c0d01ab4 <mcu_usb_printc>:

  return ret;
} 

// so unoptimized
void mcu_usb_printc(unsigned char c) {
c0d01ab4:	b5b0      	push	{r4, r5, r7, lr}
c0d01ab6:	b082      	sub	sp, #8
c0d01ab8:	ac01      	add	r4, sp, #4
#else // TARGET_NANOX
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
#endif // TARGET_NANOX
  buf[1] = 0;
  buf[2] = 1;
  buf[3] = c;
c0d01aba:	70e0      	strb	r0, [r4, #3]
c0d01abc:	2001      	movs	r0, #1
  buf[0] = SEPROXYHAL_TAG_PRINTF;
#else // TARGET_NANOX
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
#endif // TARGET_NANOX
  buf[1] = 0;
  buf[2] = 1;
c0d01abe:	70a0      	strb	r0, [r4, #2]
c0d01ac0:	2500      	movs	r5, #0
#ifdef TARGET_NANOX
  buf[0] = SEPROXYHAL_TAG_PRINTF;
#else // TARGET_NANOX
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
#endif // TARGET_NANOX
  buf[1] = 0;
c0d01ac2:	7065      	strb	r5, [r4, #1]
c0d01ac4:	2066      	movs	r0, #102	; 0x66
void mcu_usb_printc(unsigned char c) {
  unsigned char buf[4];
#ifdef TARGET_NANOX
  buf[0] = SEPROXYHAL_TAG_PRINTF;
#else // TARGET_NANOX
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
c0d01ac6:	7020      	strb	r0, [r4, #0]
c0d01ac8:	2104      	movs	r1, #4
#endif // TARGET_NANOX
  buf[1] = 0;
  buf[2] = 1;
  buf[3] = c;
  io_seproxyhal_spi_send(buf, 4);
c0d01aca:	4620      	mov	r0, r4
c0d01acc:	f000 fc28 	bl	c0d02320 <io_seph_send>
c0d01ad0:	2103      	movs	r1, #3
#ifndef TARGET_NANOX
#ifndef IO_SEPROXYHAL_DEBUG
  // wait printf ack (no race kthx)
  io_seproxyhal_spi_recv(buf, 3, 0);
c0d01ad2:	4620      	mov	r0, r4
c0d01ad4:	462a      	mov	r2, r5
c0d01ad6:	f000 fc3b 	bl	c0d02350 <io_seph_recv>
  buf[0] = 0; // consume tag to avoid misinterpretation (due to IO_CACHE)
#endif // IO_SEPROXYHAL_DEBUG
#endif // TARGET_NANOX
}
c0d01ada:	b002      	add	sp, #8
c0d01adc:	bdb0      	pop	{r4, r5, r7, pc}
	...

c0d01ae0 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_channel;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d01ae0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01ae2:	b081      	sub	sp, #4
c0d01ae4:	9200      	str	r2, [sp, #0]
c0d01ae6:	4604      	mov	r4, r0
  // avoid over/under flows
  if (buffer != G_io_usb_ep_buffer) {
c0d01ae8:	4e46      	ldr	r6, [pc, #280]	; (c0d01c04 <io_usb_hid_receive+0x124>)
c0d01aea:	42b1      	cmp	r1, r6
c0d01aec:	d010      	beq.n	c0d01b10 <io_usb_hid_receive+0x30>
c0d01aee:	460f      	mov	r7, r1
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d01af0:	4d44      	ldr	r5, [pc, #272]	; (c0d01c04 <io_usb_hid_receive+0x124>)
c0d01af2:	2100      	movs	r1, #0
c0d01af4:	2640      	movs	r6, #64	; 0x40
c0d01af6:	4628      	mov	r0, r5
c0d01af8:	4632      	mov	r2, r6
c0d01afa:	f7ff fbc2 	bl	c0d01282 <os_memset>
c0d01afe:	9a00      	ldr	r2, [sp, #0]
    os_memmove(G_io_usb_ep_buffer, buffer, MIN(l, sizeof(G_io_usb_ep_buffer)));
c0d01b00:	2a40      	cmp	r2, #64	; 0x40
c0d01b02:	d300      	bcc.n	c0d01b06 <io_usb_hid_receive+0x26>
c0d01b04:	4632      	mov	r2, r6
c0d01b06:	4628      	mov	r0, r5
c0d01b08:	4639      	mov	r1, r7
c0d01b0a:	f7ff fba4 	bl	c0d01256 <os_memmove>
c0d01b0e:	4e3d      	ldr	r6, [pc, #244]	; (c0d01c04 <io_usb_hid_receive+0x124>)
  }

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
c0d01b10:	78b0      	ldrb	r0, [r6, #2]
c0d01b12:	2801      	cmp	r0, #1
c0d01b14:	dc0a      	bgt.n	c0d01b2c <io_usb_hid_receive+0x4c>
c0d01b16:	2800      	cmp	r0, #0
c0d01b18:	d025      	beq.n	c0d01b66 <io_usb_hid_receive+0x86>
c0d01b1a:	2801      	cmp	r0, #1
c0d01b1c:	d160      	bne.n	c0d01be0 <io_usb_hid_receive+0x100>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_usb_ep_buffer+3, 4);
c0d01b1e:	1cf0      	adds	r0, r6, #3
c0d01b20:	2104      	movs	r1, #4
c0d01b22:	f000 fb0b 	bl	c0d0213c <cx_rng>
c0d01b26:	2140      	movs	r1, #64	; 0x40
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01b28:	4630      	mov	r0, r6
c0d01b2a:	e028      	b.n	c0d01b7e <io_usb_hid_receive+0x9e>
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
    os_memmove(G_io_usb_ep_buffer, buffer, MIN(l, sizeof(G_io_usb_ep_buffer)));
  }

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
c0d01b2c:	2802      	cmp	r0, #2
c0d01b2e:	d024      	beq.n	c0d01b7a <io_usb_hid_receive+0x9a>
c0d01b30:	2805      	cmp	r0, #5
c0d01b32:	d155      	bne.n	c0d01be0 <io_usb_hid_receive+0x100>
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if ((unsigned int)U2BE(G_io_usb_ep_buffer, 3) != (unsigned int)G_io_usb_hid_sequence_number) {
c0d01b34:	7930      	ldrb	r0, [r6, #4]
c0d01b36:	78f1      	ldrb	r1, [r6, #3]
c0d01b38:	0209      	lsls	r1, r1, #8
c0d01b3a:	1808      	adds	r0, r1, r0
c0d01b3c:	4c32      	ldr	r4, [pc, #200]	; (c0d01c08 <io_usb_hid_receive+0x128>)
c0d01b3e:	6821      	ldr	r1, [r4, #0]
c0d01b40:	2700      	movs	r7, #0
c0d01b42:	4288      	cmp	r0, r1
c0d01b44:	d153      	bne.n	c0d01bee <io_usb_hid_receive+0x10e>
    }
    // cid, tag, seq
    l -= 2+1+2;
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d01b46:	6820      	ldr	r0, [r4, #0]
c0d01b48:	2800      	cmp	r0, #0
c0d01b4a:	d01b      	beq.n	c0d01b84 <io_usb_hid_receive+0xa4>
    if ((unsigned int)U2BE(G_io_usb_ep_buffer, 3) != (unsigned int)G_io_usb_hid_sequence_number) {
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d01b4c:	9800      	ldr	r0, [sp, #0]
c0d01b4e:	1f40      	subs	r0, r0, #5
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d01b50:	b285      	uxth	r5, r0
c0d01b52:	482e      	ldr	r0, [pc, #184]	; (c0d01c0c <io_usb_hid_receive+0x12c>)
c0d01b54:	6801      	ldr	r1, [r0, #0]
c0d01b56:	42a9      	cmp	r1, r5
c0d01b58:	d201      	bcs.n	c0d01b5e <io_usb_hid_receive+0x7e>
        l = G_io_usb_hid_remaining_length;
c0d01b5a:	6800      	ldr	r0, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
c0d01b5c:	b285      	uxth	r5, r0
c0d01b5e:	482c      	ldr	r0, [pc, #176]	; (c0d01c10 <io_usb_hid_receive+0x130>)
c0d01b60:	6800      	ldr	r0, [r0, #0]
c0d01b62:	1d71      	adds	r1, r6, #5
c0d01b64:	e02e      	b.n	c0d01bc4 <io_usb_hid_receive+0xe4>
    G_io_usb_hid_sequence_number++;
    break;

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_usb_ep_buffer+3, 0, 4); // PROTOCOL VERSION is 0
c0d01b66:	1cf0      	adds	r0, r6, #3
c0d01b68:	2700      	movs	r7, #0
c0d01b6a:	2204      	movs	r2, #4
c0d01b6c:	4639      	mov	r1, r7
c0d01b6e:	f7ff fb88 	bl	c0d01282 <os_memset>
c0d01b72:	2140      	movs	r1, #64	; 0x40
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01b74:	4630      	mov	r0, r6
c0d01b76:	47a0      	blx	r4
c0d01b78:	e039      	b.n	c0d01bee <io_usb_hid_receive+0x10e>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d01b7a:	4822      	ldr	r0, [pc, #136]	; (c0d01c04 <io_usb_hid_receive+0x124>)
c0d01b7c:	2140      	movs	r1, #64	; 0x40
c0d01b7e:	47a0      	blx	r4
c0d01b80:	2700      	movs	r7, #0
c0d01b82:	e034      	b.n	c0d01bee <io_usb_hid_receive+0x10e>
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = U2BE(G_io_usb_ep_buffer, 5); //(G_io_usb_ep_buffer[5]<<8)+(G_io_usb_ep_buffer[6]&0xFF);
c0d01b84:	79b0      	ldrb	r0, [r6, #6]
c0d01b86:	7971      	ldrb	r1, [r6, #5]
c0d01b88:	0209      	lsls	r1, r1, #8
c0d01b8a:	1809      	adds	r1, r1, r0
c0d01b8c:	4821      	ldr	r0, [pc, #132]	; (c0d01c14 <io_usb_hid_receive+0x134>)
c0d01b8e:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d01b90:	6801      	ldr	r1, [r0, #0]
c0d01b92:	0849      	lsrs	r1, r1, #1
c0d01b94:	29a8      	cmp	r1, #168	; 0xa8
c0d01b96:	d82a      	bhi.n	c0d01bee <io_usb_hid_receive+0x10e>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d01b98:	6801      	ldr	r1, [r0, #0]
c0d01b9a:	481c      	ldr	r0, [pc, #112]	; (c0d01c0c <io_usb_hid_receive+0x12c>)
c0d01b9c:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);
c0d01b9e:	7871      	ldrb	r1, [r6, #1]
c0d01ba0:	7832      	ldrb	r2, [r6, #0]
c0d01ba2:	0212      	lsls	r2, r2, #8
c0d01ba4:	1851      	adds	r1, r2, r1
c0d01ba6:	4a1c      	ldr	r2, [pc, #112]	; (c0d01c18 <io_usb_hid_receive+0x138>)
c0d01ba8:	6011      	str	r1, [r2, #0]
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01baa:	4919      	ldr	r1, [pc, #100]	; (c0d01c10 <io_usb_hid_receive+0x130>)
c0d01bac:	4a1b      	ldr	r2, [pc, #108]	; (c0d01c1c <io_usb_hid_receive+0x13c>)
c0d01bae:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d01bb0:	9900      	ldr	r1, [sp, #0]
c0d01bb2:	1fc9      	subs	r1, r1, #7
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);

      if (l > G_io_usb_hid_remaining_length) {
c0d01bb4:	b28d      	uxth	r5, r1
c0d01bb6:	6801      	ldr	r1, [r0, #0]
c0d01bb8:	42a9      	cmp	r1, r5
c0d01bba:	d201      	bcs.n	c0d01bc0 <io_usb_hid_receive+0xe0>
        l = G_io_usb_hid_remaining_length;
c0d01bbc:	6800      	ldr	r0, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
c0d01bbe:	b285      	uxth	r5, r0
c0d01bc0:	1df1      	adds	r1, r6, #7
c0d01bc2:	4816      	ldr	r0, [pc, #88]	; (c0d01c1c <io_usb_hid_receive+0x13c>)
c0d01bc4:	462a      	mov	r2, r5
c0d01bc6:	f7ff fb46 	bl	c0d01256 <os_memmove>
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
    G_io_usb_hid_remaining_length -= l;
c0d01bca:	4810      	ldr	r0, [pc, #64]	; (c0d01c0c <io_usb_hid_receive+0x12c>)
c0d01bcc:	6801      	ldr	r1, [r0, #0]
c0d01bce:	1b49      	subs	r1, r1, r5
c0d01bd0:	6001      	str	r1, [r0, #0]
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d01bd2:	480f      	ldr	r0, [pc, #60]	; (c0d01c10 <io_usb_hid_receive+0x130>)
c0d01bd4:	6801      	ldr	r1, [r0, #0]
c0d01bd6:	1949      	adds	r1, r1, r5
c0d01bd8:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
    G_io_usb_hid_sequence_number++;
c0d01bda:	6820      	ldr	r0, [r4, #0]
c0d01bdc:	1c40      	adds	r0, r0, #1
c0d01bde:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d01be0:	480a      	ldr	r0, [pc, #40]	; (c0d01c0c <io_usb_hid_receive+0x12c>)
c0d01be2:	6800      	ldr	r0, [r0, #0]
c0d01be4:	2800      	cmp	r0, #0
c0d01be6:	d001      	beq.n	c0d01bec <io_usb_hid_receive+0x10c>
c0d01be8:	2701      	movs	r7, #1
c0d01bea:	e007      	b.n	c0d01bfc <io_usb_hid_receive+0x11c>
c0d01bec:	2702      	movs	r7, #2
c0d01bee:	4806      	ldr	r0, [pc, #24]	; (c0d01c08 <io_usb_hid_receive+0x128>)
c0d01bf0:	2100      	movs	r1, #0
c0d01bf2:	6001      	str	r1, [r0, #0]
c0d01bf4:	4806      	ldr	r0, [pc, #24]	; (c0d01c10 <io_usb_hid_receive+0x130>)
c0d01bf6:	6001      	str	r1, [r0, #0]
c0d01bf8:	4804      	ldr	r0, [pc, #16]	; (c0d01c0c <io_usb_hid_receive+0x12c>)
c0d01bfa:	6001      	str	r1, [r0, #0]
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d01bfc:	4638      	mov	r0, r7
c0d01bfe:	b001      	add	sp, #4
c0d01c00:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01c02:	46c0      	nop			; (mov r8, r8)
c0d01c04:	20001fb4 	.word	0x20001fb4
c0d01c08:	20001ff4 	.word	0x20001ff4
c0d01c0c:	20001ffc 	.word	0x20001ffc
c0d01c10:	20002000 	.word	0x20002000
c0d01c14:	20001ff8 	.word	0x20001ff8
c0d01c18:	20002004 	.word	0x20002004
c0d01c1c:	20001df4 	.word	0x20001df4

c0d01c20 <io_usb_hid_init>:

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01c20:	4803      	ldr	r0, [pc, #12]	; (c0d01c30 <io_usb_hid_init+0x10>)
c0d01c22:	2100      	movs	r1, #0
c0d01c24:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
  G_io_usb_hid_current_buffer = NULL;
c0d01c26:	4803      	ldr	r0, [pc, #12]	; (c0d01c34 <io_usb_hid_init+0x14>)
c0d01c28:	6001      	str	r1, [r0, #0]
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
  G_io_usb_hid_remaining_length = 0;
c0d01c2a:	4803      	ldr	r0, [pc, #12]	; (c0d01c38 <io_usb_hid_init+0x18>)
c0d01c2c:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_current_buffer = NULL;
}
c0d01c2e:	4770      	bx	lr
c0d01c30:	20001ff4 	.word	0x20001ff4
c0d01c34:	20002000 	.word	0x20002000
c0d01c38:	20001ffc 	.word	0x20001ffc

c0d01c3c <io_usb_hid_sent>:

/**
 * sent the next io_usb_hid transport chunk (rx on the host, tx on the device)
 */
void io_usb_hid_sent(io_send_t sndfct) {
c0d01c3c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c3e:	b081      	sub	sp, #4
  unsigned int l;

  // only prepare next chunk if some data to be sent remain
  if (G_io_usb_hid_remaining_length && G_io_usb_hid_current_buffer) {
c0d01c40:	4f2a      	ldr	r7, [pc, #168]	; (c0d01cec <io_usb_hid_sent+0xb0>)
c0d01c42:	683a      	ldr	r2, [r7, #0]
c0d01c44:	4c2a      	ldr	r4, [pc, #168]	; (c0d01cf0 <io_usb_hid_sent+0xb4>)
c0d01c46:	6821      	ldr	r1, [r4, #0]
c0d01c48:	2900      	cmp	r1, #0
c0d01c4a:	d01e      	beq.n	c0d01c8a <io_usb_hid_sent+0x4e>
c0d01c4c:	2a00      	cmp	r2, #0
c0d01c4e:	d01c      	beq.n	c0d01c8a <io_usb_hid_sent+0x4e>
c0d01c50:	9000      	str	r0, [sp, #0]
    // fill the chunk
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d01c52:	4d2a      	ldr	r5, [pc, #168]	; (c0d01cfc <io_usb_hid_sent+0xc0>)
c0d01c54:	2100      	movs	r1, #0
c0d01c56:	2240      	movs	r2, #64	; 0x40
c0d01c58:	4628      	mov	r0, r5
c0d01c5a:	f7ff fb12 	bl	c0d01282 <os_memset>
c0d01c5e:	2005      	movs	r0, #5

    // keep the channel identifier
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
    G_io_usb_ep_buffer[2] = 0x05;
c0d01c60:	70a8      	strb	r0, [r5, #2]
  if (G_io_usb_hid_remaining_length && G_io_usb_hid_current_buffer) {
    // fill the chunk
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));

    // keep the channel identifier
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
c0d01c62:	4827      	ldr	r0, [pc, #156]	; (c0d01d00 <io_usb_hid_sent+0xc4>)
c0d01c64:	6801      	ldr	r1, [r0, #0]
c0d01c66:	0a09      	lsrs	r1, r1, #8
c0d01c68:	7029      	strb	r1, [r5, #0]
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
c0d01c6a:	6800      	ldr	r0, [r0, #0]
c0d01c6c:	7068      	strb	r0, [r5, #1]
    G_io_usb_ep_buffer[2] = 0x05;
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
c0d01c6e:	4b21      	ldr	r3, [pc, #132]	; (c0d01cf4 <io_usb_hid_sent+0xb8>)
c0d01c70:	6818      	ldr	r0, [r3, #0]
c0d01c72:	0a00      	lsrs	r0, r0, #8
c0d01c74:	70e8      	strb	r0, [r5, #3]
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;
c0d01c76:	6818      	ldr	r0, [r3, #0]
c0d01c78:	7128      	strb	r0, [r5, #4]

    if (G_io_usb_hid_sequence_number == 0) {
c0d01c7a:	6819      	ldr	r1, [r3, #0]
c0d01c7c:	6820      	ldr	r0, [r4, #0]
c0d01c7e:	2900      	cmp	r1, #0
c0d01c80:	d00b      	beq.n	c0d01c9a <io_usb_hid_sent+0x5e>
      os_memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
    }
    else {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : G_io_usb_hid_remaining_length);
c0d01c82:	283b      	cmp	r0, #59	; 0x3b
c0d01c84:	d90d      	bls.n	c0d01ca2 <io_usb_hid_sent+0x66>
c0d01c86:	263b      	movs	r6, #59	; 0x3b
c0d01c88:	e00c      	b.n	c0d01ca4 <io_usb_hid_sent+0x68>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d01c8a:	481a      	ldr	r0, [pc, #104]	; (c0d01cf4 <io_usb_hid_sent+0xb8>)
c0d01c8c:	2100      	movs	r1, #0
c0d01c8e:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
  G_io_usb_hid_current_buffer = NULL;
c0d01c90:	6039      	str	r1, [r7, #0]
  // cleanup when everything has been sent (ack for the last sent usb in packet)
  else {
    io_usb_hid_init();

    // we sent the whole response
    G_io_app.apdu_state = APDU_IDLE;
c0d01c92:	4819      	ldr	r0, [pc, #100]	; (c0d01cf8 <io_usb_hid_sent+0xbc>)
c0d01c94:	7001      	strb	r1, [r0, #0]
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
  G_io_usb_hid_remaining_length = 0;
c0d01c96:	6021      	str	r1, [r4, #0]
c0d01c98:	e026      	b.n	c0d01ce8 <io_usb_hid_sent+0xac>
    G_io_usb_ep_buffer[2] = 0x05;
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : G_io_usb_hid_remaining_length);
c0d01c9a:	2839      	cmp	r0, #57	; 0x39
c0d01c9c:	d90a      	bls.n	c0d01cb4 <io_usb_hid_sent+0x78>
c0d01c9e:	2639      	movs	r6, #57	; 0x39
c0d01ca0:	e009      	b.n	c0d01cb6 <io_usb_hid_sent+0x7a>
      os_memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
    }
    else {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : G_io_usb_hid_remaining_length);
c0d01ca2:	6826      	ldr	r6, [r4, #0]
      os_memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d01ca4:	6839      	ldr	r1, [r7, #0]
c0d01ca6:	1d68      	adds	r0, r5, #5
c0d01ca8:	4632      	mov	r2, r6
c0d01caa:	f7ff fad4 	bl	c0d01256 <os_memmove>
c0d01cae:	9a00      	ldr	r2, [sp, #0]
c0d01cb0:	4910      	ldr	r1, [pc, #64]	; (c0d01cf4 <io_usb_hid_sent+0xb8>)
c0d01cb2:	e00d      	b.n	c0d01cd0 <io_usb_hid_sent+0x94>
    G_io_usb_ep_buffer[2] = 0x05;
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : G_io_usb_hid_remaining_length);
c0d01cb4:	6826      	ldr	r6, [r4, #0]
      G_io_usb_ep_buffer[5] = G_io_usb_hid_remaining_length>>8;
c0d01cb6:	6820      	ldr	r0, [r4, #0]
c0d01cb8:	0a00      	lsrs	r0, r0, #8
c0d01cba:	7168      	strb	r0, [r5, #5]
      G_io_usb_ep_buffer[6] = G_io_usb_hid_remaining_length;
c0d01cbc:	6820      	ldr	r0, [r4, #0]
c0d01cbe:	71a8      	strb	r0, [r5, #6]
      os_memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d01cc0:	6839      	ldr	r1, [r7, #0]
c0d01cc2:	1de8      	adds	r0, r5, #7
c0d01cc4:	4632      	mov	r2, r6
c0d01cc6:	461d      	mov	r5, r3
c0d01cc8:	f7ff fac5 	bl	c0d01256 <os_memmove>
c0d01ccc:	4629      	mov	r1, r5
c0d01cce:	9a00      	ldr	r2, [sp, #0]
c0d01cd0:	6820      	ldr	r0, [r4, #0]
c0d01cd2:	1b80      	subs	r0, r0, r6
c0d01cd4:	6020      	str	r0, [r4, #0]
c0d01cd6:	6838      	ldr	r0, [r7, #0]
c0d01cd8:	1980      	adds	r0, r0, r6
c0d01cda:	6038      	str	r0, [r7, #0]
      os_memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;   
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d01cdc:	6808      	ldr	r0, [r1, #0]
c0d01cde:	1c40      	adds	r0, r0, #1
c0d01ce0:	6008      	str	r0, [r1, #0]
    // send the chunk
    // always padded (USB HID transport) :)
    sndfct(G_io_usb_ep_buffer, sizeof(G_io_usb_ep_buffer));
c0d01ce2:	4806      	ldr	r0, [pc, #24]	; (c0d01cfc <io_usb_hid_sent+0xc0>)
c0d01ce4:	2140      	movs	r1, #64	; 0x40
c0d01ce6:	4790      	blx	r2
    io_usb_hid_init();

    // we sent the whole response
    G_io_app.apdu_state = APDU_IDLE;
  }
}
c0d01ce8:	b001      	add	sp, #4
c0d01cea:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01cec:	20002000 	.word	0x20002000
c0d01cf0:	20001ffc 	.word	0x20001ffc
c0d01cf4:	20001ff4 	.word	0x20001ff4
c0d01cf8:	20001f48 	.word	0x20001f48
c0d01cfc:	20001fb4 	.word	0x20001fb4
c0d01d00:	20002004 	.word	0x20002004

c0d01d04 <io_usb_hid_send>:

void io_usb_hid_send(io_send_t sndfct, unsigned short sndlength) {
c0d01d04:	b580      	push	{r7, lr}
  // perform send
  if (sndlength) {
c0d01d06:	2900      	cmp	r1, #0
c0d01d08:	d00b      	beq.n	c0d01d22 <io_usb_hid_send+0x1e>
    G_io_usb_hid_sequence_number = 0; 
c0d01d0a:	4a06      	ldr	r2, [pc, #24]	; (c0d01d24 <io_usb_hid_send+0x20>)
c0d01d0c:	2300      	movs	r3, #0
c0d01d0e:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
    G_io_usb_hid_remaining_length = sndlength;
c0d01d10:	4a05      	ldr	r2, [pc, #20]	; (c0d01d28 <io_usb_hid_send+0x24>)
c0d01d12:	6011      	str	r1, [r2, #0]

void io_usb_hid_send(io_send_t sndfct, unsigned short sndlength) {
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01d14:	4a05      	ldr	r2, [pc, #20]	; (c0d01d2c <io_usb_hid_send+0x28>)
c0d01d16:	4b06      	ldr	r3, [pc, #24]	; (c0d01d30 <io_usb_hid_send+0x2c>)
c0d01d18:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_remaining_length = sndlength;
    G_io_usb_hid_total_length = sndlength;
c0d01d1a:	4a06      	ldr	r2, [pc, #24]	; (c0d01d34 <io_usb_hid_send+0x30>)
c0d01d1c:	6011      	str	r1, [r2, #0]
    io_usb_hid_sent(sndfct);
c0d01d1e:	f7ff ff8d 	bl	c0d01c3c <io_usb_hid_sent>
  }
}
c0d01d22:	bd80      	pop	{r7, pc}
c0d01d24:	20001ff4 	.word	0x20001ff4
c0d01d28:	20001ffc 	.word	0x20001ffc
c0d01d2c:	20002000 	.word	0x20002000
c0d01d30:	20001df4 	.word	0x20001df4
c0d01d34:	20001ff8 	.word	0x20001ff8

c0d01d38 <mcu_usb_prints>:
    mcu_usb_printc(*str++);
  }
}

#else
void mcu_usb_prints(const char* str, unsigned int charcount) {
c0d01d38:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01d3a:	b081      	sub	sp, #4
c0d01d3c:	460d      	mov	r5, r1
c0d01d3e:	4604      	mov	r4, r0
c0d01d40:	20dc      	movs	r0, #220	; 0xdc
  if(USBD_Device.dev_state != USBD_STATE_CONFIGURED){
c0d01d42:	4911      	ldr	r1, [pc, #68]	; (c0d01d88 <mcu_usb_prints+0x50>)
c0d01d44:	5c08      	ldrb	r0, [r1, r0]
c0d01d46:	2803      	cmp	r0, #3
c0d01d48:	d11c      	bne.n	c0d01d84 <mcu_usb_prints+0x4c>
    return;
  }
  unsigned char buf[4];
  if(io_seproxyhal_spi_is_status_sent()){
c0d01d4a:	f000 faf5 	bl	c0d02338 <io_seph_is_status_sent>
c0d01d4e:	2800      	cmp	r0, #0
c0d01d50:	d004      	beq.n	c0d01d5c <mcu_usb_prints+0x24>
c0d01d52:	4668      	mov	r0, sp
c0d01d54:	2103      	movs	r1, #3
c0d01d56:	2200      	movs	r2, #0
      io_seproxyhal_spi_recv(buf, 3, 0);
c0d01d58:	f000 fafa 	bl	c0d02350 <io_seph_recv>
c0d01d5c:	466e      	mov	r6, sp
  }
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
  buf[1] = charcount >> 8;
  buf[2] = charcount;
c0d01d5e:	70b5      	strb	r5, [r6, #2]
c0d01d60:	2066      	movs	r0, #102	; 0x66
  }
  unsigned char buf[4];
  if(io_seproxyhal_spi_is_status_sent()){
      io_seproxyhal_spi_recv(buf, 3, 0);
  }
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
c0d01d62:	7030      	strb	r0, [r6, #0]
  buf[1] = charcount >> 8;
c0d01d64:	0a28      	lsrs	r0, r5, #8
c0d01d66:	7070      	strb	r0, [r6, #1]
c0d01d68:	2703      	movs	r7, #3
  buf[2] = charcount;
  io_seproxyhal_spi_send(buf, 3);
c0d01d6a:	4630      	mov	r0, r6
c0d01d6c:	4639      	mov	r1, r7
c0d01d6e:	f000 fad7 	bl	c0d02320 <io_seph_send>
  io_seproxyhal_spi_send(str, charcount);
c0d01d72:	b2a9      	uxth	r1, r5
c0d01d74:	4620      	mov	r0, r4
c0d01d76:	f000 fad3 	bl	c0d02320 <io_seph_send>
c0d01d7a:	2200      	movs	r2, #0
#ifndef IO_SEPROXYHAL_DEBUG
  // wait printf ack (no race kthx)
  io_seproxyhal_spi_recv(buf, 3, 0);
c0d01d7c:	4630      	mov	r0, r6
c0d01d7e:	4639      	mov	r1, r7
c0d01d80:	f000 fae6 	bl	c0d02350 <io_seph_recv>
  buf[0] = 0; // consume tag to avoid misinterpretation (due to IO_CACHE)
#endif // IO_SEPROXYHAL_DEBUG
}
c0d01d84:	b001      	add	sp, #4
c0d01d86:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01d88:	20002010 	.word	0x20002010

c0d01d8c <mcu_usb_printf>:
 * - screen_printc
 */

void screen_printf(const char* format, ...) __attribute__ ((weak, alias ("mcu_usb_printf")));

void mcu_usb_printf(const char* format, ...) {
c0d01d8c:	b083      	sub	sp, #12
c0d01d8e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01d90:	b08e      	sub	sp, #56	; 0x38
c0d01d92:	ac13      	add	r4, sp, #76	; 0x4c
c0d01d94:	c40e      	stmia	r4!, {r1, r2, r3}
    char cStrlenSet;

    //
    // Check the arguments.
    //
    if(format == 0) {
c0d01d96:	2800      	cmp	r0, #0
c0d01d98:	d100      	bne.n	c0d01d9c <mcu_usb_printf+0x10>
c0d01d9a:	e18e      	b.n	c0d020ba <mcu_usb_printf+0x32e>
c0d01d9c:	4604      	mov	r4, r0
c0d01d9e:	a813      	add	r0, sp, #76	; 0x4c
    }

    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01da0:	9008      	str	r0, [sp, #32]

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01da2:	7820      	ldrb	r0, [r4, #0]
c0d01da4:	2800      	cmp	r0, #0
c0d01da6:	d100      	bne.n	c0d01daa <mcu_usb_printf+0x1e>
c0d01da8:	e187      	b.n	c0d020ba <mcu_usb_printf+0x32e>
c0d01daa:	2600      	movs	r6, #0
c0d01dac:	43f1      	mvns	r1, r6
c0d01dae:	9100      	str	r1, [sp, #0]
c0d01db0:	9604      	str	r6, [sp, #16]
c0d01db2:	e019      	b.n	c0d01de8 <mcu_usb_printf+0x5c>
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
                        
                          // padd ulStrlen white space
                          do {
                            mcu_usb_prints(" ", 1);
c0d01db4:	9800      	ldr	r0, [sp, #0]
c0d01db6:	9907      	ldr	r1, [sp, #28]
c0d01db8:	1a46      	subs	r6, r0, r1
c0d01dba:	48c4      	ldr	r0, [pc, #784]	; (c0d020cc <mcu_usb_printf+0x340>)
c0d01dbc:	4478      	add	r0, pc
c0d01dbe:	2101      	movs	r1, #1
c0d01dc0:	f7ff ffba 	bl	c0d01d38 <mcu_usb_prints>
                          } while(ulStrlen-- > 0);
c0d01dc4:	1c76      	adds	r6, r6, #1
c0d01dc6:	d1f8      	bne.n	c0d01dba <mcu_usb_printf+0x2e>
c0d01dc8:	9906      	ldr	r1, [sp, #24]

s_pad:
                    //
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
c0d01dca:	42a9      	cmp	r1, r5
c0d01dcc:	d800      	bhi.n	c0d01dd0 <mcu_usb_printf+0x44>
c0d01dce:	e16f      	b.n	c0d020b0 <mcu_usb_printf+0x324>
                    {
                        ulCount -= ulIdx;
c0d01dd0:	1b48      	subs	r0, r1, r5
c0d01dd2:	d100      	bne.n	c0d01dd6 <mcu_usb_printf+0x4a>
c0d01dd4:	e16c      	b.n	c0d020b0 <mcu_usb_printf+0x324>
                        while(ulCount--)
c0d01dd6:	1a6d      	subs	r5, r5, r1
                        {
                            mcu_usb_prints(" ", 1);
c0d01dd8:	48be      	ldr	r0, [pc, #760]	; (c0d020d4 <mcu_usb_printf+0x348>)
c0d01dda:	4478      	add	r0, pc
c0d01ddc:	2101      	movs	r1, #1
c0d01dde:	f7ff ffab 	bl	c0d01d38 <mcu_usb_prints>
                    // Write any required padding spaces
                    //
                    if(ulCount > ulIdx)
                    {
                        ulCount -= ulIdx;
                        while(ulCount--)
c0d01de2:	1c6d      	adds	r5, r5, #1
c0d01de4:	d1f8      	bne.n	c0d01dd8 <mcu_usb_printf+0x4c>
c0d01de6:	e163      	b.n	c0d020b0 <mcu_usb_printf+0x324>
c0d01de8:	4635      	mov	r5, r6
c0d01dea:	e002      	b.n	c0d01df2 <mcu_usb_printf+0x66>
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01dec:	1960      	adds	r0, r4, r5
c0d01dee:	7840      	ldrb	r0, [r0, #1]
            ulIdx++)
c0d01df0:	1c6d      	adds	r5, r5, #1
    while(*format)
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01df2:	b2c0      	uxtb	r0, r0
c0d01df4:	2800      	cmp	r0, #0
c0d01df6:	d001      	beq.n	c0d01dfc <mcu_usb_printf+0x70>
c0d01df8:	2825      	cmp	r0, #37	; 0x25
c0d01dfa:	d1f7      	bne.n	c0d01dec <mcu_usb_printf+0x60>
        }

        //
        // Write this portion of the string.
        //
        mcu_usb_prints(format, ulIdx);
c0d01dfc:	4620      	mov	r0, r4
c0d01dfe:	4629      	mov	r1, r5
c0d01e00:	f7ff ff9a 	bl	c0d01d38 <mcu_usb_prints>
        format += ulIdx;

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01e04:	5d60      	ldrb	r0, [r4, r5]
c0d01e06:	2825      	cmp	r0, #37	; 0x25
c0d01e08:	d109      	bne.n	c0d01e1e <mcu_usb_printf+0x92>
            ulCount = 0;
            cFill = ' ';
            ulStrlen = 0;
            cStrlenSet = 0;
            ulCap = 0;
            ulBase = 10;
c0d01e0a:	1960      	adds	r0, r4, r5
c0d01e0c:	1c41      	adds	r1, r0, #1
c0d01e0e:	2300      	movs	r3, #0
c0d01e10:	2020      	movs	r0, #32
c0d01e12:	220a      	movs	r2, #10
c0d01e14:	9205      	str	r2, [sp, #20]
c0d01e16:	9307      	str	r3, [sp, #28]
c0d01e18:	461e      	mov	r6, r3
c0d01e1a:	9306      	str	r3, [sp, #24]
c0d01e1c:	e008      	b.n	c0d01e30 <mcu_usb_printf+0xa4>
c0d01e1e:	1964      	adds	r4, r4, r5
c0d01e20:	e148      	b.n	c0d020b4 <mcu_usb_printf+0x328>
c0d01e22:	2302      	movs	r3, #2
c0d01e24:	4621      	mov	r1, r4
c0d01e26:	9a08      	ldr	r2, [sp, #32]
c0d01e28:	1d14      	adds	r4, r2, #4
c0d01e2a:	9408      	str	r4, [sp, #32]
c0d01e2c:	6812      	ldr	r2, [r2, #0]
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01e2e:	9207      	str	r2, [sp, #28]
c0d01e30:	460c      	mov	r4, r1
c0d01e32:	4619      	mov	r1, r3
c0d01e34:	7822      	ldrb	r2, [r4, #0]
c0d01e36:	1c64      	adds	r4, r4, #1
c0d01e38:	2300      	movs	r3, #0
c0d01e3a:	2a2d      	cmp	r2, #45	; 0x2d
c0d01e3c:	d0f9      	beq.n	c0d01e32 <mcu_usb_printf+0xa6>
c0d01e3e:	2a47      	cmp	r2, #71	; 0x47
c0d01e40:	dc18      	bgt.n	c0d01e74 <mcu_usb_printf+0xe8>
c0d01e42:	2a2f      	cmp	r2, #47	; 0x2f
c0d01e44:	dd23      	ble.n	c0d01e8e <mcu_usb_printf+0x102>
c0d01e46:	4613      	mov	r3, r2
c0d01e48:	3b30      	subs	r3, #48	; 0x30
c0d01e4a:	2b0a      	cmp	r3, #10
c0d01e4c:	d300      	bcc.n	c0d01e50 <mcu_usb_printf+0xc4>
c0d01e4e:	e088      	b.n	c0d01f62 <mcu_usb_printf+0x1d6>
                {
                    //
                    // If this is a zero, and it is the first digit, then the
                    // fill character is a zero instead of a space.
                    //
                    if((format[-1] == '0') && (ulCount == 0))
c0d01e50:	2a30      	cmp	r2, #48	; 0x30
c0d01e52:	4603      	mov	r3, r0
c0d01e54:	d100      	bne.n	c0d01e58 <mcu_usb_printf+0xcc>
c0d01e56:	4613      	mov	r3, r2
c0d01e58:	9f06      	ldr	r7, [sp, #24]
c0d01e5a:	2f00      	cmp	r7, #0
c0d01e5c:	d000      	beq.n	c0d01e60 <mcu_usb_printf+0xd4>
c0d01e5e:	4603      	mov	r3, r0
c0d01e60:	270a      	movs	r7, #10
                    }

                    //
                    // Update the digit count.
                    //
                    ulCount *= 10;
c0d01e62:	9806      	ldr	r0, [sp, #24]
c0d01e64:	4347      	muls	r7, r0
                    ulCount += format[-1] - '0';
c0d01e66:	18b8      	adds	r0, r7, r2
c0d01e68:	3830      	subs	r0, #48	; 0x30
c0d01e6a:	9006      	str	r0, [sp, #24]
c0d01e6c:	4618      	mov	r0, r3
c0d01e6e:	460b      	mov	r3, r1
c0d01e70:	4621      	mov	r1, r4
c0d01e72:	e7dd      	b.n	c0d01e30 <mcu_usb_printf+0xa4>
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01e74:	2a67      	cmp	r2, #103	; 0x67
c0d01e76:	dd04      	ble.n	c0d01e82 <mcu_usb_printf+0xf6>
c0d01e78:	2a72      	cmp	r2, #114	; 0x72
c0d01e7a:	dd1b      	ble.n	c0d01eb4 <mcu_usb_printf+0x128>
c0d01e7c:	2a73      	cmp	r2, #115	; 0x73
c0d01e7e:	d130      	bne.n	c0d01ee2 <mcu_usb_printf+0x156>
c0d01e80:	e01d      	b.n	c0d01ebe <mcu_usb_printf+0x132>
c0d01e82:	2a62      	cmp	r2, #98	; 0x62
c0d01e84:	dc32      	bgt.n	c0d01eec <mcu_usb_printf+0x160>
c0d01e86:	2a48      	cmp	r2, #72	; 0x48
c0d01e88:	d140      	bne.n	c0d01f0c <mcu_usb_printf+0x180>
c0d01e8a:	2601      	movs	r6, #1
c0d01e8c:	e015      	b.n	c0d01eba <mcu_usb_printf+0x12e>
c0d01e8e:	2a25      	cmp	r2, #37	; 0x25
c0d01e90:	d04c      	beq.n	c0d01f2c <mcu_usb_printf+0x1a0>
c0d01e92:	2a2a      	cmp	r2, #42	; 0x2a
c0d01e94:	d021      	beq.n	c0d01eda <mcu_usb_printf+0x14e>
c0d01e96:	2a2e      	cmp	r2, #46	; 0x2e
c0d01e98:	d163      	bne.n	c0d01f62 <mcu_usb_printf+0x1d6>
                // special %.*H or %.*h format to print a given length of hex digits (case: H UPPER, h lower)
                //
                case '.':
                {
                  // ensure next char is '*' and next one is 's'
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d01e9a:	7821      	ldrb	r1, [r4, #0]
c0d01e9c:	292a      	cmp	r1, #42	; 0x2a
c0d01e9e:	d160      	bne.n	c0d01f62 <mcu_usb_printf+0x1d6>
c0d01ea0:	7862      	ldrb	r2, [r4, #1]
c0d01ea2:	1c61      	adds	r1, r4, #1
c0d01ea4:	2301      	movs	r3, #1
c0d01ea6:	2a48      	cmp	r2, #72	; 0x48
c0d01ea8:	d0bd      	beq.n	c0d01e26 <mcu_usb_printf+0x9a>
c0d01eaa:	2a68      	cmp	r2, #104	; 0x68
c0d01eac:	d0bb      	beq.n	c0d01e26 <mcu_usb_printf+0x9a>
c0d01eae:	2a73      	cmp	r2, #115	; 0x73
c0d01eb0:	d0b9      	beq.n	c0d01e26 <mcu_usb_printf+0x9a>
c0d01eb2:	e056      	b.n	c0d01f62 <mcu_usb_printf+0x1d6>
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01eb4:	2a68      	cmp	r2, #104	; 0x68
c0d01eb6:	d12d      	bne.n	c0d01f14 <mcu_usb_printf+0x188>
c0d01eb8:	2600      	movs	r6, #0
c0d01eba:	2210      	movs	r2, #16
c0d01ebc:	9205      	str	r2, [sp, #20]
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01ebe:	9b08      	ldr	r3, [sp, #32]
c0d01ec0:	1d1a      	adds	r2, r3, #4
c0d01ec2:	9208      	str	r2, [sp, #32]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01ec4:	b2ca      	uxtb	r2, r1
                case_s:
                {
                    //
                    // Get the string pointer from the varargs.
                    //
                    pcStr = va_arg(vaArgP, char *);
c0d01ec6:	681f      	ldr	r7, [r3, #0]

                    //
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
c0d01ec8:	2a01      	cmp	r2, #1
c0d01eca:	d044      	beq.n	c0d01f56 <mcu_usb_printf+0x1ca>
c0d01ecc:	2a02      	cmp	r2, #2
c0d01ece:	d044      	beq.n	c0d01f5a <mcu_usb_printf+0x1ce>
c0d01ed0:	2a03      	cmp	r2, #3
c0d01ed2:	460b      	mov	r3, r1
c0d01ed4:	4621      	mov	r1, r4
c0d01ed6:	d0ab      	beq.n	c0d01e30 <mcu_usb_printf+0xa4>
c0d01ed8:	e047      	b.n	c0d01f6a <mcu_usb_printf+0x1de>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01eda:	7821      	ldrb	r1, [r4, #0]
c0d01edc:	2973      	cmp	r1, #115	; 0x73
c0d01ede:	d0a0      	beq.n	c0d01e22 <mcu_usb_printf+0x96>
c0d01ee0:	e03f      	b.n	c0d01f62 <mcu_usb_printf+0x1d6>
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01ee2:	2a75      	cmp	r2, #117	; 0x75
c0d01ee4:	d025      	beq.n	c0d01f32 <mcu_usb_printf+0x1a6>
c0d01ee6:	2a78      	cmp	r2, #120	; 0x78
c0d01ee8:	d016      	beq.n	c0d01f18 <mcu_usb_printf+0x18c>
c0d01eea:	e03a      	b.n	c0d01f62 <mcu_usb_printf+0x1d6>
c0d01eec:	2a63      	cmp	r2, #99	; 0x63
c0d01eee:	d02a      	beq.n	c0d01f46 <mcu_usb_printf+0x1ba>
c0d01ef0:	2a64      	cmp	r2, #100	; 0x64
c0d01ef2:	d136      	bne.n	c0d01f62 <mcu_usb_printf+0x1d6>
c0d01ef4:	9003      	str	r0, [sp, #12]
c0d01ef6:	9605      	str	r6, [sp, #20]
                case 'd':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01ef8:	9808      	ldr	r0, [sp, #32]
c0d01efa:	1d01      	adds	r1, r0, #4
c0d01efc:	9108      	str	r1, [sp, #32]
c0d01efe:	6800      	ldr	r0, [r0, #0]
c0d01f00:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f02:	260a      	movs	r6, #10

                    //
                    // If the value is negative, make it positive and indicate
                    // that a minus sign is needed.
                    //
                    if((long)ulValue < 0)
c0d01f04:	2800      	cmp	r0, #0
c0d01f06:	db5c      	blt.n	c0d01fc2 <mcu_usb_printf+0x236>
c0d01f08:	2100      	movs	r1, #0
c0d01f0a:	e05d      	b.n	c0d01fc8 <mcu_usb_printf+0x23c>
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d01f0c:	2a58      	cmp	r2, #88	; 0x58
c0d01f0e:	d128      	bne.n	c0d01f62 <mcu_usb_printf+0x1d6>
c0d01f10:	2601      	movs	r6, #1
c0d01f12:	e001      	b.n	c0d01f18 <mcu_usb_printf+0x18c>
c0d01f14:	2a70      	cmp	r2, #112	; 0x70
c0d01f16:	d124      	bne.n	c0d01f62 <mcu_usb_printf+0x1d6>
c0d01f18:	9003      	str	r0, [sp, #12]
c0d01f1a:	9605      	str	r6, [sp, #20]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01f1c:	9808      	ldr	r0, [sp, #32]
c0d01f1e:	1d01      	adds	r1, r0, #4
c0d01f20:	9108      	str	r1, [sp, #32]
c0d01f22:	6800      	ldr	r0, [r0, #0]
c0d01f24:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f26:	2100      	movs	r1, #0
c0d01f28:	2610      	movs	r6, #16
c0d01f2a:	e04d      	b.n	c0d01fc8 <mcu_usb_printf+0x23c>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    mcu_usb_prints(format - 1, 1);
c0d01f2c:	9800      	ldr	r0, [sp, #0]
c0d01f2e:	1820      	adds	r0, r4, r0
c0d01f30:	e00f      	b.n	c0d01f52 <mcu_usb_printf+0x1c6>
c0d01f32:	9003      	str	r0, [sp, #12]
c0d01f34:	9605      	str	r6, [sp, #20]
                case 'u':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01f36:	9808      	ldr	r0, [sp, #32]
c0d01f38:	1d01      	adds	r1, r0, #4
c0d01f3a:	9108      	str	r1, [sp, #32]
c0d01f3c:	6800      	ldr	r0, [r0, #0]
c0d01f3e:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f40:	2100      	movs	r1, #0
c0d01f42:	260a      	movs	r6, #10
c0d01f44:	e040      	b.n	c0d01fc8 <mcu_usb_printf+0x23c>
                case 'c':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01f46:	9808      	ldr	r0, [sp, #32]
c0d01f48:	1d01      	adds	r1, r0, #4
c0d01f4a:	9108      	str	r1, [sp, #32]
c0d01f4c:	6800      	ldr	r0, [r0, #0]
c0d01f4e:	900d      	str	r0, [sp, #52]	; 0x34
c0d01f50:	a80d      	add	r0, sp, #52	; 0x34
c0d01f52:	2101      	movs	r1, #1
c0d01f54:	e0aa      	b.n	c0d020ac <mcu_usb_printf+0x320>
c0d01f56:	9907      	ldr	r1, [sp, #28]
c0d01f58:	e00d      	b.n	c0d01f76 <mcu_usb_printf+0x1ea>
                        break;
                        
                      // printout prepad
                      case 2:
                        // if string is empty, then, ' ' padding
                        if (pcStr[0] == '\0') {
c0d01f5a:	7838      	ldrb	r0, [r7, #0]
c0d01f5c:	2800      	cmp	r0, #0
c0d01f5e:	d100      	bne.n	c0d01f62 <mcu_usb_printf+0x1d6>
c0d01f60:	e728      	b.n	c0d01db4 <mcu_usb_printf+0x28>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    mcu_usb_prints("ERROR", 5);
c0d01f62:	4858      	ldr	r0, [pc, #352]	; (c0d020c4 <mcu_usb_printf+0x338>)
c0d01f64:	4478      	add	r0, pc
c0d01f66:	2105      	movs	r1, #5
c0d01f68:	e0a0      	b.n	c0d020ac <mcu_usb_printf+0x320>
c0d01f6a:	2100      	movs	r1, #0
                    // Determine the length of the string. (if not specified using .*)
                    //
                    switch(cStrlenSet) {
                      // compute length with strlen
                      case 0:
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d01f6c:	5c7a      	ldrb	r2, [r7, r1]
c0d01f6e:	1c49      	adds	r1, r1, #1
c0d01f70:	2a00      	cmp	r2, #0
c0d01f72:	d1fb      	bne.n	c0d01f6c <mcu_usb_printf+0x1e0>
                    }

                    //
                    // Write the string.
                    //
                    switch(ulBase) {
c0d01f74:	1e49      	subs	r1, r1, #1
c0d01f76:	9805      	ldr	r0, [sp, #20]
c0d01f78:	2810      	cmp	r0, #16
c0d01f7a:	d11d      	bne.n	c0d01fb8 <mcu_usb_printf+0x22c>
                      default:
                        mcu_usb_prints(pcStr, ulIdx);
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01f7c:	2900      	cmp	r1, #0
c0d01f7e:	9605      	str	r6, [sp, #20]
c0d01f80:	d100      	bne.n	c0d01f84 <mcu_usb_printf+0x1f8>
c0d01f82:	e095      	b.n	c0d020b0 <mcu_usb_printf+0x324>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01f84:	7838      	ldrb	r0, [r7, #0]
c0d01f86:	250f      	movs	r5, #15
                          nibble2 = pcStr[ulCount]&0xF;
c0d01f88:	4005      	ands	r5, r0
                        mcu_usb_prints(pcStr, ulIdx);
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d01f8a:	0900      	lsrs	r0, r0, #4
                          nibble2 = pcStr[ulCount]&0xF;
                          switch(ulCap) {
c0d01f8c:	2e01      	cmp	r6, #1
c0d01f8e:	d004      	beq.n	c0d01f9a <mcu_usb_printf+0x20e>
c0d01f90:	2e00      	cmp	r6, #0
c0d01f92:	d10d      	bne.n	c0d01fb0 <mcu_usb_printf+0x224>
                            case 0:
                              mcu_usb_printc(g_pcHex[nibble1]);
c0d01f94:	4e4c      	ldr	r6, [pc, #304]	; (c0d020c8 <mcu_usb_printf+0x33c>)
c0d01f96:	447e      	add	r6, pc
c0d01f98:	e001      	b.n	c0d01f9e <mcu_usb_printf+0x212>
                              mcu_usb_printc(g_pcHex[nibble2]);
                              break;
                            case 1:
                              mcu_usb_printc(g_pcHex_cap[nibble1]);
c0d01f9a:	4e4d      	ldr	r6, [pc, #308]	; (c0d020d0 <mcu_usb_printf+0x344>)
c0d01f9c:	447e      	add	r6, pc
c0d01f9e:	5c30      	ldrb	r0, [r6, r0]
c0d01fa0:	9107      	str	r1, [sp, #28]
c0d01fa2:	f7ff fd87 	bl	c0d01ab4 <mcu_usb_printc>
c0d01fa6:	5d70      	ldrb	r0, [r6, r5]
c0d01fa8:	9e05      	ldr	r6, [sp, #20]
c0d01faa:	f7ff fd83 	bl	c0d01ab4 <mcu_usb_printc>
c0d01fae:	9907      	ldr	r1, [sp, #28]
                      default:
                        mcu_usb_prints(pcStr, ulIdx);
                        break;
                      case 16: {
                        unsigned char nibble1, nibble2;
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d01fb0:	1c7f      	adds	r7, r7, #1
c0d01fb2:	1e49      	subs	r1, r1, #1
c0d01fb4:	d1e6      	bne.n	c0d01f84 <mcu_usb_printf+0x1f8>
c0d01fb6:	e07b      	b.n	c0d020b0 <mcu_usb_printf+0x324>
                    //
                    // Write the string.
                    //
                    switch(ulBase) {
                      default:
                        mcu_usb_prints(pcStr, ulIdx);
c0d01fb8:	4638      	mov	r0, r7
c0d01fba:	460d      	mov	r5, r1
c0d01fbc:	f7ff febc 	bl	c0d01d38 <mcu_usb_prints>
c0d01fc0:	e702      	b.n	c0d01dc8 <mcu_usb_printf+0x3c>
                    if((long)ulValue < 0)
                    {
                        //
                        // Make the value positive.
                        //
                        ulValue = -(long)ulValue;
c0d01fc2:	4240      	negs	r0, r0
c0d01fc4:	900d      	str	r0, [sp, #52]	; 0x34
c0d01fc6:	2101      	movs	r1, #1
c0d01fc8:	9102      	str	r1, [sp, #8]
c0d01fca:	9007      	str	r0, [sp, #28]
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01fcc:	4286      	cmp	r6, r0
c0d01fce:	d901      	bls.n	c0d01fd4 <mcu_usb_printf+0x248>
c0d01fd0:	2701      	movs	r7, #1
c0d01fd2:	e012      	b.n	c0d01ffa <mcu_usb_printf+0x26e>
c0d01fd4:	2501      	movs	r5, #1
c0d01fd6:	4630      	mov	r0, r6
c0d01fd8:	4607      	mov	r7, r0
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
c0d01fda:	4631      	mov	r1, r6
c0d01fdc:	f002 f8aa 	bl	c0d04134 <__aeabi_uidiv>
                    //
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
c0d01fe0:	42a8      	cmp	r0, r5
c0d01fe2:	d109      	bne.n	c0d01ff8 <mcu_usb_printf+0x26c>
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01fe4:	4630      	mov	r0, r6
c0d01fe6:	4378      	muls	r0, r7
                         (((ulIdx * ulBase) / ulBase) == ulIdx));
                        ulIdx *= ulBase, ulCount--)
c0d01fe8:	9906      	ldr	r1, [sp, #24]
c0d01fea:	1e49      	subs	r1, r1, #1
                    // Determine the number of digits in the string version of
                    // the value.
                    //
convert:
                    for(ulIdx = 1;
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01fec:	9106      	str	r1, [sp, #24]
c0d01fee:	9907      	ldr	r1, [sp, #28]
c0d01ff0:	4288      	cmp	r0, r1
c0d01ff2:	463d      	mov	r5, r7
c0d01ff4:	d9f0      	bls.n	c0d01fd8 <mcu_usb_printf+0x24c>
c0d01ff6:	e000      	b.n	c0d01ffa <mcu_usb_printf+0x26e>
c0d01ff8:	462f      	mov	r7, r5
c0d01ffa:	9601      	str	r6, [sp, #4]
c0d01ffc:	9b02      	ldr	r3, [sp, #8]

                    //
                    // If the value is negative, reduce the count of padding
                    // characters needed.
                    //
                    if(ulNeg)
c0d01ffe:	2b00      	cmp	r3, #0
c0d02000:	d101      	bne.n	c0d02006 <mcu_usb_printf+0x27a>
c0d02002:	9906      	ldr	r1, [sp, #24]
c0d02004:	e001      	b.n	c0d0200a <mcu_usb_printf+0x27e>
c0d02006:	9806      	ldr	r0, [sp, #24]
c0d02008:	1e41      	subs	r1, r0, #1
c0d0200a:	2000      	movs	r0, #0
c0d0200c:	2b00      	cmp	r3, #0
c0d0200e:	d101      	bne.n	c0d02014 <mcu_usb_printf+0x288>
c0d02010:	461e      	mov	r6, r3
c0d02012:	e000      	b.n	c0d02016 <mcu_usb_printf+0x28a>
c0d02014:	43c6      	mvns	r6, r0

                    //
                    // If the value is negative and the value is padded with
                    // zeros, then place the minus sign before the padding.
                    //
                    if(ulNeg && (cFill == '0'))
c0d02016:	2b00      	cmp	r3, #0
c0d02018:	d009      	beq.n	c0d0202e <mcu_usb_printf+0x2a2>
c0d0201a:	9a03      	ldr	r2, [sp, #12]
c0d0201c:	b2d2      	uxtb	r2, r2
c0d0201e:	2a30      	cmp	r2, #48	; 0x30
c0d02020:	d106      	bne.n	c0d02030 <mcu_usb_printf+0x2a4>
c0d02022:	aa09      	add	r2, sp, #36	; 0x24
c0d02024:	232d      	movs	r3, #45	; 0x2d
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d02026:	7013      	strb	r3, [r2, #0]
c0d02028:	2501      	movs	r5, #1
c0d0202a:	4603      	mov	r3, r0
c0d0202c:	e001      	b.n	c0d02032 <mcu_usb_printf+0x2a6>
c0d0202e:	4603      	mov	r3, r0
c0d02030:	4605      	mov	r5, r0

                    //
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
c0d02032:	1e88      	subs	r0, r1, #2
c0d02034:	280d      	cmp	r0, #13
c0d02036:	d812      	bhi.n	c0d0205e <mcu_usb_printf+0x2d2>
c0d02038:	a809      	add	r0, sp, #36	; 0x24
                    {
                        for(ulCount--; ulCount; ulCount--)
                        {
                            pcBuf[ulPos++] = cFill;
c0d0203a:	1940      	adds	r0, r0, r5
c0d0203c:	1e49      	subs	r1, r1, #1
c0d0203e:	9a03      	ldr	r2, [sp, #12]
c0d02040:	b2d2      	uxtb	r2, r2
c0d02042:	9603      	str	r6, [sp, #12]
c0d02044:	461e      	mov	r6, r3
c0d02046:	f002 f90b 	bl	c0d04260 <__aeabi_memset>
c0d0204a:	4633      	mov	r3, r6
c0d0204c:	2001      	movs	r0, #1
c0d0204e:	9906      	ldr	r1, [sp, #24]
c0d02050:	1a40      	subs	r0, r0, r1
c0d02052:	9903      	ldr	r1, [sp, #12]
c0d02054:	1a40      	subs	r0, r0, r1
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
                    {
                        for(ulCount--; ulCount; ulCount--)
c0d02056:	1c40      	adds	r0, r0, #1
                        {
                            pcBuf[ulPos++] = cFill;
c0d02058:	1c6d      	adds	r5, r5, #1
                    // Provide additional padding at the beginning of the
                    // string conversion if needed.
                    //
                    if((ulCount > 1) && (ulCount < 16))
                    {
                        for(ulCount--; ulCount; ulCount--)
c0d0205a:	2800      	cmp	r0, #0
c0d0205c:	d1fb      	bne.n	c0d02056 <mcu_usb_printf+0x2ca>

                    //
                    // If the value is negative, then place the minus sign
                    // before the number.
                    //
                    if(ulNeg)
c0d0205e:	2b00      	cmp	r3, #0
c0d02060:	d003      	beq.n	c0d0206a <mcu_usb_printf+0x2de>
c0d02062:	a809      	add	r0, sp, #36	; 0x24
c0d02064:	212d      	movs	r1, #45	; 0x2d
                    {
                        //
                        // Place the minus sign in the output buffer.
                        //
                        pcBuf[ulPos++] = '-';
c0d02066:	5541      	strb	r1, [r0, r5]
c0d02068:	1c6d      	adds	r5, r5, #1
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d0206a:	2f00      	cmp	r7, #0
c0d0206c:	d01c      	beq.n	c0d020a8 <mcu_usb_printf+0x31c>
c0d0206e:	9805      	ldr	r0, [sp, #20]
c0d02070:	2800      	cmp	r0, #0
c0d02072:	d002      	beq.n	c0d0207a <mcu_usb_printf+0x2ee>
c0d02074:	4819      	ldr	r0, [pc, #100]	; (c0d020dc <mcu_usb_printf+0x350>)
c0d02076:	4478      	add	r0, pc
c0d02078:	e001      	b.n	c0d0207e <mcu_usb_printf+0x2f2>
c0d0207a:	4817      	ldr	r0, [pc, #92]	; (c0d020d8 <mcu_usb_printf+0x34c>)
c0d0207c:	4478      	add	r0, pc
c0d0207e:	9006      	str	r0, [sp, #24]
c0d02080:	9e01      	ldr	r6, [sp, #4]
c0d02082:	9807      	ldr	r0, [sp, #28]
c0d02084:	4639      	mov	r1, r7
c0d02086:	f002 f855 	bl	c0d04134 <__aeabi_uidiv>
c0d0208a:	4631      	mov	r1, r6
c0d0208c:	f002 f8d8 	bl	c0d04240 <__aeabi_uidivmod>
c0d02090:	9806      	ldr	r0, [sp, #24]
c0d02092:	5c40      	ldrb	r0, [r0, r1]
c0d02094:	a909      	add	r1, sp, #36	; 0x24
                    {
                        if (!ulCap) {
                          pcBuf[ulPos++] = g_pcHex[(ulValue / ulIdx) % ulBase];
c0d02096:	5548      	strb	r0, [r1, r5]
                    }

                    //
                    // Convert the value into a string.
                    //
                    for(; ulIdx; ulIdx /= ulBase)
c0d02098:	4638      	mov	r0, r7
c0d0209a:	4631      	mov	r1, r6
c0d0209c:	f002 f84a 	bl	c0d04134 <__aeabi_uidiv>
c0d020a0:	1c6d      	adds	r5, r5, #1
c0d020a2:	42be      	cmp	r6, r7
c0d020a4:	4607      	mov	r7, r0
c0d020a6:	d9ec      	bls.n	c0d02082 <mcu_usb_printf+0x2f6>
c0d020a8:	a809      	add	r0, sp, #36	; 0x24
                    }

                    //
                    // Write the string.
                    //
                    mcu_usb_prints(pcBuf, ulPos);
c0d020aa:	4629      	mov	r1, r5
c0d020ac:	f7ff fe44 	bl	c0d01d38 <mcu_usb_prints>
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d020b0:	7820      	ldrb	r0, [r4, #0]
c0d020b2:	9e04      	ldr	r6, [sp, #16]
c0d020b4:	2800      	cmp	r0, #0
c0d020b6:	d000      	beq.n	c0d020ba <mcu_usb_printf+0x32e>
c0d020b8:	e696      	b.n	c0d01de8 <mcu_usb_printf+0x5c>

    //
    // End the varargs processing.
    //
    va_end(vaArgP);
}
c0d020ba:	b00e      	add	sp, #56	; 0x38
c0d020bc:	bcf0      	pop	{r4, r5, r6, r7}
c0d020be:	bc01      	pop	{r0}
c0d020c0:	b003      	add	sp, #12
c0d020c2:	4700      	bx	r0
c0d020c4:	00002937 	.word	0x00002937
c0d020c8:	0000290b 	.word	0x0000290b
c0d020cc:	00002add 	.word	0x00002add
c0d020d0:	00002915 	.word	0x00002915
c0d020d4:	00002abf 	.word	0x00002abf
c0d020d8:	00002825 	.word	0x00002825
c0d020dc:	0000283b 	.word	0x0000283b

c0d020e0 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d020e0:	b580      	push	{r7, lr}
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d020e2:	4904      	ldr	r1, [pc, #16]	; (c0d020f4 <pic+0x14>)
c0d020e4:	4288      	cmp	r0, r1
c0d020e6:	d304      	bcc.n	c0d020f2 <pic+0x12>
c0d020e8:	4903      	ldr	r1, [pc, #12]	; (c0d020f8 <pic+0x18>)
c0d020ea:	4288      	cmp	r0, r1
c0d020ec:	d201      	bcs.n	c0d020f2 <pic+0x12>
		link_address = pic_internal(link_address);
c0d020ee:	f000 f805 	bl	c0d020fc <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d020f2:	bd80      	pop	{r7, pc}
c0d020f4:	c0d00000 	.word	0xc0d00000
c0d020f8:	c0d04e00 	.word	0xc0d04e00

c0d020fc <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d020fc:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d020fe:	4902      	ldr	r1, [pc, #8]	; (c0d02108 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d02100:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d02102:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d02104:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d02106:	4770      	bx	lr
c0d02108:	c0d020fd 	.word	0xc0d020fd

c0d0210c <SVC_Call>:

// avoid a separate asm file, but avoid any intrusion from the compiler
__attribute__((naked)) void SVC_Call(unsigned int syscall_id, volatile unsigned int * parameters);
__attribute__((naked)) void SVC_Call(__attribute__((unused)) unsigned int syscall_id, __attribute__((unused)) volatile unsigned int * parameters) {
  // delegate svc, ensure no optimization by gcc with naked and r0, r1 marked as clobbered
  asm volatile("svc #1":::"r0","r1");
c0d0210c:	df01      	svc	1
  asm volatile("bx  lr");
c0d0210e:	4770      	bx	lr

c0d02110 <check_api_level>:
}
void check_api_level ( unsigned int apiLevel ) 
{
c0d02110:	b580      	push	{r7, lr}
c0d02112:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
  parameters[0] = (unsigned int)apiLevel;
c0d02114:	9001      	str	r0, [sp, #4]
c0d02116:	4803      	ldr	r0, [pc, #12]	; (c0d02124 <check_api_level+0x14>)
c0d02118:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
c0d0211a:	f7ff fff7 	bl	c0d0210c <SVC_Call>
}
c0d0211e:	b004      	add	sp, #16
c0d02120:	bd80      	pop	{r7, pc}
c0d02122:	46c0      	nop			; (mov r8, r8)
c0d02124:	60000137 	.word	0x60000137

c0d02128 <halt>:

void halt ( void ) 
{
c0d02128:	b580      	push	{r7, lr}
c0d0212a:	b082      	sub	sp, #8
c0d0212c:	4802      	ldr	r0, [pc, #8]	; (c0d02138 <halt+0x10>)
c0d0212e:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
  SVC_Call(SYSCALL_halt_ID_IN, parameters);
c0d02130:	f7ff ffec 	bl	c0d0210c <SVC_Call>
}
c0d02134:	b002      	add	sp, #8
c0d02136:	bd80      	pop	{r7, pc}
c0d02138:	6000023c 	.word	0x6000023c

c0d0213c <cx_rng>:
  SVC_Call(SYSCALL_cx_rng_u8_ID_IN, parameters);
  return (unsigned char)(((volatile unsigned int*)parameters)[1]);
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d0213c:	b580      	push	{r7, lr}
c0d0213e:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
c0d02140:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)len;
c0d02142:	9101      	str	r1, [sp, #4]
c0d02144:	4803      	ldr	r0, [pc, #12]	; (c0d02154 <cx_rng+0x18>)
c0d02146:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_rng_ID_IN, parameters);
c0d02148:	f7ff ffe0 	bl	c0d0210c <SVC_Call>
  return (unsigned char *)(((volatile unsigned int*)parameters)[1]);
c0d0214c:	9801      	ldr	r0, [sp, #4]
c0d0214e:	b004      	add	sp, #16
c0d02150:	bd80      	pop	{r7, pc}
c0d02152:	46c0      	nop			; (mov r8, r8)
c0d02154:	6000052c 	.word	0x6000052c

c0d02158 <cx_hash>:
}

int cx_hash ( cx_hash_t * hash, int mode, const unsigned char * in, unsigned int len, unsigned char * out, unsigned int out_len ) 
{
c0d02158:	b580      	push	{r7, lr}
c0d0215a:	b088      	sub	sp, #32
  volatile unsigned int parameters [2+6];
  parameters[0] = (unsigned int)hash;
c0d0215c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)mode;
c0d0215e:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)in;
c0d02160:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d02162:	9303      	str	r3, [sp, #12]
c0d02164:	980a      	ldr	r0, [sp, #40]	; 0x28
  parameters[4] = (unsigned int)out;
c0d02166:	9004      	str	r0, [sp, #16]
c0d02168:	980b      	ldr	r0, [sp, #44]	; 0x2c
  parameters[5] = (unsigned int)out_len;
c0d0216a:	9005      	str	r0, [sp, #20]
c0d0216c:	4803      	ldr	r0, [pc, #12]	; (c0d0217c <cx_hash+0x24>)
c0d0216e:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_hash_ID_IN, parameters);
c0d02170:	f7ff ffcc 	bl	c0d0210c <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d02174:	9801      	ldr	r0, [sp, #4]
c0d02176:	b008      	add	sp, #32
c0d02178:	bd80      	pop	{r7, pc}
c0d0217a:	46c0      	nop			; (mov r8, r8)
c0d0217c:	6000073b 	.word	0x6000073b

c0d02180 <cx_ripemd160_init>:
}

int cx_ripemd160_init ( cx_ripemd160_t * hash ) 
{
c0d02180:	b580      	push	{r7, lr}
c0d02182:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)hash;
c0d02184:	9001      	str	r0, [sp, #4]
c0d02186:	4803      	ldr	r0, [pc, #12]	; (c0d02194 <cx_ripemd160_init+0x14>)
c0d02188:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_cx_ripemd160_init_ID_IN, parameters);
c0d0218a:	f7ff ffbf 	bl	c0d0210c <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d0218e:	9802      	ldr	r0, [sp, #8]
c0d02190:	b004      	add	sp, #16
c0d02192:	bd80      	pop	{r7, pc}
c0d02194:	6000087f 	.word	0x6000087f

c0d02198 <cx_sha3_init>:
  SVC_Call(SYSCALL_cx_hash_sha512_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_sha3_init ( cx_sha3_t * hash, unsigned int size ) 
{
c0d02198:	b580      	push	{r7, lr}
c0d0219a:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)hash;
c0d0219c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)size;
c0d0219e:	9101      	str	r1, [sp, #4]
c0d021a0:	4803      	ldr	r0, [pc, #12]	; (c0d021b0 <cx_sha3_init+0x18>)
c0d021a2:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_sha3_init_ID_IN, parameters);
c0d021a4:	f7ff ffb2 	bl	c0d0210c <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d021a8:	9801      	ldr	r0, [sp, #4]
c0d021aa:	b004      	add	sp, #16
c0d021ac:	bd80      	pop	{r7, pc}
c0d021ae:	46c0      	nop			; (mov r8, r8)
c0d021b0:	60000fd1 	.word	0x60000fd1

c0d021b4 <cx_ecfp_init_private_key>:
  SVC_Call(SYSCALL_cx_ecfp_init_public_key_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_ecfp_init_private_key ( cx_curve_t curve, const unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * pvkey ) 
{
c0d021b4:	b580      	push	{r7, lr}
c0d021b6:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+4];
  parameters[0] = (unsigned int)curve;
c0d021b8:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)rawkey;
c0d021ba:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)key_len;
c0d021bc:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)pvkey;
c0d021be:	9303      	str	r3, [sp, #12]
c0d021c0:	4803      	ldr	r0, [pc, #12]	; (c0d021d0 <cx_ecfp_init_private_key+0x1c>)
c0d021c2:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_ecfp_init_private_key_ID_IN, parameters);
c0d021c4:	f7ff ffa2 	bl	c0d0210c <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d021c8:	9801      	ldr	r0, [sp, #4]
c0d021ca:	b006      	add	sp, #24
c0d021cc:	bd80      	pop	{r7, pc}
c0d021ce:	46c0      	nop			; (mov r8, r8)
c0d021d0:	60002eea 	.word	0x60002eea

c0d021d4 <cx_ecfp_generate_pair2>:
  SVC_Call(SYSCALL_cx_ecfp_generate_pair_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_ecfp_generate_pair2 ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate, cx_md_t hashID ) 
{
c0d021d4:	b580      	push	{r7, lr}
c0d021d6:	b088      	sub	sp, #32
  volatile unsigned int parameters [2+5];
  parameters[0] = (unsigned int)curve;
c0d021d8:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)pubkey;
c0d021da:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)privkey;
c0d021dc:	9203      	str	r2, [sp, #12]
  parameters[3] = (unsigned int)keepprivate;
c0d021de:	9304      	str	r3, [sp, #16]
c0d021e0:	980a      	ldr	r0, [sp, #40]	; 0x28
  parameters[4] = (unsigned int)hashID;
c0d021e2:	9005      	str	r0, [sp, #20]
c0d021e4:	4803      	ldr	r0, [pc, #12]	; (c0d021f4 <cx_ecfp_generate_pair2+0x20>)
c0d021e6:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_cx_ecfp_generate_pair2_ID_IN, parameters);
c0d021e8:	f7ff ff90 	bl	c0d0210c <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d021ec:	9802      	ldr	r0, [sp, #8]
c0d021ee:	b008      	add	sp, #32
c0d021f0:	bd80      	pop	{r7, pc}
c0d021f2:	46c0      	nop			; (mov r8, r8)
c0d021f4:	6000301f 	.word	0x6000301f

c0d021f8 <cx_eddsa_sign>:
  parameters[6] = (unsigned int)h_len;
  SVC_Call(SYSCALL_cx_eddsa_get_public_key_ID_IN, parameters);
}

int cx_eddsa_sign ( const cx_ecfp_private_key_t * pvkey, int mode, cx_md_t hashID, const unsigned char * hash, unsigned int hash_len, const unsigned char * ctx, unsigned int ctx_len, unsigned char * sig, unsigned int sig_len, unsigned int * info ) 
{
c0d021f8:	b580      	push	{r7, lr}
c0d021fa:	b08c      	sub	sp, #48	; 0x30
  volatile unsigned int parameters [2+10];
  parameters[0] = (unsigned int)pvkey;
c0d021fc:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)mode;
c0d021fe:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)hashID;
c0d02200:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)hash;
c0d02202:	9303      	str	r3, [sp, #12]
c0d02204:	980e      	ldr	r0, [sp, #56]	; 0x38
  parameters[4] = (unsigned int)hash_len;
c0d02206:	9004      	str	r0, [sp, #16]
c0d02208:	980f      	ldr	r0, [sp, #60]	; 0x3c
  parameters[5] = (unsigned int)ctx;
c0d0220a:	9005      	str	r0, [sp, #20]
c0d0220c:	9810      	ldr	r0, [sp, #64]	; 0x40
  parameters[6] = (unsigned int)ctx_len;
c0d0220e:	9006      	str	r0, [sp, #24]
c0d02210:	9811      	ldr	r0, [sp, #68]	; 0x44
  parameters[7] = (unsigned int)sig;
c0d02212:	9007      	str	r0, [sp, #28]
c0d02214:	9812      	ldr	r0, [sp, #72]	; 0x48
  parameters[8] = (unsigned int)sig_len;
c0d02216:	9008      	str	r0, [sp, #32]
c0d02218:	9813      	ldr	r0, [sp, #76]	; 0x4c
  parameters[9] = (unsigned int)info;
c0d0221a:	9009      	str	r0, [sp, #36]	; 0x24
c0d0221c:	4803      	ldr	r0, [pc, #12]	; (c0d0222c <cx_eddsa_sign+0x34>)
c0d0221e:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_cx_eddsa_sign_ID_IN, parameters);
c0d02220:	f7ff ff74 	bl	c0d0210c <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d02224:	9801      	ldr	r0, [sp, #4]
c0d02226:	b00c      	add	sp, #48	; 0x30
c0d02228:	bd80      	pop	{r7, pc}
c0d0222a:	46c0      	nop			; (mov r8, r8)
c0d0222c:	6000363b 	.word	0x6000363b

c0d02230 <cx_crc16_update>:
  SVC_Call(SYSCALL_cx_crc16_ID_IN, parameters);
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
}

unsigned short cx_crc16_update ( unsigned short crc, const void * buffer, size_t len ) 
{
c0d02230:	b580      	push	{r7, lr}
c0d02232:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)crc;
c0d02234:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)buffer;
c0d02236:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)len;
c0d02238:	9203      	str	r2, [sp, #12]
c0d0223a:	4804      	ldr	r0, [pc, #16]	; (c0d0224c <cx_crc16_update+0x1c>)
c0d0223c:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_cx_crc16_update_ID_IN, parameters);
c0d0223e:	f7ff ff65 	bl	c0d0210c <SVC_Call>
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
c0d02242:	9802      	ldr	r0, [sp, #8]
c0d02244:	b280      	uxth	r0, r0
c0d02246:	b006      	add	sp, #24
c0d02248:	bd80      	pop	{r7, pc}
c0d0224a:	46c0      	nop			; (mov r8, r8)
c0d0224c:	6000926e 	.word	0x6000926e

c0d02250 <os_perso_isonboarded>:
  volatile unsigned int parameters [2];
  SVC_Call(SYSCALL_os_perso_finalize_ID_IN, parameters);
}

bolos_bool_t os_perso_isonboarded ( void ) 
{
c0d02250:	b580      	push	{r7, lr}
c0d02252:	b082      	sub	sp, #8
c0d02254:	4803      	ldr	r0, [pc, #12]	; (c0d02264 <os_perso_isonboarded+0x14>)
c0d02256:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_perso_isonboarded_ID_IN, parameters);
c0d02258:	f7ff ff58 	bl	c0d0210c <SVC_Call>
  return (bolos_bool_t)(((volatile unsigned int*)parameters)[1]);
c0d0225c:	9801      	ldr	r0, [sp, #4]
c0d0225e:	b2c0      	uxtb	r0, r0
c0d02260:	b002      	add	sp, #8
c0d02262:	bd80      	pop	{r7, pc}
c0d02264:	60009f4f 	.word	0x60009f4f

c0d02268 <os_perso_derive_node_bip32>:
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, const unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d02268:	b580      	push	{r7, lr}
c0d0226a:	b088      	sub	sp, #32
  volatile unsigned int parameters [2+5];
  parameters[0] = (unsigned int)curve;
c0d0226c:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)path;
c0d0226e:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)pathLength;
c0d02270:	9203      	str	r2, [sp, #12]
  parameters[3] = (unsigned int)privateKey;
c0d02272:	9304      	str	r3, [sp, #16]
c0d02274:	980a      	ldr	r0, [sp, #40]	; 0x28
  parameters[4] = (unsigned int)chain;
c0d02276:	9005      	str	r0, [sp, #20]
c0d02278:	4802      	ldr	r0, [pc, #8]	; (c0d02284 <os_perso_derive_node_bip32+0x1c>)
c0d0227a:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_perso_derive_node_bip32_ID_IN, parameters);
c0d0227c:	f7ff ff46 	bl	c0d0210c <SVC_Call>
}
c0d02280:	b008      	add	sp, #32
c0d02282:	bd80      	pop	{r7, pc}
c0d02284:	600053ba 	.word	0x600053ba

c0d02288 <os_perso_seed_cookie>:
  parameters[7] = (unsigned int)seed_key_length;
  SVC_Call(SYSCALL_os_perso_derive_node_with_seed_key_ID_IN, parameters);
}

unsigned int os_perso_seed_cookie ( unsigned char * seed_cookie, unsigned int seed_cookie_length ) 
{
c0d02288:	b580      	push	{r7, lr}
c0d0228a:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)seed_cookie;
c0d0228c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)seed_cookie_length;
c0d0228e:	9101      	str	r1, [sp, #4]
c0d02290:	4803      	ldr	r0, [pc, #12]	; (c0d022a0 <os_perso_seed_cookie+0x18>)
c0d02292:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_perso_seed_cookie_ID_IN, parameters);
c0d02294:	f7ff ff3a 	bl	c0d0210c <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d02298:	9801      	ldr	r0, [sp, #4]
c0d0229a:	b004      	add	sp, #16
c0d0229c:	bd80      	pop	{r7, pc}
c0d0229e:	46c0      	nop			; (mov r8, r8)
c0d022a0:	6000a8fc 	.word	0x6000a8fc

c0d022a4 <os_global_pin_is_validated>:
  SVC_Call(SYSCALL_os_endorsement_key2_derive_sign_data_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

bolos_bool_t os_global_pin_is_validated ( void ) 
{
c0d022a4:	b580      	push	{r7, lr}
c0d022a6:	b082      	sub	sp, #8
c0d022a8:	4803      	ldr	r0, [pc, #12]	; (c0d022b8 <os_global_pin_is_validated+0x14>)
c0d022aa:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_global_pin_is_validated_ID_IN, parameters);
c0d022ac:	f7ff ff2e 	bl	c0d0210c <SVC_Call>
  return (bolos_bool_t)(((volatile unsigned int*)parameters)[1]);
c0d022b0:	9801      	ldr	r0, [sp, #4]
c0d022b2:	b2c0      	uxtb	r0, r0
c0d022b4:	b002      	add	sp, #8
c0d022b6:	bd80      	pop	{r7, pc}
c0d022b8:	6000a03c 	.word	0x6000a03c

c0d022bc <os_ux>:
  parameters[1] = (unsigned int)out_application_entry;
  SVC_Call(SYSCALL_os_registry_get_ID_IN, parameters);
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d022bc:	b580      	push	{r7, lr}
c0d022be:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)params;
c0d022c0:	9001      	str	r0, [sp, #4]
c0d022c2:	4803      	ldr	r0, [pc, #12]	; (c0d022d0 <os_ux+0x14>)
c0d022c4:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
c0d022c6:	f7ff ff21 	bl	c0d0210c <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d022ca:	9802      	ldr	r0, [sp, #8]
c0d022cc:	b004      	add	sp, #16
c0d022ce:	bd80      	pop	{r7, pc}
c0d022d0:	60006458 	.word	0x60006458

c0d022d4 <os_flags>:
  parameters[0] = (unsigned int)exception;
  SVC_Call(SYSCALL_os_lib_throw_ID_IN, parameters);
}

unsigned int os_flags ( void ) 
{
c0d022d4:	b580      	push	{r7, lr}
c0d022d6:	b082      	sub	sp, #8
c0d022d8:	4803      	ldr	r0, [pc, #12]	; (c0d022e8 <os_flags+0x14>)
c0d022da:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
c0d022dc:	f7ff ff16 	bl	c0d0210c <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d022e0:	9801      	ldr	r0, [sp, #4]
c0d022e2:	b002      	add	sp, #8
c0d022e4:	bd80      	pop	{r7, pc}
c0d022e6:	46c0      	nop			; (mov r8, r8)
c0d022e8:	60006a6e 	.word	0x60006a6e

c0d022ec <os_registry_get_current_app_tag>:
  SVC_Call(SYSCALL_os_registry_get_tag_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

unsigned int os_registry_get_current_app_tag ( unsigned int tag, unsigned char * buffer, unsigned int maxlen ) 
{
c0d022ec:	b580      	push	{r7, lr}
c0d022ee:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)tag;
c0d022f0:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)buffer;
c0d022f2:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)maxlen;
c0d022f4:	9203      	str	r2, [sp, #12]
c0d022f6:	4803      	ldr	r0, [pc, #12]	; (c0d02304 <os_registry_get_current_app_tag+0x18>)
c0d022f8:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
c0d022fa:	f7ff ff07 	bl	c0d0210c <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d022fe:	9802      	ldr	r0, [sp, #8]
c0d02300:	b006      	add	sp, #24
c0d02302:	bd80      	pop	{r7, pc}
c0d02304:	600074d4 	.word	0x600074d4

c0d02308 <os_sched_exit>:
  parameters[0] = (unsigned int)application_index;
  SVC_Call(SYSCALL_os_sched_exec_ID_IN, parameters);
}

void os_sched_exit ( bolos_task_status_t exit_code ) 
{
c0d02308:	b580      	push	{r7, lr}
c0d0230a:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
  parameters[0] = (unsigned int)exit_code;
c0d0230c:	9001      	str	r0, [sp, #4]
c0d0230e:	4803      	ldr	r0, [pc, #12]	; (c0d0231c <os_sched_exit+0x14>)
c0d02310:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d02312:	f7ff fefb 	bl	c0d0210c <SVC_Call>
}
c0d02316:	b004      	add	sp, #16
c0d02318:	bd80      	pop	{r7, pc}
c0d0231a:	46c0      	nop			; (mov r8, r8)
c0d0231c:	60009abe 	.word	0x60009abe

c0d02320 <io_seph_send>:
  parameters[0] = (unsigned int)taskidx;
  SVC_Call(SYSCALL_os_sched_kill_ID_IN, parameters);
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d02320:	b580      	push	{r7, lr}
c0d02322:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
c0d02324:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)length;
c0d02326:	9101      	str	r1, [sp, #4]
c0d02328:	4802      	ldr	r0, [pc, #8]	; (c0d02334 <io_seph_send+0x14>)
c0d0232a:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_io_seph_send_ID_IN, parameters);
c0d0232c:	f7ff feee 	bl	c0d0210c <SVC_Call>
}
c0d02330:	b004      	add	sp, #16
c0d02332:	bd80      	pop	{r7, pc}
c0d02334:	60008381 	.word	0x60008381

c0d02338 <io_seph_is_status_sent>:

unsigned int io_seph_is_status_sent ( void ) 
{
c0d02338:	b580      	push	{r7, lr}
c0d0233a:	b082      	sub	sp, #8
c0d0233c:	4803      	ldr	r0, [pc, #12]	; (c0d0234c <io_seph_is_status_sent+0x14>)
c0d0233e:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_io_seph_is_status_sent_ID_IN, parameters);
c0d02340:	f7ff fee4 	bl	c0d0210c <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d02344:	9801      	ldr	r0, [sp, #4]
c0d02346:	b002      	add	sp, #8
c0d02348:	bd80      	pop	{r7, pc}
c0d0234a:	46c0      	nop			; (mov r8, r8)
c0d0234c:	600084bb 	.word	0x600084bb

c0d02350 <io_seph_recv>:
}

unsigned short io_seph_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d02350:	b580      	push	{r7, lr}
c0d02352:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)buffer;
c0d02354:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)maxlength;
c0d02356:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)flags;
c0d02358:	9203      	str	r2, [sp, #12]
c0d0235a:	4804      	ldr	r0, [pc, #16]	; (c0d0236c <io_seph_recv+0x1c>)
c0d0235c:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_io_seph_recv_ID_IN, parameters);
c0d0235e:	f7ff fed5 	bl	c0d0210c <SVC_Call>
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
c0d02362:	9802      	ldr	r0, [sp, #8]
c0d02364:	b280      	uxth	r0, r0
c0d02366:	b006      	add	sp, #24
c0d02368:	bd80      	pop	{r7, pc}
c0d0236a:	46c0      	nop			; (mov r8, r8)
c0d0236c:	600085e4 	.word	0x600085e4

c0d02370 <try_context_get>:
  parameters[0] = (unsigned int)page_adr;
  SVC_Call(SYSCALL_nvm_write_page_ID_IN, parameters);
}

try_context_t * try_context_get ( void ) 
{
c0d02370:	b580      	push	{r7, lr}
c0d02372:	b082      	sub	sp, #8
c0d02374:	4803      	ldr	r0, [pc, #12]	; (c0d02384 <try_context_get+0x14>)
c0d02376:	4669      	mov	r1, sp
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_try_context_get_ID_IN, parameters);
c0d02378:	f7ff fec8 	bl	c0d0210c <SVC_Call>
  return (try_context_t *)(((volatile unsigned int*)parameters)[1]);
c0d0237c:	9801      	ldr	r0, [sp, #4]
c0d0237e:	b002      	add	sp, #8
c0d02380:	bd80      	pop	{r7, pc}
c0d02382:	46c0      	nop			; (mov r8, r8)
c0d02384:	600087b1 	.word	0x600087b1

c0d02388 <try_context_set>:
}

try_context_t * try_context_set ( try_context_t * context ) 
{
c0d02388:	b580      	push	{r7, lr}
c0d0238a:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)context;
c0d0238c:	9001      	str	r0, [sp, #4]
c0d0238e:	4803      	ldr	r0, [pc, #12]	; (c0d0239c <try_context_set+0x14>)
c0d02390:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_try_context_set_ID_IN, parameters);
c0d02392:	f7ff febb 	bl	c0d0210c <SVC_Call>
  return (try_context_t *)(((volatile unsigned int*)parameters)[1]);
c0d02396:	9802      	ldr	r0, [sp, #8]
c0d02398:	b004      	add	sp, #16
c0d0239a:	bd80      	pop	{r7, pc}
c0d0239c:	60008875 	.word	0x60008875

c0d023a0 <os_sched_last_status>:
  SVC_Call(SYSCALL_cx_rng_u32_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

bolos_task_status_t os_sched_last_status ( unsigned int task_idx ) 
{
c0d023a0:	b580      	push	{r7, lr}
c0d023a2:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)task_idx;
c0d023a4:	9001      	str	r0, [sp, #4]
c0d023a6:	4804      	ldr	r0, [pc, #16]	; (c0d023b8 <os_sched_last_status+0x18>)
c0d023a8:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_sched_last_status_ID_IN, parameters);
c0d023aa:	f7ff feaf 	bl	c0d0210c <SVC_Call>
  return (bolos_task_status_t)(((volatile unsigned int*)parameters)[1]);
c0d023ae:	9802      	ldr	r0, [sp, #8]
c0d023b0:	b2c0      	uxtb	r0, r0
c0d023b2:	b004      	add	sp, #16
c0d023b4:	bd80      	pop	{r7, pc}
c0d023b6:	46c0      	nop			; (mov r8, r8)
c0d023b8:	60009c8b 	.word	0x60009c8b

c0d023bc <u2f_apdu_sign>:

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
}

void u2f_apdu_sign(u2f_service_t *service, uint8_t p1, uint8_t p2,
                     uint8_t *buffer, uint16_t length) {
c0d023bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d023be:	b083      	sub	sp, #12
    UNUSED(p2);
    uint8_t keyHandleLength;
    uint8_t i;

    // can't process the apdu if another one is already scheduled in
    if (G_io_app.apdu_state != APDU_IDLE) {
c0d023c0:	4a35      	ldr	r2, [pc, #212]	; (c0d02498 <u2f_apdu_sign+0xdc>)
c0d023c2:	7812      	ldrb	r2, [r2, #0]
c0d023c4:	2a00      	cmp	r2, #0
c0d023c6:	d003      	beq.n	c0d023d0 <u2f_apdu_sign+0x14>
c0d023c8:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d023ca:	4a35      	ldr	r2, [pc, #212]	; (c0d024a0 <u2f_apdu_sign+0xe4>)
c0d023cc:	447a      	add	r2, pc
c0d023ce:	e00b      	b.n	c0d023e8 <u2f_apdu_sign+0x2c>
c0d023d0:	9a08      	ldr	r2, [sp, #32]
                  (uint8_t *)SW_BUSY,
                  sizeof(SW_BUSY));
        return;        
    }

    if (length < U2F_HANDLE_SIGN_HEADER_SIZE + 5 /*at least an apdu header*/) {
c0d023d2:	2a45      	cmp	r2, #69	; 0x45
c0d023d4:	d803      	bhi.n	c0d023de <u2f_apdu_sign+0x22>
c0d023d6:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d023d8:	4a32      	ldr	r2, [pc, #200]	; (c0d024a4 <u2f_apdu_sign+0xe8>)
c0d023da:	447a      	add	r2, pc
c0d023dc:	e004      	b.n	c0d023e8 <u2f_apdu_sign+0x2c>
                  sizeof(SW_WRONG_LENGTH));
        return;
    }

    // Confirm immediately if it's just a validation call
    if (p1 == P1_SIGN_CHECK_ONLY) {
c0d023de:	2907      	cmp	r1, #7
c0d023e0:	d107      	bne.n	c0d023f2 <u2f_apdu_sign+0x36>
c0d023e2:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d023e4:	4a30      	ldr	r2, [pc, #192]	; (c0d024a8 <u2f_apdu_sign+0xec>)
c0d023e6:	447a      	add	r2, pc
c0d023e8:	2302      	movs	r3, #2
c0d023ea:	f000 fc53 	bl	c0d02c94 <u2f_message_reply>
    app_dispatch();
    if ((btchip_context_D.io_flags & IO_ASYNCH_REPLY) == 0) {
        u2f_proxy_response(service, btchip_context_D.outLength);
    }
    */
}
c0d023ee:	b003      	add	sp, #12
c0d023f0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d023f2:	9200      	str	r2, [sp, #0]
c0d023f4:	9001      	str	r0, [sp, #4]
c0d023f6:	2040      	movs	r0, #64	; 0x40
c0d023f8:	9302      	str	r3, [sp, #8]
                  sizeof(SW_PROOF_OF_PRESENCE_REQUIRED));
        return;
    }

    // Unwrap magic
    keyHandleLength = buffer[U2F_HANDLE_SIGN_HEADER_SIZE-1];
c0d023fa:	5c1e      	ldrb	r6, [r3, r0]
    
    // reply to the "get magic" question of the host
    if (keyHandleLength == 5) {
c0d023fc:	2e00      	cmp	r6, #0
c0d023fe:	d01a      	beq.n	c0d02436 <u2f_apdu_sign+0x7a>
c0d02400:	2e05      	cmp	r6, #5
c0d02402:	9d02      	ldr	r5, [sp, #8]
c0d02404:	d108      	bne.n	c0d02418 <u2f_apdu_sign+0x5c>
        // GET U2F PROXY PARAMETERS
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
c0d02406:	4628      	mov	r0, r5
c0d02408:	3041      	adds	r0, #65	; 0x41
c0d0240a:	4928      	ldr	r1, [pc, #160]	; (c0d024ac <u2f_apdu_sign+0xf0>)
c0d0240c:	4479      	add	r1, pc
c0d0240e:	2205      	movs	r2, #5
c0d02410:	f7fe ff40 	bl	c0d01294 <os_memcmp>
c0d02414:	2800      	cmp	r0, #0
c0d02416:	d02b      	beq.n	c0d02470 <u2f_apdu_sign+0xb4>
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
c0d02418:	3541      	adds	r5, #65	; 0x41
c0d0241a:	2400      	movs	r4, #0
c0d0241c:	4f24      	ldr	r7, [pc, #144]	; (c0d024b0 <u2f_apdu_sign+0xf4>)
c0d0241e:	447f      	add	r7, pc
c0d02420:	b2e0      	uxtb	r0, r4
c0d02422:	2103      	movs	r1, #3
c0d02424:	f001 ff0c 	bl	c0d04240 <__aeabi_uidivmod>
c0d02428:	5d28      	ldrb	r0, [r5, r4]
c0d0242a:	5c79      	ldrb	r1, [r7, r1]
c0d0242c:	4041      	eors	r1, r0
c0d0242e:	5529      	strb	r1, [r5, r4]
            return;
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
c0d02430:	1c64      	adds	r4, r4, #1
c0d02432:	42a6      	cmp	r6, r4
c0d02434:	d1f4      	bne.n	c0d02420 <u2f_apdu_sign+0x64>
c0d02436:	2045      	movs	r0, #69	; 0x45
c0d02438:	9902      	ldr	r1, [sp, #8]
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
c0d0243a:	5c08      	ldrb	r0, [r1, r0]
c0d0243c:	3046      	adds	r0, #70	; 0x46
c0d0243e:	9a00      	ldr	r2, [sp, #0]
c0d02440:	4290      	cmp	r0, r2
c0d02442:	d10f      	bne.n	c0d02464 <u2f_apdu_sign+0xa8>
                  sizeof(SW_BAD_KEY_HANDLE));
        return;
    }

    // make the apdu available to higher layers
    os_memmove(G_io_apdu_buffer, buffer + U2F_HANDLE_SIGN_HEADER_SIZE, keyHandleLength);
c0d02444:	3141      	adds	r1, #65	; 0x41
c0d02446:	4815      	ldr	r0, [pc, #84]	; (c0d0249c <u2f_apdu_sign+0xe0>)
c0d02448:	4632      	mov	r2, r6
c0d0244a:	f7fe ff04 	bl	c0d01256 <os_memmove>
c0d0244e:	2007      	movs	r0, #7
c0d02450:	4911      	ldr	r1, [pc, #68]	; (c0d02498 <u2f_apdu_sign+0xdc>)
    G_io_app.apdu_length = keyHandleLength;
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
c0d02452:	7188      	strb	r0, [r1, #6]
        return;
    }

    // make the apdu available to higher layers
    os_memmove(G_io_apdu_buffer, buffer + U2F_HANDLE_SIGN_HEADER_SIZE, keyHandleLength);
    G_io_app.apdu_length = keyHandleLength;
c0d02454:	804e      	strh	r6, [r1, #2]
c0d02456:	2009      	movs	r0, #9
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
    G_io_app.apdu_state = APDU_U2F;
c0d02458:	7008      	strb	r0, [r1, #0]
c0d0245a:	2101      	movs	r1, #1

    // prepare for asynch reply
    u2f_message_set_autoreply_wait_user_presence(service, true);
c0d0245c:	9801      	ldr	r0, [sp, #4]
c0d0245e:	f000 fc05 	bl	c0d02c6c <u2f_message_set_autoreply_wait_user_presence>
c0d02462:	e7c4      	b.n	c0d023ee <u2f_apdu_sign+0x32>
c0d02464:	2183      	movs	r1, #131	; 0x83
    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
        u2f_message_reply(service, U2F_CMD_MSG,
c0d02466:	4a13      	ldr	r2, [pc, #76]	; (c0d024b4 <u2f_apdu_sign+0xf8>)
c0d02468:	447a      	add	r2, pc
c0d0246a:	2302      	movs	r3, #2
c0d0246c:	9801      	ldr	r0, [sp, #4]
c0d0246e:	e7bc      	b.n	c0d023ea <u2f_apdu_sign+0x2e>
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
c0d02470:	4d0a      	ldr	r5, [pc, #40]	; (c0d0249c <u2f_apdu_sign+0xe0>)
c0d02472:	2203      	movs	r2, #3
c0d02474:	702a      	strb	r2, [r5, #0]
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
c0d02476:	1c68      	adds	r0, r5, #1
c0d02478:	490f      	ldr	r1, [pc, #60]	; (c0d024b8 <u2f_apdu_sign+0xfc>)
c0d0247a:	4479      	add	r1, pc
c0d0247c:	f7fe feeb 	bl	c0d01256 <os_memmove>
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
c0d02480:	1d28      	adds	r0, r5, #4
c0d02482:	490e      	ldr	r1, [pc, #56]	; (c0d024bc <u2f_apdu_sign+0x100>)
c0d02484:	4479      	add	r1, pc
c0d02486:	2204      	movs	r2, #4
c0d02488:	f7fe fee5 	bl	c0d01256 <os_memmove>
            u2f_message_reply(service, U2F_CMD_MSG,
                              (uint8_t *)G_io_apdu_buffer,
                              G_io_apdu_buffer[0]+1+2+2);
c0d0248c:	7828      	ldrb	r0, [r5, #0]
c0d0248e:	1d43      	adds	r3, r0, #5
c0d02490:	2183      	movs	r1, #131	; 0x83
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
            u2f_message_reply(service, U2F_CMD_MSG,
c0d02492:	9801      	ldr	r0, [sp, #4]
c0d02494:	462a      	mov	r2, r5
c0d02496:	e7a8      	b.n	c0d023ea <u2f_apdu_sign+0x2e>
c0d02498:	20001f48 	.word	0x20001f48
c0d0249c:	20001df4 	.word	0x20001df4
c0d024a0:	000024f7 	.word	0x000024f7
c0d024a4:	000024eb 	.word	0x000024eb
c0d024a8:	000024e1 	.word	0x000024e1
c0d024ac:	000024bd 	.word	0x000024bd
c0d024b0:	000024b1 	.word	0x000024b1
c0d024b4:	00002470 	.word	0x00002470
c0d024b8:	00002455 	.word	0x00002455
c0d024bc:	0000244f 	.word	0x0000244f

c0d024c0 <u2f_handle_cmd_init>:
}

#endif // U2F_PROXY_MAGIC

void u2f_handle_cmd_init(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length, uint8_t *channelInit) {
c0d024c0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d024c2:	b081      	sub	sp, #4
c0d024c4:	461d      	mov	r5, r3
c0d024c6:	460e      	mov	r6, r1
c0d024c8:	4604      	mov	r4, r0
    // screen_printf("U2F init\n");
    uint8_t channel[4];
    (void)length;
    if (u2f_is_channel_broadcast(channelInit)) {
c0d024ca:	4618      	mov	r0, r3
c0d024cc:	f000 fbc2 	bl	c0d02c54 <u2f_is_channel_broadcast>
c0d024d0:	2800      	cmp	r0, #0
c0d024d2:	d00e      	beq.n	c0d024f2 <u2f_handle_cmd_init+0x32>
        // cx_rng(channel, 4); // not available within the IO task
        U4BE_ENCODE(channel, 0, ++service->next_channel);
c0d024d4:	6820      	ldr	r0, [r4, #0]
c0d024d6:	1cc1      	adds	r1, r0, #3
c0d024d8:	0a09      	lsrs	r1, r1, #8
c0d024da:	466a      	mov	r2, sp
c0d024dc:	7091      	strb	r1, [r2, #2]
c0d024de:	1c81      	adds	r1, r0, #2
c0d024e0:	0c09      	lsrs	r1, r1, #16
c0d024e2:	7051      	strb	r1, [r2, #1]
c0d024e4:	1c41      	adds	r1, r0, #1
c0d024e6:	0e09      	lsrs	r1, r1, #24
c0d024e8:	7011      	strb	r1, [r2, #0]
c0d024ea:	1d00      	adds	r0, r0, #4
c0d024ec:	6020      	str	r0, [r4, #0]
c0d024ee:	70d0      	strb	r0, [r2, #3]
c0d024f0:	e004      	b.n	c0d024fc <u2f_handle_cmd_init+0x3c>
c0d024f2:	4668      	mov	r0, sp
c0d024f4:	2204      	movs	r2, #4
    } else {
        os_memmove(channel, channelInit, 4);
c0d024f6:	4629      	mov	r1, r5
c0d024f8:	f7fe fead 	bl	c0d01256 <os_memmove>
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
c0d024fc:	4f15      	ldr	r7, [pc, #84]	; (c0d02554 <u2f_handle_cmd_init+0x94>)
c0d024fe:	2208      	movs	r2, #8
c0d02500:	4638      	mov	r0, r7
c0d02502:	4631      	mov	r1, r6
c0d02504:	f7fe fea7 	bl	c0d01256 <os_memmove>
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
c0d02508:	4638      	mov	r0, r7
c0d0250a:	3008      	adds	r0, #8
c0d0250c:	4669      	mov	r1, sp
c0d0250e:	2204      	movs	r2, #4
c0d02510:	f7fe fea1 	bl	c0d01256 <os_memmove>
c0d02514:	2000      	movs	r0, #0
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
    G_io_apdu_buffer[15] = INIT_BUILD_VERSION;
    G_io_apdu_buffer[16] = INIT_CAPABILITIES;
c0d02516:	7438      	strb	r0, [r7, #16]
    os_memmove(G_io_apdu_buffer, buffer, 8);
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
    G_io_apdu_buffer[15] = INIT_BUILD_VERSION;
c0d02518:	73f8      	strb	r0, [r7, #15]
c0d0251a:	2101      	movs	r1, #1
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
c0d0251c:	73b9      	strb	r1, [r7, #14]
        os_memmove(channel, channelInit, 4);
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
c0d0251e:	7378      	strb	r0, [r7, #13]
c0d02520:	2002      	movs	r0, #2
    } else {
        os_memmove(channel, channelInit, 4);
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
c0d02522:	7338      	strb	r0, [r7, #12]
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
    G_io_apdu_buffer[15] = INIT_BUILD_VERSION;
    G_io_apdu_buffer[16] = INIT_CAPABILITIES;

    if (u2f_is_channel_broadcast(channelInit)) {
c0d02524:	4628      	mov	r0, r5
c0d02526:	f000 fb95 	bl	c0d02c54 <u2f_is_channel_broadcast>
c0d0252a:	4601      	mov	r1, r0
c0d0252c:	1d20      	adds	r0, r4, #4
c0d0252e:	2900      	cmp	r1, #0
c0d02530:	d004      	beq.n	c0d0253c <u2f_handle_cmd_init+0x7c>
c0d02532:	21ff      	movs	r1, #255	; 0xff
c0d02534:	2204      	movs	r2, #4
        os_memset(service->channel, 0xff, 4);
c0d02536:	f7fe fea4 	bl	c0d01282 <os_memset>
c0d0253a:	e003      	b.n	c0d02544 <u2f_handle_cmd_init+0x84>
c0d0253c:	4669      	mov	r1, sp
c0d0253e:	2204      	movs	r2, #4
    } else {
        os_memmove(service->channel, channel, 4);
c0d02540:	f7fe fe89 	bl	c0d01256 <os_memmove>
c0d02544:	2186      	movs	r1, #134	; 0x86
    }
    u2f_message_reply(service, U2F_CMD_INIT, G_io_apdu_buffer, 17);
c0d02546:	4a03      	ldr	r2, [pc, #12]	; (c0d02554 <u2f_handle_cmd_init+0x94>)
c0d02548:	2311      	movs	r3, #17
c0d0254a:	4620      	mov	r0, r4
c0d0254c:	f000 fba2 	bl	c0d02c94 <u2f_message_reply>
}
c0d02550:	b001      	add	sp, #4
c0d02552:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02554:	20001df4 	.word	0x20001df4

c0d02558 <u2f_handle_cmd_msg>:
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
c0d02558:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0255a:	b083      	sub	sp, #12
c0d0255c:	9002      	str	r0, [sp, #8]
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
c0d0255e:	7988      	ldrb	r0, [r1, #6]
c0d02560:	794b      	ldrb	r3, [r1, #5]
c0d02562:	021b      	lsls	r3, r3, #8
c0d02564:	181f      	adds	r7, r3, r0
void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
c0d02566:	7888      	ldrb	r0, [r1, #2]

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
c0d02568:	9001      	str	r0, [sp, #4]
c0d0256a:	7848      	ldrb	r0, [r1, #1]
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
c0d0256c:	780e      	ldrb	r6, [r1, #0]
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
c0d0256e:	4615      	mov	r5, r2
c0d02570:	3d09      	subs	r5, #9
c0d02572:	b2ab      	uxth	r3, r5
c0d02574:	429f      	cmp	r7, r3
c0d02576:	d003      	beq.n	c0d02580 <u2f_handle_cmd_msg+0x28>
c0d02578:	1fd4      	subs	r4, r2, #7
c0d0257a:	b2a4      	uxth	r4, r4
c0d0257c:	42a7      	cmp	r7, r4
c0d0257e:	d11b      	bne.n	c0d025b8 <u2f_handle_cmd_msg+0x60>
c0d02580:	463d      	mov	r5, r7
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
    G_io_app.apdu_state = APDU_U2F;

#else // U2F_PROXY_MAGIC

    if (cla != FIDO_CLA) {
c0d02582:	2e00      	cmp	r6, #0
c0d02584:	d008      	beq.n	c0d02598 <u2f_handle_cmd_msg+0x40>
c0d02586:	2183      	movs	r1, #131	; 0x83
        u2f_message_reply(service, U2F_CMD_MSG,
c0d02588:	4a1c      	ldr	r2, [pc, #112]	; (c0d025fc <u2f_handle_cmd_msg+0xa4>)
c0d0258a:	447a      	add	r2, pc
c0d0258c:	2302      	movs	r3, #2
c0d0258e:	9802      	ldr	r0, [sp, #8]
c0d02590:	f000 fb80 	bl	c0d02c94 <u2f_message_reply>
                 sizeof(SW_UNKNOWN_INSTRUCTION));
        return;
    }

#endif // U2F_PROXY_MAGIC
}
c0d02594:	b003      	add	sp, #12
c0d02596:	bdf0      	pop	{r4, r5, r6, r7, pc}
        u2f_message_reply(service, U2F_CMD_MSG,
                  (uint8_t *)SW_UNKNOWN_CLASS,
                  sizeof(SW_UNKNOWN_CLASS));
        return;
    }
    switch (ins) {
c0d02598:	2802      	cmp	r0, #2
c0d0259a:	dc15      	bgt.n	c0d025c8 <u2f_handle_cmd_msg+0x70>
c0d0259c:	2801      	cmp	r0, #1
c0d0259e:	d020      	beq.n	c0d025e2 <u2f_handle_cmd_msg+0x8a>
c0d025a0:	2802      	cmp	r0, #2
c0d025a2:	d11a      	bne.n	c0d025da <u2f_handle_cmd_msg+0x82>
        // screen_printf("enroll\n");
        u2f_apdu_enroll(service, p1, p2, buffer + 7, dataLength);
        break;
    case FIDO_INS_SIGN:
        // screen_printf("sign\n");
        u2f_apdu_sign(service, p1, p2, buffer + 7, dataLength);
c0d025a4:	b2a8      	uxth	r0, r5
c0d025a6:	466a      	mov	r2, sp
c0d025a8:	6010      	str	r0, [r2, #0]
c0d025aa:	1dcb      	adds	r3, r1, #7
c0d025ac:	2200      	movs	r2, #0
c0d025ae:	9802      	ldr	r0, [sp, #8]
c0d025b0:	9901      	ldr	r1, [sp, #4]
c0d025b2:	f7ff ff03 	bl	c0d023bc <u2f_apdu_sign>
c0d025b6:	e7ed      	b.n	c0d02594 <u2f_handle_cmd_msg+0x3c>
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
        // Le is optional
        // nominal case from the specification
    }
    // circumvent google chrome extended length encoding done on the last byte only (module 256) but all data being transferred
    else if (dataLength == (uint16_t)(length - 9)%256) {
c0d025b8:	b2db      	uxtb	r3, r3
c0d025ba:	429f      	cmp	r7, r3
c0d025bc:	d0e1      	beq.n	c0d02582 <u2f_handle_cmd_msg+0x2a>
        dataLength = length - 9;
    }
    else if (dataLength == (uint16_t)(length - 7)%256) {
c0d025be:	b2e3      	uxtb	r3, r4
c0d025c0:	429f      	cmp	r7, r3
c0d025c2:	d112      	bne.n	c0d025ea <u2f_handle_cmd_msg+0x92>
c0d025c4:	1fd5      	subs	r5, r2, #7
c0d025c6:	e7dc      	b.n	c0d02582 <u2f_handle_cmd_msg+0x2a>
        u2f_message_reply(service, U2F_CMD_MSG,
                  (uint8_t *)SW_UNKNOWN_CLASS,
                  sizeof(SW_UNKNOWN_CLASS));
        return;
    }
    switch (ins) {
c0d025c8:	2803      	cmp	r0, #3
c0d025ca:	d012      	beq.n	c0d025f2 <u2f_handle_cmd_msg+0x9a>
c0d025cc:	28c1      	cmp	r0, #193	; 0xc1
c0d025ce:	d104      	bne.n	c0d025da <u2f_handle_cmd_msg+0x82>
c0d025d0:	2183      	movs	r1, #131	; 0x83
                            uint8_t *buffer, uint16_t length) {
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)INFO, sizeof(INFO));
c0d025d2:	4a0b      	ldr	r2, [pc, #44]	; (c0d02600 <u2f_handle_cmd_msg+0xa8>)
c0d025d4:	447a      	add	r2, pc
c0d025d6:	2304      	movs	r3, #4
c0d025d8:	e7d9      	b.n	c0d0258e <u2f_handle_cmd_msg+0x36>
c0d025da:	2183      	movs	r1, #131	; 0x83
        u2f_apdu_get_info(service, p1, p2, buffer + 7, dataLength);
        break;

    default:
        // screen_printf("unsupported\n");
        u2f_message_reply(service, U2F_CMD_MSG,
c0d025dc:	4a0b      	ldr	r2, [pc, #44]	; (c0d0260c <u2f_handle_cmd_msg+0xb4>)
c0d025de:	447a      	add	r2, pc
c0d025e0:	e7d4      	b.n	c0d0258c <u2f_handle_cmd_msg+0x34>
c0d025e2:	2183      	movs	r1, #131	; 0x83
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
c0d025e4:	4a07      	ldr	r2, [pc, #28]	; (c0d02604 <u2f_handle_cmd_msg+0xac>)
c0d025e6:	447a      	add	r2, pc
c0d025e8:	e7d0      	b.n	c0d0258c <u2f_handle_cmd_msg+0x34>
c0d025ea:	2183      	movs	r1, #131	; 0x83
    else if (dataLength == (uint16_t)(length - 7)%256) {
        dataLength = length - 7;
    }    
    else { 
        // invalid size
        u2f_message_reply(service, U2F_CMD_MSG,
c0d025ec:	4a08      	ldr	r2, [pc, #32]	; (c0d02610 <u2f_handle_cmd_msg+0xb8>)
c0d025ee:	447a      	add	r2, pc
c0d025f0:	e7cc      	b.n	c0d0258c <u2f_handle_cmd_msg+0x34>
c0d025f2:	2183      	movs	r1, #131	; 0x83
    // screen_printf("U2F version\n");
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)U2F_VERSION, sizeof(U2F_VERSION));
c0d025f4:	4a04      	ldr	r2, [pc, #16]	; (c0d02608 <u2f_handle_cmd_msg+0xb0>)
c0d025f6:	447a      	add	r2, pc
c0d025f8:	2308      	movs	r3, #8
c0d025fa:	e7c8      	b.n	c0d0258e <u2f_handle_cmd_msg+0x36>
c0d025fc:	0000235c 	.word	0x0000235c
c0d02600:	0000230e 	.word	0x0000230e
c0d02604:	000022db 	.word	0x000022db
c0d02608:	000022e4 	.word	0x000022e4
c0d0260c:	0000230a 	.word	0x0000230a
c0d02610:	000022d7 	.word	0x000022d7

c0d02614 <u2f_message_complete>:
    }

#endif // U2F_PROXY_MAGIC
}

void u2f_message_complete(u2f_service_t *service) {
c0d02614:	b580      	push	{r7, lr}
    uint8_t cmd = service->transportBuffer[0];
c0d02616:	69c1      	ldr	r1, [r0, #28]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
c0d02618:	788a      	ldrb	r2, [r1, #2]
c0d0261a:	784b      	ldrb	r3, [r1, #1]
c0d0261c:	021b      	lsls	r3, r3, #8
c0d0261e:	189b      	adds	r3, r3, r2

#endif // U2F_PROXY_MAGIC
}

void u2f_message_complete(u2f_service_t *service) {
    uint8_t cmd = service->transportBuffer[0];
c0d02620:	780a      	ldrb	r2, [r1, #0]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
    switch (cmd) {
c0d02622:	2a81      	cmp	r2, #129	; 0x81
c0d02624:	d009      	beq.n	c0d0263a <u2f_message_complete+0x26>
c0d02626:	2a83      	cmp	r2, #131	; 0x83
c0d02628:	d00d      	beq.n	c0d02646 <u2f_message_complete+0x32>
c0d0262a:	2a86      	cmp	r2, #134	; 0x86
c0d0262c:	d10f      	bne.n	c0d0264e <u2f_message_complete+0x3a>
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
c0d0262e:	1cc9      	adds	r1, r1, #3
c0d02630:	1d03      	adds	r3, r0, #4
c0d02632:	2200      	movs	r2, #0
c0d02634:	f7ff ff44 	bl	c0d024c0 <u2f_handle_cmd_init>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d02638:	bd80      	pop	{r7, pc}
    switch (cmd) {
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
c0d0263a:	1cca      	adds	r2, r1, #3
}

void u2f_handle_cmd_ping(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length) {
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
c0d0263c:	b29b      	uxth	r3, r3
c0d0263e:	2181      	movs	r1, #129	; 0x81
c0d02640:	f000 fb28 	bl	c0d02c94 <u2f_message_reply>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d02644:	bd80      	pop	{r7, pc}
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
c0d02646:	1cc9      	adds	r1, r1, #3
c0d02648:	b29a      	uxth	r2, r3
c0d0264a:	f7ff ff85 	bl	c0d02558 <u2f_handle_cmd_msg>
        break;
    }
}
c0d0264e:	bd80      	pop	{r7, pc}

c0d02650 <u2f_io_send>:
#include "u2f_processing.h"
#include "u2f_impl.h"

#include "os_io_seproxyhal.h"

void u2f_io_send(uint8_t *buffer, uint16_t length, u2f_transport_media_t media) {
c0d02650:	b570      	push	{r4, r5, r6, lr}
    if (media == U2F_MEDIA_USB) {
c0d02652:	2a01      	cmp	r2, #1
c0d02654:	d114      	bne.n	c0d02680 <u2f_io_send+0x30>
c0d02656:	460d      	mov	r5, r1
c0d02658:	4601      	mov	r1, r0
        os_memmove(G_io_usb_ep_buffer, buffer, length);
c0d0265a:	4c0c      	ldr	r4, [pc, #48]	; (c0d0268c <u2f_io_send+0x3c>)
c0d0265c:	4620      	mov	r0, r4
c0d0265e:	462a      	mov	r2, r5
c0d02660:	f7fe fdf9 	bl	c0d01256 <os_memmove>
        // wipe the remaining to avoid :
        // 1/ data leaks
        // 2/ invalid junk
        os_memset(G_io_usb_ep_buffer+length, 0, sizeof(G_io_usb_ep_buffer)-length);
c0d02664:	1960      	adds	r0, r4, r5
c0d02666:	2640      	movs	r6, #64	; 0x40
c0d02668:	1b72      	subs	r2, r6, r5
c0d0266a:	2500      	movs	r5, #0
c0d0266c:	4629      	mov	r1, r5
c0d0266e:	f7fe fe08 	bl	c0d01282 <os_memset>
c0d02672:	2081      	movs	r0, #129	; 0x81
    }
    switch (media) {
    case U2F_MEDIA_USB:
        io_usb_send_ep(U2F_EPIN_ADDR, G_io_usb_ep_buffer, USB_SEGMENT_SIZE, 0);
c0d02674:	4621      	mov	r1, r4
c0d02676:	4632      	mov	r2, r6
c0d02678:	462b      	mov	r3, r5
c0d0267a:	f7fe febf 	bl	c0d013fc <io_usb_send_ep>
#endif
    default:
        PRINTF("Request to send on unsupported media %d\n", media);
        break;
    }
}
c0d0267e:	bd70      	pop	{r4, r5, r6, pc}
    case U2F_MEDIA_BLE:
        BLE_protocol_send(buffer, length);
        break;
#endif
    default:
        PRINTF("Request to send on unsupported media %d\n", media);
c0d02680:	4803      	ldr	r0, [pc, #12]	; (c0d02690 <u2f_io_send+0x40>)
c0d02682:	4478      	add	r0, pc
c0d02684:	4611      	mov	r1, r2
c0d02686:	f7ff fb81 	bl	c0d01d8c <mcu_usb_printf>
        break;
    }
}
c0d0268a:	bd70      	pop	{r4, r5, r6, pc}
c0d0268c:	20001fb4 	.word	0x20001fb4
c0d02690:	00002268 	.word	0x00002268

c0d02694 <u2f_transport_init>:
}

/**
 * Initialize the u2f transport and provide the buffer into which to store incoming message
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
c0d02694:	2300      	movs	r3, #0
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d02696:	7683      	strb	r3, [r0, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d02698:	82c3      	strh	r3, [r0, #22]
/**
 * Initialize the u2f transport and provide the buffer into which to store incoming message
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
    service->transportReceiveBufferLength = message_buffer_length;
c0d0269a:	8202      	strh	r2, [r0, #16]

/**
 * Initialize the u2f transport and provide the buffer into which to store incoming message
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
c0d0269c:	60c1      	str	r1, [r0, #12]
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d0269e:	8543      	strh	r3, [r0, #42]	; 0x2a

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d026a0:	8483      	strh	r3, [r0, #36]	; 0x24
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d026a2:	61c1      	str	r1, [r0, #28]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d026a4:	6203      	str	r3, [r0, #32]
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
    service->transportReceiveBufferLength = message_buffer_length;
    u2f_transport_reset(service);
}
c0d026a6:	4770      	bx	lr

c0d026a8 <u2f_transport_sent>:

/**
 * Function called when the previously scheduled message to be sent on the media is effectively sent.
 * And a new message can be scheduled.
 */
void u2f_transport_sent(u2f_service_t* service, u2f_transport_media_t media) {
c0d026a8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d026aa:	b083      	sub	sp, #12
c0d026ac:	4604      	mov	r4, r0
c0d026ae:	202a      	movs	r0, #42	; 0x2a

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d026b0:	5c20      	ldrb	r0, [r4, r0]
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d026b2:	2801      	cmp	r0, #1
c0d026b4:	d025      	beq.n	c0d02702 <u2f_transport_sent+0x5a>
c0d026b6:	460d      	mov	r5, r1
c0d026b8:	2800      	cmp	r0, #0
c0d026ba:	d117      	bne.n	c0d026ec <u2f_transport_sent+0x44>
c0d026bc:	202b      	movs	r0, #43	; 0x2b
c0d026be:	2100      	movs	r1, #0
c0d026c0:	5421      	strb	r1, [r4, r0]
c0d026c2:	4620      	mov	r0, r4
c0d026c4:	302b      	adds	r0, #43	; 0x2b
c0d026c6:	2120      	movs	r1, #32

    // previous mark packet as sent
    service->sending = false;

    // if idle (possibly after an error), then only await for a transmission 
    if (service->transportState != U2F_SENDING_RESPONSE 
c0d026c8:	5c61      	ldrb	r1, [r4, r1]
        && service->transportState != U2F_SENDING_ERROR) {
c0d026ca:	1ec9      	subs	r1, r1, #3
c0d026cc:	b2c9      	uxtb	r1, r1
c0d026ce:	2901      	cmp	r1, #1
c0d026d0:	d81a      	bhi.n	c0d02708 <u2f_transport_sent+0x60>
c0d026d2:	4623      	mov	r3, r4
c0d026d4:	332a      	adds	r3, #42	; 0x2a
c0d026d6:	4626      	mov	r6, r4
c0d026d8:	3620      	adds	r6, #32
        // absorb the error, transport is erroneous but that won't hurt in the end.
        // also absorb the fake channel user presence check reply ack
        //THROW(INVALID_STATE);
        return;
    }
    if (service->transportOffset < service->transportLength) {
c0d026da:	8b21      	ldrh	r1, [r4, #24]
c0d026dc:	8ae2      	ldrh	r2, [r4, #22]
c0d026de:	4291      	cmp	r1, r2
c0d026e0:	d914      	bls.n	c0d0270c <u2f_transport_sent+0x64>
        uint16_t mtu = (media == U2F_MEDIA_USB) ? USB_SEGMENT_SIZE : BLE_SEGMENT_SIZE;
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
c0d026e2:	7ea0      	ldrb	r0, [r4, #26]
c0d026e4:	2800      	cmp	r0, #0
c0d026e6:	d01e      	beq.n	c0d02726 <u2f_transport_sent+0x7e>
c0d026e8:	2301      	movs	r3, #1
c0d026ea:	e01d      	b.n	c0d02728 <u2f_transport_sent+0x80>
c0d026ec:	2025      	movs	r0, #37	; 0x25
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d026ee:	5c20      	ldrb	r0, [r4, r0]
            && service->sending == false)
c0d026f0:	2806      	cmp	r0, #6
c0d026f2:	d106      	bne.n	c0d02702 <u2f_transport_sent+0x5a>
c0d026f4:	202b      	movs	r0, #43	; 0x2b
c0d026f6:	5c21      	ldrb	r1, [r4, r0]
c0d026f8:	2200      	movs	r2, #0
c0d026fa:	5422      	strb	r2, [r4, r0]
 * And a new message can be scheduled.
 */
void u2f_transport_sent(u2f_service_t* service, u2f_transport_media_t media) {

    // don't process when replying to anti timeout requests
    if (!u2f_message_repliable(service)) {
c0d026fc:	2900      	cmp	r1, #0
c0d026fe:	d103      	bne.n	c0d02708 <u2f_transport_sent+0x60>
c0d02700:	e7df      	b.n	c0d026c2 <u2f_transport_sent+0x1a>
c0d02702:	202b      	movs	r0, #43	; 0x2b
c0d02704:	2100      	movs	r1, #0
c0d02706:	5421      	strb	r1, [r4, r0]
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
    }
}
c0d02708:	b003      	add	sp, #12
c0d0270a:	bdf0      	pop	{r4, r5, r6, r7, pc}
        service->transportOffset += blockSize;
        service->transportPacketIndex++;
        u2f_io_send(G_io_usb_ep_buffer, dataSize, media);
    }
    // last part sent
    else if (service->transportOffset == service->transportLength) {
c0d0270c:	d1fc      	bne.n	c0d02708 <u2f_transport_sent+0x60>
c0d0270e:	2100      	movs	r1, #0
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d02710:	76a1      	strb	r1, [r4, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d02712:	82e1      	strh	r1, [r4, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d02714:	7001      	strb	r1, [r0, #0]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d02716:	7019      	strb	r1, [r3, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d02718:	80b1      	strh	r1, [r6, #4]
c0d0271a:	6031      	str	r1, [r6, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d0271c:	68e0      	ldr	r0, [r4, #12]
c0d0271e:	61e0      	str	r0, [r4, #28]
    }
    // last part sent
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
c0d02720:	4822      	ldr	r0, [pc, #136]	; (c0d027ac <u2f_transport_sent+0x104>)
c0d02722:	7001      	strb	r1, [r0, #0]
c0d02724:	e7f0      	b.n	c0d02708 <u2f_transport_sent+0x60>
c0d02726:	2303      	movs	r3, #3
        // also absorb the fake channel user presence check reply ack
        //THROW(INVALID_STATE);
        return;
    }
    if (service->transportOffset < service->transportLength) {
        uint16_t mtu = (media == U2F_MEDIA_USB) ? USB_SEGMENT_SIZE : BLE_SEGMENT_SIZE;
c0d02728:	1e6e      	subs	r6, r5, #1
c0d0272a:	4277      	negs	r7, r6
c0d0272c:	4177      	adcs	r7, r6
c0d0272e:	00be      	lsls	r6, r7, #2
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
c0d02730:	199b      	adds	r3, r3, r6
c0d02732:	2640      	movs	r6, #64	; 0x40
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
                                      (mtu - headerSize)
c0d02734:	1af7      	subs	r7, r6, r3
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
c0d02736:	1a89      	subs	r1, r1, r2
c0d02738:	42b9      	cmp	r1, r7
c0d0273a:	dc00      	bgt.n	c0d0273e <u2f_transport_sent+0x96>
c0d0273c:	460f      	mov	r7, r1
                                  ? (mtu - headerSize)
                                  : service->transportLength - service->transportOffset);
        uint16_t dataSize = blockSize + headerSize;
        uint16_t offset = 0;
        // Fragment
        if (media == U2F_MEDIA_USB) {
c0d0273e:	2d01      	cmp	r5, #1
c0d02740:	9602      	str	r6, [sp, #8]
c0d02742:	d109      	bne.n	c0d02758 <u2f_transport_sent+0xb0>
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d02744:	1d21      	adds	r1, r4, #4
c0d02746:	481a      	ldr	r0, [pc, #104]	; (c0d027b0 <u2f_transport_sent+0x108>)
c0d02748:	2604      	movs	r6, #4
c0d0274a:	4632      	mov	r2, r6
c0d0274c:	9301      	str	r3, [sp, #4]
c0d0274e:	f7fe fd82 	bl	c0d01256 <os_memmove>
c0d02752:	9b01      	ldr	r3, [sp, #4]
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
c0d02754:	7ea0      	ldrb	r0, [r4, #26]
c0d02756:	e000      	b.n	c0d0275a <u2f_transport_sent+0xb2>
c0d02758:	2600      	movs	r6, #0
c0d0275a:	2800      	cmp	r0, #0
c0d0275c:	d001      	beq.n	c0d02762 <u2f_transport_sent+0xba>
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
c0d0275e:	1e40      	subs	r0, r0, #1
c0d02760:	e009      	b.n	c0d02776 <u2f_transport_sent+0xce>
        if (media == U2F_MEDIA_USB) {
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
c0d02762:	9802      	ldr	r0, [sp, #8]
c0d02764:	5c20      	ldrb	r0, [r4, r0]
c0d02766:	4912      	ldr	r1, [pc, #72]	; (c0d027b0 <u2f_transport_sent+0x108>)
c0d02768:	5588      	strb	r0, [r1, r6]
c0d0276a:	2001      	movs	r0, #1
c0d0276c:	4330      	orrs	r0, r6
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
c0d0276e:	7e62      	ldrb	r2, [r4, #25]
c0d02770:	540a      	strb	r2, [r1, r0]
c0d02772:	1c46      	adds	r6, r0, #1
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
c0d02774:	7e20      	ldrb	r0, [r4, #24]
c0d02776:	18f9      	adds	r1, r7, r3
c0d02778:	9102      	str	r1, [sp, #8]
c0d0277a:	4a0d      	ldr	r2, [pc, #52]	; (c0d027b0 <u2f_transport_sent+0x108>)
c0d0277c:	5590      	strb	r0, [r2, r6]
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
c0d0277e:	69e1      	ldr	r1, [r4, #28]
c0d02780:	2900      	cmp	r1, #0
c0d02782:	d006      	beq.n	c0d02792 <u2f_transport_sent+0xea>
c0d02784:	b2be      	uxth	r6, r7
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d02786:	18d0      	adds	r0, r2, r3
                       service->transportBuffer + service->transportOffset, blockSize);
c0d02788:	8ae3      	ldrh	r3, [r4, #22]
c0d0278a:	18c9      	adds	r1, r1, r3
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d0278c:	4632      	mov	r2, r6
c0d0278e:	f7fe fd62 	bl	c0d01256 <os_memmove>
                       service->transportBuffer + service->transportOffset, blockSize);
        }
        service->transportOffset += blockSize;
c0d02792:	8ae0      	ldrh	r0, [r4, #22]
c0d02794:	19c0      	adds	r0, r0, r7
c0d02796:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d02798:	7ea0      	ldrb	r0, [r4, #26]
c0d0279a:	1c40      	adds	r0, r0, #1
c0d0279c:	76a0      	strb	r0, [r4, #26]
        u2f_io_send(G_io_usb_ep_buffer, dataSize, media);
c0d0279e:	9802      	ldr	r0, [sp, #8]
c0d027a0:	b281      	uxth	r1, r0
c0d027a2:	4803      	ldr	r0, [pc, #12]	; (c0d027b0 <u2f_transport_sent+0x108>)
c0d027a4:	462a      	mov	r2, r5
c0d027a6:	f7ff ff53 	bl	c0d02650 <u2f_io_send>
c0d027aa:	e7ad      	b.n	c0d02708 <u2f_transport_sent+0x60>
c0d027ac:	20001f48 	.word	0x20001f48
c0d027b0:	20001fb4 	.word	0x20001fb4

c0d027b4 <u2f_message_repliable>:
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
    }
}

bool u2f_message_repliable(u2f_service_t* service) {
c0d027b4:	212a      	movs	r1, #42	; 0x2a
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d027b6:	5c41      	ldrb	r1, [r0, r1]
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d027b8:	2900      	cmp	r1, #0
c0d027ba:	d00c      	beq.n	c0d027d6 <u2f_message_repliable+0x22>
c0d027bc:	2901      	cmp	r1, #1
c0d027be:	d008      	beq.n	c0d027d2 <u2f_message_repliable+0x1e>
c0d027c0:	2125      	movs	r1, #37	; 0x25
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d027c2:	5c41      	ldrb	r1, [r0, r1]
            && service->sending == false)
c0d027c4:	2906      	cmp	r1, #6
c0d027c6:	d104      	bne.n	c0d027d2 <u2f_message_repliable+0x1e>
c0d027c8:	212b      	movs	r1, #43	; 0x2b
c0d027ca:	5c41      	ldrb	r1, [r0, r1]
c0d027cc:	4248      	negs	r0, r1
c0d027ce:	4148      	adcs	r0, r1

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d027d0:	4770      	bx	lr
c0d027d2:	2000      	movs	r0, #0
c0d027d4:	4770      	bx	lr
c0d027d6:	2001      	movs	r0, #1
c0d027d8:	4770      	bx	lr
	...

c0d027dc <u2f_transport_send_usb_user_presence_required>:
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
    }
}

void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
c0d027dc:	b5b0      	push	{r4, r5, r7, lr}
c0d027de:	212b      	movs	r1, #43	; 0x2b
c0d027e0:	2401      	movs	r4, #1
    uint16_t offset = 0;
    service->sending = true;
c0d027e2:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d027e4:	1d01      	adds	r1, r0, #4
c0d027e6:	4d0a      	ldr	r5, [pc, #40]	; (c0d02810 <u2f_transport_send_usb_user_presence_required+0x34>)
c0d027e8:	2204      	movs	r2, #4
c0d027ea:	4628      	mov	r0, r5
c0d027ec:	f7fe fd33 	bl	c0d01256 <os_memmove>
c0d027f0:	2085      	movs	r0, #133	; 0x85
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 2;
    G_io_usb_ep_buffer[offset++] = 0x69;
    G_io_usb_ep_buffer[offset++] = 0x85;
c0d027f2:	7228      	strb	r0, [r5, #8]
c0d027f4:	2069      	movs	r0, #105	; 0x69
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 2;
    G_io_usb_ep_buffer[offset++] = 0x69;
c0d027f6:	71e8      	strb	r0, [r5, #7]
c0d027f8:	2002      	movs	r0, #2
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 2;
c0d027fa:	71a8      	strb	r0, [r5, #6]
c0d027fc:	2000      	movs	r0, #0
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
    G_io_usb_ep_buffer[offset++] = 0;
c0d027fe:	7168      	strb	r0, [r5, #5]
c0d02800:	2083      	movs	r0, #131	; 0x83
void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
c0d02802:	7128      	strb	r0, [r5, #4]
c0d02804:	2109      	movs	r1, #9
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 2;
    G_io_usb_ep_buffer[offset++] = 0x69;
    G_io_usb_ep_buffer[offset++] = 0x85;
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d02806:	4628      	mov	r0, r5
c0d02808:	4622      	mov	r2, r4
c0d0280a:	f7ff ff21 	bl	c0d02650 <u2f_io_send>
}
c0d0280e:	bdb0      	pop	{r4, r5, r7, pc}
c0d02810:	20001fb4 	.word	0x20001fb4

c0d02814 <u2f_transport_send_wink>:

void u2f_transport_send_wink(u2f_service_t *service) {
c0d02814:	b5b0      	push	{r4, r5, r7, lr}
c0d02816:	212b      	movs	r1, #43	; 0x2b
c0d02818:	2401      	movs	r4, #1
    uint16_t offset = 0;
    service->sending = true;
c0d0281a:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d0281c:	1d01      	adds	r1, r0, #4
c0d0281e:	4d08      	ldr	r5, [pc, #32]	; (c0d02840 <u2f_transport_send_wink+0x2c>)
c0d02820:	2204      	movs	r2, #4
c0d02822:	4628      	mov	r0, r5
c0d02824:	f7fe fd17 	bl	c0d01256 <os_memmove>
c0d02828:	2000      	movs	r0, #0
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_WINK;
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 0;
c0d0282a:	71a8      	strb	r0, [r5, #6]
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_WINK;
    G_io_usb_ep_buffer[offset++] = 0;
c0d0282c:	7168      	strb	r0, [r5, #5]
c0d0282e:	2088      	movs	r0, #136	; 0x88
void u2f_transport_send_wink(u2f_service_t *service) {
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_WINK;
c0d02830:	7128      	strb	r0, [r5, #4]
c0d02832:	2107      	movs	r1, #7
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 0;
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d02834:	4628      	mov	r0, r5
c0d02836:	4622      	mov	r2, r4
c0d02838:	f7ff ff0a 	bl	c0d02650 <u2f_io_send>
}
c0d0283c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0283e:	46c0      	nop			; (mov r8, r8)
c0d02840:	20001fb4 	.word	0x20001fb4

c0d02844 <u2f_transport_receive_fakeChannel>:

bool u2f_transport_receive_fakeChannel(u2f_service_t *service, uint8_t *buffer, uint16_t size) {
c0d02844:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02846:	b081      	sub	sp, #4
c0d02848:	4604      	mov	r4, r0
c0d0284a:	2025      	movs	r0, #37	; 0x25
    if (service->fakeChannelTransportState == U2F_INTERNAL_ERROR) {
c0d0284c:	5c20      	ldrb	r0, [r4, r0]
c0d0284e:	2805      	cmp	r0, #5
c0d02850:	d101      	bne.n	c0d02856 <u2f_transport_receive_fakeChannel+0x12>
c0d02852:	2500      	movs	r5, #0
c0d02854:	e065      	b.n	c0d02922 <u2f_transport_receive_fakeChannel+0xde>
c0d02856:	4626      	mov	r6, r4
c0d02858:	3625      	adds	r6, #37	; 0x25
        return false;
    }
    if (memcmp(service->channel, buffer, 4) != 0) {
c0d0285a:	7808      	ldrb	r0, [r1, #0]
c0d0285c:	784b      	ldrb	r3, [r1, #1]
c0d0285e:	021b      	lsls	r3, r3, #8
c0d02860:	1818      	adds	r0, r3, r0
c0d02862:	788b      	ldrb	r3, [r1, #2]
c0d02864:	78cd      	ldrb	r5, [r1, #3]
c0d02866:	022d      	lsls	r5, r5, #8
c0d02868:	18eb      	adds	r3, r5, r3
c0d0286a:	041b      	lsls	r3, r3, #16
c0d0286c:	1818      	adds	r0, r3, r0
c0d0286e:	7923      	ldrb	r3, [r4, #4]
c0d02870:	7965      	ldrb	r5, [r4, #5]
c0d02872:	022d      	lsls	r5, r5, #8
c0d02874:	18eb      	adds	r3, r5, r3
c0d02876:	79a5      	ldrb	r5, [r4, #6]
c0d02878:	79e7      	ldrb	r7, [r4, #7]
c0d0287a:	023f      	lsls	r7, r7, #8
c0d0287c:	197d      	adds	r5, r7, r5
c0d0287e:	042d      	lsls	r5, r5, #16
c0d02880:	18eb      	adds	r3, r5, r3
c0d02882:	4283      	cmp	r3, r0
c0d02884:	d150      	bne.n	c0d02928 <u2f_transport_receive_fakeChannel+0xe4>
c0d02886:	790b      	ldrb	r3, [r1, #4]
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
c0d02888:	8c60      	ldrh	r0, [r4, #34]	; 0x22
c0d0288a:	2800      	cmp	r0, #0
c0d0288c:	d013      	beq.n	c0d028b6 <u2f_transport_receive_fakeChannel+0x72>
c0d0288e:	2524      	movs	r5, #36	; 0x24
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
        service->fakeChannelTransportPacketIndex = 0;
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
c0d02890:	5d65      	ldrb	r5, [r4, r5]
c0d02892:	42ab      	cmp	r3, r5
c0d02894:	d148      	bne.n	c0d02928 <u2f_transport_receive_fakeChannel+0xe4>
c0d02896:	4625      	mov	r5, r4
c0d02898:	3524      	adds	r5, #36	; 0x24
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d0289a:	8b27      	ldrh	r7, [r4, #24]
        service->fakeChannelTransportPacketIndex++;
c0d0289c:	1c5b      	adds	r3, r3, #1
c0d0289e:	702b      	strb	r3, [r5, #0]
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d028a0:	1a3b      	subs	r3, r7, r0
c0d028a2:	1f52      	subs	r2, r2, #5
c0d028a4:	429a      	cmp	r2, r3
c0d028a6:	db00      	blt.n	c0d028aa <u2f_transport_receive_fakeChannel+0x66>
c0d028a8:	461a      	mov	r2, r3
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
c0d028aa:	1880      	adds	r0, r0, r2
c0d028ac:	8460      	strh	r0, [r4, #34]	; 0x22
c0d028ae:	b292      	uxth	r2, r2
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
c0d028b0:	8d20      	ldrh	r0, [r4, #40]	; 0x28
c0d028b2:	1d49      	adds	r1, r1, #5
c0d028b4:	e01e      	b.n	c0d028f4 <u2f_transport_receive_fakeChannel+0xb0>
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
        uint16_t commandLength = U2BE(buffer, 4+1) + U2F_COMMAND_HEADER_SIZE;
        // Some buggy implementations can send a WINK here, reply it gently
        if (buffer[4] == U2F_CMD_WINK) {
c0d028b6:	2b88      	cmp	r3, #136	; 0x88
c0d028b8:	d104      	bne.n	c0d028c4 <u2f_transport_receive_fakeChannel+0x80>
            u2f_transport_send_wink(service);
c0d028ba:	4620      	mov	r0, r4
c0d028bc:	f7ff ffaa 	bl	c0d02814 <u2f_transport_send_wink>
c0d028c0:	2501      	movs	r5, #1
c0d028c2:	e02e      	b.n	c0d02922 <u2f_transport_receive_fakeChannel+0xde>
            return true;
        }

        if (commandLength != service->transportLength) {
c0d028c4:	2b83      	cmp	r3, #131	; 0x83
c0d028c6:	d12f      	bne.n	c0d02928 <u2f_transport_receive_fakeChannel+0xe4>
c0d028c8:	7988      	ldrb	r0, [r1, #6]
c0d028ca:	794b      	ldrb	r3, [r1, #5]
c0d028cc:	021b      	lsls	r3, r3, #8
c0d028ce:	1818      	adds	r0, r3, r0
c0d028d0:	1cc0      	adds	r0, r0, #3
c0d028d2:	8b23      	ldrh	r3, [r4, #24]
c0d028d4:	b285      	uxth	r5, r0
c0d028d6:	42ab      	cmp	r3, r5
c0d028d8:	d126      	bne.n	c0d02928 <u2f_transport_receive_fakeChannel+0xe4>
c0d028da:	1d09      	adds	r1, r1, #4
c0d028dc:	b285      	uxth	r5, r0
c0d028de:	4b15      	ldr	r3, [pc, #84]	; (c0d02934 <u2f_transport_receive_fakeChannel+0xf0>)
c0d028e0:	2724      	movs	r7, #36	; 0x24
c0d028e2:	2000      	movs	r0, #0
        }
        if (buffer[4] != U2F_CMD_MSG) {
            goto error;
        }
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
        service->fakeChannelTransportPacketIndex = 0;
c0d028e4:	55e0      	strb	r0, [r4, r7]
            goto error;
        }
        if (buffer[4] != U2F_CMD_MSG) {
            goto error;
        }
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
c0d028e6:	1f12      	subs	r2, r2, #4
c0d028e8:	42aa      	cmp	r2, r5
c0d028ea:	db00      	blt.n	c0d028ee <u2f_transport_receive_fakeChannel+0xaa>
c0d028ec:	462a      	mov	r2, r5
c0d028ee:	8462      	strh	r2, [r4, #34]	; 0x22
        service->fakeChannelTransportPacketIndex = 0;
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
c0d028f0:	4013      	ands	r3, r2
c0d028f2:	461a      	mov	r2, r3
c0d028f4:	f7ff fc9c 	bl	c0d02230 <cx_crc16_update>
c0d028f8:	8520      	strh	r0, [r4, #40]	; 0x28
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
    }
    if (service->fakeChannelTransportOffset >= service->transportLength) {
c0d028fa:	8b21      	ldrh	r1, [r4, #24]
c0d028fc:	8c62      	ldrh	r2, [r4, #34]	; 0x22
c0d028fe:	2501      	movs	r5, #1
c0d02900:	428a      	cmp	r2, r1
c0d02902:	d30e      	bcc.n	c0d02922 <u2f_transport_receive_fakeChannel+0xde>
        if (service->fakeChannelCrc != service->commandCrc) {
c0d02904:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d02906:	4288      	cmp	r0, r1
c0d02908:	d10e      	bne.n	c0d02928 <u2f_transport_receive_fakeChannel+0xe4>
c0d0290a:	2006      	movs	r0, #6
            goto error;
        }
        service->fakeChannelTransportState = U2F_FAKE_RECEIVED;
c0d0290c:	7030      	strb	r0, [r6, #0]
c0d0290e:	2700      	movs	r7, #0
        service->fakeChannelTransportOffset = 0;
c0d02910:	8467      	strh	r7, [r4, #34]	; 0x22
c0d02912:	202a      	movs	r0, #42	; 0x2a
        // reply immediately when the asynch response is not yet ready
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d02914:	5c20      	ldrb	r0, [r4, r0]
c0d02916:	2801      	cmp	r0, #1
c0d02918:	d103      	bne.n	c0d02922 <u2f_transport_receive_fakeChannel+0xde>
            u2f_transport_send_usb_user_presence_required(service);
c0d0291a:	4620      	mov	r0, r4
c0d0291c:	f7ff ff5e 	bl	c0d027dc <u2f_transport_send_usb_user_presence_required>
            // response sent
            service->fakeChannelTransportState = U2F_IDLE;
c0d02920:	7037      	strb	r7, [r6, #0]
error:
    service->fakeChannelTransportState = U2F_INTERNAL_ERROR;
    // don't hesitate here, the user will have to exit/rerun the app otherwise.
    THROW(EXCEPTION_IO_RESET);
    return false;    
}
c0d02922:	4628      	mov	r0, r5
c0d02924:	b001      	add	sp, #4
c0d02926:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02928:	2005      	movs	r0, #5
            service->fakeChannelTransportState = U2F_IDLE;
        }
    }
    return true;
error:
    service->fakeChannelTransportState = U2F_INTERNAL_ERROR;
c0d0292a:	7030      	strb	r0, [r6, #0]
c0d0292c:	2010      	movs	r0, #16
    // don't hesitate here, the user will have to exit/rerun the app otherwise.
    THROW(EXCEPTION_IO_RESET);
c0d0292e:	f7fe fcc7 	bl	c0d012c0 <os_longjmp>
c0d02932:	46c0      	nop			; (mov r8, r8)
c0d02934:	0000ffff 	.word	0x0000ffff

c0d02938 <u2f_transport_received>:
/** 
 * Function that process every message received on a media.
 * Performs message concatenation when message is splitted.
 */
void u2f_transport_received(u2f_service_t *service, uint8_t *buffer,
                          uint16_t size, u2f_transport_media_t media) {
c0d02938:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0293a:	b087      	sub	sp, #28
c0d0293c:	4604      	mov	r4, r0
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
    uint16_t xfer_len;
    service->media = media;
c0d0293e:	7203      	strb	r3, [r0, #8]
c0d02940:	2020      	movs	r0, #32

    // Handle a busy channel and avoid reentry
    if (service->transportState == U2F_SENDING_RESPONSE) {
c0d02942:	5c20      	ldrb	r0, [r4, r0]
c0d02944:	4626      	mov	r6, r4
c0d02946:	3620      	adds	r6, #32
c0d02948:	2803      	cmp	r0, #3
c0d0294a:	d00a      	beq.n	c0d02962 <u2f_transport_received+0x2a>
c0d0294c:	460f      	mov	r7, r1
c0d0294e:	212a      	movs	r1, #42	; 0x2a
        u2f_transport_error(service, ERROR_CHANNEL_BUSY);
        goto error;
    }
    if (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_IDLE) {
c0d02950:	5c61      	ldrb	r1, [r4, r1]
c0d02952:	2900      	cmp	r1, #0
c0d02954:	d01a      	beq.n	c0d0298c <u2f_transport_received+0x54>
        if (!u2f_transport_receive_fakeChannel(service, buffer, size)) {
c0d02956:	4620      	mov	r0, r4
c0d02958:	4639      	mov	r1, r7
c0d0295a:	f7ff ff73 	bl	c0d02844 <u2f_transport_receive_fakeChannel>
c0d0295e:	2800      	cmp	r0, #0
c0d02960:	d112      	bne.n	c0d02988 <u2f_transport_received+0x50>
c0d02962:	48b8      	ldr	r0, [pc, #736]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02964:	2106      	movs	r1, #6
c0d02966:	7201      	strb	r1, [r0, #8]
c0d02968:	2104      	movs	r1, #4
c0d0296a:	7031      	strb	r1, [r6, #0]
c0d0296c:	2140      	movs	r1, #64	; 0x40
c0d0296e:	22bf      	movs	r2, #191	; 0xbf
c0d02970:	5462      	strb	r2, [r4, r1]
c0d02972:	3008      	adds	r0, #8
c0d02974:	61e0      	str	r0, [r4, #28]
c0d02976:	2000      	movs	r0, #0
c0d02978:	76a0      	strb	r0, [r4, #26]
c0d0297a:	2101      	movs	r1, #1
c0d0297c:	8321      	strh	r1, [r4, #24]
c0d0297e:	82e0      	strh	r0, [r4, #22]
c0d02980:	7a21      	ldrb	r1, [r4, #8]
c0d02982:	4620      	mov	r0, r4
c0d02984:	f7ff fe90 	bl	c0d026a8 <u2f_transport_sent>
        service->seqTimeout = 0;
        service->transportState = U2F_HANDLE_SEGMENTED;
    }
error:
    return;
}
c0d02988:	b007      	add	sp, #28
c0d0298a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0298c:	461d      	mov	r5, r3
c0d0298e:	4623      	mov	r3, r4
c0d02990:	332a      	adds	r3, #42	; 0x2a
        }
        return;
    }
    
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
c0d02992:	2804      	cmp	r0, #4
c0d02994:	d109      	bne.n	c0d029aa <u2f_transport_received+0x72>
c0d02996:	202b      	movs	r0, #43	; 0x2b
c0d02998:	2100      	movs	r1, #0
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d0299a:	5421      	strb	r1, [r4, r0]
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d0299c:	76a1      	strb	r1, [r4, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d0299e:	82e1      	strh	r1, [r4, #22]
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d029a0:	7019      	strb	r1, [r3, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d029a2:	80b1      	strh	r1, [r6, #4]
c0d029a4:	6031      	str	r1, [r6, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d029a6:	68e0      	ldr	r0, [r4, #12]
c0d029a8:	61e0      	str	r0, [r4, #28]
c0d029aa:	9306      	str	r3, [sp, #24]
 * Function that process every message received on a media.
 * Performs message concatenation when message is splitted.
 */
void u2f_transport_received(u2f_service_t *service, uint8_t *buffer,
                          uint16_t size, u2f_transport_media_t media) {
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
c0d029ac:	1e68      	subs	r0, r5, #1
c0d029ae:	4241      	negs	r1, r0
c0d029b0:	4141      	adcs	r1, r0
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
        u2f_transport_reset(service);
    }

    if (size < (1 + channelHeader)) {
c0d029b2:	008b      	lsls	r3, r1, #2
c0d029b4:	1c58      	adds	r0, r3, #1
c0d029b6:	4290      	cmp	r0, r2
c0d029b8:	d82c      	bhi.n	c0d02a14 <u2f_transport_received+0xdc>
c0d029ba:	9003      	str	r0, [sp, #12]
        // Message to short, abort
        u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
        goto error;
    }
    if (media == U2F_MEDIA_USB) {
c0d029bc:	2d01      	cmp	r5, #1
c0d029be:	d108      	bne.n	c0d029d2 <u2f_transport_received+0x9a>
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
c0d029c0:	1d20      	adds	r0, r4, #4
c0d029c2:	9205      	str	r2, [sp, #20]
c0d029c4:	2204      	movs	r2, #4
c0d029c6:	4639      	mov	r1, r7
c0d029c8:	9304      	str	r3, [sp, #16]
c0d029ca:	f7fe fc44 	bl	c0d01256 <os_memmove>
c0d029ce:	9b04      	ldr	r3, [sp, #16]
c0d029d0:	9a05      	ldr	r2, [sp, #20]
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d029d2:	8ae0      	ldrh	r0, [r4, #22]
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
c0d029d4:	2800      	cmp	r0, #0
c0d029d6:	d00d      	beq.n	c0d029f4 <u2f_transport_received+0xbc>
c0d029d8:	2d01      	cmp	r5, #1
c0d029da:	d117      	bne.n	c0d02a0c <u2f_transport_received+0xd4>
c0d029dc:	4620      	mov	r0, r4
c0d029de:	3012      	adds	r0, #18
c0d029e0:	1d21      	adds	r1, r4, #4
c0d029e2:	9205      	str	r2, [sp, #20]
c0d029e4:	2204      	movs	r2, #4
c0d029e6:	9304      	str	r3, [sp, #16]
c0d029e8:	f7fe fc54 	bl	c0d01294 <os_memcmp>
c0d029ec:	9b04      	ldr	r3, [sp, #16]
c0d029ee:	9a05      	ldr	r2, [sp, #20]
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d029f0:	2800      	cmp	r0, #0
c0d029f2:	d00b      	beq.n	c0d02a0c <u2f_transport_received+0xd4>
c0d029f4:	2103      	movs	r1, #3
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
        if (size < (channelHeader + 3)) {
c0d029f6:	4618      	mov	r0, r3
c0d029f8:	4308      	orrs	r0, r1
c0d029fa:	4290      	cmp	r0, r2
c0d029fc:	d80a      	bhi.n	c0d02a14 <u2f_transport_received+0xdc>
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        // check this is a command, cannot accept continuation without previous command
        if ((buffer[channelHeader+0]&U2F_MASK_COMMAND) == 0) {
c0d029fe:	56f8      	ldrsb	r0, [r7, r3]
c0d02a00:	2800      	cmp	r0, #0
c0d02a02:	db28      	blt.n	c0d02a56 <u2f_transport_received+0x11e>
c0d02a04:	488f      	ldr	r0, [pc, #572]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02a06:	2104      	movs	r1, #4
c0d02a08:	7201      	strb	r1, [r0, #8]
c0d02a0a:	e7ae      	b.n	c0d0296a <u2f_transport_received+0x32>
c0d02a0c:	2002      	movs	r0, #2
            service->transportPacketIndex = 0;
            os_memmove(service->transportChannel, service->channel, 4);
        }
    } else {
        // Continuation
        if (size < (channelHeader + 2)) {
c0d02a0e:	4318      	orrs	r0, r3
c0d02a10:	4290      	cmp	r0, r2
c0d02a12:	d902      	bls.n	c0d02a1a <u2f_transport_received+0xe2>
c0d02a14:	488b      	ldr	r0, [pc, #556]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02a16:	2185      	movs	r1, #133	; 0x85
c0d02a18:	e7a5      	b.n	c0d02966 <u2f_transport_received+0x2e>
c0d02a1a:	2021      	movs	r0, #33	; 0x21
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        if (media != service->transportMedia) {
c0d02a1c:	5c20      	ldrb	r0, [r4, r0]
c0d02a1e:	42a8      	cmp	r0, r5
c0d02a20:	d116      	bne.n	c0d02a50 <u2f_transport_received+0x118>
            // Mixed medias
            u2f_transport_error(service, ERROR_PROP_MEDIA_MIXED);
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
c0d02a22:	7830      	ldrb	r0, [r6, #0]
c0d02a24:	2801      	cmp	r0, #1
c0d02a26:	d146      	bne.n	c0d02ab6 <u2f_transport_received+0x17e>
            } else {
                u2f_transport_error(service, ERROR_INVALID_SEQ);
                goto error;
            }
        }
        if (media == U2F_MEDIA_USB) {
c0d02a28:	2d01      	cmp	r5, #1
c0d02a2a:	d152      	bne.n	c0d02ad2 <u2f_transport_received+0x19a>
            // Check the channel
            if (os_memcmp(buffer, service->channel, 4) != 0) {
c0d02a2c:	1d21      	adds	r1, r4, #4
c0d02a2e:	2004      	movs	r0, #4
c0d02a30:	9006      	str	r0, [sp, #24]
c0d02a32:	4638      	mov	r0, r7
c0d02a34:	9205      	str	r2, [sp, #20]
c0d02a36:	9a06      	ldr	r2, [sp, #24]
c0d02a38:	9304      	str	r3, [sp, #16]
c0d02a3a:	f7fe fc2b 	bl	c0d01294 <os_memcmp>
c0d02a3e:	9b04      	ldr	r3, [sp, #16]
c0d02a40:	9a05      	ldr	r2, [sp, #20]
c0d02a42:	2800      	cmp	r0, #0
c0d02a44:	d045      	beq.n	c0d02ad2 <u2f_transport_received+0x19a>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02a46:	487f      	ldr	r0, [pc, #508]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02a48:	2106      	movs	r1, #6
c0d02a4a:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02a4c:	9906      	ldr	r1, [sp, #24]
c0d02a4e:	e78c      	b.n	c0d0296a <u2f_transport_received+0x32>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02a50:	487c      	ldr	r0, [pc, #496]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02a52:	218d      	movs	r1, #141	; 0x8d
c0d02a54:	e787      	b.n	c0d02966 <u2f_transport_received+0x2e>
c0d02a56:	9102      	str	r1, [sp, #8]
c0d02a58:	18f8      	adds	r0, r7, r3
            goto error;
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
c0d02a5a:	9006      	str	r0, [sp, #24]
c0d02a5c:	2d01      	cmp	r5, #1
c0d02a5e:	d114      	bne.n	c0d02a8a <u2f_transport_received+0x152>
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d02a60:	7830      	ldrb	r0, [r6, #0]
c0d02a62:	2801      	cmp	r0, #1
c0d02a64:	d11a      	bne.n	c0d02a9c <u2f_transport_received+0x164>
                (os_memcmp(service->channel, service->transportChannel, 4) !=
c0d02a66:	1d20      	adds	r0, r4, #4
c0d02a68:	4621      	mov	r1, r4
c0d02a6a:	3112      	adds	r1, #18
c0d02a6c:	9205      	str	r2, [sp, #20]
c0d02a6e:	2204      	movs	r2, #4
c0d02a70:	9001      	str	r0, [sp, #4]
c0d02a72:	9304      	str	r3, [sp, #16]
c0d02a74:	f7fe fc0e 	bl	c0d01294 <os_memcmp>
c0d02a78:	9b04      	ldr	r3, [sp, #16]
c0d02a7a:	9a05      	ldr	r2, [sp, #20]
                 0) &&
c0d02a7c:	2800      	cmp	r0, #0
c0d02a7e:	d004      	beq.n	c0d02a8a <u2f_transport_received+0x152>
                (buffer[channelHeader] != U2F_CMD_INIT)) {
c0d02a80:	9806      	ldr	r0, [sp, #24]
c0d02a82:	7800      	ldrb	r0, [r0, #0]
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d02a84:	2886      	cmp	r0, #134	; 0x86
c0d02a86:	d000      	beq.n	c0d02a8a <u2f_transport_received+0x152>
c0d02a88:	e0c3      	b.n	c0d02c12 <u2f_transport_received+0x2da>
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d02a8a:	7830      	ldrb	r0, [r6, #0]
c0d02a8c:	2801      	cmp	r0, #1
c0d02a8e:	d105      	bne.n	c0d02a9c <u2f_transport_received+0x164>
            !((media == U2F_MEDIA_USB) &&
c0d02a90:	2d01      	cmp	r5, #1
c0d02a92:	d1b7      	bne.n	c0d02a04 <u2f_transport_received+0xcc>
              (buffer[channelHeader] == U2F_CMD_INIT))) {
c0d02a94:	9806      	ldr	r0, [sp, #24]
c0d02a96:	7800      	ldrb	r0, [r0, #0]
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d02a98:	2886      	cmp	r0, #134	; 0x86
c0d02a9a:	d1b3      	bne.n	c0d02a04 <u2f_transport_received+0xcc>
c0d02a9c:	9903      	ldr	r1, [sp, #12]
            // Unexpected continuation at this stage, abort
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        // Check the length
        uint16_t commandLength = U2BE(buffer, channelHeader + 1);
c0d02a9e:	1878      	adds	r0, r7, r1
c0d02aa0:	7840      	ldrb	r0, [r0, #1]
c0d02aa2:	5c79      	ldrb	r1, [r7, r1]
c0d02aa4:	0209      	lsls	r1, r1, #8
c0d02aa6:	180f      	adds	r7, r1, r0
        if (commandLength > (service->transportReceiveBufferLength - 3)) {
c0d02aa8:	8a20      	ldrh	r0, [r4, #16]
c0d02aaa:	1ec0      	subs	r0, r0, #3
c0d02aac:	4287      	cmp	r7, r0
c0d02aae:	dd35      	ble.n	c0d02b1c <u2f_transport_received+0x1e4>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02ab0:	4864      	ldr	r0, [pc, #400]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02ab2:	9902      	ldr	r1, [sp, #8]
c0d02ab4:	e757      	b.n	c0d02966 <u2f_transport_received+0x2e>
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
            // Unexpected continuation at this stage, abort
            // TODO : review the behavior is HID only
            if (media == U2F_MEDIA_USB) {
c0d02ab6:	2d01      	cmp	r5, #1
c0d02ab8:	d1a4      	bne.n	c0d02a04 <u2f_transport_received+0xcc>
c0d02aba:	202b      	movs	r0, #43	; 0x2b
c0d02abc:	2100      	movs	r1, #0
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d02abe:	5421      	strb	r1, [r4, r0]
// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d02ac0:	76a1      	strb	r1, [r4, #26]
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d02ac2:	82e1      	strh	r1, [r4, #22]
    service->transportPacketIndex = 0;
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d02ac4:	9806      	ldr	r0, [sp, #24]
c0d02ac6:	7001      	strb	r1, [r0, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d02ac8:	80b1      	strh	r1, [r6, #4]
c0d02aca:	6031      	str	r1, [r6, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d02acc:	68e0      	ldr	r0, [r4, #12]
c0d02ace:	61e0      	str	r0, [r4, #28]
c0d02ad0:	e75a      	b.n	c0d02988 <u2f_transport_received+0x50>
                u2f_transport_error(service, ERROR_CHANNEL_BUSY);
                goto error;
            }
        }
        // also discriminate invalid command sent instead of a continuation
        if (buffer[channelHeader] != service->transportPacketIndex) {
c0d02ad2:	5cf8      	ldrb	r0, [r7, r3]
c0d02ad4:	7ea1      	ldrb	r1, [r4, #26]
c0d02ad6:	4288      	cmp	r0, r1
c0d02ad8:	d194      	bne.n	c0d02a04 <u2f_transport_received+0xcc>
c0d02ada:	18f9      	adds	r1, r7, r3
            // Bad continuation packet, abort
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        xfer_len = MIN(size - (channelHeader + 1), service->transportLength - service->transportOffset);
c0d02adc:	9803      	ldr	r0, [sp, #12]
c0d02ade:	1a17      	subs	r7, r2, r0
c0d02ae0:	8ae0      	ldrh	r0, [r4, #22]
c0d02ae2:	8b22      	ldrh	r2, [r4, #24]
c0d02ae4:	1a12      	subs	r2, r2, r0
c0d02ae6:	4297      	cmp	r7, r2
c0d02ae8:	db00      	blt.n	c0d02aec <u2f_transport_received+0x1b4>
c0d02aea:	4617      	mov	r7, r2
        os_memmove(service->transportBuffer + service->transportOffset, buffer + channelHeader + 1, xfer_len);
c0d02aec:	b2ba      	uxth	r2, r7
c0d02aee:	69e3      	ldr	r3, [r4, #28]
c0d02af0:	1818      	adds	r0, r3, r0
c0d02af2:	1c49      	adds	r1, r1, #1
c0d02af4:	9206      	str	r2, [sp, #24]
c0d02af6:	f7fe fbae 	bl	c0d01256 <os_memmove>
        if (media == U2F_MEDIA_USB) {
c0d02afa:	2d01      	cmp	r5, #1
c0d02afc:	d107      	bne.n	c0d02b0e <u2f_transport_received+0x1d6>
            service->commandCrc = cx_crc16_update(service->commandCrc, service->transportBuffer + service->transportOffset, xfer_len);
c0d02afe:	8ae0      	ldrh	r0, [r4, #22]
c0d02b00:	69e1      	ldr	r1, [r4, #28]
c0d02b02:	1809      	adds	r1, r1, r0
c0d02b04:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d02b06:	9a06      	ldr	r2, [sp, #24]
c0d02b08:	f7ff fb92 	bl	c0d02230 <cx_crc16_update>
c0d02b0c:	84e0      	strh	r0, [r4, #38]	; 0x26
        }        
        service->transportOffset += xfer_len;
c0d02b0e:	8ae0      	ldrh	r0, [r4, #22]
c0d02b10:	19c0      	adds	r0, r0, r7
c0d02b12:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d02b14:	7ea0      	ldrb	r0, [r4, #26]
c0d02b16:	1c40      	adds	r0, r0, #1
c0d02b18:	76a0      	strb	r0, [r4, #26]
c0d02b1a:	e054      	b.n	c0d02bc6 <u2f_transport_received+0x28e>
            // Overflow in message size, abort
            u2f_transport_error(service, ERROR_INVALID_LEN);
            goto error;
        }
        // Check if the command is supported
        switch (buffer[channelHeader]) {
c0d02b1c:	9806      	ldr	r0, [sp, #24]
c0d02b1e:	7800      	ldrb	r0, [r0, #0]
c0d02b20:	2881      	cmp	r0, #129	; 0x81
c0d02b22:	d003      	beq.n	c0d02b2c <u2f_transport_received+0x1f4>
c0d02b24:	2886      	cmp	r0, #134	; 0x86
c0d02b26:	d01c      	beq.n	c0d02b62 <u2f_transport_received+0x22a>
c0d02b28:	2883      	cmp	r0, #131	; 0x83
c0d02b2a:	d15f      	bne.n	c0d02bec <u2f_transport_received+0x2b4>
c0d02b2c:	9304      	str	r3, [sp, #16]
c0d02b2e:	9205      	str	r2, [sp, #20]
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
c0d02b30:	2d01      	cmp	r5, #1
c0d02b32:	d123      	bne.n	c0d02b7c <u2f_transport_received+0x244>
                if (u2f_is_channel_broadcast(service->channel) ||
c0d02b34:	1d20      	adds	r0, r4, #4
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d02b36:	4944      	ldr	r1, [pc, #272]	; (c0d02c48 <u2f_transport_received+0x310>)
c0d02b38:	4479      	add	r1, pc
c0d02b3a:	2204      	movs	r2, #4
c0d02b3c:	9003      	str	r0, [sp, #12]
c0d02b3e:	9202      	str	r2, [sp, #8]
c0d02b40:	f7fe fba8 	bl	c0d01294 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d02b44:	2800      	cmp	r0, #0
c0d02b46:	d007      	beq.n	c0d02b58 <u2f_transport_received+0x220>
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d02b48:	4940      	ldr	r1, [pc, #256]	; (c0d02c4c <u2f_transport_received+0x314>)
c0d02b4a:	4479      	add	r1, pc
c0d02b4c:	2204      	movs	r2, #4
c0d02b4e:	9803      	ldr	r0, [sp, #12]
c0d02b50:	f7fe fba0 	bl	c0d01294 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d02b54:	2800      	cmp	r0, #0
c0d02b56:	d111      	bne.n	c0d02b7c <u2f_transport_received+0x244>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02b58:	483a      	ldr	r0, [pc, #232]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02b5a:	210b      	movs	r1, #11
c0d02b5c:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02b5e:	9902      	ldr	r1, [sp, #8]
c0d02b60:	e703      	b.n	c0d0296a <u2f_transport_received+0x32>
                }
            }
            // no channel for BLE
            break;
        case U2F_CMD_INIT:
            if (media != U2F_MEDIA_USB) {
c0d02b62:	2d01      	cmp	r5, #1
c0d02b64:	d142      	bne.n	c0d02bec <u2f_transport_received+0x2b4>
c0d02b66:	9304      	str	r3, [sp, #16]
c0d02b68:	9205      	str	r2, [sp, #20]
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d02b6a:	1d20      	adds	r0, r4, #4
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d02b6c:	4938      	ldr	r1, [pc, #224]	; (c0d02c50 <u2f_transport_received+0x318>)
c0d02b6e:	4479      	add	r1, pc
c0d02b70:	2204      	movs	r2, #4
c0d02b72:	9203      	str	r2, [sp, #12]
c0d02b74:	f7fe fb8e 	bl	c0d01294 <os_memcmp>
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d02b78:	2800      	cmp	r0, #0
c0d02b7a:	d05d      	beq.n	c0d02c38 <u2f_transport_received+0x300>
        }

        // Ok, initialize the buffer
        //if (buffer[channelHeader] != U2F_CMD_INIT) 
        {
            xfer_len = MIN(size - (channelHeader), U2F_COMMAND_HEADER_SIZE+commandLength);
c0d02b7c:	9805      	ldr	r0, [sp, #20]
c0d02b7e:	9904      	ldr	r1, [sp, #16]
c0d02b80:	1a40      	subs	r0, r0, r1
c0d02b82:	1cf9      	adds	r1, r7, #3
c0d02b84:	4288      	cmp	r0, r1
c0d02b86:	db00      	blt.n	c0d02b8a <u2f_transport_received+0x252>
c0d02b88:	4608      	mov	r0, r1
c0d02b8a:	9104      	str	r1, [sp, #16]
c0d02b8c:	9005      	str	r0, [sp, #20]
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
c0d02b8e:	b287      	uxth	r7, r0
c0d02b90:	69e0      	ldr	r0, [r4, #28]
c0d02b92:	9906      	ldr	r1, [sp, #24]
c0d02b94:	463a      	mov	r2, r7
c0d02b96:	f7fe fb5e 	bl	c0d01256 <os_memmove>
            if (media == U2F_MEDIA_USB) {
c0d02b9a:	2d01      	cmp	r5, #1
c0d02b9c:	d105      	bne.n	c0d02baa <u2f_transport_received+0x272>
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
c0d02b9e:	69e1      	ldr	r1, [r4, #28]
c0d02ba0:	2000      	movs	r0, #0
c0d02ba2:	463a      	mov	r2, r7
c0d02ba4:	f7ff fb44 	bl	c0d02230 <cx_crc16_update>
c0d02ba8:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d02baa:	2021      	movs	r0, #33	; 0x21
            }
            service->transportOffset = xfer_len;
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
            service->transportMedia = media;
c0d02bac:	5425      	strb	r5, [r4, r0]
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
            if (media == U2F_MEDIA_USB) {
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
            }
            service->transportOffset = xfer_len;
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
c0d02bae:	9804      	ldr	r0, [sp, #16]
c0d02bb0:	8320      	strh	r0, [r4, #24]
            xfer_len = MIN(size - (channelHeader), U2F_COMMAND_HEADER_SIZE+commandLength);
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
            if (media == U2F_MEDIA_USB) {
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
            }
            service->transportOffset = xfer_len;
c0d02bb2:	9805      	ldr	r0, [sp, #20]
c0d02bb4:	82e0      	strh	r0, [r4, #22]
c0d02bb6:	2000      	movs	r0, #0
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
            service->transportMedia = media;
            // initialize the response
            service->transportPacketIndex = 0;
c0d02bb8:	76a0      	strb	r0, [r4, #26]
            os_memmove(service->transportChannel, service->channel, 4);
c0d02bba:	4620      	mov	r0, r4
c0d02bbc:	3012      	adds	r0, #18
c0d02bbe:	1d21      	adds	r1, r4, #4
c0d02bc0:	2204      	movs	r2, #4
c0d02bc2:	f7fe fb48 	bl	c0d01256 <os_memmove>
c0d02bc6:	8ae0      	ldrh	r0, [r4, #22]
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d02bc8:	2d01      	cmp	r5, #1
c0d02bca:	d101      	bne.n	c0d02bd0 <u2f_transport_received+0x298>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
c0d02bcc:	8b21      	ldrh	r1, [r4, #24]
c0d02bce:	e006      	b.n	c0d02bde <u2f_transport_received+0x2a6>
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
c0d02bd0:	8b21      	ldrh	r1, [r4, #24]
c0d02bd2:	1cca      	adds	r2, r1, #3
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d02bd4:	4282      	cmp	r2, r0
c0d02bd6:	d202      	bcs.n	c0d02bde <u2f_transport_received+0x2a6>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02bd8:	481a      	ldr	r0, [pc, #104]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02bda:	2103      	movs	r1, #3
c0d02bdc:	e6c3      	b.n	c0d02966 <u2f_transport_received+0x2e>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
c0d02bde:	4288      	cmp	r0, r1
c0d02be0:	d211      	bcs.n	c0d02c06 <u2f_transport_received+0x2ce>
c0d02be2:	2000      	movs	r0, #0
        service->transportState = U2F_PROCESSING_COMMAND;
        // internal notification of a complete message received
        u2f_message_complete(service);
    } else {
        // new segment received, reset the timeout for the current piece
        service->seqTimeout = 0;
c0d02be4:	6360      	str	r0, [r4, #52]	; 0x34
c0d02be6:	2001      	movs	r0, #1
        service->transportState = U2F_HANDLE_SEGMENTED;
c0d02be8:	7030      	strb	r0, [r6, #0]
c0d02bea:	e6cd      	b.n	c0d02988 <u2f_transport_received+0x50>
c0d02bec:	4815      	ldr	r0, [pc, #84]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02bee:	2101      	movs	r1, #1
c0d02bf0:	7201      	strb	r1, [r0, #8]
c0d02bf2:	2204      	movs	r2, #4
c0d02bf4:	7032      	strb	r2, [r6, #0]
c0d02bf6:	2240      	movs	r2, #64	; 0x40
c0d02bf8:	23bf      	movs	r3, #191	; 0xbf
c0d02bfa:	54a3      	strb	r3, [r4, r2]
c0d02bfc:	3008      	adds	r0, #8
c0d02bfe:	61e0      	str	r0, [r4, #28]
c0d02c00:	2000      	movs	r0, #0
c0d02c02:	76a0      	strb	r0, [r4, #26]
c0d02c04:	e6ba      	b.n	c0d0297c <u2f_transport_received+0x44>
c0d02c06:	2002      	movs	r0, #2
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
        // switch before the handler gets the opportunity to change it again
        service->transportState = U2F_PROCESSING_COMMAND;
c0d02c08:	7030      	strb	r0, [r6, #0]
        // internal notification of a complete message received
        u2f_message_complete(service);
c0d02c0a:	4620      	mov	r0, r4
c0d02c0c:	f7ff fd02 	bl	c0d02614 <u2f_message_complete>
c0d02c10:	e6ba      	b.n	c0d02988 <u2f_transport_received+0x50>
                // special error case, we reply but don't change the current state of the transport (ongoing message for example)
                //u2f_transport_error_no_reset(service, ERROR_CHANNEL_BUSY);
                uint16_t offset = 0;
                // Fragment
                if (media == U2F_MEDIA_USB) {
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d02c12:	4c0c      	ldr	r4, [pc, #48]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02c14:	2204      	movs	r2, #4
c0d02c16:	4620      	mov	r0, r4
c0d02c18:	9901      	ldr	r1, [sp, #4]
c0d02c1a:	f7fe fb1c 	bl	c0d01256 <os_memmove>
c0d02c1e:	2006      	movs	r0, #6
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
                G_io_usb_ep_buffer[offset++] = 0;
                G_io_usb_ep_buffer[offset++] = 1;
                G_io_usb_ep_buffer[offset++] = ERROR_CHANNEL_BUSY;
c0d02c20:	71e0      	strb	r0, [r4, #7]
c0d02c22:	2201      	movs	r2, #1
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
                G_io_usb_ep_buffer[offset++] = 0;
                G_io_usb_ep_buffer[offset++] = 1;
c0d02c24:	71a2      	strb	r2, [r4, #6]
c0d02c26:	2000      	movs	r0, #0
                if (media == U2F_MEDIA_USB) {
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
                G_io_usb_ep_buffer[offset++] = 0;
c0d02c28:	7160      	strb	r0, [r4, #5]
c0d02c2a:	20bf      	movs	r0, #191	; 0xbf
                // Fragment
                if (media == U2F_MEDIA_USB) {
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
c0d02c2c:	7120      	strb	r0, [r4, #4]
c0d02c2e:	2108      	movs	r1, #8
                G_io_usb_ep_buffer[offset++] = 0;
                G_io_usb_ep_buffer[offset++] = 1;
                G_io_usb_ep_buffer[offset++] = ERROR_CHANNEL_BUSY;
                u2f_io_send(G_io_usb_ep_buffer, offset, media);
c0d02c30:	4620      	mov	r0, r4
c0d02c32:	f7ff fd0d 	bl	c0d02650 <u2f_io_send>
c0d02c36:	e6a7      	b.n	c0d02988 <u2f_transport_received+0x50>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d02c38:	4802      	ldr	r0, [pc, #8]	; (c0d02c44 <u2f_transport_received+0x30c>)
c0d02c3a:	210b      	movs	r1, #11
c0d02c3c:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d02c3e:	9903      	ldr	r1, [sp, #12]
c0d02c40:	e693      	b.n	c0d0296a <u2f_transport_received+0x32>
c0d02c42:	46c0      	nop			; (mov r8, r8)
c0d02c44:	20001fb4 	.word	0x20001fb4
c0d02c48:	00001ddb 	.word	0x00001ddb
c0d02c4c:	00001dcd 	.word	0x00001dcd
c0d02c50:	00001da9 	.word	0x00001da9

c0d02c54 <u2f_is_channel_broadcast>:
    }
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
c0d02c54:	b580      	push	{r7, lr}
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d02c56:	4904      	ldr	r1, [pc, #16]	; (c0d02c68 <u2f_is_channel_broadcast+0x14>)
c0d02c58:	4479      	add	r1, pc
c0d02c5a:	2204      	movs	r2, #4
c0d02c5c:	f7fe fb1a 	bl	c0d01294 <os_memcmp>
c0d02c60:	4241      	negs	r1, r0
c0d02c62:	4148      	adcs	r0, r1
c0d02c64:	bd80      	pop	{r7, pc}
c0d02c66:	46c0      	nop			; (mov r8, r8)
c0d02c68:	00001cbb 	.word	0x00001cbb

c0d02c6c <u2f_message_set_autoreply_wait_user_presence>:
}

/**
 * Auto reply hodl until the real reply is prepared and sent
 */
void u2f_message_set_autoreply_wait_user_presence(u2f_service_t* service, bool enabled) {
c0d02c6c:	b580      	push	{r7, lr}
c0d02c6e:	222a      	movs	r2, #42	; 0x2a
c0d02c70:	5c83      	ldrb	r3, [r0, r2]
c0d02c72:	4602      	mov	r2, r0
c0d02c74:	322a      	adds	r2, #42	; 0x2a

    if (enabled) {
c0d02c76:	2900      	cmp	r1, #0
c0d02c78:	d006      	beq.n	c0d02c88 <u2f_message_set_autoreply_wait_user_presence+0x1c>
        // start replying placeholder until user presence validated
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE) {
c0d02c7a:	2b00      	cmp	r3, #0
c0d02c7c:	d108      	bne.n	c0d02c90 <u2f_message_set_autoreply_wait_user_presence+0x24>
c0d02c7e:	2101      	movs	r1, #1
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
c0d02c80:	7011      	strb	r1, [r2, #0]
            u2f_transport_send_usb_user_presence_required(service);
c0d02c82:	f7ff fdab 	bl	c0d027dc <u2f_transport_send_usb_user_presence_required>
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
    }
}
c0d02c86:	bd80      	pop	{r7, pc}
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
            u2f_transport_send_usb_user_presence_required(service);
        }
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d02c88:	2b01      	cmp	r3, #1
c0d02c8a:	d101      	bne.n	c0d02c90 <u2f_message_set_autoreply_wait_user_presence+0x24>
c0d02c8c:	2002      	movs	r0, #2
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
c0d02c8e:	7010      	strb	r0, [r2, #0]
    }
}
c0d02c90:	bd80      	pop	{r7, pc}
	...

c0d02c94 <u2f_message_reply>:
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
            && service->sending == false)
        ;
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {
c0d02c94:	b570      	push	{r4, r5, r6, lr}
c0d02c96:	4604      	mov	r4, r0
c0d02c98:	202a      	movs	r0, #42	; 0x2a

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d02c9a:	5c20      	ldrb	r0, [r4, r0]
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d02c9c:	2800      	cmp	r0, #0
c0d02c9e:	d009      	beq.n	c0d02cb4 <u2f_message_reply+0x20>
c0d02ca0:	2801      	cmp	r0, #1
c0d02ca2:	d029      	beq.n	c0d02cf8 <u2f_message_reply+0x64>
c0d02ca4:	2025      	movs	r0, #37	; 0x25
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d02ca6:	5c20      	ldrb	r0, [r4, r0]
            && service->sending == false)
c0d02ca8:	2806      	cmp	r0, #6
c0d02caa:	d125      	bne.n	c0d02cf8 <u2f_message_reply+0x64>
c0d02cac:	202b      	movs	r0, #43	; 0x2b
c0d02cae:	5c20      	ldrb	r0, [r4, r0]
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {

    // if U2F is not ready to reply, then gently avoid replying
    if (u2f_message_repliable(service)) 
c0d02cb0:	2800      	cmp	r0, #0
c0d02cb2:	d121      	bne.n	c0d02cf8 <u2f_message_reply+0x64>
c0d02cb4:	2020      	movs	r0, #32
c0d02cb6:	2503      	movs	r5, #3
    {
        service->transportState = U2F_SENDING_RESPONSE;
c0d02cb8:	5425      	strb	r5, [r4, r0]
c0d02cba:	2040      	movs	r0, #64	; 0x40
        service->transportPacketIndex = 0;
        service->transportBuffer = buffer;
        service->transportOffset = 0;
        service->transportLength = len;
        service->sendCmd = cmd;
c0d02cbc:	5421      	strb	r1, [r4, r0]
    // if U2F is not ready to reply, then gently avoid replying
    if (u2f_message_repliable(service)) 
    {
        service->transportState = U2F_SENDING_RESPONSE;
        service->transportPacketIndex = 0;
        service->transportBuffer = buffer;
c0d02cbe:	61e2      	str	r2, [r4, #28]
c0d02cc0:	2000      	movs	r0, #0

    // if U2F is not ready to reply, then gently avoid replying
    if (u2f_message_repliable(service)) 
    {
        service->transportState = U2F_SENDING_RESPONSE;
        service->transportPacketIndex = 0;
c0d02cc2:	76a0      	strb	r0, [r4, #26]
        service->transportBuffer = buffer;
        service->transportOffset = 0;
        service->transportLength = len;
c0d02cc4:	8323      	strh	r3, [r4, #24]
    if (u2f_message_repliable(service)) 
    {
        service->transportState = U2F_SENDING_RESPONSE;
        service->transportPacketIndex = 0;
        service->transportBuffer = buffer;
        service->transportOffset = 0;
c0d02cc6:	82e0      	strh	r0, [r4, #22]
c0d02cc8:	2021      	movs	r0, #33	; 0x21
        service->transportLength = len;
        service->sendCmd = cmd;
        if (service->transportMedia != U2F_MEDIA_BLE) {
c0d02cca:	5c21      	ldrb	r1, [r4, r0]
c0d02ccc:	2903      	cmp	r1, #3
c0d02cce:	d114      	bne.n	c0d02cfa <u2f_message_reply+0x66>
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
        }
        else {
            while (G_io_app.apdu_state != APDU_IDLE) {
c0d02cd0:	4d0c      	ldr	r5, [pc, #48]	; (c0d02d04 <u2f_message_reply+0x70>)
c0d02cd2:	7828      	ldrb	r0, [r5, #0]
c0d02cd4:	2800      	cmp	r0, #0
c0d02cd6:	d00f      	beq.n	c0d02cf8 <u2f_message_reply+0x64>
c0d02cd8:	2103      	movs	r1, #3
                u2f_transport_sent(service, service->transportMedia);       
c0d02cda:	4620      	mov	r0, r4
c0d02cdc:	f7ff fce4 	bl	c0d026a8 <u2f_transport_sent>
        if (service->transportMedia != U2F_MEDIA_BLE) {
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
        }
        else {
            while (G_io_app.apdu_state != APDU_IDLE) {
c0d02ce0:	7828      	ldrb	r0, [r5, #0]
c0d02ce2:	2800      	cmp	r0, #0
c0d02ce4:	d008      	beq.n	c0d02cf8 <u2f_message_reply+0x64>
c0d02ce6:	4626      	mov	r6, r4
c0d02ce8:	3621      	adds	r6, #33	; 0x21
                u2f_transport_sent(service, service->transportMedia);       
c0d02cea:	7831      	ldrb	r1, [r6, #0]
c0d02cec:	4620      	mov	r0, r4
c0d02cee:	f7ff fcdb 	bl	c0d026a8 <u2f_transport_sent>
        if (service->transportMedia != U2F_MEDIA_BLE) {
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
        }
        else {
            while (G_io_app.apdu_state != APDU_IDLE) {
c0d02cf2:	7828      	ldrb	r0, [r5, #0]
c0d02cf4:	2800      	cmp	r0, #0
c0d02cf6:	d1f8      	bne.n	c0d02cea <u2f_message_reply+0x56>
                u2f_transport_sent(service, service->transportMedia);       
            }
        }
    }
}
c0d02cf8:	bd70      	pop	{r4, r5, r6, pc}
        service->transportOffset = 0;
        service->transportLength = len;
        service->sendCmd = cmd;
        if (service->transportMedia != U2F_MEDIA_BLE) {
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
c0d02cfa:	4620      	mov	r0, r4
c0d02cfc:	f7ff fcd4 	bl	c0d026a8 <u2f_transport_sent>
            while (G_io_app.apdu_state != APDU_IDLE) {
                u2f_transport_sent(service, service->transportMedia);       
            }
        }
    }
}
c0d02d00:	bd70      	pop	{r4, r5, r6, pc}
c0d02d02:	46c0      	nop			; (mov r8, r8)
c0d02d04:	20001f48 	.word	0x20001f48

c0d02d08 <USBD_LL_Init>:
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
  ep_out_stall = 0;
c0d02d08:	4902      	ldr	r1, [pc, #8]	; (c0d02d14 <USBD_LL_Init+0xc>)
c0d02d0a:	2000      	movs	r0, #0
c0d02d0c:	6008      	str	r0, [r1, #0]
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d02d0e:	4902      	ldr	r1, [pc, #8]	; (c0d02d18 <USBD_LL_Init+0x10>)
c0d02d10:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
  return USBD_OK;
c0d02d12:	4770      	bx	lr
c0d02d14:	2000200c 	.word	0x2000200c
c0d02d18:	20002008 	.word	0x20002008

c0d02d1c <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d02d1c:	b510      	push	{r4, lr}
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02d1e:	4807      	ldr	r0, [pc, #28]	; (c0d02d3c <USBD_LL_DeInit+0x20>)
c0d02d20:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 1;
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02d22:	70c1      	strb	r1, [r0, #3]
c0d02d24:	2101      	movs	r1, #1
{
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d02d26:	7081      	strb	r1, [r0, #2]
c0d02d28:	2400      	movs	r4, #0
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02d2a:	7044      	strb	r4, [r0, #1]
c0d02d2c:	214f      	movs	r1, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02d2e:	7001      	strb	r1, [r0, #0]
c0d02d30:	2104      	movs	r1, #4
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 1;
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d02d32:	f7ff faf5 	bl	c0d02320 <io_seph_send>

  return USBD_OK; 
c0d02d36:	4620      	mov	r0, r4
c0d02d38:	bd10      	pop	{r4, pc}
c0d02d3a:	46c0      	nop			; (mov r8, r8)
c0d02d3c:	20001d74 	.word	0x20001d74

c0d02d40 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d02d40:	b570      	push	{r4, r5, r6, lr}
c0d02d42:	b082      	sub	sp, #8
c0d02d44:	466d      	mov	r5, sp
c0d02d46:	2400      	movs	r4, #0
  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = 0;
c0d02d48:	712c      	strb	r4, [r5, #4]
c0d02d4a:	2003      	movs	r0, #3

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02d4c:	70e8      	strb	r0, [r5, #3]
c0d02d4e:	2002      	movs	r0, #2
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
c0d02d50:	70a8      	strb	r0, [r5, #2]
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02d52:	706c      	strb	r4, [r5, #1]
c0d02d54:	264f      	movs	r6, #79	; 0x4f
{
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02d56:	702e      	strb	r6, [r5, #0]
c0d02d58:	2105      	movs	r1, #5
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = 0;
  io_seproxyhal_spi_send(buffer, 5);
c0d02d5a:	4628      	mov	r0, r5
c0d02d5c:	f7ff fae0 	bl	c0d02320 <io_seph_send>
c0d02d60:	2001      	movs	r0, #1
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 1;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d02d62:	70e8      	strb	r0, [r5, #3]
  io_seproxyhal_spi_send(buffer, 5);
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 1;
c0d02d64:	70a8      	strb	r0, [r5, #2]
  buffer[4] = 0;
  io_seproxyhal_spi_send(buffer, 5);
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02d66:	706c      	strb	r4, [r5, #1]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = 0;
  io_seproxyhal_spi_send(buffer, 5);
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02d68:	702e      	strb	r6, [r5, #0]
c0d02d6a:	2104      	movs	r1, #4
  buffer[1] = 0;
  buffer[2] = 1;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
  io_seproxyhal_spi_send(buffer, 4);
c0d02d6c:	4628      	mov	r0, r5
c0d02d6e:	f7ff fad7 	bl	c0d02320 <io_seph_send>
  return USBD_OK; 
c0d02d72:	4620      	mov	r0, r4
c0d02d74:	b002      	add	sp, #8
c0d02d76:	bd70      	pop	{r4, r5, r6, pc}

c0d02d78 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d02d78:	b510      	push	{r4, lr}
c0d02d7a:	b082      	sub	sp, #8
c0d02d7c:	a801      	add	r0, sp, #4
c0d02d7e:	2102      	movs	r1, #2
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 1;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d02d80:	70c1      	strb	r1, [r0, #3]
c0d02d82:	2101      	movs	r1, #1
{
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 1;
c0d02d84:	7081      	strb	r1, [r0, #2]
c0d02d86:	2400      	movs	r4, #0
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02d88:	7044      	strb	r4, [r0, #1]
c0d02d8a:	214f      	movs	r1, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02d8c:	7001      	strb	r1, [r0, #0]
c0d02d8e:	2104      	movs	r1, #4
  buffer[1] = 0;
  buffer[2] = 1;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
  io_seproxyhal_spi_send(buffer, 4);
c0d02d90:	f7ff fac6 	bl	c0d02320 <io_seph_send>
  return USBD_OK; 
c0d02d94:	4620      	mov	r0, r4
c0d02d96:	b002      	add	sp, #8
c0d02d98:	bd10      	pop	{r4, pc}
	...

c0d02d9c <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d02d9c:	b570      	push	{r4, r5, r6, lr}
c0d02d9e:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
  ep_out_stall = 0;
c0d02da0:	4814      	ldr	r0, [pc, #80]	; (c0d02df4 <USBD_LL_OpenEP+0x58>)
c0d02da2:	2400      	movs	r4, #0
c0d02da4:	6004      	str	r4, [r0, #0]
                                      uint16_t ep_mps)
{
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d02da6:	4814      	ldr	r0, [pc, #80]	; (c0d02df8 <USBD_LL_OpenEP+0x5c>)
c0d02da8:	6004      	str	r4, [r0, #0]
c0d02daa:	466d      	mov	r5, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d02dac:	71ac      	strb	r4, [r5, #6]
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
c0d02dae:	7169      	strb	r1, [r5, #5]
c0d02db0:	2001      	movs	r0, #1

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
c0d02db2:	7128      	strb	r0, [r5, #4]
c0d02db4:	2104      	movs	r1, #4
  ep_out_stall = 0;

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02db6:	70e9      	strb	r1, [r5, #3]
c0d02db8:	2605      	movs	r6, #5
  ep_in_stall = 0;
  ep_out_stall = 0;

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 5;
c0d02dba:	70ae      	strb	r6, [r5, #2]

  ep_in_stall = 0;
  ep_out_stall = 0;

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02dbc:	706c      	strb	r4, [r5, #1]
c0d02dbe:	244f      	movs	r4, #79	; 0x4f
  UNUSED(pdev);

  ep_in_stall = 0;
  ep_out_stall = 0;

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02dc0:	702c      	strb	r4, [r5, #0]
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
  switch(ep_type) {
c0d02dc2:	2a01      	cmp	r2, #1
c0d02dc4:	dc05      	bgt.n	c0d02dd2 <USBD_LL_OpenEP+0x36>
c0d02dc6:	2a00      	cmp	r2, #0
c0d02dc8:	d00a      	beq.n	c0d02de0 <USBD_LL_OpenEP+0x44>
c0d02dca:	2a01      	cmp	r2, #1
c0d02dcc:	d10a      	bne.n	c0d02de4 <USBD_LL_OpenEP+0x48>
c0d02dce:	4608      	mov	r0, r1
c0d02dd0:	e006      	b.n	c0d02de0 <USBD_LL_OpenEP+0x44>
c0d02dd2:	2a02      	cmp	r2, #2
c0d02dd4:	d003      	beq.n	c0d02dde <USBD_LL_OpenEP+0x42>
c0d02dd6:	2a03      	cmp	r2, #3
c0d02dd8:	d104      	bne.n	c0d02de4 <USBD_LL_OpenEP+0x48>
c0d02dda:	2002      	movs	r0, #2
c0d02ddc:	e000      	b.n	c0d02de0 <USBD_LL_OpenEP+0x44>
c0d02dde:	2003      	movs	r0, #3
c0d02de0:	4669      	mov	r1, sp
c0d02de2:	7188      	strb	r0, [r1, #6]
c0d02de4:	4668      	mov	r0, sp
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d02de6:	71c3      	strb	r3, [r0, #7]
c0d02de8:	2108      	movs	r1, #8
  io_seproxyhal_spi_send(buffer, 8);
c0d02dea:	f7ff fa99 	bl	c0d02320 <io_seph_send>
c0d02dee:	2000      	movs	r0, #0
  return USBD_OK; 
c0d02df0:	b002      	add	sp, #8
c0d02df2:	bd70      	pop	{r4, r5, r6, pc}
c0d02df4:	2000200c 	.word	0x2000200c
c0d02df8:	20002008 	.word	0x20002008

c0d02dfc <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02dfc:	b510      	push	{r4, lr}
c0d02dfe:	b082      	sub	sp, #8
c0d02e00:	4668      	mov	r0, sp
c0d02e02:	2400      	movs	r4, #0
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
  buffer[7] = 0;
c0d02e04:	71c4      	strb	r4, [r0, #7]
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d02e06:	7184      	strb	r4, [r0, #6]
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
c0d02e08:	7141      	strb	r1, [r0, #5]
c0d02e0a:	2101      	movs	r1, #1
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
c0d02e0c:	7101      	strb	r1, [r0, #4]
c0d02e0e:	2104      	movs	r1, #4
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d02e10:	70c1      	strb	r1, [r0, #3]
c0d02e12:	2105      	movs	r1, #5
{
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 5;
c0d02e14:	7081      	strb	r1, [r0, #2]
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02e16:	7044      	strb	r4, [r0, #1]
c0d02e18:	214f      	movs	r1, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02e1a:	7001      	strb	r1, [r0, #0]
c0d02e1c:	2108      	movs	r1, #8
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
  buffer[7] = 0;
  io_seproxyhal_spi_send(buffer, 8);
c0d02e1e:	f7ff fa7f 	bl	c0d02320 <io_seph_send>
  return USBD_OK; 
c0d02e22:	4620      	mov	r0, r4
c0d02e24:	b002      	add	sp, #8
c0d02e26:	bd10      	pop	{r4, pc}

c0d02e28 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d02e28:	b5b0      	push	{r4, r5, r7, lr}
c0d02e2a:	b082      	sub	sp, #8
c0d02e2c:	460d      	mov	r5, r1
c0d02e2e:	4668      	mov	r0, sp
c0d02e30:	2400      	movs	r4, #0
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
  buffer[5] = 0;
c0d02e32:	7144      	strb	r4, [r0, #5]
c0d02e34:	2140      	movs	r1, #64	; 0x40
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d02e36:	7101      	strb	r1, [r0, #4]
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
c0d02e38:	70c5      	strb	r5, [r0, #3]
c0d02e3a:	2103      	movs	r1, #3
{ 
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
c0d02e3c:	7081      	strb	r1, [r0, #2]
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
c0d02e3e:	7044      	strb	r4, [r0, #1]
c0d02e40:	2150      	movs	r1, #80	; 0x50
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02e42:	7001      	strb	r1, [r0, #0]
c0d02e44:	2106      	movs	r1, #6
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
  buffer[5] = 0;
  io_seproxyhal_spi_send(buffer, 6);
c0d02e46:	f7ff fa6b 	bl	c0d02320 <io_seph_send>
  if (ep_addr & 0x80) {
c0d02e4a:	0628      	lsls	r0, r5, #24
c0d02e4c:	d501      	bpl.n	c0d02e52 <USBD_LL_StallEP+0x2a>
c0d02e4e:	4807      	ldr	r0, [pc, #28]	; (c0d02e6c <USBD_LL_StallEP+0x44>)
c0d02e50:	e000      	b.n	c0d02e54 <USBD_LL_StallEP+0x2c>
c0d02e52:	4805      	ldr	r0, [pc, #20]	; (c0d02e68 <USBD_LL_StallEP+0x40>)
c0d02e54:	6801      	ldr	r1, [r0, #0]
c0d02e56:	227f      	movs	r2, #127	; 0x7f
c0d02e58:	4015      	ands	r5, r2
c0d02e5a:	2201      	movs	r2, #1
c0d02e5c:	40aa      	lsls	r2, r5
c0d02e5e:	430a      	orrs	r2, r1
c0d02e60:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02e62:	4620      	mov	r0, r4
c0d02e64:	b002      	add	sp, #8
c0d02e66:	bdb0      	pop	{r4, r5, r7, pc}
c0d02e68:	2000200c 	.word	0x2000200c
c0d02e6c:	20002008 	.word	0x20002008

c0d02e70 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d02e70:	b5b0      	push	{r4, r5, r7, lr}
c0d02e72:	b082      	sub	sp, #8
c0d02e74:	460d      	mov	r5, r1
c0d02e76:	4668      	mov	r0, sp
c0d02e78:	2400      	movs	r4, #0
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
  buffer[5] = 0;
c0d02e7a:	7144      	strb	r4, [r0, #5]
c0d02e7c:	2180      	movs	r1, #128	; 0x80
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d02e7e:	7101      	strb	r1, [r0, #4]
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
c0d02e80:	70c5      	strb	r5, [r0, #3]
c0d02e82:	2103      	movs	r1, #3
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
c0d02e84:	7081      	strb	r1, [r0, #2]
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
c0d02e86:	7044      	strb	r4, [r0, #1]
c0d02e88:	2150      	movs	r1, #80	; 0x50
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02e8a:	7001      	strb	r1, [r0, #0]
c0d02e8c:	2106      	movs	r1, #6
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
  buffer[5] = 0;
  io_seproxyhal_spi_send(buffer, 6);
c0d02e8e:	f7ff fa47 	bl	c0d02320 <io_seph_send>
  if (ep_addr & 0x80) {
c0d02e92:	0628      	lsls	r0, r5, #24
c0d02e94:	d501      	bpl.n	c0d02e9a <USBD_LL_ClearStallEP+0x2a>
c0d02e96:	4807      	ldr	r0, [pc, #28]	; (c0d02eb4 <USBD_LL_ClearStallEP+0x44>)
c0d02e98:	e000      	b.n	c0d02e9c <USBD_LL_ClearStallEP+0x2c>
c0d02e9a:	4805      	ldr	r0, [pc, #20]	; (c0d02eb0 <USBD_LL_ClearStallEP+0x40>)
c0d02e9c:	6801      	ldr	r1, [r0, #0]
c0d02e9e:	227f      	movs	r2, #127	; 0x7f
c0d02ea0:	4015      	ands	r5, r2
c0d02ea2:	2201      	movs	r2, #1
c0d02ea4:	40aa      	lsls	r2, r5
c0d02ea6:	4391      	bics	r1, r2
c0d02ea8:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d02eaa:	4620      	mov	r0, r4
c0d02eac:	b002      	add	sp, #8
c0d02eae:	bdb0      	pop	{r4, r5, r7, pc}
c0d02eb0:	2000200c 	.word	0x2000200c
c0d02eb4:	20002008 	.word	0x20002008

c0d02eb8 <USBD_LL_IsStallEP>:
c0d02eb8:	0608      	lsls	r0, r1, #24
c0d02eba:	d501      	bpl.n	c0d02ec0 <USBD_LL_IsStallEP+0x8>
c0d02ebc:	4805      	ldr	r0, [pc, #20]	; (c0d02ed4 <USBD_LL_IsStallEP+0x1c>)
c0d02ebe:	e000      	b.n	c0d02ec2 <USBD_LL_IsStallEP+0xa>
c0d02ec0:	4803      	ldr	r0, [pc, #12]	; (c0d02ed0 <USBD_LL_IsStallEP+0x18>)
c0d02ec2:	7802      	ldrb	r2, [r0, #0]
c0d02ec4:	207f      	movs	r0, #127	; 0x7f
c0d02ec6:	4001      	ands	r1, r0
c0d02ec8:	2001      	movs	r0, #1
c0d02eca:	4088      	lsls	r0, r1
c0d02ecc:	4010      	ands	r0, r2
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d02ece:	4770      	bx	lr
c0d02ed0:	2000200c 	.word	0x2000200c
c0d02ed4:	20002008 	.word	0x20002008

c0d02ed8 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d02ed8:	b510      	push	{r4, lr}
c0d02eda:	b082      	sub	sp, #8
c0d02edc:	4668      	mov	r0, sp
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = dev_addr;
c0d02ede:	7101      	strb	r1, [r0, #4]
c0d02ee0:	2103      	movs	r1, #3
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d02ee2:	70c1      	strb	r1, [r0, #3]
c0d02ee4:	2102      	movs	r1, #2
{
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
c0d02ee6:	7081      	strb	r1, [r0, #2]
c0d02ee8:	2400      	movs	r4, #0
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
c0d02eea:	7044      	strb	r4, [r0, #1]
c0d02eec:	214f      	movs	r1, #79	; 0x4f
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d02eee:	7001      	strb	r1, [r0, #0]
c0d02ef0:	2105      	movs	r1, #5
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = dev_addr;
  io_seproxyhal_spi_send(buffer, 5);
c0d02ef2:	f7ff fa15 	bl	c0d02320 <io_seph_send>
  return USBD_OK; 
c0d02ef6:	4620      	mov	r0, r4
c0d02ef8:	b002      	add	sp, #8
c0d02efa:	bd10      	pop	{r4, pc}

c0d02efc <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d02efc:	b5b0      	push	{r4, r5, r7, lr}
c0d02efe:	b082      	sub	sp, #8
c0d02f00:	461c      	mov	r4, r3
c0d02f02:	4615      	mov	r5, r2
c0d02f04:	4668      	mov	r0, sp
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  buffer[5] = size;
c0d02f06:	7143      	strb	r3, [r0, #5]
c0d02f08:	2220      	movs	r2, #32
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02f0a:	7102      	strb	r2, [r0, #4]
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
c0d02f0c:	70c1      	strb	r1, [r0, #3]
c0d02f0e:	2150      	movs	r1, #80	; 0x50
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02f10:	7001      	strb	r1, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d02f12:	1cd9      	adds	r1, r3, #3
  buffer[2] = (3+size);
c0d02f14:	7081      	strb	r1, [r0, #2]
                                      uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
c0d02f16:	0a09      	lsrs	r1, r1, #8
c0d02f18:	7041      	strb	r1, [r0, #1]
c0d02f1a:	2106      	movs	r1, #6
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  buffer[5] = size;
  io_seproxyhal_spi_send(buffer, 6);
c0d02f1c:	f7ff fa00 	bl	c0d02320 <io_seph_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d02f20:	4628      	mov	r0, r5
c0d02f22:	4621      	mov	r1, r4
c0d02f24:	f7ff f9fc 	bl	c0d02320 <io_seph_send>
c0d02f28:	2000      	movs	r0, #0
  return USBD_OK;   
c0d02f2a:	b002      	add	sp, #8
c0d02f2c:	bdb0      	pop	{r4, r5, r7, pc}

c0d02f2e <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d02f2e:	b510      	push	{r4, lr}
c0d02f30:	b082      	sub	sp, #8
c0d02f32:	4668      	mov	r0, sp
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3/*+size*/)>>8;
  buffer[2] = (3/*+size*/);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
  buffer[5] = size; // expected size, not transmitted here !
c0d02f34:	7142      	strb	r2, [r0, #5]
c0d02f36:	2230      	movs	r2, #48	; 0x30
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3/*+size*/)>>8;
  buffer[2] = (3/*+size*/);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d02f38:	7102      	strb	r2, [r0, #4]
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3/*+size*/)>>8;
  buffer[2] = (3/*+size*/);
  buffer[3] = ep_addr;
c0d02f3a:	70c1      	strb	r1, [r0, #3]
c0d02f3c:	2103      	movs	r1, #3
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3/*+size*/)>>8;
  buffer[2] = (3/*+size*/);
c0d02f3e:	7081      	strb	r1, [r0, #2]
c0d02f40:	2400      	movs	r4, #0
                                           uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3/*+size*/)>>8;
c0d02f42:	7044      	strb	r4, [r0, #1]
c0d02f44:	2150      	movs	r1, #80	; 0x50
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02f46:	7001      	strb	r1, [r0, #0]
c0d02f48:	2106      	movs	r1, #6
  buffer[1] = (3/*+size*/)>>8;
  buffer[2] = (3/*+size*/);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
  buffer[5] = size; // expected size, not transmitted here !
  io_seproxyhal_spi_send(buffer, 6);
c0d02f4a:	f7ff f9e9 	bl	c0d02320 <io_seph_send>
  return USBD_OK;   
c0d02f4e:	4620      	mov	r0, r4
c0d02f50:	b002      	add	sp, #8
c0d02f52:	bd10      	pop	{r4, pc}

c0d02f54 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d02f54:	b570      	push	{r4, r5, r6, lr}
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d02f56:	2800      	cmp	r0, #0
c0d02f58:	d014      	beq.n	c0d02f84 <USBD_Init+0x30>
c0d02f5a:	4615      	mov	r5, r2
c0d02f5c:	460e      	mov	r6, r1
c0d02f5e:	4604      	mov	r4, r0
c0d02f60:	2045      	movs	r0, #69	; 0x45
c0d02f62:	0081      	lsls	r1, r0, #2
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d02f64:	4620      	mov	r0, r4
c0d02f66:	f001 f971 	bl	c0d0424c <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d02f6a:	2e00      	cmp	r6, #0
c0d02f6c:	d001      	beq.n	c0d02f72 <USBD_Init+0x1e>
c0d02f6e:	20f0      	movs	r0, #240	; 0xf0
  {
    pdev->pDesc = pdesc;
c0d02f70:	5026      	str	r6, [r4, r0]
c0d02f72:	20dc      	movs	r0, #220	; 0xdc
c0d02f74:	2101      	movs	r1, #1
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02f76:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d02f78:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d02f7a:	4620      	mov	r0, r4
c0d02f7c:	f7ff fec4 	bl	c0d02d08 <USBD_LL_Init>
c0d02f80:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d02f82:	bd70      	pop	{r4, r5, r6, pc}
c0d02f84:	2002      	movs	r0, #2
c0d02f86:	bd70      	pop	{r4, r5, r6, pc}

c0d02f88 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d02f88:	b5b0      	push	{r4, r5, r7, lr}
c0d02f8a:	4604      	mov	r4, r0
c0d02f8c:	20dc      	movs	r0, #220	; 0xdc
c0d02f8e:	2101      	movs	r1, #1
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d02f90:	5421      	strb	r1, [r4, r0]
c0d02f92:	2017      	movs	r0, #23
c0d02f94:	43c5      	mvns	r5, r0
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(pdev->interfacesClass[intf].pClass != NULL) {
c0d02f96:	1960      	adds	r0, r4, r5
c0d02f98:	2143      	movs	r1, #67	; 0x43
c0d02f9a:	0089      	lsls	r1, r1, #2
c0d02f9c:	5840      	ldr	r0, [r0, r1]
c0d02f9e:	2800      	cmp	r0, #0
c0d02fa0:	d006      	beq.n	c0d02fb0 <USBD_DeInit+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
c0d02fa2:	6840      	ldr	r0, [r0, #4]
c0d02fa4:	f7ff f89c 	bl	c0d020e0 <pic>
c0d02fa8:	4602      	mov	r2, r0
c0d02faa:	7921      	ldrb	r1, [r4, #4]
c0d02fac:	4620      	mov	r0, r4
c0d02fae:	4790      	blx	r2
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d02fb0:	3508      	adds	r5, #8
c0d02fb2:	d1f0      	bne.n	c0d02f96 <USBD_DeInit+0xe>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
    }
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d02fb4:	4620      	mov	r0, r4
c0d02fb6:	f7ff fedf 	bl	c0d02d78 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d02fba:	4620      	mov	r0, r4
c0d02fbc:	f7ff feae 	bl	c0d02d1c <USBD_LL_DeInit>
c0d02fc0:	2000      	movs	r0, #0
  
  return USBD_OK;
c0d02fc2:	bdb0      	pop	{r4, r5, r7, pc}

c0d02fc4 <USBD_RegisterClassForInterface>:
  * @retval USBD Status
  */
USBD_StatusTypeDef USBD_RegisterClassForInterface(uint8_t interfaceidx, USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d02fc4:	2a00      	cmp	r2, #0
c0d02fc6:	d008      	beq.n	c0d02fda <USBD_RegisterClassForInterface+0x16>
c0d02fc8:	4603      	mov	r3, r0
c0d02fca:	2000      	movs	r0, #0
  {
    if (interfaceidx < USBD_MAX_NUM_INTERFACES) {
c0d02fcc:	2b02      	cmp	r3, #2
c0d02fce:	d803      	bhi.n	c0d02fd8 <USBD_RegisterClassForInterface+0x14>
      /* link the class to the USB Device handle */
      pdev->interfacesClass[interfaceidx].pClass = pclass;
c0d02fd0:	00db      	lsls	r3, r3, #3
c0d02fd2:	18c9      	adds	r1, r1, r3
c0d02fd4:	23f4      	movs	r3, #244	; 0xf4
c0d02fd6:	50ca      	str	r2, [r1, r3]
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d02fd8:	4770      	bx	lr
c0d02fda:	2002      	movs	r0, #2
c0d02fdc:	4770      	bx	lr

c0d02fde <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d02fde:	b580      	push	{r7, lr}
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d02fe0:	f7ff feae 	bl	c0d02d40 <USBD_LL_Start>
c0d02fe4:	2000      	movs	r0, #0
  
  return USBD_OK;  
c0d02fe6:	bd80      	pop	{r7, pc}

c0d02fe8 <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d02fe8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02fea:	b081      	sub	sp, #4
c0d02fec:	460c      	mov	r4, r1
c0d02fee:	4605      	mov	r5, r0
c0d02ff0:	2600      	movs	r6, #0
c0d02ff2:	27f4      	movs	r7, #244	; 0xf4
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d02ff4:	4628      	mov	r0, r5
c0d02ff6:	4631      	mov	r1, r6
c0d02ff8:	f000 f968 	bl	c0d032cc <usbd_is_valid_intf>
c0d02ffc:	2800      	cmp	r0, #0
c0d02ffe:	d007      	beq.n	c0d03010 <USBD_SetClassConfig+0x28>
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
c0d03000:	59e8      	ldr	r0, [r5, r7]
c0d03002:	6800      	ldr	r0, [r0, #0]
c0d03004:	f7ff f86c 	bl	c0d020e0 <pic>
c0d03008:	4602      	mov	r2, r0
c0d0300a:	4628      	mov	r0, r5
c0d0300c:	4621      	mov	r1, r4
c0d0300e:	4790      	blx	r2

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03010:	3708      	adds	r7, #8
c0d03012:	1c76      	adds	r6, r6, #1
c0d03014:	2e03      	cmp	r6, #3
c0d03016:	d1ed      	bne.n	c0d02ff4 <USBD_SetClassConfig+0xc>
c0d03018:	2000      	movs	r0, #0
    if(usbd_is_valid_intf(pdev, intf)) {
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
    }
  }

  return USBD_OK; 
c0d0301a:	b001      	add	sp, #4
c0d0301c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0301e <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d0301e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03020:	b081      	sub	sp, #4
c0d03022:	460c      	mov	r4, r1
c0d03024:	4605      	mov	r5, r0
c0d03026:	2600      	movs	r6, #0
c0d03028:	27f4      	movs	r7, #244	; 0xf4
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d0302a:	4628      	mov	r0, r5
c0d0302c:	4631      	mov	r1, r6
c0d0302e:	f000 f94d 	bl	c0d032cc <usbd_is_valid_intf>
c0d03032:	2800      	cmp	r0, #0
c0d03034:	d007      	beq.n	c0d03046 <USBD_ClrClassConfig+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
c0d03036:	59e8      	ldr	r0, [r5, r7]
c0d03038:	6840      	ldr	r0, [r0, #4]
c0d0303a:	f7ff f851 	bl	c0d020e0 <pic>
c0d0303e:	4602      	mov	r2, r0
c0d03040:	4628      	mov	r0, r5
c0d03042:	4621      	mov	r1, r4
c0d03044:	4790      	blx	r2
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03046:	3708      	adds	r7, #8
c0d03048:	1c76      	adds	r6, r6, #1
c0d0304a:	2e03      	cmp	r6, #3
c0d0304c:	d1ed      	bne.n	c0d0302a <USBD_ClrClassConfig+0xc>
c0d0304e:	2000      	movs	r0, #0
    if(usbd_is_valid_intf(pdev, intf)) {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
    }
  }
  return USBD_OK;
c0d03050:	b001      	add	sp, #4
c0d03052:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03054 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d03054:	b5b0      	push	{r4, r5, r7, lr}
c0d03056:	4604      	mov	r4, r0
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d03058:	4605      	mov	r5, r0
c0d0305a:	35e8      	adds	r5, #232	; 0xe8
c0d0305c:	4628      	mov	r0, r5
c0d0305e:	f000 fb77 	bl	c0d03750 <USBD_ParseSetupRequest>
c0d03062:	20d4      	movs	r0, #212	; 0xd4
c0d03064:	2101      	movs	r1, #1
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d03066:	5021      	str	r1, [r4, r0]
c0d03068:	20ee      	movs	r0, #238	; 0xee
  pdev->ep0_data_len = pdev->request.wLength;
c0d0306a:	5a20      	ldrh	r0, [r4, r0]
c0d0306c:	21d8      	movs	r1, #216	; 0xd8
c0d0306e:	5060      	str	r0, [r4, r1]
c0d03070:	20e8      	movs	r0, #232	; 0xe8
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d03072:	5c21      	ldrb	r1, [r4, r0]
c0d03074:	201f      	movs	r0, #31
c0d03076:	4008      	ands	r0, r1
c0d03078:	2802      	cmp	r0, #2
c0d0307a:	d008      	beq.n	c0d0308e <USBD_LL_SetupStage+0x3a>
c0d0307c:	2801      	cmp	r0, #1
c0d0307e:	d00b      	beq.n	c0d03098 <USBD_LL_SetupStage+0x44>
c0d03080:	2800      	cmp	r0, #0
c0d03082:	d10e      	bne.n	c0d030a2 <USBD_LL_SetupStage+0x4e>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d03084:	4620      	mov	r0, r4
c0d03086:	4629      	mov	r1, r5
c0d03088:	f000 f92c 	bl	c0d032e4 <USBD_StdDevReq>
c0d0308c:	e00e      	b.n	c0d030ac <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d0308e:	4620      	mov	r0, r4
c0d03090:	4629      	mov	r1, r5
c0d03092:	f000 fadb 	bl	c0d0364c <USBD_StdEPReq>
c0d03096:	e009      	b.n	c0d030ac <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d03098:	4620      	mov	r0, r4
c0d0309a:	4629      	mov	r1, r5
c0d0309c:	f000 fab2 	bl	c0d03604 <USBD_StdItfReq>
c0d030a0:	e004      	b.n	c0d030ac <USBD_LL_SetupStage+0x58>
c0d030a2:	2080      	movs	r0, #128	; 0x80
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d030a4:	4001      	ands	r1, r0
c0d030a6:	4620      	mov	r0, r4
c0d030a8:	f7ff febe 	bl	c0d02e28 <USBD_LL_StallEP>
c0d030ac:	2000      	movs	r0, #0
    break;
  }  
  return USBD_OK;  
c0d030ae:	bdb0      	pop	{r4, r5, r7, pc}

c0d030b0 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d030b0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d030b2:	b083      	sub	sp, #12
c0d030b4:	9202      	str	r2, [sp, #8]
c0d030b6:	4604      	mov	r4, r0
c0d030b8:	9101      	str	r1, [sp, #4]
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d030ba:	2900      	cmp	r1, #0
c0d030bc:	d01c      	beq.n	c0d030f8 <USBD_LL_DataOutStage+0x48>
c0d030be:	4625      	mov	r5, r4
c0d030c0:	35dc      	adds	r5, #220	; 0xdc
c0d030c2:	2700      	movs	r7, #0
c0d030c4:	26f4      	movs	r6, #244	; 0xf4
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d030c6:	4620      	mov	r0, r4
c0d030c8:	4639      	mov	r1, r7
c0d030ca:	f000 f8ff 	bl	c0d032cc <usbd_is_valid_intf>
c0d030ce:	2800      	cmp	r0, #0
c0d030d0:	d00d      	beq.n	c0d030ee <USBD_LL_DataOutStage+0x3e>
c0d030d2:	59a0      	ldr	r0, [r4, r6]
c0d030d4:	6980      	ldr	r0, [r0, #24]
c0d030d6:	2800      	cmp	r0, #0
c0d030d8:	d009      	beq.n	c0d030ee <USBD_LL_DataOutStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d030da:	7829      	ldrb	r1, [r5, #0]
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d030dc:	2903      	cmp	r1, #3
c0d030de:	d106      	bne.n	c0d030ee <USBD_LL_DataOutStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
c0d030e0:	f7fe fffe 	bl	c0d020e0 <pic>
c0d030e4:	4603      	mov	r3, r0
c0d030e6:	4620      	mov	r0, r4
c0d030e8:	9901      	ldr	r1, [sp, #4]
c0d030ea:	9a02      	ldr	r2, [sp, #8]
c0d030ec:	4798      	blx	r3
    }
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d030ee:	3608      	adds	r6, #8
c0d030f0:	1c7f      	adds	r7, r7, #1
c0d030f2:	2f03      	cmp	r7, #3
c0d030f4:	d1e7      	bne.n	c0d030c6 <USBD_LL_DataOutStage+0x16>
c0d030f6:	e030      	b.n	c0d0315a <USBD_LL_DataOutStage+0xaa>
c0d030f8:	20d4      	movs	r0, #212	; 0xd4
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d030fa:	5820      	ldr	r0, [r4, r0]
c0d030fc:	2803      	cmp	r0, #3
c0d030fe:	d12c      	bne.n	c0d0315a <USBD_LL_DataOutStage+0xaa>
c0d03100:	2080      	movs	r0, #128	; 0x80
    {
      if(pep->rem_length > pep->maxpacket)
c0d03102:	5820      	ldr	r0, [r4, r0]
c0d03104:	6fe1      	ldr	r1, [r4, #124]	; 0x7c
c0d03106:	4281      	cmp	r1, r0
c0d03108:	d90a      	bls.n	c0d03120 <USBD_LL_DataOutStage+0x70>
      {
        pep->rem_length -=  pep->maxpacket;
c0d0310a:	1a09      	subs	r1, r1, r0
c0d0310c:	67e1      	str	r1, [r4, #124]	; 0x7c
       
        USBD_CtlContinueRx (pdev, 
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
c0d0310e:	4281      	cmp	r1, r0
c0d03110:	d300      	bcc.n	c0d03114 <USBD_LL_DataOutStage+0x64>
c0d03112:	4601      	mov	r1, r0
    {
      if(pep->rem_length > pep->maxpacket)
      {
        pep->rem_length -=  pep->maxpacket;
       
        USBD_CtlContinueRx (pdev, 
c0d03114:	b28a      	uxth	r2, r1
c0d03116:	4620      	mov	r0, r4
c0d03118:	9902      	ldr	r1, [sp, #8]
c0d0311a:	f000 fddb 	bl	c0d03cd4 <USBD_CtlContinueRx>
c0d0311e:	e01c      	b.n	c0d0315a <USBD_LL_DataOutStage+0xaa>
c0d03120:	4626      	mov	r6, r4
c0d03122:	36dc      	adds	r6, #220	; 0xdc
c0d03124:	2500      	movs	r5, #0
c0d03126:	27f4      	movs	r7, #244	; 0xf4
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d03128:	4620      	mov	r0, r4
c0d0312a:	4629      	mov	r1, r5
c0d0312c:	f000 f8ce 	bl	c0d032cc <usbd_is_valid_intf>
c0d03130:	2800      	cmp	r0, #0
c0d03132:	d00b      	beq.n	c0d0314c <USBD_LL_DataOutStage+0x9c>
c0d03134:	59e0      	ldr	r0, [r4, r7]
c0d03136:	6900      	ldr	r0, [r0, #16]
c0d03138:	2800      	cmp	r0, #0
c0d0313a:	d007      	beq.n	c0d0314c <USBD_LL_DataOutStage+0x9c>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d0313c:	7831      	ldrb	r1, [r6, #0]
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d0313e:	2903      	cmp	r1, #3
c0d03140:	d104      	bne.n	c0d0314c <USBD_LL_DataOutStage+0x9c>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
c0d03142:	f7fe ffcd 	bl	c0d020e0 <pic>
c0d03146:	4601      	mov	r1, r0
c0d03148:	4620      	mov	r0, r4
c0d0314a:	4788      	blx	r1
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0314c:	3708      	adds	r7, #8
c0d0314e:	1c6d      	adds	r5, r5, #1
c0d03150:	2d03      	cmp	r5, #3
c0d03152:	d1e9      	bne.n	c0d03128 <USBD_LL_DataOutStage+0x78>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
          }
        }
        USBD_CtlSendStatus(pdev);
c0d03154:	4620      	mov	r0, r4
c0d03156:	f000 fdc4 	bl	c0d03ce2 <USBD_CtlSendStatus>
c0d0315a:	2000      	movs	r0, #0
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
      }
    }
  }  
  return USBD_OK;
c0d0315c:	b003      	add	sp, #12
c0d0315e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03160 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d03160:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03162:	b081      	sub	sp, #4
c0d03164:	4604      	mov	r4, r0
*         Handle data in stage
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
c0d03166:	30d8      	adds	r0, #216	; 0xd8
c0d03168:	9000      	str	r0, [sp, #0]
{
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d0316a:	2900      	cmp	r1, #0
c0d0316c:	d01b      	beq.n	c0d031a6 <USBD_LL_DataInStage+0x46>
c0d0316e:	460d      	mov	r5, r1
c0d03170:	2600      	movs	r6, #0
c0d03172:	27f4      	movs	r7, #244	; 0xf4
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d03174:	4620      	mov	r0, r4
c0d03176:	4631      	mov	r1, r6
c0d03178:	f000 f8a8 	bl	c0d032cc <usbd_is_valid_intf>
c0d0317c:	2800      	cmp	r0, #0
c0d0317e:	d00d      	beq.n	c0d0319c <USBD_LL_DataInStage+0x3c>
c0d03180:	59e0      	ldr	r0, [r4, r7]
c0d03182:	6940      	ldr	r0, [r0, #20]
c0d03184:	2800      	cmp	r0, #0
c0d03186:	d009      	beq.n	c0d0319c <USBD_LL_DataInStage+0x3c>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d03188:	9900      	ldr	r1, [sp, #0]
c0d0318a:	7909      	ldrb	r1, [r1, #4]
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d0318c:	2903      	cmp	r1, #3
c0d0318e:	d105      	bne.n	c0d0319c <USBD_LL_DataInStage+0x3c>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
c0d03190:	f7fe ffa6 	bl	c0d020e0 <pic>
c0d03194:	4602      	mov	r2, r0
c0d03196:	4620      	mov	r0, r4
c0d03198:	4629      	mov	r1, r5
c0d0319a:	4790      	blx	r2
      pdev->dev_test_mode = 0;
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0319c:	3708      	adds	r7, #8
c0d0319e:	1c76      	adds	r6, r6, #1
c0d031a0:	2e03      	cmp	r6, #3
c0d031a2:	d1e7      	bne.n	c0d03174 <USBD_LL_DataInStage+0x14>
c0d031a4:	e04c      	b.n	c0d03240 <USBD_LL_DataInStage+0xe0>
c0d031a6:	20d4      	movs	r0, #212	; 0xd4
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d031a8:	5820      	ldr	r0, [r4, r0]
c0d031aa:	2802      	cmp	r0, #2
c0d031ac:	d141      	bne.n	c0d03232 <USBD_LL_DataInStage+0xd2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d031ae:	69e0      	ldr	r0, [r4, #28]
c0d031b0:	6a25      	ldr	r5, [r4, #32]
c0d031b2:	42a8      	cmp	r0, r5
c0d031b4:	d90b      	bls.n	c0d031ce <USBD_LL_DataInStage+0x6e>
c0d031b6:	2111      	movs	r1, #17
c0d031b8:	010a      	lsls	r2, r1, #4
      {
        pep->rem_length -=  pep->maxpacket;
        pdev->pData += pep->maxpacket;
c0d031ba:	58a1      	ldr	r1, [r4, r2]
c0d031bc:	1949      	adds	r1, r1, r5
c0d031be:	50a1      	str	r1, [r4, r2]
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
    {
      if(pep->rem_length > pep->maxpacket)
      {
        pep->rem_length -=  pep->maxpacket;
c0d031c0:	1b40      	subs	r0, r0, r5
c0d031c2:	61e0      	str	r0, [r4, #28]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d031c4:	b282      	uxth	r2, r0
c0d031c6:	4620      	mov	r0, r4
c0d031c8:	f000 fd76 	bl	c0d03cb8 <USBD_CtlContinueSendData>
c0d031cc:	e031      	b.n	c0d03232 <USBD_LL_DataInStage+0xd2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d031ce:	69a6      	ldr	r6, [r4, #24]
c0d031d0:	4630      	mov	r0, r6
c0d031d2:	4629      	mov	r1, r5
c0d031d4:	f001 f834 	bl	c0d04240 <__aeabi_uidivmod>
c0d031d8:	42ae      	cmp	r6, r5
c0d031da:	d30e      	bcc.n	c0d031fa <USBD_LL_DataInStage+0x9a>
c0d031dc:	2900      	cmp	r1, #0
c0d031de:	d10c      	bne.n	c0d031fa <USBD_LL_DataInStage+0x9a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d031e0:	9800      	ldr	r0, [sp, #0]
c0d031e2:	6800      	ldr	r0, [r0, #0]
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d031e4:	4286      	cmp	r6, r0
c0d031e6:	d208      	bcs.n	c0d031fa <USBD_LL_DataInStage+0x9a>
c0d031e8:	2500      	movs	r5, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d031ea:	4620      	mov	r0, r4
c0d031ec:	4629      	mov	r1, r5
c0d031ee:	462a      	mov	r2, r5
c0d031f0:	f000 fd62 	bl	c0d03cb8 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d031f4:	9800      	ldr	r0, [sp, #0]
c0d031f6:	6005      	str	r5, [r0, #0]
c0d031f8:	e01b      	b.n	c0d03232 <USBD_LL_DataInStage+0xd2>
c0d031fa:	2500      	movs	r5, #0
c0d031fc:	26f4      	movs	r6, #244	; 0xf4
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d031fe:	4620      	mov	r0, r4
c0d03200:	4629      	mov	r1, r5
c0d03202:	f000 f863 	bl	c0d032cc <usbd_is_valid_intf>
c0d03206:	2800      	cmp	r0, #0
c0d03208:	d00c      	beq.n	c0d03224 <USBD_LL_DataInStage+0xc4>
c0d0320a:	59a0      	ldr	r0, [r4, r6]
c0d0320c:	68c0      	ldr	r0, [r0, #12]
c0d0320e:	2800      	cmp	r0, #0
c0d03210:	d008      	beq.n	c0d03224 <USBD_LL_DataInStage+0xc4>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d03212:	9900      	ldr	r1, [sp, #0]
c0d03214:	7909      	ldrb	r1, [r1, #4]
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d03216:	2903      	cmp	r1, #3
c0d03218:	d104      	bne.n	c0d03224 <USBD_LL_DataInStage+0xc4>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
c0d0321a:	f7fe ff61 	bl	c0d020e0 <pic>
c0d0321e:	4601      	mov	r1, r0
c0d03220:	4620      	mov	r0, r4
c0d03222:	4788      	blx	r1
          
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03224:	3608      	adds	r6, #8
c0d03226:	1c6d      	adds	r5, r5, #1
c0d03228:	2d03      	cmp	r5, #3
c0d0322a:	d1e8      	bne.n	c0d031fe <USBD_LL_DataInStage+0x9e>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
            }
          }
          USBD_CtlReceiveStatus(pdev);
c0d0322c:	4620      	mov	r0, r4
c0d0322e:	f000 fd64 	bl	c0d03cfa <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d03232:	9800      	ldr	r0, [sp, #0]
c0d03234:	7a00      	ldrb	r0, [r0, #8]
c0d03236:	2801      	cmp	r0, #1
c0d03238:	d102      	bne.n	c0d03240 <USBD_LL_DataInStage+0xe0>
c0d0323a:	2000      	movs	r0, #0
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d0323c:	9900      	ldr	r1, [sp, #0]
c0d0323e:	7208      	strb	r0, [r1, #8]
c0d03240:	2000      	movs	r0, #0
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
      }
    }
  }
  return USBD_OK;
c0d03242:	b001      	add	sp, #4
c0d03244:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03246 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d03246:	b570      	push	{r4, r5, r6, lr}
c0d03248:	4604      	mov	r4, r0
c0d0324a:	20dc      	movs	r0, #220	; 0xdc
c0d0324c:	2101      	movs	r1, #1
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d0324e:	5421      	strb	r1, [r4, r0]
c0d03250:	2080      	movs	r0, #128	; 0x80
c0d03252:	2140      	movs	r1, #64	; 0x40
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d03254:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d03256:	6221      	str	r1, [r4, #32]
c0d03258:	2500      	movs	r5, #0
c0d0325a:	26f4      	movs	r6, #244	; 0xf4
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if( usbd_is_valid_intf(pdev, intf))
c0d0325c:	4620      	mov	r0, r4
c0d0325e:	4629      	mov	r1, r5
c0d03260:	f000 f834 	bl	c0d032cc <usbd_is_valid_intf>
c0d03264:	2800      	cmp	r0, #0
c0d03266:	d007      	beq.n	c0d03278 <USBD_LL_Reset+0x32>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
c0d03268:	59a0      	ldr	r0, [r4, r6]
c0d0326a:	6840      	ldr	r0, [r0, #4]
c0d0326c:	f7fe ff38 	bl	c0d020e0 <pic>
c0d03270:	4602      	mov	r2, r0
c0d03272:	7921      	ldrb	r1, [r4, #4]
c0d03274:	4620      	mov	r0, r4
c0d03276:	4790      	blx	r2
  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d03278:	3608      	adds	r6, #8
c0d0327a:	1c6d      	adds	r5, r5, #1
c0d0327c:	2d03      	cmp	r5, #3
c0d0327e:	d1ed      	bne.n	c0d0325c <USBD_LL_Reset+0x16>
c0d03280:	2000      	movs	r0, #0
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
    }
  }
  
  return USBD_OK;
c0d03282:	bd70      	pop	{r4, r5, r6, pc}

c0d03284 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d03284:	7401      	strb	r1, [r0, #16]
c0d03286:	2000      	movs	r0, #0
  return USBD_OK;
c0d03288:	4770      	bx	lr

c0d0328a <USBD_LL_Suspend>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Suspend(USBD_HandleTypeDef  *pdev)
{
c0d0328a:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d0328c:	4770      	bx	lr

c0d0328e <USBD_LL_Resume>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
c0d0328e:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d03290:	4770      	bx	lr

c0d03292 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d03292:	b570      	push	{r4, r5, r6, lr}
c0d03294:	4604      	mov	r4, r0
c0d03296:	20dc      	movs	r0, #220	; 0xdc
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d03298:	5c20      	ldrb	r0, [r4, r0]
c0d0329a:	2803      	cmp	r0, #3
c0d0329c:	d114      	bne.n	c0d032c8 <USBD_LL_SOF+0x36>
c0d0329e:	2500      	movs	r5, #0
c0d032a0:	26f4      	movs	r6, #244	; 0xf4
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && pdev->interfacesClass[intf].pClass->SOF != NULL)
c0d032a2:	4620      	mov	r0, r4
c0d032a4:	4629      	mov	r1, r5
c0d032a6:	f000 f811 	bl	c0d032cc <usbd_is_valid_intf>
c0d032aa:	2800      	cmp	r0, #0
c0d032ac:	d008      	beq.n	c0d032c0 <USBD_LL_SOF+0x2e>
c0d032ae:	59a0      	ldr	r0, [r4, r6]
c0d032b0:	69c0      	ldr	r0, [r0, #28]
c0d032b2:	2800      	cmp	r0, #0
c0d032b4:	d004      	beq.n	c0d032c0 <USBD_LL_SOF+0x2e>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
c0d032b6:	f7fe ff13 	bl	c0d020e0 <pic>
c0d032ba:	4601      	mov	r1, r0
c0d032bc:	4620      	mov	r0, r4
c0d032be:	4788      	blx	r1
USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d032c0:	3608      	adds	r6, #8
c0d032c2:	1c6d      	adds	r5, r5, #1
c0d032c4:	2d03      	cmp	r5, #3
c0d032c6:	d1ec      	bne.n	c0d032a2 <USBD_LL_SOF+0x10>
c0d032c8:	2000      	movs	r0, #0
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
      }
    }
  }
  return USBD_OK;
c0d032ca:	bd70      	pop	{r4, r5, r6, pc}

c0d032cc <usbd_is_valid_intf>:
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d032cc:	2902      	cmp	r1, #2
c0d032ce:	d807      	bhi.n	c0d032e0 <usbd_is_valid_intf+0x14>
c0d032d0:	00c9      	lsls	r1, r1, #3
c0d032d2:	1840      	adds	r0, r0, r1
c0d032d4:	21f4      	movs	r1, #244	; 0xf4
c0d032d6:	5840      	ldr	r0, [r0, r1]
c0d032d8:	2800      	cmp	r0, #0
c0d032da:	d000      	beq.n	c0d032de <usbd_is_valid_intf+0x12>
c0d032dc:	2001      	movs	r0, #1
c0d032de:	4770      	bx	lr
c0d032e0:	2000      	movs	r0, #0
c0d032e2:	4770      	bx	lr

c0d032e4 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d032e4:	b580      	push	{r7, lr}
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d032e6:	784a      	ldrb	r2, [r1, #1]
c0d032e8:	2a04      	cmp	r2, #4
c0d032ea:	dd08      	ble.n	c0d032fe <USBD_StdDevReq+0x1a>
c0d032ec:	2a07      	cmp	r2, #7
c0d032ee:	dc0f      	bgt.n	c0d03310 <USBD_StdDevReq+0x2c>
c0d032f0:	2a05      	cmp	r2, #5
c0d032f2:	d014      	beq.n	c0d0331e <USBD_StdDevReq+0x3a>
c0d032f4:	2a06      	cmp	r2, #6
c0d032f6:	d11b      	bne.n	c0d03330 <USBD_StdDevReq+0x4c>
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d032f8:	f000 f821 	bl	c0d0333e <USBD_GetDescriptor>
c0d032fc:	e01d      	b.n	c0d0333a <USBD_StdDevReq+0x56>
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d032fe:	2a00      	cmp	r2, #0
c0d03300:	d010      	beq.n	c0d03324 <USBD_StdDevReq+0x40>
c0d03302:	2a01      	cmp	r2, #1
c0d03304:	d017      	beq.n	c0d03336 <USBD_StdDevReq+0x52>
c0d03306:	2a03      	cmp	r2, #3
c0d03308:	d112      	bne.n	c0d03330 <USBD_StdDevReq+0x4c>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d0330a:	f000 f936 	bl	c0d0357a <USBD_SetFeature>
c0d0330e:	e014      	b.n	c0d0333a <USBD_StdDevReq+0x56>
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d03310:	2a08      	cmp	r2, #8
c0d03312:	d00a      	beq.n	c0d0332a <USBD_StdDevReq+0x46>
c0d03314:	2a09      	cmp	r2, #9
c0d03316:	d10b      	bne.n	c0d03330 <USBD_StdDevReq+0x4c>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d03318:	f000 f8bd 	bl	c0d03496 <USBD_SetConfig>
c0d0331c:	e00d      	b.n	c0d0333a <USBD_StdDevReq+0x56>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d0331e:	f000 f894 	bl	c0d0344a <USBD_SetAddress>
c0d03322:	e00a      	b.n	c0d0333a <USBD_StdDevReq+0x56>
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d03324:	f000 f906 	bl	c0d03534 <USBD_GetStatus>
c0d03328:	e007      	b.n	c0d0333a <USBD_StdDevReq+0x56>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d0332a:	f000 f8ec 	bl	c0d03506 <USBD_GetConfig>
c0d0332e:	e004      	b.n	c0d0333a <USBD_StdDevReq+0x56>
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
    break;
    
  default:  
    USBD_CtlError(pdev , req);
c0d03330:	f000 fbe2 	bl	c0d03af8 <USBD_CtlError>
c0d03334:	e001      	b.n	c0d0333a <USBD_StdDevReq+0x56>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d03336:	f000 f93d 	bl	c0d035b4 <USBD_ClrFeature>
c0d0333a:	2000      	movs	r0, #0
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d0333c:	bd80      	pop	{r7, pc}

c0d0333e <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d0333e:	b5b0      	push	{r4, r5, r7, lr}
c0d03340:	b082      	sub	sp, #8
c0d03342:	460d      	mov	r5, r1
c0d03344:	4604      	mov	r4, r0
c0d03346:	a801      	add	r0, sp, #4
c0d03348:	2100      	movs	r1, #0
  uint16_t len = 0;
c0d0334a:	8001      	strh	r1, [r0, #0]
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d0334c:	886a      	ldrh	r2, [r5, #2]
c0d0334e:	0a10      	lsrs	r0, r2, #8
c0d03350:	2805      	cmp	r0, #5
c0d03352:	dc12      	bgt.n	c0d0337a <USBD_GetDescriptor+0x3c>
c0d03354:	2801      	cmp	r0, #1
c0d03356:	d01c      	beq.n	c0d03392 <USBD_GetDescriptor+0x54>
c0d03358:	2802      	cmp	r0, #2
c0d0335a:	d024      	beq.n	c0d033a6 <USBD_GetDescriptor+0x68>
c0d0335c:	2803      	cmp	r0, #3
c0d0335e:	d137      	bne.n	c0d033d0 <USBD_GetDescriptor+0x92>
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d03360:	b2d0      	uxtb	r0, r2
c0d03362:	2802      	cmp	r0, #2
c0d03364:	dc39      	bgt.n	c0d033da <USBD_GetDescriptor+0x9c>
c0d03366:	2800      	cmp	r0, #0
c0d03368:	d05f      	beq.n	c0d0342a <USBD_GetDescriptor+0xec>
c0d0336a:	2801      	cmp	r0, #1
c0d0336c:	d065      	beq.n	c0d0343a <USBD_GetDescriptor+0xfc>
c0d0336e:	2802      	cmp	r0, #2
c0d03370:	d12e      	bne.n	c0d033d0 <USBD_GetDescriptor+0x92>
c0d03372:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d03374:	5820      	ldr	r0, [r4, r0]
c0d03376:	68c0      	ldr	r0, [r0, #12]
c0d03378:	e00e      	b.n	c0d03398 <USBD_GetDescriptor+0x5a>
{
  uint16_t len = 0;
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d0337a:	2806      	cmp	r0, #6
c0d0337c:	d01c      	beq.n	c0d033b8 <USBD_GetDescriptor+0x7a>
c0d0337e:	2807      	cmp	r0, #7
c0d03380:	d023      	beq.n	c0d033ca <USBD_GetDescriptor+0x8c>
c0d03382:	280f      	cmp	r0, #15
c0d03384:	d124      	bne.n	c0d033d0 <USBD_GetDescriptor+0x92>
c0d03386:	20f0      	movs	r0, #240	; 0xf0
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    if(pdev->pDesc->GetBOSDescriptor != NULL) {
c0d03388:	5820      	ldr	r0, [r4, r0]
c0d0338a:	69c0      	ldr	r0, [r0, #28]
c0d0338c:	2800      	cmp	r0, #0
c0d0338e:	d103      	bne.n	c0d03398 <USBD_GetDescriptor+0x5a>
c0d03390:	e01e      	b.n	c0d033d0 <USBD_GetDescriptor+0x92>
c0d03392:	20f0      	movs	r0, #240	; 0xf0
      goto default_error;
    }
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d03394:	5820      	ldr	r0, [r4, r0]
c0d03396:	6800      	ldr	r0, [r0, #0]
c0d03398:	f7fe fea2 	bl	c0d020e0 <pic>
c0d0339c:	4602      	mov	r2, r0
c0d0339e:	7c20      	ldrb	r0, [r4, #16]
c0d033a0:	a901      	add	r1, sp, #4
c0d033a2:	4790      	blx	r2
c0d033a4:	e02f      	b.n	c0d03406 <USBD_GetDescriptor+0xc8>
c0d033a6:	20f4      	movs	r0, #244	; 0xf4
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
c0d033a8:	5820      	ldr	r0, [r4, r0]
c0d033aa:	2800      	cmp	r0, #0
c0d033ac:	d02c      	beq.n	c0d03408 <USBD_GetDescriptor+0xca>
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d033ae:	7c21      	ldrb	r1, [r4, #16]
c0d033b0:	2900      	cmp	r1, #0
c0d033b2:	d022      	beq.n	c0d033fa <USBD_GetDescriptor+0xbc>
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
        //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
      }
      else
      {
        pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetFSConfigDescriptor))(&len);
c0d033b4:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d033b6:	e021      	b.n	c0d033fc <USBD_GetDescriptor+0xbe>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL )   
c0d033b8:	7c20      	ldrb	r0, [r4, #16]
c0d033ba:	2800      	cmp	r0, #0
c0d033bc:	d108      	bne.n	c0d033d0 <USBD_GetDescriptor+0x92>
c0d033be:	20f4      	movs	r0, #244	; 0xf4
c0d033c0:	5820      	ldr	r0, [r4, r0]
c0d033c2:	2800      	cmp	r0, #0
c0d033c4:	d004      	beq.n	c0d033d0 <USBD_GetDescriptor+0x92>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetDeviceQualifierDescriptor))(&len);
c0d033c6:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d033c8:	e018      	b.n	c0d033fc <USBD_GetDescriptor+0xbe>
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d033ca:	7c20      	ldrb	r0, [r4, #16]
c0d033cc:	2800      	cmp	r0, #0
c0d033ce:	d00e      	beq.n	c0d033ee <USBD_GetDescriptor+0xb0>
      goto default_error;
    }

  default: 
  default_error:
     USBD_CtlError(pdev , req);
c0d033d0:	4620      	mov	r0, r4
c0d033d2:	4629      	mov	r1, r5
c0d033d4:	f000 fb90 	bl	c0d03af8 <USBD_CtlError>
c0d033d8:	e025      	b.n	c0d03426 <USBD_GetDescriptor+0xe8>
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d033da:	2803      	cmp	r0, #3
c0d033dc:	d029      	beq.n	c0d03432 <USBD_GetDescriptor+0xf4>
c0d033de:	2804      	cmp	r0, #4
c0d033e0:	d02f      	beq.n	c0d03442 <USBD_GetDescriptor+0x104>
c0d033e2:	2805      	cmp	r0, #5
c0d033e4:	d1f4      	bne.n	c0d033d0 <USBD_GetDescriptor+0x92>
c0d033e6:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d033e8:	5820      	ldr	r0, [r4, r0]
c0d033ea:	6980      	ldr	r0, [r0, #24]
c0d033ec:	e7d4      	b.n	c0d03398 <USBD_GetDescriptor+0x5a>
c0d033ee:	20f4      	movs	r0, #244	; 0xf4
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d033f0:	5820      	ldr	r0, [r4, r0]
c0d033f2:	2800      	cmp	r0, #0
c0d033f4:	d0ec      	beq.n	c0d033d0 <USBD_GetDescriptor+0x92>
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d033f6:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d033f8:	e000      	b.n	c0d033fc <USBD_GetDescriptor+0xbe>
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
      {
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
c0d033fa:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d033fc:	f7fe fe70 	bl	c0d020e0 <pic>
c0d03400:	4601      	mov	r1, r0
c0d03402:	a801      	add	r0, sp, #4
c0d03404:	4788      	blx	r1
c0d03406:	4601      	mov	r1, r0
c0d03408:	a801      	add	r0, sp, #4
  default_error:
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d0340a:	8802      	ldrh	r2, [r0, #0]
c0d0340c:	2a00      	cmp	r2, #0
c0d0340e:	d00a      	beq.n	c0d03426 <USBD_GetDescriptor+0xe8>
c0d03410:	88e8      	ldrh	r0, [r5, #6]
c0d03412:	2800      	cmp	r0, #0
c0d03414:	d007      	beq.n	c0d03426 <USBD_GetDescriptor+0xe8>
  {
    
    len = MIN(len , req->wLength);
c0d03416:	4282      	cmp	r2, r0
c0d03418:	d300      	bcc.n	c0d0341c <USBD_GetDescriptor+0xde>
c0d0341a:	4602      	mov	r2, r0
c0d0341c:	a801      	add	r0, sp, #4
c0d0341e:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d03420:	4620      	mov	r0, r4
c0d03422:	f000 fc33 	bl	c0d03c8c <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d03426:	b002      	add	sp, #8
c0d03428:	bdb0      	pop	{r4, r5, r7, pc}
c0d0342a:	20f0      	movs	r0, #240	; 0xf0
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d0342c:	5820      	ldr	r0, [r4, r0]
c0d0342e:	6840      	ldr	r0, [r0, #4]
c0d03430:	e7b2      	b.n	c0d03398 <USBD_GetDescriptor+0x5a>
c0d03432:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d03434:	5820      	ldr	r0, [r4, r0]
c0d03436:	6900      	ldr	r0, [r0, #16]
c0d03438:	e7ae      	b.n	c0d03398 <USBD_GetDescriptor+0x5a>
c0d0343a:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d0343c:	5820      	ldr	r0, [r4, r0]
c0d0343e:	6880      	ldr	r0, [r0, #8]
c0d03440:	e7aa      	b.n	c0d03398 <USBD_GetDescriptor+0x5a>
c0d03442:	20f0      	movs	r0, #240	; 0xf0
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d03444:	5820      	ldr	r0, [r4, r0]
c0d03446:	6940      	ldr	r0, [r0, #20]
c0d03448:	e7a6      	b.n	c0d03398 <USBD_GetDescriptor+0x5a>

c0d0344a <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0344a:	b570      	push	{r4, r5, r6, lr}
c0d0344c:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d0344e:	8888      	ldrh	r0, [r1, #4]
c0d03450:	2800      	cmp	r0, #0
c0d03452:	d106      	bne.n	c0d03462 <USBD_SetAddress+0x18>
c0d03454:	88c8      	ldrh	r0, [r1, #6]
c0d03456:	2800      	cmp	r0, #0
c0d03458:	d103      	bne.n	c0d03462 <USBD_SetAddress+0x18>
c0d0345a:	20dc      	movs	r0, #220	; 0xdc
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d0345c:	5c20      	ldrb	r0, [r4, r0]
c0d0345e:	2803      	cmp	r0, #3
c0d03460:	d103      	bne.n	c0d0346a <USBD_SetAddress+0x20>
c0d03462:	4620      	mov	r0, r4
c0d03464:	f000 fb48 	bl	c0d03af8 <USBD_CtlError>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d03468:	bd70      	pop	{r4, r5, r6, pc}
c0d0346a:	8848      	ldrh	r0, [r1, #2]
c0d0346c:	257f      	movs	r5, #127	; 0x7f
c0d0346e:	4005      	ands	r5, r0
c0d03470:	4626      	mov	r6, r4
c0d03472:	36dc      	adds	r6, #220	; 0xdc
c0d03474:	20de      	movs	r0, #222	; 0xde
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d03476:	5425      	strb	r5, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d03478:	4620      	mov	r0, r4
c0d0347a:	4629      	mov	r1, r5
c0d0347c:	f7ff fd2c 	bl	c0d02ed8 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d03480:	4620      	mov	r0, r4
c0d03482:	f000 fc2e 	bl	c0d03ce2 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d03486:	2d00      	cmp	r5, #0
c0d03488:	d002      	beq.n	c0d03490 <USBD_SetAddress+0x46>
c0d0348a:	2002      	movs	r0, #2
      {
        pdev->dev_state  = USBD_STATE_ADDRESSED;
c0d0348c:	7030      	strb	r0, [r6, #0]
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d0348e:	bd70      	pop	{r4, r5, r6, pc}
c0d03490:	2001      	movs	r0, #1
      {
        pdev->dev_state  = USBD_STATE_ADDRESSED;
      } 
      else 
      {
        pdev->dev_state  = USBD_STATE_DEFAULT; 
c0d03492:	7030      	strb	r0, [r6, #0]
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d03494:	bd70      	pop	{r4, r5, r6, pc}

c0d03496 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d03496:	b570      	push	{r4, r5, r6, lr}
c0d03498:	460d      	mov	r5, r1
c0d0349a:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d0349c:	788e      	ldrb	r6, [r1, #2]
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d0349e:	2e02      	cmp	r6, #2
c0d034a0:	d21d      	bcs.n	c0d034de <USBD_SetConfig+0x48>
c0d034a2:	20dc      	movs	r0, #220	; 0xdc
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d034a4:	5c21      	ldrb	r1, [r4, r0]
c0d034a6:	4620      	mov	r0, r4
c0d034a8:	30dc      	adds	r0, #220	; 0xdc
c0d034aa:	2903      	cmp	r1, #3
c0d034ac:	d007      	beq.n	c0d034be <USBD_SetConfig+0x28>
c0d034ae:	2902      	cmp	r1, #2
c0d034b0:	d115      	bne.n	c0d034de <USBD_SetConfig+0x48>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d034b2:	2e00      	cmp	r6, #0
c0d034b4:	d023      	beq.n	c0d034fe <USBD_SetConfig+0x68>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d034b6:	6066      	str	r6, [r4, #4]
c0d034b8:	2103      	movs	r1, #3
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d034ba:	7001      	strb	r1, [r0, #0]
c0d034bc:	e009      	b.n	c0d034d2 <USBD_SetConfig+0x3c>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d034be:	2e00      	cmp	r6, #0
c0d034c0:	d012      	beq.n	c0d034e8 <USBD_SetConfig+0x52>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d034c2:	6860      	ldr	r0, [r4, #4]
c0d034c4:	42b0      	cmp	r0, r6
c0d034c6:	d01a      	beq.n	c0d034fe <USBD_SetConfig+0x68>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d034c8:	b2c1      	uxtb	r1, r0
c0d034ca:	4620      	mov	r0, r4
c0d034cc:	f7ff fda7 	bl	c0d0301e <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d034d0:	6066      	str	r6, [r4, #4]
c0d034d2:	4620      	mov	r0, r4
c0d034d4:	4631      	mov	r1, r6
c0d034d6:	f7ff fd87 	bl	c0d02fe8 <USBD_SetClassConfig>
c0d034da:	2802      	cmp	r0, #2
c0d034dc:	d10f      	bne.n	c0d034fe <USBD_SetConfig+0x68>
c0d034de:	4620      	mov	r0, r4
c0d034e0:	4629      	mov	r1, r5
c0d034e2:	f000 fb09 	bl	c0d03af8 <USBD_CtlError>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d034e6:	bd70      	pop	{r4, r5, r6, pc}
c0d034e8:	2102      	movs	r1, #2
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d034ea:	7001      	strb	r1, [r0, #0]
c0d034ec:	2000      	movs	r0, #0
        pdev->dev_config = cfgidx;          
c0d034ee:	6060      	str	r0, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d034f0:	4620      	mov	r0, r4
c0d034f2:	4631      	mov	r1, r6
c0d034f4:	f7ff fd93 	bl	c0d0301e <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d034f8:	4620      	mov	r0, r4
c0d034fa:	f000 fbf2 	bl	c0d03ce2 <USBD_CtlSendStatus>
c0d034fe:	4620      	mov	r0, r4
c0d03500:	f000 fbef 	bl	c0d03ce2 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d03504:	bd70      	pop	{r4, r5, r6, pc}

c0d03506 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d03506:	b580      	push	{r7, lr}

  if (req->wLength != 1) 
c0d03508:	88ca      	ldrh	r2, [r1, #6]
c0d0350a:	2a01      	cmp	r2, #1
c0d0350c:	d10a      	bne.n	c0d03524 <USBD_GetConfig+0x1e>
c0d0350e:	22dc      	movs	r2, #220	; 0xdc
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d03510:	5c82      	ldrb	r2, [r0, r2]
c0d03512:	2a03      	cmp	r2, #3
c0d03514:	d009      	beq.n	c0d0352a <USBD_GetConfig+0x24>
c0d03516:	2a02      	cmp	r2, #2
c0d03518:	d104      	bne.n	c0d03524 <USBD_GetConfig+0x1e>
c0d0351a:	2100      	movs	r1, #0
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d0351c:	6081      	str	r1, [r0, #8]
c0d0351e:	4601      	mov	r1, r0
c0d03520:	3108      	adds	r1, #8
c0d03522:	e003      	b.n	c0d0352c <USBD_GetConfig+0x26>
c0d03524:	f000 fae8 	bl	c0d03af8 <USBD_CtlError>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d03528:	bd80      	pop	{r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d0352a:	1d01      	adds	r1, r0, #4
c0d0352c:	2201      	movs	r2, #1
c0d0352e:	f000 fbad 	bl	c0d03c8c <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d03532:	bd80      	pop	{r7, pc}

c0d03534 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d03534:	b5b0      	push	{r4, r5, r7, lr}
c0d03536:	4604      	mov	r4, r0
c0d03538:	20dc      	movs	r0, #220	; 0xdc
  
    
  switch (pdev->dev_state) 
c0d0353a:	5c20      	ldrb	r0, [r4, r0]
c0d0353c:	22fe      	movs	r2, #254	; 0xfe
c0d0353e:	4002      	ands	r2, r0
c0d03540:	2a02      	cmp	r2, #2
c0d03542:	d10e      	bne.n	c0d03562 <USBD_GetStatus+0x2e>
c0d03544:	2001      	movs	r0, #1
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d03546:	60e0      	str	r0, [r4, #12]
c0d03548:	20e4      	movs	r0, #228	; 0xe4
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0354a:	5820      	ldr	r0, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d0354c:	4625      	mov	r5, r4
c0d0354e:	350c      	adds	r5, #12
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d03550:	2800      	cmp	r0, #0
c0d03552:	d00a      	beq.n	c0d0356a <USBD_GetStatus+0x36>
c0d03554:	4620      	mov	r0, r4
c0d03556:	f000 fbd0 	bl	c0d03cfa <USBD_CtlReceiveStatus>
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d0355a:	68e1      	ldr	r1, [r4, #12]
c0d0355c:	2002      	movs	r0, #2
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0355e:	4308      	orrs	r0, r1
c0d03560:	e004      	b.n	c0d0356c <USBD_GetStatus+0x38>
                      (uint8_t *)& pdev->dev_config_status,
                      2);
    break;
    
  default :
    USBD_CtlError(pdev , req);                        
c0d03562:	4620      	mov	r0, r4
c0d03564:	f000 fac8 	bl	c0d03af8 <USBD_CtlError>
    break;
  }
}
c0d03568:	bdb0      	pop	{r4, r5, r7, pc}
c0d0356a:	2003      	movs	r0, #3
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d0356c:	60e0      	str	r0, [r4, #12]
c0d0356e:	2202      	movs	r2, #2
    }
    
    USBD_CtlSendData (pdev, 
c0d03570:	4620      	mov	r0, r4
c0d03572:	4629      	mov	r1, r5
c0d03574:	f000 fb8a 	bl	c0d03c8c <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d03578:	bdb0      	pop	{r4, r5, r7, pc}

c0d0357a <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0357a:	b5b0      	push	{r4, r5, r7, lr}
c0d0357c:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d0357e:	8848      	ldrh	r0, [r1, #2]
c0d03580:	2801      	cmp	r0, #1
c0d03582:	d116      	bne.n	c0d035b2 <USBD_SetFeature+0x38>
c0d03584:	460d      	mov	r5, r1
c0d03586:	20e4      	movs	r0, #228	; 0xe4
c0d03588:	2101      	movs	r1, #1
  {
    pdev->dev_remote_wakeup = 1;  
c0d0358a:	5021      	str	r1, [r4, r0]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d0358c:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d0358e:	2802      	cmp	r0, #2
c0d03590:	d80c      	bhi.n	c0d035ac <USBD_SetFeature+0x32>
c0d03592:	00c0      	lsls	r0, r0, #3
c0d03594:	1820      	adds	r0, r4, r0
c0d03596:	21f4      	movs	r1, #244	; 0xf4
c0d03598:	5840      	ldr	r0, [r0, r1]
{

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
  {
    pdev->dev_remote_wakeup = 1;  
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d0359a:	2800      	cmp	r0, #0
c0d0359c:	d006      	beq.n	c0d035ac <USBD_SetFeature+0x32>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d0359e:	6880      	ldr	r0, [r0, #8]
c0d035a0:	f7fe fd9e 	bl	c0d020e0 <pic>
c0d035a4:	4602      	mov	r2, r0
c0d035a6:	4620      	mov	r0, r4
c0d035a8:	4629      	mov	r1, r5
c0d035aa:	4790      	blx	r2
    }
    USBD_CtlSendStatus(pdev);
c0d035ac:	4620      	mov	r0, r4
c0d035ae:	f000 fb98 	bl	c0d03ce2 <USBD_CtlSendStatus>
  }

}
c0d035b2:	bdb0      	pop	{r4, r5, r7, pc}

c0d035b4 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d035b4:	b5b0      	push	{r4, r5, r7, lr}
c0d035b6:	460d      	mov	r5, r1
c0d035b8:	4604      	mov	r4, r0
c0d035ba:	20dc      	movs	r0, #220	; 0xdc
  switch (pdev->dev_state)
c0d035bc:	5c20      	ldrb	r0, [r4, r0]
c0d035be:	21fe      	movs	r1, #254	; 0xfe
c0d035c0:	4001      	ands	r1, r0
c0d035c2:	2902      	cmp	r1, #2
c0d035c4:	d119      	bne.n	c0d035fa <USBD_ClrFeature+0x46>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d035c6:	8868      	ldrh	r0, [r5, #2]
c0d035c8:	2801      	cmp	r0, #1
c0d035ca:	d11a      	bne.n	c0d03602 <USBD_ClrFeature+0x4e>
c0d035cc:	20e4      	movs	r0, #228	; 0xe4
c0d035ce:	2100      	movs	r1, #0
    {
      pdev->dev_remote_wakeup = 0; 
c0d035d0:	5021      	str	r1, [r4, r0]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d035d2:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d035d4:	2802      	cmp	r0, #2
c0d035d6:	d80c      	bhi.n	c0d035f2 <USBD_ClrFeature+0x3e>
c0d035d8:	00c0      	lsls	r0, r0, #3
c0d035da:	1820      	adds	r0, r4, r0
c0d035dc:	21f4      	movs	r1, #244	; 0xf4
c0d035de:	5840      	ldr	r0, [r0, r1]
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
    {
      pdev->dev_remote_wakeup = 0; 
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d035e0:	2800      	cmp	r0, #0
c0d035e2:	d006      	beq.n	c0d035f2 <USBD_ClrFeature+0x3e>
        ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d035e4:	6880      	ldr	r0, [r0, #8]
c0d035e6:	f7fe fd7b 	bl	c0d020e0 <pic>
c0d035ea:	4602      	mov	r2, r0
c0d035ec:	4620      	mov	r0, r4
c0d035ee:	4629      	mov	r1, r5
c0d035f0:	4790      	blx	r2
      }
      USBD_CtlSendStatus(pdev);
c0d035f2:	4620      	mov	r0, r4
c0d035f4:	f000 fb75 	bl	c0d03ce2 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d035f8:	bdb0      	pop	{r4, r5, r7, pc}
      USBD_CtlSendStatus(pdev);
    }
    break;
    
  default :
     USBD_CtlError(pdev , req);
c0d035fa:	4620      	mov	r0, r4
c0d035fc:	4629      	mov	r1, r5
c0d035fe:	f000 fa7b 	bl	c0d03af8 <USBD_CtlError>
    break;
  }
}
c0d03602:	bdb0      	pop	{r4, r5, r7, pc}

c0d03604 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d03604:	b5b0      	push	{r4, r5, r7, lr}
c0d03606:	460d      	mov	r5, r1
c0d03608:	4604      	mov	r4, r0
c0d0360a:	20dc      	movs	r0, #220	; 0xdc
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d0360c:	5c20      	ldrb	r0, [r4, r0]
c0d0360e:	2803      	cmp	r0, #3
c0d03610:	d116      	bne.n	c0d03640 <USBD_StdItfReq+0x3c>
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d03612:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d03614:	2802      	cmp	r0, #2
c0d03616:	d813      	bhi.n	c0d03640 <USBD_StdItfReq+0x3c>
c0d03618:	00c0      	lsls	r0, r0, #3
c0d0361a:	1820      	adds	r0, r4, r0
c0d0361c:	21f4      	movs	r1, #244	; 0xf4
c0d0361e:	5840      	ldr	r0, [r0, r1]
  
  switch (pdev->dev_state) 
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d03620:	2800      	cmp	r0, #0
c0d03622:	d00d      	beq.n	c0d03640 <USBD_StdItfReq+0x3c>
    {
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d03624:	6880      	ldr	r0, [r0, #8]
c0d03626:	f7fe fd5b 	bl	c0d020e0 <pic>
c0d0362a:	4602      	mov	r2, r0
c0d0362c:	4620      	mov	r0, r4
c0d0362e:	4629      	mov	r1, r5
c0d03630:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d03632:	88e8      	ldrh	r0, [r5, #6]
c0d03634:	2800      	cmp	r0, #0
c0d03636:	d107      	bne.n	c0d03648 <USBD_StdItfReq+0x44>
      {
         USBD_CtlSendStatus(pdev);
c0d03638:	4620      	mov	r0, r4
c0d0363a:	f000 fb52 	bl	c0d03ce2 <USBD_CtlSendStatus>
c0d0363e:	e003      	b.n	c0d03648 <USBD_StdItfReq+0x44>
c0d03640:	4620      	mov	r0, r4
c0d03642:	4629      	mov	r1, r5
c0d03644:	f000 fa58 	bl	c0d03af8 <USBD_CtlError>
c0d03648:	2000      	movs	r0, #0
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d0364a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0364c <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d0364c:	b5b0      	push	{r4, r5, r7, lr}
c0d0364e:	460d      	mov	r5, r1
c0d03650:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d03652:	7808      	ldrb	r0, [r1, #0]
c0d03654:	2260      	movs	r2, #96	; 0x60
c0d03656:	4002      	ands	r2, r0
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d03658:	7909      	ldrb	r1, [r1, #4]
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d0365a:	2a20      	cmp	r2, #32
c0d0365c:	d10f      	bne.n	c0d0367e <USBD_StdEPReq+0x32>
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d0365e:	2902      	cmp	r1, #2
c0d03660:	d80d      	bhi.n	c0d0367e <USBD_StdEPReq+0x32>
c0d03662:	00c8      	lsls	r0, r1, #3
c0d03664:	1820      	adds	r0, r4, r0
c0d03666:	22f4      	movs	r2, #244	; 0xf4
c0d03668:	5880      	ldr	r0, [r0, r2]
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d0366a:	2800      	cmp	r0, #0
c0d0366c:	d007      	beq.n	c0d0367e <USBD_StdEPReq+0x32>
  {
    ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d0366e:	6880      	ldr	r0, [r0, #8]
c0d03670:	f7fe fd36 	bl	c0d020e0 <pic>
c0d03674:	4602      	mov	r2, r0
c0d03676:	4620      	mov	r0, r4
c0d03678:	4629      	mov	r1, r5
c0d0367a:	4790      	blx	r2
c0d0367c:	e066      	b.n	c0d0374c <USBD_StdEPReq+0x100>
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d0367e:	7868      	ldrb	r0, [r5, #1]
c0d03680:	2800      	cmp	r0, #0
c0d03682:	d016      	beq.n	c0d036b2 <USBD_StdEPReq+0x66>
c0d03684:	2801      	cmp	r0, #1
c0d03686:	d01d      	beq.n	c0d036c4 <USBD_StdEPReq+0x78>
c0d03688:	2803      	cmp	r0, #3
c0d0368a:	d15f      	bne.n	c0d0374c <USBD_StdEPReq+0x100>
c0d0368c:	20dc      	movs	r0, #220	; 0xdc
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d0368e:	5c20      	ldrb	r0, [r4, r0]
c0d03690:	2803      	cmp	r0, #3
c0d03692:	d11b      	bne.n	c0d036cc <USBD_StdEPReq+0x80>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d03694:	8868      	ldrh	r0, [r5, #2]
c0d03696:	2800      	cmp	r0, #0
c0d03698:	d107      	bne.n	c0d036aa <USBD_StdEPReq+0x5e>
c0d0369a:	2080      	movs	r0, #128	; 0x80
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d0369c:	4308      	orrs	r0, r1
c0d0369e:	2880      	cmp	r0, #128	; 0x80
c0d036a0:	d003      	beq.n	c0d036aa <USBD_StdEPReq+0x5e>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d036a2:	4620      	mov	r0, r4
c0d036a4:	f7ff fbc0 	bl	c0d02e28 <USBD_LL_StallEP>
          
        }
c0d036a8:	7929      	ldrb	r1, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d036aa:	2902      	cmp	r1, #2
c0d036ac:	d83d      	bhi.n	c0d0372a <USBD_StdEPReq+0xde>
c0d036ae:	00c8      	lsls	r0, r1, #3
c0d036b0:	e02f      	b.n	c0d03712 <USBD_StdEPReq+0xc6>
c0d036b2:	20dc      	movs	r0, #220	; 0xdc
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d036b4:	5c20      	ldrb	r0, [r4, r0]
c0d036b6:	2803      	cmp	r0, #3
c0d036b8:	d017      	beq.n	c0d036ea <USBD_StdEPReq+0x9e>
c0d036ba:	2802      	cmp	r0, #2
c0d036bc:	d110      	bne.n	c0d036e0 <USBD_StdEPReq+0x94>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d036be:	0648      	lsls	r0, r1, #25
c0d036c0:	d10a      	bne.n	c0d036d8 <USBD_StdEPReq+0x8c>
c0d036c2:	e043      	b.n	c0d0374c <USBD_StdEPReq+0x100>
c0d036c4:	20dc      	movs	r0, #220	; 0xdc
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d036c6:	5c20      	ldrb	r0, [r4, r0]
c0d036c8:	2803      	cmp	r0, #3
c0d036ca:	d016      	beq.n	c0d036fa <USBD_StdEPReq+0xae>
c0d036cc:	2802      	cmp	r0, #2
c0d036ce:	d107      	bne.n	c0d036e0 <USBD_StdEPReq+0x94>
c0d036d0:	2080      	movs	r0, #128	; 0x80
c0d036d2:	4308      	orrs	r0, r1
c0d036d4:	2880      	cmp	r0, #128	; 0x80
c0d036d6:	d039      	beq.n	c0d0374c <USBD_StdEPReq+0x100>
c0d036d8:	4620      	mov	r0, r4
c0d036da:	f7ff fba5 	bl	c0d02e28 <USBD_LL_StallEP>
c0d036de:	e035      	b.n	c0d0374c <USBD_StdEPReq+0x100>
c0d036e0:	4620      	mov	r0, r4
c0d036e2:	4629      	mov	r1, r5
c0d036e4:	f000 fa08 	bl	c0d03af8 <USBD_CtlError>
c0d036e8:	e030      	b.n	c0d0374c <USBD_StdEPReq+0x100>
c0d036ea:	207f      	movs	r0, #127	; 0x7f
c0d036ec:	4008      	ands	r0, r1
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d036ee:	0100      	lsls	r0, r0, #4
c0d036f0:	1825      	adds	r5, r4, r0
c0d036f2:	0608      	lsls	r0, r1, #24
c0d036f4:	d51d      	bpl.n	c0d03732 <USBD_StdEPReq+0xe6>
c0d036f6:	3514      	adds	r5, #20
c0d036f8:	e01c      	b.n	c0d03734 <USBD_StdEPReq+0xe8>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d036fa:	8868      	ldrh	r0, [r5, #2]
c0d036fc:	2800      	cmp	r0, #0
c0d036fe:	d125      	bne.n	c0d0374c <USBD_StdEPReq+0x100>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d03700:	0648      	lsls	r0, r1, #25
c0d03702:	d012      	beq.n	c0d0372a <USBD_StdEPReq+0xde>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d03704:	4620      	mov	r0, r4
c0d03706:	f7ff fbb3 	bl	c0d02e70 <USBD_LL_ClearStallEP>
          if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d0370a:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d0370c:	2802      	cmp	r0, #2
c0d0370e:	d80c      	bhi.n	c0d0372a <USBD_StdEPReq+0xde>
c0d03710:	00c0      	lsls	r0, r0, #3
c0d03712:	1820      	adds	r0, r4, r0
c0d03714:	21f4      	movs	r1, #244	; 0xf4
c0d03716:	5840      	ldr	r0, [r0, r1]
c0d03718:	2800      	cmp	r0, #0
c0d0371a:	d006      	beq.n	c0d0372a <USBD_StdEPReq+0xde>
c0d0371c:	6880      	ldr	r0, [r0, #8]
c0d0371e:	f7fe fcdf 	bl	c0d020e0 <pic>
c0d03722:	4602      	mov	r2, r0
c0d03724:	4620      	mov	r0, r4
c0d03726:	4629      	mov	r1, r5
c0d03728:	4790      	blx	r2
c0d0372a:	4620      	mov	r0, r4
c0d0372c:	f000 fad9 	bl	c0d03ce2 <USBD_CtlSendStatus>
c0d03730:	e00c      	b.n	c0d0374c <USBD_StdEPReq+0x100>
c0d03732:	3574      	adds	r5, #116	; 0x74
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d03734:	4620      	mov	r0, r4
c0d03736:	f7ff fbbf 	bl	c0d02eb8 <USBD_LL_IsStallEP>
c0d0373a:	2800      	cmp	r0, #0
c0d0373c:	d000      	beq.n	c0d03740 <USBD_StdEPReq+0xf4>
c0d0373e:	2001      	movs	r0, #1
c0d03740:	6028      	str	r0, [r5, #0]
c0d03742:	2202      	movs	r2, #2
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d03744:	4620      	mov	r0, r4
c0d03746:	4629      	mov	r1, r5
c0d03748:	f000 faa0 	bl	c0d03c8c <USBD_CtlSendData>
c0d0374c:	2000      	movs	r0, #0
    
  default:
    break;
  }
  return ret;
}
c0d0374e:	bdb0      	pop	{r4, r5, r7, pc}

c0d03750 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d03750:	780a      	ldrb	r2, [r1, #0]
c0d03752:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d03754:	784a      	ldrb	r2, [r1, #1]
c0d03756:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d03758:	788a      	ldrb	r2, [r1, #2]
c0d0375a:	78cb      	ldrb	r3, [r1, #3]
c0d0375c:	021b      	lsls	r3, r3, #8
c0d0375e:	189a      	adds	r2, r3, r2
c0d03760:	8042      	strh	r2, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d03762:	790a      	ldrb	r2, [r1, #4]
c0d03764:	794b      	ldrb	r3, [r1, #5]
c0d03766:	021b      	lsls	r3, r3, #8
c0d03768:	189a      	adds	r2, r3, r2
c0d0376a:	8082      	strh	r2, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d0376c:	798a      	ldrb	r2, [r1, #6]
c0d0376e:	79c9      	ldrb	r1, [r1, #7]
c0d03770:	0209      	lsls	r1, r1, #8
c0d03772:	1889      	adds	r1, r1, r2
c0d03774:	80c1      	strh	r1, [r0, #6]

}
c0d03776:	4770      	bx	lr

c0d03778 <USBD_CtlStall>:
* @param  pdev: device instance
* @param  req: usb request
* @retval None
*/
void USBD_CtlStall( USBD_HandleTypeDef *pdev)
{
c0d03778:	b510      	push	{r4, lr}
c0d0377a:	4604      	mov	r4, r0
c0d0377c:	2180      	movs	r1, #128	; 0x80
  USBD_LL_StallEP(pdev , 0x80);
c0d0377e:	f7ff fb53 	bl	c0d02e28 <USBD_LL_StallEP>
c0d03782:	2100      	movs	r1, #0
  USBD_LL_StallEP(pdev , 0);
c0d03784:	4620      	mov	r0, r4
c0d03786:	f7ff fb4f 	bl	c0d02e28 <USBD_LL_StallEP>
}
c0d0378a:	bd10      	pop	{r4, pc}

c0d0378c <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d0378c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0378e:	b083      	sub	sp, #12
c0d03790:	460e      	mov	r6, r1
c0d03792:	4605      	mov	r5, r0
c0d03794:	a802      	add	r0, sp, #8
c0d03796:	2400      	movs	r4, #0
  uint16_t len = 0;
c0d03798:	8004      	strh	r4, [r0, #0]
c0d0379a:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d0379c:	7004      	strb	r4, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d0379e:	7809      	ldrb	r1, [r1, #0]
c0d037a0:	2060      	movs	r0, #96	; 0x60
c0d037a2:	4008      	ands	r0, r1
c0d037a4:	2800      	cmp	r0, #0
c0d037a6:	d010      	beq.n	c0d037ca <USBD_HID_Setup+0x3e>
c0d037a8:	2820      	cmp	r0, #32
c0d037aa:	d137      	bne.n	c0d0381c <USBD_HID_Setup+0x90>
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d037ac:	7870      	ldrb	r0, [r6, #1]
c0d037ae:	4601      	mov	r1, r0
c0d037b0:	390a      	subs	r1, #10
c0d037b2:	2902      	cmp	r1, #2
c0d037b4:	d332      	bcc.n	c0d0381c <USBD_HID_Setup+0x90>
c0d037b6:	2802      	cmp	r0, #2
c0d037b8:	d01b      	beq.n	c0d037f2 <USBD_HID_Setup+0x66>
c0d037ba:	2803      	cmp	r0, #3
c0d037bc:	d019      	beq.n	c0d037f2 <USBD_HID_Setup+0x66>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d037be:	4628      	mov	r0, r5
c0d037c0:	4631      	mov	r1, r6
c0d037c2:	f000 f999 	bl	c0d03af8 <USBD_CtlError>
c0d037c6:	2402      	movs	r4, #2
c0d037c8:	e028      	b.n	c0d0381c <USBD_HID_Setup+0x90>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d037ca:	7870      	ldrb	r0, [r6, #1]
c0d037cc:	280b      	cmp	r0, #11
c0d037ce:	d013      	beq.n	c0d037f8 <USBD_HID_Setup+0x6c>
c0d037d0:	280a      	cmp	r0, #10
c0d037d2:	d00e      	beq.n	c0d037f2 <USBD_HID_Setup+0x66>
c0d037d4:	2806      	cmp	r0, #6
c0d037d6:	d121      	bne.n	c0d0381c <USBD_HID_Setup+0x90>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d037d8:	78f0      	ldrb	r0, [r6, #3]
c0d037da:	2400      	movs	r4, #0
c0d037dc:	2821      	cmp	r0, #33	; 0x21
c0d037de:	d00f      	beq.n	c0d03800 <USBD_HID_Setup+0x74>
c0d037e0:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d037e2:	4622      	mov	r2, r4
c0d037e4:	4621      	mov	r1, r4
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d037e6:	d116      	bne.n	c0d03816 <USBD_HID_Setup+0x8a>
c0d037e8:	af02      	add	r7, sp, #8
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d037ea:	4638      	mov	r0, r7
c0d037ec:	f000 f858 	bl	c0d038a0 <USBD_HID_GetReportDescriptor_impl>
c0d037f0:	e00a      	b.n	c0d03808 <USBD_HID_Setup+0x7c>
c0d037f2:	a901      	add	r1, sp, #4
c0d037f4:	2201      	movs	r2, #1
c0d037f6:	e00e      	b.n	c0d03816 <USBD_HID_Setup+0x8a>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d037f8:	4628      	mov	r0, r5
c0d037fa:	f000 fa72 	bl	c0d03ce2 <USBD_CtlSendStatus>
c0d037fe:	e00d      	b.n	c0d0381c <USBD_HID_Setup+0x90>
c0d03800:	af02      	add	r7, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d03802:	4638      	mov	r0, r7
c0d03804:	f000 f832 	bl	c0d0386c <USBD_HID_GetHidDescriptor_impl>
c0d03808:	4601      	mov	r1, r0
c0d0380a:	883a      	ldrh	r2, [r7, #0]
c0d0380c:	88f0      	ldrh	r0, [r6, #6]
c0d0380e:	4282      	cmp	r2, r0
c0d03810:	d300      	bcc.n	c0d03814 <USBD_HID_Setup+0x88>
c0d03812:	4602      	mov	r2, r0
c0d03814:	803a      	strh	r2, [r7, #0]
c0d03816:	4628      	mov	r0, r5
c0d03818:	f000 fa38 	bl	c0d03c8c <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d0381c:	4620      	mov	r0, r4
c0d0381e:	b003      	add	sp, #12
c0d03820:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03822 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d03822:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03824:	b081      	sub	sp, #4
c0d03826:	4604      	mov	r4, r0
c0d03828:	2182      	movs	r1, #130	; 0x82
c0d0382a:	2603      	movs	r6, #3
c0d0382c:	2540      	movs	r5, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d0382e:	4632      	mov	r2, r6
c0d03830:	462b      	mov	r3, r5
c0d03832:	f7ff fab3 	bl	c0d02d9c <USBD_LL_OpenEP>
c0d03836:	2702      	movs	r7, #2
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d03838:	4620      	mov	r0, r4
c0d0383a:	4639      	mov	r1, r7
c0d0383c:	4632      	mov	r2, r6
c0d0383e:	462b      	mov	r3, r5
c0d03840:	f7ff faac 	bl	c0d02d9c <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d03844:	4620      	mov	r0, r4
c0d03846:	4639      	mov	r1, r7
c0d03848:	462a      	mov	r2, r5
c0d0384a:	f7ff fb70 	bl	c0d02f2e <USBD_LL_PrepareReceive>
c0d0384e:	2000      	movs	r0, #0
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d03850:	b001      	add	sp, #4
c0d03852:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d03854 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d03854:	b510      	push	{r4, lr}
c0d03856:	4604      	mov	r4, r0
c0d03858:	2182      	movs	r1, #130	; 0x82
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d0385a:	f7ff facf 	bl	c0d02dfc <USBD_LL_CloseEP>
c0d0385e:	2102      	movs	r1, #2
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d03860:	4620      	mov	r0, r4
c0d03862:	f7ff facb 	bl	c0d02dfc <USBD_LL_CloseEP>
c0d03866:	2000      	movs	r0, #0
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d03868:	bd10      	pop	{r4, pc}
	...

c0d0386c <USBD_HID_GetHidDescriptor_impl>:
{
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
c0d0386c:	21ec      	movs	r1, #236	; 0xec
  switch (USBD_Device.request.wIndex&0xFF) {
c0d0386e:	4a09      	ldr	r2, [pc, #36]	; (c0d03894 <USBD_HID_GetHidDescriptor_impl+0x28>)
c0d03870:	5c51      	ldrb	r1, [r2, r1]
c0d03872:	2209      	movs	r2, #9
c0d03874:	2901      	cmp	r1, #1
c0d03876:	d004      	beq.n	c0d03882 <USBD_HID_GetHidDescriptor_impl+0x16>
c0d03878:	2900      	cmp	r1, #0
c0d0387a:	d105      	bne.n	c0d03888 <USBD_HID_GetHidDescriptor_impl+0x1c>
c0d0387c:	4907      	ldr	r1, [pc, #28]	; (c0d0389c <USBD_HID_GetHidDescriptor_impl+0x30>)
c0d0387e:	4479      	add	r1, pc
c0d03880:	e004      	b.n	c0d0388c <USBD_HID_GetHidDescriptor_impl+0x20>
c0d03882:	4905      	ldr	r1, [pc, #20]	; (c0d03898 <USBD_HID_GetHidDescriptor_impl+0x2c>)
c0d03884:	4479      	add	r1, pc
c0d03886:	e001      	b.n	c0d0388c <USBD_HID_GetHidDescriptor_impl+0x20>
c0d03888:	2200      	movs	r2, #0
c0d0388a:	4611      	mov	r1, r2
c0d0388c:	8002      	strh	r2, [r0, #0]
      *len = sizeof(USBD_HID_Desc);
      return (uint8_t*)USBD_HID_Desc; 
  }
  *len = 0;
  return 0;
}
c0d0388e:	4608      	mov	r0, r1
c0d03890:	4770      	bx	lr
c0d03892:	46c0      	nop			; (mov r8, r8)
c0d03894:	20002010 	.word	0x20002010
c0d03898:	00001098 	.word	0x00001098
c0d0389c:	000010aa 	.word	0x000010aa

c0d038a0 <USBD_HID_GetReportDescriptor_impl>:

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
c0d038a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d038a2:	b081      	sub	sp, #4
c0d038a4:	4602      	mov	r2, r0
c0d038a6:	20ec      	movs	r0, #236	; 0xec
  switch (USBD_Device.request.wIndex&0xFF) {
c0d038a8:	4913      	ldr	r1, [pc, #76]	; (c0d038f8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d038aa:	5c08      	ldrb	r0, [r1, r0]
c0d038ac:	2422      	movs	r4, #34	; 0x22
c0d038ae:	2800      	cmp	r0, #0
c0d038b0:	d01a      	beq.n	c0d038e8 <USBD_HID_GetReportDescriptor_impl+0x48>
c0d038b2:	2801      	cmp	r0, #1
c0d038b4:	d11b      	bne.n	c0d038ee <USBD_HID_GetReportDescriptor_impl+0x4e>
#ifdef HAVE_IO_U2F
  case U2F_INTF:

    // very dirty work due to lack of callback when USB_HID_Init is called
    USBD_LL_OpenEP(&USBD_Device,
c0d038b6:	4810      	ldr	r0, [pc, #64]	; (c0d038f8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d038b8:	2181      	movs	r1, #129	; 0x81
c0d038ba:	2703      	movs	r7, #3
c0d038bc:	2640      	movs	r6, #64	; 0x40
c0d038be:	9200      	str	r2, [sp, #0]
c0d038c0:	463a      	mov	r2, r7
c0d038c2:	4633      	mov	r3, r6
c0d038c4:	f7ff fa6a 	bl	c0d02d9c <USBD_LL_OpenEP>
c0d038c8:	2501      	movs	r5, #1
                   U2F_EPIN_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPIN_SIZE);
    
    USBD_LL_OpenEP(&USBD_Device,
c0d038ca:	480b      	ldr	r0, [pc, #44]	; (c0d038f8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d038cc:	4629      	mov	r1, r5
c0d038ce:	463a      	mov	r2, r7
c0d038d0:	4633      	mov	r3, r6
c0d038d2:	f7ff fa63 	bl	c0d02d9c <USBD_LL_OpenEP>
                   U2F_EPOUT_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPOUT_SIZE);

    /* Prepare Out endpoint to receive 1st packet */ 
    USBD_LL_PrepareReceive(&USBD_Device, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d038d6:	4808      	ldr	r0, [pc, #32]	; (c0d038f8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d038d8:	4629      	mov	r1, r5
c0d038da:	4632      	mov	r2, r6
c0d038dc:	f7ff fb27 	bl	c0d02f2e <USBD_LL_PrepareReceive>
c0d038e0:	9a00      	ldr	r2, [sp, #0]
c0d038e2:	4807      	ldr	r0, [pc, #28]	; (c0d03900 <USBD_HID_GetReportDescriptor_impl+0x60>)
c0d038e4:	4478      	add	r0, pc
c0d038e6:	e004      	b.n	c0d038f2 <USBD_HID_GetReportDescriptor_impl+0x52>
c0d038e8:	4804      	ldr	r0, [pc, #16]	; (c0d038fc <USBD_HID_GetReportDescriptor_impl+0x5c>)
c0d038ea:	4478      	add	r0, pc
c0d038ec:	e001      	b.n	c0d038f2 <USBD_HID_GetReportDescriptor_impl+0x52>
c0d038ee:	2400      	movs	r4, #0
c0d038f0:	4620      	mov	r0, r4
c0d038f2:	8014      	strh	r4, [r2, #0]
    *len = sizeof(HID_ReportDesc);
    return (uint8_t*)HID_ReportDesc;
  }
  *len = 0;
  return 0;
}
c0d038f4:	b001      	add	sp, #4
c0d038f6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d038f8:	20002010 	.word	0x20002010
c0d038fc:	00001069 	.word	0x00001069
c0d03900:	0000104d 	.word	0x0000104d

c0d03904 <USBD_U2F_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_U2F_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d03904:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03906:	b081      	sub	sp, #4
c0d03908:	4604      	mov	r4, r0
c0d0390a:	2181      	movs	r1, #129	; 0x81
c0d0390c:	2603      	movs	r6, #3
c0d0390e:	2540      	movs	r5, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d03910:	4632      	mov	r2, r6
c0d03912:	462b      	mov	r3, r5
c0d03914:	f7ff fa42 	bl	c0d02d9c <USBD_LL_OpenEP>
c0d03918:	2701      	movs	r7, #1
                 U2F_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d0391a:	4620      	mov	r0, r4
c0d0391c:	4639      	mov	r1, r7
c0d0391e:	4632      	mov	r2, r6
c0d03920:	462b      	mov	r3, r5
c0d03922:	f7ff fa3b 	bl	c0d02d9c <USBD_LL_OpenEP>
                 U2F_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d03926:	4620      	mov	r0, r4
c0d03928:	4639      	mov	r1, r7
c0d0392a:	462a      	mov	r2, r5
c0d0392c:	f7ff faff 	bl	c0d02f2e <USBD_LL_PrepareReceive>
c0d03930:	2000      	movs	r0, #0

  return USBD_OK;
c0d03932:	b001      	add	sp, #4
c0d03934:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d03938 <USBD_U2F_DataIn_impl>:
}

uint8_t  USBD_U2F_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d03938:	b580      	push	{r7, lr}
  UNUSED(pdev);
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d0393a:	2901      	cmp	r1, #1
c0d0393c:	d103      	bne.n	c0d03946 <USBD_U2F_DataIn_impl+0xe>
  // FIDO endpoint
  case (U2F_EPIN_ADDR&0x7F):
    // advance the u2f sending machine state
    u2f_transport_sent(&G_io_u2f, U2F_MEDIA_USB);
c0d0393e:	4803      	ldr	r0, [pc, #12]	; (c0d0394c <USBD_U2F_DataIn_impl+0x14>)
c0d03940:	2101      	movs	r1, #1
c0d03942:	f7fe feb1 	bl	c0d026a8 <u2f_transport_sent>
c0d03946:	2000      	movs	r0, #0
    break;
  } 
  return USBD_OK;
c0d03948:	bd80      	pop	{r7, pc}
c0d0394a:	46c0      	nop			; (mov r8, r8)
c0d0394c:	20001f70 	.word	0x20001f70

c0d03950 <USBD_U2F_DataOut_impl>:
}

uint8_t  USBD_U2F_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03950:	b5b0      	push	{r4, r5, r7, lr}
  switch (epnum) {
c0d03952:	2901      	cmp	r1, #1
c0d03954:	d10e      	bne.n	c0d03974 <USBD_U2F_DataOut_impl+0x24>
c0d03956:	4614      	mov	r4, r2
c0d03958:	2501      	movs	r5, #1
c0d0395a:	2240      	movs	r2, #64	; 0x40
  // FIDO endpoint
  case (U2F_EPOUT_ADDR&0x7F):
      USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR , U2F_EPOUT_SIZE);
c0d0395c:	4629      	mov	r1, r5
c0d0395e:	f7ff fae6 	bl	c0d02f2e <USBD_LL_PrepareReceive>
      u2f_transport_received(&G_io_u2f, buffer, io_seproxyhal_get_ep_rx_size(U2F_EPOUT_ADDR), U2F_MEDIA_USB);
c0d03962:	4628      	mov	r0, r5
c0d03964:	f7fd fd0c 	bl	c0d01380 <io_seproxyhal_get_ep_rx_size>
c0d03968:	4602      	mov	r2, r0
c0d0396a:	4803      	ldr	r0, [pc, #12]	; (c0d03978 <USBD_U2F_DataOut_impl+0x28>)
c0d0396c:	4621      	mov	r1, r4
c0d0396e:	462b      	mov	r3, r5
c0d03970:	f7fe ffe2 	bl	c0d02938 <u2f_transport_received>
c0d03974:	2000      	movs	r0, #0
    break;
  }

  return USBD_OK;
c0d03976:	bdb0      	pop	{r4, r5, r7, pc}
c0d03978:	20001f70 	.word	0x20001f70

c0d0397c <USBD_HID_DataIn_impl>:
}
#endif // HAVE_IO_U2F

uint8_t  USBD_HID_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d0397c:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d0397e:	2902      	cmp	r1, #2
c0d03980:	d103      	bne.n	c0d0398a <USBD_HID_DataIn_impl+0xe>
    // HID gen endpoint
    case (HID_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data);
c0d03982:	4803      	ldr	r0, [pc, #12]	; (c0d03990 <USBD_HID_DataIn_impl+0x14>)
c0d03984:	4478      	add	r0, pc
c0d03986:	f7fe f959 	bl	c0d01c3c <io_usb_hid_sent>
c0d0398a:	2000      	movs	r0, #0
      break;
  }

  return USBD_OK;
c0d0398c:	bd80      	pop	{r7, pc}
c0d0398e:	46c0      	nop			; (mov r8, r8)
c0d03990:	ffffdac5 	.word	0xffffdac5

c0d03994 <USBD_HID_DataOut_impl>:
}

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03994:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d03996:	2902      	cmp	r1, #2
c0d03998:	d11a      	bne.n	c0d039d0 <USBD_HID_DataOut_impl+0x3c>
c0d0399a:	4614      	mov	r4, r2
c0d0399c:	2102      	movs	r1, #2
c0d0399e:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (HID_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d039a0:	f7ff fac5 	bl	c0d02f2e <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d039a4:	4d0b      	ldr	r5, [pc, #44]	; (c0d039d4 <USBD_HID_DataOut_impl+0x40>)
c0d039a6:	79a8      	ldrb	r0, [r5, #6]
c0d039a8:	2800      	cmp	r0, #0
c0d039aa:	d111      	bne.n	c0d039d0 <USBD_HID_DataOut_impl+0x3c>
c0d039ac:	2002      	movs	r0, #2
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d039ae:	f7fd fce7 	bl	c0d01380 <io_seproxyhal_get_ep_rx_size>
c0d039b2:	4602      	mov	r2, r0
c0d039b4:	4809      	ldr	r0, [pc, #36]	; (c0d039dc <USBD_HID_DataOut_impl+0x48>)
c0d039b6:	4478      	add	r0, pc
c0d039b8:	4621      	mov	r1, r4
c0d039ba:	f7fe f891 	bl	c0d01ae0 <io_usb_hid_receive>
c0d039be:	2802      	cmp	r0, #2
c0d039c0:	d106      	bne.n	c0d039d0 <USBD_HID_DataOut_impl+0x3c>
c0d039c2:	2007      	movs	r0, #7
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
          G_io_app.apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d039c4:	7028      	strb	r0, [r5, #0]
c0d039c6:	2001      	movs	r0, #1
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d039c8:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_state = APDU_USB_HID; // for next call to io_exchange
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d039ca:	4803      	ldr	r0, [pc, #12]	; (c0d039d8 <USBD_HID_DataOut_impl+0x44>)
c0d039cc:	6800      	ldr	r0, [r0, #0]
c0d039ce:	8068      	strh	r0, [r5, #2]
c0d039d0:	2000      	movs	r0, #0
      }
    }
    break;
  }

  return USBD_OK;
c0d039d2:	bdb0      	pop	{r4, r5, r7, pc}
c0d039d4:	20001f48 	.word	0x20001f48
c0d039d8:	20001ff8 	.word	0x20001ff8
c0d039dc:	ffffda93 	.word	0xffffda93

c0d039e0 <USBD_WEBUSB_Init>:

#ifdef HAVE_WEBUSB

uint8_t  USBD_WEBUSB_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d039e0:	b570      	push	{r4, r5, r6, lr}
c0d039e2:	4604      	mov	r4, r0
c0d039e4:	2183      	movs	r1, #131	; 0x83
c0d039e6:	2503      	movs	r5, #3
c0d039e8:	2640      	movs	r6, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d039ea:	462a      	mov	r2, r5
c0d039ec:	4633      	mov	r3, r6
c0d039ee:	f7ff f9d5 	bl	c0d02d9c <USBD_LL_OpenEP>
                 WEBUSB_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d039f2:	4620      	mov	r0, r4
c0d039f4:	4629      	mov	r1, r5
c0d039f6:	462a      	mov	r2, r5
c0d039f8:	4633      	mov	r3, r6
c0d039fa:	f7ff f9cf 	bl	c0d02d9c <USBD_LL_OpenEP>
                 WEBUSB_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d039fe:	4620      	mov	r0, r4
c0d03a00:	4629      	mov	r1, r5
c0d03a02:	4632      	mov	r2, r6
c0d03a04:	f7ff fa93 	bl	c0d02f2e <USBD_LL_PrepareReceive>
c0d03a08:	2000      	movs	r0, #0

  return USBD_OK;
c0d03a0a:	bd70      	pop	{r4, r5, r6, pc}

c0d03a0c <USBD_WEBUSB_DeInit>:
}

uint8_t  USBD_WEBUSB_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx) {
c0d03a0c:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(cfgidx);
  return USBD_OK;
c0d03a0e:	4770      	bx	lr

c0d03a10 <USBD_WEBUSB_Setup>:
}

uint8_t  USBD_WEBUSB_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d03a10:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(req);
  return USBD_OK;
c0d03a12:	4770      	bx	lr

c0d03a14 <USBD_WEBUSB_DataIn>:
}

uint8_t  USBD_WEBUSB_DataIn (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d03a14:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d03a16:	2903      	cmp	r1, #3
c0d03a18:	d103      	bne.n	c0d03a22 <USBD_WEBUSB_DataIn+0xe>
    // HID gen endpoint
    case (WEBUSB_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data_ep0x83);
c0d03a1a:	4803      	ldr	r0, [pc, #12]	; (c0d03a28 <USBD_WEBUSB_DataIn+0x14>)
c0d03a1c:	4478      	add	r0, pc
c0d03a1e:	f7fe f90d 	bl	c0d01c3c <io_usb_hid_sent>
c0d03a22:	2000      	movs	r0, #0
      break;
  }
  return USBD_OK;
c0d03a24:	bd80      	pop	{r7, pc}
c0d03a26:	46c0      	nop			; (mov r8, r8)
c0d03a28:	ffffda3d 	.word	0xffffda3d

c0d03a2c <USBD_WEBUSB_DataOut>:
}

uint8_t USBD_WEBUSB_DataOut (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d03a2c:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d03a2e:	2903      	cmp	r1, #3
c0d03a30:	d11a      	bne.n	c0d03a68 <USBD_WEBUSB_DataOut+0x3c>
c0d03a32:	4614      	mov	r4, r2
c0d03a34:	2103      	movs	r1, #3
c0d03a36:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (WEBUSB_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d03a38:	f7ff fa79 	bl	c0d02f2e <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d03a3c:	4d0b      	ldr	r5, [pc, #44]	; (c0d03a6c <USBD_WEBUSB_DataOut+0x40>)
c0d03a3e:	79a8      	ldrb	r0, [r5, #6]
c0d03a40:	2800      	cmp	r0, #0
c0d03a42:	d111      	bne.n	c0d03a68 <USBD_WEBUSB_DataOut+0x3c>
c0d03a44:	2003      	movs	r0, #3
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data_ep0x83, buffer, io_seproxyhal_get_ep_rx_size(WEBUSB_EPOUT_ADDR))) {
c0d03a46:	f7fd fc9b 	bl	c0d01380 <io_seproxyhal_get_ep_rx_size>
c0d03a4a:	4602      	mov	r2, r0
c0d03a4c:	4809      	ldr	r0, [pc, #36]	; (c0d03a74 <USBD_WEBUSB_DataOut+0x48>)
c0d03a4e:	4478      	add	r0, pc
c0d03a50:	4621      	mov	r1, r4
c0d03a52:	f7fe f845 	bl	c0d01ae0 <io_usb_hid_receive>
c0d03a56:	2802      	cmp	r0, #2
c0d03a58:	d106      	bne.n	c0d03a68 <USBD_WEBUSB_DataOut+0x3c>
c0d03a5a:	200b      	movs	r0, #11
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
          G_io_app.apdu_state = APDU_USB_WEBUSB; // for next call to io_exchange
c0d03a5c:	7028      	strb	r0, [r5, #0]
c0d03a5e:	2005      	movs	r0, #5
      switch(io_usb_hid_receive(io_usb_send_apdu_data_ep0x83, buffer, io_seproxyhal_get_ep_rx_size(WEBUSB_EPOUT_ADDR))) {
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
c0d03a60:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_state = APDU_USB_WEBUSB; // for next call to io_exchange
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d03a62:	4803      	ldr	r0, [pc, #12]	; (c0d03a70 <USBD_WEBUSB_DataOut+0x44>)
c0d03a64:	6800      	ldr	r0, [r0, #0]
c0d03a66:	8068      	strh	r0, [r5, #2]
c0d03a68:	2000      	movs	r0, #0
      }
    }
    break;
  }

  return USBD_OK;
c0d03a6a:	bdb0      	pop	{r4, r5, r7, pc}
c0d03a6c:	20001f48 	.word	0x20001f48
c0d03a70:	20001ff8 	.word	0x20001ff8
c0d03a74:	ffffda0b 	.word	0xffffda0b

c0d03a78 <USBD_DeviceDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03a78:	2012      	movs	r0, #18
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d03a7a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d03a7c:	4801      	ldr	r0, [pc, #4]	; (c0d03a84 <USBD_DeviceDescriptor+0xc>)
c0d03a7e:	4478      	add	r0, pc
c0d03a80:	4770      	bx	lr
c0d03a82:	46c0      	nop			; (mov r8, r8)
c0d03a84:	0000116a 	.word	0x0000116a

c0d03a88 <USBD_LangIDStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03a88:	2004      	movs	r0, #4
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d03a8a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d03a8c:	4801      	ldr	r0, [pc, #4]	; (c0d03a94 <USBD_LangIDStrDescriptor+0xc>)
c0d03a8e:	4478      	add	r0, pc
c0d03a90:	4770      	bx	lr
c0d03a92:	46c0      	nop			; (mov r8, r8)
c0d03a94:	0000116c 	.word	0x0000116c

c0d03a98 <USBD_ManufacturerStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03a98:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d03a9a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d03a9c:	4801      	ldr	r0, [pc, #4]	; (c0d03aa4 <USBD_ManufacturerStrDescriptor+0xc>)
c0d03a9e:	4478      	add	r0, pc
c0d03aa0:	4770      	bx	lr
c0d03aa2:	46c0      	nop			; (mov r8, r8)
c0d03aa4:	00001160 	.word	0x00001160

c0d03aa8 <USBD_ProductStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03aa8:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d03aaa:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d03aac:	4801      	ldr	r0, [pc, #4]	; (c0d03ab4 <USBD_ProductStrDescriptor+0xc>)
c0d03aae:	4478      	add	r0, pc
c0d03ab0:	4770      	bx	lr
c0d03ab2:	46c0      	nop			; (mov r8, r8)
c0d03ab4:	0000115e 	.word	0x0000115e

c0d03ab8 <USBD_SerialStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03ab8:	200a      	movs	r0, #10
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d03aba:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d03abc:	4801      	ldr	r0, [pc, #4]	; (c0d03ac4 <USBD_SerialStrDescriptor+0xc>)
c0d03abe:	4478      	add	r0, pc
c0d03ac0:	4770      	bx	lr
c0d03ac2:	46c0      	nop			; (mov r8, r8)
c0d03ac4:	0000115c 	.word	0x0000115c

c0d03ac8 <USBD_ConfigStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03ac8:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d03aca:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d03acc:	4801      	ldr	r0, [pc, #4]	; (c0d03ad4 <USBD_ConfigStrDescriptor+0xc>)
c0d03ace:	4478      	add	r0, pc
c0d03ad0:	4770      	bx	lr
c0d03ad2:	46c0      	nop			; (mov r8, r8)
c0d03ad4:	0000113e 	.word	0x0000113e

c0d03ad8 <USBD_InterfaceStrDescriptor>:
  * @param  speed: Current device speed
  * @param  length: Pointer to data length variable
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03ad8:	200e      	movs	r0, #14
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d03ada:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d03adc:	4801      	ldr	r0, [pc, #4]	; (c0d03ae4 <USBD_InterfaceStrDescriptor+0xc>)
c0d03ade:	4478      	add	r0, pc
c0d03ae0:	4770      	bx	lr
c0d03ae2:	46c0      	nop			; (mov r8, r8)
c0d03ae4:	0000112e 	.word	0x0000112e

c0d03ae8 <USBD_BOSDescriptor>:
};

#endif // HAVE_WEBUSB

static uint8_t *USBD_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d03ae8:	2039      	movs	r0, #57	; 0x39
  UNUSED(speed);
#ifdef HAVE_WEBUSB
  *length = sizeof(C_usb_bos);
c0d03aea:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)C_usb_bos;
c0d03aec:	4801      	ldr	r0, [pc, #4]	; (c0d03af4 <USBD_BOSDescriptor+0xc>)
c0d03aee:	4478      	add	r0, pc
c0d03af0:	4770      	bx	lr
c0d03af2:	46c0      	nop			; (mov r8, r8)
c0d03af4:	00000e9e 	.word	0x00000e9e

c0d03af8 <USBD_CtlError>:
  '4', 0x00, '6', 0x00, '7', 0x00, '6', 0x00, '5', 0x00, '7', 0x00,
  '2', 0x00, '}', 0x00, 0x00, 0x00, 0x00, 0x00 // propertyData, double unicode nul terminated
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
c0d03af8:	b580      	push	{r7, lr}
#if WEBUSB_URL_SIZE_B > 0
  if ((req->bmRequest & 0x80) && req->bRequest == WEBUSB_VENDOR_CODE && req->wIndex == WEBUSB_REQ_GET_URL
c0d03afa:	780a      	ldrb	r2, [r1, #0]
c0d03afc:	b252      	sxtb	r2, r2
c0d03afe:	2a00      	cmp	r2, #0
c0d03b00:	db02      	blt.n	c0d03b08 <USBD_CtlError+0x10>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
c0d03b02:	f7ff fe39 	bl	c0d03778 <USBD_CtlStall>
  }
}
c0d03b06:	bd80      	pop	{r7, pc}
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
#if WEBUSB_URL_SIZE_B > 0
  if ((req->bmRequest & 0x80) && req->bRequest == WEBUSB_VENDOR_CODE && req->wIndex == WEBUSB_REQ_GET_URL
c0d03b08:	784a      	ldrb	r2, [r1, #1]
c0d03b0a:	2a06      	cmp	r2, #6
c0d03b0c:	d012      	beq.n	c0d03b34 <USBD_CtlError+0x3c>
c0d03b0e:	2a77      	cmp	r2, #119	; 0x77
c0d03b10:	d01d      	beq.n	c0d03b4e <USBD_CtlError+0x56>
c0d03b12:	2a1e      	cmp	r2, #30
c0d03b14:	d1f5      	bne.n	c0d03b02 <USBD_CtlError+0xa>
c0d03b16:	888a      	ldrh	r2, [r1, #4]
    // HTTPS url
    && req->wValue == 1) {
c0d03b18:	2a02      	cmp	r2, #2
c0d03b1a:	d1f2      	bne.n	c0d03b02 <USBD_CtlError+0xa>
c0d03b1c:	884a      	ldrh	r2, [r1, #2]
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
#if WEBUSB_URL_SIZE_B > 0
  if ((req->bmRequest & 0x80) && req->bRequest == WEBUSB_VENDOR_CODE && req->wIndex == WEBUSB_REQ_GET_URL
c0d03b1e:	2a01      	cmp	r2, #1
c0d03b20:	d1ef      	bne.n	c0d03b02 <USBD_CtlError+0xa>
    // HTTPS url
    && req->wValue == 1) {
    // return the URL descriptor
    USBD_CtlSendData (pdev, (unsigned char*)C_webusb_url_descriptor, MIN(req->wLength, sizeof(C_webusb_url_descriptor)));
c0d03b22:	88ca      	ldrh	r2, [r1, #6]
c0d03b24:	2a17      	cmp	r2, #23
c0d03b26:	d300      	bcc.n	c0d03b2a <USBD_CtlError+0x32>
c0d03b28:	2217      	movs	r2, #23
c0d03b2a:	491c      	ldr	r1, [pc, #112]	; (c0d03b9c <USBD_CtlError+0xa4>)
c0d03b2c:	4479      	add	r1, pc
c0d03b2e:	f000 f8ad 	bl	c0d03c8c <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d03b32:	bd80      	pop	{r7, pc}
  else 
#endif // WEBUSB_URL_SIZE_B
    // SETUP (LE): 0x80 0x06 0x03 0x77 0x00 0x00 0xXX 0xXX
    if ((req->bmRequest & 0x80) 
    && req->bRequest == USB_REQ_GET_DESCRIPTOR 
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
c0d03b34:	884a      	ldrh	r2, [r1, #2]
c0d03b36:	4b18      	ldr	r3, [pc, #96]	; (c0d03b98 <USBD_CtlError+0xa0>)
    && (req->wValue & 0xFF) == 0xEE) {
c0d03b38:	429a      	cmp	r2, r3
c0d03b3a:	d1e2      	bne.n	c0d03b02 <USBD_CtlError+0xa>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
c0d03b3c:	88ca      	ldrh	r2, [r1, #6]
c0d03b3e:	2a12      	cmp	r2, #18
c0d03b40:	d300      	bcc.n	c0d03b44 <USBD_CtlError+0x4c>
c0d03b42:	2212      	movs	r2, #18
c0d03b44:	4916      	ldr	r1, [pc, #88]	; (c0d03ba0 <USBD_CtlError+0xa8>)
c0d03b46:	4479      	add	r1, pc
c0d03b48:	f000 f8a0 	bl	c0d03c8c <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d03b4c:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
  }
  // SETUP (LE): 0x80 0x77 0x04 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
c0d03b4e:	888a      	ldrh	r2, [r1, #4]
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
    && (req->wValue & 0xFF) == 0xEE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
  }
  // SETUP (LE): 0x80 0x77 0x04 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
c0d03b50:	2a04      	cmp	r2, #4
c0d03b52:	d108      	bne.n	c0d03b66 <USBD_CtlError+0x6e>
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
c0d03b54:	88ca      	ldrh	r2, [r1, #6]
c0d03b56:	2a28      	cmp	r2, #40	; 0x28
c0d03b58:	d300      	bcc.n	c0d03b5c <USBD_CtlError+0x64>
c0d03b5a:	2228      	movs	r2, #40	; 0x28
c0d03b5c:	4911      	ldr	r1, [pc, #68]	; (c0d03ba4 <USBD_CtlError+0xac>)
c0d03b5e:	4479      	add	r1, pc
c0d03b60:	f000 f894 	bl	c0d03c8c <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d03b64:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
  }
  // SETUP (LE): 0x80 0x77 0x05 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
c0d03b66:	888a      	ldrh	r2, [r1, #4]
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
  }
  // SETUP (LE): 0x80 0x77 0x05 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
c0d03b68:	2a05      	cmp	r2, #5
c0d03b6a:	d108      	bne.n	c0d03b7e <USBD_CtlError+0x86>
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
  ) {        
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
c0d03b6c:	88ca      	ldrh	r2, [r1, #6]
c0d03b6e:	2a92      	cmp	r2, #146	; 0x92
c0d03b70:	d300      	bcc.n	c0d03b74 <USBD_CtlError+0x7c>
c0d03b72:	2292      	movs	r2, #146	; 0x92
c0d03b74:	490c      	ldr	r1, [pc, #48]	; (c0d03ba8 <USBD_CtlError+0xb0>)
c0d03b76:	4479      	add	r1, pc
c0d03b78:	f000 f888 	bl	c0d03c8c <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d03b7c:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
  }
  // Microsoft OS 2.0 Descriptors for Windows 8.1 and Windows 10
  else if ((req->bmRequest & 0x80)
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
c0d03b7e:	888a      	ldrh	r2, [r1, #4]
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
  ) {        
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
  }
  // Microsoft OS 2.0 Descriptors for Windows 8.1 and Windows 10
  else if ((req->bmRequest & 0x80)
c0d03b80:	2a07      	cmp	r2, #7
c0d03b82:	d1be      	bne.n	c0d03b02 <USBD_CtlError+0xa>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
c0d03b84:	88ca      	ldrh	r2, [r1, #6]
c0d03b86:	2ab2      	cmp	r2, #178	; 0xb2
c0d03b88:	d300      	bcc.n	c0d03b8c <USBD_CtlError+0x94>
c0d03b8a:	22b2      	movs	r2, #178	; 0xb2
c0d03b8c:	4907      	ldr	r1, [pc, #28]	; (c0d03bac <USBD_CtlError+0xb4>)
c0d03b8e:	4479      	add	r1, pc
c0d03b90:	f000 f87c 	bl	c0d03c8c <USBD_CtlSendData>
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d03b94:	bd80      	pop	{r7, pc}
c0d03b96:	46c0      	nop			; (mov r8, r8)
c0d03b98:	000003ee 	.word	0x000003ee
c0d03b9c:	00000e49 	.word	0x00000e49
c0d03ba0:	00000ea2 	.word	0x00000ea2
c0d03ba4:	000010c6 	.word	0x000010c6
c0d03ba8:	00000e84 	.word	0x00000e84
c0d03bac:	00000efe 	.word	0x00000efe

c0d03bb0 <USB_power>:
  // nothing to do ?
  return 0;
}
#endif // HAVE_USB_CLASS_CCID

void USB_power(unsigned char enabled) {
c0d03bb0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03bb2:	b081      	sub	sp, #4
c0d03bb4:	4604      	mov	r4, r0
c0d03bb6:	2045      	movs	r0, #69	; 0x45
c0d03bb8:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d03bba:	4824      	ldr	r0, [pc, #144]	; (c0d03c4c <USB_power+0x9c>)
c0d03bbc:	2600      	movs	r6, #0
c0d03bbe:	4631      	mov	r1, r6
c0d03bc0:	462a      	mov	r2, r5
c0d03bc2:	f7fd fb5e 	bl	c0d01282 <os_memset>

  // init timeouts and other global fields
  os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
c0d03bc6:	4f22      	ldr	r7, [pc, #136]	; (c0d03c50 <USB_power+0xa0>)
c0d03bc8:	4638      	mov	r0, r7
c0d03bca:	300c      	adds	r0, #12
c0d03bcc:	2206      	movs	r2, #6
c0d03bce:	4631      	mov	r1, r6
c0d03bd0:	f7fd fb57 	bl	c0d01282 <os_memset>
  os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d03bd4:	3712      	adds	r7, #18
c0d03bd6:	220c      	movs	r2, #12
c0d03bd8:	4638      	mov	r0, r7
c0d03bda:	4631      	mov	r1, r6
c0d03bdc:	f7fd fb51 	bl	c0d01282 <os_memset>

  if (enabled) {
c0d03be0:	2c00      	cmp	r4, #0
c0d03be2:	d02d      	beq.n	c0d03c40 <USB_power+0x90>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d03be4:	4c19      	ldr	r4, [pc, #100]	; (c0d03c4c <USB_power+0x9c>)
c0d03be6:	2600      	movs	r6, #0
c0d03be8:	4620      	mov	r0, r4
c0d03bea:	4631      	mov	r1, r6
c0d03bec:	462a      	mov	r2, r5
c0d03bee:	f7fd fb48 	bl	c0d01282 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d03bf2:	491a      	ldr	r1, [pc, #104]	; (c0d03c5c <USB_power+0xac>)
c0d03bf4:	4479      	add	r1, pc
c0d03bf6:	4620      	mov	r0, r4
c0d03bf8:	4632      	mov	r2, r6
c0d03bfa:	f7ff f9ab 	bl	c0d02f54 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClassForInterface(HID_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d03bfe:	4a18      	ldr	r2, [pc, #96]	; (c0d03c60 <USB_power+0xb0>)
c0d03c00:	447a      	add	r2, pc
c0d03c02:	4630      	mov	r0, r6
c0d03c04:	4621      	mov	r1, r4
c0d03c06:	f7ff f9dd 	bl	c0d02fc4 <USBD_RegisterClassForInterface>
c0d03c0a:	2001      	movs	r0, #1
#ifdef HAVE_IO_U2F
    USBD_RegisterClassForInterface(U2F_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_U2F);
c0d03c0c:	4a15      	ldr	r2, [pc, #84]	; (c0d03c64 <USB_power+0xb4>)
c0d03c0e:	447a      	add	r2, pc
c0d03c10:	4621      	mov	r1, r4
c0d03c12:	f7ff f9d7 	bl	c0d02fc4 <USBD_RegisterClassForInterface>
c0d03c16:	22ff      	movs	r2, #255	; 0xff
c0d03c18:	3252      	adds	r2, #82	; 0x52
    // initialize the U2F tunnel transport
    u2f_transport_init(&G_io_u2f, G_io_apdu_buffer, IO_APDU_BUFFER_SIZE);
c0d03c1a:	480e      	ldr	r0, [pc, #56]	; (c0d03c54 <USB_power+0xa4>)
c0d03c1c:	490e      	ldr	r1, [pc, #56]	; (c0d03c58 <USB_power+0xa8>)
c0d03c1e:	f7fe fd39 	bl	c0d02694 <u2f_transport_init>
c0d03c22:	2002      	movs	r0, #2
#ifdef HAVE_USB_CLASS_CCID
    USBD_RegisterClassForInterface(CCID_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_CCID);
#endif // HAVE_USB_CLASS_CCID

#ifdef HAVE_WEBUSB
    USBD_RegisterClassForInterface(WEBUSB_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_WEBUSB);
c0d03c24:	4a10      	ldr	r2, [pc, #64]	; (c0d03c68 <USB_power+0xb8>)
c0d03c26:	447a      	add	r2, pc
c0d03c28:	4621      	mov	r1, r4
c0d03c2a:	f7ff f9cb 	bl	c0d02fc4 <USBD_RegisterClassForInterface>
c0d03c2e:	2103      	movs	r1, #3
c0d03c30:	2240      	movs	r2, #64	; 0x40
    USBD_LL_PrepareReceive(&USBD_Device, WEBUSB_EPOUT_ADDR , WEBUSB_EPOUT_SIZE);
c0d03c32:	4620      	mov	r0, r4
c0d03c34:	f7ff f97b 	bl	c0d02f2e <USBD_LL_PrepareReceive>
#endif // HAVE_WEBUSB

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d03c38:	4620      	mov	r0, r4
c0d03c3a:	f7ff f9d0 	bl	c0d02fde <USBD_Start>
c0d03c3e:	e002      	b.n	c0d03c46 <USB_power+0x96>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d03c40:	4802      	ldr	r0, [pc, #8]	; (c0d03c4c <USB_power+0x9c>)
c0d03c42:	f7ff f9a1 	bl	c0d02f88 <USBD_DeInit>
  }
}
c0d03c46:	b001      	add	sp, #4
c0d03c48:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03c4a:	46c0      	nop			; (mov r8, r8)
c0d03c4c:	20002010 	.word	0x20002010
c0d03c50:	20001f48 	.word	0x20001f48
c0d03c54:	20001f70 	.word	0x20001f70
c0d03c58:	20001df4 	.word	0x20001df4
c0d03c5c:	00000dd4 	.word	0x00000dd4
c0d03c60:	00000f40 	.word	0x00000f40
c0d03c64:	00000f6a 	.word	0x00000f6a
c0d03c68:	00000f8a 	.word	0x00000f8a

c0d03c6c <USBD_GetCfgDesc_impl>:
  * @param  speed : current device speed
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
c0d03c6c:	2160      	movs	r1, #96	; 0x60
  *length = sizeof (USBD_CfgDesc);
c0d03c6e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d03c70:	4801      	ldr	r0, [pc, #4]	; (c0d03c78 <USBD_GetCfgDesc_impl+0xc>)
c0d03c72:	4478      	add	r0, pc
c0d03c74:	4770      	bx	lr
c0d03c76:	46c0      	nop			; (mov r8, r8)
c0d03c78:	00000fda 	.word	0x00000fda

c0d03c7c <USBD_GetDeviceQualifierDesc_impl>:
*         return Device Qualifier descriptor
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
c0d03c7c:	210a      	movs	r1, #10
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d03c7e:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d03c80:	4801      	ldr	r0, [pc, #4]	; (c0d03c88 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d03c82:	4478      	add	r0, pc
c0d03c84:	4770      	bx	lr
c0d03c86:	46c0      	nop			; (mov r8, r8)
c0d03c88:	0000102a 	.word	0x0000102a

c0d03c8c <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d03c8c:	b5b0      	push	{r4, r5, r7, lr}
c0d03c8e:	460c      	mov	r4, r1
c0d03c90:	21d4      	movs	r1, #212	; 0xd4
c0d03c92:	2302      	movs	r3, #2
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d03c94:	5043      	str	r3, [r0, r1]
c0d03c96:	2111      	movs	r1, #17
c0d03c98:	0109      	lsls	r1, r1, #4
  pdev->ep_in[0].total_length = len;
  pdev->ep_in[0].rem_length   = len;
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d03c9a:	5044      	str	r4, [r0, r1]
                               uint8_t *pbuf,
                               uint16_t len)
{
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
  pdev->ep_in[0].total_length = len;
c0d03c9c:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d03c9e:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d03ca0:	6a01      	ldr	r1, [r0, #32]
c0d03ca2:	4291      	cmp	r1, r2
c0d03ca4:	d800      	bhi.n	c0d03ca8 <USBD_CtlSendData+0x1c>
c0d03ca6:	460a      	mov	r2, r1
c0d03ca8:	b293      	uxth	r3, r2
c0d03caa:	2500      	movs	r5, #0
c0d03cac:	4629      	mov	r1, r5
c0d03cae:	4622      	mov	r2, r4
c0d03cb0:	f7ff f924 	bl	c0d02efc <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03cb4:	4628      	mov	r0, r5
c0d03cb6:	bdb0      	pop	{r4, r5, r7, pc}

c0d03cb8 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d03cb8:	b5b0      	push	{r4, r5, r7, lr}
c0d03cba:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d03cbc:	6a01      	ldr	r1, [r0, #32]
c0d03cbe:	4291      	cmp	r1, r2
c0d03cc0:	d800      	bhi.n	c0d03cc4 <USBD_CtlContinueSendData+0xc>
c0d03cc2:	460a      	mov	r2, r1
c0d03cc4:	b293      	uxth	r3, r2
c0d03cc6:	2500      	movs	r5, #0
c0d03cc8:	4629      	mov	r1, r5
c0d03cca:	4622      	mov	r2, r4
c0d03ccc:	f7ff f916 	bl	c0d02efc <USBD_LL_Transmit>
  return USBD_OK;
c0d03cd0:	4628      	mov	r0, r5
c0d03cd2:	bdb0      	pop	{r4, r5, r7, pc}

c0d03cd4 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d03cd4:	b510      	push	{r4, lr}
c0d03cd6:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d03cd8:	4621      	mov	r1, r4
c0d03cda:	f7ff f928 	bl	c0d02f2e <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d03cde:	4620      	mov	r0, r4
c0d03ce0:	bd10      	pop	{r4, pc}

c0d03ce2 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d03ce2:	b510      	push	{r4, lr}
c0d03ce4:	21d4      	movs	r1, #212	; 0xd4
c0d03ce6:	2204      	movs	r2, #4

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d03ce8:	5042      	str	r2, [r0, r1]
c0d03cea:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d03cec:	4621      	mov	r1, r4
c0d03cee:	4622      	mov	r2, r4
c0d03cf0:	4623      	mov	r3, r4
c0d03cf2:	f7ff f903 	bl	c0d02efc <USBD_LL_Transmit>
  
  return USBD_OK;
c0d03cf6:	4620      	mov	r0, r4
c0d03cf8:	bd10      	pop	{r4, pc}

c0d03cfa <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d03cfa:	b510      	push	{r4, lr}
c0d03cfc:	21d4      	movs	r1, #212	; 0xd4
c0d03cfe:	2205      	movs	r2, #5
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d03d00:	5042      	str	r2, [r0, r1]
c0d03d02:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d03d04:	4621      	mov	r1, r4
c0d03d06:	4622      	mov	r2, r4
c0d03d08:	f7ff f911 	bl	c0d02f2e <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d03d0c:	4620      	mov	r0, r4
c0d03d0e:	bd10      	pop	{r4, pc}

c0d03d10 <ux_menu_element_preprocessor>:
    return ux_menu.menu_iterator(entry_idx);
  } 
  return &ux_menu.menu_entries[entry_idx];
} 

const bagl_element_t* ux_menu_element_preprocessor(const bagl_element_t* element) {
c0d03d10:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03d12:	b083      	sub	sp, #12
c0d03d14:	4606      	mov	r6, r0
  //todo avoid center alignment when text_x or icon_x AND text_x are not 0
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d03d16:	4868      	ldr	r0, [pc, #416]	; (c0d03eb8 <ux_menu_element_preprocessor+0x1a8>)
c0d03d18:	1d00      	adds	r0, r0, #4
c0d03d1a:	2220      	movs	r2, #32
c0d03d1c:	9001      	str	r0, [sp, #4]
c0d03d1e:	4631      	mov	r1, r6
c0d03d20:	f7fd fa99 	bl	c0d01256 <os_memmove>

  // ask the current entry first, to setup other entries
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d03d24:	4d65      	ldr	r5, [pc, #404]	; (c0d03ebc <ux_menu_element_preprocessor+0x1ac>)
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d03d26:	6929      	ldr	r1, [r5, #16]
const bagl_element_t* ux_menu_element_preprocessor(const bagl_element_t* element) {
  //todo avoid center alignment when text_x or icon_x AND text_x are not 0
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // ask the current entry first, to setup other entries
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d03d28:	68a8      	ldr	r0, [r5, #8]
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d03d2a:	2900      	cmp	r1, #0
c0d03d2c:	d001      	beq.n	c0d03d32 <ux_menu_element_preprocessor+0x22>
    return ux_menu.menu_iterator(entry_idx);
c0d03d2e:	4788      	blx	r1
c0d03d30:	e003      	b.n	c0d03d3a <ux_menu_element_preprocessor+0x2a>
c0d03d32:	211c      	movs	r1, #28
  } 
  return &ux_menu.menu_entries[entry_idx];
c0d03d34:	4341      	muls	r1, r0
c0d03d36:	6828      	ldr	r0, [r5, #0]
c0d03d38:	1840      	adds	r0, r0, r1
const bagl_element_t* ux_menu_element_preprocessor(const bagl_element_t* element) {
  //todo avoid center alignment when text_x or icon_x AND text_x are not 0
  os_memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));

  // ask the current entry first, to setup other entries
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d03d3a:	f7fe f9d1 	bl	c0d020e0 <pic>
c0d03d3e:	9002      	str	r0, [sp, #8]

  const ux_menu_entry_t* previous_entry = NULL;
  if (ux_menu.current_entry) {
c0d03d40:	68a8      	ldr	r0, [r5, #8]
c0d03d42:	2700      	movs	r7, #0
c0d03d44:	2800      	cmp	r0, #0
c0d03d46:	d005      	beq.n	c0d03d54 <ux_menu_element_preprocessor+0x44>
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d03d48:	6929      	ldr	r1, [r5, #16]
  // ask the current entry first, to setup other entries
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));

  const ux_menu_entry_t* previous_entry = NULL;
  if (ux_menu.current_entry) {
    previous_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry-1));
c0d03d4a:	1e40      	subs	r0, r0, #1
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d03d4c:	2900      	cmp	r1, #0
c0d03d4e:	d004      	beq.n	c0d03d5a <ux_menu_element_preprocessor+0x4a>
    return ux_menu.menu_iterator(entry_idx);
c0d03d50:	4788      	blx	r1
c0d03d52:	e006      	b.n	c0d03d62 <ux_menu_element_preprocessor+0x52>
  const ux_menu_entry_t* previous_entry = NULL;
  if (ux_menu.current_entry) {
    previous_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry-1));
  }
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
c0d03d54:	4638      	mov	r0, r7
c0d03d56:	463c      	mov	r4, r7
c0d03d58:	e007      	b.n	c0d03d6a <ux_menu_element_preprocessor+0x5a>
c0d03d5a:	211c      	movs	r1, #28

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
    return ux_menu.menu_iterator(entry_idx);
  } 
  return &ux_menu.menu_entries[entry_idx];
c0d03d5c:	4341      	muls	r1, r0
c0d03d5e:	6828      	ldr	r0, [r5, #0]
c0d03d60:	1840      	adds	r0, r0, r1
  // ask the current entry first, to setup other entries
  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));

  const ux_menu_entry_t* previous_entry = NULL;
  if (ux_menu.current_entry) {
    previous_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry-1));
c0d03d62:	f7fe f9bd 	bl	c0d020e0 <pic>
c0d03d66:	4604      	mov	r4, r0
  }
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
c0d03d68:	68a8      	ldr	r0, [r5, #8]
c0d03d6a:	6869      	ldr	r1, [r5, #4]
c0d03d6c:	1e49      	subs	r1, r1, #1
c0d03d6e:	4288      	cmp	r0, r1
c0d03d70:	d20f      	bcs.n	c0d03d92 <ux_menu_element_preprocessor+0x82>
c0d03d72:	462b      	mov	r3, r5
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d03d74:	6929      	ldr	r1, [r5, #16]
  if (ux_menu.current_entry) {
    previous_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry-1));
  }
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
    next_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry+1));
c0d03d76:	1c40      	adds	r0, r0, #1
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d03d78:	2900      	cmp	r1, #0
c0d03d7a:	d002      	beq.n	c0d03d82 <ux_menu_element_preprocessor+0x72>
c0d03d7c:	461d      	mov	r5, r3
    return ux_menu.menu_iterator(entry_idx);
c0d03d7e:	4788      	blx	r1
c0d03d80:	e004      	b.n	c0d03d8c <ux_menu_element_preprocessor+0x7c>
c0d03d82:	211c      	movs	r1, #28
  } 
  return &ux_menu.menu_entries[entry_idx];
c0d03d84:	4341      	muls	r1, r0
c0d03d86:	461d      	mov	r5, r3
c0d03d88:	6818      	ldr	r0, [r3, #0]
c0d03d8a:	1840      	adds	r0, r0, r1
  if (ux_menu.current_entry) {
    previous_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry-1));
  }
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
    next_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry+1));
c0d03d8c:	f7fe f9a8 	bl	c0d020e0 <pic>
c0d03d90:	4607      	mov	r7, r0
  }

  switch(element->component.userid) {
c0d03d92:	7870      	ldrb	r0, [r6, #1]
c0d03d94:	2840      	cmp	r0, #64	; 0x40
c0d03d96:	dc0e      	bgt.n	c0d03db6 <ux_menu_element_preprocessor+0xa6>
c0d03d98:	2820      	cmp	r0, #32
c0d03d9a:	dc2a      	bgt.n	c0d03df2 <ux_menu_element_preprocessor+0xe2>
c0d03d9c:	2810      	cmp	r0, #16
c0d03d9e:	9b02      	ldr	r3, [sp, #8]
c0d03da0:	d03e      	beq.n	c0d03e20 <ux_menu_element_preprocessor+0x110>
c0d03da2:	2820      	cmp	r0, #32
c0d03da4:	d17d      	bne.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
c0d03da6:	2000      	movs	r0, #0
      if (current_entry->icon_x) {
        G_ux.tmp_element.component.x = current_entry->icon_x;
      }
      break;
    case 0x20:
      if (!current_entry || current_entry->line2 != NULL) {
c0d03da8:	2b00      	cmp	r3, #0
c0d03daa:	d100      	bne.n	c0d03dae <ux_menu_element_preprocessor+0x9e>
c0d03dac:	e081      	b.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03dae:	6959      	ldr	r1, [r3, #20]
c0d03db0:	2900      	cmp	r1, #0
c0d03db2:	d17e      	bne.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03db4:	e063      	b.n	c0d03e7e <ux_menu_element_preprocessor+0x16e>
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
    next_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry+1));
  }

  switch(element->component.userid) {
c0d03db6:	2880      	cmp	r0, #128	; 0x80
c0d03db8:	dc29      	bgt.n	c0d03e0e <ux_menu_element_preprocessor+0xfe>
c0d03dba:	2841      	cmp	r0, #65	; 0x41
c0d03dbc:	9b02      	ldr	r3, [sp, #8]
c0d03dbe:	d03d      	beq.n	c0d03e3c <ux_menu_element_preprocessor+0x12c>
c0d03dc0:	2842      	cmp	r0, #66	; 0x42
c0d03dc2:	d16e      	bne.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
c0d03dc4:	2000      	movs	r0, #0
      G_ux.tmp_element.text = previous_entry->line1;
      break;
    // next setting name
    case 0x42:
      if (!current_entry
        || current_entry->line2 != NULL 
c0d03dc6:	2b00      	cmp	r3, #0
c0d03dc8:	d073      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03dca:	6959      	ldr	r1, [r3, #20]
        || current_entry->icon != NULL
c0d03dcc:	2900      	cmp	r1, #0
c0d03dce:	d170      	bne.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03dd0:	68d9      	ldr	r1, [r3, #12]
        || ux_menu.current_entry == ux_menu.menu_entries_count-1
c0d03dd2:	2900      	cmp	r1, #0
c0d03dd4:	d16d      	bne.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
        || ux_menu.menu_entries_count == 1
c0d03dd6:	2f00      	cmp	r7, #0
c0d03dd8:	d06b      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03dda:	6869      	ldr	r1, [r5, #4]
c0d03ddc:	2901      	cmp	r1, #1
c0d03dde:	d068      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03de0:	68aa      	ldr	r2, [r5, #8]
c0d03de2:	1e49      	subs	r1, r1, #1
c0d03de4:	428a      	cmp	r2, r1
c0d03de6:	d064      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
        || !next_entry
        || next_entry->icon != NULL) {
c0d03de8:	68f9      	ldr	r1, [r7, #12]
      }
      G_ux.tmp_element.text = previous_entry->line1;
      break;
    // next setting name
    case 0x42:
      if (!current_entry
c0d03dea:	2900      	cmp	r1, #0
c0d03dec:	d161      	bne.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
        || ux_menu.menu_entries_count == 1
        || !next_entry
        || next_entry->icon != NULL) {
        return NULL;
      }
      G_ux.tmp_element.text = next_entry->line1;
c0d03dee:	6938      	ldr	r0, [r7, #16]
c0d03df0:	e03c      	b.n	c0d03e6c <ux_menu_element_preprocessor+0x15c>
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
    next_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry+1));
  }

  switch(element->component.userid) {
c0d03df2:	2821      	cmp	r0, #33	; 0x21
c0d03df4:	9b02      	ldr	r3, [sp, #8]
c0d03df6:	d03c      	beq.n	c0d03e72 <ux_menu_element_preprocessor+0x162>
c0d03df8:	2822      	cmp	r0, #34	; 0x22
c0d03dfa:	d152      	bne.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
c0d03dfc:	2000      	movs	r0, #0
        return NULL;
      }
      G_ux.tmp_element.text = current_entry->line1;
      goto adjust_text_x;
    case 0x22:
      if (!current_entry || current_entry->line2 == NULL) {
c0d03dfe:	2b00      	cmp	r3, #0
c0d03e00:	d057      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03e02:	6959      	ldr	r1, [r3, #20]
c0d03e04:	2900      	cmp	r1, #0
c0d03e06:	d054      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
        return NULL;
      }
      G_ux.tmp_element.text = current_entry->line2;
c0d03e08:	482b      	ldr	r0, [pc, #172]	; (c0d03eb8 <ux_menu_element_preprocessor+0x1a8>)
c0d03e0a:	6201      	str	r1, [r0, #32]
c0d03e0c:	e03a      	b.n	c0d03e84 <ux_menu_element_preprocessor+0x174>
  const ux_menu_entry_t* next_entry = NULL;
  if (ux_menu.current_entry < ux_menu.menu_entries_count-1) {
    next_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry+1));
  }

  switch(element->component.userid) {
c0d03e0e:	2882      	cmp	r0, #130	; 0x82
c0d03e10:	9b02      	ldr	r3, [sp, #8]
c0d03e12:	d03f      	beq.n	c0d03e94 <ux_menu_element_preprocessor+0x184>
c0d03e14:	2881      	cmp	r0, #129	; 0x81
c0d03e16:	d144      	bne.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
    case 0x81:
      if (ux_menu.current_entry == 0) {
c0d03e18:	68a8      	ldr	r0, [r5, #8]
c0d03e1a:	2800      	cmp	r0, #0
c0d03e1c:	d141      	bne.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
c0d03e1e:	e03e      	b.n	c0d03e9e <ux_menu_element_preprocessor+0x18e>
c0d03e20:	2000      	movs	r0, #0
        return NULL;
      }
      G_ux.tmp_element.text = next_entry->line1;
      break;
    case 0x10:
      if (!current_entry || current_entry->icon == NULL) {
c0d03e22:	2b00      	cmp	r3, #0
c0d03e24:	d045      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03e26:	68d9      	ldr	r1, [r3, #12]
c0d03e28:	2900      	cmp	r1, #0
c0d03e2a:	d042      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
        return NULL;
      }
      G_ux.tmp_element.text = (const char*)current_entry->icon;
c0d03e2c:	4822      	ldr	r0, [pc, #136]	; (c0d03eb8 <ux_menu_element_preprocessor+0x1a8>)
c0d03e2e:	6201      	str	r1, [r0, #32]
      if (current_entry->icon_x) {
c0d03e30:	7e58      	ldrb	r0, [r3, #25]
c0d03e32:	2800      	cmp	r0, #0
c0d03e34:	d035      	beq.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
        G_ux.tmp_element.component.x = current_entry->icon_x;
c0d03e36:	4920      	ldr	r1, [pc, #128]	; (c0d03eb8 <ux_menu_element_preprocessor+0x1a8>)
c0d03e38:	80c8      	strh	r0, [r1, #6]
c0d03e3a:	e032      	b.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
c0d03e3c:	2000      	movs	r0, #0
      }
      break;
    // previous setting name
    case 0x41:
      if (!current_entry
        || current_entry->line2 != NULL 
c0d03e3e:	2b00      	cmp	r3, #0
c0d03e40:	d037      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03e42:	6959      	ldr	r1, [r3, #20]
        || current_entry->icon != NULL
c0d03e44:	2900      	cmp	r1, #0
c0d03e46:	d134      	bne.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
        || ux_menu.current_entry == 0
c0d03e48:	2c00      	cmp	r4, #0
c0d03e4a:	d032      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03e4c:	68d9      	ldr	r1, [r3, #12]
c0d03e4e:	2900      	cmp	r1, #0
c0d03e50:	d12f      	bne.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03e52:	68a9      	ldr	r1, [r5, #8]
c0d03e54:	2900      	cmp	r1, #0
c0d03e56:	d02c      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03e58:	6869      	ldr	r1, [r5, #4]
c0d03e5a:	2901      	cmp	r1, #1
c0d03e5c:	d029      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
        || ux_menu.menu_entries_count == 1 
        || !previous_entry
        || previous_entry->icon != NULL
c0d03e5e:	68e1      	ldr	r1, [r4, #12]
        || previous_entry->line2 != NULL) {
c0d03e60:	2900      	cmp	r1, #0
c0d03e62:	d126      	bne.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03e64:	6961      	ldr	r1, [r4, #20]
        return NULL;
      }
      break;
    // previous setting name
    case 0x41:
      if (!current_entry
c0d03e66:	2900      	cmp	r1, #0
c0d03e68:	d123      	bne.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
        || !previous_entry
        || previous_entry->icon != NULL
        || previous_entry->line2 != NULL) {
        return 0;
      }
      G_ux.tmp_element.text = previous_entry->line1;
c0d03e6a:	6920      	ldr	r0, [r4, #16]
c0d03e6c:	4912      	ldr	r1, [pc, #72]	; (c0d03eb8 <ux_menu_element_preprocessor+0x1a8>)
c0d03e6e:	6208      	str	r0, [r1, #32]
c0d03e70:	e017      	b.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
c0d03e72:	2000      	movs	r0, #0
        return NULL;
      }
      G_ux.tmp_element.text = current_entry->line1;
      goto adjust_text_x;
    case 0x21:
      if (!current_entry || current_entry->line2 == NULL) {
c0d03e74:	2b00      	cmp	r3, #0
c0d03e76:	d01c      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03e78:	6959      	ldr	r1, [r3, #20]
c0d03e7a:	2900      	cmp	r1, #0
c0d03e7c:	d019      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
c0d03e7e:	6918      	ldr	r0, [r3, #16]
c0d03e80:	490d      	ldr	r1, [pc, #52]	; (c0d03eb8 <ux_menu_element_preprocessor+0x1a8>)
c0d03e82:	6208      	str	r0, [r1, #32]
      if (!current_entry || current_entry->line2 == NULL) {
        return NULL;
      }
      G_ux.tmp_element.text = current_entry->line2;
    adjust_text_x:
      if (current_entry && current_entry->text_x) {
c0d03e84:	7e18      	ldrb	r0, [r3, #24]
c0d03e86:	2800      	cmp	r0, #0
c0d03e88:	d00b      	beq.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
c0d03e8a:	2108      	movs	r1, #8
c0d03e8c:	4a0a      	ldr	r2, [pc, #40]	; (c0d03eb8 <ux_menu_element_preprocessor+0x1a8>)
        G_ux.tmp_element.component.x = current_entry->text_x;
        // discard the 'center' flag
        G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_EXTRABOLD_11px;
c0d03e8e:	8391      	strh	r1, [r2, #28]
        return NULL;
      }
      G_ux.tmp_element.text = current_entry->line2;
    adjust_text_x:
      if (current_entry && current_entry->text_x) {
        G_ux.tmp_element.component.x = current_entry->text_x;
c0d03e90:	80d0      	strh	r0, [r2, #6]
c0d03e92:	e006      	b.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
      if (ux_menu.current_entry == 0) {
        return NULL;
      }
      break;
    case 0x82:
      if (ux_menu.current_entry == ux_menu.menu_entries_count-1) {
c0d03e94:	6868      	ldr	r0, [r5, #4]
c0d03e96:	68a9      	ldr	r1, [r5, #8]
c0d03e98:	1e40      	subs	r0, r0, #1
c0d03e9a:	4281      	cmp	r1, r0
c0d03e9c:	d101      	bne.n	c0d03ea2 <ux_menu_element_preprocessor+0x192>
c0d03e9e:	2000      	movs	r0, #0
c0d03ea0:	e007      	b.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
        G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_EXTRABOLD_11px;
      }
      break;
  }
  // ensure prepro agrees to the element to be displayed
  if (ux_menu.menu_entry_preprocessor) {
c0d03ea2:	68ea      	ldr	r2, [r5, #12]
c0d03ea4:	2a00      	cmp	r2, #0
c0d03ea6:	9801      	ldr	r0, [sp, #4]
c0d03ea8:	d003      	beq.n	c0d03eb2 <ux_menu_element_preprocessor+0x1a2>
    // menu is denied by the menu entry preprocessor
    return ux_menu.menu_entry_preprocessor(current_entry, &G_ux.tmp_element);
c0d03eaa:	4803      	ldr	r0, [pc, #12]	; (c0d03eb8 <ux_menu_element_preprocessor+0x1a8>)
c0d03eac:	1d01      	adds	r1, r0, #4
c0d03eae:	4618      	mov	r0, r3
c0d03eb0:	4790      	blx	r2
  }

  return &G_ux.tmp_element;
}
c0d03eb2:	b003      	add	sp, #12
c0d03eb4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03eb6:	46c0      	nop			; (mov r8, r8)
c0d03eb8:	2000182c 	.word	0x2000182c
c0d03ebc:	20002124 	.word	0x20002124

c0d03ec0 <ux_menu_elements_button>:

unsigned int ux_menu_elements_button (unsigned int button_mask, unsigned int button_mask_counter) {
c0d03ec0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03ec2:	b081      	sub	sp, #4
c0d03ec4:	4605      	mov	r5, r0
  UNUSED(button_mask_counter);

  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d03ec6:	4f40      	ldr	r7, [pc, #256]	; (c0d03fc8 <ux_menu_elements_button+0x108>)
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d03ec8:	6939      	ldr	r1, [r7, #16]
}

unsigned int ux_menu_elements_button (unsigned int button_mask, unsigned int button_mask_counter) {
  UNUSED(button_mask_counter);

  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d03eca:	68b8      	ldr	r0, [r7, #8]
  {{BAGL_LABELINE                       , 0x22,  14,  26, 100,  12, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL },

};

const ux_menu_entry_t* ux_menu_get_entry (unsigned int entry_idx) {
  if (ux_menu.menu_iterator) {
c0d03ecc:	2900      	cmp	r1, #0
c0d03ece:	d001      	beq.n	c0d03ed4 <ux_menu_elements_button+0x14>
    return ux_menu.menu_iterator(entry_idx);
c0d03ed0:	4788      	blx	r1
c0d03ed2:	e003      	b.n	c0d03edc <ux_menu_elements_button+0x1c>
c0d03ed4:	211c      	movs	r1, #28
  } 
  return &ux_menu.menu_entries[entry_idx];
c0d03ed6:	4341      	muls	r1, r0
c0d03ed8:	6838      	ldr	r0, [r7, #0]
c0d03eda:	1840      	adds	r0, r0, r1
}

unsigned int ux_menu_elements_button (unsigned int button_mask, unsigned int button_mask_counter) {
  UNUSED(button_mask_counter);

  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));
c0d03edc:	f7fe f900 	bl	c0d020e0 <pic>
c0d03ee0:	4606      	mov	r6, r0
c0d03ee2:	2401      	movs	r4, #1
c0d03ee4:	4839      	ldr	r0, [pc, #228]	; (c0d03fcc <ux_menu_elements_button+0x10c>)

  switch (button_mask) {
c0d03ee6:	4285      	cmp	r5, r0
c0d03ee8:	dd14      	ble.n	c0d03f14 <ux_menu_elements_button+0x54>
c0d03eea:	4839      	ldr	r0, [pc, #228]	; (c0d03fd0 <ux_menu_elements_button+0x110>)
c0d03eec:	4285      	cmp	r5, r0
c0d03eee:	d016      	beq.n	c0d03f1e <ux_menu_elements_button+0x5e>
c0d03ef0:	4838      	ldr	r0, [pc, #224]	; (c0d03fd4 <ux_menu_elements_button+0x114>)
c0d03ef2:	4285      	cmp	r5, r0
c0d03ef4:	d01a      	beq.n	c0d03f2c <ux_menu_elements_button+0x6c>
c0d03ef6:	4838      	ldr	r0, [pc, #224]	; (c0d03fd8 <ux_menu_elements_button+0x118>)
c0d03ef8:	4285      	cmp	r5, r0
c0d03efa:	d162      	bne.n	c0d03fc2 <ux_menu_elements_button+0x102>
    // enter menu or exit menu
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      // menu is priority 1
      if (current_entry->menu) {
c0d03efc:	6830      	ldr	r0, [r6, #0]
c0d03efe:	2800      	cmp	r0, #0
c0d03f00:	d056      	beq.n	c0d03fb0 <ux_menu_elements_button+0xf0>
        // use userid as the pointer to current entry in the parent menu
        UX_MENU_DISPLAY(current_entry->userid, (const ux_menu_entry_t*)PIC(current_entry->menu), ux_menu.menu_entry_preprocessor);
c0d03f02:	68b4      	ldr	r4, [r6, #8]
c0d03f04:	f7fe f8ec 	bl	c0d020e0 <pic>
c0d03f08:	4601      	mov	r1, r0
c0d03f0a:	68fa      	ldr	r2, [r7, #12]
c0d03f0c:	4620      	mov	r0, r4
c0d03f0e:	f000 f869 	bl	c0d03fe4 <ux_menu_display>
c0d03f12:	e055      	b.n	c0d03fc0 <ux_menu_elements_button+0x100>
c0d03f14:	4931      	ldr	r1, [pc, #196]	; (c0d03fdc <ux_menu_elements_button+0x11c>)
unsigned int ux_menu_elements_button (unsigned int button_mask, unsigned int button_mask_counter) {
  UNUSED(button_mask_counter);

  const ux_menu_entry_t* current_entry = (const ux_menu_entry_t*)PIC(ux_menu_get_entry(ux_menu.current_entry));

  switch (button_mask) {
c0d03f16:	428d      	cmp	r5, r1
c0d03f18:	d008      	beq.n	c0d03f2c <ux_menu_elements_button+0x6c>
c0d03f1a:	4285      	cmp	r5, r0
c0d03f1c:	d151      	bne.n	c0d03fc2 <ux_menu_elements_button+0x102>
      goto redraw;

    case BUTTON_EVT_FAST|BUTTON_RIGHT:
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      // entry 0 is the number of entries in the menu list
      if (ux_menu.current_entry >= ux_menu.menu_entries_count-1) {
c0d03f1e:	6879      	ldr	r1, [r7, #4]
c0d03f20:	68b8      	ldr	r0, [r7, #8]
c0d03f22:	1e49      	subs	r1, r1, #1
c0d03f24:	4288      	cmp	r0, r1
c0d03f26:	d24b      	bcs.n	c0d03fc0 <ux_menu_elements_button+0x100>
        return 0;
      }
      ux_menu.current_entry++;
c0d03f28:	1c40      	adds	r0, r0, #1
c0d03f2a:	e003      	b.n	c0d03f34 <ux_menu_elements_button+0x74>
      break;

    case BUTTON_EVT_FAST|BUTTON_LEFT:
    case BUTTON_EVT_RELEASED|BUTTON_LEFT:
      // entry 0 is the number of entries in the menu list
      if (ux_menu.current_entry == 0) {
c0d03f2c:	68b8      	ldr	r0, [r7, #8]
c0d03f2e:	2800      	cmp	r0, #0
c0d03f30:	d046      	beq.n	c0d03fc0 <ux_menu_elements_button+0x100>
        return 0;
      }
      ux_menu.current_entry--;
c0d03f32:	1e40      	subs	r0, r0, #1
c0d03f34:	60b8      	str	r0, [r7, #8]
      ux_menu.current_entry++;
    redraw:
#ifdef HAVE_BOLOS_UX
      ux_stack_display(0);
#else
      UX_REDISPLAY();
c0d03f36:	f7fd fb15 	bl	c0d01564 <io_seproxyhal_init_ux>
c0d03f3a:	f7fd fb15 	bl	c0d01568 <io_seproxyhal_init_button>
c0d03f3e:	4d28      	ldr	r5, [pc, #160]	; (c0d03fe0 <ux_menu_elements_button+0x120>)
c0d03f40:	2400      	movs	r4, #0
c0d03f42:	84ec      	strh	r4, [r5, #38]	; 0x26
c0d03f44:	2004      	movs	r0, #4
c0d03f46:	f7fe fa2b 	bl	c0d023a0 <os_sched_last_status>
c0d03f4a:	66a8      	str	r0, [r5, #104]	; 0x68
c0d03f4c:	2800      	cmp	r0, #0
c0d03f4e:	d038      	beq.n	c0d03fc2 <ux_menu_elements_button+0x102>
c0d03f50:	2897      	cmp	r0, #151	; 0x97
c0d03f52:	d036      	beq.n	c0d03fc2 <ux_menu_elements_button+0x102>
c0d03f54:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d03f56:	2800      	cmp	r0, #0
c0d03f58:	d033      	beq.n	c0d03fc2 <ux_menu_elements_button+0x102>
c0d03f5a:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d03f5c:	212c      	movs	r1, #44	; 0x2c
c0d03f5e:	5c69      	ldrb	r1, [r5, r1]
c0d03f60:	b280      	uxth	r0, r0
c0d03f62:	4288      	cmp	r0, r1
c0d03f64:	d22d      	bcs.n	c0d03fc2 <ux_menu_elements_button+0x102>
c0d03f66:	f7fe f9e7 	bl	c0d02338 <io_seph_is_status_sent>
c0d03f6a:	2800      	cmp	r0, #0
c0d03f6c:	d129      	bne.n	c0d03fc2 <ux_menu_elements_button+0x102>
c0d03f6e:	f7fe f96f 	bl	c0d02250 <os_perso_isonboarded>
c0d03f72:	28aa      	cmp	r0, #170	; 0xaa
c0d03f74:	d103      	bne.n	c0d03f7e <ux_menu_elements_button+0xbe>
c0d03f76:	f7fe f995 	bl	c0d022a4 <os_global_pin_is_validated>
c0d03f7a:	28aa      	cmp	r0, #170	; 0xaa
c0d03f7c:	d121      	bne.n	c0d03fc2 <ux_menu_elements_button+0x102>
c0d03f7e:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d03f80:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d03f82:	0149      	lsls	r1, r1, #5
c0d03f84:	1840      	adds	r0, r0, r1
c0d03f86:	6b29      	ldr	r1, [r5, #48]	; 0x30
c0d03f88:	2900      	cmp	r1, #0
c0d03f8a:	d002      	beq.n	c0d03f92 <ux_menu_elements_button+0xd2>
c0d03f8c:	4788      	blx	r1
c0d03f8e:	2800      	cmp	r0, #0
c0d03f90:	d007      	beq.n	c0d03fa2 <ux_menu_elements_button+0xe2>
c0d03f92:	2801      	cmp	r0, #1
c0d03f94:	d103      	bne.n	c0d03f9e <ux_menu_elements_button+0xde>
c0d03f96:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d03f98:	8ce9      	ldrh	r1, [r5, #38]	; 0x26
c0d03f9a:	0149      	lsls	r1, r1, #5
c0d03f9c:	1840      	adds	r0, r0, r1
c0d03f9e:	f7fc fc09 	bl	c0d007b4 <io_seproxyhal_display>
c0d03fa2:	8ce8      	ldrh	r0, [r5, #38]	; 0x26
c0d03fa4:	1c40      	adds	r0, r0, #1
c0d03fa6:	84e8      	strh	r0, [r5, #38]	; 0x26
c0d03fa8:	6aa9      	ldr	r1, [r5, #40]	; 0x28
c0d03faa:	2900      	cmp	r1, #0
c0d03fac:	d1d6      	bne.n	c0d03f5c <ux_menu_elements_button+0x9c>
c0d03fae:	e008      	b.n	c0d03fc2 <ux_menu_elements_button+0x102>
        // use userid as the pointer to current entry in the parent menu
        UX_MENU_DISPLAY(current_entry->userid, (const ux_menu_entry_t*)PIC(current_entry->menu), ux_menu.menu_entry_preprocessor);
        return 0;
      }
      // else callback
      else if (current_entry->callback) {
c0d03fb0:	6870      	ldr	r0, [r6, #4]
c0d03fb2:	2800      	cmp	r0, #0
c0d03fb4:	d005      	beq.n	c0d03fc2 <ux_menu_elements_button+0x102>
        ((ux_menu_callback_t)PIC(current_entry->callback))(current_entry->userid);
c0d03fb6:	f7fe f893 	bl	c0d020e0 <pic>
c0d03fba:	4601      	mov	r1, r0
c0d03fbc:	68b0      	ldr	r0, [r6, #8]
c0d03fbe:	4788      	blx	r1
c0d03fc0:	2400      	movs	r4, #0
      UX_REDISPLAY();
#endif
      return 0;
  }
  return 1;
}
c0d03fc2:	4620      	mov	r0, r4
c0d03fc4:	b001      	add	sp, #4
c0d03fc6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03fc8:	20002124 	.word	0x20002124
c0d03fcc:	80000002 	.word	0x80000002
c0d03fd0:	40000002 	.word	0x40000002
c0d03fd4:	40000001 	.word	0x40000001
c0d03fd8:	80000003 	.word	0x80000003
c0d03fdc:	80000001 	.word	0x80000001
c0d03fe0:	2000182c 	.word	0x2000182c

c0d03fe4 <ux_menu_display>:

const ux_menu_entry_t UX_MENU_END_ENTRY = UX_MENU_END;

void ux_menu_display(unsigned int current_entry, 
                     const ux_menu_entry_t* menu_entries,
                     ux_menu_preprocessor_t menu_entry_preprocessor) {
c0d03fe4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03fe6:	b083      	sub	sp, #12
c0d03fe8:	9202      	str	r2, [sp, #8]
c0d03fea:	460c      	mov	r4, r1
c0d03fec:	9001      	str	r0, [sp, #4]
  // reset to first entry
  ux_menu.menu_entries_count = 0;
c0d03fee:	4e40      	ldr	r6, [pc, #256]	; (c0d040f0 <ux_menu_display+0x10c>)
c0d03ff0:	2000      	movs	r0, #0
c0d03ff2:	9000      	str	r0, [sp, #0]
c0d03ff4:	6070      	str	r0, [r6, #4]

  // count entries
  if (menu_entries) {
c0d03ff6:	2900      	cmp	r1, #0
c0d03ff8:	d015      	beq.n	c0d04026 <ux_menu_display+0x42>
    for(;;) {
      if (os_memcmp(&menu_entries[ux_menu.menu_entries_count], &UX_MENU_END_ENTRY, sizeof(ux_menu_entry_t)) == 0) {
c0d03ffa:	493f      	ldr	r1, [pc, #252]	; (c0d040f8 <ux_menu_display+0x114>)
c0d03ffc:	4479      	add	r1, pc
c0d03ffe:	271c      	movs	r7, #28
c0d04000:	4620      	mov	r0, r4
c0d04002:	463a      	mov	r2, r7
c0d04004:	f7fd f946 	bl	c0d01294 <os_memcmp>
c0d04008:	2800      	cmp	r0, #0
c0d0400a:	d00c      	beq.n	c0d04026 <ux_menu_display+0x42>
c0d0400c:	4d3b      	ldr	r5, [pc, #236]	; (c0d040fc <ux_menu_display+0x118>)
c0d0400e:	447d      	add	r5, pc
        break;
      }
      ux_menu.menu_entries_count++;
c0d04010:	6870      	ldr	r0, [r6, #4]
c0d04012:	1c40      	adds	r0, r0, #1
c0d04014:	6070      	str	r0, [r6, #4]
  ux_menu.menu_entries_count = 0;

  // count entries
  if (menu_entries) {
    for(;;) {
      if (os_memcmp(&menu_entries[ux_menu.menu_entries_count], &UX_MENU_END_ENTRY, sizeof(ux_menu_entry_t)) == 0) {
c0d04016:	4378      	muls	r0, r7
c0d04018:	1820      	adds	r0, r4, r0
c0d0401a:	4629      	mov	r1, r5
c0d0401c:	463a      	mov	r2, r7
c0d0401e:	f7fd f939 	bl	c0d01294 <os_memcmp>
c0d04022:	2800      	cmp	r0, #0
c0d04024:	d1f4      	bne.n	c0d04010 <ux_menu_display+0x2c>
c0d04026:	9901      	ldr	r1, [sp, #4]
      }
      ux_menu.menu_entries_count++;
    }
  }

  if (current_entry != UX_MENU_UNCHANGED_ENTRY) {
c0d04028:	1c48      	adds	r0, r1, #1
c0d0402a:	d005      	beq.n	c0d04038 <ux_menu_display+0x54>
    ux_menu.current_entry = current_entry;
    if (ux_menu.current_entry > ux_menu.menu_entries_count) {
c0d0402c:	6870      	ldr	r0, [r6, #4]
c0d0402e:	4288      	cmp	r0, r1
c0d04030:	9800      	ldr	r0, [sp, #0]
c0d04032:	d300      	bcc.n	c0d04036 <ux_menu_display+0x52>
c0d04034:	4608      	mov	r0, r1
c0d04036:	60b0      	str	r0, [r6, #8]
c0d04038:	212c      	movs	r1, #44	; 0x2c
  G_ux.stack[0].button_push_callback = ux_menu_elements_button;

  ux_stack_display(0);
#else
  // display the menu current entry
  UX_DISPLAY(ux_menu_elements, ux_menu_element_preprocessor);
c0d0403a:	9101      	str	r1, [sp, #4]
c0d0403c:	4f2d      	ldr	r7, [pc, #180]	; (c0d040f4 <ux_menu_display+0x110>)
c0d0403e:	2009      	movs	r0, #9
c0d04040:	5478      	strb	r0, [r7, r1]
c0d04042:	2064      	movs	r0, #100	; 0x64
c0d04044:	2103      	movs	r1, #3
c0d04046:	5439      	strb	r1, [r7, r0]
c0d04048:	2500      	movs	r5, #0
    if (ux_menu.current_entry > ux_menu.menu_entries_count) {
      ux_menu.current_entry = 0;
    }
  }
  ux_menu.menu_entries = menu_entries;
  ux_menu.menu_entry_preprocessor = menu_entry_preprocessor;
c0d0404a:	9802      	ldr	r0, [sp, #8]
c0d0404c:	60f0      	str	r0, [r6, #12]
  ux_menu.menu_iterator = NULL;
c0d0404e:	6135      	str	r5, [r6, #16]
    ux_menu.current_entry = current_entry;
    if (ux_menu.current_entry > ux_menu.menu_entries_count) {
      ux_menu.current_entry = 0;
    }
  }
  ux_menu.menu_entries = menu_entries;
c0d04050:	6034      	str	r4, [r6, #0]
  G_ux.stack[0].button_push_callback = ux_menu_elements_button;

  ux_stack_display(0);
#else
  // display the menu current entry
  UX_DISPLAY(ux_menu_elements, ux_menu_element_preprocessor);
c0d04052:	482b      	ldr	r0, [pc, #172]	; (c0d04100 <ux_menu_display+0x11c>)
c0d04054:	4478      	add	r0, pc
c0d04056:	492b      	ldr	r1, [pc, #172]	; (c0d04104 <ux_menu_display+0x120>)
c0d04058:	4479      	add	r1, pc
c0d0405a:	62b9      	str	r1, [r7, #40]	; 0x28
c0d0405c:	66bd      	str	r5, [r7, #104]	; 0x68
c0d0405e:	492a      	ldr	r1, [pc, #168]	; (c0d04108 <ux_menu_display+0x124>)
c0d04060:	4479      	add	r1, pc
c0d04062:	6339      	str	r1, [r7, #48]	; 0x30
c0d04064:	6378      	str	r0, [r7, #52]	; 0x34
c0d04066:	4638      	mov	r0, r7
c0d04068:	3064      	adds	r0, #100	; 0x64
c0d0406a:	f7fe f927 	bl	c0d022bc <os_ux>
c0d0406e:	2404      	movs	r4, #4
c0d04070:	4620      	mov	r0, r4
c0d04072:	f7fe f995 	bl	c0d023a0 <os_sched_last_status>
c0d04076:	66b8      	str	r0, [r7, #104]	; 0x68
c0d04078:	f7fd fa74 	bl	c0d01564 <io_seproxyhal_init_ux>
c0d0407c:	f7fd fa74 	bl	c0d01568 <io_seproxyhal_init_button>
c0d04080:	84fd      	strh	r5, [r7, #38]	; 0x26
c0d04082:	4620      	mov	r0, r4
c0d04084:	9c01      	ldr	r4, [sp, #4]
c0d04086:	f7fe f98b 	bl	c0d023a0 <os_sched_last_status>
c0d0408a:	66b8      	str	r0, [r7, #104]	; 0x68
c0d0408c:	2800      	cmp	r0, #0
c0d0408e:	d02d      	beq.n	c0d040ec <ux_menu_display+0x108>
c0d04090:	2897      	cmp	r0, #151	; 0x97
c0d04092:	d02b      	beq.n	c0d040ec <ux_menu_display+0x108>
c0d04094:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d04096:	2800      	cmp	r0, #0
c0d04098:	d028      	beq.n	c0d040ec <ux_menu_display+0x108>
c0d0409a:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d0409c:	5d39      	ldrb	r1, [r7, r4]
c0d0409e:	b280      	uxth	r0, r0
c0d040a0:	4288      	cmp	r0, r1
c0d040a2:	d223      	bcs.n	c0d040ec <ux_menu_display+0x108>
c0d040a4:	f7fe f948 	bl	c0d02338 <io_seph_is_status_sent>
c0d040a8:	2800      	cmp	r0, #0
c0d040aa:	d11f      	bne.n	c0d040ec <ux_menu_display+0x108>
c0d040ac:	f7fe f8d0 	bl	c0d02250 <os_perso_isonboarded>
c0d040b0:	28aa      	cmp	r0, #170	; 0xaa
c0d040b2:	d103      	bne.n	c0d040bc <ux_menu_display+0xd8>
c0d040b4:	f7fe f8f6 	bl	c0d022a4 <os_global_pin_is_validated>
c0d040b8:	28aa      	cmp	r0, #170	; 0xaa
c0d040ba:	d117      	bne.n	c0d040ec <ux_menu_display+0x108>
c0d040bc:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d040be:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
c0d040c0:	0149      	lsls	r1, r1, #5
c0d040c2:	1840      	adds	r0, r0, r1
c0d040c4:	6b39      	ldr	r1, [r7, #48]	; 0x30
c0d040c6:	2900      	cmp	r1, #0
c0d040c8:	d002      	beq.n	c0d040d0 <ux_menu_display+0xec>
c0d040ca:	4788      	blx	r1
c0d040cc:	2800      	cmp	r0, #0
c0d040ce:	d007      	beq.n	c0d040e0 <ux_menu_display+0xfc>
c0d040d0:	2801      	cmp	r0, #1
c0d040d2:	d103      	bne.n	c0d040dc <ux_menu_display+0xf8>
c0d040d4:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d040d6:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
c0d040d8:	0149      	lsls	r1, r1, #5
c0d040da:	1840      	adds	r0, r0, r1
c0d040dc:	f7fc fb6a 	bl	c0d007b4 <io_seproxyhal_display>
c0d040e0:	8cf8      	ldrh	r0, [r7, #38]	; 0x26
c0d040e2:	1c40      	adds	r0, r0, #1
c0d040e4:	84f8      	strh	r0, [r7, #38]	; 0x26
c0d040e6:	6ab9      	ldr	r1, [r7, #40]	; 0x28
c0d040e8:	2900      	cmp	r1, #0
c0d040ea:	d1d7      	bne.n	c0d0409c <ux_menu_display+0xb8>
#endif
}
c0d040ec:	b003      	add	sp, #12
c0d040ee:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d040f0:	20002124 	.word	0x20002124
c0d040f4:	2000182c 	.word	0x2000182c
c0d040f8:	00000ddc 	.word	0x00000ddc
c0d040fc:	00000dca 	.word	0x00000dca
c0d04100:	fffffe69 	.word	0xfffffe69
c0d04104:	00000c60 	.word	0x00000c60
c0d04108:	fffffcad 	.word	0xfffffcad

c0d0410c <ux_stack_push>:
    }
  }
  return 0;
}

unsigned int ux_stack_push(void) {
c0d0410c:	b510      	push	{r4, lr}
  // only push if an available slot exists
  if (G_ux.stack_count < ARRAYLEN(G_ux.stack)) {
c0d0410e:	4c08      	ldr	r4, [pc, #32]	; (c0d04130 <ux_stack_push+0x24>)
c0d04110:	7820      	ldrb	r0, [r4, #0]
c0d04112:	2800      	cmp	r0, #0
c0d04114:	d108      	bne.n	c0d04128 <ux_stack_push+0x1c>
    os_memset(&G_ux.stack[G_ux.stack_count], 0, sizeof(G_ux.stack[0]));
c0d04116:	4620      	mov	r0, r4
c0d04118:	3024      	adds	r0, #36	; 0x24
c0d0411a:	2100      	movs	r1, #0
c0d0411c:	2220      	movs	r2, #32
c0d0411e:	f7fd f8b0 	bl	c0d01282 <os_memset>
#ifdef HAVE_UX_FLOW
    os_memset(&G_ux.flow_stack[G_ux.stack_count], 0, sizeof(G_ux.flow_stack[0]));
#endif // HAVE_UX_FLOW
    G_ux.stack_count++;
c0d04122:	7820      	ldrb	r0, [r4, #0]
c0d04124:	1c40      	adds	r0, r0, #1
c0d04126:	7020      	strb	r0, [r4, #0]
  }
  // return the stack top index
  return G_ux.stack_count-1;
c0d04128:	b2c0      	uxtb	r0, r0
c0d0412a:	1e40      	subs	r0, r0, #1
c0d0412c:	bd10      	pop	{r4, pc}
c0d0412e:	46c0      	nop			; (mov r8, r8)
c0d04130:	2000182c 	.word	0x2000182c

c0d04134 <__aeabi_uidiv>:
c0d04134:	2200      	movs	r2, #0
c0d04136:	0843      	lsrs	r3, r0, #1
c0d04138:	428b      	cmp	r3, r1
c0d0413a:	d374      	bcc.n	c0d04226 <__aeabi_uidiv+0xf2>
c0d0413c:	0903      	lsrs	r3, r0, #4
c0d0413e:	428b      	cmp	r3, r1
c0d04140:	d35f      	bcc.n	c0d04202 <__aeabi_uidiv+0xce>
c0d04142:	0a03      	lsrs	r3, r0, #8
c0d04144:	428b      	cmp	r3, r1
c0d04146:	d344      	bcc.n	c0d041d2 <__aeabi_uidiv+0x9e>
c0d04148:	0b03      	lsrs	r3, r0, #12
c0d0414a:	428b      	cmp	r3, r1
c0d0414c:	d328      	bcc.n	c0d041a0 <__aeabi_uidiv+0x6c>
c0d0414e:	0c03      	lsrs	r3, r0, #16
c0d04150:	428b      	cmp	r3, r1
c0d04152:	d30d      	bcc.n	c0d04170 <__aeabi_uidiv+0x3c>
c0d04154:	22ff      	movs	r2, #255	; 0xff
c0d04156:	0209      	lsls	r1, r1, #8
c0d04158:	ba12      	rev	r2, r2
c0d0415a:	0c03      	lsrs	r3, r0, #16
c0d0415c:	428b      	cmp	r3, r1
c0d0415e:	d302      	bcc.n	c0d04166 <__aeabi_uidiv+0x32>
c0d04160:	1212      	asrs	r2, r2, #8
c0d04162:	0209      	lsls	r1, r1, #8
c0d04164:	d065      	beq.n	c0d04232 <__aeabi_uidiv+0xfe>
c0d04166:	0b03      	lsrs	r3, r0, #12
c0d04168:	428b      	cmp	r3, r1
c0d0416a:	d319      	bcc.n	c0d041a0 <__aeabi_uidiv+0x6c>
c0d0416c:	e000      	b.n	c0d04170 <__aeabi_uidiv+0x3c>
c0d0416e:	0a09      	lsrs	r1, r1, #8
c0d04170:	0bc3      	lsrs	r3, r0, #15
c0d04172:	428b      	cmp	r3, r1
c0d04174:	d301      	bcc.n	c0d0417a <__aeabi_uidiv+0x46>
c0d04176:	03cb      	lsls	r3, r1, #15
c0d04178:	1ac0      	subs	r0, r0, r3
c0d0417a:	4152      	adcs	r2, r2
c0d0417c:	0b83      	lsrs	r3, r0, #14
c0d0417e:	428b      	cmp	r3, r1
c0d04180:	d301      	bcc.n	c0d04186 <__aeabi_uidiv+0x52>
c0d04182:	038b      	lsls	r3, r1, #14
c0d04184:	1ac0      	subs	r0, r0, r3
c0d04186:	4152      	adcs	r2, r2
c0d04188:	0b43      	lsrs	r3, r0, #13
c0d0418a:	428b      	cmp	r3, r1
c0d0418c:	d301      	bcc.n	c0d04192 <__aeabi_uidiv+0x5e>
c0d0418e:	034b      	lsls	r3, r1, #13
c0d04190:	1ac0      	subs	r0, r0, r3
c0d04192:	4152      	adcs	r2, r2
c0d04194:	0b03      	lsrs	r3, r0, #12
c0d04196:	428b      	cmp	r3, r1
c0d04198:	d301      	bcc.n	c0d0419e <__aeabi_uidiv+0x6a>
c0d0419a:	030b      	lsls	r3, r1, #12
c0d0419c:	1ac0      	subs	r0, r0, r3
c0d0419e:	4152      	adcs	r2, r2
c0d041a0:	0ac3      	lsrs	r3, r0, #11
c0d041a2:	428b      	cmp	r3, r1
c0d041a4:	d301      	bcc.n	c0d041aa <__aeabi_uidiv+0x76>
c0d041a6:	02cb      	lsls	r3, r1, #11
c0d041a8:	1ac0      	subs	r0, r0, r3
c0d041aa:	4152      	adcs	r2, r2
c0d041ac:	0a83      	lsrs	r3, r0, #10
c0d041ae:	428b      	cmp	r3, r1
c0d041b0:	d301      	bcc.n	c0d041b6 <__aeabi_uidiv+0x82>
c0d041b2:	028b      	lsls	r3, r1, #10
c0d041b4:	1ac0      	subs	r0, r0, r3
c0d041b6:	4152      	adcs	r2, r2
c0d041b8:	0a43      	lsrs	r3, r0, #9
c0d041ba:	428b      	cmp	r3, r1
c0d041bc:	d301      	bcc.n	c0d041c2 <__aeabi_uidiv+0x8e>
c0d041be:	024b      	lsls	r3, r1, #9
c0d041c0:	1ac0      	subs	r0, r0, r3
c0d041c2:	4152      	adcs	r2, r2
c0d041c4:	0a03      	lsrs	r3, r0, #8
c0d041c6:	428b      	cmp	r3, r1
c0d041c8:	d301      	bcc.n	c0d041ce <__aeabi_uidiv+0x9a>
c0d041ca:	020b      	lsls	r3, r1, #8
c0d041cc:	1ac0      	subs	r0, r0, r3
c0d041ce:	4152      	adcs	r2, r2
c0d041d0:	d2cd      	bcs.n	c0d0416e <__aeabi_uidiv+0x3a>
c0d041d2:	09c3      	lsrs	r3, r0, #7
c0d041d4:	428b      	cmp	r3, r1
c0d041d6:	d301      	bcc.n	c0d041dc <__aeabi_uidiv+0xa8>
c0d041d8:	01cb      	lsls	r3, r1, #7
c0d041da:	1ac0      	subs	r0, r0, r3
c0d041dc:	4152      	adcs	r2, r2
c0d041de:	0983      	lsrs	r3, r0, #6
c0d041e0:	428b      	cmp	r3, r1
c0d041e2:	d301      	bcc.n	c0d041e8 <__aeabi_uidiv+0xb4>
c0d041e4:	018b      	lsls	r3, r1, #6
c0d041e6:	1ac0      	subs	r0, r0, r3
c0d041e8:	4152      	adcs	r2, r2
c0d041ea:	0943      	lsrs	r3, r0, #5
c0d041ec:	428b      	cmp	r3, r1
c0d041ee:	d301      	bcc.n	c0d041f4 <__aeabi_uidiv+0xc0>
c0d041f0:	014b      	lsls	r3, r1, #5
c0d041f2:	1ac0      	subs	r0, r0, r3
c0d041f4:	4152      	adcs	r2, r2
c0d041f6:	0903      	lsrs	r3, r0, #4
c0d041f8:	428b      	cmp	r3, r1
c0d041fa:	d301      	bcc.n	c0d04200 <__aeabi_uidiv+0xcc>
c0d041fc:	010b      	lsls	r3, r1, #4
c0d041fe:	1ac0      	subs	r0, r0, r3
c0d04200:	4152      	adcs	r2, r2
c0d04202:	08c3      	lsrs	r3, r0, #3
c0d04204:	428b      	cmp	r3, r1
c0d04206:	d301      	bcc.n	c0d0420c <__aeabi_uidiv+0xd8>
c0d04208:	00cb      	lsls	r3, r1, #3
c0d0420a:	1ac0      	subs	r0, r0, r3
c0d0420c:	4152      	adcs	r2, r2
c0d0420e:	0883      	lsrs	r3, r0, #2
c0d04210:	428b      	cmp	r3, r1
c0d04212:	d301      	bcc.n	c0d04218 <__aeabi_uidiv+0xe4>
c0d04214:	008b      	lsls	r3, r1, #2
c0d04216:	1ac0      	subs	r0, r0, r3
c0d04218:	4152      	adcs	r2, r2
c0d0421a:	0843      	lsrs	r3, r0, #1
c0d0421c:	428b      	cmp	r3, r1
c0d0421e:	d301      	bcc.n	c0d04224 <__aeabi_uidiv+0xf0>
c0d04220:	004b      	lsls	r3, r1, #1
c0d04222:	1ac0      	subs	r0, r0, r3
c0d04224:	4152      	adcs	r2, r2
c0d04226:	1a41      	subs	r1, r0, r1
c0d04228:	d200      	bcs.n	c0d0422c <__aeabi_uidiv+0xf8>
c0d0422a:	4601      	mov	r1, r0
c0d0422c:	4152      	adcs	r2, r2
c0d0422e:	4610      	mov	r0, r2
c0d04230:	4770      	bx	lr
c0d04232:	e7ff      	b.n	c0d04234 <__aeabi_uidiv+0x100>
c0d04234:	b501      	push	{r0, lr}
c0d04236:	2000      	movs	r0, #0
c0d04238:	f000 f806 	bl	c0d04248 <__aeabi_idiv0>
c0d0423c:	bd02      	pop	{r1, pc}
c0d0423e:	46c0      	nop			; (mov r8, r8)

c0d04240 <__aeabi_uidivmod>:
c0d04240:	2900      	cmp	r1, #0
c0d04242:	d0f7      	beq.n	c0d04234 <__aeabi_uidiv+0x100>
c0d04244:	e776      	b.n	c0d04134 <__aeabi_uidiv>
c0d04246:	4770      	bx	lr

c0d04248 <__aeabi_idiv0>:
c0d04248:	4770      	bx	lr
c0d0424a:	46c0      	nop			; (mov r8, r8)

c0d0424c <__aeabi_memclr>:
c0d0424c:	b510      	push	{r4, lr}
c0d0424e:	2200      	movs	r2, #0
c0d04250:	f000 f806 	bl	c0d04260 <__aeabi_memset>
c0d04254:	bd10      	pop	{r4, pc}
c0d04256:	46c0      	nop			; (mov r8, r8)

c0d04258 <__aeabi_memcpy>:
c0d04258:	b510      	push	{r4, lr}
c0d0425a:	f000 f809 	bl	c0d04270 <memcpy>
c0d0425e:	bd10      	pop	{r4, pc}

c0d04260 <__aeabi_memset>:
c0d04260:	0013      	movs	r3, r2
c0d04262:	b510      	push	{r4, lr}
c0d04264:	000a      	movs	r2, r1
c0d04266:	0019      	movs	r1, r3
c0d04268:	f000 f840 	bl	c0d042ec <memset>
c0d0426c:	bd10      	pop	{r4, pc}
c0d0426e:	46c0      	nop			; (mov r8, r8)

c0d04270 <memcpy>:
c0d04270:	b570      	push	{r4, r5, r6, lr}
c0d04272:	2a0f      	cmp	r2, #15
c0d04274:	d932      	bls.n	c0d042dc <memcpy+0x6c>
c0d04276:	000c      	movs	r4, r1
c0d04278:	4304      	orrs	r4, r0
c0d0427a:	000b      	movs	r3, r1
c0d0427c:	07a4      	lsls	r4, r4, #30
c0d0427e:	d131      	bne.n	c0d042e4 <memcpy+0x74>
c0d04280:	0015      	movs	r5, r2
c0d04282:	0004      	movs	r4, r0
c0d04284:	3d10      	subs	r5, #16
c0d04286:	092d      	lsrs	r5, r5, #4
c0d04288:	3501      	adds	r5, #1
c0d0428a:	012d      	lsls	r5, r5, #4
c0d0428c:	1949      	adds	r1, r1, r5
c0d0428e:	681e      	ldr	r6, [r3, #0]
c0d04290:	6026      	str	r6, [r4, #0]
c0d04292:	685e      	ldr	r6, [r3, #4]
c0d04294:	6066      	str	r6, [r4, #4]
c0d04296:	689e      	ldr	r6, [r3, #8]
c0d04298:	60a6      	str	r6, [r4, #8]
c0d0429a:	68de      	ldr	r6, [r3, #12]
c0d0429c:	3310      	adds	r3, #16
c0d0429e:	60e6      	str	r6, [r4, #12]
c0d042a0:	3410      	adds	r4, #16
c0d042a2:	4299      	cmp	r1, r3
c0d042a4:	d1f3      	bne.n	c0d0428e <memcpy+0x1e>
c0d042a6:	230f      	movs	r3, #15
c0d042a8:	1945      	adds	r5, r0, r5
c0d042aa:	4013      	ands	r3, r2
c0d042ac:	2b03      	cmp	r3, #3
c0d042ae:	d91b      	bls.n	c0d042e8 <memcpy+0x78>
c0d042b0:	1f1c      	subs	r4, r3, #4
c0d042b2:	2300      	movs	r3, #0
c0d042b4:	08a4      	lsrs	r4, r4, #2
c0d042b6:	3401      	adds	r4, #1
c0d042b8:	00a4      	lsls	r4, r4, #2
c0d042ba:	58ce      	ldr	r6, [r1, r3]
c0d042bc:	50ee      	str	r6, [r5, r3]
c0d042be:	3304      	adds	r3, #4
c0d042c0:	429c      	cmp	r4, r3
c0d042c2:	d1fa      	bne.n	c0d042ba <memcpy+0x4a>
c0d042c4:	2303      	movs	r3, #3
c0d042c6:	192d      	adds	r5, r5, r4
c0d042c8:	1909      	adds	r1, r1, r4
c0d042ca:	401a      	ands	r2, r3
c0d042cc:	d005      	beq.n	c0d042da <memcpy+0x6a>
c0d042ce:	2300      	movs	r3, #0
c0d042d0:	5ccc      	ldrb	r4, [r1, r3]
c0d042d2:	54ec      	strb	r4, [r5, r3]
c0d042d4:	3301      	adds	r3, #1
c0d042d6:	429a      	cmp	r2, r3
c0d042d8:	d1fa      	bne.n	c0d042d0 <memcpy+0x60>
c0d042da:	bd70      	pop	{r4, r5, r6, pc}
c0d042dc:	0005      	movs	r5, r0
c0d042de:	2a00      	cmp	r2, #0
c0d042e0:	d1f5      	bne.n	c0d042ce <memcpy+0x5e>
c0d042e2:	e7fa      	b.n	c0d042da <memcpy+0x6a>
c0d042e4:	0005      	movs	r5, r0
c0d042e6:	e7f2      	b.n	c0d042ce <memcpy+0x5e>
c0d042e8:	001a      	movs	r2, r3
c0d042ea:	e7f8      	b.n	c0d042de <memcpy+0x6e>

c0d042ec <memset>:
c0d042ec:	b570      	push	{r4, r5, r6, lr}
c0d042ee:	0783      	lsls	r3, r0, #30
c0d042f0:	d03f      	beq.n	c0d04372 <memset+0x86>
c0d042f2:	1e54      	subs	r4, r2, #1
c0d042f4:	2a00      	cmp	r2, #0
c0d042f6:	d03b      	beq.n	c0d04370 <memset+0x84>
c0d042f8:	b2ce      	uxtb	r6, r1
c0d042fa:	0003      	movs	r3, r0
c0d042fc:	2503      	movs	r5, #3
c0d042fe:	e003      	b.n	c0d04308 <memset+0x1c>
c0d04300:	1e62      	subs	r2, r4, #1
c0d04302:	2c00      	cmp	r4, #0
c0d04304:	d034      	beq.n	c0d04370 <memset+0x84>
c0d04306:	0014      	movs	r4, r2
c0d04308:	3301      	adds	r3, #1
c0d0430a:	1e5a      	subs	r2, r3, #1
c0d0430c:	7016      	strb	r6, [r2, #0]
c0d0430e:	422b      	tst	r3, r5
c0d04310:	d1f6      	bne.n	c0d04300 <memset+0x14>
c0d04312:	2c03      	cmp	r4, #3
c0d04314:	d924      	bls.n	c0d04360 <memset+0x74>
c0d04316:	25ff      	movs	r5, #255	; 0xff
c0d04318:	400d      	ands	r5, r1
c0d0431a:	022a      	lsls	r2, r5, #8
c0d0431c:	4315      	orrs	r5, r2
c0d0431e:	042a      	lsls	r2, r5, #16
c0d04320:	4315      	orrs	r5, r2
c0d04322:	2c0f      	cmp	r4, #15
c0d04324:	d911      	bls.n	c0d0434a <memset+0x5e>
c0d04326:	0026      	movs	r6, r4
c0d04328:	3e10      	subs	r6, #16
c0d0432a:	0936      	lsrs	r6, r6, #4
c0d0432c:	3601      	adds	r6, #1
c0d0432e:	0136      	lsls	r6, r6, #4
c0d04330:	001a      	movs	r2, r3
c0d04332:	199b      	adds	r3, r3, r6
c0d04334:	6015      	str	r5, [r2, #0]
c0d04336:	6055      	str	r5, [r2, #4]
c0d04338:	6095      	str	r5, [r2, #8]
c0d0433a:	60d5      	str	r5, [r2, #12]
c0d0433c:	3210      	adds	r2, #16
c0d0433e:	4293      	cmp	r3, r2
c0d04340:	d1f8      	bne.n	c0d04334 <memset+0x48>
c0d04342:	220f      	movs	r2, #15
c0d04344:	4014      	ands	r4, r2
c0d04346:	2c03      	cmp	r4, #3
c0d04348:	d90a      	bls.n	c0d04360 <memset+0x74>
c0d0434a:	1f26      	subs	r6, r4, #4
c0d0434c:	08b6      	lsrs	r6, r6, #2
c0d0434e:	3601      	adds	r6, #1
c0d04350:	00b6      	lsls	r6, r6, #2
c0d04352:	001a      	movs	r2, r3
c0d04354:	199b      	adds	r3, r3, r6
c0d04356:	c220      	stmia	r2!, {r5}
c0d04358:	4293      	cmp	r3, r2
c0d0435a:	d1fc      	bne.n	c0d04356 <memset+0x6a>
c0d0435c:	2203      	movs	r2, #3
c0d0435e:	4014      	ands	r4, r2
c0d04360:	2c00      	cmp	r4, #0
c0d04362:	d005      	beq.n	c0d04370 <memset+0x84>
c0d04364:	b2c9      	uxtb	r1, r1
c0d04366:	191c      	adds	r4, r3, r4
c0d04368:	7019      	strb	r1, [r3, #0]
c0d0436a:	3301      	adds	r3, #1
c0d0436c:	429c      	cmp	r4, r3
c0d0436e:	d1fb      	bne.n	c0d04368 <memset+0x7c>
c0d04370:	bd70      	pop	{r4, r5, r6, pc}
c0d04372:	0014      	movs	r4, r2
c0d04374:	0003      	movs	r3, r0
c0d04376:	e7cc      	b.n	c0d04312 <memset+0x26>

c0d04378 <setjmp>:
c0d04378:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d0437a:	4641      	mov	r1, r8
c0d0437c:	464a      	mov	r2, r9
c0d0437e:	4653      	mov	r3, sl
c0d04380:	465c      	mov	r4, fp
c0d04382:	466d      	mov	r5, sp
c0d04384:	4676      	mov	r6, lr
c0d04386:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d04388:	3828      	subs	r0, #40	; 0x28
c0d0438a:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d0438c:	2000      	movs	r0, #0
c0d0438e:	4770      	bx	lr

c0d04390 <longjmp>:
c0d04390:	3010      	adds	r0, #16
c0d04392:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d04394:	4690      	mov	r8, r2
c0d04396:	4699      	mov	r9, r3
c0d04398:	46a2      	mov	sl, r4
c0d0439a:	46ab      	mov	fp, r5
c0d0439c:	46b5      	mov	sp, r6
c0d0439e:	c808      	ldmia	r0!, {r3}
c0d043a0:	3828      	subs	r0, #40	; 0x28
c0d043a2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d043a4:	1c08      	adds	r0, r1, #0
c0d043a6:	d100      	bne.n	c0d043aa <longjmp+0x1a>
c0d043a8:	2001      	movs	r0, #1
c0d043aa:	4718      	bx	r3

c0d043ac <strlen>:
c0d043ac:	b510      	push	{r4, lr}
c0d043ae:	0783      	lsls	r3, r0, #30
c0d043b0:	d027      	beq.n	c0d04402 <strlen+0x56>
c0d043b2:	7803      	ldrb	r3, [r0, #0]
c0d043b4:	2b00      	cmp	r3, #0
c0d043b6:	d026      	beq.n	c0d04406 <strlen+0x5a>
c0d043b8:	0003      	movs	r3, r0
c0d043ba:	2103      	movs	r1, #3
c0d043bc:	e002      	b.n	c0d043c4 <strlen+0x18>
c0d043be:	781a      	ldrb	r2, [r3, #0]
c0d043c0:	2a00      	cmp	r2, #0
c0d043c2:	d01c      	beq.n	c0d043fe <strlen+0x52>
c0d043c4:	3301      	adds	r3, #1
c0d043c6:	420b      	tst	r3, r1
c0d043c8:	d1f9      	bne.n	c0d043be <strlen+0x12>
c0d043ca:	6819      	ldr	r1, [r3, #0]
c0d043cc:	4a0f      	ldr	r2, [pc, #60]	; (c0d0440c <strlen+0x60>)
c0d043ce:	4c10      	ldr	r4, [pc, #64]	; (c0d04410 <strlen+0x64>)
c0d043d0:	188a      	adds	r2, r1, r2
c0d043d2:	438a      	bics	r2, r1
c0d043d4:	4222      	tst	r2, r4
c0d043d6:	d10f      	bne.n	c0d043f8 <strlen+0x4c>
c0d043d8:	3304      	adds	r3, #4
c0d043da:	6819      	ldr	r1, [r3, #0]
c0d043dc:	4a0b      	ldr	r2, [pc, #44]	; (c0d0440c <strlen+0x60>)
c0d043de:	188a      	adds	r2, r1, r2
c0d043e0:	438a      	bics	r2, r1
c0d043e2:	4222      	tst	r2, r4
c0d043e4:	d108      	bne.n	c0d043f8 <strlen+0x4c>
c0d043e6:	3304      	adds	r3, #4
c0d043e8:	6819      	ldr	r1, [r3, #0]
c0d043ea:	4a08      	ldr	r2, [pc, #32]	; (c0d0440c <strlen+0x60>)
c0d043ec:	188a      	adds	r2, r1, r2
c0d043ee:	438a      	bics	r2, r1
c0d043f0:	4222      	tst	r2, r4
c0d043f2:	d0f1      	beq.n	c0d043d8 <strlen+0x2c>
c0d043f4:	e000      	b.n	c0d043f8 <strlen+0x4c>
c0d043f6:	3301      	adds	r3, #1
c0d043f8:	781a      	ldrb	r2, [r3, #0]
c0d043fa:	2a00      	cmp	r2, #0
c0d043fc:	d1fb      	bne.n	c0d043f6 <strlen+0x4a>
c0d043fe:	1a18      	subs	r0, r3, r0
c0d04400:	bd10      	pop	{r4, pc}
c0d04402:	0003      	movs	r3, r0
c0d04404:	e7e1      	b.n	c0d043ca <strlen+0x1e>
c0d04406:	2000      	movs	r0, #0
c0d04408:	e7fa      	b.n	c0d04400 <strlen+0x54>
c0d0440a:	46c0      	nop			; (mov r8, r8)
c0d0440c:	fefefeff 	.word	0xfefefeff
c0d04410:	80808080 	.word	0x80808080
c0d04414:	44434241 	.word	0x44434241
c0d04418:	48474645 	.word	0x48474645
c0d0441c:	4c4b4a49 	.word	0x4c4b4a49
c0d04420:	504f4e4d 	.word	0x504f4e4d
c0d04424:	54535251 	.word	0x54535251
c0d04428:	58575655 	.word	0x58575655
c0d0442c:	33325a59 	.word	0x33325a59
c0d04430:	37363534 	.word	0x37363534
c0d04434:	00000000 	.word	0x00000000

c0d04438 <C_icon_NEM_colors>:
c0d04438:	00000000 00ffffff                       ........

c0d04440 <C_icon_NEM_bitmap>:
c0d04440:	ffffffff bbeddfc0 73bdeef7 f9f7d30f     ...........s....
c0d04450:	ffedff7b fffffffc 0000000f              {...........

c0d0445c <C_icon_NEM>:
c0d0445c:	0000000e 0000000e 00000001 c0d04438     ............8D..
c0d0446c:	c0d04440                                @D..

c0d04470 <C_icon_back_colors>:
c0d04470:	00000000 00ffffff                       ........

c0d04478 <C_icon_back_bitmap>:
c0d04478:	c1fe01e0 067f38fd c4ff81df bcfff37f     .....8..........
c0d04488:	f1e7e71f 7807f83f 00000000              ....?..x....

c0d04494 <C_icon_back>:
c0d04494:	0000000e 0000000e 00000001 c0d04470     ............pD..
c0d044a4:	c0d04478                                xD..

c0d044a8 <C_icon_dashboard_colors>:
c0d044a8:	00000000 00ffffff                       ........

c0d044b0 <C_icon_dashboard_bitmap>:
c0d044b0:	c1fe01e0 067038ff 9e7e79d8 b9e7e79f     .....8p..y~.....
c0d044c0:	f1c0e601 7807f83f 00000000              ....?..x....

c0d044cc <C_icon_dashboard>:
c0d044cc:	0000000e 0000000e 00000001 c0d044a8     .............D..
c0d044dc:	c0d044b0 73726556 006e6f69 2e302e30     .D..Version.0.0.
c0d044ec:	75410031 726f6874 53444600 63614200     1.Author.FDS.Bac
c0d044fc:	6557006b 6d6f636c 6f742065 6d795300     k.Welcome to.Sym
c0d0450c:	206c6f62 6c6c6177 41007465 74756f62     bol wallet.About
c0d0451c:	69755100 70612074 78450070 74726f70     .Quit app.Export
c0d0452c:	4d454e00 63636120 746e756f 64644100     .NEM account.Add
c0d0453c:	73736572 6e6f4300 6d726966 69727000     ress.Confirm.pri
c0d0454c:	0a203a76 30322500 654e0078 50412077     v: ..%20x.New AP
c0d0455c:	72205544 69656365 3a646576 2a2e250a     DU received:.%.*
c0d0456c:	00000a48                                H...

c0d04570 <menu_about>:
	...
c0d04580:	c0d044e0 c0d044e8 00000000 00000000     .D...D..........
	...
c0d0459c:	c0d044ee c0d044f5 00000000 c0d045e0     .D...D.......E..
c0d045ac:	00000000 00000001 c0d04494 c0d044f9     .........D...D..
c0d045bc:	00000000 0000283d 00000000 00000000     ....=(..........
	...

c0d045e0 <menu_main>:
	...
c0d045ec:	c0d0445c c0d044fe c0d04509 00000c21     \D...D...E..!...
c0d045fc:	c0d04570 00000000 00000000 00000000     pE..............
c0d0460c:	c0d04517 00000000 00000000 00000000     .E..............
c0d0461c:	c0d02309 00000000 c0d044cc c0d0451d     .#.......D...E..
c0d0462c:	00000000 00001d32 00000000 00000000     ....2...........
	...

c0d04650 <ui_address_nanos>:
c0d04650:	00000003 00800000 00000020 00000001     ........ .......
c0d04660:	00000000 00ffffff 00000000 00000000     ................
c0d04670:	00030005 0007000c 00000007 00000000     ................
c0d04680:	00ffffff 00000000 00070000 00000000     ................
c0d04690:	00750005 0008000d 00000006 00000000     ..u.............
c0d046a0:	00ffffff 00000000 00060000 00000000     ................
c0d046b0:	00000107 0080000c 00000020 00000000     ........ .......
c0d046c0:	00ffffff 00000000 00008008 c0d04526     ............&E..
c0d046d0:	00000107 0080001a 00000020 00000000     ........ .......
c0d046e0:	00ffffff 00000000 00008008 c0d0452d     ............-E..
c0d046f0:	00000207 0080000c 00000020 00000000     ........ .......
c0d04700:	00ffffff 00000000 0000800a c0d04539     ............9E..
c0d04710:	00170207 0052001a 008a000c 00000000     ......R.........
c0d04720:	00ffffff 00000000 001a8008 20001800     ............... 

c0d04730 <ui_approval_details>:
c0d04730:	2000192c 20001800 2000193b 200019d1     ,.. ... ;.. ... 
c0d04740:	2000194a 200019e2 20001959 200019f3     J.. ... Y.. ... 
c0d04750:	20001968 20001a04 20001977 20001a15     h.. ... w.. ... 
c0d04760:	20001986 20001a26 20001995 20001a37     ... &.. ... 7.. 
c0d04770:	200019a4 20001a48 200019b3 20001a59     ... H.. ... Y.. 
c0d04780:	200019c2 20001a6a                       ... j.. 

c0d04788 <ui_approval_nanos>:
c0d04788:	00000003 00800000 00000020 00000001     ........ .......
c0d04798:	00000000 00ffffff 00000000 00000000     ................
c0d047a8:	00030005 0007000c 00000007 00000000     ................
c0d047b8:	00ffffff 00000000 00070000 00000000     ................
c0d047c8:	00750005 0008000d 00000006 00000000     ..u.............
c0d047d8:	00ffffff 00000000 00060000 00000000     ................
c0d047e8:	00000107 0080000c 00000020 00000000     ........ .......
c0d047f8:	00ffffff 00000000 00008008 c0d04541     ............AE..
c0d04808:	00000107 0080001a 00000020 00000000     ........ .......
c0d04818:	00ffffff 00000000 00008008 20001a7b     ............{.. 
c0d04828:	00000207 0080000c 00000020 00000000     ........ .......
c0d04838:	00ffffff 00000000 0000800a 00000000     ................
c0d04848:	00171207 0052001a 008a000c 00000000     ......R.........
c0d04858:	00ffffff 00000000 001a8008 00000000     ................
c0d04868:	6e617254 72656673 00585420 65637865     Transfer TX.exce
c0d04878:	6f697470 64255b6e 4c203a5d 78303d52     ption[%d]: LR=0x
c0d04888:	58383025 01b0000a b0000000 000000a7     %08X............
c0d04898:	000002b0 45002000 524f5252 32313000              ..... .ERROR.

c0d048a5 <g_pcHex>:
c0d048a5:	33323130 37363534 62613938 66656463     0123456789abcdef

c0d048b5 <g_pcHex_cap>:
c0d048b5:	33323130 37363534 42413938 46454443     0123456789ABCDEF

c0d048c5 <SW_INTERNAL>:
c0d048c5:	0190006f                                         o.

c0d048c7 <SW_BUSY>:
c0d048c7:	00670190                                         ..

c0d048c9 <SW_WRONG_LENGTH>:
c0d048c9:	85690067                                         g.

c0d048cb <SW_PROOF_OF_PRESENCE_REQUIRED>:
c0d048cb:	d0f18569 00000000 004d454e 00900090     i.......NEM.....
	...

c0d048dc <SW_BAD_KEY_HANDLE>:
c0d048dc:	3255806a                                         j.

c0d048de <U2F_VERSION>:
c0d048de:	5f463255 00903256                       U2F_V2..

c0d048e6 <INFO>:
c0d048e6:	00900901                                ....

c0d048ea <SW_UNKNOWN_CLASS>:
c0d048ea:	006d006e                                         n.

c0d048ec <SW_UNKNOWN_INSTRUCTION>:
c0d048ec:	6552006d 73657571 6f742074 6e657320     m.Request to sen
c0d048fc:	6e6f2064 736e7520 6f707075 64657472     d on unsupported
c0d0490c:	64656d20 25206169 ff000a64                        media %d..

c0d04917 <BROADCAST_CHANNEL>:
c0d04917:	ffffffff                                ....

c0d0491b <FORBIDDEN_CHANNEL>:
c0d0491b:	00000000 11210900                                .....

c0d04920 <USBD_HID_Desc_fido>:
c0d04920:	01112109 22220121 00000000              .!..!.""....

c0d0492c <USBD_HID_Desc>:
c0d0492c:	01112109 22220100 f1d00600                       .!...."".

c0d04935 <HID_ReportDesc_fido>:
c0d04935:	09f1d006 0901a101 26001503 087500ff     ...........&..u.
c0d04945:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d04955:	a006c008                                         ..

c0d04957 <HID_ReportDesc>:
c0d04957:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d04967:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d04977:	0317c008                                         ..

c0d04979 <C_webusb_url_descriptor>:
c0d04979:	77010317 6c2e7777 65676465 6c617772     ...www.ledgerwal
c0d04989:	2e74656c 056d6f63                                let.com

c0d04990 <C_usb_bos>:
c0d04990:	00390f05 05101802 08b63800 a009a934     ..9......8..4...
c0d049a0:	a0fd8b47 b6158876 1e010065 05101c01     G...v...e.......
c0d049b0:	dd60df00 c74589d8 65d29c4c 8a649e9d     ..`...E.L..e..d.
c0d049c0:	0300009f 7700b206 00000000              .......w....

c0d049cc <HID_Desc>:
c0d049cc:	c0d03a79 c0d03a89 c0d03a99 c0d03aa9     y:...:...:...:..
c0d049dc:	c0d03ab9 c0d03ac9 c0d03ad9 c0d03ae9     .:...:...:...:..

c0d049ec <C_winusb_string_descriptor>:
c0d049ec:	004d0312 00460053 00310054 00300030     ..M.S.F.T.1.0.0.
c0d049fc:	00920077                                         w.

c0d049fe <C_winusb_guid>:
c0d049fe:	00000092 00050100 00880001 00070000     ................
c0d04a0e:	002a0000 00650044 00690076 00650063     ..*.D.e.v.i.c.e.
c0d04a1e:	006e0049 00650074 00660072 00630061     I.n.t.e.r.f.a.c.
c0d04a2e:	00470065 00490055 00730044 00500000     e.G.U.I.D.s...P.
c0d04a3e:	007b0000 00330031 00360064 00340033     ..{.1.3.d.6.3.4.
c0d04a4e:	00300030 0032002d 00390043 002d0037     0.0.-.2.C.9.7.-.
c0d04a5e:	00300030 00340030 0030002d 00300030     0.0.0.4.-.0.0.0.
c0d04a6e:	002d0030 00630034 00350036 00340036     0.-.4.c.6.5.6.4.
c0d04a7e:	00370036 00350036 00320037 0000007d     6.7.6.5.7.2.}...
	...

c0d04a90 <C_winusb_request_descriptor>:
c0d04a90:	0000000a 06030000 000800b2 00000001     ................
c0d04aa0:	000800a8 00020002 001400a0 49570003     ..............WI
c0d04ab0:	4253554e 00000000 00000000 00840000     NUSB............
c0d04ac0:	00070004 0044002a 00760065 00630069     ....*.D.e.v.i.c.
c0d04ad0:	00490065 0074006e 00720065 00610066     e.I.n.t.e.r.f.a.
c0d04ae0:	00650063 00550047 00440049 00000073     c.e.G.U.I.D.s...
c0d04af0:	007b0050 00450043 00300038 00320039     P.{.C.E.8.0.9.2.
c0d04b00:	00340036 0034002d 00320042 002d0034     6.4.-.4.B.2.4.-.
c0d04b10:	00450034 00310038 0041002d 00420038     4.E.8.1.-.A.8.B.
c0d04b20:	002d0032 00370035 00440045 00310030     2.-.5.7.E.D.0.1.
c0d04b30:	00350044 00300038 00310045 0000007d     D.5.8.0.E.1.}...
c0d04b40:	00000000                                ....

c0d04b44 <USBD_HID>:
c0d04b44:	c0d03823 c0d03855 c0d0378d 00000000     #8..U8...7......
c0d04b54:	00000000 c0d0397d c0d03995 00000000     ....}9...9......
	...
c0d04b6c:	c0d03c6d c0d03c6d c0d03c6d c0d03c7d     m<..m<..m<..}<..

c0d04b7c <USBD_U2F>:
c0d04b7c:	c0d03905 c0d03855 c0d0378d 00000000     .9..U8...7......
c0d04b8c:	00000000 c0d03939 c0d03951 00000000     ....99..Q9......
	...
c0d04ba4:	c0d03c6d c0d03c6d c0d03c6d c0d03c7d     m<..m<..m<..}<..

c0d04bb4 <USBD_WEBUSB>:
c0d04bb4:	c0d039e1 c0d03a0d c0d03a11 00000000     .9...:...:......
c0d04bc4:	00000000 c0d03a15 c0d03a2d 00000000     .....:..-:......
	...
c0d04bdc:	c0d03c6d c0d03c6d c0d03c6d c0d03c7d     m<..m<..m<..}<..

c0d04bec <USBD_DeviceDesc>:
c0d04bec:	02100112 40000000 10152c97 02010201     .......@.,......
c0d04bfc:	03040103                                         ..

c0d04bfe <USBD_LangIDDesc>:
c0d04bfe:	04090304                                ....

c0d04c02 <USBD_MANUFACTURER_STRING>:
c0d04c02:	004c030e 00640065 00650067 030e0072              ..L.e.d.g.e.r.

c0d04c10 <USBD_PRODUCT_FS_STRING>:
c0d04c10:	004e030e 006e0061 0020006f 030a0053              ..N.a.n.o. .S.

c0d04c1e <USB_SERIAL_STRING>:
c0d04c1e:	0030030a 00300030 00280031                       ..0.0.0.1.

c0d04c28 <C_winusb_wcid>:
c0d04c28:	00000028 00040100 00000001 00000000     (...............
c0d04c38:	49570102 4253554e 00000000 00000000     ..WINUSB........
	...

c0d04c50 <USBD_CfgDesc>:
c0d04c50:	00600209 c0020103 00040932 00030200     ..`.....2.......
c0d04c60:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d04c70:	05070100 00400302 01040901 01030200     ......@.........
c0d04c80:	21090201 01210111 07002222 40038105     ...!..!."".....@
c0d04c90:	05070100 00400301 02040901 ffff0200     ......@.........
c0d04ca0:	050702ff 00400383 03050701 01004003     ......@......@..

c0d04cb0 <USBD_DeviceQualifierDesc>:
c0d04cb0:	0200060a 40000000 00000001              .......@....

c0d04cbc <ux_menu_elements>:
c0d04cbc:	00008003 00800000 00000020 00000001     ........ .......
c0d04ccc:	00000000 00ffffff 00000000 00000000     ................
c0d04cdc:	00038105 0007000e 00000004 00000000     ................
c0d04cec:	00ffffff 00000000 000b0000 00000000     ................
c0d04cfc:	00768205 0007000e 00000004 00000000     ..v.............
c0d04d0c:	00ffffff 00000000 000c0000 00000000     ................
c0d04d1c:	000e4107 00640003 0000000c 00000000     .A....d.........
c0d04d2c:	00ffffff 00000000 0000800a 00000000     ................
c0d04d3c:	000e4207 00640023 0000000c 00000000     .B..#.d.........
c0d04d4c:	00ffffff 00000000 0000800a 00000000     ................
c0d04d5c:	000e1005 00000009 00000000 00000000     ................
c0d04d6c:	00ffffff 00000000 00000000 00000000     ................
c0d04d7c:	000e2007 00640013 0000000c 00000000     . ....d.........
c0d04d8c:	00ffffff 00000000 00008008 00000000     ................
c0d04d9c:	000e2107 0064000c 0000000c 00000000     .!....d.........
c0d04dac:	00ffffff 00000000 00008008 00000000     ................
c0d04dbc:	000e2207 0064001a 0000000c 00000000     ."....d.........
c0d04dcc:	00ffffff 00000000 00008008 00000000     ................

c0d04ddc <UX_MENU_END_ENTRY>:
	...

c0d04df8 <_etext>:
	...
