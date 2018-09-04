   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               L3_cnt:
   6  0000 0000          	dc.w	0
  67                     ; 6 bool Delay( void )
  67                     ; 7 {
  69                     	switch	.text
  70  0000               _Delay:
  74                     ; 11     if( ++cnt >= CNT )
  76  0000 be00          	ldw	x,L3_cnt
  77  0002 1c0001        	addw	x,#1
  78  0005 bf00          	ldw	L3_cnt,x
  79  0007 a34e20        	cpw	x,#20000
  80  000a 2506          	jrult	L14
  81                     ; 13         cnt = 0;
  83  000c 5f            	clrw	x
  84  000d bf00          	ldw	L3_cnt,x
  85                     ; 14         return true;
  87  000f a601          	ld	a,#1
  90  0011 81            	ret
  91  0012               L14:
  92                     ; 16     return false;
  94  0012 4f            	clr	a
  97  0013 81            	ret
 196                     ; 25 void Init_OptocouplerGpio( GPIO_TypeDef *GPIO, u8 pin )
 196                     ; 26 {
 197                     	switch	.text
 198  0014               _Init_OptocouplerGpio:
 200  0014 89            	pushw	x
 201       00000000      OFST:	set	0
 204                     ; 27 	GPIO->DDR &= ~( 1<<pin );  /* ÊäÈë */
 206  0015 7b05          	ld	a,(OFST+5,sp)
 207  0017 905f          	clrw	y
 208  0019 9097          	ld	yl,a
 209  001b a601          	ld	a,#1
 210  001d 905d          	tnzw	y
 211  001f 2705          	jreq	L01
 212  0021               L21:
 213  0021 48            	sll	a
 214  0022 905a          	decw	y
 215  0024 26fb          	jrne	L21
 216  0026               L01:
 217  0026 43            	cpl	a
 218  0027 e402          	and	a,(2,x)
 219  0029 e702          	ld	(2,x),a
 220                     ; 28 	GPIO->CR1 |= 1<<pin;  		 /* ÉÏÀ­ */
 222  002b 7b05          	ld	a,(OFST+5,sp)
 223  002d 905f          	clrw	y
 224  002f 9097          	ld	yl,a
 225  0031 a601          	ld	a,#1
 226  0033 905d          	tnzw	y
 227  0035 2705          	jreq	L41
 228  0037               L61:
 229  0037 48            	sll	a
 230  0038 905a          	decw	y
 231  003a 26fb          	jrne	L61
 232  003c               L41:
 233  003c ea03          	or	a,(3,x)
 234  003e e703          	ld	(3,x),a
 235                     ; 29 }
 238  0040 85            	popw	x
 239  0041 81            	ret
 263                     ; 37 void Init_Optocoupler( void )
 263                     ; 38 {
 264                     	switch	.text
 265  0042               _Init_Optocoupler:
 269                     ; 39 	Init_OptocouplerGpio( OPTOCOUPLER1_PROT, OPTOCOUPLER1_PIN );
 271  0042 4b05          	push	#5
 272  0044 ae5014        	ldw	x,#20500
 273  0047 adcb          	call	_Init_OptocouplerGpio
 275  0049 84            	pop	a
 276                     ; 40 	Init_OptocouplerGpio( OPTOCOUPLER2_PROT, OPTOCOUPLER2_PIN );
 278  004a 4b01          	push	#1
 279  004c ae500a        	ldw	x,#20490
 280  004f adc3          	call	_Init_OptocouplerGpio
 282  0051 84            	pop	a
 283                     ; 41 	Init_OptocouplerGpio( OPTOCOUPLER3_PROT, OPTOCOUPLER3_PIN );
 285  0052 4b02          	push	#2
 286  0054 ae500a        	ldw	x,#20490
 287  0057 adbb          	call	_Init_OptocouplerGpio
 289  0059 84            	pop	a
 290                     ; 42 	Init_OptocouplerGpio( OPTOCOUPLER4_PROT, OPTOCOUPLER4_PIN );
 292  005a 4b03          	push	#3
 293  005c ae500a        	ldw	x,#20490
 294  005f adb3          	call	_Init_OptocouplerGpio
 296  0061 84            	pop	a
 297                     ; 43 	Init_OptocouplerGpio( OPTOCOUPLER5_PROT, OPTOCOUPLER5_PIN );
 299  0062 4b04          	push	#4
 300  0064 ae500a        	ldw	x,#20490
 301  0067 adab          	call	_Init_OptocouplerGpio
 303  0069 84            	pop	a
 304                     ; 44 	Init_OptocouplerGpio( OPTOCOUPLER6_PROT, OPTOCOUPLER6_PIN );
 306  006a 4b05          	push	#5
 307  006c ae500a        	ldw	x,#20490
 308  006f ada3          	call	_Init_OptocouplerGpio
 310  0071 84            	pop	a
 311                     ; 45 	Init_OptocouplerGpio( OPTOCOUPLER7_PROT, OPTOCOUPLER7_PIN );
 313  0072 4b06          	push	#6
 314  0074 ae500a        	ldw	x,#20490
 315  0077 ad9b          	call	_Init_OptocouplerGpio
 317  0079 84            	pop	a
 318                     ; 46 	Init_OptocouplerGpio( OPTOCOUPLER8_PROT, OPTOCOUPLER8_PIN );
 320  007a 4b07          	push	#7
 321  007c ae500a        	ldw	x,#20490
 322  007f ad93          	call	_Init_OptocouplerGpio
 324  0081 84            	pop	a
 325                     ; 47 }
 328  0082 81            	ret
 362                     ; 55 u8 Read_Optocoupler( void )
 362                     ; 56 {
 363                     	switch	.text
 364  0083               _Read_Optocoupler:
 366  0083 88            	push	a
 367       00000001      OFST:	set	1
 370                     ; 57 	u8 data=0;
 372  0084 0f01          	clr	(OFST+0,sp)
 373                     ; 58 		data |= ((!(OPTOCOUPLER1_PROT->IDR & (1 << OPTOCOUPLER1_PIN))) << OPTOCOUPLER1);
 375  0086 c65015        	ld	a,20501
 376  0089 a520          	bcp	a,#32
 377  008b 2604          	jrne	L42
 378  008d a601          	ld	a,#1
 379  008f 2001          	jra	L62
 380  0091               L42:
 381  0091 4f            	clr	a
 382  0092               L62:
 383  0092 1a01          	or	a,(OFST+0,sp)
 384  0094 6b01          	ld	(OFST+0,sp),a
 385                     ; 59 		data |= ((!(OPTOCOUPLER2_PROT->IDR & (1 << OPTOCOUPLER2_PIN))) << OPTOCOUPLER2);
 387  0096 c6500b        	ld	a,20491
 388  0099 a502          	bcp	a,#2
 389  009b 2604          	jrne	L03
 390  009d a601          	ld	a,#1
 391  009f 2001          	jra	L23
 392  00a1               L03:
 393  00a1 4f            	clr	a
 394  00a2               L23:
 395  00a2 48            	sll	a
 396  00a3 1a01          	or	a,(OFST+0,sp)
 397  00a5 6b01          	ld	(OFST+0,sp),a
 398                     ; 60 		data |= ((!(OPTOCOUPLER3_PROT->IDR & (1 << OPTOCOUPLER3_PIN))) << OPTOCOUPLER3);
 400  00a7 c6500b        	ld	a,20491
 401  00aa a504          	bcp	a,#4
 402  00ac 2604          	jrne	L43
 403  00ae a601          	ld	a,#1
 404  00b0 2001          	jra	L63
 405  00b2               L43:
 406  00b2 4f            	clr	a
 407  00b3               L63:
 408  00b3 48            	sll	a
 409  00b4 48            	sll	a
 410  00b5 1a01          	or	a,(OFST+0,sp)
 411  00b7 6b01          	ld	(OFST+0,sp),a
 412                     ; 61 		data |= ((!(OPTOCOUPLER4_PROT->IDR & (1 << OPTOCOUPLER4_PIN))) << OPTOCOUPLER4);
 414  00b9 c6500b        	ld	a,20491
 415  00bc a508          	bcp	a,#8
 416  00be 2604          	jrne	L04
 417  00c0 a601          	ld	a,#1
 418  00c2 2001          	jra	L24
 419  00c4               L04:
 420  00c4 4f            	clr	a
 421  00c5               L24:
 422  00c5 48            	sll	a
 423  00c6 48            	sll	a
 424  00c7 48            	sll	a
 425  00c8 1a01          	or	a,(OFST+0,sp)
 426  00ca 6b01          	ld	(OFST+0,sp),a
 427                     ; 62 		data |= ((!(OPTOCOUPLER5_PROT->IDR & (1 << OPTOCOUPLER5_PIN))) << OPTOCOUPLER5);
 429  00cc c6500b        	ld	a,20491
 430  00cf a510          	bcp	a,#16
 431  00d1 2604          	jrne	L44
 432  00d3 a601          	ld	a,#1
 433  00d5 2001          	jra	L64
 434  00d7               L44:
 435  00d7 4f            	clr	a
 436  00d8               L64:
 437  00d8 4e            	swap	a
 438  00d9 a4f0          	and	a,#240
 439  00db 1a01          	or	a,(OFST+0,sp)
 440  00dd 6b01          	ld	(OFST+0,sp),a
 441                     ; 63 		data |= ((!(OPTOCOUPLER6_PROT->IDR & (1 << OPTOCOUPLER6_PIN))) << OPTOCOUPLER6);
 443  00df c6500b        	ld	a,20491
 444  00e2 a520          	bcp	a,#32
 445  00e4 2604          	jrne	L05
 446  00e6 a601          	ld	a,#1
 447  00e8 2001          	jra	L25
 448  00ea               L05:
 449  00ea 4f            	clr	a
 450  00eb               L25:
 451  00eb 4e            	swap	a
 452  00ec 48            	sll	a
 453  00ed a4e0          	and	a,#224
 454  00ef 1a01          	or	a,(OFST+0,sp)
 455  00f1 6b01          	ld	(OFST+0,sp),a
 456                     ; 64 		data |= ((!(OPTOCOUPLER7_PROT->IDR & (1 << OPTOCOUPLER7_PIN))) << OPTOCOUPLER7);
 458  00f3 c6500b        	ld	a,20491
 459  00f6 a540          	bcp	a,#64
 460  00f8 2604          	jrne	L45
 461  00fa a601          	ld	a,#1
 462  00fc 2001          	jra	L65
 463  00fe               L45:
 464  00fe 4f            	clr	a
 465  00ff               L65:
 466  00ff 4e            	swap	a
 467  0100 48            	sll	a
 468  0101 48            	sll	a
 469  0102 a4c0          	and	a,#192
 470  0104 1a01          	or	a,(OFST+0,sp)
 471  0106 6b01          	ld	(OFST+0,sp),a
 472                     ; 65 		data |= ((!(OPTOCOUPLER8_PROT->IDR & (1 << OPTOCOUPLER8_PIN))) << OPTOCOUPLER8);
 474  0108 c6500b        	ld	a,20491
 475  010b a580          	bcp	a,#128
 476  010d 2604          	jrne	L06
 477  010f a601          	ld	a,#1
 478  0111 2001          	jra	L26
 479  0113               L06:
 480  0113 4f            	clr	a
 481  0114               L26:
 482  0114 46            	rrc	a
 483  0115 4f            	clr	a
 484  0116 46            	rrc	a
 485  0117 1a01          	or	a,(OFST+0,sp)
 486  0119 6b01          	ld	(OFST+0,sp),a
 487                     ; 66 	return (~data);
 489  011b 7b01          	ld	a,(OFST+0,sp)
 490  011d 43            	cpl	a
 493  011e 5b01          	addw	sp,#1
 494  0120 81            	ret
 531                     ; 74 u8 Read_Optocouplerdeliy( void )
 531                     ; 75 {
 532                     	switch	.text
 533  0121               _Read_Optocouplerdeliy:
 535  0121 88            	push	a
 536       00000001      OFST:	set	1
 539                     ; 76 	u8 data = 0x00;
 541  0122 0f01          	clr	(OFST+0,sp)
 542                     ; 77 	if(Read_Optocoupler() != 0x00)
 544  0124 cd0083        	call	_Read_Optocoupler
 546  0127 4d            	tnz	a
 547  0128 270b          	jreq	L361
 548                     ; 79 		if(Delay())
 550  012a cd0000        	call	_Delay
 552  012d 4d            	tnz	a
 553  012e 2705          	jreq	L361
 554                     ; 81 			data = Read_Optocoupler();
 556  0130 cd0083        	call	_Read_Optocoupler
 558  0133 6b01          	ld	(OFST+0,sp),a
 559  0135               L361:
 560                     ; 84 	return (data);
 562  0135 7b01          	ld	a,(OFST+0,sp)
 565  0137 5b01          	addw	sp,#1
 566  0139 81            	ret
 579                     	xdef	_Read_Optocouplerdeliy
 580                     	xdef	_Init_OptocouplerGpio
 581                     	xdef	_Delay
 582                     	xdef	_Read_Optocoupler
 583                     	xdef	_Init_Optocoupler
 602                     	end
