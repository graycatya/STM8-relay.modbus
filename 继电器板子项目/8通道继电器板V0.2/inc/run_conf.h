#ifndef RUN_CONF_H
#define RUN_CONF_H

/*****  写单线圈   *****/
#define RelayAddr (0x08)
#define AsingON   (0xFF00)
#define AsingOFF  (0x0000)

/*****  写多线圈   *****/
#define RelayAddrs (0x07)
#define RelayCount (0x01)

/*****   读线圈    *****/
#define ReadCoil   (15)


/*****   寄存器数量    *****/
#define TEL_table  (1) 
#define RegisterSite0 (0x00)
/*寄存器0模式*/
#define RegisterSite0_ZERO (0)
#define RegisterSite0_ONE  (1)


extern u8 register_block[TEL_table*2];


#endif