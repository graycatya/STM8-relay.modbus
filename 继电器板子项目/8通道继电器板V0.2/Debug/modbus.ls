   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  56                     ; 21 void Modbus_Analyze( u8 location )
  56                     ; 22 {
  58                     	switch	.text
  59  0000               _Modbus_Analyze:
  61  0000 88            	push	a
  62  0001 89            	pushw	x
  63       00000002      OFST:	set	2
  66                     ; 25 		if( usart2_rece.event )
  68  0002 3d02          	tnz	_usart2_rece
  69  0004 2726          	jreq	L33
  70                     ; 27 			usart2_rece.event = false;
  72  0006 3f02          	clr	_usart2_rece
  73                     ; 28 			Dispose_data = usart2_rece.buffer;
  75  0008 ae0004        	ldw	x,#_usart2_rece+2
  76  000b 1f01          	ldw	(OFST-1,sp),x
  77                     ; 30 			if( Dispose_data[0] == Broadcast_Addr ) return; //广播不做处理
  79  000d 1e01          	ldw	x,(OFST-1,sp)
  80  000f 7d            	tnz	(x)
  81  0010 271a          	jreq	L6
  84                     ; 32 			if( location ==  Dispose_data[0] ) //地址码判断
  86  0012 1e01          	ldw	x,(OFST-1,sp)
  87  0014 f6            	ld	a,(x)
  88  0015 1103          	cp	a,(OFST+1,sp)
  89  0017 2611          	jrne	L73
  90                     ; 35 				if(Modbus_Crc( Dispose_data, usart2_rece.cnt )) //CRC校验
  92  0019 3b0003        	push	_usart2_rece+1
  93  001c 1e02          	ldw	x,(OFST+0,sp)
  94  001e cd00bb        	call	_Modbus_Crc
  96  0021 5b01          	addw	sp,#1
  97  0023 4d            	tnz	a
  98  0024 2704          	jreq	L73
  99                     ; 37 					Functional_analysis( Dispose_data );
 101  0026 1e01          	ldw	x,(OFST-1,sp)
 102  0028 ad05          	call	_Functional_analysis
 104  002a               L73:
 105                     ; 41 			usart2_rece.cnt = 0;
 107  002a 3f03          	clr	_usart2_rece+1
 108  002c               L33:
 109                     ; 43 }
 110  002c               L6:
 113  002c 5b03          	addw	sp,#3
 114  002e 81            	ret
 158                     ; 50 void Functional_analysis( u8 *data )
 158                     ; 51 {
 159                     	switch	.text
 160  002f               _Functional_analysis:
 162  002f 89            	pushw	x
 163       00000000      OFST:	set	0
 166                     ; 52 	switch(data[1])
 168  0030 e601          	ld	a,(1,x)
 170                     ; 89 			break;
 171  0032 4a            	dec	a
 172  0033 2713          	jreq	L34
 173  0035 a003          	sub	a,#3
 174  0037 271a          	jreq	L54
 175  0039 4a            	dec	a
 176  003a 2722          	jreq	L74
 177  003c 4a            	dec	a
 178  003d 2733          	jreq	L15
 179  003f a009          	sub	a,#9
 180  0041 273a          	jreq	L35
 181  0043 4a            	dec	a
 182  0044 274b          	jreq	L55
 183  0046 2052          	jra	L101
 184  0048               L34:
 185                     ; 56 				ReadCoils( data , usart2_rece.cnt );
 187  0048 3b0003        	push	_usart2_rece+1
 188  004b 1e02          	ldw	x,(OFST+2,sp)
 189  004d cd0000        	call	_ReadCoils
 191  0050 84            	pop	a
 192                     ; 57 				break;
 194  0051 2047          	jra	L101
 195  0053               L54:
 196                     ; 61 				ReadInputRegister( data, usart2_rece.cnt );
 198  0053 3b0003        	push	_usart2_rece+1
 199  0056 1e02          	ldw	x,(OFST+2,sp)
 200  0058 cd0000        	call	_ReadInputRegister
 202  005b 84            	pop	a
 203                     ; 62 				break;
 205  005c 203c          	jra	L101
 206  005e               L74:
 207                     ; 66 				if( Register_input( RegisterSite0 ) == RegisterSite0_ZERO )
 209  005e 5f            	clrw	x
 210  005f cd0000        	call	_Register_input
 212  0062 a30000        	cpw	x,#0
 213  0065 2633          	jrne	L101
 214                     ; 67 					WrAsingleCoil( data , usart2_rece.cnt);
 216  0067 3b0003        	push	_usart2_rece+1
 217  006a 1e02          	ldw	x,(OFST+2,sp)
 218  006c cd0000        	call	_WrAsingleCoil
 220  006f 84            	pop	a
 221  0070 2028          	jra	L101
 222  0072               L15:
 223                     ; 72 				WriteAsingleRegister( data , usart2_rece.cnt );
 225  0072 3b0003        	push	_usart2_rece+1
 226  0075 1e02          	ldw	x,(OFST+2,sp)
 227  0077 cd0000        	call	_WriteAsingleRegister
 229  007a 84            	pop	a
 230                     ; 74 				break;
 232  007b 201d          	jra	L101
 233  007d               L35:
 234                     ; 78 				if( Register_input( RegisterSite0 ) == RegisterSite0_ZERO )
 236  007d 5f            	clrw	x
 237  007e cd0000        	call	_Register_input
 239  0081 a30000        	cpw	x,#0
 240  0084 2614          	jrne	L101
 241                     ; 79 					WriteMultipleCoil( data , usart2_rece.cnt );
 243  0086 3b0003        	push	_usart2_rece+1
 244  0089 1e02          	ldw	x,(OFST+2,sp)
 245  008b cd0000        	call	_WriteMultipleCoil
 247  008e 84            	pop	a
 248  008f 2009          	jra	L101
 249  0091               L55:
 250                     ; 84 				Usart_Send_Bytes( data, usart2_rece.cnt );
 252  0091 3b0003        	push	_usart2_rece+1
 253  0094 1e02          	ldw	x,(OFST+2,sp)
 254  0096 cd0000        	call	_Usart_Send_Bytes
 256  0099 84            	pop	a
 257                     ; 85 				break;
 259  009a               L101:
 260                     ; 92 }
 263  009a 85            	popw	x
 264  009b 81            	ret
 328                     ; 102 u8* Returns_error( u8 *data ,u8 error_fun, u8 error)
 328                     ; 103 {
 329                     	switch	.text
 330  009c               _Returns_error:
 332  009c 89            	pushw	x
 333  009d 89            	pushw	x
 334       00000002      OFST:	set	2
 337                     ; 106 	data_treating[0] = data[0];
 339  009e f6            	ld	a,(x)
 340  009f 1e01          	ldw	x,(OFST-1,sp)
 341  00a1 f7            	ld	(x),a
 342                     ; 107 	data_treating[1] = data[1];
 344  00a2 1e03          	ldw	x,(OFST+1,sp)
 345  00a4 e601          	ld	a,(1,x)
 346  00a6 1e01          	ldw	x,(OFST-1,sp)
 347  00a8 e701          	ld	(1,x),a
 348                     ; 108 	data_treating[2] = error_fun;
 350  00aa 7b07          	ld	a,(OFST+5,sp)
 351  00ac 1e01          	ldw	x,(OFST-1,sp)
 352  00ae e702          	ld	(2,x),a
 353                     ; 109 	data_treating[3] = error;
 355  00b0 7b08          	ld	a,(OFST+6,sp)
 356  00b2 1e01          	ldw	x,(OFST-1,sp)
 357  00b4 e703          	ld	(3,x),a
 358                     ; 110 	return data_treating;
 360  00b6 1e01          	ldw	x,(OFST-1,sp)
 363  00b8 5b04          	addw	sp,#4
 364  00ba 81            	ret
 448                     ; 120 bool Modbus_Crc( u8 *data, u8 data_len)
 448                     ; 121 {
 449                     	switch	.text
 450  00bb               _Modbus_Crc:
 452  00bb 89            	pushw	x
 453  00bc 5205          	subw	sp,#5
 454       00000005      OFST:	set	5
 457                     ; 123 	crc16 = crc16_modbus( data, data_len-2);
 459  00be 7b0a          	ld	a,(OFST+5,sp)
 460  00c0 a002          	sub	a,#2
 461  00c2 88            	push	a
 462  00c3 cd0000        	call	_crc16_modbus
 464  00c6 84            	pop	a
 465  00c7 1f02          	ldw	(OFST-3,sp),x
 466                     ; 124 	data_crc = (u16)((data[data_len-2]<<8) | data[data_len-1]);
 468  00c9 7b0a          	ld	a,(OFST+5,sp)
 469  00cb 5f            	clrw	x
 470  00cc 97            	ld	xl,a
 471  00cd 5a            	decw	x
 472  00ce 72fb06        	addw	x,(OFST+1,sp)
 473  00d1 f6            	ld	a,(x)
 474  00d2 6b01          	ld	(OFST-4,sp),a
 475  00d4 7b0a          	ld	a,(OFST+5,sp)
 476  00d6 5f            	clrw	x
 477  00d7 97            	ld	xl,a
 478  00d8 5a            	decw	x
 479  00d9 5a            	decw	x
 480  00da 72fb06        	addw	x,(OFST+1,sp)
 481  00dd f6            	ld	a,(x)
 482  00de 5f            	clrw	x
 483  00df 97            	ld	xl,a
 484  00e0 4f            	clr	a
 485  00e1 02            	rlwa	x,a
 486  00e2 01            	rrwa	x,a
 487  00e3 1a01          	or	a,(OFST-4,sp)
 488  00e5 02            	rlwa	x,a
 489  00e6 1f04          	ldw	(OFST-1,sp),x
 490  00e8 01            	rrwa	x,a
 491                     ; 126 	if(data_crc == crc16)
 493  00e9 1e04          	ldw	x,(OFST-1,sp)
 494  00eb 1302          	cpw	x,(OFST-3,sp)
 495  00ed 2604          	jrne	L302
 496                     ; 128 			return true;
 498  00ef a601          	ld	a,#1
 500  00f1 2001          	jra	L61
 501  00f3               L302:
 502                     ; 131 	return false;
 504  00f3 4f            	clr	a
 506  00f4               L61:
 508  00f4 5b07          	addw	sp,#7
 509  00f6 81            	ret
 578                     	switch	.ubsct
 579  0000               _register_block:
 580  0000 0000          	ds.b	2
 581                     	xdef	_register_block
 582                     	xref	_ReadInputRegister
 583                     	xref	_Register_input
 584                     	xref	_WriteAsingleRegister
 585                     	xref	_ReadCoils
 586                     	xref	_WriteMultipleCoil
 587                     	xref	_WrAsingleCoil
 588                     	xref	_crc16_modbus
 589                     	xref	_Usart_Send_Bytes
 590  0002               _usart2_rece:
 591  0002 000000000000  	ds.b	102
 592                     	xdef	_usart2_rece
 593                     	xdef	_Functional_analysis
 594                     	xdef	_Returns_error
 595                     	xdef	_Modbus_Crc
 596                     	xdef	_Modbus_Analyze
 616                     	end
