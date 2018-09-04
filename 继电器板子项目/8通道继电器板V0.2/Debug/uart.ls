   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 12 void Init_Uart2_Gpio( void )
  32                     ; 13 {
  34                     	switch	.text
  35  0000               _Init_Uart2_Gpio:
  39                     ; 14 	USART2_TxPORT->DDR |= 1<<USART2_TxPIN;  /* 输出 */
  41  0000 721a5011      	bset	20497,#5
  42                     ; 15 	USART2_TxPORT->CR1 |= 1<<USART2_TxPIN;  /* 推挽 */
  44  0004 721a5012      	bset	20498,#5
  45                     ; 16 	USART2_RxPORT->DDR &= ~(1<<USART2_RxPIN);  /* 输入 */
  47  0008 721d5011      	bres	20497,#6
  48                     ; 17 	USART2_RxPORT->CR1 |= 1<<USART2_RxPIN;     /* 上拉 */
  50  000c 721c5012      	bset	20498,#6
  51                     ; 18 }
  54  0010 81            	ret
 125                     ; 27 void Init_Usart( u32 fclk, u16 baud )
 125                     ; 28 {
 126                     	switch	.text
 127  0011               _Init_Usart:
 129  0011 5208          	subw	sp,#8
 130       00000008      OFST:	set	8
 133                     ; 32 	Init_Uart2_Gpio( ); 	/* 初始化UARTx引脚 */
 135  0013 adeb          	call	_Init_Uart2_Gpio
 137                     ; 34 	brr_temp = fclk/baud;  		/* 计算波特率 		*/
 139  0015 1e0f          	ldw	x,(OFST+7,sp)
 140  0017 cd0000        	call	c_uitolx
 142  001a 96            	ldw	x,sp
 143  001b 1c0001        	addw	x,#OFST-7
 144  001e cd0000        	call	c_rtol
 146  0021 96            	ldw	x,sp
 147  0022 1c000b        	addw	x,#OFST+3
 148  0025 cd0000        	call	c_ltor
 150  0028 96            	ldw	x,sp
 151  0029 1c0001        	addw	x,#OFST-7
 152  002c cd0000        	call	c_ludv
 154  002f be02          	ldw	x,c_lreg+2
 155  0031 1f07          	ldw	(OFST-1,sp),x
 156                     ; 35 	brr2 = ( ( brr_temp>>8 ) & 0xf0 ) | ( brr_temp & 0x0f);
 158  0033 7b08          	ld	a,(OFST+0,sp)
 159  0035 a40f          	and	a,#15
 160  0037 6b04          	ld	(OFST-4,sp),a
 161  0039 7b07          	ld	a,(OFST-1,sp)
 162  003b a4f0          	and	a,#240
 163  003d 1a04          	or	a,(OFST-4,sp)
 164  003f 6b05          	ld	(OFST-3,sp),a
 165                     ; 36 	brr1 = brr_temp>>4;
 167  0041 1e07          	ldw	x,(OFST-1,sp)
 168  0043 54            	srlw	x
 169  0044 54            	srlw	x
 170  0045 54            	srlw	x
 171  0046 54            	srlw	x
 172  0047 01            	rrwa	x,a
 173  0048 6b06          	ld	(OFST-2,sp),a
 174  004a 02            	rlwa	x,a
 175                     ; 38 	UART2->BRR2 = brr2;
 177  004b 7b05          	ld	a,(OFST-3,sp)
 178  004d c75243        	ld	21059,a
 179                     ; 39 	UART2->BRR1 = brr1;
 181  0050 7b06          	ld	a,(OFST-2,sp)
 182  0052 c75242        	ld	21058,a
 183                     ; 41 	UART2->CR2 = 0x0c;  		/* 使能发送和接收 	 */
 185  0055 350c5245      	mov	21061,#12
 186                     ; 42 	UART2->CR2 |= 1<<5;  		/* 使能UART1接收中断 */
 188  0059 721a5245      	bset	21061,#5
 189                     ; 43 	UART2->CR2 |= 1<<4;  		/* 使能UART1空闲中断 */ 
 191  005d 72185245      	bset	21061,#4
 192                     ; 45 }
 195  0061 5b08          	addw	sp,#8
 196  0063 81            	ret
 230                     ; 53 void UART2_SendData8( u8 Data )  
 230                     ; 54 {
 231                     	switch	.text
 232  0064               _UART2_SendData8:
 234  0064 88            	push	a
 235       00000000      OFST:	set	0
 238  0065               L77:
 239                     ; 57 	while(!UART2_TXE);
 241  0065 c65240        	ld	a,21056
 242  0068 a580          	bcp	a,#128
 243  006a 27f9          	jreq	L77
 244                     ; 58 	LED_PROT->ODR = ((1<<LED_PIN) | LED_PROT->IDR);
 246  006c c65010        	ld	a,20496
 247  006f aa02          	or	a,#2
 248  0071 c7500f        	ld	20495,a
 249                     ; 59 	UART2->DR = Data; //向寄存器写数据。 
 251  0074 7b01          	ld	a,(OFST+1,sp)
 252  0076 c75241        	ld	21057,a
 254  0079               L701:
 255                     ; 61 	while(!UART2_TC);
 257  0079 c65240        	ld	a,21056
 258  007c a540          	bcp	a,#64
 259  007e 27f9          	jreq	L701
 260                     ; 62 } 
 263  0080 84            	pop	a
 264  0081 81            	ret
 308                     ; 70 void Usart_Send_Bytes( u8 *data, u8 length )
 308                     ; 71 {
 309                     	switch	.text
 310  0082               _Usart_Send_Bytes:
 312  0082 89            	pushw	x
 313       00000000      OFST:	set	0
 316  0083 201d          	jra	L731
 317  0085               L531:
 318                     ; 77 		LED_PROT->ODR = ((1<<LED_PIN) | LED_PROT->IDR);
 320  0085 c65010        	ld	a,20496
 321  0088 aa02          	or	a,#2
 322  008a c7500f        	ld	20495,a
 324  008d               L741:
 325                     ; 78 		while( !USARTx_TXE );
 327  008d c65240        	ld	a,21056
 328  0090 a580          	bcp	a,#128
 329  0092 27f9          	jreq	L741
 330                     ; 79 		UART2->DR = *(data++);
 332  0094 1e01          	ldw	x,(OFST+1,sp)
 333  0096 1c0001        	addw	x,#1
 334  0099 1f01          	ldw	(OFST+1,sp),x
 335  009b 1d0001        	subw	x,#1
 336  009e f6            	ld	a,(x)
 337  009f c75241        	ld	21057,a
 338  00a2               L731:
 339                     ; 76 	while( length-- ){
 341  00a2 7b05          	ld	a,(OFST+5,sp)
 342  00a4 0a05          	dec	(OFST+5,sp)
 343  00a6 4d            	tnz	a
 344  00a7 26dc          	jrne	L531
 346  00a9               L551:
 347                     ; 82 	while( !USARTx_TC );
 349  00a9 c65240        	ld	a,21056
 350  00ac a540          	bcp	a,#64
 351  00ae 27f9          	jreq	L551
 352                     ; 83 }
 355  00b0 85            	popw	x
 356  00b1 81            	ret
 391                     ; 92 void Usart_Send_String( char *string )
 391                     ; 93 {
 392                     	switch	.text
 393  00b2               _Usart_Send_String:
 395  00b2 89            	pushw	x
 396       00000000      OFST:	set	0
 399  00b3 2015          	jra	L102
 400  00b5               L702:
 401                     ; 98 		while( !USARTx_TXE );
 403  00b5 c65240        	ld	a,21056
 404  00b8 a580          	bcp	a,#128
 405  00ba 27f9          	jreq	L702
 406                     ; 99 		UART2->DR = *(string++);
 408  00bc 1e01          	ldw	x,(OFST+1,sp)
 409  00be 1c0001        	addw	x,#1
 410  00c1 1f01          	ldw	(OFST+1,sp),x
 411  00c3 1d0001        	subw	x,#1
 412  00c6 f6            	ld	a,(x)
 413  00c7 c75241        	ld	21057,a
 414  00ca               L102:
 415                     ; 97 	while( *string != '\0' ){
 417  00ca 1e01          	ldw	x,(OFST+1,sp)
 418  00cc 7d            	tnz	(x)
 419  00cd 26e6          	jrne	L702
 421  00cf               L512:
 422                     ; 101 	while( !USARTx_TC );
 424  00cf c65240        	ld	a,21056
 425  00d2 a540          	bcp	a,#64
 426  00d4 27f9          	jreq	L512
 427                     ; 102 }
 430  00d6 85            	popw	x
 431  00d7 81            	ret
 444                     	xdef	_Init_Uart2_Gpio
 445                     	xdef	_UART2_SendData8
 446                     	xdef	_Usart_Send_String
 447                     	xdef	_Usart_Send_Bytes
 448                     	xdef	_Init_Usart
 449                     	xref.b	c_lreg
 468                     	xref	c_ludv
 469                     	xref	c_rtol
 470                     	xref	c_uitolx
 471                     	xref	c_ltor
 472                     	end
