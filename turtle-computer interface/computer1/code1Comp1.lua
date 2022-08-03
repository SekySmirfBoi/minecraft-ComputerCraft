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
print("Computer has started.")

if eSender == turtleID1 and eMessage == "received" then
    print()
    print("Turtle 1 active")
    print()
    print("Press 0 to disable turtle")
    print("Press 1 to enable turtle")
    print("Press 2 to return turtle")
    print()
    working = true
else
    print("Failed to get a responce from turtle")
    print()
end

local active = "off"
local remoteControl = "off"

while working do 

    local event, arg1, arg2, arg3, arg4, arg5 = os.pullEventRaw()

    if event == "rednet_message" then
        local sender = arg1
        local message = arg2
        local protocol = arg3

        if sender == turtleID1 then
            -- prints whatever the turtle said to the screen
            if protocol == "compDisplay" then
                print(message)
            end

            -- prints turtle's x coordinate
            if protocol == "getCoordsX" then
                print("X: "..message)
            end
            -- prints turtle's y coordinate
            if protocol == "getCoordsY" then
                print("Y: "..message)
            end
            -- prints turtle's z coordinate
            if protocol == "getCoordsZ" then
                print("Z: "..message)
            end

            -- Terminates the computer when turtle is terminated
            if message == "termination" and protocol == "userCommand" then
                print("terminating")
                working = false
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

    -- Stop the turtle from moving and mining
    if event == "char" and arg1 == "0" then
        print("Computer output: Turtle off.")
        active = "off"
        rednet.send(turtleID1, "off", "instruction")
    end

    -- Start the turtle moving and mining
    if event == "char" and arg1 == "1" then
        print("Computer output: Turtle on.")
        active = "on"
        rednet.send(turtleID1, "on", "instruction")
    end

    -- Bring turtle to its current set home
    if event == "char" and arg1 == "2" then
        print("Attempting to return turtle.")
        print("Attempt: 1")
        rednet.send(turtleID1, "return", "instruction")

        local responded = false
        local attempt = 1

        if active == "on" then
            print("You must deactive the turtle first")
            responded = true
        end

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



    -- Toggle remote control
    if event == "char" and arg1 == "/" then
        if active == "on" then
            print("You must deactivate the turtle first")
        elseif remoteControl == "off" then
            remoteControl = "on"
            print("Enabled turtle remote control")
        elseif remoteControl == "on" then
            remoteControl = "off"
            print("Disabled turtle remote control")
        end
    end


    --[[
    keyUp = 265
    keyDown = 264
    keyLeft = 263
    keyRight = 262
    pgUp = 266
    pgDown = 267
    ]]--

    -- Turtle move up
    if event == "key" and arg1 == 266 then
        if remoteControl == "on" then
            rednet.send(turtleID1, "up")
        else
            print("remoteControl off")
        end
    end
    
    -- Turtle move down
    if event == "key" and arg1 == 267 then
        if remoteControl == "on" then
            rednet.send(turtleID1, "down")
        else
            print("remoteControl off")
        end
    end
    
    -- Turtle move forward
    if event == "key" and arg1 == 265 then
        if remoteControl == "on" then
            rednet.send(turtleID1, "forward")
        else
            print("remoteControl off")
        end
    end

    -- Turtle move back
    if event == "key" and arg1 == 264 then
        if remoteControl == "on" then
            rednet.send(turtleID1, "back")
        else
            print("remoteControl off")
        end
    end
    
    -- Turtle turn left
    if event == "key" and arg1 == 263 then
        if remoteControl == "on" then
            rednet.send(turtleID1, "left")
        else
            print("remoteControl off")
        end
    end
    
    -- Turtle turn right
    if event == "key" and arg1 == 262 then
        if remoteControl == "on" then
            rednet.send(turtleID1, "right")
        else 
            print("remoteControl off")
        end
    end


    -- Get the coords of the turtle to be able to track easier
    if event == "char" and arg1 == "+" then
        if remoteControl == "on" then
            rednet.send(turtleID1, "coords")
        else
            print("remoteControl off")
        end
    end

    -- kills program the computer and turtle is running
    if event == "terminate" then
        
        rednet.send(turtleID1, "termination", "instruction")
        term.setTextColor(colors.red)
        print("Terminated code")
        print("This is a custom termination")
        term.setTextColor(colors.white)
        working = false

    end
end