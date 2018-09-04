#include "zyxstm8.h"
#include "uart.h"
#include "uart_conf.h"
#include "relay.h"
#include "relay_conf.h"

/******************************************************************
 * ���ܣ���ʼ��UART1����
 * ��������
 * ���أ���
******************************************************************/
void Init_Uart2_Gpio( void )
{
	USART2_TxPORT->DDR |= 1<<USART2_TxPIN;  /* ��� */
	USART2_TxPORT->CR1 |= 1<<USART2_TxPIN;  /* ���� */
	USART2_RxPORT->DDR &= ~(1<<USART2_RxPIN);  /* ���� */
	USART2_RxPORT->CR1 |= 1<<USART2_RxPIN;     /* ���� */
}
/*===============================================================*/


/******************************************************************
 * ���ܣ���ʼ��UART1
 * ������ϵͳʱ��Ƶ�ʣ�������
 * ���أ���
******************************************************************/
void Init_Usart( u32 fclk, u16 baud )
{
	u8 brr2,brr1;
	u16 brr_temp;
	
	Init_Uart2_Gpio( ); 	/* ��ʼ��UARTx���� */
	
	brr_temp = fclk/baud;  		/* ���㲨���� 		*/
	brr2 = ( ( brr_temp>>8 ) & 0xf0 ) | ( brr_temp & 0x0f);
	brr1 = brr_temp>>4;
	
	UART2->BRR2 = brr2;
	UART2->BRR1 = brr1;
	
	UART2->CR2 = 0x0c;  		/* ʹ�ܷ��ͺͽ��� 	 */
	UART2->CR2 |= 1<<5;  		/* ʹ��UART1�����ж� */
	UART2->CR2 |= 1<<4;  		/* ʹ��UART1�����ж� */ 
	
}
/*===============================================================*/

/******************************************************************
 * ����: �������ݺ��� 
 * ����: ��
 * ����: ��
******************************************************************/
void UART2_SendData8( u8 Data )  
{
	#define UART2_TXE	( UART2->SR & ( 1<<7 ) )
	#define	UART2_TC	( UART2->SR & ( 1<<6 ) )
	while(!UART2_TXE);
	LED_PROT->ODR = ((1<<LED_PIN) | LED_PROT->IDR);
	UART2->DR = Data; //��Ĵ���д���ݡ� 
	//LED_PROT->ODR = (~(0<<LED_PIN) & LED_PROT->IDR);
	while(!UART2_TC);
} 


/******************************************************************
 * ���ܣ�UART1�����ֽ�����
 * ���������ڣ�����ָ�룬���ݳ���
 * ���أ���
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
 * ���ܣ�UART1�����ַ���
 * ���������ڣ�����ָ�룬���ݳ���
 * ���أ���
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

