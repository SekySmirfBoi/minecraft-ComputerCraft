rednet.open("back")

local turtleID1 = 52

local working = false

local eResponded = false
local eSender, eMessage, eProtocol


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
print()
print("Echoing turtle")

while not eResponded do
    rednet.send(turtleID1, "echo", "instruction")
    eSender, eMessage, eProtocol = rednet.receive(nil, 2)
    print("Echoing turtle")

    if eSender == turtleID1 and eMessage == "received" then
        eResponded = true
        print()
        print("----------------------------------------------")
        print()
        print("Turtle has started")
        print()
        print("Press 0 to stop the turtle from working")
        print("Press 1 to start the turtle working")
        print("Press 2 to toggle the turtle to dig a 2 high tunnel")
        print()
        print("Press home to return turtle to its pre set home")
        print("Press # to orient the turtle while at home")
        print("Press + to get the turtle's coordinates")
        print()
        print("Remote control:")
        print("Press / to toggle the remote control")
        print("Press up arrow to move the turtle forwards")
        print("Press down arrow to move the turtle backwards")
        print("Press left arrow to turn the turtle left")
        print("Press right arrow to turn the turtle right")
        print("Press page up to move the turtle up")
        print("Press page down to move the turtle down")
        print("Press e to empty turtle's inventory at home")
        print()
        print("Press f1 to break up block")
        print("Press f2 to break front block")
        print("Press f3 to break down block")
        print()
        print("Press f4 to place up block")
        print("Press f5 to place front block")
        print("Press f6 to place down block")
        print()
        working = true
    end
end

local HighThing = "on"
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
                
                rednet.send(turtleID1, "termination", "instruction")
                term.setTextColor(colors.red)
                print("Terminated code")
                print("This is a custom termination")
                term.setTextColor(colors.white)
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
        print("Turtle off.")
        active = "off"
        print()
        local disableAttempt = 1
        local disableResponded = false

        while disableResponded == false do
            print("Attempt: "..disableAttempt)
            rednet.send(turtleID1, "off", "instruction")   
            local respSender, respMessage, respProtocol = rednet.receive(nil, 0.2)

            if respMessage == "recieved" and respProtocol == "recieved" then
                disableResponded = true
            else
                disableAttempt = disableAttempt + 1
            end
        end

        print()
        print("Turtle responded in "..disableAttempt.." attempts")
        print("Just so you know you have to return it home yourself")
        print("To do this just press the home button on your keyboard")
    end

    -- Start the turtle moving and mining
    if event == "char" and arg1 == "1" then
        print("Turtle on.")
        active = "on"
        rednet.send(turtleID1, "on", "instruction")
    end

    if event == "char" and arg1 == "2" then
        if HighThing == "off" then
            HighThing = "on"
            print("The turtle now digs 2 high tunnels")
            rednet.send(turtleID1, "toggle2High", "instruction")
        elseif HighThing == "on" then
            HighThing = "off"
            print("The turtle won't digs high tunnels")
            rednet.send(turtleID1, "toggle2High", "instruction")
        end
    end

    -- Bring turtle to its current set home
    if event == "key" and arg1 == 268 then
        
        if active == "on" then
            print("Turtle off.")
            active = "off"
            rednet.send(turtleID1, "off", "instruction")
        end

        print()
        print("Attempting to return turtle.")
        print("Attempt: 1")
        rednet.send(turtleID1, "return", "instruction")

        local responded = false
        local attempt = 1

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

    -- Orient the trutle
    if event == "char" and arg1 == "#" then
        print()
        print("Orientating turtle")
        rednet.send(turtleID1, "orient", "instruction")
    end

    -- Empty inventory do
    if event == "char" and arg1 == "e" then
        print()
        print("Emtpying inventory")
        rednet.send(turtleID1, "inventoryEmtpyHome", "instruction")
    end


    --[[
    keyUp = 265
    keyDown = 264
    keyLeft = 263
    keyRight = 262
    pgUp = 266
    pgDown = 267

    leftShift = 340
    tab = 258
    leftAlt = 342

    f1 = 290
    f2 = 291
    f3 = 292
    f4 = 293
    f5 = 294
    f6 = 295
    f7 = 296
    f8 = 297
    f9 = 298
    f10 = 299
    f11 = 300
    f12 = 301
    f13 = 302
    f14 = 303
    f15 = 304
    f16 = 305
    f17 = 306
    f18 = 307
    f19 = 308
    f20 = 309
    f21 = 310
    f22 = 311
    f23 = 312
    f24 = 313
    ]]--

    -- destroy up
    if event == "key" and arg1 == 290 then
        print()
        print("Attempting to destroy up block")
        rednet.send(turtleID1, "destroyUp", "instruction")
    end

    -- destroy front
    if event == "key" and arg1 == 291 then
        print()
        print("Attempting to destroy front block")
        rednet.send(turtleID1, "destroyFront", "instruction")
    end

    -- destroy down
    if event == "key" and arg1 == 292 then
        print()
        print("Attempting to destroy down block")
        rednet.send(turtleID1, "destroyDown", "instruction")
    end

    -- place up
    if event == "key" and arg1 == 293 then
        print()
        print("Attempting to place up block")
        rednet.send(turtleID1, "placeUp", "instruction")
    end

    -- place front
    if event == "key" and arg1 == 294 then
        print()
        print("Attempting to place front block")
        rednet.send(turtleID1, "placeFront", "instruction")
    end

    -- place down
    if event == "key" and arg1 == 295 then
        print()
        print("Attempting to place down block")
        rednet.send(turtleID1, "placeDown", "instruction")
    end

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

    rednet.send(turtleID1, "workYouBastard", "instruction")
end