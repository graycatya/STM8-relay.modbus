/*
zyx-ns
2017/4/14

-----  MODBUS  -----
*/

#ifndef MODBUS_H
#define MODBUS_H


extern void Modbus_Analyze( u8 location );
extern bool Modbus_Crc( u8 *data, u8 data_len);
extern u8* Returns_error( u8 *data ,u8 error_fun, u8 error);
extern void Functional_analysis( u8 *data );
extern u8 Function_error( u8 data);

#endif
