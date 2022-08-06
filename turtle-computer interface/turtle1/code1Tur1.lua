function returnHome()

    local x, y, z = gps.locate()

    while y > 5 do
        if turtle.detectDown() then
            digBlock("down")
        end
        moveDown()
        x, y, z = gps.locate()
        if turtle.getFuelLevel == 0 then
            print(); rednet.send(masterComputerID, "", "compDisplay")
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
            return
        end
    end

    correctYIfAtHome()

    local oldDifX = 0
    local newDifX = 0

    local oldZ = 0
    local newZealand = 0

    x, y, z = gps.locate()
    oldZ = z

    if x < homeX then
        
        oldDifX = homeX - x

        if turtle.detect() then
            digBlock("front")
        end
        moveForwards()
        x, y, z = gps.locate()
        newZealand = z
        if oldZ ~= newZealand then
            moveBackwards()
            turnRight()
            if turtle.detect() then
                digBlock("front")
            end
            moveForwards()
        end

        x, y, z = gps.locate()

        newDifX = homeX - x

    elseif x > homeX then

        oldDifX = x - homeX

        if turtle.detect() then
            digBlock("front")
        end
        moveForwards()
        x, y, z = gps.locate()
        newZealand = z
        if oldZ ~= newZealand then
            moveBackwards()
            turnRight()
            if turtle.detect() then
                digBlock("front")
            end
            moveForwards()
        end

        x, y, z = gps.locate()

        x, y, z = gps.locate()

        newDifX = x - homeX
    end


    if oldDifX < newDifX then
        turnLeft()
        turnLeft()
    end

    x, y, z = gps.locate()

    while x ~= homeX do
        if turtle.detect() then
            digBlock("front")
        end
        moveForwards()
        x, y, z = gps.locate()
        if turtle.getFuelLevel == 0 then
            print(); rednet.send(masterComputerID, "", "compDisplay")
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
            return
        end
    end

    correctYIfAtHome()

    x, y, z = gps.locate()

    while x ~= homeX do
        if turtle.detect() then
            digBlock("front")
        end
        moveForwards()
        x, y, z = gps.locate()
        if turtle.getFuelLevel == 0 then
            print(); rednet.send(masterComputerID, "", "compDisplay")
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
            return
        end
    end


    ------------------------------------------------------------

    correctYIfAtHome()

    local oldDifZ = 0
    local newDifZ = 0

    local oldX = 0
    local newX = 0

    x, y, z = gps.locate()
    oldX = x

    if z < homeZ then
        
        oldDifZ = homeZ - z

        if turtle.detect() then
            digBlock("front")
        end
        moveForwards()
        x, y, z = gps.locate()
        newX = x
        if oldX ~= newX then
            moveBackwards()
            turnRight()
            if turtle.detect() then
                digBlock("front")
            end
            moveForwards()
        end

        x, y, z = gps.locate()

        newDifZ = homeZ - z

    elseif z > homeZ then

        oldDifZ = z - homeZ

        if turtle.detect() then
            digBlock("front")
        end
        moveForwards()
        x, y, z = gps.locate()
        newX = x
        if oldX ~= newX then
            moveBackwards()
            turnRight()
            if turtle.detect() then
                digBlock("front")
            end
            moveForwards()
        end

        x, y, z = gps.locate()

        newDifZ = z - homeZ
    end


    if oldDifZ < newDifZ then
        turnLeft()
        turnLeft()
    end

    x, y, z = gps.locate()

    while z ~= homeZ do
        if turtle.detect() then
            digBlock("front")
        end
        moveForwards()
        x, y, z = gps.locate()
        if turtle.getFuelLevel == 0 then
            print(); rednet.send(masterComputerID, "", "compDisplay")
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
            return
        end
    end

    -----------------------------------------------------------------------------------------------

    correctYIfAtHome()
end


function correctTurtleFacing() 
    local success, data = turtle.inspect()

    local x, y, z = gps.locate()

    if x == homeX and y == homeY and z == homeZ then

        while data.name ~= "minecraft:chest" do
            turnLeft()
            success, data = turtle.inspect() 
        end
    else
        print("Turtle not at home"); rednet.send(masterComputerID, "Turtle not at home", "compDisplay")
    end        
end

function correctYIfAtHome()

    local x, y, z = gps.locate()

    if x == homeX and z == homeZ then

        while y < 64 do
            if turtle.detectUp() then
                digBlock("up")
            end
            moveUp()
            x, y, z = gps.locate()
            if turtle.getFuelLevel == 0 then
                print(); rednet.send(masterComputerID, "", "compDisplay")
                print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
                return
            end
        end

        while y > 64 do
            if turtle.detectDown() then
                digBlock("down")
            end
            moveDown()
            x, y, z = gps.locate()
            if turtle.getFuelLevel == 0 then
                print(); rednet.send(masterComputerID, "", "compDisplay")
                print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
                return
            end
        end

        print(); rednet.send(masterComputerID, "", "compDisplay")
        print("Returned home"); rednet.send(masterComputerID, "Returned home", "compDisplay")

        correctTurtleFacing()
        return
    end
end


function dropInventory(dir)

    local prevSlot = turtle.getSelectedSlot()

    if dir == "front" then

        turtle.select(1)
        
        for i = 1, 16, 1 do
            turtle.select(i)
            turtle.drop()
        end

        turtle.select(prevSlot)

    elseif dir == "up" then
        
        turtle.select(1)
        
        for i = 1, 16, 1 do
            turtle.select(i)
            turtle.dropUp()
        end

        turtle.select(prevSlot)

    elseif dir == "down" then
        
        turtle.select(1)
        
        for i = 1, 16, 1 do
            turtle.select(i)
            turtle.dropDown()
        end

        turtle.select(prevSlot)

    end
end

function emptyInventoryAtHome()
    
    local x, y, z = gps.locate()

    if x == homeX and y == homeY and x == homeX then
        correctTurtleFacing()
        rednet.send(masterComputerID, "Emptying inventory", "compyDisplay")
        dropInventory("front");
    else
        print("Turtle not at home"); rednet.send(masterComputerID, "Turtle not at home", "compyDisplay")
    end
end

function getItemSlot(itemName)

    if itemName == nil then
        return nil;
    end

    local prevSlot = turtle.getSelectedSlot()

    for i = 1, 16, 1 do
        turtle.select(i)
        
        if turtle.getItemDetail().name == itemName then
            return turtle.getSelectedSlot()
        end
    end
end


function digBlock(dir) 
    local success, err
    local succ, data

    local x, y, z = gps.locate()

    if dir == "front" or dir == nil then
        succ, data = turtle.inspect()
        if x == homeX and y == homeY and z == homeZ then
            print("Will not break blocks while at home")
            success = false
            err = "Turtle at home"
        else
            success, err = turtle.dig()
        end
    elseif dir == "down" then
        succ, data = turtle.inspectDown()
        if x == homeX and y == homeY and z == homeZ then
            print("Will not break blocks while at home")
            success = false
            err = "Turtle at home"
        else
            success, err = turtle.digDown()
        end
    elseif dir == "up" then
        succ, data = turtle.inspectUp()
        if x == homeX and y == homeY and z == homeZ then
            print("Will not break blocks while at home")
            success = false
            err = "Turtle at home"
        else
            success, err = turtle.digUp()
        end
    else
        return
    end

    if success then
        print()
        print("Mined block: "..data.name); rednet.send(masterComputerID, "Mined block: "..data.name, "compDisplay")
    else
        print()
        print("Failed to mine block"); rednet.send(masterComputerID, "Failed to mine block", "compDisplay")
        print("Reason: "..err); rednet.send(masterComputerID, "Reason: "..err, "compDisplay")
    end
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
    print(); rednet.send(masterComputerID, "", "compDisplay")
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
masterComputerID = 53   -- masterComputerID -- The computer in control of everything
comp2ID = 19    -- secondComputerID -- Just a second unused computer

homeX = 572
homeY = 64
homeZ = 257

nextMove = ""
miningVein = false

print()
print("Turtle ready to receive instructions")
print("Listeneing for messages")
print()

active = "off"
echoed = false

loopRunning = true

while loopRunning do

    local osEvent, osArg1, osArg2, osArg3, osArg4, osArg5 = os.pullEventRaw()

    if osEvent == "rednet_message" then
        local sender = osArg1
        local message = osArg2
        local protocol = osArg3

        if sender == masterComputerID then

            -- Responds back to thr master computer saying that it is online
            if message == "echo" and protocol == "instruction" then
                rednet.send(masterComputerID, "received")
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
            
            -- empties inventory into the home chest
            if message == "inventoryEmtpyHome" and protocol == "instruction" then
                emptyInventoryAtHome()
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



            -- destroy up block
            if message == "destroyUp" and protocol == "instruction" then
                digBlock("up")
            end

            if message == "destroyFront" and protocol == "instruction" then
                digBlock("front")
            end

            if message == "destroyDown" and protocol == "instruction" then
                digBlock("down")
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

            -- orients the turtle
            if message == "orient" then
                correctTurtleFacing()
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
        nextMove = work(nextMove)
    end
end