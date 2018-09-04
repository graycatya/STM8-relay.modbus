/*
zyx-ns
2017/4/13

-----  UART1配置  -----
*/

#ifndef UART_CONF_H
#define UART_CONF_H

/* 宏定义引脚 */
#define USART1_TxPORT	( GPIOD )
#define USART1_TxPIN		( 5 )
#define USART1_RxPORT	( GPIOD )
#define USART1_RxPIN		( 6 )

#define USART2_TxPORT	( GPIOD )
#define USART2_TxPIN		( 5 )
#define USART2_RxPORT	( GPIOD )
#define USART2_RxPIN		( 6 )

#define USART3_TxPORT	( GPIOD )
#define USART3_TxPIN		( 5 )
#define USART3_RxPORT	( GPIOD )
#define USART3_RxPIN		( 6 )



/* UART1状态位 *//*
#define UART2_TXE	( UART2->SR & ( 1<<7 ) )
#define UART2_TC	( UART2->SR & ( 1<<6 ) )
#define UART2_RXNE	( UART2->SR & ( 1<<5 ) )*/


/* 使能UART1发送缓存区为空中断 */
//#define ENA_TIEN  ( UART1->CR2 |= 1<<7 )
/* 失能UART1发送缓存区为空中断 */
//#define DIS_TIEN  ( UART1->CR2 &= ~(1<<7) )


/* 使能UART1发送完成中断 */
#define ENA_TCIEN	( UART2->CR2 |= 1<<6 )
/* 失能UART1发送完成中断 */
#define DIS_TCIEN	( UART2->CR2 &= ~( 1<<6 ) )




#endif
