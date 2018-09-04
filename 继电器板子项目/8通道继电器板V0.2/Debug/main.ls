   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  61                     ; 16 void delayms( u16 k)
  61                     ; 17 {
  63                     	switch	.text
  64  0000               _delayms:
  66  0000 89            	pushw	x
  67  0001 5204          	subw	sp,#4
  68       00000004      OFST:	set	4
  71                     ; 19 	for(x = 0; x < k; x++)
  73  0003 5f            	clrw	x
  74  0004 1f01          	ldw	(OFST-3,sp),x
  76  0006 2018          	jra	L34
  77  0008               L73:
  78                     ; 20 		for(y = 0; y < 500; y++);
  80  0008 5f            	clrw	x
  81  0009 1f03          	ldw	(OFST-1,sp),x
  82  000b               L74:
  86  000b 1e03          	ldw	x,(OFST-1,sp)
  87  000d 1c0001        	addw	x,#1
  88  0010 1f03          	ldw	(OFST-1,sp),x
  91  0012 1e03          	ldw	x,(OFST-1,sp)
  92  0014 a301f4        	cpw	x,#500
  93  0017 25f2          	jrult	L74
  94                     ; 19 	for(x = 0; x < k; x++)
  96  0019 1e01          	ldw	x,(OFST-3,sp)
  97  001b 1c0001        	addw	x,#1
  98  001e 1f01          	ldw	(OFST-3,sp),x
  99  0020               L34:
 102  0020 1e01          	ldw	x,(OFST-3,sp)
 103  0022 1305          	cpw	x,(OFST+1,sp)
 104  0024 25e2          	jrult	L73
 105                     ; 21 }
 108  0026 5b06          	addw	sp,#6
 109  0028 81            	ret
 148                     ; 24 void main( void )
 148                     ; 25 {
 149                     	switch	.text
 150  0029               _main:
 152  0029 88            	push	a
 153       00000001      OFST:	set	1
 156                     ; 27 	Init();
 158  002a cd0000        	call	_Init
 160                     ; 28 	addr = Read_Addr();
 162  002d cd0000        	call	_Read_Addr
 164  0030 6b01          	ld	(OFST+0,sp),a
 165                     ; 29 	UART2_SendData8( addr );
 167  0032 7b01          	ld	a,(OFST+0,sp)
 168  0034 cd0000        	call	_UART2_SendData8
 170                     ; 30 	UART2_SendData8( 0x00 );
 172  0037 4f            	clr	a
 173  0038 cd0000        	call	_UART2_SendData8
 175  003b               L37:
 176                     ; 33 		LED_PROT->ODR = (~(1<<LED_PIN) & LED_PROT->IDR);
 178  003b c65010        	ld	a,20496
 179  003e a4fd          	and	a,#253
 180  0040 c7500f        	ld	20495,a
 181                     ; 34 		Modbus_Analyze( addr );
 183  0043 7b01          	ld	a,(OFST+0,sp)
 184  0045 cd0000        	call	_Modbus_Analyze
 186                     ; 35 		Register_function();
 188  0048 cd0000        	call	_Register_function
 191  004b 20ee          	jra	L37
 204                     	xdef	_main
 205                     	xdef	_delayms
 206                     	xref	_UART2_SendData8
 207                     	xref	_Read_Addr
 208                     	xref	_Register_function
 209                     	xref	_Init
 210                     	xref	_Modbus_Analyze
 229                     	end
