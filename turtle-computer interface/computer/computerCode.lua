rednet.open("back")

rednet.send(18, "echo")

local eSender, eMessage, eProtocol = rednet.receive(nil, 2)
local working = false

print()
print("Computer has started.")
print()
if eSender == 18 and eMessage == "received" then
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
    
    if character == "9" then
        print()
        print("Computer shuting down")
        print("Turtle shutting down")
        print()

        rednet.send(18, "shutdown", "instruction")

        shell.exit()

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