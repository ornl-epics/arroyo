# Arroyo temperature controller TEC Commands
EPICS Driver developed by Mariano Ruiz, zma@ornl.gov

This driver is developed to control a peltier. 
The driver is compatible with some of the TC temperature control commands. 


Interface Settings 
 Baud Rate The instrument will operate at 300, 1200, 2400, 4800, 9600, 19200, 38400, 57600, and 
115200 baud rates. The baud rate can be set through the instrument’s menu, with a 
factory default of 9600, and must match the setting on the PC Parity None Data Bits 8 Stop Bits 1 Flow Control None 


EPICS Module ASYN drvAsynIPPortConfigure
