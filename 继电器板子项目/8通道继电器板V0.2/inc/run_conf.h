#ifndef RUN_CONF_H
#define RUN_CONF_H

/*****  д����Ȧ   *****/
#define RelayAddr (0x08)
#define AsingON   (0xFF00)
#define AsingOFF  (0x0000)

/*****  д����Ȧ   *****/
#define RelayAddrs (0x07)
#define RelayCount (0x01)

/*****   ����Ȧ    *****/
#define ReadCoil   (15)


/*****   �Ĵ�������    *****/
#define TEL_table  (1) 
#define RegisterSite0 (0x00)
/*�Ĵ���0ģʽ*/
#define RegisterSite0_ZERO (0)
#define RegisterSite0_ONE  (1)


extern u8 register_block[TEL_table*2];


#endif