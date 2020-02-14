#!/user/bin/python
# Senior Design #
# 

### import Python Modules ###
from calc import *
import RPi.GPIO as GPIO
import time
import threading

## car amount list ## 
car = [0, 24, 48, 72, 96]
IDX = 0 
prev_input = 0

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
	# print(pin)
	global IDX
	print("IDX: " + str(IDX))
	b_in = GPIO.input(pin)
	print("b_in: " + str(b_in))

	if pin == BTN_Y and not b_in :
		print("new value of IDX: " + str(IDX))
		print("b_in: " + str(b_in))
		print("incremented IDX")
		IDX+=1 
		if IDX >= 5: 
			IDX = 0 
		time.sleep(1)
	elif pin == BTN_B and b_in: 
		print("new value of IDX: " + str(IDX))
		print("b_in: " + str(b_in))
		print("decremented IDX")
		IDX-=1 
		if IDX < 0: 
			IDX = 0 
		time.sleep(1)

	t = None


##Tell GPIO lib to look out for an event on each pushbutton and pass handle ###
### function to be run for each pushbutton detection ### 


GPIO.add_event_detect(BTN_Y,GPIO.BOTH, handle)
GPIO.add_event_detect(BTN_B,GPIO.BOTH,handle)

#wait for an interrupt
while True:
	print("current value of IDX: "+ str(IDX))
	print("number of cars on the bridge: " + str(car[IDX]))
	severity(car[IDX])
	time.sleep(1)

