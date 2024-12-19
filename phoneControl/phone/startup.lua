local turtles = {45, 36, 47, 46}

function main()
    rednet.open("back")

    local slavesWorking = false

    print("Press enter to being mining")

    while true do
        local event, arg1, arg2 = os.pullEvent()

        if event == "rednet_message" then
            local sender = arg1
            local message = arg2

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
        else if event == "key" then
            local key = arg1
            if key == 257 then
                slavesWorking = true
                for i, id in turtles do
                    rednet.send(id, "beginMine")
                end
            end
        end 
    end
end

main()