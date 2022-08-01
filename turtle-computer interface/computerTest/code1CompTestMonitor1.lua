rednet.open("back")
local m = peripheral.wrap("left")

m.clear()
m.setCursorPos(1,1)

--rednet.send(18, "echo")

--local eSender, eMessage, eProtocol = rednet.receive(nil, 2)
--local working = false

--m.write
m.write("--------------------------------------------------------------------")
m.setCursorPos(2,1)
m.write()
m.setCursorPos(3,1)
m.write("   SSSSSSSSSSSSSSS         SSSSSSSSSSSSSSS      BBBBBBBBBBBBBBBBB   ")
m.setCursorPos(4,1)
m.write(" SS:::::::::::::::S      SS:::::::::::::::S     B::::::::::::::::B  ")
m.setCursorPos(5,1)
m.write("S:::::SSSSSS::::::S     S:::::SSSSSS::::::S     B::::::BBBBBB:::::B ")
m.setCursorPos(6,1)
m.write("S:::::S     SSSSSSS     S:::::S     SSSSSSS     BB:::::B     B:::::B")
m.setCursorPos(7,1)
m.write("S:::::S                 S:::::S                   B::::B     B:::::B")
m.setCursorPos(8,1)
m.write("S:::::S                 S:::::S                   B::::B     B:::::B")
m.setCursorPos(9,1)
m.write(" S::::SSSS               S::::SSSS                B::::BBBBBB:::::B ")
m.setCursorPos(10,1)
m.write("  SS::::::SSSSS           SS::::::SSSSS           B:::::::::::::BB  ")
m.setCursorPos(11,1)
m.write("    SSS::::::::SS           SSS::::::::SS         B::::BBBBBB:::::B ")
m.setCursorPos(12,1)
m.write("       SSSSSS::::S             SSSSSS::::S        B::::B     B:::::B")
m.setCursorPos(13,1)
m.write("            S:::::S                 S:::::S       B::::B     B:::::B")
m.setCursorPos(14,1)
m.write("            S:::::S                 S:::::S       B::::B     B:::::B")
m.setCursorPos(15,1)
m.write("SSSSSSS     S:::::S     SSSSSSS     S:::::S     BB:::::BBBBBB::::::B")
m.setCursorPos(16,1)
m.write("S::::::SSSSSS:::::S     S::::::SSSSSS:::::S     B:::::::::::::::::B ")
m.setCursorPos(17,1)
m.write("S:::::::::::::::SS      S:::::::::::::::SS      B::::::::::::::::B  ")
m.setCursorPos(18,1)
m.write(" SSSSSSSSSSSSSSS         SSSSSSSSSSSSSSS        BBBBBBBBBBBBBBBBB   ")
m.setCursorPos(19,1)
m.write()
m.setCursorPos(20,1)
m.write("--------------------------------------------------------------------")
m.setCursorPos(21,1)
m.write()
m.setCursorPos(22,1)
m.write("Computer has started.")
m.setCursorPos(23,1)
--[[
if eSender == 18 and eMessage == "received" then
    print("Turtle 1 active")
    print()
    print("Press 0 to disable turtle")
    print("Press 1 to enable turtle")
    --print("Press 2 to echo turtle")
    print()
    working = true
else
    print("Failed to get a responce from turtle")
    print()
end

local active = "off"

while working do 

    local event, arg1, arg2, arg3, arg4, arg5 = os.pullEvent()

    if event == "rednet_message" then
        local sender = arg1
        local message = arg2
        local protocol = arg3
    end
    
    
    if event == "char" and arg1 == "2" then
        rednet.send(18, "echo")
        eSender, eMessage, eProtocol = rednet.receive(nil, 2)
        if eSender == 18 and eMessage == "received" then
            print("Turtle responded")
        end
    end
    

    if event == "char" and arg1 == "0" then
        print("Turtle off")
        active = "off"
        rednet.send(18, "off", "instruction")
    end

    if event == "char" and arg1 == "1" then
        print("Turtle on")
        active = "on"
        rednet.send(18, "on", "instruction")
    end
end
]]--