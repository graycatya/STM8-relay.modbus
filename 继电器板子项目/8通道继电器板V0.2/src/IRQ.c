/*
zyx-ns
2017/4/8

-----  所有的中断服务函数都在这个文件中  -----
*/

#include "zyxstm8.h"
#include "uart.h"
#include "uart_irq_conf.h"


/******************************************************************
 * 功能：UART23_Rx的中断服务函数
 * 参数：无
 * 返回：无
******************************************************************/
@far @interrupt void IRQ_UART23_RX( void )
{	
    #define USART2_SR_RXNE  ( 1<<5 )
	#define USART2_SR_IDEL  ( 1<<4 )
    
    u8 USART2_SR = UART2->SR,
       USART2_DR = UART2->DR;
			 
		//while(USART2_SR & USART2_SR_RXNE)
    if( USART2_SR & USART2_SR_RXNE )
    {
        usart2_rece.buffer[(usart2_rece.cnt)++] = USART2_DR;
        if( usart2_rece.cnt >= USART2_RECE_BUFFER_MAX_LEN)
            usart2_rece.cnt = 0;				
    }
    
    if( USART2_SR & USART2_SR_IDEL )
    {
        usart2_rece.event = true;
    }  
}

/******************************************************************
 * 功能：TIM4中断服务函数
 * 参数：无
 * 返回：无
******************************************************************//*
@near @interrupt void IRQ_TIM4_UPD_OVF( void )
{
	#define TIM4_UIF  ( TIM4->SR & 1 )
	#define clearUIF  ( TIM4->SR &= 0xfe )
	
	if( TIM4_UIF )
	{
		clearUIF;
		S_clk = !S_clk;
	}
}*/
