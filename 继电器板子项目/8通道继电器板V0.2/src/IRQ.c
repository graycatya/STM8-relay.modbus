/*
zyx-ns
2017/4/8

-----  ���е��жϷ�������������ļ���  -----
*/

#include "zyxstm8.h"
#include "uart.h"
#include "uart_irq_conf.h"


/******************************************************************
 * ���ܣ�UART23_Rx���жϷ�����
 * ��������
 * ���أ���
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
 * ���ܣ�TIM4�жϷ�����
 * ��������
 * ���أ���
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
