function main()
    local speaker = peripheral.wrap("top")
    while true do
        local sender, message, protocol = rednet.receive()
        if message == "found" and protocol == "atmore" then
            rednet.send(sender, "ok", "atmore")
            
            local playerAck = false
            while not playerAck do
                speaker.playNote("bit", 100, 1)
                local event, key = os.pullEvent("key")
                if key == 257 then
                    playerAck = true
                end
            end
        end
    end
end

main()