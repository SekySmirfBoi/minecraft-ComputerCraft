function returnHome()
    


    -------------------------------------------------
    -------------------------------------------------
    -------------------------------------------------
    -------------------------------------------------

    local success, data = turtle.inspect()

    if data.name == nil then
        data.name = "notTheRightOne"
    end

    while data.name ~= "minecraft:crafting_table" then
        turtle.left()
        success, data = turtle.inspect() 
    end
    
    turtle.left()
    turtle.left()
end

function moveUp()
    local success, err = turtle.up()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then        
        print("Successfully moved up"); rednet.send(masterComputerID, "Successfully moved up", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function moveDown()
    
    local x, y, z = gps.locate()

    if y == 5 then
        print("Will not go below y-level 5."); rednet.send(masterComputerID, "Will not go below y-level 5.", "compDisplay")
        print("This is to prevent the turtle getting stuck under bedrock"); rednet.send(masterComputerID, "This is to prevent the turtle getting stuck under bedrock", "compDisplay")
        return
    end

    local success, err = turtle.down()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        print("Successfully moved down"); rednet.send(masterComputerID, "Successfully moved down", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function moveForwards()
    local success, err = turtle.forward()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        print("Successfully moved forward"); rednet.send(masterComputerID, "Successfully moved forward", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function moveBackwards()
    local success, err = turtle.back()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        print("Successfully moved back"); rednet.send(masterComputerID, "Successfully moved back", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function turnLeft()
    local success, err = turtle.turnLeft()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        print("Successfully turned left"); rednet.send(masterComputerID, "Successfully turned left", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function turnRight()
    local success, err = turtle.turnRight()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        print("Successfully turned right"); rednet.send(masterComputerID, "Successfully turned right", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function work()
    local x, y, z = gps.locate()

    if y == 5 then
    end
end

rednet.open("left")

print()
print("---------------------------------------")
print()
print("   _____    _____   ____  ")
print(" / ____|  / ____| |  _ \\ ")
print("| (___   | (___   | |_) |")
print(" \\___ \\   \\___ \\  |  _ < ")
print(" ____) |  ____) | | |_) |")
print("|_____/  |_____/  |____/ ")
print()
print("---------------------------------------")

thisTurtleID = os.getComputerID()   -- thisTurtleID -- The ID of this turtle
masterComputerID = 12   -- masterComputerID -- The computer in control of everything
comp2ID = 19    -- secondComputerID -- Just a second unused computer

local homeX = 572
local homeY = 64
local homeZ = 257

print()
print("Turtle ready to receive instructions")
print("Listeneing for messages")
print()

local active = "off"
local echoed = false

local loopRunning = true

while loopRunning do

    local osEvent, osArg1, osArg2, osArg3, osArg4, osArg5 = os.pullEventRaw()

    if osEvent == "rednet_message" then
        local sender = osArg1
        local message = osArg2
        local protocol = osArg3

        if sender == masterComputerID then

            -- Responds back to thr master computer saying that it is online
            if message == "echo" and protocol == "instruction" then
                rednet.send(sender, "received")
                print()
                print("Echoing")
                echoed = true
            end

            -- disables the turtle after the master computer tells it to
            if message == "off" and protocol == "instruction" then
                active = "off"
                print("Turtle off")
            end

            -- enables the turtle after the master computer tells it to
            if message == "on" and protocol == "instruction" then
                active = "on"
                print("Turtle on")
            end

            -- sends the turtle back home
            if message == "return" and protocol == "instruction" then
                rednet.send(masterComputerID, "returningHome", "notSleep")
                print("Returning home")
                returnHome()
            end

            --updates the turtles home
            if message == "newHome" and protocol == "instruction" then
                print("Setting new home coords as:")
                updateHomeCoords()
            end

            -- termination after getting the instruction from the master computer
            if message == "termination" and protocol == "instruction" then
                term.setTextColor(colors.red)
                print("Why kill me?")
                print()
                term.setTextColor(colors.lightBlue)
                print("It's because I'm a turtle isn't it :(")
                print("Tell my family that I love them")
                print("Why would you ever do that, you're the one who killed me")
                term.setTextColor(colors.white)
                loopRunning = false
            end




            --moves turtle up
            if message == "up" then
                moveUp()
            end
            
            --moves turtle down
            if message == "down" then
                moveDown()
            end

            --moves turtle forward
            if message == "forward" then
                moveForwards()
            end

            --moves turtle backwards
            if message == "back" then
                moveBackwards()
            end

            --turns turtle left
            if message == "left" then
                turnLeft()
            end

            --turns turtle 
            if message == "right" then
                turnRight()
            end

            -- sends the master computer its coords
            if message == "coords" then
                local x, y, z = gps.locate()
                print("X: "..x); rednet.send(masterComputerID, x, "getCoordsX")
                print("Y: "..y); rednet.send(masterComputerID, y, "getCoordsY")
                print("Z: "..z); rednet.send(masterComputerID, z, "getCoordsZ")
            end
        end

    -- custom terminate
    elseif osEvent == "terminate" then
        
        rednet.send(masterComputerID, "termination", "userCommand")
        term.setTextColor(colors.red)
        print("Why kill me?")
        print()
        term.setTextColor(colors.lightBlue)
        print("It's because I'm a turtle isn't it :(")
        print("Tell my family that I love them")
        print("Why would you ever do that, you're the one who killed me")
        term.setTextColor(colors.white)
        loopRunning = false


    --turtle goes and works
    elseif echoed and active == "on" then
        work()
    end
end