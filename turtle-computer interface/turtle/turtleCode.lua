rednet.open("right")

print("   ")
print("Turtle ready to receive instructions")
print("Listeneing for messages")
print(" ")

local active = "off"
local echoed = false

while true do

    local sender, message, protocol = rednet.receive(nil, 1)

    if sender == 12 then
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
    end
    else if echoed then
        print("Forwards")
    end
end