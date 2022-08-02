function updateWayHomeFile(move, adding)

    if adding == true then
        local f, err = io.open("miningTurtleCode/wayHomeFile.txt", "a")
        local f2, err2 = io.open("miningTurtleCode/wayHomeFile.txt", "r")

        for line in f2:lines() do
            if line ~= "" then
                f:write("\n")
            end
        end

        f:write(move)
        f:close()
        f2:close()
    elseif adding == false then

        local lineCount = 0
        local count = 1
        local f, err = io.open("miningTurtleCode/wayHomeFile.txt", "r")
        local f2, err2 = io.open("miningTurtleCode/wayHomeFile.txt", "w")
        local lineLength = 0

        for line in f:lines() do
            lineCount = lineCount + 1
        end

        for line in f:lines() do
            if count == lineCount then

                lineLength = string.len(line)
                
            end
            count = count + 1
        end

        f2:seek("end", -1 * lineLength)

        while lineLength ~= 0 do
            f2:write("")
            lineLength = lineLength - 1
        end

        f:close()
    end
end



function moveUp(addReturn)
    local success, err = turtle.up()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        
        if addReturn then
            updateWayHomeFile("moveDown", true)
            table.insert( wayHome, 1, "moveDown" )
        end
        
        currentY = tonumber(currentY) + 1
        updateCoords()
        
        print("Successfully moved up, new coordinates:"); rednet.send(masterComputerID, "Successfully moved up, new coordinates:", compDisplay)
        print("X: "..currentX)
        print("Y: "..currentY)
        print("Z: "..currentZ)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function moveDown(addReturn)
    local success, err = turtle.down()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        
        if addReturn then
            updateWayHomeFile("moveUp", true)
            table.insert( wayHome, 1, "moveUp" )
        end
        
        currentY = tonumber(currentY) - 1
        updateCoords()

        print("Successfully moved down, new coordinates:"); rednet.send(masterComputerID, "Successfully moved down, new coordinates:", compDisplay)
        print("X: "..currentX)
        print("Y: "..currentY)
        print("Z: "..currentZ)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function moveForwards(addReturn)
    local success, err = turtle.forward()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        if dirFacing == "north" then
            currentZ = currentZ - 1
        elseif dirFacing == "east" then
            currentX = currentX + 1
        elseif dirFacing == "south" then
            currentZ = currentZ + 1
        elseif dirFacing == "west" then
            currentX = currentX - 1
        end
        
        if addReturn then
            updateWayHomeFile("moveBackwards", true)
            table.insert( wayHome, 1, "moveBackwards" )
        end

        updateCoords()

        print("Successfully moved forward, new coordinates:"); rednet.send(masterComputerID, "Successfully moved forward, new coordinates:", compDisplay)
        print("X: "..currentX)
        print("Y: "..currentY)
        print("Z: "..currentZ)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function moveBackwards(addReturn)
    local success, err = turtle.back()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        if dirArseFacing == "north" then
            currentZ = currentZ - 1
        elseif dirArseFacing == "east" then
            currentX = currentX + 1
        elseif dirArseFacing == "south" then
            currentZ = currentZ + 1
        elseif dirArseFacing == "west" then
            currentX = currentX - 1
        end
        
        if addReturn then
            updateWayHomeFile("moveForwards", true)
            table.insert( wayHome, 1, "moveForwards" )
        end
        
        updateCoords()

        print("Successfully moved back, new coordinates:"); rednet.send(masterComputerID, "Successfully moved back, new coordinates:", compDisplay)
        print("X: "..currentX)
        print("Y: "..currentY)
        print("Z: "..currentZ)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function turnLeft(addReturn)
    local success, err = turtle.turnLeft()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then

        if facing == 0 then
            facing = 1
            arseFacing = 3
            dirFacing = "west"
            dirArseFacing = "east"
        elseif facing == 1 then
            facing = 2
            arseFacing = 0
            dirFacing = "south"
            dirArseFacing = "north"
        elseif facing == 2 then
            facing = 3
            arseFacing = 1
            dirFacing = "east"
            dirArseFacing = "west"
        elseif facing == 3 then
            facing = 0
            arseFacing = 2
            dirFacing = "north"
            dirArseFacing = "south"
        end
        
        if addReturn then
            updateWayHomeFile("turnRight", true)
            table.insert( wayHome, 1, "turnRight" )
        end

        print("Successfully turned left, now facing", dirFacing); local turnMes = "Successfully turned left, now facing", dirFacing; rednet.send(masterComputerID, turnMes, "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function turnRight(addReturn)
    turtle.turnRight()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        
        if facing == 0 then
            facing = 3
            dirFacing = 1
            arseFacing = "west"
            dirArseFacing = "east"
        elseif facing == 1 then
            facing = 0
            dirFacing = 2
            arseFacing = "south"
            dirArseFacing = "north"
        elseif facing == 2 then
            facing = 1
            dirFacing = 3
            arseFacing = "east"
            dirArseFacing = "west"
        elseif facing == 3 then
            facing = 2
            dirFacing = 0
            arseFacing = "north"
            dirArseFacing = "south"
        end
        
        if addReturn then
            updateWayHomeFile("turnLeft", true)
            table.insert( wayHome, 1, "turnLeft" )
        end

        print("Successfully turned right, now facing", dirFacing); local turnMes = "Successfully turned right, now facing", dirFacing; rednet.send(masterComputerID, turnMes, "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function returnHome()
    local f, err = io.open("miningTurtleCode/wayHomeFile.txt", "r")

    for line in f:lines() do
        table.insert(wayHome, 1, line)
    end
    f:close()

    --[[
    "moveDown"
    "moveUp"
    "moveBackwards"
    "moveForwards"
    "turnRight"
    "turnLeft"
    ]]--

    for key, item in pairs(wayHome) do
        if item == "moveDown" then
            moveDown(false)
            updateWayHomeFile(nil, false)
        elseif item == "moveUp" then
            moveUp(false)
            updateWayHomeFile(nil, false)
        elseif item == "moveBackwards" then
            moveBackwards(false)
            updateWayHomeFile(nil, false)
        elseif item == "moveForwards" then
            moveForwards(false)
            updateWayHomeFile(nil, false)
        elseif item == "turnRight" then
            turnRight(false)
            updateWayHomeFile(nil, false)
        elseif item == "turnLeft" then
            turnLeft(false)
            updateWayHomeFile(nil, false)
        end
    end

    wayHome = {}
end

function work()
    print("Work in progress")
end

function updateCoords()
    --f = io.open("miningTurtleCode/coordsTurtle.txt", "w")
    --f:write(currentX.."\n"..currentY.."\n"..currentZ.."\n"..facing.."\n"..arseFacing)
    --f:close()
end

function getCoords(axis)
    
    local f, err = io.open("miningTurtleCode/coordsTurtle.txt", "r")
    
    if axis == "x" then

        local count = 1

        if f == nil then
            print(err)
        else
            for line in f:lines() do
                if count == 1 then
                    f:close()
                    return tonumber(line)
                end
                count = count + 1
            end
        end
    end

    if axis == "y" then

        local count = 1

        if f == nil then
            print(err)
        else
            for line in f:lines() do
                if count == 2 then
                    f:close()
                    return tonumber(line)
                end
                count = count + 1
            end
        end
    end

    if axis == "z" then

        local count = 1

        if f == nil then
            print(err)
        else
            for line in f:lines() do
                if count == 3 then
                    f:close()
                    return tonumber(line)
                end
                count = count + 1
            end
        end
    end

    if axis == "face" then

        local count = 1

        if f == nil then
            print(err)
        else
            for line in f:lines() do
                if count == 4 then
                    f:close()
                    return tonumber(line)
                end
                count = count + 1
            end
        end
    end

    if axis == "arse" then

        local count = 1

        if f == nil then
            print(err)
        else
            for line in f:lines() do
                if count == 5 then
                    f:close()
                    return tonumber(line)
                end
                count = count + 1
            end
        end
    end

    f:close()
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

wayHome = {}

thisTurtleID = os.getComputerID()   -- thisTurtleID -- The ID of this turtle
masterComputerID = 12   -- masterComputerID -- The computer in control of everything
comp2ID = 19    -- relayComputerID -- The computer used to relay messages

local homeX = 572
local homeY = 64
local homeZ = 257

local currentX = getCoords("x")
local currentY = getCoords("y")
local currentZ = getCoords("z")
local facing = getCoords("face")
local arseFacing = getCoords("arse")
local dirFacing;
local dirArseFacing;

if facing == 0 then
    dirFacing = "north"
    dirArseFacing = "south"
elseif facing == 1 then
    dirFacing = "west"
    dirArseFacing = "east"
elseif facing == 2 then
    dirFacing = "south"
    dirArseFacing = "north"
elseif facing == 3 then
    dirFacing = "east"
    dirArseFacing = "west"
end

print()
print("Turtle ready to receive instructions")
print("Listeneing for messages")
print()

--[[
print("X:", currentX)
print("Y:", currentY)
print("Z:", currentZ)
print("Facing:", facing)
]]--

local compDisplay = "compDisplay"

local active = "off"
local echoed = false

while true do

    local sender, message, protocol = rednet.receive(nil, 1)

    if sender == masterComputerID then

        if message == "echo" and protocol == "instruction" then
            rednet.send(sender, "received")
            print()
            print("Echoing")
            echoed = true
        end

        if message == "off" and protocol == "instruction" then
            active = "off"
            print("Turtle off")
        end

        if message == "on" and protocol == "instruction" then
            active = "on"
            print("Turtle on")
        end

        if message == "return" and protocol == "instruction" then
            rednet.send(masterComputerID, "returningHome", "notSleep")
            print("Returning home")
            returnHome()
        end






        if message == "up" then
            moveUp(true)
        end

        if message == "down" then
            moveDown(true)
        end

        if message == "forward" then
            moveForwards(true)
        end

        if message == "back" then
            moveBackwards(true)
        end

        if message == "left" then
            turnLeft(true)
        end

        if message == "right" then
            turnRight(true)
        end






    elseif echoed and active == "on" then
        work()
    end
end