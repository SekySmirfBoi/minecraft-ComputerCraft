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
                shell.run("speaker play https://cdn.discordapp.com/attachments/809382496415514654/1340476130603307071/BGM_Guardian_main_5.dfpwm?ex=67b27f2e&is=67b12dae&hm=848eb53349e36c7e8a95a7b12729ea6e33ab970b7a9a456ffe915b7c2d5b3f51&")
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