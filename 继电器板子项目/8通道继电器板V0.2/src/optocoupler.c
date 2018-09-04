#include "zyxstm8.h"
#include "optocoupler.h"
#include "optocoupler_conf.h"


bool Delay( void )
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
 * ���ܣ���ʼ������( �������� )
 * ������*GPIO, pin
 * ���أ���
******************************************************************/
void Init_OptocouplerGpio( GPIO_TypeDef *GPIO, u8 pin )
{
	GPIO->DDR &= ~( 1<<pin );  /* ���� */
	GPIO->CR1 |= 1<<pin;  		 /* ���� */
}


/******************************************************************
 * ���ܣ���ʼ����������
 * ����: ��
 * ���أ���
******************************************************************/
void Init_Optocoupler( void )
{
	Init_OptocouplerGpio( OPTOCOUPLER1_PROT, OPTOCOUPLER1_PIN );
	Init_OptocouplerGpio( OPTOCOUPLER2_PROT, OPTOCOUPLER2_PIN );
	Init_OptocouplerGpio( OPTOCOUPLER3_PROT, OPTOCOUPLER3_PIN );
	Init_OptocouplerGpio( OPTOCOUPLER4_PROT, OPTOCOUPLER4_PIN );
	Init_OptocouplerGpio( OPTOCOUPLER5_PROT, OPTOCOUPLER5_PIN );
	Init_OptocouplerGpio( OPTOCOUPLER6_PROT, OPTOCOUPLER6_PIN );
	Init_OptocouplerGpio( OPTOCOUPLER7_PROT, OPTOCOUPLER7_PIN );
	Init_OptocouplerGpio( OPTOCOUPLER8_PROT, OPTOCOUPLER8_PIN );
}


/******************************************************************
 * ���ܣ���ȡ��������ֵ
 * ����: ��
 * ���أ���
******************************************************************/
u8 Read_Optocoupler( void )
{
	u8 data=0;
		data |= ((!(OPTOCOUPLER1_PROT->IDR & (1 << OPTOCOUPLER1_PIN))) << OPTOCOUPLER1);
		data |= ((!(OPTOCOUPLER2_PROT->IDR & (1 << OPTOCOUPLER2_PIN))) << OPTOCOUPLER2);
		data |= ((!(OPTOCOUPLER3_PROT->IDR & (1 << OPTOCOUPLER3_PIN))) << OPTOCOUPLER3);
		data |= ((!(OPTOCOUPLER4_PROT->IDR & (1 << OPTOCOUPLER4_PIN))) << OPTOCOUPLER4);
		data |= ((!(OPTOCOUPLER5_PROT->IDR & (1 << OPTOCOUPLER5_PIN))) << OPTOCOUPLER5);
		data |= ((!(OPTOCOUPLER6_PROT->IDR & (1 << OPTOCOUPLER6_PIN))) << OPTOCOUPLER6);
		data |= ((!(OPTOCOUPLER7_PROT->IDR & (1 << OPTOCOUPLER7_PIN))) << OPTOCOUPLER7);
		data |= ((!(OPTOCOUPLER8_PROT->IDR & (1 << OPTOCOUPLER8_PIN))) << OPTOCOUPLER8);
	return (~data);
}

/******************************************************************
 * ���ܣ���ȡ��������ֵ(ȥ����ʱ)
 * ����: ��
 * ���أ���
******************************************************************/
u8 Read_Optocouplerdeliy( void )
{
	u8 data = 0x00;
	if(Read_Optocoupler() != 0x00)
	{
		if(Delay())
		{
			data = Read_Optocoupler();
		}
	}
	return (data);
}


