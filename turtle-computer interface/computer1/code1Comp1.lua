rednet.open("back")

local turtleID1 = 39

rednet.send(turtleID1, "echo", "instruction")

local eSender, eMessage, eProtocol = rednet.receive(nil, 2)
local working = false

print()
print("----------------------------------------------")
print()
print("   _____    _____   ____  ")
print(" / ____|  / ____| |  _ \\ ")
print("| (___   | (___   | |_) |")
print(" \\___ \\   \\___ \\  |  _ < ")
print(" ____) |  ____) | | |_) |")
print("|_____/  |_____/  |____/ ")
print()
print("----------------------------------------------")
print()
print("Computer output: Computer has started.")

if eSender == turtleID1 and eMessage == "received" then
    print("Computer output: ")
    print()
    print("Turtle 1 active")
    print()
    print("Press 0 to disable turtle")
    print("Press 1 to enable turtle")
    print("Press 2 to return turtle")
    --print("Press 2 to echo turtle")
    print()
    print("End of Computer output")
    print()
    working = true
else
    print("Computer output: Failed to get a responce from turtle")
    print()
end

local active = "off"
local remoteControl = "off"

while working do 

    local event, arg1, arg2, arg3, arg4, arg5 = os.pullEvent()

    if event == "rednet_message" then
        local sender = arg1
        local message = arg2
        local protocol = arg3

        if sender == turtleID1 then
            if protocol == "compDisplay" then
                print(message)
            end

            if protocol == "getCoordsX" then
                print("X: "..message)
            end
            if protocol == "getCoordsY" then
                print("Y: "..message)
            end
            if protocol == "getCoordsZ" then
                print("Z: "..message)
            end
        end
    end
    
    --[[
    if event == "char" and arg1 == "2" then
        rednet.send(18, "echo")
        eSender, eMessage, eProtocol = rednet.receive(nil, 2)
        if eSender == 18 and eMessage == "received" then
            print("Turtle responded")
        end
    end
    ]]--

    if event == "char" and arg1 == "0" then
        print("Computer output: Turtle off.")
        active = "off"
        rednet.send(turtleID1, "off", "instruction")
    end

    if event == "char" and arg1 == "1" then
        print("Computer output: Turtle on.")
        active = "on"
        rednet.send(turtleID1, "on", "instruction")
    end

    if event == "char" and arg1 == "2" then
        print("Attempting to return turtle.")
        print("Attempt: 1")
        rednet.send(turtleID1, "return", "instruction")

        local responded = false
        local attempt = 2

        while not responded do
            
            local respSender, respMessage, respProtocol = rednet.receive(nil, 1)

            if respMessage == "returningHome" and respSender == turtleID1 and respProtocol == "notSleep" then
                print()
                print("Turtle returing home")
                responded = true
            else
                print("Attempt:", attempt)
                rednet.send(turtleID1, "return", "instruction")
                attempt = attempt + 1
            end
        end
    end




    if event == "char" and arg1 == "/" then
        if remoteControl == "off" then
            remoteControl = "on"
            print("Enabled turtle remote control")
        elseif remoteControl == "on" then
            remoteControl = "off"
            print("Disabled turtle remote control")
        end
    end


    if event == "char" and arg1 == "7" then
        if remoteControl == "on" then
            rednet.send(turtleID1, "up")
        else
            print("remoteControl off")
        end
    end
    
    if event == "char" and arg1 == "9" then
        if remoteControl == "on" then
            rednet.send(turtleID1, "down")
        else
            print("remoteControl off")
        end
    end
    
    if event == "char" and arg1 == "8" then
        if remoteControl == "on" then
            rednet.send(turtleID1, "forward")
        else
            print("remoteControl off")
        end
    end

    
    if event == "char" and arg1 == "5" then
        if remoteControl == "on" then
            rednet.send(turtleID1, "back")
        else
            print("remoteControl off")
        end
    end
    
    if event == "char" and arg1 == "4" then
        if remoteControl == "on" then
            rednet.send(turtleID1, "left")
        else
            print("remoteControl off")
        end
    end
    
    if event == "char" and arg1 == "6" then
        if remoteControl == "on" then
            rednet.send(turtleID1, "right")
        else 
            print("remoteControl off")
        end
    end



    if event == "char" and arg1 == "+" then
        if remoteControl == "on" then
            rednet.send(turtleID1, "coords")
        else
            print("remoteControl off")
        end
    end
end