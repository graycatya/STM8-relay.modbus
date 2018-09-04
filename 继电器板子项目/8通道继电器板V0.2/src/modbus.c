#include "zyxstm8.h"
#include "modbus.h"
#include "modbus_conf.h"
#include "uart_irq_conf.h"
#include "uart.h"
#include "CRC16.h"
#include "string.h"
#include "run.h"
#include "run_conf.h"


struct USART2_RECE usart2_rece;

u8 register_block[TEL_table*2];

/******************************************************************
 * ���ܣ�modbus���ݷ���
 * ����: ��
 * ���أ���
******************************************************************/
void Modbus_Analyze( u8 location )
{
	u16 crc_16; //CRC16У��
	u8 *Dispose_data;
		if( usart2_rece.event )
		{
			usart2_rece.event = false;
			Dispose_data = usart2_rece.buffer;
			
			if( Dispose_data[0] == Broadcast_Addr ) return; //�㲥��������
			
			if( location ==  Dispose_data[0] ) //��ַ���ж�
			{
				
				if(Modbus_Crc( Dispose_data, usart2_rece.cnt )) //CRCУ��
				{
					Functional_analysis( Dispose_data );
				}
				
			}
			usart2_rece.cnt = 0;
		}
}

/******************************************************************
 * ���ܣ�modbus���ܷ���
 * ����: ��
 * ���أ���
******************************************************************/
void Functional_analysis( u8 *data )
{
	switch(data[1])
	{
		case(Read_Coil):
			{
				ReadCoils( data , usart2_rece.cnt );
				break;
			}
		case(Read_InputRegister):
			{
				ReadInputRegister( data, usart2_rece.cnt );
				break;
			}
		case(Write_AsingleCoil):
			{
				if( Register_input( RegisterSite0 ) == RegisterSite0_ZERO )
					WrAsingleCoil( data , usart2_rece.cnt);
				break;
			}
		case(Write_AsingleRegister):
			{
				WriteAsingleRegister( data , usart2_rece.cnt );
				//Usart_Send_Bytes( data, usart2_rece.cnt );
				break;
			}
		case(Write_MultipleCoil):
			{
				if( Register_input( RegisterSite0 ) == RegisterSite0_ZERO )
					WriteMultipleCoil( data , usart2_rece.cnt );
				break;
			}
		case(Write_MultipleRegister):
			{
				Usart_Send_Bytes( data, usart2_rece.cnt );
				break;
			}
		default: 
		{
			break;
		}
	}
}




/******************************************************************
 * ���ܣ����ش�����
 * ����: ��
 * ���أ���
******************************************************************/
u8* Returns_error( u8 *data ,u8 error_fun, u8 error)
{
	u8 *data_treating;
	u16 data_crc;
	data_treating[0] = data[0];
	data_treating[1] = data[1];
	data_treating[2] = error_fun;
	data_treating[3] = error;
	return data_treating;
}



/******************************************************************
 * ���ܣ�modbusCRCУ��
 * ����: ��
 * ���أ���
******************************************************************/
bool Modbus_Crc( u8 *data, u8 data_len)
{
	u16 crc16,data_crc;
	crc16 = crc16_modbus( data, data_len-2);
	data_crc = (u16)((data[data_len-2]<<8) | data[data_len-1]);
	
	if(data_crc == crc16)
		{
			return true;
		}
		
	return false;
}




