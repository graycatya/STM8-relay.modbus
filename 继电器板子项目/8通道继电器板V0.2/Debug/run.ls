   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               L3_cnt:
   6  0000 0000          	dc.w	0
  67                     ; 16 bool Delays( void )
  67                     ; 17 {
  69                     	switch	.text
  70  0000               _Delays:
  74                     ; 21     if( ++cnt >= CNT )
  76  0000 be00          	ldw	x,L3_cnt
  77  0002 1c0001        	addw	x,#1
  78  0005 bf00          	ldw	L3_cnt,x
  79  0007 a34e20        	cpw	x,#20000
  80  000a 2506          	jrult	L14
  81                     ; 23         cnt = 0;
  83  000c 5f            	clrw	x
  84  000d bf00          	ldw	L3_cnt,x
  85                     ; 24         return true;
  87  000f a601          	ld	a,#1
  90  0011 81            	ret
  91  0012               L14:
  92                     ; 26     return false;
  94  0012 4f            	clr	a
  97  0013 81            	ret
 125                     ; 51 void Init( void )
 125                     ; 52 {
 126                     	switch	.text
 127  0014               _Init:
 131                     ; 53 	_asm("sim");  /* 关闭中断 */
 134  0014 9b            sim
 136                     ; 55   	CLK->CKDIVR = 0;
 138  0015 725f50c6      	clr	20678
 139                     ; 56 		Init_Usart( 16000000, 9600 );
 141  0019 ae2580        	ldw	x,#9600
 142  001c 89            	pushw	x
 143  001d ae2400        	ldw	x,#9216
 144  0020 89            	pushw	x
 145  0021 ae00f4        	ldw	x,#244
 146  0024 89            	pushw	x
 147  0025 cd0000        	call	_Init_Usart
 149  0028 5b06          	addw	sp,#6
 150                     ; 57     Init_ModbusAddr();
 152  002a cd0000        	call	_Init_ModbusAddr
 154                     ; 58 		Init_Optocoupler();
 156  002d cd0000        	call	_Init_Optocoupler
 158                     ; 59 		Init_Relay();
 160  0030 cd0000        	call	_Init_Relay
 162                     ; 60     init_Register();
 164  0033 cd05af        	call	_init_Register
 166                     ; 61 	_asm("rim");  /* 开启中断 */
 169  0036 9a            rim
 171                     ; 62 }
 174  0037 81            	ret
 260                     ; 70 void WrAsingleCoil( u8 *data , u8 len )
 260                     ; 71 {
 261                     	switch	.text
 262  0038               _WrAsingleCoil:
 264  0038 89            	pushw	x
 265  0039 520d          	subw	sp,#13
 266       0000000d      OFST:	set	13
 269                     ; 73 		addr_qt = ((u16)data[2]<<8) | data[3];
 271  003b e602          	ld	a,(2,x)
 272  003d 5f            	clrw	x
 273  003e 97            	ld	xl,a
 274  003f 4f            	clr	a
 275  0040 02            	rlwa	x,a
 276  0041 01            	rrwa	x,a
 277  0042 160e          	ldw	y,(OFST+1,sp)
 278  0044 90ea03        	or	a,(3,y)
 279  0047 02            	rlwa	x,a
 280  0048 1f0a          	ldw	(OFST-3,sp),x
 281  004a 01            	rrwa	x,a
 282                     ; 74 		input_value = (((u16)data[4])<<8) | data[5];
 284  004b 1e0e          	ldw	x,(OFST+1,sp)
 285  004d e604          	ld	a,(4,x)
 286  004f 5f            	clrw	x
 287  0050 97            	ld	xl,a
 288  0051 4f            	clr	a
 289  0052 02            	rlwa	x,a
 290  0053 01            	rrwa	x,a
 291  0054 160e          	ldw	y,(OFST+1,sp)
 292  0056 90ea05        	or	a,(5,y)
 293  0059 02            	rlwa	x,a
 294  005a 1f0c          	ldw	(OFST-1,sp),x
 295  005c 01            	rrwa	x,a
 296                     ; 75 		if( addr_qt < RelayAddr & (input_value == AsingON | input_value == AsingOFF) )
 298  005d 1e0c          	ldw	x,(OFST-1,sp)
 299  005f 2605          	jrne	L21
 300  0061 ae0001        	ldw	x,#1
 301  0064 2001          	jra	L41
 302  0066               L21:
 303  0066 5f            	clrw	x
 304  0067               L41:
 305  0067 1f03          	ldw	(OFST-10,sp),x
 306  0069 1e0c          	ldw	x,(OFST-1,sp)
 307  006b a3ff00        	cpw	x,#65280
 308  006e 2605          	jrne	L61
 309  0070 ae0001        	ldw	x,#1
 310  0073 2001          	jra	L02
 311  0075               L61:
 312  0075 5f            	clrw	x
 313  0076               L02:
 314  0076 01            	rrwa	x,a
 315  0077 1a04          	or	a,(OFST-9,sp)
 316  0079 01            	rrwa	x,a
 317  007a 1a03          	or	a,(OFST-10,sp)
 318  007c 01            	rrwa	x,a
 319  007d 1f01          	ldw	(OFST-12,sp),x
 320  007f 1e0a          	ldw	x,(OFST-3,sp)
 321  0081 a30008        	cpw	x,#8
 322  0084 2405          	jruge	L22
 323  0086 ae0001        	ldw	x,#1
 324  0089 2001          	jra	L42
 325  008b               L22:
 326  008b 5f            	clrw	x
 327  008c               L42:
 328  008c 01            	rrwa	x,a
 329  008d 1402          	and	a,(OFST-11,sp)
 330  008f 01            	rrwa	x,a
 331  0090 1401          	and	a,(OFST-12,sp)
 332  0092 01            	rrwa	x,a
 333  0093 a30000        	cpw	x,#0
 334  0096 2733          	jreq	L511
 335                     ; 77 			if(input_value == AsingON) //正确控制
 337  0098 1e0c          	ldw	x,(OFST-1,sp)
 338  009a a3ff00        	cpw	x,#65280
 339  009d 2611          	jrne	L711
 340                     ; 79 				Write_Relay( AsingleCoil_map( addr_qt ) | ~Read_Relay());
 342  009f cd0000        	call	_Read_Relay
 344  00a2 43            	cpl	a
 345  00a3 6b04          	ld	(OFST-9,sp),a
 346  00a5 1e0a          	ldw	x,(OFST-3,sp)
 347  00a7 ad5d          	call	_AsingleCoil_map
 349  00a9 1a04          	or	a,(OFST-9,sp)
 350  00ab cd0000        	call	_Write_Relay
 353  00ae 2010          	jra	L121
 354  00b0               L711:
 355                     ; 83 				Write_Relay( ~AsingleCoil_map( addr_qt ) & ~Read_Relay() );
 357  00b0 cd0000        	call	_Read_Relay
 359  00b3 43            	cpl	a
 360  00b4 6b04          	ld	(OFST-9,sp),a
 361  00b6 1e0a          	ldw	x,(OFST-3,sp)
 362  00b8 ad4c          	call	_AsingleCoil_map
 364  00ba 43            	cpl	a
 365  00bb 1404          	and	a,(OFST-9,sp)
 366  00bd cd0000        	call	_Write_Relay
 368  00c0               L121:
 369                     ; 85 			Usart_Send_Bytes( data, len );
 371  00c0 7b12          	ld	a,(OFST+5,sp)
 372  00c2 88            	push	a
 373  00c3 1e0f          	ldw	x,(OFST+2,sp)
 374  00c5 cd0000        	call	_Usart_Send_Bytes
 376  00c8 84            	pop	a
 378  00c9 2038          	jra	L321
 379  00cb               L511:
 380                     ; 91 			Err_addr[0] = data[0];
 382  00cb 1e0e          	ldw	x,(OFST+1,sp)
 383  00cd f6            	ld	a,(x)
 384  00ce 6b05          	ld	(OFST-8,sp),a
 385                     ; 92 			Err_addr[1] = Slip_WriteAsingleCoil;
 387  00d0 a685          	ld	a,#133
 388  00d2 6b06          	ld	(OFST-7,sp),a
 389                     ; 93 			if( addr_qt >= RelayAddr )
 391  00d4 1e0a          	ldw	x,(OFST-3,sp)
 392  00d6 a30008        	cpw	x,#8
 393  00d9 2506          	jrult	L521
 394                     ; 95 					Err_addr[2] = StartAddress_Error;
 396  00db a602          	ld	a,#2
 397  00dd 6b07          	ld	(OFST-6,sp),a
 399  00df 2004          	jra	L721
 400  00e1               L521:
 401                     ; 99 					Err_addr[2] = AddrOutput_Error;
 403  00e1 a603          	ld	a,#3
 404  00e3 6b07          	ld	(OFST-6,sp),a
 405  00e5               L721:
 406                     ; 101 			Err_crc = crc16_modbus( Err_addr , 3);
 408  00e5 4b03          	push	#3
 409  00e7 96            	ldw	x,sp
 410  00e8 1c0006        	addw	x,#OFST-7
 411  00eb cd0000        	call	_crc16_modbus
 413  00ee 84            	pop	a
 414  00ef 1f0c          	ldw	(OFST-1,sp),x
 415                     ; 102 			Err_addr[3] = (u8)(Err_crc>>8);
 417  00f1 7b0c          	ld	a,(OFST-1,sp)
 418  00f3 6b08          	ld	(OFST-5,sp),a
 419                     ; 103 			Err_addr[4] = (u8)Err_crc;
 421  00f5 7b0d          	ld	a,(OFST+0,sp)
 422  00f7 6b09          	ld	(OFST-4,sp),a
 423                     ; 104 			Usart_Send_Bytes( Err_addr , 5 );
 425  00f9 4b05          	push	#5
 426  00fb 96            	ldw	x,sp
 427  00fc 1c0006        	addw	x,#OFST-7
 428  00ff cd0000        	call	_Usart_Send_Bytes
 430  0102 84            	pop	a
 431  0103               L321:
 432                     ; 106 }
 435  0103 5b0f          	addw	sp,#15
 436  0105 81            	ret
 470                     ; 108 u8 AsingleCoil_map( u16 addr)
 470                     ; 109 	{
 471                     	switch	.text
 472  0106               _AsingleCoil_map:
 476                     ; 110 		switch(addr)
 479                     ; 119 				case(0x0007):{ return (0x80); }
 480  0106 5d            	tnzw	x
 481  0107 2717          	jreq	L131
 482  0109 5a            	decw	x
 483  010a 2717          	jreq	L331
 484  010c 5a            	decw	x
 485  010d 2717          	jreq	L531
 486  010f 5a            	decw	x
 487  0110 2717          	jreq	L731
 488  0112 5a            	decw	x
 489  0113 2717          	jreq	L141
 490  0115 5a            	decw	x
 491  0116 2717          	jreq	L341
 492  0118 5a            	decw	x
 493  0119 2717          	jreq	L541
 494  011b 5a            	decw	x
 495  011c 2717          	jreq	L741
 496  011e 2018          	jra	L171
 497  0120               L131:
 498                     ; 112 				case(0x0000):{ return (0x01); }
 500  0120 a601          	ld	a,#1
 503  0122 81            	ret
 504  0123               L331:
 505                     ; 113 				case(0x0001):{ return (0x02); }
 507  0123 a602          	ld	a,#2
 510  0125 81            	ret
 511  0126               L531:
 512                     ; 114 				case(0x0002):{ return (0x04); }
 514  0126 a604          	ld	a,#4
 517  0128 81            	ret
 518  0129               L731:
 519                     ; 115 				case(0x0003):{ return (0x08); }
 521  0129 a608          	ld	a,#8
 524  012b 81            	ret
 525  012c               L141:
 526                     ; 116 				case(0x0004):{ return (0x10); }
 528  012c a610          	ld	a,#16
 531  012e 81            	ret
 532  012f               L341:
 533                     ; 117 				case(0x0005):{ return (0x20); }
 535  012f a620          	ld	a,#32
 538  0131 81            	ret
 539  0132               L541:
 540                     ; 118 				case(0x0006):{ return (0x40); }
 542  0132 a640          	ld	a,#64
 545  0134 81            	ret
 546  0135               L741:
 547                     ; 119 				case(0x0007):{ return (0x80); }
 549  0135 a680          	ld	a,#128
 552  0137 81            	ret
 553  0138               L171:
 554                     ; 121 			return 0;
 556  0138 4f            	clr	a
 559  0139 81            	ret
 671                     ; 134 void WriteMultipleCoil( u8 *data , u8 len )
 671                     ; 135 	{
 672                     	switch	.text
 673  013a               _WriteMultipleCoil:
 675  013a 89            	pushw	x
 676  013b 5214          	subw	sp,#20
 677       00000014      OFST:	set	20
 680                     ; 136 		u16 start_addr=0, input_addr=0; //地址数量
 682  013d 1e10          	ldw	x,(OFST-4,sp)
 685  013f 1e13          	ldw	x,(OFST-1,sp)
 686                     ; 138 		start_addr = ((u16)data[2]<<8) | ((u16)data[3]);
 688  0141 1e15          	ldw	x,(OFST+1,sp)
 689  0143 e603          	ld	a,(3,x)
 690  0145 5f            	clrw	x
 691  0146 97            	ld	xl,a
 692  0147 1f03          	ldw	(OFST-17,sp),x
 693  0149 1e15          	ldw	x,(OFST+1,sp)
 694  014b e602          	ld	a,(2,x)
 695  014d 5f            	clrw	x
 696  014e 97            	ld	xl,a
 697  014f 4f            	clr	a
 698  0150 02            	rlwa	x,a
 699  0151 01            	rrwa	x,a
 700  0152 1a04          	or	a,(OFST-16,sp)
 701  0154 01            	rrwa	x,a
 702  0155 1a03          	or	a,(OFST-17,sp)
 703  0157 01            	rrwa	x,a
 704  0158 1f10          	ldw	(OFST-4,sp),x
 705                     ; 139 		input_addr = ((u16)data[4]<<8) | ((u16)data[5]);
 707  015a 1e15          	ldw	x,(OFST+1,sp)
 708  015c e605          	ld	a,(5,x)
 709  015e 5f            	clrw	x
 710  015f 97            	ld	xl,a
 711  0160 1f03          	ldw	(OFST-17,sp),x
 712  0162 1e15          	ldw	x,(OFST+1,sp)
 713  0164 e604          	ld	a,(4,x)
 714  0166 5f            	clrw	x
 715  0167 97            	ld	xl,a
 716  0168 4f            	clr	a
 717  0169 02            	rlwa	x,a
 718  016a 01            	rrwa	x,a
 719  016b 1a04          	or	a,(OFST-16,sp)
 720  016d 01            	rrwa	x,a
 721  016e 1a03          	or	a,(OFST-17,sp)
 722  0170 01            	rrwa	x,a
 723  0171 1f13          	ldw	(OFST-1,sp),x
 724                     ; 140 		input_bytes = data[6];
 726  0173 1e15          	ldw	x,(OFST+1,sp)
 727  0175 e606          	ld	a,(6,x)
 728  0177 6b12          	ld	(OFST-2,sp),a
 729                     ; 141 		pin_count = data[7];
 731  0179 1e15          	ldw	x,(OFST+1,sp)
 732  017b e607          	ld	a,(7,x)
 733  017d 6b0f          	ld	(OFST-5,sp),a
 734                     ; 142 		if( (start_addr <= input_addr & input_addr <= RelayAddrs)  & input_bytes == RelayCount )
 736  017f 7b12          	ld	a,(OFST-2,sp)
 737  0181 a101          	cp	a,#1
 738  0183 2605          	jrne	L23
 739  0185 ae0001        	ldw	x,#1
 740  0188 2001          	jra	L43
 741  018a               L23:
 742  018a 5f            	clrw	x
 743  018b               L43:
 744  018b 1f03          	ldw	(OFST-17,sp),x
 745  018d 1e13          	ldw	x,(OFST-1,sp)
 746  018f a30008        	cpw	x,#8
 747  0192 2405          	jruge	L63
 748  0194 ae0001        	ldw	x,#1
 749  0197 2001          	jra	L04
 750  0199               L63:
 751  0199 5f            	clrw	x
 752  019a               L04:
 753  019a 1f01          	ldw	(OFST-19,sp),x
 754  019c 1e10          	ldw	x,(OFST-4,sp)
 755  019e 1313          	cpw	x,(OFST-1,sp)
 756  01a0 2205          	jrugt	L24
 757  01a2 ae0001        	ldw	x,#1
 758  01a5 2001          	jra	L44
 759  01a7               L24:
 760  01a7 5f            	clrw	x
 761  01a8               L44:
 762  01a8 01            	rrwa	x,a
 763  01a9 1402          	and	a,(OFST-18,sp)
 764  01ab 01            	rrwa	x,a
 765  01ac 1401          	and	a,(OFST-19,sp)
 766  01ae 01            	rrwa	x,a
 767  01af 01            	rrwa	x,a
 768  01b0 1404          	and	a,(OFST-16,sp)
 769  01b2 01            	rrwa	x,a
 770  01b3 1403          	and	a,(OFST-17,sp)
 771  01b5 01            	rrwa	x,a
 772  01b6 a30000        	cpw	x,#0
 773  01b9 2750          	jreq	L152
 774                     ; 146 				true_data[0] = data[0];
 776  01bb 1e15          	ldw	x,(OFST+1,sp)
 777  01bd f6            	ld	a,(x)
 778  01be 6b07          	ld	(OFST-13,sp),a
 779                     ; 147 				true_data[1] = data[1];
 781  01c0 1e15          	ldw	x,(OFST+1,sp)
 782  01c2 e601          	ld	a,(1,x)
 783  01c4 6b08          	ld	(OFST-12,sp),a
 784                     ; 148 				true_data[2] = data[2];
 786  01c6 1e15          	ldw	x,(OFST+1,sp)
 787  01c8 e602          	ld	a,(2,x)
 788  01ca 6b09          	ld	(OFST-11,sp),a
 789                     ; 149 				true_data[3] = data[3];
 791  01cc 1e15          	ldw	x,(OFST+1,sp)
 792  01ce e603          	ld	a,(3,x)
 793  01d0 6b0a          	ld	(OFST-10,sp),a
 794                     ; 150 				true_data[4] = data[4];
 796  01d2 1e15          	ldw	x,(OFST+1,sp)
 797  01d4 e604          	ld	a,(4,x)
 798  01d6 6b0b          	ld	(OFST-9,sp),a
 799                     ; 151 				true_data[5] = data[5];
 801  01d8 1e15          	ldw	x,(OFST+1,sp)
 802  01da e605          	ld	a,(5,x)
 803  01dc 6b0c          	ld	(OFST-8,sp),a
 804                     ; 152 				crc = crc16_modbus( true_data , 6);
 806  01de 4b06          	push	#6
 807  01e0 96            	ldw	x,sp
 808  01e1 1c0008        	addw	x,#OFST-12
 809  01e4 cd0000        	call	_crc16_modbus
 811  01e7 84            	pop	a
 812  01e8 1f05          	ldw	(OFST-15,sp),x
 813                     ; 153 				true_data[6] = (u8)(crc>>8);
 815  01ea 7b05          	ld	a,(OFST-15,sp)
 816  01ec 6b0d          	ld	(OFST-7,sp),a
 817                     ; 154 				true_data[7] = (u8)crc;
 819  01ee 7b06          	ld	a,(OFST-14,sp)
 820  01f0 6b0e          	ld	(OFST-6,sp),a
 821                     ; 155 				More_Pincount( start_addr , input_addr , ~pin_count );
 823  01f2 7b0f          	ld	a,(OFST-5,sp)
 824  01f4 43            	cpl	a
 825  01f5 88            	push	a
 826  01f6 1e14          	ldw	x,(OFST+0,sp)
 827  01f8 89            	pushw	x
 828  01f9 1e13          	ldw	x,(OFST-1,sp)
 829  01fb ad48          	call	_More_Pincount
 831  01fd 5b03          	addw	sp,#3
 832                     ; 156 				Usart_Send_Bytes( true_data, 8 );
 834  01ff 4b08          	push	#8
 835  0201 96            	ldw	x,sp
 836  0202 1c0008        	addw	x,#OFST-12
 837  0205 cd0000        	call	_Usart_Send_Bytes
 839  0208 84            	pop	a
 841  0209 2037          	jra	L352
 842  020b               L152:
 843                     ; 162 				Err_addr[0] = data[0];
 845  020b 1e15          	ldw	x,(OFST+1,sp)
 846  020d f6            	ld	a,(x)
 847  020e 6b0a          	ld	(OFST-10,sp),a
 848                     ; 163 				Err_addr[1] = Slip_WriteMultipleCoil;
 850  0210 a60f          	ld	a,#15
 851  0212 6b0b          	ld	(OFST-9,sp),a
 852                     ; 164 				if( input_bytes != RelayCount )
 854  0214 7b12          	ld	a,(OFST-2,sp)
 855  0216 a101          	cp	a,#1
 856  0218 2706          	jreq	L552
 857                     ; 166 						Err_addr[2] = AddrOutput_Error;
 859  021a a603          	ld	a,#3
 860  021c 6b0c          	ld	(OFST-8,sp),a
 862  021e 2004          	jra	L752
 863  0220               L552:
 864                     ; 170 						Err_addr[2] = StartAddress_Error;
 866  0220 a602          	ld	a,#2
 867  0222 6b0c          	ld	(OFST-8,sp),a
 868  0224               L752:
 869                     ; 172 				Err_crc = crc16_modbus( Err_addr , 3);
 871  0224 4b03          	push	#3
 872  0226 96            	ldw	x,sp
 873  0227 1c000b        	addw	x,#OFST-9
 874  022a cd0000        	call	_crc16_modbus
 876  022d 84            	pop	a
 877  022e 1f08          	ldw	(OFST-12,sp),x
 878                     ; 173 				Err_addr[3] = (u8)(Err_crc>>8);
 880  0230 7b08          	ld	a,(OFST-12,sp)
 881  0232 6b0d          	ld	(OFST-7,sp),a
 882                     ; 174 				Err_addr[4] = (u8)Err_crc;
 884  0234 7b09          	ld	a,(OFST-11,sp)
 885  0236 6b0e          	ld	(OFST-6,sp),a
 886                     ; 175 				Usart_Send_Bytes(  Err_addr , 5 );
 888  0238 4b05          	push	#5
 889  023a 96            	ldw	x,sp
 890  023b 1c000b        	addw	x,#OFST-9
 891  023e cd0000        	call	_Usart_Send_Bytes
 893  0241 84            	pop	a
 894  0242               L352:
 895                     ; 177 	}
 898  0242 5b16          	addw	sp,#22
 899  0244 81            	ret
 980                     ; 185 void More_Pincount( u16 strat_add , u16 last_add , u8 pin_put )
 980                     ; 186 	{
 981                     	switch	.text
 982  0245               _More_Pincount:
 984  0245 89            	pushw	x
 985  0246 5206          	subw	sp,#6
 986       00000006      OFST:	set	6
 989                     ; 187 		u16 x = 0;
 991  0248 1e05          	ldw	x,(OFST-1,sp)
 992                     ; 188 		u8 data = 0,data_pin;
 994  024a 0f04          	clr	(OFST-2,sp)
 995                     ; 189 		data_pin = ~Read_Relay();
 997  024c cd0000        	call	_Read_Relay
 999  024f 43            	cpl	a
1000  0250 6b03          	ld	(OFST-3,sp),a
1001                     ; 190 		for(x = 0; x <= RelayAddrs; x++)  
1003  0252 5f            	clrw	x
1004  0253 1f05          	ldw	(OFST-1,sp),x
1005  0255               L323:
1006                     ; 192 				if(x < strat_add)
1008  0255 1e05          	ldw	x,(OFST-1,sp)
1009  0257 1307          	cpw	x,(OFST+1,sp)
1010  0259 2415          	jruge	L133
1011                     ; 194 					data |= data_pin & (1<<x);
1013  025b 7b06          	ld	a,(OFST+0,sp)
1014  025d 5f            	clrw	x
1015  025e 97            	ld	xl,a
1016  025f a601          	ld	a,#1
1017  0261 5d            	tnzw	x
1018  0262 2704          	jreq	L05
1019  0264               L25:
1020  0264 48            	sll	a
1021  0265 5a            	decw	x
1022  0266 26fc          	jrne	L25
1023  0268               L05:
1024  0268 1403          	and	a,(OFST-3,sp)
1025  026a 1a04          	or	a,(OFST-2,sp)
1026  026c 6b04          	ld	(OFST-2,sp),a
1028  026e 2053          	jra	L333
1029  0270               L133:
1030                     ; 196 				else if(x >= strat_add & x<= last_add)
1032  0270 1e05          	ldw	x,(OFST-1,sp)
1033  0272 130b          	cpw	x,(OFST+5,sp)
1034  0274 2205          	jrugt	L45
1035  0276 ae0001        	ldw	x,#1
1036  0279 2001          	jra	L65
1037  027b               L45:
1038  027b 5f            	clrw	x
1039  027c               L65:
1040  027c 1f01          	ldw	(OFST-5,sp),x
1041  027e 1e05          	ldw	x,(OFST-1,sp)
1042  0280 1307          	cpw	x,(OFST+1,sp)
1043  0282 2505          	jrult	L06
1044  0284 ae0001        	ldw	x,#1
1045  0287 2001          	jra	L26
1046  0289               L06:
1047  0289 5f            	clrw	x
1048  028a               L26:
1049  028a 01            	rrwa	x,a
1050  028b 1402          	and	a,(OFST-4,sp)
1051  028d 01            	rrwa	x,a
1052  028e 1401          	and	a,(OFST-5,sp)
1053  0290 01            	rrwa	x,a
1054  0291 a30000        	cpw	x,#0
1055  0294 271a          	jreq	L533
1056                     ; 198 					data |= ~pin_put & (1<<x);
1058  0296 7b06          	ld	a,(OFST+0,sp)
1059  0298 5f            	clrw	x
1060  0299 97            	ld	xl,a
1061  029a a601          	ld	a,#1
1062  029c 5d            	tnzw	x
1063  029d 2704          	jreq	L46
1064  029f               L66:
1065  029f 48            	sll	a
1066  02a0 5a            	decw	x
1067  02a1 26fc          	jrne	L66
1068  02a3               L46:
1069  02a3 6b02          	ld	(OFST-4,sp),a
1070  02a5 7b0d          	ld	a,(OFST+7,sp)
1071  02a7 43            	cpl	a
1072  02a8 1402          	and	a,(OFST-4,sp)
1073  02aa 1a04          	or	a,(OFST-2,sp)
1074  02ac 6b04          	ld	(OFST-2,sp),a
1076  02ae 2013          	jra	L333
1077  02b0               L533:
1078                     ; 202 					data |= data_pin & (1<<x);
1080  02b0 7b06          	ld	a,(OFST+0,sp)
1081  02b2 5f            	clrw	x
1082  02b3 97            	ld	xl,a
1083  02b4 a601          	ld	a,#1
1084  02b6 5d            	tnzw	x
1085  02b7 2704          	jreq	L07
1086  02b9               L27:
1087  02b9 48            	sll	a
1088  02ba 5a            	decw	x
1089  02bb 26fc          	jrne	L27
1090  02bd               L07:
1091  02bd 1403          	and	a,(OFST-3,sp)
1092  02bf 1a04          	or	a,(OFST-2,sp)
1093  02c1 6b04          	ld	(OFST-2,sp),a
1094  02c3               L333:
1095                     ; 190 		for(x = 0; x <= RelayAddrs; x++)  
1097  02c3 1e05          	ldw	x,(OFST-1,sp)
1098  02c5 1c0001        	addw	x,#1
1099  02c8 1f05          	ldw	(OFST-1,sp),x
1102  02ca 1e05          	ldw	x,(OFST-1,sp)
1103  02cc a30008        	cpw	x,#8
1104  02cf 2584          	jrult	L323
1105                     ; 205 		data = data ;
1107  02d1 7b04          	ld	a,(OFST-2,sp)
1108  02d3 97            	ld	xl,a
1109                     ; 206 		Write_Relay(data);
1111  02d4 7b04          	ld	a,(OFST-2,sp)
1112  02d6 cd0000        	call	_Write_Relay
1114                     ; 207 	}
1117  02d9 5b08          	addw	sp,#8
1118  02db 81            	ret
1221                     ; 219 void ReadCoils( u8 *data , u8 len )
1221                     ; 220 {
1222                     	switch	.text
1223  02dc               _ReadCoils:
1225  02dc 89            	pushw	x
1226  02dd 520d          	subw	sp,#13
1227       0000000d      OFST:	set	13
1230                     ; 221 	u16 start_addr=0, input_addr=0; //地址数量
1232  02df 1e0c          	ldw	x,(OFST-1,sp)
1235  02e1 1e0a          	ldw	x,(OFST-3,sp)
1236                     ; 222 	start_addr = ((u16)data[2]<<8) | ((u16)data[3]);
1238  02e3 1e0e          	ldw	x,(OFST+1,sp)
1239  02e5 e603          	ld	a,(3,x)
1240  02e7 5f            	clrw	x
1241  02e8 97            	ld	xl,a
1242  02e9 1f01          	ldw	(OFST-12,sp),x
1243  02eb 1e0e          	ldw	x,(OFST+1,sp)
1244  02ed e602          	ld	a,(2,x)
1245  02ef 5f            	clrw	x
1246  02f0 97            	ld	xl,a
1247  02f1 4f            	clr	a
1248  02f2 02            	rlwa	x,a
1249  02f3 01            	rrwa	x,a
1250  02f4 1a02          	or	a,(OFST-11,sp)
1251  02f6 01            	rrwa	x,a
1252  02f7 1a01          	or	a,(OFST-12,sp)
1253  02f9 01            	rrwa	x,a
1254  02fa 1f0c          	ldw	(OFST-1,sp),x
1255                     ; 223 	input_addr = ((u16)data[4]<<8) | ((u16)data[5]);
1257  02fc 1e0e          	ldw	x,(OFST+1,sp)
1258  02fe e605          	ld	a,(5,x)
1259  0300 5f            	clrw	x
1260  0301 97            	ld	xl,a
1261  0302 1f01          	ldw	(OFST-12,sp),x
1262  0304 1e0e          	ldw	x,(OFST+1,sp)
1263  0306 e604          	ld	a,(4,x)
1264  0308 5f            	clrw	x
1265  0309 97            	ld	xl,a
1266  030a 4f            	clr	a
1267  030b 02            	rlwa	x,a
1268  030c 01            	rrwa	x,a
1269  030d 1a02          	or	a,(OFST-11,sp)
1270  030f 01            	rrwa	x,a
1271  0310 1a01          	or	a,(OFST-12,sp)
1272  0312 01            	rrwa	x,a
1273  0313 1f0a          	ldw	(OFST-3,sp),x
1274                     ; 224 	if( start_addr < input_addr & input_addr <= ReadCoil  )
1276  0315 1e0a          	ldw	x,(OFST-3,sp)
1277  0317 a30010        	cpw	x,#16
1278  031a 2405          	jruge	L67
1279  031c ae0001        	ldw	x,#1
1280  031f 2001          	jra	L001
1281  0321               L67:
1282  0321 5f            	clrw	x
1283  0322               L001:
1284  0322 1f01          	ldw	(OFST-12,sp),x
1285  0324 1e0c          	ldw	x,(OFST-1,sp)
1286  0326 130a          	cpw	x,(OFST-3,sp)
1287  0328 2405          	jruge	L201
1288  032a ae0001        	ldw	x,#1
1289  032d 2001          	jra	L401
1290  032f               L201:
1291  032f 5f            	clrw	x
1292  0330               L401:
1293  0330 01            	rrwa	x,a
1294  0331 1402          	and	a,(OFST-11,sp)
1295  0333 01            	rrwa	x,a
1296  0334 1401          	and	a,(OFST-12,sp)
1297  0336 01            	rrwa	x,a
1298  0337 a30000        	cpw	x,#0
1299  033a 2742          	jreq	L314
1300                     ; 228 				true_data[0] = data[0];
1302  033c 1e0e          	ldw	x,(OFST+1,sp)
1303  033e f6            	ld	a,(x)
1304  033f 6b03          	ld	(OFST-10,sp),a
1305                     ; 229 				true_data[1] = data[1];
1307  0341 1e0e          	ldw	x,(OFST+1,sp)
1308  0343 e601          	ld	a,(1,x)
1309  0345 6b04          	ld	(OFST-9,sp),a
1310                     ; 230 				true_data[2] = 0x02;
1312  0347 a602          	ld	a,#2
1313  0349 6b05          	ld	(OFST-8,sp),a
1314                     ; 231 				data_bit = ReadCoil_input( start_addr, input_addr );
1316  034b 1e0a          	ldw	x,(OFST-3,sp)
1317  034d 89            	pushw	x
1318  034e 1e0e          	ldw	x,(OFST+1,sp)
1319  0350 ad5a          	call	_ReadCoil_input
1321  0352 5b02          	addw	sp,#2
1322  0354 1f0c          	ldw	(OFST-1,sp),x
1323                     ; 232 				true_data[3] = (data_bit>>8);
1325  0356 7b0c          	ld	a,(OFST-1,sp)
1326  0358 6b06          	ld	(OFST-7,sp),a
1327                     ; 233 				true_data[4] = (u8)data_bit;
1329  035a 7b0d          	ld	a,(OFST+0,sp)
1330  035c 6b07          	ld	(OFST-6,sp),a
1331                     ; 234 				crc = crc16_modbus( true_data , 5 );
1333  035e 4b05          	push	#5
1334  0360 96            	ldw	x,sp
1335  0361 1c0004        	addw	x,#OFST-9
1336  0364 cd0000        	call	_crc16_modbus
1338  0367 84            	pop	a
1339  0368 1f0c          	ldw	(OFST-1,sp),x
1340                     ; 235 				true_data[5] = (u8)(crc>>8);
1342  036a 7b0c          	ld	a,(OFST-1,sp)
1343  036c 6b08          	ld	(OFST-5,sp),a
1344                     ; 236 				true_data[6] = (u8)crc;
1346  036e 7b0d          	ld	a,(OFST+0,sp)
1347  0370 6b09          	ld	(OFST-4,sp),a
1348                     ; 237 				Usart_Send_Bytes( true_data , 7 );
1350  0372 4b07          	push	#7
1351  0374 96            	ldw	x,sp
1352  0375 1c0004        	addw	x,#OFST-9
1353  0378 cd0000        	call	_Usart_Send_Bytes
1355  037b 84            	pop	a
1357  037c 202b          	jra	L514
1358  037e               L314:
1359                     ; 243 				Err_addr[0] = data[0];
1361  037e 1e0e          	ldw	x,(OFST+1,sp)
1362  0380 f6            	ld	a,(x)
1363  0381 6b05          	ld	(OFST-8,sp),a
1364                     ; 244 				Err_addr[1] = Slip_ReadCoil;
1366  0383 a680          	ld	a,#128
1367  0385 6b06          	ld	(OFST-7,sp),a
1368                     ; 245 				Err_addr[2] = StartAddress_Error;
1370  0387 a602          	ld	a,#2
1371  0389 6b07          	ld	(OFST-6,sp),a
1372                     ; 246 				Err_crc = crc16_modbus( Err_addr , 3 );
1374  038b 4b03          	push	#3
1375  038d 96            	ldw	x,sp
1376  038e 1c0006        	addw	x,#OFST-7
1377  0391 cd0000        	call	_crc16_modbus
1379  0394 84            	pop	a
1380  0395 1f0c          	ldw	(OFST-1,sp),x
1381                     ; 247 				Err_addr[3] = (u8)(Err_crc>>8);
1383  0397 7b0c          	ld	a,(OFST-1,sp)
1384  0399 6b08          	ld	(OFST-5,sp),a
1385                     ; 248 				Err_addr[4] = (u8)Err_crc;
1387  039b 7b0d          	ld	a,(OFST+0,sp)
1388  039d 6b09          	ld	(OFST-4,sp),a
1389                     ; 249 				Usart_Send_Bytes( Err_addr , 5 );
1391  039f 4b05          	push	#5
1392  03a1 96            	ldw	x,sp
1393  03a2 1c0006        	addw	x,#OFST-7
1394  03a5 cd0000        	call	_Usart_Send_Bytes
1396  03a8 84            	pop	a
1397  03a9               L514:
1398                     ; 251 }
1401  03a9 5b0f          	addw	sp,#15
1402  03ab 81            	ret
1465                     ; 258 u16 ReadCoil_input( u16 start_addr, u16 input_addr)
1465                     ; 259 {
1466                     	switch	.text
1467  03ac               _ReadCoil_input:
1469  03ac 89            	pushw	x
1470  03ad 5205          	subw	sp,#5
1471       00000005      OFST:	set	5
1474                     ; 260 	u16 data=0;
1476  03af 5f            	clrw	x
1477  03b0 1f03          	ldw	(OFST-2,sp),x
1478                     ; 262 	 for(x=start_addr; x<input_addr + 1; x++)
1480  03b2 7b07          	ld	a,(OFST+2,sp)
1481  03b4 6b05          	ld	(OFST+0,sp),a
1483  03b6 2054          	jra	L554
1484  03b8               L154:
1485                     ; 264 			if( x <= ReadCoil/2 )
1487  03b8 7b05          	ld	a,(OFST+0,sp)
1488  03ba a108          	cp	a,#8
1489  03bc 2426          	jruge	L164
1490                     ; 266 					data |= ~Read_Relay() & (1<<x);
1492  03be ae0001        	ldw	x,#1
1493  03c1 7b05          	ld	a,(OFST+0,sp)
1494  03c3 4d            	tnz	a
1495  03c4 2704          	jreq	L011
1496  03c6               L211:
1497  03c6 58            	sllw	x
1498  03c7 4a            	dec	a
1499  03c8 26fc          	jrne	L211
1500  03ca               L011:
1501  03ca 1f01          	ldw	(OFST-4,sp),x
1502  03cc cd0000        	call	_Read_Relay
1504  03cf 5f            	clrw	x
1505  03d0 97            	ld	xl,a
1506  03d1 53            	cplw	x
1507  03d2 01            	rrwa	x,a
1508  03d3 1402          	and	a,(OFST-3,sp)
1509  03d5 01            	rrwa	x,a
1510  03d6 1401          	and	a,(OFST-4,sp)
1511  03d8 01            	rrwa	x,a
1512  03d9 01            	rrwa	x,a
1513  03da 1a04          	or	a,(OFST-1,sp)
1514  03dc 01            	rrwa	x,a
1515  03dd 1a03          	or	a,(OFST-2,sp)
1516  03df 01            	rrwa	x,a
1517  03e0 1f03          	ldw	(OFST-2,sp),x
1519  03e2 2026          	jra	L364
1520  03e4               L164:
1521                     ; 270 					data |= ((~Read_Optocoupler())<<8) & (1<<x);
1523  03e4 ae0001        	ldw	x,#1
1524  03e7 7b05          	ld	a,(OFST+0,sp)
1525  03e9 4d            	tnz	a
1526  03ea 2704          	jreq	L411
1527  03ec               L611:
1528  03ec 58            	sllw	x
1529  03ed 4a            	dec	a
1530  03ee 26fc          	jrne	L611
1531  03f0               L411:
1532  03f0 1f01          	ldw	(OFST-4,sp),x
1533  03f2 cd0000        	call	_Read_Optocoupler
1535  03f5 5f            	clrw	x
1536  03f6 97            	ld	xl,a
1537  03f7 53            	cplw	x
1538  03f8 4f            	clr	a
1539  03f9 02            	rlwa	x,a
1540  03fa 01            	rrwa	x,a
1541  03fb 1402          	and	a,(OFST-3,sp)
1542  03fd 01            	rrwa	x,a
1543  03fe 1401          	and	a,(OFST-4,sp)
1544  0400 01            	rrwa	x,a
1545  0401 01            	rrwa	x,a
1546  0402 1a04          	or	a,(OFST-1,sp)
1547  0404 01            	rrwa	x,a
1548  0405 1a03          	or	a,(OFST-2,sp)
1549  0407 01            	rrwa	x,a
1550  0408 1f03          	ldw	(OFST-2,sp),x
1551  040a               L364:
1552                     ; 262 	 for(x=start_addr; x<input_addr + 1; x++)
1554  040a 0c05          	inc	(OFST+0,sp)
1555  040c               L554:
1558  040c 1e0a          	ldw	x,(OFST+5,sp)
1559  040e 5c            	incw	x
1560  040f 7b05          	ld	a,(OFST+0,sp)
1561  0411 905f          	clrw	y
1562  0413 9097          	ld	yl,a
1563  0415 90bf01        	ldw	c_y+1,y
1564  0418 b301          	cpw	x,c_y+1
1565  041a 229c          	jrugt	L154
1566                     ; 273 		return data;
1568  041c 1e03          	ldw	x,(OFST-2,sp)
1571  041e 5b07          	addw	sp,#7
1572  0420 81            	ret
1657                     ; 284 void WriteAsingleRegister( u8 *data , u8 len )
1657                     ; 285 {
1658                     	switch	.text
1659  0421               _WriteAsingleRegister:
1661  0421 89            	pushw	x
1662  0422 520b          	subw	sp,#11
1663       0000000b      OFST:	set	11
1666                     ; 287 		addr_qt = ((u16)data[2]<<8) | data[3];
1668  0424 e602          	ld	a,(2,x)
1669  0426 5f            	clrw	x
1670  0427 97            	ld	xl,a
1671  0428 4f            	clr	a
1672  0429 02            	rlwa	x,a
1673  042a 01            	rrwa	x,a
1674  042b 160c          	ldw	y,(OFST+1,sp)
1675  042d 90ea03        	or	a,(3,y)
1676  0430 02            	rlwa	x,a
1677  0431 1f0a          	ldw	(OFST-1,sp),x
1678  0433 01            	rrwa	x,a
1679                     ; 288 		input_value = (((u16)data[4])<<8) | data[5];
1681  0434 1e0c          	ldw	x,(OFST+1,sp)
1682  0436 e604          	ld	a,(4,x)
1683  0438 5f            	clrw	x
1684  0439 97            	ld	xl,a
1685  043a 4f            	clr	a
1686  043b 02            	rlwa	x,a
1687  043c 01            	rrwa	x,a
1688  043d 160c          	ldw	y,(OFST+1,sp)
1689  043f 90ea05        	or	a,(5,y)
1690  0442 02            	rlwa	x,a
1691  0443 1f08          	ldw	(OFST-3,sp),x
1692  0445 01            	rrwa	x,a
1693                     ; 289 		if( addr_qt < TEL_table & input_value <= RegisterSite0_ONE )
1695  0446 1e08          	ldw	x,(OFST-3,sp)
1696  0448 a30002        	cpw	x,#2
1697  044b 2405          	jruge	L221
1698  044d ae0001        	ldw	x,#1
1699  0450 2001          	jra	L421
1700  0452               L221:
1701  0452 5f            	clrw	x
1702  0453               L421:
1703  0453 1f01          	ldw	(OFST-10,sp),x
1704  0455 1e0a          	ldw	x,(OFST-1,sp)
1705  0457 2605          	jrne	L621
1706  0459 ae0001        	ldw	x,#1
1707  045c 2001          	jra	L031
1708  045e               L621:
1709  045e 5f            	clrw	x
1710  045f               L031:
1711  045f 01            	rrwa	x,a
1712  0460 1402          	and	a,(OFST-9,sp)
1713  0462 01            	rrwa	x,a
1714  0463 1401          	and	a,(OFST-10,sp)
1715  0465 01            	rrwa	x,a
1716  0466 a30000        	cpw	x,#0
1717  0469 271b          	jreq	L725
1718                     ; 291 			Register_state(addr_qt, data[4], data[5]);
1720  046b 1e0c          	ldw	x,(OFST+1,sp)
1721  046d e605          	ld	a,(5,x)
1722  046f 88            	push	a
1723  0470 1e0d          	ldw	x,(OFST+2,sp)
1724  0472 e604          	ld	a,(4,x)
1725  0474 88            	push	a
1726  0475 1e0c          	ldw	x,(OFST+1,sp)
1727  0477 cd059b        	call	_Register_state
1729  047a 85            	popw	x
1730                     ; 292 			Usart_Send_Bytes( data, len );
1732  047b 7b10          	ld	a,(OFST+5,sp)
1733  047d 88            	push	a
1734  047e 1e0d          	ldw	x,(OFST+2,sp)
1735  0480 cd0000        	call	_Usart_Send_Bytes
1737  0483 84            	pop	a
1739  0484 2035          	jra	L135
1740  0486               L725:
1741                     ; 298 				Err_addr[0] = data[0];
1743  0486 1e0c          	ldw	x,(OFST+1,sp)
1744  0488 f6            	ld	a,(x)
1745  0489 6b03          	ld	(OFST-8,sp),a
1746                     ; 299 				Err_addr[1] = Slip_WriteAsingleRegister;
1748  048b a686          	ld	a,#134
1749  048d 6b04          	ld	(OFST-7,sp),a
1750                     ; 300 				if( addr_qt >= TEL_table )
1752  048f 1e0a          	ldw	x,(OFST-1,sp)
1753  0491 2706          	jreq	L335
1754                     ; 302 						Err_addr[2] = AddrOutput_Error;
1756  0493 a603          	ld	a,#3
1757  0495 6b05          	ld	(OFST-6,sp),a
1759  0497 2004          	jra	L535
1760  0499               L335:
1761                     ; 306 						Err_addr[2] = WriteOutput_Error;
1763  0499 a604          	ld	a,#4
1764  049b 6b05          	ld	(OFST-6,sp),a
1765  049d               L535:
1766                     ; 308 				Err_crc = crc16_modbus( Err_addr , 3);
1768  049d 4b03          	push	#3
1769  049f 96            	ldw	x,sp
1770  04a0 1c0004        	addw	x,#OFST-7
1771  04a3 cd0000        	call	_crc16_modbus
1773  04a6 84            	pop	a
1774  04a7 1f0a          	ldw	(OFST-1,sp),x
1775                     ; 309 				Err_addr[3] = (u8)(Err_crc>>8);
1777  04a9 7b0a          	ld	a,(OFST-1,sp)
1778  04ab 6b06          	ld	(OFST-5,sp),a
1779                     ; 310 				Err_addr[4] = (u8)Err_crc;
1781  04ad 7b0b          	ld	a,(OFST+0,sp)
1782  04af 6b07          	ld	(OFST-4,sp),a
1783                     ; 311 				Usart_Send_Bytes(  Err_addr , 5 );
1785  04b1 4b05          	push	#5
1786  04b3 96            	ldw	x,sp
1787  04b4 1c0004        	addw	x,#OFST-7
1788  04b7 cd0000        	call	_Usart_Send_Bytes
1790  04ba 84            	pop	a
1791  04bb               L135:
1792                     ; 313 }
1795  04bb 5b0d          	addw	sp,#13
1796  04bd 81            	ret
1899                     ; 320 void ReadInputRegister( u8 *data , u8 len )
1899                     ; 321 {
1900                     	switch	.text
1901  04be               _ReadInputRegister:
1903  04be 89            	pushw	x
1904  04bf 520f          	subw	sp,#15
1905       0000000f      OFST:	set	15
1908                     ; 322 		u16 start_addr=0, input_addr=0; //地址数量
1910  04c1 1e0c          	ldw	x,(OFST-3,sp)
1913  04c3 1e0e          	ldw	x,(OFST-1,sp)
1914                     ; 323 	start_addr = ((u16)data[2]<<8) | ((u16)data[3]);
1916  04c5 1e10          	ldw	x,(OFST+1,sp)
1917  04c7 e603          	ld	a,(3,x)
1918  04c9 5f            	clrw	x
1919  04ca 97            	ld	xl,a
1920  04cb 1f03          	ldw	(OFST-12,sp),x
1921  04cd 1e10          	ldw	x,(OFST+1,sp)
1922  04cf e602          	ld	a,(2,x)
1923  04d1 5f            	clrw	x
1924  04d2 97            	ld	xl,a
1925  04d3 4f            	clr	a
1926  04d4 02            	rlwa	x,a
1927  04d5 01            	rrwa	x,a
1928  04d6 1a04          	or	a,(OFST-11,sp)
1929  04d8 01            	rrwa	x,a
1930  04d9 1a03          	or	a,(OFST-12,sp)
1931  04db 01            	rrwa	x,a
1932  04dc 1f0c          	ldw	(OFST-3,sp),x
1933                     ; 324 	input_addr = ((u16)data[4]<<8) | ((u16)data[5]);
1935  04de 1e10          	ldw	x,(OFST+1,sp)
1936  04e0 e605          	ld	a,(5,x)
1937  04e2 5f            	clrw	x
1938  04e3 97            	ld	xl,a
1939  04e4 1f03          	ldw	(OFST-12,sp),x
1940  04e6 1e10          	ldw	x,(OFST+1,sp)
1941  04e8 e604          	ld	a,(4,x)
1942  04ea 5f            	clrw	x
1943  04eb 97            	ld	xl,a
1944  04ec 4f            	clr	a
1945  04ed 02            	rlwa	x,a
1946  04ee 01            	rrwa	x,a
1947  04ef 1a04          	or	a,(OFST-11,sp)
1948  04f1 01            	rrwa	x,a
1949  04f2 1a03          	or	a,(OFST-12,sp)
1950  04f4 01            	rrwa	x,a
1951  04f5 1f0e          	ldw	(OFST-1,sp),x
1952                     ; 325 	if( start_addr < TEL_table & input_addr <= TEL_table  & input_addr > RegisterSite0)
1954  04f7 1e0e          	ldw	x,(OFST-1,sp)
1955  04f9 2705          	jreq	L431
1956  04fb ae0001        	ldw	x,#1
1957  04fe 2001          	jra	L631
1958  0500               L431:
1959  0500 5f            	clrw	x
1960  0501               L631:
1961  0501 1f03          	ldw	(OFST-12,sp),x
1962  0503 1e0e          	ldw	x,(OFST-1,sp)
1963  0505 a30002        	cpw	x,#2
1964  0508 2405          	jruge	L041
1965  050a ae0001        	ldw	x,#1
1966  050d 2001          	jra	L241
1967  050f               L041:
1968  050f 5f            	clrw	x
1969  0510               L241:
1970  0510 1f01          	ldw	(OFST-14,sp),x
1971  0512 1e0c          	ldw	x,(OFST-3,sp)
1972  0514 2605          	jrne	L441
1973  0516 ae0001        	ldw	x,#1
1974  0519 2001          	jra	L641
1975  051b               L441:
1976  051b 5f            	clrw	x
1977  051c               L641:
1978  051c 01            	rrwa	x,a
1979  051d 1402          	and	a,(OFST-13,sp)
1980  051f 01            	rrwa	x,a
1981  0520 1401          	and	a,(OFST-14,sp)
1982  0522 01            	rrwa	x,a
1983  0523 01            	rrwa	x,a
1984  0524 1404          	and	a,(OFST-11,sp)
1985  0526 01            	rrwa	x,a
1986  0527 1403          	and	a,(OFST-12,sp)
1987  0529 01            	rrwa	x,a
1988  052a a30000        	cpw	x,#0
1989  052d 273e          	jreq	L116
1990                     ; 329 				true_data[0] = data[0];
1992  052f 1e10          	ldw	x,(OFST+1,sp)
1993  0531 f6            	ld	a,(x)
1994  0532 6b05          	ld	(OFST-10,sp),a
1995                     ; 330 				true_data[1] = data[1];
1997  0534 1e10          	ldw	x,(OFST+1,sp)
1998  0536 e601          	ld	a,(1,x)
1999  0538 6b06          	ld	(OFST-9,sp),a
2000                     ; 331 				true_data[2] = 2*input_addr;
2002  053a 7b0f          	ld	a,(OFST+0,sp)
2003  053c 48            	sll	a
2004  053d 6b07          	ld	(OFST-8,sp),a
2005                     ; 332 				data_bit = Register_input( RegisterSite0 );
2007  053f 5f            	clrw	x
2008  0540 cd05c7        	call	_Register_input
2010  0543 1f0e          	ldw	(OFST-1,sp),x
2011                     ; 333 				true_data[3] = (u8)(data_bit>>8);
2013  0545 7b0e          	ld	a,(OFST-1,sp)
2014  0547 6b08          	ld	(OFST-7,sp),a
2015                     ; 334 				true_data[4] = (u8)data_bit;
2017  0549 7b0f          	ld	a,(OFST+0,sp)
2018  054b 6b09          	ld	(OFST-6,sp),a
2019                     ; 335 				crc = crc16_modbus( true_data , 5 );
2021  054d 4b05          	push	#5
2022  054f 96            	ldw	x,sp
2023  0550 1c0006        	addw	x,#OFST-9
2024  0553 cd0000        	call	_crc16_modbus
2026  0556 84            	pop	a
2027  0557 1f0e          	ldw	(OFST-1,sp),x
2028                     ; 336 				true_data[5] = (u8)(crc>>8);
2030  0559 7b0e          	ld	a,(OFST-1,sp)
2031  055b 6b0a          	ld	(OFST-5,sp),a
2032                     ; 337 				true_data[6] = (u8)crc;
2034  055d 7b0f          	ld	a,(OFST+0,sp)
2035  055f 6b0b          	ld	(OFST-4,sp),a
2036                     ; 338 				Usart_Send_Bytes( true_data, 7 );
2038  0561 4b07          	push	#7
2039  0563 96            	ldw	x,sp
2040  0564 1c0006        	addw	x,#OFST-9
2041  0567 cd0000        	call	_Usart_Send_Bytes
2043  056a 84            	pop	a
2045  056b 202b          	jra	L316
2046  056d               L116:
2047                     ; 345 				Err_addr[0] = data[0];
2049  056d 1e10          	ldw	x,(OFST+1,sp)
2050  056f f6            	ld	a,(x)
2051  0570 6b07          	ld	(OFST-8,sp),a
2052                     ; 346 				Err_addr[1] = Slip_ReadInputRegister;
2054  0572 a684          	ld	a,#132
2055  0574 6b08          	ld	(OFST-7,sp),a
2056                     ; 347 				Err_addr[2] = StartAddress_Error;
2058  0576 a602          	ld	a,#2
2059  0578 6b09          	ld	(OFST-6,sp),a
2060                     ; 348 				Err_crc = crc16_modbus( Err_addr , 3 );
2062  057a 4b03          	push	#3
2063  057c 96            	ldw	x,sp
2064  057d 1c0008        	addw	x,#OFST-7
2065  0580 cd0000        	call	_crc16_modbus
2067  0583 84            	pop	a
2068  0584 1f0e          	ldw	(OFST-1,sp),x
2069                     ; 349 				Err_addr[3] = (u8)(Err_crc>>8);
2071  0586 7b0e          	ld	a,(OFST-1,sp)
2072  0588 6b0a          	ld	(OFST-5,sp),a
2073                     ; 350 				Err_addr[4] = (u8)Err_crc;
2075  058a 7b0f          	ld	a,(OFST+0,sp)
2076  058c 6b0b          	ld	(OFST-4,sp),a
2077                     ; 351 				Usart_Send_Bytes( Err_addr , 5 );
2079  058e 4b05          	push	#5
2080  0590 96            	ldw	x,sp
2081  0591 1c0008        	addw	x,#OFST-7
2082  0594 cd0000        	call	_Usart_Send_Bytes
2084  0597 84            	pop	a
2085  0598               L316:
2086                     ; 353 }
2089  0598 5b11          	addw	sp,#17
2090  059a 81            	ret
2152                     ; 363 void Register_state(u16 readdr, u8 state_h, u8 state_l)
2152                     ; 364 {
2153                     	switch	.text
2154  059b               _Register_state:
2156  059b 89            	pushw	x
2157  059c 89            	pushw	x
2158       00000002      OFST:	set	2
2161                     ; 365 	u16 data = readdr*2;
2163  059d 58            	sllw	x
2164  059e 1f01          	ldw	(OFST-1,sp),x
2165                     ; 366 	register_block[data] = state_h;
2167  05a0 7b07          	ld	a,(OFST+5,sp)
2168  05a2 1e01          	ldw	x,(OFST-1,sp)
2169  05a4 e700          	ld	(_register_block,x),a
2170                     ; 367 	register_block[data+1] = state_l;
2172  05a6 7b08          	ld	a,(OFST+6,sp)
2173  05a8 1e01          	ldw	x,(OFST-1,sp)
2174  05aa e701          	ld	(_register_block+1,x),a
2175                     ; 368 }
2178  05ac 5b04          	addw	sp,#4
2179  05ae 81            	ret
2214                     ; 376 void init_Register( void )
2214                     ; 377 {
2215                     	switch	.text
2216  05af               _init_Register:
2218  05af 89            	pushw	x
2219       00000002      OFST:	set	2
2222                     ; 379 	for(x = 0; x <TEL_table*2; x++)
2224  05b0 5f            	clrw	x
2225  05b1 1f01          	ldw	(OFST-1,sp),x
2226  05b3               L566:
2227                     ; 380 			register_block[x] = 0x00;
2229  05b3 1e01          	ldw	x,(OFST-1,sp)
2230  05b5 6f00          	clr	(_register_block,x)
2231                     ; 379 	for(x = 0; x <TEL_table*2; x++)
2233  05b7 1e01          	ldw	x,(OFST-1,sp)
2234  05b9 1c0001        	addw	x,#1
2235  05bc 1f01          	ldw	(OFST-1,sp),x
2238  05be 1e01          	ldw	x,(OFST-1,sp)
2239  05c0 a30002        	cpw	x,#2
2240  05c3 25ee          	jrult	L566
2241                     ; 381 }
2244  05c5 85            	popw	x
2245  05c6 81            	ret
2289                     ; 389 u16 Register_input( u16 bit )
2289                     ; 390 {
2290                     	switch	.text
2291  05c7               _Register_input:
2293  05c7 89            	pushw	x
2294  05c8 89            	pushw	x
2295       00000002      OFST:	set	2
2298                     ; 391 	u16 data = 0;
2300  05c9 5f            	clrw	x
2301  05ca 1f01          	ldw	(OFST-1,sp),x
2302                     ; 392 	data = (u16)register_block[bit]<<8;
2304  05cc 1e03          	ldw	x,(OFST+1,sp)
2305  05ce e600          	ld	a,(_register_block,x)
2306  05d0 5f            	clrw	x
2307  05d1 97            	ld	xl,a
2308  05d2 4f            	clr	a
2309  05d3 02            	rlwa	x,a
2310  05d4 1f01          	ldw	(OFST-1,sp),x
2311                     ; 393 	data |= register_block[bit+1];
2313  05d6 1e03          	ldw	x,(OFST+1,sp)
2314  05d8 e601          	ld	a,(_register_block+1,x)
2315  05da 5f            	clrw	x
2316  05db 97            	ld	xl,a
2317  05dc 01            	rrwa	x,a
2318  05dd 1a02          	or	a,(OFST+0,sp)
2319  05df 01            	rrwa	x,a
2320  05e0 1a01          	or	a,(OFST-1,sp)
2321  05e2 01            	rrwa	x,a
2322  05e3 1f01          	ldw	(OFST-1,sp),x
2323                     ; 394 	return data;
2325  05e5 1e01          	ldw	x,(OFST-1,sp)
2328  05e7 5b04          	addw	sp,#4
2329  05e9 81            	ret
2356                     ; 402 void Register_function( void )
2356                     ; 403 {
2357                     	switch	.text
2358  05ea               _Register_function:
2362                     ; 404 	if(Register_input( RegisterSite0 ) == RegisterSite0_ONE)
2364  05ea 5f            	clrw	x
2365  05eb adda          	call	_Register_input
2367  05ed a30001        	cpw	x,#1
2368  05f0 260e          	jrne	L527
2369                     ; 406 		if(Delays(  ) == true)
2371  05f2 cd0000        	call	_Delays
2373  05f5 a101          	cp	a,#1
2374  05f7 2607          	jrne	L527
2375                     ; 408 					Write_Relay(~Read_Optocoupler());
2377  05f9 cd0000        	call	_Read_Optocoupler
2379  05fc 43            	cpl	a
2380  05fd cd0000        	call	_Write_Relay
2382  0600               L527:
2383                     ; 411 }
2386  0600 81            	ret
2399                     	xdef	_Register_state
2400                     	xdef	_init_Register
2401                     	xdef	_ReadCoil_input
2402                     	xdef	_More_Pincount
2403                     	xdef	_AsingleCoil_map
2404                     	xdef	_Delays
2405                     	xref	_crc16_modbus
2406                     	xref	_Read_Relay
2407                     	xref	_Write_Relay
2408                     	xref	_Init_Relay
2409                     	xref	_Init_ModbusAddr
2410                     	xref	_Read_Optocoupler
2411                     	xref	_Init_Optocoupler
2412                     	xref.b	_register_block
2413                     	xdef	_Register_function
2414                     	xdef	_ReadInputRegister
2415                     	xdef	_Register_input
2416                     	xdef	_WriteAsingleRegister
2417                     	xdef	_ReadCoils
2418                     	xdef	_WriteMultipleCoil
2419                     	xdef	_WrAsingleCoil
2420                     	xdef	_Init
2421                     	xref	_Usart_Send_Bytes
2422                     	xref	_Init_Usart
2423                     	xref.b	c_y
2442                     	end
