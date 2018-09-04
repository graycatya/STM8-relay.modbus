/*
zyx-ns
2017/4/15

-----  Modbus配置数据 -----
*/

#ifndef MODBUS_CONF_H
#define MODBUS_CONF_H


#define Broadcast_Addr (0x00) //广播地址


/***** 功能码 *****/
enum
{
	Read_Coil = 0x01, 					//读线圈
	Read_Inputdispersion = 0x02,		//读输入离散量
	Read_MultipleRegister = 0x03,		//读多个寄存器
	Read_InputRegister = 0x04,			//读输入寄存器
	Write_AsingleCoil = 0x05,			//写单个线圈
	Write_AsingleRegister = 0x06,		//写单个寄存器
	Write_MultipleCoil = 0x0f,			//写多个线圈
	Write_MultipleRegister = 0x10		//写多个寄存器
};


/***** 差错码 *****/
enum
{
	Slip_ReadCoil = 0x80,				//读线圈差错码
	Slip_ReadInputdispersion = 0x82,	//读输入离散量差错码
	Slip_ReadMultipleRegister = 0x83,	//读多个寄存器差错码
	Slip_ReadInputRegister = 0x84,		//读输入寄存器差错码
	Slip_WriteAsingleCoil = 0x85,		//写单个线圈差错码
	Slip_WriteAsingleRegister = 0x86,	//写单个寄存器差错码
	Slip_WriteMultipleCoil = 0x0f,		//写多个线圈差错码
	Slip_WriteMultipleRegister = 0x10	//写多个寄存器差错码
};


/***** 异常码 *****/
enum
{
	NO_Error = 0x00,				//正确
	Functioncode_Error = 0x01,		//功能码错误
	StartAddress_Error = 0x02,		//地址量错误
	AddrOutput_Error = 0x03,		//输出量错误
	WriteOutput_Error = 0x04		//输出错误
};






#endif
