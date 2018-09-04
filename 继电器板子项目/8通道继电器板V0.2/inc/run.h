#ifndef RUN_H
#define RUN_H

extern void Init( void );
extern void WrAsingleCoil( u8 *data , u8 len );
extern void WriteMultipleCoil( u8 *data , u8 len );
extern void ReadCoils( u8 *data , u8 len );

extern void WriteAsingleRegister( u8 *data , u8 len );
extern u16 Register_input( u16 bit );

extern void ReadInputRegister( u8 *data , u8 len );
extern void Register_function( void );

#endif