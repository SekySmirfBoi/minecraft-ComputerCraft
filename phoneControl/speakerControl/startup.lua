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
                shell.run("speaker play https://cdn.discordapp.com/attachments/1119559261261938709/1320521425072951387/BGM_Guardian_main.dfpwm?ex=6769e6e9&is=67689569&hm=fbd878093baebcdfef10fd3231a50e1125a2f20da4354ccf631bceacf064063b&")
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