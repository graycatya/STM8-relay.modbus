   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  53                     ; 18 @far @interrupt void IRQ_UART23_RX( void )
  53                     ; 19 {	
  54                     	switch	.text
  55  0000               f_IRQ_UART23_RX:
  58       00000002      OFST:	set	2
  59  0000 89            	pushw	x
  62                     ; 23     u8 USART2_SR = UART2->SR,
  64  0001 c65240        	ld	a,21056
  65  0004 6b02          	ld	(OFST+0,sp),a
  66                     ; 24        USART2_DR = UART2->DR;
  68  0006 c65241        	ld	a,21057
  69  0009 6b01          	ld	(OFST-1,sp),a
  70                     ; 27     if( USART2_SR & USART2_SR_RXNE )
  72  000b 7b02          	ld	a,(OFST+0,sp)
  73  000d a520          	bcp	a,#32
  74  000f 2714          	jreq	L33
  75                     ; 29         usart2_rece.buffer[(usart2_rece.cnt)++] = USART2_DR;
  77  0011 b601          	ld	a,_usart2_rece+1
  78  0013 97            	ld	xl,a
  79  0014 3c01          	inc	_usart2_rece+1
  80  0016 9f            	ld	a,xl
  81  0017 5f            	clrw	x
  82  0018 97            	ld	xl,a
  83  0019 7b01          	ld	a,(OFST-1,sp)
  84  001b e702          	ld	(_usart2_rece+2,x),a
  85                     ; 30         if( usart2_rece.cnt >= USART2_RECE_BUFFER_MAX_LEN)
  87  001d b601          	ld	a,_usart2_rece+1
  88  001f a164          	cp	a,#100
  89  0021 2502          	jrult	L33
  90                     ; 31             usart2_rece.cnt = 0;				
  92  0023 3f01          	clr	_usart2_rece+1
  93  0025               L33:
  94                     ; 34     if( USART2_SR & USART2_SR_IDEL )
  96  0025 7b02          	ld	a,(OFST+0,sp)
  97  0027 a510          	bcp	a,#16
  98  0029 2704          	jreq	L73
  99                     ; 36         usart2_rece.event = true;
 101  002b 35010000      	mov	_usart2_rece,#1
 102  002f               L73:
 103                     ; 38 }
 106  002f 5b02          	addw	sp,#2
 107  0031 80            	iret
 119                     	xdef	f_IRQ_UART23_RX
 120                     	xref.b	_usart2_rece
 139                     	end
