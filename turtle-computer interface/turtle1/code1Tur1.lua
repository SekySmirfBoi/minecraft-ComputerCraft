
---------------Change these variables---------------

--[[
The turtle will return to this position when its 
inventory is full, when it's low on fuel, or when 
the player requests it via the master computer
]]--

homeX = 572     -- X coordinate of the turtle's home
homeY = 64      -- Y coordinate of the turtle's home
homeZ = 257     -- Z coordinate of the turtle's home

masterComputerID = 53   -- masterComputerID -- The computer in control of everything
turtleMonitorID = 61    -- secondComputerID -- Just a second unused computer
---------------------------------------------------------------



------------You do not need to change this variable------------
---------------------------------------------------------------
thisTurtleID = os.getComputerID()   -- The ID of this turtle -- 
---------------------------------------------------------------

--snepsdfgdkfjghdkgjhzdlrjkgh


function prinTCum(message) 

    if message == nil then
        print()
    else
        print(message)
    end

    rednet.send(turtleMonitorID, message, "display")
end




function returnHome()

    local x, y, z = gps.locate()
    rednet.send(masterComputerID, "X: "..x, "actuallyPrintThisPls")
    rednet.send(masterComputerID, "Y: "..y, "actuallyPrintThisPls")
    rednet.send(masterComputerID, "Z: "..z, "actuallyPrintThisPls")

    while y > 5 do
        if turtle.detectDown() then
            digBlock("down")
        end
        moveDown()
        x, y, z = gps.locate()
        if turtle.getFuelLevel == 0 then
            prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
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
            prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
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
            prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
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
            prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
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
        prinTCum("Turtle not at home"); rednet.send(masterComputerID, "Turtle not at home", "compDisplay")
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
                prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
                prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
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
                prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
                prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
                return
            end
        end

        prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
        prinTCum("Returned home"); rednet.send(masterComputerID, "Returned home", "compDisplay")

        correctTurtleFacing()
        return
    end
end



function dropInventory(dir)

    local prevSlot = turtle.getSelectedSlot()

    if dir == "front" or dir == nil then

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
        prinTCum("Turtle not at home"); rednet.send(masterComputerID, "Turtle not at home", "compyDisplay")
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
            turtle.select(prevSlot)
            return turtle.getSelectedSlot()
        end
    end

    return nil;
end

function getCurrentSlotData()
    if turtle.getItemDetail() == nil then
        return nil
    end

    return turtle.getItemDetail()
end

function getLeastValue()
    --[[
    local valuable = {"minecraft:diamond", 
    "minecraft:diamond_ore",
    "minecraft:iron_ore",
    "minecraft:iron_ingot",
    "minecraft:coal", 
    "minecraft:coal_ore",
    "minecraft:gold_ore", 
    "minecraft:gold_ingot",
    "minecraft:emerald", 
    "minecraft:emerald_old",
    "minecraft:lapis_lazuli", 
    "minecraft:lapis_ore",
    "minecraft:redstone",
    "minecraft:redstone_ore"}
    ]]--

    local notValuable = {
        "minecraft:dirt",
        "minecraft:stone",
        "minecraft:granite",
        "minecraft:diorite",
        "minecraft:andesite",
        "minecraft:cobblestone",
        "minecraft:gravel"
    }

    local prevSlot = turtle.getSelectedSlot()

    for i = 1, 16, 1 do
        turtle.select(i)

        for key, item in ipairs(notValuable) do
            if item == getCurrentSlotData().name then
                turtle.select(prevSlot)
                return i
            end
        end

        return false
    end
end


function checkInventoryIfFull() 

    local prevSlot = turtle.getSelectedSlot()

    for i = 1, 16, 1 do
        turtle.select(i)

        if getCurrentSlotData() == nil then
            turtle.select(prevSlot)
            return false
        end
    end

    turtle.select(prevSlot)

    return true
end




function digBlock(dir) 
    local success, err
    local succ, data

    local x, y, z = gps.locate()

    if dir == "front" or dir == nil then
        succ, data = turtle.inspect()
        if x == homeX and y == homeY and z == homeZ then
            prinTCum("Will not break blocks while at home")
            success = false
            err = "Turtle at home"
        else
            success, err = turtle.dig()
        end
    elseif dir == "down" then
        succ, data = turtle.inspectDown()
        if x == homeX and y == homeY and z == homeZ then
            prinTCum("Will not break blocks while at home")
            success = false
            err = "Turtle at home"
        else
            success, err = turtle.digDown()
        end
    elseif dir == "up" then
        succ, data = turtle.inspectUp()
        if x == homeX and y == homeY and z == homeZ then
            prinTCum("Will not break blocks while at home")
            success = false
            err = "Turtle at home"
        else
            success, err = turtle.digUp()
        end
    else
        return
    end

    if success then
        prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
        prinTCum("Mined block: "..data.name); rednet.send(masterComputerID, "Mined block: "..data.name, "compDisplay")
    else
        prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
        prinTCum("Failed to mine block"); rednet.send(masterComputerID, "Failed to mine block", "compDisplay")
        prinTCum("Reason: "..err); rednet.send(masterComputerID, "Reason: "..err, "compDisplay")
    end
end

function placeBlock(dir)
    local success
    local err
    local data

    if getCurrentSlotData() == nil then
        success = false
        err = "No block in current slot"

    elseif dir == "front" or dir == nil then
        if turtle.detect() then
            err = "Block in way"
        else
            data = getCurrentSlotData()
            success = turtle.place()
        end
    elseif dir == "up" then
        if turtle.detectUp() then
            err = "Block in way"
        else
            data = getCurrentSlotData()
            success = turtle.placeUp()
        end
    elseif dir == "down" then
        if turtle.detectDown() then
            err = "Block in way"
        else
            data = getCurrentSlotData()
            success = turtle.placeDown()
        end

    else
        return
    end

    if success then
        prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
        prinTCum("Placed block: "..data.name); rednet.send(masterComputerID, "Placed block: "..data.name, "compDisplay")
    else
        prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
        prinTCum("Failed to place block"); rednet.send(masterComputerID, "Failed to place block", "compDisplay")
        prinTCum("Reason: "..err); rednet.send(masterComputerID, "Reason: "..err, "compDisplay")
    end
end


function moveUp()
    local success, err = turtle.up()
    prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
    prinTCum("Fuel left: "..turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then        
        prinTCum("Successfully moved up"); rednet.send(masterComputerID, "Successfully moved up", "compDisplay")
    else
        prinTCum()
        prinTCum("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            prinTCum("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            prinTCum("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function moveDown()
    
    local x, y, z = gps.locate()

    if y == 5 then
        prinTCum("Will not go below y-level 5."); rednet.send(masterComputerID, "Will not go below y-level 5.", "compDisplay")
        prinTCum("This is to prevent the turtle getting stuck under bedrock"); rednet.send(masterComputerID, "This is to prevent the turtle getting stuck under bedrock", "compDisplay")
        return
    end

    local success, err = turtle.down()
    prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
    prinTCum("Fuel left: "..turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        prinTCum("Successfully moved down"); rednet.send(masterComputerID, "Successfully moved down", "compDisplay")
    else
        prinTCum()
        prinTCum("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            prinTCum("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            prinTCum("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function moveForwards()
    local success, err = turtle.forward()
    prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
    prinTCum("Fuel left: "..turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        prinTCum("Successfully moved forward"); rednet.send(masterComputerID, "Successfully moved forward", "compDisplay")
    else
        prinTCum()
        prinTCum("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            prinTCum("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            prinTCum("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function moveBackwards()
    local success, err = turtle.back()
    prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
    prinTCum("Fuel left: "..turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        prinTCum("Successfully moved back"); rednet.send(masterComputerID, "Successfully moved back", "compDisplay")
    else
        prinTCum()
        prinTCum("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            prinTCum("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            prinTCum("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function turnLeft()
    local success, err = turtle.turnLeft()
    prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
    prinTCum("Fuel left: ".turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        prinTCum("Successfully turned left"); rednet.send(masterComputerID, "Successfully turned left", "compDisplay")
    else
        prinTCum()
        prinTCum("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            prinTCum("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            prinTCum("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function turnRight()
    local success, err = turtle.turnRight()
    prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
    prinTCum("Fuel left: "..turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        prinTCum("Successfully turned right"); rednet.send(masterComputerID, "Successfully turned right", "compDisplay")
    else
        prinTCum()
        prinTCum("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            prinTCum("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            prinTCum("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            prinTCum("Unknown error: "..err); rednet.send(masterComputerID, "Unknown error: "..err, "compDisplay")
        end
    end
end

function work(currY)

    prinTCum("did the thing")
    local mesId, mesMes = rednet.receive("instruction", 0.25)

    if mesId ~= nil then
        if mesId == masterComputerID and mesMes == "off" then
            rednet.send(mesId, "recieved", "recieved")
            return true
        end
        if mesId == masterComputerID and mesMes == "return" then
            rednet.send(mesId, "returningHome", "notSleep")
            returnHome()
            return true
        end
    end

    if currY == 5 then
        if turtle.detect() then
            digBlock("front")
        end

        if HighMine == "on" then
            digBlock("up")
        end

        if turtle.detectUp() then
            local succ, data = turtle.inspectUp()

            if data.name == "minecraft:gold_ore" or 
            data.name == "minecraft:iron_ore" or 
            data.name == "minecraft:coal_ore" or 
            data.name == "minecraft:lapis_ore" or 
            data.name == "minecraft:diamond_ore" or 
            data.name == "minecraft:redstone_ore" or 
            data.name == "minecraft:emerald_ore" then
                digBlock("up")
            end
        end

        ------------------------------------------------

        moveUp()

        if turtle.detectUp() then
            local succ, data = turtle.inspectUp()

            if data.name == "minecraft:gold_ore" or 
            data.name == "minecraft:iron_ore" or 
            data.name == "minecraft:coal_ore" or 
            data.name == "minecraft:lapis_ore" or 
            data.name == "minecraft:diamond_ore" or 
            data.name == "minecraft:redstone_ore" or 
            data.name == "minecraft:emerald_ore" then
                digBlock("up")
            end
        end

        turnLeft()
        
        if turtle.detect() then
            local succ, data = turtle.inspect()

            if data.name == "minecraft:gold_ore" or 
            data.name == "minecraft:iron_ore" or 
            data.name == "minecraft:coal_ore" or 
            data.name == "minecraft:lapis_ore" or 
            data.name == "minecraft:diamond_ore" or 
            data.name == "minecraft:redstone_ore" or 
            data.name == "minecraft:emerald_ore" then
                digBlock("front")
            end
        end

        turnRight()
        turnRight()

        if turtle.detect() then
            local succ, data = turtle.inspect()

            if data.name == "minecraft:gold_ore" or 
            data.name == "minecraft:iron_ore" or 
            data.name == "minecraft:coal_ore" or 
            data.name == "minecraft:lapis_ore" or 
            data.name == "minecraft:diamond_ore" or 
            data.name == "minecraft:redstone_ore" or 
            data.name == "minecraft:emerald_ore" then
                digBlock("front")
            end
        end

        turnLeft()

        moveDown()

        ------------------------------------------------

        if turtle.detectDown() then
            local succ, data = turtle.inspectDown()

            if data.name == "minecraft:gold_ore" or 
            data.name == "minecraft:iron_ore" or 
            data.name == "minecraft:coal_ore" or 
            data.name == "minecraft:lapis_ore" or 
            data.name == "minecraft:diamond_ore" or 
            data.name == "minecraft:redstone_ore" or 
            data.name == "minecraft:emerald_ore" then
                digBlock("down")
            end
        end

        turnLeft()

        if turtle.detect() then
            local succ, data = turtle.inspect()

            if data.name == "minecraft:gold_ore" or 
            data.name == "minecraft:iron_ore" or 
            data.name == "minecraft:coal_ore" or 
            data.name == "minecraft:lapis_ore" or 
            data.name == "minecraft:diamond_ore" or 
            data.name == "minecraft:redstone_ore" or 
            data.name == "minecraft:emerald_ore" then
                digBlock("front")
            end
        end

        turnRight()
        turnRight()

        if turtle.detect() then
            local succ, data = turtle.inspect()

            if data.name == "minecraft:gold_ore" or 
            data.name == "minecraft:iron_ore" or 
            data.name == "minecraft:coal_ore" or 
            data.name == "minecraft:lapis_ore" or 
            data.name == "minecraft:diamond_ore" or 
            data.name == "minecraft:redstone_ore" or 
            data.name == "minecraft:emerald_ore" then
                digBlock("front")
            end
        end

        turnLeft()

        moveForwards()
    else
        local x, y, z = gps.locate()
        prinTCum()
        prinTCum("Moving down to y 5")
        prinTCum("You can't control it while it is doing this")
        while y > 5 do
            if turtle.detectDown() then
                digBlock("down")
            end
            moveDown()
            x, y, z = gps.locate()
        end
        prinTCum()
        prinTCum("Finished moving down")
    end

    if checkInventoryIfFull() then

        local tempMemory = getLeastValue()

        if tempMemory == false then
            returnHome()
            emptyInventoryAtHome()
        elseif tempMemory >= 1 and tempMemory <= 16 then
            turtle.select(tempMemory)
            turtle.drop()
        else
            prinTCum()
            prinTCum("Error"); rednet.send(masterComputerID, "Error", "compDisplay")
            prinTCum("tempMemory: "..tempMemory); rednet.send(masterComputerID, "tempMemory: "..tempMemory, "compDisplay")
            prinTCum(); rednet.send(masterComputerID, "", "compDisplay")
            prinTCum("You fix the problem, I'm too lazy"); rednet.send(masterComputerID, "You fix the problem, I'm too lazy", "compDisplay")
        end
    end

    local x, y, z = gps.locate()

    local disHomeX = homeX - x
    local disHomeY = homeY - y
    local disHomeZ = homeZ - z

    if disHomeX < 0 then
        disHomeX = disHomeX * -1
    end
    if disHomeY < 0 then
        disHomeY = disHomeY * -1
    end
    if disHomeZ < 0 then
        disHomeZ = disHomeZ * -1
    end

    local disFromHome = disHomeX + disHomeY + disHomeZ

    if turtle.getFuelLevel() <= disFromHome + 100 then
        
        local tempMemory = getItemSlot("minecraft:coal_block")
        local prevSlot = turtle.getSelectedSlot()

        if tempMemory == nil then
            tempMemory = getItemSlot("minecraft:coal")
            if tempMemory == nil then
                prinTCum("Turtle out of fuel")
                prinTCum("Returning home")
                returnHome()
                return true
            end
        end

        turtle.select(tempMemory)
        turtle.refuel(64)
        
    end
end

rednet.open("left")

prinTCum()
prinTCum("---------------------------------------")
prinTCum()
prinTCum("   SSSSSSSSSSSSSSS         SSSSSSSSSSSSSSS      BBBBBBBBBBBBBBBBB   ")
prinTCum(" SS:::::::::::::::S      SS:::::::::::::::S     B::::::::::::::::B  ")
prinTCum("S:::::SSSSSS::::::S     S:::::SSSSSS::::::S     B::::::BBBBBB:::::B ")
prinTCum("S:::::S     SSSSSSS     S:::::S     SSSSSSS     BB:::::B     B:::::B")
prinTCum("S:::::S                 S:::::S                   B::::B     B:::::B")
prinTCum("S:::::S                 S:::::S                   B::::B     B:::::B")
prinTCum(" S::::SSSS               S::::SSSS                B::::BBBBBB:::::B ")
prinTCum("  SS::::::SSSSS           SS::::::SSSSS           B:::::::::::::BB  ")
prinTCum("    SSS::::::::SS           SSS::::::::SS         B::::BBBBBB:::::B ")
prinTCum("       SSSSSS::::S             SSSSSS::::S        B::::B     B:::::B")
prinTCum("            S:::::S                 S:::::S       B::::B     B:::::B")
prinTCum("            S:::::S                 S:::::S       B::::B     B:::::B")
prinTCum("SSSSSSS     S:::::S     SSSSSSS     S:::::S     BB:::::BBBBBB::::::B")
prinTCum("S::::::SSSSSS:::::S     S::::::SSSSSS:::::S     B:::::::::::::::::B ")
prinTCum("S:::::::::::::::SS      S:::::::::::::::SS      B::::::::::::::::B  ")
prinTCum(" SSSSSSSSSSSSSSS         SSSSSSSSSSSSSSS        BBBBBBBBBBBBBBBBB   ")
prinTCum()
prinTCum("---------------------------------------")

validY = false

HighMine = "on"

if homeY < 5 then
    validY = false
    prinTCum("homeY cannot be less then 5")
else
    validY = true
end

if validY then
    prinTCum()
    prinTCum("Turtle ready to receive instructions")
    prinTCum("Listeneing for messages")
    prinTCum()

    active = "off"
    notContinue = true
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
                    prinTCum("Echoing")
                    echoed = true
                end

                -- disables the turtle after the master computer tells it to
                if message == "off" and protocol == "instruction" then
                    active = "off"
                    prinTCum("Turtle off")
                    rednet.send(masterComputerID, "recieved", "recieved")

                    local x, y, z = gps.locate()
                    rednet.send(masterComputerID, "X: "..x, "actuallyPrintThisPls")
                    rednet.send(masterComputerID, "Y: "..y, "actuallyPrintThisPls")
                    rednet.send(masterComputerID, "Z: "..z, "actuallyPrintThisPls")
                end

                if message == "workYouBastard" and protocol == "instruction" then
                end

                -- enables the turtle after the master computer tells it to
                if message == "on" and protocol == "instruction" then
                    active = "on"
                    prinTCum("Turtle on")

                    local x, y, z = gps.locate()
                    rednet.send(masterComputerID, "X: "..x, "actuallyPrintThisPls")
                    rednet.send(masterComputerID, "Y: "..y, "actuallyPrintThisPls")
                    rednet.send(masterComputerID, "Z: "..z, "actuallyPrintThisPls")
                end

                if message == "toggle2High" and protocol == "instruction" then
                    if HighMine == "off" then
                        HighMine = "on"
                    elseif HighMine == "on" then
                        HighMine = "off"
                    end
                end

                -- sends the turtle back home
                if message == "return" and protocol == "instruction" then
                    rednet.send(masterComputerID, "returningHome", "notSleep")

                    prinTCum("Returning home")
                    returnHome()
                end

                --updates the turtles home
                if message == "newHome" and protocol == "instruction" then
                    prinTCum("Setting new home coords as:")
                    updateHomeCoords()
                end

                -- empties inventory into the home chest
                if message == "inventoryEmtpyHome" and protocol == "instruction" then
                    emptyInventoryAtHome()
                end

                -- termination after getting the instruction from the master computer
                if message == "termination" and protocol == "instruction" then
                    term.setTextColor(colors.red)
                    prinTCum()
                    prinTCum("Why kill me?")
                    prinTCum()
                    term.setTextColor(colors.lightBlue)
                    prinTCum("It's because I'm a turtle isn't it :(")
                    prinTCum("Tell my family that I love them")
                    prinTCum("Why would you ever do that, you're the one who killed me")
                    term.setTextColor(colors.white)
                    loopRunning = false
                end



                -- destroy block
                if message == "destroyUp" and protocol == "instruction" then
                    digBlock("up")
                end

                if message == "destroyFront" and protocol == "instruction" then
                    digBlock("front")
                end

                if message == "destroyDown" and protocol == "instruction" then
                    digBlock("down")
                end


                -- place block
                if message == "placeUp" and protocol == "instruction" then
                    placeBlock("up")
                end

                if message == "placeFront" and protocol == "instruction" then
                    placeBlock("front")
                end

                if message == "placeDown" and protocol == "instruction" then
                    placeBlock("down")
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
                    prinTCum("X: "..x); rednet.send(masterComputerID, x, "getCoordsX")
                    prinTCum("Y: "..y); rednet.send(masterComputerID, y, "getCoordsY")
                    prinTCum("Z: "..z); rednet.send(masterComputerID, z, "getCoordsZ")
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
            prinTCum()
            prinTCum("Why kill me?")
            prinTCum()
            term.setTextColor(colors.lightBlue)
            prinTCum("It's because I'm a turtle isn't it :(")
            prinTCum("Tell my family that I love them")
            prinTCum("Why would you ever do that, you're the one who killed me")
            term.setTextColor(colors.white)
            loopRunning = false


        --turtle goes and works
        elseif echoed and active == "on" then
            
            local x, y, z = gps.locate()
            
            
            notContinue = work(y)

            if notContinue then
                active = "off"
            elseif not notContinue or notContinue == nil then
                active = "on"
            else
                prinTCum("Unknown erro")
            end
        end
    end
end