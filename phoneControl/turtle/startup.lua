local stripsToMine = 8
local blocksPerStrip = 64
local direction = "" -- This means go in the direction

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
    print(os.getComputerID())
    rednet.open("left")

    local running = true

    while running do
        print("waiting for request")
        local event, sender, message, protocol = os.pullEvent("rednet_message")

        if sender == masterPhoneID then
            print("Master has requested me")
            if protocol == "beginMine" then
                direction = message

                local fuelRequired = blocksPerStrip * stripsToMine + stripsToMine * 2
                print("Estimated fuel required:", fuelRequired)
                print("Coal required:", fuelRequired / 80)
                local stripsLeft = stripsToMine
                while stripsLeft > 0 do
                    local blocksLeft = blocksPerStrip
                    while blocksLeft > 0 do
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
                        turtle.dig()
                        turtle.forward()
                        turtle.digUp()
                        turtle.digDown()

                        turtle.turnLeft()

                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end

                        turtle.dig()
                        turtle.forward()
                        turtle.digUp()
                        turtle.digDown()

                        turtle.turnLeft() 
                        direction = "tiht"
                    else
                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end
                        turtle.dig()
                        turtle.forward()
                        turtle.digUp()
                        turtle.digDown()

                        turtle.turnRight()

                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end
                        turtle.dig()
                        turtle.forward()
                        turtle.digUp()
                        turtle.digDown()

                        turtle.turnRight()
                        direction = "left"
                    end

                    stripsLeft = stripsLeft - 1
                end
            else
                if message == "break" then
                    if protocol == "up" then
                        turtle.digUp()
                    elseif protocol == "down" then
                        turtle.digDown()
                    elseif protocol == "front" then
                        turtle.dig()
                    end
                else
                    shell.run(message)
                end
            end
        else
            print("That aint my master")
        end
    end
end


main()