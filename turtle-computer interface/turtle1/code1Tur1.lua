rednet.open("right")

print("   ")
print("Turtle ready to receive instructions")
print("Listeneing for messages")
print(" ")

thisTurtleID = os.getComputerID() -- thisTurtleID -- The ID of this turtle
masterComputerID = 12   -- masterComputerID -- The computer in control of everything
comp2ID = 19    -- relayComputerID -- The computer used to relay messages

local active = "off"
local echoed = false

while true do

    local sender, message, protocol = rednet.receive(nil, 1)

    if sender == masterComputerID then

        if message == "echo" then
            rednet.send(sender, "received")
            print("Echoing")
            echoed = true
        end

        if message == "off" then
            active = "off"
            print("Turtle off")
        end

        if message == "on" then
            active = "on"
            print("Turtle on")
        end
    elseif echoed and active == "on" then
        
    end
end