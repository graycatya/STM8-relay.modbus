#include "zyxstm8.h"
#include "uart.h"
#include "uart_conf.h"
#include "relay.h"
#include "relay_conf.h"

/******************************************************************
 * 功能：初始化UART1引脚
 * 参数：无
 * 返回：无
******************************************************************/
void Init_Uart2_Gpio( void )
{
	USART2_TxPORT->DDR |= 1<<USART2_TxPIN;  /* 输出 */
	USART2_TxPORT->CR1 |= 1<<USART2_TxPIN;  /* 推挽 */
	USART2_RxPORT->DDR &= ~(1<<USART2_RxPIN);  /* 输入 */
	USART2_RxPORT->CR1 |= 1<<USART2_RxPIN;     /* 上拉 */
}
/*===============================================================*/


/******************************************************************
 * 功能：初始化UART1
 * 参数：系统时钟频率，波特率
 * 返回：无
******************************************************************/
void Init_Usart( u32 fclk, u16 baud )
{
	u8 brr2,brr1;
	u16 brr_temp;
	
	Init_Uart2_Gpio( ); 	/* 初始化UARTx引脚 */
	
	brr_temp = fclk/baud;  		/* 计算波特率 		*/
	brr2 = ( ( brr_temp>>8 ) & 0xf0 ) | ( brr_temp & 0x0f);
	brr1 = brr_temp>>4;
	
	UART2->BRR2 = brr2;
	UART2->BRR1 = brr1;
	
	UART2->CR2 = 0x0c;  		/* 使能发送和接收 	 */
	UART2->CR2 |= 1<<5;  		/* 使能UART1接收中断 */
	UART2->CR2 |= 1<<4;  		/* 使能UART1空闲中断 */ 
	
}
/*===============================================================*/

/******************************************************************
 * 功能: 发送数据函数 
 * 参数: 无
 * 返回: 无
******************************************************************/
void UART2_SendData8( u8 Data )  
{
	#define UART2_TXE	( UART2->SR & ( 1<<7 ) )
	#define	UART2_TC	( UART2->SR & ( 1<<6 ) )
	while(!UART2_TXE);
	LED_PROT->ODR = ((1<<LED_PIN) | LED_PROT->IDR);
	UART2->DR = Data; //向寄存器写数据。 
	//LED_PROT->ODR = (~(0<<LED_PIN) & LED_PROT->IDR);
	while(!UART2_TC);
} 


/******************************************************************
 * 功能：UART1发送字节数据
 * 参数：串口，数据指针，数据长度
 * 返回：无
******************************************************************/
void Usart_Send_Bytes( u8 *data, u8 length )
{
	
	#define USARTx_TXE	( UART2->SR & (1<<7) )
	#define USARTx_TC	( UART2->SR & (1<<6) )

	while( length-- ){
		LED_PROT->ODR = ((1<<LED_PIN) | LED_PROT->IDR);
		while( !USARTx_TXE );
		UART2->DR = *(data++);
	}
	//LED_PROT->ODR = ((0<<LED_PIN) | LED_PROT->IDR);
	while( !USARTx_TC );
}
/*===============================================================*/


/******************************************************************
 * 功能：UART1发送字符串
 * 参数：串口，数据指针，数据长度
 * 返回：无
******************************************************************/
void Usart_Send_String( char *string )
{
	#define USARTx_TXE	( UART2->SR & (1<<7) )
	#define USARTx_TC	  ( UART2->SR & (1<<6) )

	while( *string != '\0' ){
		while( !USARTx_TXE );
		UART2->DR = *(string++);
	}
	while( !USARTx_TC );
}
/*===============================================================*/

