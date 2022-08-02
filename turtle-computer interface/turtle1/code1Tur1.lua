function moveUp()
    local success, err = turtle.up()
    print(); rednet.send(masterComputerID, "", compDisplay)
    print("Fuel left: ", turtle.getFuelLevel()); local fuelMessage = "Fuel left", turtle.getFuelLevel(); rednet.send(masterComputerID, fuelMessage, compDisplay)

    if success then
        print("Successfully moved up"); rednet.send(masterComputerID, "Successfully moved up", compDisplay)
    else
        print()
        print("There was an error"); rednet.send(masterComputerID, "There was an error", compDisplay)
        print("Reason: ", err)
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
        print("Reason: ", err)
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
        print("Reason: ", err)
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
        print("Reason: ", err)
    end
end

function turnLeft()
    turtle.turnLeft()
end

function turnRight()
    turtle.turnRight()
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

print("   ")
print("Turtle ready to receive instructions")
print("Listeneing for messages")
print(" ")

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

        if message == "echo" then
            rednet.send(sender, "received")
            print()
            print("Echoing")
            echoed = true
        end

        if message == "off" then
            active = "off"
            print("Turtle off")
        end

        if message == "on" then
            active = "on"
            print("Turtle on")
        end
    elseif echoed and active == "on" then
        work()
    end
end