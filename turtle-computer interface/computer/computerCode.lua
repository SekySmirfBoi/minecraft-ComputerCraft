rednet.open("back")

rednet.send(18, "echo")

local eSender, eMessage, eProtocol = rednet.receive(nil, 2)
local working = false

print()
print("Computer has started.")

if eSender == 18 and eMessage == "received" then
    print("Turtle active")
    print()
    print("Press 0 to disable turtle")
    print("Press 1 to enable turtle")
    print("Press 2 to echo turtle")
    print()
    working = true
else
    print("Failed to get a responce from turtle")
end

local active = "off"

while working do 

    local event, character = os.pullEvent("char")

    if character == "2" then
        rednet.send(18, "echo")
        eSender, eMessage, eProtocol = rednet.receive(nil, 2)
        if eSender == 18 and eMessage == "received" then
            print("Turtle responded")
        end
    end

    if character == "0" then
        print("Turtle off")
        active = "off"
        rednet.send(18, "off", "instruction")
    end

    if character == "1" then
        print("Turtle on")
        active = "on"
        rednet.send(18, "on", "instruction")
    end
end