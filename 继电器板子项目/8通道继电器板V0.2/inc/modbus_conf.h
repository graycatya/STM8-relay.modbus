/*
zyx-ns
2017/4/15

-----  Modbus�������� -----
*/

#ifndef MODBUS_CONF_H
#define MODBUS_CONF_H


#define Broadcast_Addr (0x00) //�㲥��ַ


/***** ������ *****/
enum
{
	Read_Coil = 0x01, 					//����Ȧ
	Read_Inputdispersion = 0x02,		//��������ɢ��
	Read_MultipleRegister = 0x03,		//������Ĵ���
	Read_InputRegister = 0x04,			//������Ĵ���
	Write_AsingleCoil = 0x05,			//д������Ȧ
	Write_AsingleRegister = 0x06,		//д�����Ĵ���
	Write_MultipleCoil = 0x0f,			//д�����Ȧ
	Write_MultipleRegister = 0x10		//д����Ĵ���
};


/***** ����� *****/
enum
{
	Slip_ReadCoil = 0x80,				//����Ȧ�����
	Slip_ReadInputdispersion = 0x82,	//��������ɢ�������
	Slip_ReadMultipleRegister = 0x83,	//������Ĵ��������
	Slip_ReadInputRegister = 0x84,		//������Ĵ��������
	Slip_WriteAsingleCoil = 0x85,		//д������Ȧ�����
	Slip_WriteAsingleRegister = 0x86,	//д�����Ĵ��������
	Slip_WriteMultipleCoil = 0x0f,		//д�����Ȧ�����
	Slip_WriteMultipleRegister = 0x10	//д����Ĵ��������
};


/***** �쳣�� *****/
enum
{
	NO_Error = 0x00,				//��ȷ
	Functioncode_Error = 0x01,		//���������
	StartAddress_Error = 0x02,		//��ַ������
	AddrOutput_Error = 0x03,		//���������
	WriteOutput_Error = 0x04		//�������
};






#endif
