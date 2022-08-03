function updateWayHomeFile(move, adding, reset)

    if adding == true then
        
        local f, err = io.open("wayHomeFile.txt", "a")
        local f2, err2 = io.open("wayHomeFile.txt", "r")

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
        local f, err = io.open("wayHomeFile.txt", "r")
        local f2, err2 = io.open("wayHomeFile.txt", "w")
        local lineLength = 0

        if reset == false then
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
        end

        f:close()
        f2:close()
    end
end

function updateReturnToPathFile(move, adding)

    if adding == true then
        
        local f, err = io.open("returnToPath.txt", "a")
        local f2, err2 = io.open("returnToPath.txt", "r")

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
        local f, err = io.open("returnToPath.txt", "r")
        local f2, err2 = io.open("returnToPath.txt", "w")
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
        f2:close()
    end
end



function returnHome()
    local f, err = io.open("wayHomeFile.txt", "r")

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

        local x, y, z = gps.locate()

        if x ~= homeX or y ~= homeY or z ~= homeZ then
            if item == "moveDown" then
                moveDown(false)
                updateWayHomeFile(nil, false, false)
            elseif item == "moveUp" then
                moveUp(false)
                updateWayHomeFile(nil, false, false)
            elseif item == "moveBackwards" then
                moveBackwards(false)
                updateWayHomeFile(nil, false, false)
            elseif item == "moveForwards" then
                moveForwards(false)
                updateWayHomeFile(nil, false, false)
            elseif item == "turnRight" then
                turnRight(false)
                updateWayHomeFile(nil, false, false)
            elseif item == "turnLeft" then
                turnLeft(false)
                updateWayHomeFile(nil, false, false)
            end
        else
            local success, data = turtle.inspect()

            if data.name == nil then
                data.name = "notTheRightOne"
            end

            if data.name == "minecraft:crafting_table" then
                turtle.left()
                turtle.left()
            else

                turtle.left()
                local success, data = turtle.inspect()
                
                if data.name == nil then
                    data.name = "notTheRightOne"
                end
                if data.name == "minecraft:crafting_table" then
                    turtle.left()
                    turtle.left()
                else

                    turtle.left()
                    local success, data = turtle.inspect()
                    
                    if data.name == nil then
                        data.name = "notTheRightOne"
                    end
                    if data.name == "minecraft:crafting_table" then
                        turtle.left()
                        turtle.left()
                    else

                        turtle.left()
                        local success, data = turtle.inspect()
                        
                        if data.name == nil then
                            data.name = "notTheRightOne"
                        end
                        if data.name == "minecraft:crafting_table" then
                            turtle.left()
                            turtle.left()
                        end
                    end
                end
            end
        end
    end

    wayHome = {}
end

function returnToPath()
    local f, err = io.open("returnToPathFile.txt", "r")

    for line in f:lines() do
        table.insert(wayToPath, 1, line)
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

    for key, item in pairs(wayToPath) do
        if item == "moveDown" then
            moveDown(false)
            updateReturnToPathFile(nil, false)
        elseif item == "moveUp" then
            moveUp(false)
            updateReturnToPathFile(nil, false)
        elseif item == "moveBackwards" then
            moveBackwards(false)
            updateReturnToPathFile(nil, false)
        elseif item == "moveForwards" then
            moveForwards(false)
            updateReturnToPathFile(nil, false)
        elseif item == "turnRight" then
            turnRight(false)
            updateReturnToPathFile(nil, false)
        elseif item == "turnLeft" then
            turnLeft(false)
            updateReturnToPathFile(nil, false)
        end
    end

    wayToPath = {}
end


function moveUp(addReturnHome, addReturnToPath)
    local success, err = turtle.up()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        
        if addReturnHome then
            updateWayHomeFile("moveDown", true, false)
            table.insert( wayHome, 1, "moveDown" )
        end
        if addReturnToPath then
            updateReturnToPathFile("moveDown", true)
            table.insert( wayToPath, 1, "moveDown" )
        end
        
        print("Successfully moved up"); rednet.send(masterComputerID, "Successfully moved up", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error"); rednet.send(masterComputerID, "Unknown error", "compDisplay")
        end
    end
end

function moveDown(addReturnHome, addReturnToPath)
    
    local x, y, z = gps.locate()

    if y == 5 then
        print("Will not go below y-level 5."); rednet.send(masterComputerID, "Will not go below y-level 5.", "compDisplay")
        print("This is to prevent the turtle getting stuck under bedrock"); rednet.send(masterComputerID, "This is to prevent the turtle getting stuck under bedrock", "compDisplay")
    end
    local success, err = turtle.down()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        
        if addReturnHome then
            updateWayHomeFile("moveUp", true, false)
            table.insert( wayHome, 1, "moveUp" )
        end
        if addReturnToPath then
            updateReturnToPathFile("moveUp", true)
            table.insert( wayToPath, 1, "moveUp" )
        end

        print("Successfully moved down"); rednet.send(masterComputerID, "Successfully moved down", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error"); rednet.send(masterComputerID, "Unknown error", "compDisplay")
        end
    end
end

function moveForwards(addReturnHome, addReturnToPath)
    local success, err = turtle.forward()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        
        if addReturnHome then
            updateWayHomeFile("moveBackwards", true, false)
            table.insert( wayHome, 1, "moveBackwards" )
        end
        if addReturnToPath then
            updateReturnToPathFile("moveBackwards", true)
            table.insert( wayToPath, 1, "moveBackwards" )
        end

        print("Successfully moved forward"); rednet.send(masterComputerID, "Successfully moved forward", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error"); rednet.send(masterComputerID, "Unknown error", "compDisplay")
        end
    end
end

function moveBackwards(addReturnHome, addReturnToPath)
    local success, err = turtle.back()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

    if success then
        
        if addReturnHome then
            updateWayHomeFile("moveForwards", true, false)
            table.insert( wayHome, 1, "moveForwards" )
        end
        if addReturnToPath then
            updateReturnToPathFile("moveForwards", true)
            table.insert( wayToPath, 1, "moveForwards" )
        end

        print("Successfully moved back"); rednet.send(masterComputerID, "Successfully moved back", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error"); rednet.send(masterComputerID, "Unknown error", "compDisplay")
        end
    end
end

function turnLeft(addReturnHome, addReturnToPath)
    local success, err = turtle.turnLeft()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

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
        
        if addReturnHome then
            updateWayHomeFile("turnRight", true, false)
            table.insert( wayHome, 1, "turnRight" )
        end
        if addReturnToPath then
            updateReturnToPathFile("turnRight", true)
            table.insert( wayToPath, 1, "turnRight" )
        end

        print("Successfully turned left"); rednet.send(masterComputerID, "Successfully turned left", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error"); rednet.send(masterComputerID, "Unknown error", "compDisplay")
        end
    end
end

function turnRight(addReturnHome, addReturnToPath)
    local success, err = turtle.turnRight()
    print(); rednet.send(masterComputerID, "", "compDisplay")
    print("Fuel left: ", turtle.getFuelLevel()); rednet.send(masterComputerID, "Fuel left "..turtle.getFuelLevel(), "compDisplay")

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
        
        if addReturnHome then
            updateWayHomeFile("turnLeft", true, false)
            table.insert( wayHome, 1, "turnLeft" )
        end
        if addReturnToPath then
            updateReturnToPathFile("turnLeft", true)
            table.insert( wayToPath, 1, "turnLeft" )
        end

        print("Successfully turned right"); rednet.send(masterComputerID, "Successfully turned right", "compDisplay")
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", "compDisplay")

        if err == "Out of fuel" then
            print("Out of fuel"); rednet.send(masterComputerID, "Out of fuel", "compDisplay")
        elseif err == "Movement obstructed" then
            print("Movement obstructed"); rednet.send(masterComputerID, "Movement obstructed", "compDisplay")
        else
            print("Unknown error"); rednet.send(masterComputerID, "Unknown error", "compDisplay")
        end
    end
end

function work()
    local x, y, z = gps.locate()

    if y == 5 then
    end
    returnToPath()
end

function updateHomeCoords()

    local x, y, z = gps.locate()

    print("X: "..x)
    print("Y: "..y)
    print("Z: "..z)

    rednet.send(masterComputerID, "New home coordinates:", "compDisplay")
    rednet.send(masterComputerID, "X: "..x, "compDisplay")
    rednet.send(masterComputerID, "Y: "..y, "compDisplay")
    rednet.send(masterComputerID, "Z: "..z, "compDisplay")

    f = io.open("homeCoords.txt", "w")
    f:write(x.."\n"..y.."\n"..z)
    f:close()
end

function getCoords(axis)
    
    local f, err = io.open("homeCoords.txt", "r")
    local f2, err2 = io.open("turtleCoords.txt", "r")

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

        if f2 == nil then
            print(err2)
        else
            for line in f2:lines() do
                if count == 4 then
                    f2:close()
                    return tonumber(line)
                end
                count = count + 1
            end
        end
    end

    if axis == "arse" then

        local count = 1

        if f2 == nil then
            print(err2)
        else
            for line in f2:lines() do
                if count == 5 then
                    f2:close()
                    return tonumber(line)
                end
                count = count + 1
            end
        end
    end

    f:close()
    f2:close()
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
wayToPath = {}

thisTurtleID = os.getComputerID()   -- thisTurtleID -- The ID of this turtle
masterComputerID = 12   -- masterComputerID -- The computer in control of everything
comp2ID = 19    -- relayComputerID -- The computer used to relay messages

local homeX = getCoords("x")
local homeY = getCoords("y")
local homeZ = getCoords("z")

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

    local osEvent, osArg1, osArg2, osArg3, osArg4, osArg5 = os.pullEventRaw()

    local sender = osArg1
    local message = osArg2
    local protocol = osArg3

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

        if message == "newHome" and protocol == "instruction" then
            print("Setting new home coords as:")
            updateHomeCoords()
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

        if message == "coords" then
            local x, y, z = gps.locate()
            print("X: "..x); rednet.send(masterComputerID, x, "getCoordsX")
            print("Y: "..y); rednet.send(masterComputerID, y, "getCoordsY")
            print("Z: "..z); rednet.send(masterComputerID, z, "getCoordsZ")
        end

        if message == "emptyWayHome" then
            updateWayHomeFile(nil, false, true)
            wayHome = {}
        end




    elseif echoed and active == "on" then
        work()
    end
end