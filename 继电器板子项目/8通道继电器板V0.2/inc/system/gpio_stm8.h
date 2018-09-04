/**********************
*       zyx-ns        *
*     2018/4/1`       *
*       GPIO          *
**********************/


#ifndef GPIO_H
#define GPIO_H


/*** I/O号 ***/
typedef enum
{
    PIN_0,
    PIN_1,
    PIN_2,
    PIN_3,
    PIN_4,
    PIN_5,
    PIN_6,
    PIN_7
} PIN;


/*** I/O方向 ***/
typedef enum
{
    IO_DIR_IN,
    IO_DIR_OUT
} IO_DIR;


/*** I/O模式 ***/
typedef enum
{
    IO_MODE_IN_FLOAT       = 0,
    IO_MODE_IN_PULL_UP,
    IO_MODE_OUT_OPEN_DRAIN = 0,
    IO_MODE_OUT_PUSH_PULL
} IO_MODE;


/*** I/O配置 ***/
typedef enum
{
    IO_CONF_IN_IRQ_ENA      = 0,
    IO_CONF_IN_IRQ_DIS,
    IO_CONF_OUT_SPEED_2M    = 0,
    IO_CONF_OUT_SPEED_10M
} IO_CONF;


extern void Conf_Port( GPIO_TypeDef *GPIOx, PIN pin, IO_DIR dir, IO_MODE mode, IO_CONF conf );
extern void Set_Pin( GPIO_TypeDef *GPIOx, PIN pin );
extern void Cls_Pin( GPIO_TypeDef *GPIOx, PIN pin );
extern void Set_Pin_Level( GPIO_TypeDef *GPIOx, PIN pin, u8 level );


#endif