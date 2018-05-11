print(1)

gpio.mode(0,gpio.OUTPUT)
gpio.mode(2,gpio.OUTPUT)
gpio.mode(3,gpio.OUTPUT)
gpio.mode(4,gpio.OUTPUT)
gpio.mode(5,gpio.OUTPUT)
gpio.mode(6,gpio.OUTPUT)
gpio.mode(7,gpio.OUTPUT)
gpio.mode(8,gpio.OUTPUT)

gpio.write(0,0)
gpio.write(2,0)
gpio.write(3,0)
gpio.write(4,1) 
gpio.write(5,0)
gpio.write(6,0)
gpio.write(7,0)
gpio.write(8,0)


pwm.setup(1,1,100)
pwm.start(1)
