local stripsToMine = 16
local blocksPerStrip = 64
local direction = "left" -- This means go left

local masterPhoneID = 37


function NoFuel()
    rednet.send(masterPhoneID, "noFuel")
    local yeahItsGood = false

    while not yeahItsGood do
        local event, sender, message, protocol = os.pullEvent("rednet_message")
        if sender == masterPhoneID and message == "continue" then
            yeahItsGood = true
        end
    end

    turtle.refuel()

    return
end

function main()
    local running = true
    
    while running do
        local event, sender, message, protocol = os.pullEvent("rednet_message")
    
        if sender == masterPhoneID then
            if message == "beginMine" then
                local stripsLeft = stripsToMine
                while stripsLeft > 0 do
                    local blocksLeft = blocksPerStrip
                    while blocksPerStrip > 0 do
                        turtle.dig()
                        if turtle.getFuelLevel() = 0 then
                            NoFuel()
                        end
                        turtle.forward()
                        turtle.digUp()
                        turtle.digDown()
                        blocksPerStrip = blocksPerStrip - 1
                    end
                
                    if direction == "left" then
                        if turtle.getFuelLevel() = 0 then
                            NoFuel()
                        end
                        turtle.forward()
                        turtle.turnLeft()
                        if turtle.getFuelLevel() = 0 then
                            NoFuel()
                        end
                        turtle.forward()
                        turtle.turnLeft() 
                        direction = "tiht"
                    else
                        if turtle.getFuelLevel() = 0 then
                            NoFuel()
                        end
                        turtle.forward()
                        turtle.turnRight()
                        if turtle.getFuelLevel() = 0 then
                            NoFuel()
                        end
                        turtle.forward()
                        turtle.turnRight()
                        direction = "left"
                    end
                
                    stripsLeft = stripsLeft - 1
                end
            end
        end
    end
end


main()