rednet.open("back")

while true do

    local sender, message, protocol = rednet.receive("relay")

    rednet.send(sender, "relayed", "relay respone")
end