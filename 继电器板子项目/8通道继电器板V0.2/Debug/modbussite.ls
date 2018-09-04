   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               L3_cnt:
   6  0000 0000          	dc.w	0
  67                     ; 5 bool Delay_0( void )
  67                     ; 6 {
  69                     	switch	.text
  70  0000               _Delay_0:
  74                     ; 10     if( ++cnt >= CNT )
  76  0000 be00          	ldw	x,L3_cnt
  77  0002 1c0001        	addw	x,#1
  78  0005 bf00          	ldw	L3_cnt,x
  79  0007 a34e20        	cpw	x,#20000
  80  000a 2506          	jrult	L14
  81                     ; 12         cnt = 0;
  83  000c 5f            	clrw	x
  84  000d bf00          	ldw	L3_cnt,x
  85                     ; 13         return true;
  87  000f a601          	ld	a,#1
  90  0011 81            	ret
  91  0012               L14:
  92                     ; 15     return false;
  94  0012 4f            	clr	a
  97  0013 81            	ret
 195                     ; 24 void Init_AddrGpio( GPIO_TypeDef *GPIO, u8 pin )
 195                     ; 25 {
 196                     	switch	.text
 197  0014               _Init_AddrGpio:
 199  0014 89            	pushw	x
 200       00000000      OFST:	set	0
 203                     ; 26 	GPIO->DDR &= ~( 1<<pin );  /* ÊäÈë */
 205  0015 7b05          	ld	a,(OFST+5,sp)
 206  0017 905f          	clrw	y
 207  0019 9097          	ld	yl,a
 208  001b a601          	ld	a,#1
 209  001d 905d          	tnzw	y
 210  001f 2705          	jreq	L01
 211  0021               L21:
 212  0021 48            	sll	a
 213  0022 905a          	decw	y
 214  0024 26fb          	jrne	L21
 215  0026               L01:
 216  0026 43            	cpl	a
 217  0027 e402          	and	a,(2,x)
 218  0029 e702          	ld	(2,x),a
 219                     ; 27 	GPIO->CR1 |= 1<<pin;  		 /* ÉÏÀ­ */
 221  002b 7b05          	ld	a,(OFST+5,sp)
 222  002d 905f          	clrw	y
 223  002f 9097          	ld	yl,a
 224  0031 a601          	ld	a,#1
 225  0033 905d          	tnzw	y
 226  0035 2705          	jreq	L41
 227  0037               L61:
 228  0037 48            	sll	a
 229  0038 905a          	decw	y
 230  003a 26fb          	jrne	L61
 231  003c               L41:
 232  003c ea03          	or	a,(3,x)
 233  003e e703          	ld	(3,x),a
 234                     ; 28 }
 237  0040 85            	popw	x
 238  0041 81            	ret
 262                     ; 37 void Init_ModbusAddr( void )
 262                     ; 38 {
 263                     	switch	.text
 264  0042               _Init_ModbusAddr:
 268                     ; 39 	Init_AddrGpio( ADDR1_PROT, ADDR1_PIN );
 270  0042 4b00          	push	#0
 271  0044 ae500f        	ldw	x,#20495
 272  0047 adcb          	call	_Init_AddrGpio
 274  0049 84            	pop	a
 275                     ; 40 	Init_AddrGpio( ADDR2_PROT, ADDR2_PIN );
 277  004a 4b01          	push	#1
 278  004c ae5000        	ldw	x,#20480
 279  004f adc3          	call	_Init_AddrGpio
 281  0051 84            	pop	a
 282                     ; 41 	Init_AddrGpio( ADDR3_PROT, ADDR3_PIN );
 284  0052 4b02          	push	#2
 285  0054 ae500f        	ldw	x,#20495
 286  0057 adbb          	call	_Init_AddrGpio
 288  0059 84            	pop	a
 289                     ; 42 	Init_AddrGpio( ADDR4_PROT, ADDR4_PIN );
 291  005a 4b03          	push	#3
 292  005c ae500f        	ldw	x,#20495
 293  005f adb3          	call	_Init_AddrGpio
 295  0061 84            	pop	a
 296                     ; 43 	Init_AddrGpio( ADDR5_PROT, ADDR5_PIN );
 298  0062 4b04          	push	#4
 299  0064 ae500f        	ldw	x,#20495
 300  0067 adab          	call	_Init_AddrGpio
 302  0069 84            	pop	a
 303                     ; 44 	Init_AddrGpio( ADDR6_PROT, ADDR6_PIN );
 305  006a 4b07          	push	#7
 306  006c ae500f        	ldw	x,#20495
 307  006f ada3          	call	_Init_AddrGpio
 309  0071 84            	pop	a
 310                     ; 45 }
 313  0072 81            	ret
 347                     ; 53 u8 Read_Addr( void )
 347                     ; 54 {
 348                     	switch	.text
 349  0073               _Read_Addr:
 351  0073 88            	push	a
 352       00000001      OFST:	set	1
 355                     ; 55 	u8 addr=0;
 357  0074 0f01          	clr	(OFST+0,sp)
 358                     ; 56 	addr |= ((!(ADDR6_PROT->IDR & (1 << ADDR6_PIN))) << ADDR1);
 360  0076 c65010        	ld	a,20496
 361  0079 a580          	bcp	a,#128
 362  007b 2604          	jrne	L42
 363  007d a601          	ld	a,#1
 364  007f 2001          	jra	L62
 365  0081               L42:
 366  0081 4f            	clr	a
 367  0082               L62:
 368  0082 1a01          	or	a,(OFST+0,sp)
 369  0084 6b01          	ld	(OFST+0,sp),a
 370                     ; 57 	addr |= ((!(ADDR5_PROT->IDR & (1 << ADDR5_PIN))) << ADDR2);
 372  0086 c65010        	ld	a,20496
 373  0089 a510          	bcp	a,#16
 374  008b 2604          	jrne	L03
 375  008d a601          	ld	a,#1
 376  008f 2001          	jra	L23
 377  0091               L03:
 378  0091 4f            	clr	a
 379  0092               L23:
 380  0092 48            	sll	a
 381  0093 1a01          	or	a,(OFST+0,sp)
 382  0095 6b01          	ld	(OFST+0,sp),a
 383                     ; 58 	addr |= ((!(ADDR4_PROT->IDR & (1 << ADDR4_PIN))) << ADDR3);
 385  0097 c65010        	ld	a,20496
 386  009a a508          	bcp	a,#8
 387  009c 2604          	jrne	L43
 388  009e a601          	ld	a,#1
 389  00a0 2001          	jra	L63
 390  00a2               L43:
 391  00a2 4f            	clr	a
 392  00a3               L63:
 393  00a3 48            	sll	a
 394  00a4 48            	sll	a
 395  00a5 1a01          	or	a,(OFST+0,sp)
 396  00a7 6b01          	ld	(OFST+0,sp),a
 397                     ; 59 	addr |= ((!(ADDR3_PROT->IDR & (1 << ADDR3_PIN))) << ADDR4);
 399  00a9 c65010        	ld	a,20496
 400  00ac a504          	bcp	a,#4
 401  00ae 2604          	jrne	L04
 402  00b0 a601          	ld	a,#1
 403  00b2 2001          	jra	L24
 404  00b4               L04:
 405  00b4 4f            	clr	a
 406  00b5               L24:
 407  00b5 48            	sll	a
 408  00b6 48            	sll	a
 409  00b7 48            	sll	a
 410  00b8 1a01          	or	a,(OFST+0,sp)
 411  00ba 6b01          	ld	(OFST+0,sp),a
 412                     ; 60 	addr |= ((!(ADDR2_PROT->IDR & (1 << ADDR2_PIN))) << ADDR5);
 414  00bc c65001        	ld	a,20481
 415  00bf a502          	bcp	a,#2
 416  00c1 2604          	jrne	L44
 417  00c3 a601          	ld	a,#1
 418  00c5 2001          	jra	L64
 419  00c7               L44:
 420  00c7 4f            	clr	a
 421  00c8               L64:
 422  00c8 4e            	swap	a
 423  00c9 a4f0          	and	a,#240
 424  00cb 1a01          	or	a,(OFST+0,sp)
 425  00cd 6b01          	ld	(OFST+0,sp),a
 426                     ; 61 	addr |= ((!(ADDR1_PROT->IDR & (1 << ADDR1_PIN))) << ADDR6);
 428  00cf c65010        	ld	a,20496
 429  00d2 a501          	bcp	a,#1
 430  00d4 2604          	jrne	L05
 431  00d6 a601          	ld	a,#1
 432  00d8 2001          	jra	L25
 433  00da               L05:
 434  00da 4f            	clr	a
 435  00db               L25:
 436  00db 4e            	swap	a
 437  00dc 48            	sll	a
 438  00dd a4e0          	and	a,#224
 439  00df 1a01          	or	a,(OFST+0,sp)
 440  00e1 6b01          	ld	(OFST+0,sp),a
 441                     ; 62 	return (addr);
 443  00e3 7b01          	ld	a,(OFST+0,sp)
 446  00e5 5b01          	addw	sp,#1
 447  00e7 81            	ret
 483                     ; 71 u8 Read_modbussite( void )
 483                     ; 72 {
 484                     	switch	.text
 485  00e8               _Read_modbussite:
 487  00e8 88            	push	a
 488       00000001      OFST:	set	1
 491                     ; 73 	u8 data = 0x00;
 493  00e9 0f01          	clr	(OFST+0,sp)
 494                     ; 74 	if(Read_Addr() != 0x00)
 496  00eb ad86          	call	_Read_Addr
 498  00ed 4d            	tnz	a
 499  00ee 270b          	jreq	L361
 500                     ; 76 		if(Delay_0())
 502  00f0 cd0000        	call	_Delay_0
 504  00f3 4d            	tnz	a
 505  00f4 2705          	jreq	L361
 506                     ; 78 			data = Read_Addr();
 508  00f6 cd0073        	call	_Read_Addr
 510  00f9 6b01          	ld	(OFST+0,sp),a
 511  00fb               L361:
 512                     ; 81 	return (data);
 514  00fb 7b01          	ld	a,(OFST+0,sp)
 517  00fd 5b01          	addw	sp,#1
 518  00ff 81            	ret
 531                     	xdef	_Init_AddrGpio
 532                     	xdef	_Delay_0
 533                     	xdef	_Read_modbussite
 534                     	xdef	_Read_Addr
 535                     	xdef	_Init_ModbusAddr
 554                     	end
