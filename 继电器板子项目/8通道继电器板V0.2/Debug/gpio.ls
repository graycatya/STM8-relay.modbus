   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
 292                     ; 10 void Conf_Port( GPIO_TypeDef *GPIOx, PIN pin, IO_DIR dir, IO_MODE mode, IO_CONF conf )
 292                     ; 11 {
 294                     	switch	.text
 295  0000               _Conf_Port:
 297  0000 89            	pushw	x
 298       00000000      OFST:	set	0
 301                     ; 12     GPIOx->DDR |= dir<<pin;
 303  0001 7b05          	ld	a,(OFST+5,sp)
 304  0003 905f          	clrw	y
 305  0005 9097          	ld	yl,a
 306  0007 7b06          	ld	a,(OFST+6,sp)
 307  0009 905d          	tnzw	y
 308  000b 2705          	jreq	L6
 309  000d               L01:
 310  000d 48            	sll	a
 311  000e 905a          	decw	y
 312  0010 26fb          	jrne	L01
 313  0012               L6:
 314  0012 ea02          	or	a,(2,x)
 315  0014 e702          	ld	(2,x),a
 316                     ; 13     GPIOx->CR1 |= mode<<pin;
 318  0016 7b05          	ld	a,(OFST+5,sp)
 319  0018 905f          	clrw	y
 320  001a 9097          	ld	yl,a
 321  001c 7b07          	ld	a,(OFST+7,sp)
 322  001e 905d          	tnzw	y
 323  0020 2705          	jreq	L21
 324  0022               L41:
 325  0022 48            	sll	a
 326  0023 905a          	decw	y
 327  0025 26fb          	jrne	L41
 328  0027               L21:
 329  0027 ea03          	or	a,(3,x)
 330  0029 e703          	ld	(3,x),a
 331                     ; 14     GPIOx->CR2 |= conf<<pin;
 333  002b 7b05          	ld	a,(OFST+5,sp)
 334  002d 905f          	clrw	y
 335  002f 9097          	ld	yl,a
 336  0031 7b08          	ld	a,(OFST+8,sp)
 337  0033 905d          	tnzw	y
 338  0035 2705          	jreq	L61
 339  0037               L02:
 340  0037 48            	sll	a
 341  0038 905a          	decw	y
 342  003a 26fb          	jrne	L02
 343  003c               L61:
 344  003c ea04          	or	a,(4,x)
 345  003e e704          	ld	(4,x),a
 346                     ; 15 }
 349  0040 85            	popw	x
 350  0041 81            	ret
 397                     ; 23 void Set_Pin( GPIO_TypeDef *GPIOx, PIN pin )
 397                     ; 24 {
 398                     	switch	.text
 399  0042               _Set_Pin:
 401  0042 89            	pushw	x
 402       00000000      OFST:	set	0
 405                     ; 25     GPIOx->ODR |= 1<<pin;
 407  0043 7b05          	ld	a,(OFST+5,sp)
 408  0045 905f          	clrw	y
 409  0047 9097          	ld	yl,a
 410  0049 a601          	ld	a,#1
 411  004b 905d          	tnzw	y
 412  004d 2705          	jreq	L42
 413  004f               L62:
 414  004f 48            	sll	a
 415  0050 905a          	decw	y
 416  0052 26fb          	jrne	L62
 417  0054               L42:
 418  0054 fa            	or	a,(x)
 419  0055 f7            	ld	(x),a
 420                     ; 26 }
 423  0056 85            	popw	x
 424  0057 81            	ret
 471                     ; 34 void Cls_Pin( GPIO_TypeDef *GPIOx, PIN pin )
 471                     ; 35 {
 472                     	switch	.text
 473  0058               _Cls_Pin:
 475  0058 89            	pushw	x
 476       00000000      OFST:	set	0
 479                     ; 36     GPIOx->ODR &= ~(1<<pin);
 481  0059 7b05          	ld	a,(OFST+5,sp)
 482  005b 905f          	clrw	y
 483  005d 9097          	ld	yl,a
 484  005f a601          	ld	a,#1
 485  0061 905d          	tnzw	y
 486  0063 2705          	jreq	L23
 487  0065               L43:
 488  0065 48            	sll	a
 489  0066 905a          	decw	y
 490  0068 26fb          	jrne	L43
 491  006a               L23:
 492  006a 43            	cpl	a
 493  006b f4            	and	a,(x)
 494  006c f7            	ld	(x),a
 495                     ; 37 }
 498  006d 85            	popw	x
 499  006e 81            	ret
 557                     ; 45 void Set_Pin_Level( GPIO_TypeDef *GPIOx, PIN pin, u8 level )
 557                     ; 46 {
 558                     	switch	.text
 559  006f               _Set_Pin_Level:
 561  006f 89            	pushw	x
 562       00000000      OFST:	set	0
 565                     ; 47     ( level ) ? Set_Pin( GPIOx, pin ) : Cls_Pin( GPIOx, pin );
 567  0070 0d06          	tnz	(OFST+6,sp)
 568  0072 2709          	jreq	L04
 569  0074 7b05          	ld	a,(OFST+5,sp)
 570  0076 88            	push	a
 571  0077 adc9          	call	_Set_Pin
 573  0079 5b01          	addw	sp,#1
 574  007b 2007          	jra	L24
 575  007d               L04:
 576  007d 7b05          	ld	a,(OFST+5,sp)
 577  007f 88            	push	a
 578  0080 add6          	call	_Cls_Pin
 580  0082 5b01          	addw	sp,#1
 581  0084               L24:
 582                     ; 48 }
 585  0084 85            	popw	x
 586  0085 81            	ret
 599                     	xdef	_Set_Pin_Level
 600                     	xdef	_Cls_Pin
 601                     	xdef	_Set_Pin
 602                     	xdef	_Conf_Port
 621                     	end
