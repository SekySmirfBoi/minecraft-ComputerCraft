local stripsToMine = 16
local blocksPerStrip = 64
local direction = "right" -- This means go left

local masterPhoneID = 37


function NoFuel()
    local received = false
    while not received do
        rednet.send(masterPhoneID, "noFuel")
        sender, message = rednet.receive(nil,1)
        if sender == masterPhoneID and message == "continue" then
            received = true
        end
    end

    turtle.refuel()

    if turtle.getFuelLevel() == 0 then
        NoFuel()
    end

    return
end

function main()
    rednet.open("left")

    local running = true

    while running do
        local event, sender, message, protocol = os.pullEvent("rednet_message")

        if sender == masterPhoneID then
            if message == "beginMine" then
                local fuelRequired = blocksPerStrip * stripsToMine + stripsToMine * 2
                print("Estimated fuel required:", fuelRequired)
                print("Coal required:", fuelRequired / 80)
                local stripsLeft = stripsToMine
                while stripsLeft > 0 do
                    local blocksLeft = blocksPerStrip
                    while blocksPerStrip > 0 do
                        turtle.dig()
                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end
                        turtle.forward()
                        turtle.digUp()
                        turtle.digDown()
                        blocksLeft = blocksLeft - 1
                    end

                    if direction == "left" then
                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end
                        turtle.forward()
                        turtle.turnLeft()
                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end
                        turtle.forward()
                        turtle.turnLeft() 
                        direction = "tiht"
                    else
                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end
                        turtle.forward()
                        turtle.turnRight()
                        if turtle.getFuelLevel() == 0 then
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