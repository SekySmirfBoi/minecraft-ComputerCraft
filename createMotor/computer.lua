local motor = peripheral.wrap("left")
local speed = -128
motor.setSpeed(speed)
sleep(motor.translate(3, speed))
motor.sleep()