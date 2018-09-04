/*
zyx-ns
2017/3/27

-----  stm8ͷ�ļ�  -----
*/

/*
zyx-ns
2017/9/19

��
typedef enum
{
    FALSE = 0,
    TRUE = !FALSE
} BOOL;
Ϊ
typedef enum
{
    false = 0,
    true = !false
} bool;
*/

/*
��ͷ�ļ�������������
ADC1 
ADC2
AWU 
BKP 
BEEP
CLK
DM
beCAN
FLASH 
GPIO A-I
I2C
ITC
IWDG
RST
SPI
TIM 1-6
UART 1-3
WWDG
*/

#define STM8S105
/*	�������Ͷ��塣*/
#define u8 unsigned char
#define u16 unsigned short int
#define u32 unsigned long int
#define uc8 const u8
#define uc16 const u16
#define uc32 const u32
#define vu8 volatile u8
#define vu16 volatile u16
#define vu32 volatile u32
#define vuc8 const vu8
#define vuc16 const vu16
#define vuc32 const vu32


/* �����Ͷ��� */
typedef enum
{
    false = 0,
    true = !false
} bool;



/* ˫�ֽڼĴ���(Double Byte) *//*
typedef struct
{
	vu8 RH;	/* ��λ���ݼĴ��� *//*
	vu8 RL;	/* ��λ���ݼĴ��� *//*
} DB_TypeDef;
*/

/* GPIO���� */
/****************************************************************/
typedef struct
{
	vu8 ODR;	/* ����Ĵ��� */
	vu8 IDR;	/* ����Ĵ��� */
	vu8 DDR;	/* io����Ĵ��� */
	vu8 CR1;	/* ���ƼĴ���1 */
	vu8 CR2;	/* ���ƼĴ���2 */
} GPIO_TypeDef;


/* ADC1(10λA/Dת����) */
/****************************************************************/
#if defined(STM8S105) || defined(STM8S103) || defined(STM8S903) || defined(STM8AF626x)
typedef struct
{
	/*struct AdcDataBuffer_TypeDef *DB[10];	/* ADC���ݻ���Ĵ���*/
	vu8 DB0RH;
	vu8 DB0RL;
	vu8 DB1RH;
	vu8 DB1RL;
	vu8 DB2RH;
	vu8 DB2RL;
	vu8 DB3RH;
	vu8 DB3RL;
	vu8 DB4RH;
	vu8 DB4RL;
	vu8 DB5RH;
	vu8 DB5RL;
	vu8 DB6RH;
	vu8 DB6RL;
	vu8 DB7RH;
	vu8 DB7RL;
	vu8 DB8RH;
	vu8 DB8RL;
	vu8 DB9RH;
	vu8 DB9RL;
	u8 RESERVED[12];
	vu8	CSR;	/* ADC1����/״̬�Ĵ��� */
	vu8 CR1;	/* ADC1���üĴ���1 */
	vu8 CR2;	/* ADC1���üĴ���2 */
	vu8 CR3;	/* ADC1���üĴ���3 */
	/*struct ADB_TypeDef *DR;	/* ADC1���ݼĴ��� */
	vu8 DRH;
	vu8 DRL;
	/*struct ADB_TypeDef *TDR;	/* ADC1ʩ���ش�����ʧ�ܼĴ��� */
	vu8 TDRH;
	vu8 TDRL;
	//struct ADB_TypeDef *HTR;	/* ADC1�����ż�ֵ�Ĵ��� */
	vu8 HTRH;
	vu8 HTRL;
	//struct ADB_TypeDef *LTR;	/* ADC1�����ż�ֵ�Ĵ��� */
	vu8 LTRH;
	vu8 LTRL;
	//struct ADB_TypeDef *AWSR;	/* ADC1ģ�⿴�Ź�״̬�Ĵ��� */
	vu8 AWSRH;
	vu8 AWSRL;
	//struct ADB_TypeDef *AWCR;	/* ADC1ģ�⿴�Ź����ƼĴ��� */
	vu8 AWCRH;
	vu8 AWCRL;
} ADC1_TypeDef;
#endif


/* ADC2 */
/****************************************************************/
#if defined(STM8S208) || defined(STM8S207) || defined(STM8AF52Ax) || defined(STM8AF62Ax)
typedef struct
{
	vu8 CSR;	/* ADC2����/״̬�Ĵ��� */
	vu8 CR1;	/* ADC2���ƼĴ���1 */
	vu8 CR2;	/* ADC2���ƼĴ���2 */
	u8 RESERVED;
	/*struct ADB_TypeDef *DR;		/* ADC2���ݼĴ��� */
	vu8 DRH;
	vu8 DRL;
	/*struct ADB_TypeDef *TDR;	/* ADC2ʩ���ش�����ʧ�ܼĴ��� */
	vu8 TDRH;
	vu8 TDRL;
} ADC2_TypeDef;
#endif


/* �Զ����� */
/****************************************************************/
typedef struct 
{
	vu8 CSR;	/* AWU����/״̬�Ĵ��� */
	vu8 APR;	/* AWU�첽Ԥ��Ƶ�Ĵ��� */
	vu8 TBR;	/* AWUʱ��ѡ��Ĵ��� */
} AWU_TypeDef;


/* ������ */
/****************************************************************/
typedef struct
{
	vu8 CSR;	/* BEEP����/״̬�Ĵ���*/
} BEEP_TypeDef;


/* ȫ�����üĴ���(CFG) */
/****************************************************************/
typedef struct
{
	vu8 GCR;
} CFG_TypeDef;	/* ȫ�����üĴ��� */


/* ʱ�ӿ��� */
/****************************************************************/
typedef struct
{
	vu8 ICKR;		/* �ڲ�ʱ�ӿ��ƼĴ��� */
	vu8 ECKR;		/* �ⲿʱ�ӿ��ƼĴ��� */
	u8 RESERVED;
	vu8 CMSR;		/* ��ʱ��״̬�Ĵ��� */
	vu8 SWR;		/* ��ʱ���л��Ĵ��� */
	vu8 SWCR;		/* �л����ƼĴ��� */
	vu8 CKDIVR;		/* ʱ�ӷ�Ƶ�Ĵ��� */
	vu8 PCKENR1;	/* ����ʱ���ſؼĴ���1 */
	vu8 CSSR;		/* ʱ�Ӱ�ȫϵͳ�Ĵ���*/
	vu8 CCOR;		/* ������ʱ������Ĵ��� */
	vu8 PCKENR2;	/* ����ʱ���ſؼĴ���2 */
	vu8 CANCCR;		/* CANʱ�ӿ��ƼĴ��� */
	vu8 HSITRIMR;	/* �ڲ�ʱ�������Ĵ��� */
	vu8 SWIMCCR;	/* SWIMʱ�ӿ��ƼĴ��� */
} CLK_TypeDef;


/* �ⲿ�жϿ��ƼĴ��� */
/****************************************************************/
typedef struct
{
	vu8 CR1;	/* �ⲿ�жϿ��ƼĴ���1 */
	vu8 CR2;	/* �ⲿ�жϿ��ƼĴ���2 */
} EXTI_TypeDef;


/* Flash */
/****************************************************************/
typedef struct
{
	vu8 CR1;	/* Flash���ƼĴ���1 */
	vu8 CR2;	/* Flash���ƼĴ���2 */
	vu8 NCR2;	/* Flash�������ƼĴ���2 */
	vu8 FPR;	/* Falsh�����Ĵ��� */
	vu8 NFPR;	/* Flash���������Ĵ��� */
	vu8 IAPSR;	/* Flash��Ӧ�ñ��״̬�Ĵ��� */
	u8 RESERVED[2];	/* �������� */
	vu8 PUKR;	/* Flash�����ڴ�Ᵽ���Ĵ��� */
	u8 RESERVED0;
	vu8 DUKR;	/* EEPROM���ݽⱣ���Ĵ��� */
} FLASH_TypeDef;

/* I2C(I2C���߽ӿ�) */
/****************************************************************/
typedef struct
{
	vu8 CR1;	/* I2C���ƼĴ���1 */
	vu8 CR2;	/* I2C���ƼĴ���2 */
	vu8 FREQR;	/* I2CƵ�ʼĴ��� */
	vu8 QARL;	/* I2C�����ַ�Ĵ�����λ */
	vu8 QARH;	/* I2C�����ַ�Ĵ�����λ */
	u8 RESERVED;
	vu8 DR;		/* I2C���ݼĴ��� */
	vu8 SR1;	/* I2C״̬�Ĵ���1 */
	vu8 SR2;	/* I2C״̬�Ĵ���2 */
	vu8 SR3;	/* I2C״̬�Ĵ���3 */
	vu8 ITR;	/* I2C�жϿ��ƼĴ��� */
	vu8 CCRL;	/* I2Cʱ�ӿ��ƼĴ�����λ */
	vu8 CCRH;	/* I2Cʱ�ӿ��ƼĴ�����λ */
	vu8 TRISER;	/* I2C����ʱ��Ĵ��� */
	vu8 PECR;	/* I2C���ݰ�������Ĵ��� */
} I2C_TypeDef;


/* �ж�������ȼ��Ĵ���(ITC) */
/****************************************************************/
typedef struct
{
	vu8 SPR[8];	/* �ж�������ȼ��Ĵ��� */
} ITC_TypeDef;


/* �������Ź� */
/****************************************************************/
typedef struct
{
	vu8 KR;		/* IWDG���Ĵ��� */
	vu8 PR;		/* IWDGԤ��Ƶ�Ĵ��� */
	vu8 RLR;	/* IWDG��װ�ؼĴ��� */
} IWDG_TypeDef;


/* ѡ���ֽ� */
/****************************************************************/
typedef struct
{
	vu8 OPT0;
	vu8 OPT1;
	vu8 NOPT1;
	vu8 OPT2;
	vu8 NOPT2;
	vu8 OPT3;
	vu8 NOPT3;
	vu8 OPT4;
	vu8 NOPT4;
	vu8 OPT5;
	vu8 NOPT5;
	u8 RESERVED[2];
	vu8 OPT7;
	vu8 NOPT7;
} OPT_TypeDef;

/* ��λ */
/****************************************************************/
typedef struct
{
	vu8 SR;		/* ��λ״̬�Ĵ��� */
} RST_TypeDef;


/* SPI(������Χ�ӿ�) */
/****************************************************************/
typedef struct
{
	vu8 CR1;	/* SPI���ƼĴ���1 */
	vu8 CR2;	/* SPI���ƼĴ���2 */
	vu8 ICR;	/* SPI�жϿ��ƼĴ��� */
	vu8 SR;		/* SPI״̬�Ĵ��� */
	vu8 DR;		/* SPI���ݼĴ��� */
	vu8 CRCPR;	/* SPI CRC����ʽ�Ĵ��� */
	vu8 RXCRCR;	/* SPI Rx CRC�Ĵ��� */
	vu8 TXCRCR;	/* SPI Tx CRC�Ĵ��� */
} SPI_TypeDef;


/* TIM1(��ʱ��1) */
/****************************************************************/
typedef struct
{
	vu8 CR1;	/* TIM1���ƼĴ���1 */
	vu8 CR2;	/* TIM1���ƼĴ���2 */
	vu8 SMCR;	/* TIM1��ģʽ�Ĵ��� */
	vu8 ETR;	/* TIM1�ⲿ�����Ĵ��� */
	vu8 IER;	/* TIM1�ж�ʹ�ܼĴ��� */
	vu8 SR1;	/* TIM1״̬�Ĵ���1 */
	vu8 SR2;	/* TIM1״̬�Ĵ���2 */
	vu8 EGR;	/* TIM1�¼������Ĵ��� */
	vu8 CCMR1;	/* TIM1����/�Ƚ�ģʽ�Ĵ���1 */
	vu8 CCMR2;	/* TIM1����/�Ƚ�ģʽ�Ĵ���2 */
	vu8 CCMR3;	/* TIM1����/�Ƚ�ģʽ�Ĵ���3 */
	vu8 CCMR4;	/* TIM1����/�Ƚ�ģʽ�Ĵ���4 */
	vu8 CCER1;	/* TIM1����/�Ƚ�ʹ�ܼĴ���1 */
	vu8 CCER2;	/* TIM1����/�Ƚ�ʹ�ܼĴ���2 */
	vu8 CNTRH;	/* TIM1��������λ */
	vu8 CNTRL;	/* TIM1��������λ */
	//struct DB_TypeDef *CNT;
	vu8 PSCRH;	/* TIM1Ԥ��Ƶ��λ */
	vu8 PSCRL;	/* TIM1Ԥ��Ƶ��λ */
	//struct DB_TypeDef *PSC;
	vu8 ARRH;	/* TIM1�Զ���װ�ظ�λ */
	vu8 ARRL;	/* TIM1�Զ���װ�ص�λ */
	//struct DB_TypeDef *ARR;
	vu8 RCR;	/* TIM1�ظ������Ĵ��� */
	vu8 CCR1H;	/* TIM1����/�Ƚ�1��λ */
	vu8 CCR1L;	/* TIM1����/�Ƚ�1��λ */
	//struct DB_TypeDef *CCR1;
	vu8 CCR2H;	/* TIM1����/�Ƚ�2��λ */
	vu8 CCR2L;	/* TIM1����/�Ƚ�2��λ */
	//struct DB_TypeDef *CCR2;
	vu8 CCR3H;	/* TIM1����/�Ƚ�3��λ */
	vu8 CCR3L;	/* TIM1����/�Ƚ�3��λ */
	//struct DB_TypeDef *CCR3;
	vu8 CCR4H;	/* TIM1����/�Ƚ�4��λ */
	vu8 CCR4L;	/* TIM1����/�Ƚ�4��λ */
	//struct DB_TypeDef *CCR4;
	vu8 BKR;	/* TIM1ɲ���Ĵ��� */
	vu8 DTR;	/* TIM1����ʱ��Ĵ��� */
	vu8 OISR;	/* TIM1�������״̬�Ĵ��� */
} TIM1_TypeDef;


/* TIM2(��ʱ��2) */
/****************************************************************/
typedef struct
{
	vu8 CR1;
#if defined(STM8S103)
	u8 RESERVED[2];
#endif
	vu8 IER;
	vu8 SR1;
	vu8 SR2;
	vu8 EGR;
	vu8 CCMR1;
	vu8 CCMR2;
	vu8 CCMR3;
	vu8 CCER1;
	vu8 CCER2;
	//struct DB_TypeDef *CNT;
	vu8 CNTRH;
	vu8 CNTRL;
	vu8 PSCR;
	//struct DB_TypeDef *ARR;
	vu8 ARRH;
	vu8 ARRL;
	//struct DB_TypeDef *CCR1;
	vu8 CCR1H;
	vu8 CCR1L;
	//struct DB_TypeDef *CCR2;
	vu8 CCR2H;
	vu8 CCR2L;
	//struct DB_TypeDef *CCR3;
	vu8 CCR3H;
	vu8 CCR3L;
} TIM2_TypeDef;


/* TIM3(��ʱ��3) */
/****************************************************************/
typedef struct
{
	vu8 CR1;
	vu8 IER;
	vu8 SR1;
	vu8 SR2;
	vu8 EGR;
	vu8 CCMR1;
	vu8 CCMR2;
	vu8 CCER1;
	//struct DB_TypeDef *CNT;
	vu8 CNTRH;
	vu8 CNTRL;
	vu8 PSCR;
	//struct DB_TypeDef *ARR;
	vu8 ARRH;
	vu8 ARRL;
	//struct DB_TypeDef *CCR1;
	vu8 CCR1H;
	vu8 CCR1L;
	//struct DB_TypeDef *CCR2;
	vu8 CCR2H;
	vu8 CCR2L;
} TIM3_TypeDef;

/* TIM4(��ʱ��4) */
/****************************************************************/
typedef struct
{
	vu8 CR1;
#if defined(STM8S103)
	u8 RESERVED[2];
#endif
	vu8 IER;
	vu8 SR;
	vu8 EGR;
	vu8 CNTR;
	vu8 PSCR;
	vu8 ARR;
} TIM4_TypeDef;


/* TIM5(��ʱ��5) */
/****************************************************************/
typedef struct
{
	vu8 CR1;
	vu8 CR2;
	vu8 SMCR;
	vu8 IER;
	vu8 SR1;
	vu8 SR2;
	vu8 EGR;
	vu8 CCMR1;
	vu8 CCMR2;
	vu8 CCMR3;
	vu8 CCER1;
	vu8 CCER2;
	//struct DB_TypeDef *CNT;
	vu8 CNTRH;
	vu8 CNTRL;
	vu8 PSCR;
	//struct DB_TypeDef *ARR;
	vu8 ARRH;
	vu8 ARRL;
	///struct DB_TypeDef *CCR1;
	vu8 CCR1H;
	vu8 CCR1L;
	//struct DB_TypeDef *CCR2;
	vu8 CCR2H;
	vu8 CCR2L;
	//struct DB_TypeDef *CCR3;
	vu8 CCR3H;
	vu8 CCR3L;
} TIM5_TypeDef;


/* TIM6(��ʱ��6) */
/****************************************************************/
typedef struct
{
	vu8 CR1;
	vu8 CR2;
	vu8 SMCR;
	vu8 IER;
	vu8 SR;
	vu8 EGR;
	vu8 CNTR;
	vu8 PSCR;
	vu8 ARR;
} TIM6_TypeDef;


/* UART1(ͨ��ͬ��/�첽���䷢��) */
/****************************************************************/
typedef struct
{
	vu8 SR;		/* UART1״̬�Ĵ��� */
	vu8 DR; 	/* UART1���ݼĴ��� */
	vu8 BRR1;	/* UART1�����ʼĴ���1 */
	vu8 BRR2;	/* UART1�����ʼĴ���2 */
	vu8 CR1;	/* UART1���ƼĴ���1 */
	vu8 CR2;	/* UART1���ƼĴ���2 */
	vu8 CR3;	/* UART1���ƼĴ���3 */
	vu8 CR4;	/* UART1���ƼĴ���4 */
	vu8 CR5;	/* UART1���ƼĴ���5 */
	vu8 GTR;	/* UART1����ʱ��Ĵ��� */
	vu8 PSCR;	/* UART1Ԥ��Ƶ�Ĵ��� */
} UART1_TypeDef;


/* UART2 */
/****************************************************************/
typedef struct
{
	vu8 SR;
	vu8 DR;
	vu8 BRR1;
	vu8 BRR2;
	vu8 CR1;
	vu8 CR2;
	vu8 CR3;
	vu8 CR4;
	vu8 CR5;
	vu8 CR6;
	vu8 GTR;
	vu8 PSCR;
} UART2_TypeDef;

/* UART3 */
/****************************************************************/
typedef struct
{
	vu8 SR;
	vu8 DR;
	vu8 BRR1;
	vu8 BRR2;
	vu8 CR1;
	vu8 CR2;
	vu8 CR3;
	vu8 CR4;
	u8 RESERVED;
	vu8 CR6;
} UART3_TypeDef;


/* ���ڿ��Ź� */
/****************************************************************/
typedef struct
{
	vu8 CR;	/* WWDG���ƼĴ��� */
	vu8 WR;	/* WWDG���ڼĴ��� */
} WWDG_TypeDef;


/* CAN (���ƾ�����) */
/****************************************************************/
typedef struct
{
	vu8 MCR;	/* CAN�����ƼĴ��� */
	vu8 MSR;	/* CAN��״̬�Ĵ��� */
	vu8 TSR;	/* CAN����״̬�Ĵ��� */
	vu8 TPR;	/* CAN�������ȼ��Ĵ��� */
	vu8 RFR;	/* CAN��ȡ����(FIFO)�Ĵ��� */
	vu8 IER;	/* CAN�ж�ʹ�ܼĴ��� */
	vu8 DGR;	/* CAN��ϼĴ��� */
	vu8 RSR;	/* CANҳѡ��Ĵ��� */
	
	union
	{
		struct
		{
			vu8 MCSR;
			vu8 MIDR[4];
			vu8 MDAR[8];
			//struct DB_TypeDef *MTS;
			vu8 MTSH;
			vu8 MTSL;
		} TxMailbox;
		
		struct
		{
			vu8 FR[16];
		} Filter;
		
		struct
		{
			vu8 F0R[8];
			vu8 F1R[8];
		} Filter01;
		
		struct
		{
			vu8 F2R[8];
			vu8 F3R[8];
		} Filter23;
		
		struct
		{
			vu8 F4R[8];
			vu8 F5R[8];
		} Filter45;
		
		struct
		{
			vu8 ESR;
			vu8 EIER;
			vu8 TECR;
			vu8 RECR;
			vu8 BTR1;
			vu8 BTR2;
			u8 Reserved[2];
			vu8 FMR1;
			vu8 FMR2;
			vu8 FCR1;
			vu8 FCR2;
			vu8 FCR3;
			u8 Reserved0[3];
		} Config;
		
		struct
		{
			vu8 MFMI;
			vu8 MDLCR;
			vu8 MIDR[4];
			vu8 MDAR[8];
			//struct DB_TypeDef *MTS;
			vu8 MTSH;
			vu8 MTSL;
		} RxFIFO;
	}Page;
} CAN_TypeDef;


/******************************************************************************/
/*                         			�������ַ                                */
/******************************************************************************/
#define OPT_BaseAddress         0x4800
#define GPIOA_BaseAddress       0x5000
#define GPIOB_BaseAddress       0x5005
#define GPIOC_BaseAddress       0x500A
#define GPIOD_BaseAddress       0x500F
#define GPIOE_BaseAddress       0x5014
#define GPIOF_BaseAddress       0x5019
#define GPIOG_BaseAddress       0x501E
#define GPIOH_BaseAddress       0x5023
#define GPIOI_BaseAddress       0x5028
#define FLASH_BaseAddress       0x505A
#define EXTI_BaseAddress        0x50A0
#define RST_BaseAddress         0x50B3
#define CLK_BaseAddress         0x50C0
#define WWDG_BaseAddress        0x50D1
#define IWDG_BaseAddress        0x50E0
#define AWU_BaseAddress         0x50F0
#define BEEP_BaseAddress        0x50F3
#define SPI_BaseAddress         0x5200
#define I2C_BaseAddress         0x5210
#define UART1_BaseAddress       0x5230
#define UART2_BaseAddress       0x5240
#define UART3_BaseAddress       0x5240
#define TIM1_BaseAddress        0x5250
#define TIM2_BaseAddress        0x5300
#define TIM3_BaseAddress        0x5320
#define TIM4_BaseAddress        0x5340
#define TIM5_BaseAddress        0x5300
#define TIM6_BaseAddress        0x5340
#define ADC1_BaseAddress        0x53E0
#define ADC2_BaseAddress        0x5400
#define CAN_BaseAddress         0x5420
#define CFG_BaseAddress         0x7F60
#define ITC_BaseAddress         0x7F70
#define DM_BaseAddress          0x7F90


#if defined(STM8S105) || defined(STM8S103) || defined(STM8S903) || defined(STM8AF626x)
 #define ADC1 ((ADC1_TypeDef *) ADC1_BaseAddress)
#endif

#if defined(STM8S208) || defined(STM8S207) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
#define ADC2 ((ADC2_TypeDef *) ADC2_BaseAddress)
#endif

#define AWU ((AWU_TypeDef *) AWU_BaseAddress)

#define BEEP ((BEEP_TypeDef *) BEEP_BaseAddress)

#if defined (STM8S208) || defined (STM8AF52Ax)
 #define CAN ((CAN_TypeDef *) CAN_BaseAddress)
#endif /* (STM8S208) || (STM8AF52Ax) */

#define CLK ((CLK_TypeDef *) CLK_BaseAddress)

#define EXTI ((EXTI_TypeDef *) EXTI_BaseAddress)

#define FLASH ((FLASH_TypeDef *) FLASH_BaseAddress)

#define OPT ((OPT_TypeDef *) OPT_BaseAddress)

#define GPIOA ((GPIO_TypeDef *) GPIOA_BaseAddress)

#define GPIOB ((GPIO_TypeDef *) GPIOB_BaseAddress)

#define GPIOC ((GPIO_TypeDef *) GPIOC_BaseAddress)

#define GPIOD ((GPIO_TypeDef *) GPIOD_BaseAddress)

#define GPIOE ((GPIO_TypeDef *) GPIOE_BaseAddress)

#define GPIOF ((GPIO_TypeDef *) GPIOF_BaseAddress)

#if defined(STM8S207) || defined(STM8S208) || defined(STM8S105) || defined (STM8AF52Ax) || defined (STM8AF62Ax) || defined (STM8AF626x)
 #define GPIOG ((GPIO_TypeDef *) GPIOG_BaseAddress)
#endif /* (STM8S208) ||(STM8S207)  || (STM8S105) || (STM8AF52Ax) || (STM8AF62Ax) || (STM8AF626x) */

#if defined(STM8S207) || defined(STM8S208) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 #define GPIOH ((GPIO_TypeDef *) GPIOH_BaseAddress)
 #define GPIOI ((GPIO_TypeDef *) GPIOI_BaseAddress)
#endif /* (STM8S208) ||(STM8S207) || (STM8AF62Ax) || (STM8AF52Ax) */

#define RST ((RST_TypeDef *) RST_BaseAddress)

#define WWDG ((WWDG_TypeDef *) WWDG_BaseAddress)
#define IWDG ((IWDG_TypeDef *) IWDG_BaseAddress)

#define SPI ((SPI_TypeDef *) SPI_BaseAddress)
#define I2C ((I2C_TypeDef *) I2C_BaseAddress)

#if defined(STM8S208) ||defined(STM8S207) ||defined(STM8S103) ||defined(STM8S903)\
    || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 #define UART1 ((UART1_TypeDef *) UART1_BaseAddress)
#endif /* (STM8S208) ||(STM8S207)  || (STM8S103) || (STM8S903) || (STM8AF52Ax) || (STM8AF62Ax) */

#if defined (STM8S105) || defined (STM8AF626x)
 #define UART2 ((UART2_TypeDef *) UART2_BaseAddress)
#endif /* STM8S105 || STM8AF626x */

#if defined(STM8S208) ||defined(STM8S207) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 #define UART3 ((UART3_TypeDef *) UART3_BaseAddress)
#endif /* (STM8S208) ||(STM8S207) || (STM8AF62Ax) || (STM8AF52Ax) */

#define TIM1 ((TIM1_TypeDef *) TIM1_BaseAddress)

#if defined(STM8S208) ||defined(STM8S207) ||defined(STM8S103) ||defined(STM8S105)\
    || defined (STM8AF52Ax) || defined (STM8AF62Ax) || defined (STM8AF626x)
 #define TIM2 ((TIM2_TypeDef *) TIM2_BaseAddress)
#endif /* (STM8S208) ||(STM8S207)  || (STM8S103) || (STM8S105) || (STM8AF52Ax) || (STM8AF62Ax) || (STM8AF626x)*/

#if defined(STM8S208) ||defined(STM8S207) ||defined(STM8S105) || defined (STM8AF52Ax)\
    || defined (STM8AF62Ax) || defined (STM8AF626x)
 #define TIM3 ((TIM3_TypeDef *) TIM3_BaseAddress)
#endif /* (STM8S208) ||(STM8S207)  || (STM8S105) || (STM8AF62Ax) || (STM8AF52Ax) || (STM8AF626x)*/

#if defined(STM8S208) ||defined(STM8S207) ||defined(STM8S103) ||defined(STM8S105)\
    || defined (STM8AF52Ax) || defined (STM8AF62Ax) || defined (STM8AF626x)
 #define TIM4 ((TIM4_TypeDef *) TIM4_BaseAddress)
#endif /* (STM8S208) ||(STM8S207)  || (STM8S103) || (STM8S105) || (STM8AF52Ax) || (STM8AF62Ax) || (STM8AF626x)*/

#ifdef STM8S903
 #define TIM5 ((TIM5_TypeDef *) TIM5_BaseAddress)
 #define TIM6 ((TIM6_TypeDef *) TIM6_BaseAddress)
#endif /* STM8S903 */ 

#define ITC ((ITC_TypeDef *) ITC_BaseAddress)

#define CFG ((CFG_TypeDef *) CFG_BaseAddress)

//#define DM ((DM_TypeDef *) DM_BaseAddress)

