local stripsToMine = 8
local blocksPerStrip = 64
local direction = "" -- This means go in the direction

local masterPhoneID = 37
local speakerCpID = 42

function NoFuel()
    local received = false
    while not received do
        rednet.send(masterPhoneID, "noFuel")
        local sender, message, protocol = rednet.receive(nil,1)
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

function checkForATMore(dir)
    local succ1, data1 = turtle.inspect()
    local succ2, data2 = turtle.inspectUp()
    local succ3, data3 = turtle.inspectDown()

    if data1.name == "allthemodium:allthemodium_slate_ore" or data2.name == "allthemodium:allthemodium_slate_ore" or data3.name == "allthemodium:allthemodium_slate_ore" then
        foundATMore()
    end

    return
end

function foundATMore()
    local ack = false
    print("Found ATM ore")
    while not ack do
        rednet.send(speakerCpID, "found", "atmore")
        local sender, message, protocol = rednet.receive(nil,1)
        if sender == speakerCpID and message == "ok" and protocol == "atmore" then
            ack = true
        end
    end
    print("Acknowledgement recieved")

    local ableToContinue = false

    while not ableToContinue do
        local succ1, data1 = turtle.inspect()
        local succ2, data2 = turtle.inspectUp()
        local succ3, data3 = turtle.inspectDown()

        if data1.name == "allthemodium:allthemodium_slate_ore" or data2.name == "allthemodium:allthemodium_slate_ore" or data3.name == "allthemodium:allthemodium_slate_ore" then
            ableToContinue = false
        else
            ableToContinue = true
        end
        sleep(0.5)
    end

    print("Continuing operation")

    return
end

function main()
    rednet.open("left")
    print(os.getComputerID())
    print("Fuel left:", turtle.getFuelLevel())

    local startupCompleted = false
    while not startupCompleted do
        rednet.send(masterPhoneID, os.getComputerID, "addTurtle")
        local sender, msg, protocol = rednet.receive(nil, 1)
        if sender == masterPhoneID and msg == "confirmed" and protocol == "addTurtle" then
            startupCompleted = true
            print("I have been recognised")
        end
    end

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
                    local blocksLeft = blocksPerStrip - 1
                    while blocksLeft > 0 do
                        checkForATMore()
                        turtle.dig()
                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end 
                        turtle.forward()
                        checkForATMore()
                        turtle.digUp()
                        turtle.digDown()
                        blocksLeft = blocksLeft - 1
                    end

                    if direction == "left" then
                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end
                        checkForATMore()
                        turtle.dig()
                        turtle.forward()
                        checkForATMore()
                        turtle.digUp()
                        turtle.digDown()

                        turtle.turnLeft()

                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end

                        if stripsLeft > 1 then
                            checkForATMore()
                            turtle.dig()
                            turtle.forward()
                            checkForATMore()
                            turtle.digUp()
                            turtle.digDown()
                            turtle.turnLeft() 
                        else
                            turtle.turnRight()
                            turtle.turnRight()

                            local tempTarget = stripsToMine - 1

                            for i = 1, tempTarget do
                                turtle.forward()
                            end 

                            turtle.turnRight()
                        end


                        direction = "tiht"
                    else
                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end
                        checkForATMore()
                        turtle.dig()
                        turtle.forward()
                        checkForATMore()
                        turtle.digUp()
                        turtle.digDown()

                        turtle.turnRight()

                        if turtle.getFuelLevel() == 0 then
                            NoFuel()
                        end

                        if stripsLeft > 1 then
                            checkForATMore()
                            turtle.dig()
                            turtle.forward()
                            checkForATMore()
                            turtle.digUp()
                            turtle.digDown()
                            turtle.turnRight()
                        else
                            turtle.turnLeft()
                            turtle.turnLeft()

                            local tempTarget = stripsToMine - 1

                            for i = 1, tempTarget do
                                turtle.forward()
                            end 

                            turtle.turnLeft()
                        end
                        direction = "left"
                    end

                    stripsLeft = stripsLeft - 1
                end
            elseif protocol == "shuting down" then
                if message == "terminate" then
                    running = false
                end
            else
                if message == "break" then
                    if protocol == "up" then
                        checkForATMore()
                        turtle.digUp()
                    elseif protocol == "down" then
                        checkForATMore()
                        turtle.digDown()
                    elseif protocol == "front" then
                        checkForATMore()
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

while true do
    main()
end