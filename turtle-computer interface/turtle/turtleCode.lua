function work() 
    turtle.forward()
end

rednet.open("right")

print("Turtle ready to receive instructions")

local active = "off"

while true do
    if active == "on" then
        work()
    end
end