/*
zyx-ns
2017/4/13

-----  UART÷–∂œ≈‰÷√  -----
*/

#ifndef UART_IRQ_CONF_H
#define UART_IRQ_CONF_H


#define USART2_RECE_BUFFER_MAX_LEN   ( 100 )
struct USART2_RECE
{
    bool event;
    u8   cnt;
    u8   buffer[USART2_RECE_BUFFER_MAX_LEN];
};


extern struct USART2_RECE usart2_rece;


#endif
