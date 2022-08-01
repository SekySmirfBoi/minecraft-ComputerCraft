function returnHome()
    print("It would return if completed, but it's still in development")
end

function work()
    print("Work in progress")
end

function updateCoords()
    local f = io.open("coordsTurtle.txt", "w")
    io.write(tostring(currentX) + "\n" + tostring(currentY) + "\n" + tostring(currentZ))
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

    f:close()
end

rednet.open("right")

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

print(currentX)
print(currentY)
print(currentZ)

local active = "off"
local echoed = false

while true do

    local sender, message, protocol = rednet.receive(nil, 1)

    if sender == masterComputerID then

        if message == "echo" then
            rednet.send(sender, "received")
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