rednet.open("back")

rednet.send(16, "echo")

local eSender, eMessage, eProtocol = rednet.receive(nil, 2)
local working = false

print()
print("Computer has started.")
print()
if eSender == 16 and eMessage == "received" then
    print("Press 1 to enable turtle")
    print("Press 0 to disable turtle")
    print()
    working = true
else
    print("Failed to get a responce from turtle")
end

local active = "off"

while working do 
    local event, character = os.pullEvent("char")
    
    if character == "0" then
        print("Turtle off")
        active = "off"
        rednet.send(16, "off", "instruction")
    end

    if character == "1" then
        print("Turtle on")
        active = "on"
        rednet.send(16, "on", "instruction")
    end
end