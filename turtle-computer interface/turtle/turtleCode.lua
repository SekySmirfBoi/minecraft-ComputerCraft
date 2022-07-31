function work() 
    while active == "on" do
        turtle.forward()
    end
end

rednet.open("right")

print()
print("Turtle ready to receive instructions")
print("------------------------------------")
print()

local active = "off"

while true do
    if active == "on" then
        work()
    end

    print("------------------------------------")
    print("Listeneing for message")
    local sender, message = rednet.receive("instruction")
    print("------------------------------------")

    if message == "off" then
        active = "off"
        print("Turtle off")
        print()
    end
    if message == "on" then
        active = "on"
        print("Turtle on")
        print()
    end
end