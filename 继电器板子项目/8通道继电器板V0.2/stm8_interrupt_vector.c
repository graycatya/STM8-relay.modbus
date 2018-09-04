/*	BASIC INTERRUPT VECTOR TABLE FOR STM8 devices
 *	Copyright (c) 2007 STMicroelectronics
 */

typedef void @far (*interrupt_handler_t)(void);

struct interrupt_vector {
	unsigned char interrupt_instruction;
	interrupt_handler_t interrupt_handler;
};

@far @interrupt void NonHandledInterrupt (void)
{
	/* in order to detect unexpected events during development, 
	   it is recommended to set a breakpoint on the following instruction
	*/
	return;
}

extern void _stext();     /* startup routine */

/* 用户中断服务函数 */
//extern @far @interrupt void IRQ_RESET( void );
//extern @far @interrupt void IRQ_TRAP( void );
//extern @far @interrupt void IRQ_TLI( void );
//extern @far @interrupt void IRQ_AWU( void );
//extern @far @interrupt void IRQ_CLK( void );
//extern @far @interrupt void IRQ_EXTI_PORTA( void );
//extern @far @interrupt void IRQ_EXTI_PORTB( void );
//extern @far @interrupt void IRQ_EXTI_PORTC( void );
//extern @far @interrupt void IRQ_EXTI_PORTD( void );
//extern @far @interrupt void IRQ_EXTI_PORTE( void );
//extern @far @interrupt void IRQ_CAN_RX( void );
//extern @far @interrupt void IRQ_CAN_TX_ER_SC( void );
//extern @far @interrupt void IRQ_SPI( void );
//extern @far @interrupt void IRQ_TIM1_UPD_OVF( void );
//extern @far @interrupt void IRQ_TIM1_CAP_CMP( void );
//extern @far @interrupt void IRQ_TIM2_UPD_OVF( void );
//extern @far @interrupt void IRQ_TIM2_CAP_CMP( void );
//extern @far @interrupt void IRQ_TIM3_UPD_OVF( void );
//extern @far @interrupt void IRQ_TIM3_CAP_CMP( void );
//extern @far @interrupt void IRQ_UART1_TX( void );
//extern @far @interrupt void IRQ_UART1_RX( void );
//extern @far @interrupt void IRQ_I2C( void );
//extern @far @interrupt void IRQ_UART23_TX( void );
extern @far @interrupt void IRQ_UART23_RX( void );
//extern @far @interrupt void IRQ_ADC( void );
//extern @far @interrupt void IRQ_TIM4_UPD_OVF( void );
//extern @far @interrupt void IRQ_FLASH( void );

struct interrupt_vector const _vectab[] = {
	{0x82, (interrupt_handler_t)_stext}, /* reset */ /* IRQ_RESET */
	{0x82, NonHandledInterrupt}, /* trap  */ /* IRQ_TRAP */
	{0x82, NonHandledInterrupt}, /* irq0  */ /* IRQ_TLI */
	{0x82, NonHandledInterrupt}, /* irq1  */ /* IRQ_AWU */
	{0x82, NonHandledInterrupt}, /* irq2  */ /* IRQ_CLK */
	{0x82, NonHandledInterrupt}, /* irq3  */ /* IRQ_EXTI_PORTA */
	{0x82, NonHandledInterrupt}, /* irq4  */ /* IRQ_EXTI_PORTB */
	{0x82, NonHandledInterrupt}, /* irq5  */ /* IRQ_EXTI_PORTC */
	{0x82, NonHandledInterrupt}, /* irq6  */ /* IRQ_EXTI_PORTD */
	{0x82, NonHandledInterrupt}, /* irq7  */ /* IRQ_EXTI_PORTE */
	{0x82, NonHandledInterrupt}, /* irq8  */ /* IRQ_CAN_RX */
	{0x82, NonHandledInterrupt}, /* irq9  */ /* IRQ_CAN_TX_ER_SC */
	{0x82, NonHandledInterrupt}, /* irq10 */ /* IRQ_SPI */
	{0x82, NonHandledInterrupt}, /* irq11 */ /* IRQ_TIM1_UPD_OVF */
	{0x82, NonHandledInterrupt}, /* irq12 */ /* IRQ_TIM1_CAP_CMP */
	{0x82, NonHandledInterrupt}, /* irq13 */ /* IRQ_TIM2_UPD_OVF */
	{0x82, NonHandledInterrupt}, /* irq14 */ /* IRQ_TIM2_CAP_CMP */
	{0x82, NonHandledInterrupt}, /* irq15 */ /* IRQ_TIM3_UPD_OVF */
	{0x82, NonHandledInterrupt}, /* irq16 */ /* IRQ_TIM3_CAP_CMP */
	{0x82, NonHandledInterrupt}, /* irq17 */ /* IRQ_UART1_TX */
	{0x82, NonHandledInterrupt}, /* irq18 */ /* IRQ_UART1_RX */
	{0x82, NonHandledInterrupt}, /* irq19 */ /* IRQ_I2C */
	{0x82, NonHandledInterrupt}, /* irq20 */ /* IRQ_UART23_TX */
	{0x82, (interrupt_handler_t)IRQ_UART23_RX}, /* irq21 */ /*  */
	{0x82, NonHandledInterrupt}, /* irq22 */ /* IRQ_ADC */
	{0x82, NonHandledInterrupt}, /* irq23 */ /* IRQ_TIM4_UPD_OVF */
	{0x82, NonHandledInterrupt}, /* irq24 */ /* IRQ_FLASH */
	{0x82, NonHandledInterrupt}, /* irq25 */
	{0x82, NonHandledInterrupt}, /* irq26 */
	{0x82, NonHandledInterrupt}, /* irq27 */
	{0x82, NonHandledInterrupt}, /* irq28 */
	{0x82, NonHandledInterrupt}, /* irq29 */
};
