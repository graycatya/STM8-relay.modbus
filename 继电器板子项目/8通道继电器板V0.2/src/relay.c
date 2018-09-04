#include "zyxstm8.h"
#include "relay.h"
#include "relay_conf.h"


/************************************************************
 * 功能：初始化继电器引脚
 * 参数：*GPIO,pin
 * 返回：无
************************************************************/
void Init_Relay_Gpio( GPIO_TypeDef *GPIO, u8 pin )
{
    CFG->GCR |= 1; //SWIM口用做普通I/O口
    
    GPIO->DDR |= 1<<pin;	
    GPIO->CR1 |= 1<<pin;  /* 上拉 */
    GPIO->ODR |= 0<<pin;
}

/************************************************************
 * 功能：写继电器
 * 参数：code(00000000)代表8个继电器。
 * 返回：无
************************************************************/
void Write_Relay(u8 code)
{
	((code >> RELAY1) & 0x01) ?
	(RELAY1_PROT->ODR |= (1 << RELAY1_PIN)) : (RELAY1_PROT->ODR &= ~(1 << RELAY1_PIN));
	((code >> RELAY2) & 0x01) ?
	(RELAY2_PROT->ODR |= (1 << RELAY2_PIN)) : (RELAY2_PROT->ODR &= ~(1 << RELAY2_PIN));
	((code >> RELAY3) & 0x01) ?
	(RELAY3_PROT->ODR |= (1 << RELAY3_PIN)) : (RELAY3_PROT->ODR &= ~(1 << RELAY3_PIN));
	((code >> RELAY4) & 0x01) ?
	(RELAY4_PROT->ODR |= (1 << RELAY4_PIN)) : (RELAY4_PROT->ODR &= ~(1 << RELAY4_PIN));
	((code >> RELAY5) & 0x01) ?
	(RELAY5_PROT->ODR |= (1 << RELAY5_PIN)) : (RELAY5_PROT->ODR &= ~(1 << RELAY5_PIN));
	((code >> RELAY6) & 0x01) ?
	(RELAY6_PROT->ODR |= (1 << RELAY6_PIN)) : (RELAY6_PROT->ODR &= ~(1 << RELAY6_PIN));
	((code >> RELAY7) & 0x01) ?
	(RELAY7_PROT->ODR |= (1 << RELAY7_PIN)) : (RELAY7_PROT->ODR &= ~(1 << RELAY7_PIN));
	((code >> RELAY8) & 0x01) ?
	(RELAY8_PROT->ODR |= (1 << RELAY8_PIN)) : (RELAY8_PROT->ODR &= ~(1 << RELAY8_PIN));
}


/******************************************************************
 * 功能：读券继电器
 * 参数: 无
 * 返回：无
******************************************************************/
u8 Read_Relay( void )
{
	u8 data=0;
		data |= (!(RELAY1_PROT->IDR & (1 << RELAY1_PIN)) << RELAY1);
		data |= (!(RELAY2_PROT->IDR & (1 << RELAY2_PIN)) << RELAY2);
		data |= (!(RELAY3_PROT->IDR & (1 << RELAY3_PIN)) << RELAY3);
		data |= (!(RELAY4_PROT->IDR & (1 << RELAY4_PIN)) << RELAY4);
		data |= (!(RELAY5_PROT->IDR & (1 << RELAY5_PIN)) << RELAY5);
		data |= (!(RELAY6_PROT->IDR & (1 << RELAY6_PIN)) << RELAY6);
		data |= (!(RELAY7_PROT->IDR & (1 << RELAY7_PIN)) << RELAY7);
		data |= (!(RELAY8_PROT->IDR & (1 << RELAY8_PIN)) << RELAY8);
	return (data);
}

/************************************************************
 * 功能：初始化继电器
 * 参数：无
 * 返回：无
************************************************************/
void Init_Relay( void )
{
	Init_Relay_Gpio( RELAY1_PROT, RELAY1_PIN );
	Init_Relay_Gpio( RELAY2_PROT, RELAY2_PIN );
	Init_Relay_Gpio( RELAY3_PROT, RELAY3_PIN );
	Init_Relay_Gpio( RELAY4_PROT, RELAY4_PIN );
	Init_Relay_Gpio( RELAY5_PROT, RELAY5_PIN );
	Init_Relay_Gpio( RELAY6_PROT, RELAY6_PIN );
	Init_Relay_Gpio( RELAY7_PROT, RELAY7_PIN );
	Init_Relay_Gpio( RELAY8_PROT, RELAY8_PIN );
	Init_Relay_Gpio( LED_PROT, LED_PIN );
}



