local farmerID = 2





rednet.open("back")

recieved = false

while not recieved do
    rednet.send(farmerID, "farm")
    local osEvent, osArg1, osArg2, osArg3, osArg4, osArg5 = os.pullEventRaw()
    if osEvent == "rednet_message" then
        local sender = osArg1
        local message = osArg2

        if sender == farmerID and message = "recieved" then
            received = true
        end
    end
end
