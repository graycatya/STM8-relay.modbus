#include "zyxstm8.h"
#include "uart.h"
#include "uart_irq_conf.h"
#include "modbus.h"
#include "run.h"
#include "run_conf.h"
#include "modbus_conf.h"
#include "optocoupler.h"
#include "optocoupler_conf.h"
#include "modbussite.h"
#include "modbussite_conf.h"
#include "relay.h"
#include "relay_conf.h"
#include "crc16.h"

bool Delays( void )
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

/*************************************/
u8 AsingleCoil_map( u16 addr);
/*************************************/

/*************************************/
void More_Pincount( u16 strat_add , u16 last_add , u8 pin_put );
/*************************************/

/*************************************/
u16 ReadCoil_input( u16 start_addr, u16 input_addr);
/*************************************/

/*************************************/
void init_Register( void );
void Register_state(u16 readdr, u8 state_h, u8 state_l);
/*************************************/

/******************************************************************
 * 功能:初始化
 * 参数:
 * 返回:
******************************************************************/
void Init( void )
{
	_asm("sim");  /* 关闭中断 */
	
  	CLK->CKDIVR = 0;
		Init_Usart( 16000000, 9600 );
    Init_ModbusAddr();
		Init_Optocoupler();
		Init_Relay();
    init_Register();
	_asm("rim");  /* 开启中断 */
}


/******************************************************************
 * 功能:写单个线圈
 * 参数:
 * 返回:
******************************************************************/
void WrAsingleCoil( u8 *data , u8 len )
{
	u16 addr_qt,input_value; //地址数量,输出值
		addr_qt = ((u16)data[2]<<8) | data[3];
		input_value = (((u16)data[4])<<8) | data[5];
		if( addr_qt < RelayAddr & (input_value == AsingON | input_value == AsingOFF) )
		{
			if(input_value == AsingON) //正确控制
			{
				Write_Relay( AsingleCoil_map( addr_qt ) | ~Read_Relay());
			}
			else 
			{
				Write_Relay( ~AsingleCoil_map( addr_qt ) & ~Read_Relay() );
			}
			Usart_Send_Bytes( data, len );
		}
	 else //错误码
		{
			u8 Err_addr[5];
			u16 Err_crc;
			Err_addr[0] = data[0];
			Err_addr[1] = Slip_WriteAsingleCoil;
			if( addr_qt >= RelayAddr )
				{
					Err_addr[2] = StartAddress_Error;
				}
			else
				{
					Err_addr[2] = AddrOutput_Error;
				}
			Err_crc = crc16_modbus( Err_addr , 3);
			Err_addr[3] = (u8)(Err_crc>>8);
			Err_addr[4] = (u8)Err_crc;
			Usart_Send_Bytes( Err_addr , 5 );
		}
}
/*地址映射-接口*/
u8 AsingleCoil_map( u16 addr)
	{
		switch(addr)
			{
				case(0x0000):{ return (0x01); }
				case(0x0001):{ return (0x02); }
				case(0x0002):{ return (0x04); }
				case(0x0003):{ return (0x08); }
				case(0x0004):{ return (0x10); }
				case(0x0005):{ return (0x20); }
				case(0x0006):{ return (0x40); }
				case(0x0007):{ return (0x80); }
			}
			return 0;
	}
/*****************************************************************************/




/*****************************************************************************/
/******************************************************************
 * 功能:写多个线圈
 * 参数:
 * 返回:
******************************************************************/
void WriteMultipleCoil( u8 *data , u8 len )
	{
		u16 start_addr=0, input_addr=0; //地址数量
		u8 input_bytes, pin_count; //输出数量
		start_addr = ((u16)data[2]<<8) | ((u16)data[3]);
		input_addr = ((u16)data[4]<<8) | ((u16)data[5]);
		input_bytes = data[6];
		pin_count = data[7];
		if( (start_addr <= input_addr & input_addr <= RelayAddrs)  & input_bytes == RelayCount )
			{
				u8 true_data[8];
				u16 crc;
				true_data[0] = data[0];
				true_data[1] = data[1];
				true_data[2] = data[2];
				true_data[3] = data[3];
				true_data[4] = data[4];
				true_data[5] = data[5];
				crc = crc16_modbus( true_data , 6);
				true_data[6] = (u8)(crc>>8);
				true_data[7] = (u8)crc;
				More_Pincount( start_addr , input_addr , ~pin_count );
				Usart_Send_Bytes( true_data, 8 );
			}
		else
			{
				u8 Err_addr[5];
				u16 Err_crc;
				Err_addr[0] = data[0];
				Err_addr[1] = Slip_WriteMultipleCoil;
				if( input_bytes != RelayCount )
					{
						Err_addr[2] = AddrOutput_Error;
					}
				else
					{
						Err_addr[2] = StartAddress_Error;
					}
				Err_crc = crc16_modbus( Err_addr , 3);
				Err_addr[3] = (u8)(Err_crc>>8);
				Err_addr[4] = (u8)Err_crc;
				Usart_Send_Bytes(  Err_addr , 5 );
			}
	}


/******************************************************************
 * 功能:多线圈控制
 * 参数:
 * 返回:
******************************************************************/
void More_Pincount( u16 strat_add , u16 last_add , u8 pin_put )
	{
		u16 x = 0;
		u8 data = 0,data_pin;
		data_pin = ~Read_Relay();
		for(x = 0; x <= RelayAddrs; x++)  
			{
				if(x < strat_add)
				{
					data |= data_pin & (1<<x);
				}
				else if(x >= strat_add & x<= last_add)
				{
					data |= ~pin_put & (1<<x);
				}
				else
				{
					data |= data_pin & (1<<x);
				}
			}
		data = data ;
		Write_Relay(data);
	}
	
	
/*****************************************************************************/


/*****************************************************************************/
/******************************************************************
 * 功能:读线圈
 * 参数:
 * 返回:
******************************************************************/
void ReadCoils( u8 *data , u8 len )
{
	u16 start_addr=0, input_addr=0; //地址数量
	start_addr = ((u16)data[2]<<8) | ((u16)data[3]);
	input_addr = ((u16)data[4]<<8) | ((u16)data[5]);
	if( start_addr < input_addr & input_addr <= ReadCoil  )
		{
				u8 true_data[7];
				u16 data_bit,crc;
				true_data[0] = data[0];
				true_data[1] = data[1];
				true_data[2] = 0x02;
				data_bit = ReadCoil_input( start_addr, input_addr );
				true_data[3] = (data_bit>>8);
				true_data[4] = (u8)data_bit;
				crc = crc16_modbus( true_data , 5 );
				true_data[5] = (u8)(crc>>8);
				true_data[6] = (u8)crc;
				Usart_Send_Bytes( true_data , 7 );
		}
	else
		{
				u8 Err_addr[5];
				u16 Err_crc;		
				Err_addr[0] = data[0];
				Err_addr[1] = Slip_ReadCoil;
				Err_addr[2] = StartAddress_Error;
				Err_crc = crc16_modbus( Err_addr , 3 );
				Err_addr[3] = (u8)(Err_crc>>8);
				Err_addr[4] = (u8)Err_crc;
				Usart_Send_Bytes( Err_addr , 5 );
		}
}

/******************************************************************
 * 功能:读线圈地址换算
 * 参数:
 * 返回:
******************************************************************/
u16 ReadCoil_input( u16 start_addr, u16 input_addr)
{
	u16 data=0;
	u8 x;
	 for(x=start_addr; x<input_addr + 1; x++)
		{
			if( x <= ReadCoil/2 )
				{
					data |= ~Read_Relay() & (1<<x);
				}
			else
				{
					data |= ((~Read_Optocoupler())<<8) & (1<<x);
				}
		}
		return data;
}
/*****************************************************************************/


/*****************************************************************************/
/******************************************************************
 * 功能:写寄存器
 * 参数:
 * 返回:
******************************************************************/
void WriteAsingleRegister( u8 *data , u8 len )
{
	u16 addr_qt,input_value; //寄存器数量,输出值
		addr_qt = ((u16)data[2]<<8) | data[3];
		input_value = (((u16)data[4])<<8) | data[5];
		if( addr_qt < TEL_table & input_value <= RegisterSite0_ONE )
		{
			Register_state(addr_qt, data[4], data[5]);
			Usart_Send_Bytes( data, len );
		}
		else
		{
				u8 Err_addr[5];
				u16 Err_crc;
				Err_addr[0] = data[0];
				Err_addr[1] = Slip_WriteAsingleRegister;
				if( addr_qt >= TEL_table )
					{
						Err_addr[2] = AddrOutput_Error;
					}
				else
					{
						Err_addr[2] = WriteOutput_Error;
					}
				Err_crc = crc16_modbus( Err_addr , 3);
				Err_addr[3] = (u8)(Err_crc>>8);
				Err_addr[4] = (u8)Err_crc;
				Usart_Send_Bytes(  Err_addr , 5 );
		}
}

/******************************************************************
 * 功能:读寄存器
 * 参数:
 * 返回:
******************************************************************/
void ReadInputRegister( u8 *data , u8 len )
{
		u16 start_addr=0, input_addr=0; //地址数量
	start_addr = ((u16)data[2]<<8) | ((u16)data[3]);
	input_addr = ((u16)data[4]<<8) | ((u16)data[5]);
	if( start_addr < TEL_table & input_addr <= TEL_table  & input_addr > RegisterSite0)
		{
				u8 true_data[7];
				u16 data_bit,crc;
				true_data[0] = data[0];
				true_data[1] = data[1];
				true_data[2] = 2*input_addr;
				data_bit = Register_input( RegisterSite0 );
				true_data[3] = (u8)(data_bit>>8);
				true_data[4] = (u8)data_bit;
				crc = crc16_modbus( true_data , 5 );
				true_data[5] = (u8)(crc>>8);
				true_data[6] = (u8)crc;
				Usart_Send_Bytes( true_data, 7 );
				
		}
	else
		{
				u8 Err_addr[5];
				u16 Err_crc;		
				Err_addr[0] = data[0];
				Err_addr[1] = Slip_ReadInputRegister;
				Err_addr[2] = StartAddress_Error;
				Err_crc = crc16_modbus( Err_addr , 3 );
				Err_addr[3] = (u8)(Err_crc>>8);
				Err_addr[4] = (u8)Err_crc;
				Usart_Send_Bytes( Err_addr , 5 );
		}
}




/******************************************************************
 * 功能:写入寄存器
 * 参数:
 * 返回:
******************************************************************/
void Register_state(u16 readdr, u8 state_h, u8 state_l)
{
	u16 data = readdr*2;
	register_block[data] = state_h;
	register_block[data+1] = state_l;
}


/******************************************************************
 * 功能: 寄存器初始化
 * 参数:
 * 返回:
******************************************************************/
void init_Register( void )
{
	u16 x;
	for(x = 0; x <TEL_table*2; x++)
			register_block[x] = 0x00;
}


/******************************************************************
 * 功能: 寄存器读出
 * 参数:
 * 返回:
******************************************************************/
u16 Register_input( u16 bit )
{
	u16 data = 0;
	data = (u16)register_block[bit]<<8;
	data |= register_block[bit+1];
	return data;
}

/******************************************************************
 * 功能: 寄存器功能
 * 参数:
 * 返回:
******************************************************************/
void Register_function( void )
{
	if(Register_input( RegisterSite0 ) == RegisterSite0_ONE)
	{
		if(Delays(  ) == true)
		{
					Write_Relay(~Read_Optocoupler());
		}
	}
}
/*****************************************************************************/