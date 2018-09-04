/*
zyx-ns
2017/4/6

-----  uart  -----
*/

#ifndef UART_H
#define UART_H



extern void Init_Usart(  unsigned long fclk, unsigned short baud );
extern void Usart_Send_Bytes(  unsigned char *data, unsigned char length );
extern void Usart_Send_String(  char *string );
extern void UART2_SendData8( u8 Data );


#endif