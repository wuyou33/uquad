EESchema Schematic File Version 2  date jue 12 ene 2012 23:34:10 UYST
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:IR-cache
EELAYER 24  0
EELAYER END
$Descr A4 11700 8267
Sheet 1 1
Title ""
Date "13 jan 2012"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	4000 2700 4000 3100
Wire Wire Line
	4700 3500 4700 3950
Wire Wire Line
	4700 3950 3550 3950
Wire Wire Line
	3550 3950 3550 2900
Wire Wire Line
	3550 2900 4000 2900
Wire Wire Line
	4600 3600 4600 3700
Wire Wire Line
	5300 3100 5100 3100
Wire Wire Line
	5100 3100 5100 3200
Wire Wire Line
	5100 3200 4900 3200
Connection ~ 4600 3600
Wire Wire Line
	4400 3600 5200 3600
Wire Wire Line
	5200 3600 5200 3200
Wire Wire Line
	5200 3200 5300 3200
Wire Wire Line
	4500 3200 4500 3050
Wire Wire Line
	4500 3050 5000 3050
Wire Wire Line
	5000 3050 5000 3300
Wire Wire Line
	5000 3300 5300 3300
Connection ~ 4700 3600
$Comp
L CONN_2 P?
U 1 1 4F0F86E6
P 4350 2800
F 0 "P?" V 4300 2800 40  0000 C CNN
F 1 "CONN_2" V 4400 2800 40  0000 C CNN
	1    4350 2800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 4F0F51C3
P 4600 3700
F 0 "#PWR01" H 4600 3700 30  0001 C CNN
F 1 "GND" H 4600 3630 30  0001 C CNN
	1    4600 3700
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 K1
U 1 1 4F0F4FF4
P 5650 3200
F 0 "K1" V 5600 3200 50  0000 C CNN
F 1 "CONN_3" V 5700 3200 40  0000 C CNN
	1    5650 3200
	1    0    0    -1  
$EndComp
$Comp
L NPN Q1
U 1 1 4F0F4E72
P 4700 3300
F 0 "Q1" H 4700 3150 50  0000 R CNN
F 1 "NPN" H 4700 3450 50  0000 R CNN
	1    4700 3300
	0    -1   -1   0   
$EndComp
$Comp
L LED D1
U 1 1 4F0EDA78
P 4200 3600
F 0 "D1" H 4200 3700 50  0000 C CNN
F 1 "LED" H 4200 3500 50  0000 C CNN
	1    4200 3600
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 4F0EDA6F
P 4000 3350
F 0 "R1" V 4050 3400 50  0000 C CNN
F 1 "R" V 3950 3350 50  0000 C CNN
	1    4000 3350
	1    0    0    -1  
$EndComp
$EndSCHEMATC
