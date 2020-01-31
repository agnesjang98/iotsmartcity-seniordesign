#!/user/bin/python
# Senior Design #
# 

### import Python Modules ###
from calc import *
import RPi.GPIO as GPIO
import time
import threading

### Set GPIO pins and all setups needs ###
GPIO.setmode(GPIO.BOARD)

BTN_B = 22 # G25

BTN_Y = 12 # G18



LED_B = 29 # G5

LED_Y = 31 # G6



btn2led = {

	BTN_Y: LED_Y,

	BTN_B: LED_B,

}	

GPIO.setwarnings(False) 
GPIO.setup([BTN_Y,BTN_B], GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup([LED_Y,LED_B], GPIO.OUT, initial=GPIO.HIGH)

### When press button light up LED to indicate, information has sent ###
def handle(pin): 
	#turn the  pressed button LED on  
	GPIO.output(btn2led[pin], not GPIO.input(pin))
	print(pin)
	if pin == BTN_Y:	
		severity(100)

	t = None


##Tell GPIO lib to look out for an event on each pushbutton and pass handle ###
### function to be run for each pushbutton detection ### 


GPIO.add_event_detect(BTN_Y,GPIO.BOTH, handle)
GPIO.add_event_detect(BTN_B,GPIO.BOTH,handle)

#wait for an interrupt
while True:
	time.sleep(1)

