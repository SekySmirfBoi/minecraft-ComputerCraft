
-- Change these variables
masterComputerID = 53   -- The id of the master computer 
turtleID = 52           -- The id of the turtle that will send messages to this computer



monitorDirection = "back" -- Change this variable so it works with the monitor

--------------------------------------------------------------
thisCompID = os.getComputerID() -- Do not change this variable
--------------------------------------------------------------

rednet.open("top")

mon = peripheral.wrap(monitorDirection)
mon.clear()
mon.setCursorPos(1,1)

active = true

while active do

    local id, mes, pro = rednet.receive("display", 0.25)

    if id == turtleID and pro == "display" then
        mon.write(mes)

        local monX, monY = mon.getCursorPos()
        if monY == 40 then
            monY = 0
            mon.clear()
        end
        monY = monY + 1
        mon.setCursorPos(1,monY)
    end
end

