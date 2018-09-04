   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
 107                     ; 11 void Init_Relay_Gpio( GPIO_TypeDef *GPIO, u8 pin )
 107                     ; 12 {
 109                     	switch	.text
 110  0000               _Init_Relay_Gpio:
 112  0000 89            	pushw	x
 113       00000000      OFST:	set	0
 116                     ; 13     CFG->GCR |= 1; //SWIM口用做普通I/O口
 118  0001 72107f60      	bset	32608,#0
 119                     ; 15     GPIO->DDR |= 1<<pin;	
 121  0005 7b05          	ld	a,(OFST+5,sp)
 122  0007 905f          	clrw	y
 123  0009 9097          	ld	yl,a
 124  000b a601          	ld	a,#1
 125  000d 905d          	tnzw	y
 126  000f 2705          	jreq	L6
 127  0011               L01:
 128  0011 48            	sll	a
 129  0012 905a          	decw	y
 130  0014 26fb          	jrne	L01
 131  0016               L6:
 132  0016 ea02          	or	a,(2,x)
 133  0018 e702          	ld	(2,x),a
 134                     ; 16     GPIO->CR1 |= 1<<pin;  /* 上拉 */
 136  001a 7b05          	ld	a,(OFST+5,sp)
 137  001c 905f          	clrw	y
 138  001e 9097          	ld	yl,a
 139  0020 a601          	ld	a,#1
 140  0022 905d          	tnzw	y
 141  0024 2705          	jreq	L21
 142  0026               L41:
 143  0026 48            	sll	a
 144  0027 905a          	decw	y
 145  0029 26fb          	jrne	L41
 146  002b               L21:
 147  002b ea03          	or	a,(3,x)
 148  002d e703          	ld	(3,x),a
 149                     ; 17     GPIO->ODR |= 0<<pin;
 151  002f 7b05          	ld	a,(OFST+5,sp)
 152  0031 905f          	clrw	y
 153  0033 9097          	ld	yl,a
 154  0035 4f            	clr	a
 155  0036 905d          	tnzw	y
 156  0038 2705          	jreq	L61
 157  003a               L02:
 158  003a 48            	sll	a
 159  003b 905a          	decw	y
 160  003d 26fb          	jrne	L02
 161  003f               L61:
 162  003f fa            	or	a,(x)
 163  0040 f7            	ld	(x),a
 164                     ; 18 }
 167  0041 85            	popw	x
 168  0042 81            	ret
 202                     ; 25 void Write_Relay(u8 code)
 202                     ; 26 {
 203                     	switch	.text
 204  0043               _Write_Relay:
 206  0043 88            	push	a
 207       00000000      OFST:	set	0
 210                     ; 27 	((code >> RELAY1) & 0x01) ?
 210                     ; 28 	(RELAY1_PROT->ODR |= (1 << RELAY1_PIN)) : (RELAY1_PROT->ODR &= ~(1 << RELAY1_PIN));
 212  0044 5f            	clrw	x
 213  0045 a501          	bcp	a,#1
 214  0047 270b          	jreq	L42
 215  0049 72105005      	bset	20485,#0
 216  004d c65005        	ld	a,20485
 217  0050 5f            	clrw	x
 218  0051 97            	ld	xl,a
 219  0052 2009          	jra	L62
 220  0054               L42:
 221  0054 72115005      	bres	20485,#0
 222  0058 c65005        	ld	a,20485
 223  005b 5f            	clrw	x
 224  005c 97            	ld	xl,a
 225  005d               L62:
 226                     ; 29 	((code >> RELAY2) & 0x01) ?
 226                     ; 30 	(RELAY2_PROT->ODR |= (1 << RELAY2_PIN)) : (RELAY2_PROT->ODR &= ~(1 << RELAY2_PIN));
 228  005d 7b01          	ld	a,(OFST+1,sp)
 229  005f 44            	srl	a
 230  0060 5f            	clrw	x
 231  0061 a501          	bcp	a,#1
 232  0063 270b          	jreq	L03
 233  0065 72125005      	bset	20485,#1
 234  0069 c65005        	ld	a,20485
 235  006c 5f            	clrw	x
 236  006d 97            	ld	xl,a
 237  006e 2009          	jra	L23
 238  0070               L03:
 239  0070 72135005      	bres	20485,#1
 240  0074 c65005        	ld	a,20485
 241  0077 5f            	clrw	x
 242  0078 97            	ld	xl,a
 243  0079               L23:
 244                     ; 31 	((code >> RELAY3) & 0x01) ?
 244                     ; 32 	(RELAY3_PROT->ODR |= (1 << RELAY3_PIN)) : (RELAY3_PROT->ODR &= ~(1 << RELAY3_PIN));
 246  0079 7b01          	ld	a,(OFST+1,sp)
 247  007b 44            	srl	a
 248  007c 44            	srl	a
 249  007d 5f            	clrw	x
 250  007e a501          	bcp	a,#1
 251  0080 270b          	jreq	L43
 252  0082 72145005      	bset	20485,#2
 253  0086 c65005        	ld	a,20485
 254  0089 5f            	clrw	x
 255  008a 97            	ld	xl,a
 256  008b 2009          	jra	L63
 257  008d               L43:
 258  008d 72155005      	bres	20485,#2
 259  0091 c65005        	ld	a,20485
 260  0094 5f            	clrw	x
 261  0095 97            	ld	xl,a
 262  0096               L63:
 263                     ; 33 	((code >> RELAY4) & 0x01) ?
 263                     ; 34 	(RELAY4_PROT->ODR |= (1 << RELAY4_PIN)) : (RELAY4_PROT->ODR &= ~(1 << RELAY4_PIN));
 265  0096 7b01          	ld	a,(OFST+1,sp)
 266  0098 44            	srl	a
 267  0099 44            	srl	a
 268  009a 44            	srl	a
 269  009b 5f            	clrw	x
 270  009c a501          	bcp	a,#1
 271  009e 270b          	jreq	L04
 272  00a0 72165005      	bset	20485,#3
 273  00a4 c65005        	ld	a,20485
 274  00a7 5f            	clrw	x
 275  00a8 97            	ld	xl,a
 276  00a9 2009          	jra	L24
 277  00ab               L04:
 278  00ab 72175005      	bres	20485,#3
 279  00af c65005        	ld	a,20485
 280  00b2 5f            	clrw	x
 281  00b3 97            	ld	xl,a
 282  00b4               L24:
 283                     ; 35 	((code >> RELAY5) & 0x01) ?
 283                     ; 36 	(RELAY5_PROT->ODR |= (1 << RELAY5_PIN)) : (RELAY5_PROT->ODR &= ~(1 << RELAY5_PIN));
 285  00b4 7b01          	ld	a,(OFST+1,sp)
 286  00b6 4e            	swap	a
 287  00b7 a40f          	and	a,#15
 288  00b9 5f            	clrw	x
 289  00ba a501          	bcp	a,#1
 290  00bc 270b          	jreq	L44
 291  00be 72185005      	bset	20485,#4
 292  00c2 c65005        	ld	a,20485
 293  00c5 5f            	clrw	x
 294  00c6 97            	ld	xl,a
 295  00c7 2009          	jra	L64
 296  00c9               L44:
 297  00c9 72195005      	bres	20485,#4
 298  00cd c65005        	ld	a,20485
 299  00d0 5f            	clrw	x
 300  00d1 97            	ld	xl,a
 301  00d2               L64:
 302                     ; 37 	((code >> RELAY6) & 0x01) ?
 302                     ; 38 	(RELAY6_PROT->ODR |= (1 << RELAY6_PIN)) : (RELAY6_PROT->ODR &= ~(1 << RELAY6_PIN));
 304  00d2 7b01          	ld	a,(OFST+1,sp)
 305  00d4 4e            	swap	a
 306  00d5 44            	srl	a
 307  00d6 a407          	and	a,#7
 308  00d8 5f            	clrw	x
 309  00d9 a501          	bcp	a,#1
 310  00db 270b          	jreq	L05
 311  00dd 721a5005      	bset	20485,#5
 312  00e1 c65005        	ld	a,20485
 313  00e4 5f            	clrw	x
 314  00e5 97            	ld	xl,a
 315  00e6 2009          	jra	L25
 316  00e8               L05:
 317  00e8 721b5005      	bres	20485,#5
 318  00ec c65005        	ld	a,20485
 319  00ef 5f            	clrw	x
 320  00f0 97            	ld	xl,a
 321  00f1               L25:
 322                     ; 39 	((code >> RELAY7) & 0x01) ?
 322                     ; 40 	(RELAY7_PROT->ODR |= (1 << RELAY7_PIN)) : (RELAY7_PROT->ODR &= ~(1 << RELAY7_PIN));
 324  00f1 7b01          	ld	a,(OFST+1,sp)
 325  00f3 4e            	swap	a
 326  00f4 44            	srl	a
 327  00f5 44            	srl	a
 328  00f6 a403          	and	a,#3
 329  00f8 5f            	clrw	x
 330  00f9 a501          	bcp	a,#1
 331  00fb 270b          	jreq	L45
 332  00fd 72185019      	bset	20505,#4
 333  0101 c65019        	ld	a,20505
 334  0104 5f            	clrw	x
 335  0105 97            	ld	xl,a
 336  0106 2009          	jra	L65
 337  0108               L45:
 338  0108 72195019      	bres	20505,#4
 339  010c c65019        	ld	a,20505
 340  010f 5f            	clrw	x
 341  0110 97            	ld	xl,a
 342  0111               L65:
 343                     ; 41 	((code >> RELAY8) & 0x01) ?
 343                     ; 42 	(RELAY8_PROT->ODR |= (1 << RELAY8_PIN)) : (RELAY8_PROT->ODR &= ~(1 << RELAY8_PIN));
 345  0111 7b01          	ld	a,(OFST+1,sp)
 346  0113 49            	rlc	a
 347  0114 4f            	clr	a
 348  0115 49            	rlc	a
 349  0116 5f            	clrw	x
 350  0117 a501          	bcp	a,#1
 351  0119 270b          	jreq	L06
 352  011b 72145000      	bset	20480,#2
 353  011f c65000        	ld	a,20480
 354  0122 5f            	clrw	x
 355  0123 97            	ld	xl,a
 356  0124 2009          	jra	L26
 357  0126               L06:
 358  0126 72155000      	bres	20480,#2
 359  012a c65000        	ld	a,20480
 360  012d 5f            	clrw	x
 361  012e 97            	ld	xl,a
 362  012f               L26:
 363                     ; 43 }
 366  012f 84            	pop	a
 367  0130 81            	ret
 401                     ; 51 u8 Read_Relay( void )
 401                     ; 52 {
 402                     	switch	.text
 403  0131               _Read_Relay:
 405  0131 88            	push	a
 406       00000001      OFST:	set	1
 409                     ; 53 	u8 data=0;
 411  0132 0f01          	clr	(OFST+0,sp)
 412                     ; 54 		data |= (!(RELAY1_PROT->IDR & (1 << RELAY1_PIN)) << RELAY1);
 414  0134 c65006        	ld	a,20486
 415  0137 a501          	bcp	a,#1
 416  0139 2604          	jrne	L66
 417  013b a601          	ld	a,#1
 418  013d 2001          	jra	L07
 419  013f               L66:
 420  013f 4f            	clr	a
 421  0140               L07:
 422  0140 1a01          	or	a,(OFST+0,sp)
 423  0142 6b01          	ld	(OFST+0,sp),a
 424                     ; 55 		data |= (!(RELAY2_PROT->IDR & (1 << RELAY2_PIN)) << RELAY2);
 426  0144 c65006        	ld	a,20486
 427  0147 a502          	bcp	a,#2
 428  0149 2604          	jrne	L27
 429  014b a601          	ld	a,#1
 430  014d 2001          	jra	L47
 431  014f               L27:
 432  014f 4f            	clr	a
 433  0150               L47:
 434  0150 48            	sll	a
 435  0151 1a01          	or	a,(OFST+0,sp)
 436  0153 6b01          	ld	(OFST+0,sp),a
 437                     ; 56 		data |= (!(RELAY3_PROT->IDR & (1 << RELAY3_PIN)) << RELAY3);
 439  0155 c65006        	ld	a,20486
 440  0158 a504          	bcp	a,#4
 441  015a 2604          	jrne	L67
 442  015c a601          	ld	a,#1
 443  015e 2001          	jra	L001
 444  0160               L67:
 445  0160 4f            	clr	a
 446  0161               L001:
 447  0161 48            	sll	a
 448  0162 48            	sll	a
 449  0163 1a01          	or	a,(OFST+0,sp)
 450  0165 6b01          	ld	(OFST+0,sp),a
 451                     ; 57 		data |= (!(RELAY4_PROT->IDR & (1 << RELAY4_PIN)) << RELAY4);
 453  0167 c65006        	ld	a,20486
 454  016a a508          	bcp	a,#8
 455  016c 2604          	jrne	L201
 456  016e a601          	ld	a,#1
 457  0170 2001          	jra	L401
 458  0172               L201:
 459  0172 4f            	clr	a
 460  0173               L401:
 461  0173 48            	sll	a
 462  0174 48            	sll	a
 463  0175 48            	sll	a
 464  0176 1a01          	or	a,(OFST+0,sp)
 465  0178 6b01          	ld	(OFST+0,sp),a
 466                     ; 58 		data |= (!(RELAY5_PROT->IDR & (1 << RELAY5_PIN)) << RELAY5);
 468  017a c65006        	ld	a,20486
 469  017d a510          	bcp	a,#16
 470  017f 2604          	jrne	L601
 471  0181 a601          	ld	a,#1
 472  0183 2001          	jra	L011
 473  0185               L601:
 474  0185 4f            	clr	a
 475  0186               L011:
 476  0186 4e            	swap	a
 477  0187 a4f0          	and	a,#240
 478  0189 1a01          	or	a,(OFST+0,sp)
 479  018b 6b01          	ld	(OFST+0,sp),a
 480                     ; 59 		data |= (!(RELAY6_PROT->IDR & (1 << RELAY6_PIN)) << RELAY6);
 482  018d c65006        	ld	a,20486
 483  0190 a520          	bcp	a,#32
 484  0192 2604          	jrne	L211
 485  0194 a601          	ld	a,#1
 486  0196 2001          	jra	L411
 487  0198               L211:
 488  0198 4f            	clr	a
 489  0199               L411:
 490  0199 4e            	swap	a
 491  019a 48            	sll	a
 492  019b a4e0          	and	a,#224
 493  019d 1a01          	or	a,(OFST+0,sp)
 494  019f 6b01          	ld	(OFST+0,sp),a
 495                     ; 60 		data |= (!(RELAY7_PROT->IDR & (1 << RELAY7_PIN)) << RELAY7);
 497  01a1 c6501a        	ld	a,20506
 498  01a4 a510          	bcp	a,#16
 499  01a6 2604          	jrne	L611
 500  01a8 a601          	ld	a,#1
 501  01aa 2001          	jra	L021
 502  01ac               L611:
 503  01ac 4f            	clr	a
 504  01ad               L021:
 505  01ad 4e            	swap	a
 506  01ae 48            	sll	a
 507  01af 48            	sll	a
 508  01b0 a4c0          	and	a,#192
 509  01b2 1a01          	or	a,(OFST+0,sp)
 510  01b4 6b01          	ld	(OFST+0,sp),a
 511                     ; 61 		data |= (!(RELAY8_PROT->IDR & (1 << RELAY8_PIN)) << RELAY8);
 513  01b6 c65001        	ld	a,20481
 514  01b9 a504          	bcp	a,#4
 515  01bb 2604          	jrne	L221
 516  01bd a601          	ld	a,#1
 517  01bf 2001          	jra	L421
 518  01c1               L221:
 519  01c1 4f            	clr	a
 520  01c2               L421:
 521  01c2 46            	rrc	a
 522  01c3 4f            	clr	a
 523  01c4 46            	rrc	a
 524  01c5 1a01          	or	a,(OFST+0,sp)
 525  01c7 6b01          	ld	(OFST+0,sp),a
 526                     ; 62 	return (data);
 528  01c9 7b01          	ld	a,(OFST+0,sp)
 531  01cb 5b01          	addw	sp,#1
 532  01cd 81            	ret
 556                     ; 70 void Init_Relay( void )
 556                     ; 71 {
 557                     	switch	.text
 558  01ce               _Init_Relay:
 562                     ; 72 	Init_Relay_Gpio( RELAY1_PROT, RELAY1_PIN );
 564  01ce 4b00          	push	#0
 565  01d0 ae5005        	ldw	x,#20485
 566  01d3 cd0000        	call	_Init_Relay_Gpio
 568  01d6 84            	pop	a
 569                     ; 73 	Init_Relay_Gpio( RELAY2_PROT, RELAY2_PIN );
 571  01d7 4b01          	push	#1
 572  01d9 ae5005        	ldw	x,#20485
 573  01dc cd0000        	call	_Init_Relay_Gpio
 575  01df 84            	pop	a
 576                     ; 74 	Init_Relay_Gpio( RELAY3_PROT, RELAY3_PIN );
 578  01e0 4b02          	push	#2
 579  01e2 ae5005        	ldw	x,#20485
 580  01e5 cd0000        	call	_Init_Relay_Gpio
 582  01e8 84            	pop	a
 583                     ; 75 	Init_Relay_Gpio( RELAY4_PROT, RELAY4_PIN );
 585  01e9 4b03          	push	#3
 586  01eb ae5005        	ldw	x,#20485
 587  01ee cd0000        	call	_Init_Relay_Gpio
 589  01f1 84            	pop	a
 590                     ; 76 	Init_Relay_Gpio( RELAY5_PROT, RELAY5_PIN );
 592  01f2 4b04          	push	#4
 593  01f4 ae5005        	ldw	x,#20485
 594  01f7 cd0000        	call	_Init_Relay_Gpio
 596  01fa 84            	pop	a
 597                     ; 77 	Init_Relay_Gpio( RELAY6_PROT, RELAY6_PIN );
 599  01fb 4b05          	push	#5
 600  01fd ae5005        	ldw	x,#20485
 601  0200 cd0000        	call	_Init_Relay_Gpio
 603  0203 84            	pop	a
 604                     ; 78 	Init_Relay_Gpio( RELAY7_PROT, RELAY7_PIN );
 606  0204 4b04          	push	#4
 607  0206 ae5019        	ldw	x,#20505
 608  0209 cd0000        	call	_Init_Relay_Gpio
 610  020c 84            	pop	a
 611                     ; 79 	Init_Relay_Gpio( RELAY8_PROT, RELAY8_PIN );
 613  020d 4b02          	push	#2
 614  020f ae5000        	ldw	x,#20480
 615  0212 cd0000        	call	_Init_Relay_Gpio
 617  0215 84            	pop	a
 618                     ; 80 	Init_Relay_Gpio( LED_PROT, LED_PIN );
 620  0216 4b01          	push	#1
 621  0218 ae500f        	ldw	x,#20495
 622  021b cd0000        	call	_Init_Relay_Gpio
 624  021e 84            	pop	a
 625                     ; 81 }
 628  021f 81            	ret
 641                     	xdef	_Init_Relay_Gpio
 642                     	xdef	_Read_Relay
 643                     	xdef	_Write_Relay
 644                     	xdef	_Init_Relay
 663                     	end
