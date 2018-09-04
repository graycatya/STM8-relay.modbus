# -*- coding: utf-8 -*-
import serial
import serial.tools.list_ports
import threading
import string  
import binascii 
from PyQt5 import QtCore, QtGui, QtWidgets
"""
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QMovie,  QIcon,  QPixmap,  QPalette
from PyQt5.QtWidgets import QMainWindow,  QApplication
"""
from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *
from Ui_window import Ui_MainWindow
from com_board import Modbus5_crc, Modbus15_crc, Modbus1_crc, Modbus6_crc
import time






class PortMain(QMainWindow,  Ui_MainWindow):
    ser = serial.Serial() #串口初始化
    def __init__(self,  parent = None):
        super(PortMain,  self).__init__(parent)
        #self.timer = QTimer(self)
        self.thread = Worker()
        self.thread_1 = Worker_1()
        self.scan_time = 0
        self.rest = False
        self.DBA = []
        self.READ_DATA = ''
        self.inter = False
        self.relay = False #继电器
        self.optocoupler  = False #光耦
        self.scan = False
        self.thread1s = False
        self.setupUi(self)
        self.Butt_fun()
        self.setEnabled_False()
        self.Enabled_False()
        self.lineEdit.setEnabled(True)
        

        #self.send_data(data0)

    def setEnabled_True(self):
        if(self.rest == True):
            self.pushButton.setEnabled(True)
            self.pushButton_2.setEnabled(True)
            self.pushButton_7.setEnabled(True)
            self.pushButton_3.setEnabled(True)
            self.pushButton_9.setEnabled(True)
            self.pushButton_8.setEnabled(True)
            self.pushButton_11.setEnabled(True)
            self.pushButton_10.setEnabled(True)
            self.pushButton_13.setEnabled(True)
            self.pushButton_12.setEnabled(True)
            self.pushButton_15.setEnabled(True)
            self.pushButton_14.setEnabled(True)
            self.pushButton_17.setEnabled(True)
            self.pushButton_16.setEnabled(True)
            self.pushButton_19.setEnabled(True)
            self.pushButton_18.setEnabled(True)
            self.pushButton_21.setEnabled(True)
            self.pushButton_22.setEnabled(True)
            self.spinBox_3.setEnabled(True)  
            self.spinBox_4.setEnabled(True) 
            self.spinBox_5.setEnabled(True) 
            self.spinBox_6.setEnabled(True) 
            self.spinBox.setEnabled(True)
            self.spinBox_2.setEnabled(True)
            self.pushButton_24.setEnabled(True)
            self.pushButton_25.setEnabled(True)

    def COMKO_True(self):
        self.comboBox_7.setEnabled(True)
        self.comboBox_6.setEnabled(True)
        self.comboBox_8.setEnabled(True)
        self.comboBox_9.setEnabled(True)
        self.comboBox_10.setEnabled(True)

    def Enabled_True(self):
        self.pushButton_23.setEnabled(True)
        self.pushButton_25.setEnabled(True)


    def setEnabled_False(self): 
        self.pushButton.setEnabled(False)
        self.pushButton_2.setEnabled(False)
        self.pushButton_7.setEnabled(False)
        self.pushButton_3.setEnabled(False)
        self.pushButton_9.setEnabled(False)
        self.pushButton_8.setEnabled(False)
        self.pushButton_11.setEnabled(False)
        self.pushButton_10.setEnabled(False)
        self.pushButton_13.setEnabled(False)
        self.pushButton_12.setEnabled(False)
        self.pushButton_15.setEnabled(False)
        self.pushButton_14.setEnabled(False)
        self.pushButton_17.setEnabled(False)
        self.pushButton_16.setEnabled(False)
        self.pushButton_19.setEnabled(False)
        self.pushButton_18.setEnabled(False)
        self.pushButton_21.setEnabled(False)
        self.pushButton_22.setEnabled(False)  
        self.spinBox_3.setEnabled(False)  
        self.spinBox_4.setEnabled(False) 
        self.spinBox_5.setEnabled(False) 
        self.spinBox_6.setEnabled(False) 
        self.spinBox.setEnabled(False)
        self.spinBox_2.setEnabled(False)
        self.pushButton_24.setEnabled(False)
        self.pushButton_25.setEnabled(False)

    def COMKO_False(self):
        self.comboBox_7.setEnabled(False)
        self.comboBox_6.setEnabled(False)
        self.comboBox_8.setEnabled(False)
        self.comboBox_9.setEnabled(False)
        self.comboBox_10.setEnabled(False)

    def Enabled_False(self):
        self.pushButton_23.setEnabled(False)
        self.pushButton_25.setEnabled(False)



    def Butt_fun(self):
        self.pushButton_6.clicked.connect(self.port_cheak) #当按下时进入端口扫描状态
        self.pushButton_4.clicked.connect(self.port_open) #开启串口
        self.pushButton_5.clicked.connect(self.port_close) #关闭串口
        self.pushButton_20.clicked.connect(self.clean_data) #当按下时清空接收区
        
        self.pushButton.clicked.connect(self.ONE_ON)
        self.pushButton_2.clicked.connect(self.ONE_OFF)
        
        self.pushButton_7.clicked.connect(self.TWO_ON)
        self.pushButton_3.clicked.connect(self.TWO_OFF)
        
        self.pushButton_9.clicked.connect(self.THREE_ON)
        self.pushButton_8.clicked.connect(self.THREE_OFF)
        
        self.pushButton_11.clicked.connect(self.FOUR_ON)
        self.pushButton_10.clicked.connect(self.FOUR_OFF)
        
        self.pushButton_13.clicked.connect(self.FIVE_ON)
        self.pushButton_12.clicked.connect(self.FIVE_OFF)
        
        self.pushButton_15.clicked.connect(self.SIX_ON)
        self.pushButton_14.clicked.connect(self.SIX_OFF)
        
        self.pushButton_17.clicked.connect(self.SEVEN_ON)
        self.pushButton_16.clicked.connect(self.SEVEN_OFF)
        
        self.pushButton_19.clicked.connect(self.EIGHT_ON)
        self.pushButton_18.clicked.connect(self.EIGHT_OFF)

        self.pushButton_21.clicked.connect(self.RANGE_ON)
        self.pushButton_22.clicked.connect(self.RANGE_OFF)

        self.pushButton_23.clicked.connect(self.endthread)
        self.pushButton_24.clicked.connect(self.REGISTER)
        self.pushButton_25.clicked.connect(self.startthread)

        self.thread_1.sinOut.connect(self.showTime)
        self.thread.sinOut.connect(self.showTthread)


    def send_data(self):
        """
        发送函数：
        """
        try:
            if(self.ser.isOpen()):
                #time.sleep(0.3)
                self.ser.write(self.DBA)
                
                #if(self.scan == 0):

                self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">发送成功</span></p></body></html>")
            else:
                self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">发送失败</span></p></body></html>")
        except:
            self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">端口断开连接</span></p></body></html>")
       

    def port_cheak(self):
        Com_List=[]
        port_list = list(serial.tools.list_ports.comports()) #读取com口
        self.comboBox_7.clear()  #清空显示
        for port in port_list: 
            Com_List.append(port[0])
            self.comboBox_7.addItem(port[0])
        if(len(Com_List) == 0):
            self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">没串口</span></p></body></html>")
            

    def port_open(self):
        try:
            if(self.lineEdit.text() != '' and int(self.lineEdit.text()) >= 1 and int(self.lineEdit.text()) <= 63):
                self.ser.port = self.comboBox_7.currentText() #波特率
                print(self.comboBox_6.currentText())
                self.ser.baudrate = int(self.comboBox_6.currentText())
                self.ser.bytesize = int(self.comboBox_8.currentText()) 
                self.ser.stopbits = int(self.comboBox_10.currentText())
                self.ser.parity = self.comboBox_9.currentText()
                try:
                    self.ser.open()
                    if(self.ser.isOpen()):
                        self.COMKO_False()
                        self.rest = True
                        self.pushButton_25.setEnabled(True)
                        self.setEnabled_True()
                        self.lineEdit.setEnabled(False)
                        self.pushButton_4.setEnabled(False)
                        self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">打开成功</span></p></body></html>")
                        self.t1 = threading.Thread(target=self.receive_data)
                        self.t1.setDaemon(True)
                        self.t1.start()
                    else:
                        self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">打开失败</span></p></body></html>")
                except:
                    self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">端口被占用</span></p></body></html>")
            else:
                self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">地址范围外</span></p></body></html>")
        except ValueError:
            self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">地址错误</span></p></body></html>")
   

    def port_close(self):
        self.ser.close()
        if(self.ser.isOpen()):
            self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">关闭失败</span></p></body></html>")
        else:
            self.endthread()
            self.endTimer()
            self.scan = False
            self.rest = False
            self.COMKO_True()
            self.Enabled_False()
            self.setEnabled_False()
            self.lineEdit.setEnabled(True)
            self.pushButton_4.setEnabled(True)
            self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">关闭成功</span></p></body></html>")


    def clean_data(self):
        self.movie_2 = QMovie("./icon/ZZPLOG.png") #设置gif图标
        self.lable_57.setMovie(self.movie_2)
        self.movie_2.start()
        self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">更换成功</span></p></body></html>")
        
    def receive_data(self):
        """
        接收函数
        """

        print("The receive_data threading is start") 
        try:
            while (self.ser.isOpen()):
                time.sleep(0.2)
                size = self.ser.inWaiting()
                if size:

                    if(self.thread1s == True):
                        self.endTimer()

                    self.READ_DATA = self.ser.read_all()
                
                    self.ser.flushInput()   
                    if(self.scan == False):
                        self.setEnabled_True()

        except:
            print("接收erro")
       

    def RELAYOPT_off(self):
        self.label_29.setPixmap(QPixmap('./icon/OFF.jpg'))  
        self.label_33.setPixmap(QPixmap('./icon/OFF.jpg'))    
        self.label_30.setPixmap(QPixmap('./icon/OFF.jpg'))  
        self.label_34.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_31.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_35.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_32.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_36.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_38.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_40.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_42.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_44.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_46.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_48.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_50.setPixmap(QPixmap('./icon/OFF.jpg')) 
        self.label_52.setPixmap(QPixmap('./icon/OFF.jpg')) 
            
    def RELAYOPT_state(self):
        """
        界面可视化光耦与继电器状态
        """
        #print()
        if(self.relay & 0x01):
            self.label_29.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_29.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.relay & 0x02):
            self.label_33.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_33.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.relay & 0x04):
            self.label_30.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_30.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.relay & 0x08):
            self.label_34.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_34.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.relay & 0x10):
            self.label_31.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_31.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.relay & 0x20):
            self.label_35.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_35.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.relay & 0x40):
            self.label_32.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_32.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.relay & 0x80):
            self.label_36.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_36.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.optocoupler & 0x01):
            self.label_38.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_38.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.optocoupler & 0x02):
            self.label_40.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_40.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.optocoupler & 0x04):
            self.label_42.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_42.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.optocoupler & 0x08):
            self.label_44.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_44.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.optocoupler & 0x10):
            self.label_46.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_46.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.optocoupler & 0x20):
            self.label_48.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_48.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.optocoupler & 0x40):
            self.label_50.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_50.setPixmap(QPixmap('./icon/OFF.jpg')) 

        if(self.optocoupler & 0x80):
            self.label_52.setPixmap(QPixmap('./icon/ON.jpg')) 
        else:
            self.label_52.setPixmap(QPixmap('./icon/OFF.jpg')) 


    def ONE_ON(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x00, 0xFF)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
        #time.sleep(0.3)
            
        
    def ONE_OFF(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x00, 0x00)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
        
            

    def TWO_ON(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x01, 0xFF)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
       
            
        
    def TWO_OFF(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x01, 0x00)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
        
            

    def THREE_ON(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x02, 0xFF)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
        
            
        
    def THREE_OFF(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x02, 0x00)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
        
            
        
    def FOUR_ON(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x03, 0xFF)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
      
            
        
    def FOUR_OFF(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x03, 0x00)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
     
            
        
    def FIVE_ON(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x04, 0xFF)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
       
            
        
    def FIVE_OFF(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x04, 0x00)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
       
            
        
    def SIX_ON(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x05, 0xFF)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
        
            
        
    def SIX_OFF(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x05, 0x00)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
        
            
        
    def SEVEN_ON(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x06, 0xFF)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
      
            
        
    def SEVEN_OFF(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x06, 0x00)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
      
            
        
    def EIGHT_ON(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x07, 0xFF)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
   
            
        
    def EIGHT_OFF(self):
        self.setEnabled_False()
        self.DBA = Modbus5_crc(int(self.lineEdit.text()), 0x07, 0x00)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()

            

    def RANGE_ON(self):
        self.setEnabled_False()
        self.DBA = Modbus15_crc(int(self.lineEdit.text()), int(self.spinBox_4.text()), int(self.spinBox_3.text()), 0xFF)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
 
            
        
    def RANGE_OFF(self):
        self.setEnabled_False()
        self.DBA = Modbus15_crc(int(self.lineEdit.text()), int(self.spinBox_5.text()), int(self.spinBox_6.text()), 0x00)
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
 
            

    def REGISTER(self):
        self.setEnabled_False()
        self.DBA = Modbus6_crc(int(self.lineEdit.text()), int(self.spinBox.text()), int(self.spinBox_2.text()))
        #time.sleep(0.1)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
  
            

    def SCAN(self):
        self.DBA = Modbus1_crc(int(self.lineEdit.text()), 0x00, 0x0F)
        #time.sleep(0.2)
        self.startTimer()
        self.send_data()
      
        

    def showTime(self):
        #进程功能
        #self.scan = False
        if(self.scan == True):
            self.endthread()
        else:
            self.setEnabled_True()

        self.label.setText("<html><head/><body><p align=\"center\"><span style=\" font-size:12pt; font-weight:600; vertical-align:sub;\">没有回复</span></p></body></html>")
        self.endTimer()
        
    
    def startTimer(self):
        #进程
        self.thread1s = True
        self.thread_1.start()


    def endTimer(self):
        self.thread1s = False
        self.thread_1.terminate()



    def showTthread(self):
        #进程1功能
        try:
            if(int(self.READ_DATA[1]) == 1 and len(self.READ_DATA) == 7):
                self.optocoupler = int(self.READ_DATA[3])
                self.relay = int(self.READ_DATA[4])
                if(self.scan == True):
                    self.RELAYOPT_state()
                else:
                    self.RELAYOPT_off()
        except:
            print("008")
        self.SCAN()


    def startthread(self):
        self.scan = True
        self.setEnabled_False()
        self.pushButton_25.setEnabled(False)
        self.pushButton_23.setEnabled(True)
        self.thread.start()

    def endthread(self):
        self.thread.terminate()
        self.scan = False
        self.setEnabled_True()
        self.pushButton_25.setEnabled(True)
        self.pushButton_23.setEnabled(False)
        self.RELAYOPT_off()


class Worker(QThread):
	sinOut = pyqtSignal()

	def __init__(self,parent=None):
		super(Worker,self).__init__(parent)
		self.working = True
		
	def __del__(self):
		self.working = False
		self.wait()
		
	def run(self):
		while self.working:
			time.sleep(0.6)
			self.sinOut.emit()
			# 线程休眠1.5秒
			#time.sleep(1)


class Worker_1(QThread):
	sinOut = pyqtSignal()

	def __init__(self,parent=None):
		super(Worker_1,self).__init__(parent)
		
	def run(self):
			# 线程休眠2秒
			self.sleep(1.5)
			self.sinOut.emit()







             
                

if __name__ == "__main__":
    import sys
    app = QApplication(sys.argv)
    ui = PortMain()
    ui.show()
    sys.exit(app.exec_())
