function main()
    rednet.open("left")

    local speaker = peripheral.wrap("top")
    while true do
        local sender, message, protocol = rednet.receive(nil)
        if message == "found" and protocol == "atmore" then
            print(sender, "found atm ore")
            rednet.send(sender, "ok", "atmore")
            
            local playerAck = false
            while not playerAck do
                shell.run("speaker play BGM_Guardian_main_5.dfpwm")
                local event, key = os.pullEvent("key")
                if key == 257 then
                    playerAck = true
                end
                speaker.stop()
            end
            print("Continuing operation")
        end
    end
end

main()