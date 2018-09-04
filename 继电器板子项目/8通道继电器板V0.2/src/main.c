/*
zyx-ns
data

-----  main  -----
*/

#include "zyxstm8.h"
#include "modbus.h"
#include "run.h"
#include "modbussite.h"
#include "uart.h"
#include "relay.h"
#include "relay_conf.h"

void delayms( u16 k)
{
	u16 x,y;
	for(x = 0; x < k; x++)
		for(y = 0; y < 500; y++);
}


void main( void )
{
	u8 addr;
	Init();
	addr = Read_Addr();
	UART2_SendData8( addr );
	UART2_SendData8( 0x00 );
	while(1)
	{
		LED_PROT->ODR = (~(1<<LED_PIN) & LED_PROT->IDR);
		Modbus_Analyze( addr );
		Register_function();
		/*Write_Relay(0x01);
		delayms( 2000);
		Write_Relay(0x02);
		delayms( 2000);
		Write_Relay(0x04);
		delayms( 2000);
		Write_Relay(0x08);
		delayms( 2000);
		Write_Relay(0x10);
		delayms( 2000);
		Write_Relay(0x20);
		delayms( 2000);
		Write_Relay(0x40);
		delayms( 2000);
		Write_Relay(0x80);
		delayms( 2000);*/
	}
}