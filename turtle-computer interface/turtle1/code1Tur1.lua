function moveUp()
    local success, err = turtle.up()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        print("Successfully moved up"); rednet.send(masterComputerID, "Successfully moved up", compDisplay)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function moveDown()
    local success, err = turtle.down()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        print("Successfully moved down"); rednet.send(masterComputerID, "Successfully moved down", compDisplay)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function moveForwards()
    local success, err = turtle.forward()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        print("Successfully moved forward"); rednet.send(masterComputerID, "Successfully moved forward", compDisplay)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function moveBackwads()
    local success, err = turtle.back()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        print("Successfully moved back"); rednet.send(masterComputerID, "Successfully moved back", compDisplay)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function turnLeft()
    local success, err = turtle.turnLeft()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if facing == 0 then
        facing = 1
        dirFacing = "west"
    elseif facing == 1 then
        facing = 2
        dirFacing = "south"
    elseif facing == 2 then
        facing = 3
        dirFacing = "east"
    elseif facing == 3 then
        facing = 0
        dirFacing = "north"
    end

    if success then
        print("Successfully turned left, now facing", dirFacing)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function turnRight()
    turtle.turnRight()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if facing == 0 then
        facing = 3
        dirFacing = "east"
    elseif facing == 1 then
        facing = 0
        dirFacing = "north"
    elseif facing == 2 then
        facing = 1
        dirFacing = "west"
    elseif facing == 3 then
        facing = 2
        dirFacing = "south"
    end

    if success then
        print("Successfully turned right, now facing", dirFacing)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason:", err); local errorMessage = "Reason:", err; rednet.send(masterComputerID, errorMessage, "compDisplay")
    end
end

function returnHome()
    --local disFromHomeX = 
    --local disFromHomeY = 
    --local disFromHomeZ = 
    print("It would return if completed, but it's still in development")
end

function work()
    print("Work in progress")
end

function updateCoords()
    local f = io.open("coordsTurtle.txt", "w")
    io.write(tostring(currentX) + "\n" + tostring(currentY) + "\n" + tostring(currentZ) + "\n" + tostring(facing))
    io.close(f)
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

    f:close()
end

rednet.open("right")

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
comp2ID = 19    -- relayComputerID -- The computer used to relay messages

local homeX = 572
local homeY = 64
local homeZ = 257

local currentX = getCoords("x")
local currentY = getCoords("y")
local currentZ = getCoords("z")
local facing = getCoords("face")
local dirFacing;

if facing == 0 then
    dirFacing = "north"
elseif facing == 1 then
    dirFacing = "west"
elseif facing == 2 then
    dirFacing = "south"
elseif facing == 3 then
    dirFacing = "east"
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

while true down

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

    elseif echoed and active == "on" then
        work()
    end
end