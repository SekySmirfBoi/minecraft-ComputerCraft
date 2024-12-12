local motorSide = "left"
local inputSide = "right"

local motor = peripheral.wrap(motorSide)
local speed = 128
local dir = 0

motor.setSpeed(-speed)
sleep(motor.translate(3,-speed))
motor.stop()

while true do
    if redstone.getInput(inputSide) then
        if dir == 0 then
            motor.setSpeed(speed)
            sleep(motor.translate(3,speed))
            dir = 1
        else
            motor.setSpeed(-speed)
            sleep(motor.translate(3,-speed))
            dir = 0
        end
    motor.stop()
    end

    os.pullEvent("redstone")
end