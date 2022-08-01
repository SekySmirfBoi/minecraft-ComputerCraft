function work() 
    while active == "on" do
        turtle.forward()
    end
end

rednet.open("right")

print("   ")
print("Turtle ready to receive instructions")
print("Listeneing for messages")
print(" ")

local active = "off"

while true do
    if active == "on" then
        work()
    end

    local sender, message, protocol = rednet.receive()

    if message == "echo" then
        rednet.send(sender, "received")
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