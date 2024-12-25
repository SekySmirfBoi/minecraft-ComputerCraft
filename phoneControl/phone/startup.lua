local turtles = {}
local turtleCount = 0

function tableContains(table, value)
    for i, id in ipairs(table) do
        if (id == value) then
            return true
        end
    end
    return false
end

function main()
    rednet.open("back")

    local slavesWorking = false

    print("Press enter to being mining")

    while true do
        local event, arg1, arg2, arg3 = os.pullEventRaw()

        if event == "terminate" then
            for i, id in ipairs(turtles) do
                rednet.send(id, "terminate", "shuting down")
            end
        elseif event == "rednet_message" then
            local sender = arg1
            local message = arg2
            local protocol = arg3

            if slavesWorking then
                if message == "noFuel" then
                    print(sender, "is out of fuel")
                    print("Press enter to resume the turtles operation")

                    local wantToConttinue = false

                    while not wantToConttinue do
                        local event, key = os.pullEvent("key")
                        if key == 257 then
                            wantToConttinue = true
                        end
                    end

                    rednet.send(sender, "continue")
                end 
            end

            if protocol == "addTurtle" then
                if not tableContains(table, sender) then
                    table.insert(turtles, sender)
                    turtleCount = turtleCount + 1
                    print("Added turtle: " .. sender .. " (" .. turtleCount .. ")")
                else
                    print("Failed to add:", sender)
                end
                rednet.send(sender, "confirmed", "addTurtle")
            end 

        elseif event == "key" then
            local key = arg1
            if key == 257 then -- enter
                --print("Direction: ")
                local diretion = "right"
                if diretion == "left" or diretion == "right" then
                    slavesWorking = true
                    for i, id in ipairs(turtles) do
                        rednet.send(id, diretion, "beginMine")
                    end
                else
                    print("Bad direction")
                end

            elseif key == 328 then -- num pad 8
                for i, id in ipairs(turtles) do
                    rednet.send(id, "break", "up")
                end
            elseif key == 325 then -- num pad 5
                for i, id in ipairs(turtles) do
                    rednet.send(id, "break", "front")
                end
            elseif key == 322 then -- num pad 2
                for i, id in ipairs(turtles) do
                    rednet.send(id, "break", "down")
                end
            elseif key == 262 then -- right
                for i, id in ipairs(turtles) do
                    rednet.send(id, "turn right")
                end
            elseif key == 263 then -- left
                for i, id in ipairs(turtles) do
                    rednet.send(id, "turn left")
                end
            elseif key == 264 then -- arrow down
                for i, id in ipairs(turtles) do
                    rednet.send(id, "go back 1")
                end
            elseif key == 265 then -- arrow up
                for i, id in ipairs(turtles) do
                    rednet.send(id, "go forward 1")
                end
            elseif key == 266 then -- pgUp
                for i, id in ipairs(turtles) do
                    rednet.send(id, "go up 1")
                end
            elseif key == 267 then -- pgDown
                for i, id in ipairs(turtles) do
                    rednet.send(id, "go down 1")
                end
            end
        end 
    end
end

main()