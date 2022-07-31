rednet.open("back")

print()
print("Computer has started.")
print("Press 1 to enable turtle(s)")
print("Press 0 to disable turtle(s)")

print("------------------------------------")

local active = "off"

while true do 
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