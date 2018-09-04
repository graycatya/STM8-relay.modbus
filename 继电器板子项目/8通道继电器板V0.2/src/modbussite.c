#include "zyxstm8.h"
#include "modbussite.h"
#include "modbussite_conf.h"

bool Delay_0( void )
{
    #define CNT     ( 20000 )
    static u16 cnt = 0;
    
    if( ++cnt >= CNT )
    {
        cnt = 0;
        return true;
    }
    return false;
}


/******************************************************************
 * 功能：初始化地址引脚( 上拉输入 )
 * 参数：*GPIO, pin
 * 返回：无
******************************************************************/
void Init_AddrGpio( GPIO_TypeDef *GPIO, u8 pin )
{
	GPIO->DDR &= ~( 1<<pin );  /* 输入 */
	GPIO->CR1 |= 1<<pin;  		 /* 上拉 */
}



/******************************************************************
 * 功能：初始化modbus地址
 * 参数: 无
 * 返回：无
******************************************************************/
void Init_ModbusAddr( void )
{
	Init_AddrGpio( ADDR1_PROT, ADDR1_PIN );
	Init_AddrGpio( ADDR2_PROT, ADDR2_PIN );
	Init_AddrGpio( ADDR3_PROT, ADDR3_PIN );
	Init_AddrGpio( ADDR4_PROT, ADDR4_PIN );
	Init_AddrGpio( ADDR5_PROT, ADDR5_PIN );
	Init_AddrGpio( ADDR6_PROT, ADDR6_PIN );
}


/******************************************************************
 * 功能：读取modbus地址
 * 参数: 无
 * 返回：无
******************************************************************/
u8 Read_Addr( void )
{
	u8 addr=0;
	addr |= ((!(ADDR6_PROT->IDR & (1 << ADDR6_PIN))) << ADDR1);
	addr |= ((!(ADDR5_PROT->IDR & (1 << ADDR5_PIN))) << ADDR2);
	addr |= ((!(ADDR4_PROT->IDR & (1 << ADDR4_PIN))) << ADDR3);
	addr |= ((!(ADDR3_PROT->IDR & (1 << ADDR3_PIN))) << ADDR4);
	addr |= ((!(ADDR2_PROT->IDR & (1 << ADDR2_PIN))) << ADDR5);
	addr |= ((!(ADDR1_PROT->IDR & (1 << ADDR1_PIN))) << ADDR6);
	return (addr);
}


/******************************************************************
 * 功能：读取modbus地址(去抖延时)
 * 参数: 无
 * 返回：无
******************************************************************/
u8 Read_modbussite( void )
{
	u8 data = 0x00;
	if(Read_Addr() != 0x00)
	{
		if(Delay_0())
		{
			data = Read_Addr();
		}
	}
	return (data);
}










