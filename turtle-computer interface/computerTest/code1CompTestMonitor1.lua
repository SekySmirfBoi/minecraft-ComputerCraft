rednet.open("back")
local m = peripheral.wrap("left")

m.clear()
m.setCursorPos(1,1)

--rednet.send(18, "echo")

--local eSender, eMessage, eProtocol = rednet.receive(nil, 2)
--local working = false

--m.write
m.write()
m.setCursorPos(1,3-3)
m.write("   SSSSSSSSSSSSSSS         SSSSSSSSSSSSSSS      BBBBBBBBBBBBBBBBB   ")
m.setCursorPos(1,4-3)
m.write(" SS:::::::::::::::S      SS:::::::::::::::S     B::::::::::::::::B  ")
m.setCursorPos(1,5-3)
m.write("S:::::SSSSSS::::::S     S:::::SSSSSS::::::S     B::::::BBBBBB:::::B ")
m.setCursorPos(1,6-3)
m.write("S:::::S     SSSSSSS     S:::::S     SSSSSSS     BB:::::B     B:::::B")
m.setCursorPos(1,7-3)
m.write("S:::::S                 S:::::S                   B::::B     B:::::B")
m.setCursorPos(1,8-3)
m.write("S:::::S                 S:::::S                   B::::B     B:::::B")
m.setCursorPos(1,9-3)
m.write(" S::::SSSS               S::::SSSS                B::::BBBBBB:::::B ")
m.setCursorPos(1,10-3)
m.write("  SS::::::SSSSS           SS::::::SSSSS           B:::::::::::::BB  ")
m.setCursorPos(1,11-3)
m.write("    SSS::::::::SS           SSS::::::::SS         B::::BBBBBB:::::B ")
m.setCursorPos(1,12-3)
m.write("       SSSSSS::::S             SSSSSS::::S        B::::B     B:::::B")
m.setCursorPos(1,13-3)
m.write("            S:::::S                 S:::::S       B::::B     B:::::B")
m.setCursorPos(1,14-3)
m.write("            S:::::S                 S:::::S       B::::B     B:::::B")
m.setCursorPos(1,15-3)
m.write("SSSSSSS     S:::::S     SSSSSSS     S:::::S     BB:::::BBBBBB::::::B")
m.setCursorPos(1,16-3)
m.write("S::::::SSSSSS:::::S     S::::::SSSSSS:::::S     B:::::::::::::::::B ")
m.setCursorPos(1,17-3)
m.write("S:::::::::::::::SS      S:::::::::::::::SS      B::::::::::::::::B  ")
m.setCursorPos(1,18-3)
m.write(" SSSSSSSSSSSSSSS         SSSSSSSSSSSSSSS        BBBBBBBBBBBBBBBBB   ")
m.setCursorPos(1,19-3)
m.write()
m.setCursorPos(1,27-3)
m.write("   SSSSSSSSSSSSSSS         SSSSSSSSSSSSSSS      BBBBBBBBBBBBBBBBB   ")
m.setCursorPos(1,28-3)
m.write(" SS:::::::::::::::S      SS:::::::::::::::S     B::::::::::::::::B  ")
m.setCursorPos(1,29-3)
m.write("S:::::SSSSSS::::::S     S:::::SSSSSS::::::S     B::::::BBBBBB:::::B ")
m.setCursorPos(1,30-3)
m.write("S:::::S     SSSSSSS     S:::::S     SSSSSSS     BB:::::B     B:::::B")
m.setCursorPos(1,31-3)
m.write("S:::::S                 S:::::S                   B::::B     B:::::B")
m.setCursorPos(1,32-3)
m.write("S:::::S                 S:::::S                   B::::B     B:::::B")
m.setCursorPos(1,33-3)
m.write(" S::::SSSS               S::::SSSS                B::::BBBBBB:::::B ")
m.setCursorPos(1,34-3)
m.write("  SS::::::SSSSS           SS::::::SSSSS           B:::::::::::::BB  ")
m.setCursorPos(1,35-3)
m.write("    SSS::::::::SS           SSS::::::::SS         B::::BBBBBB:::::B ")
m.setCursorPos(1,36-3)
m.write("       SSSSSS::::S             SSSSSS::::S        B::::B     B:::::B")
m.setCursorPos(1,37-3)
m.write("            S:::::S                 S:::::S       B::::B     B:::::B")
m.setCursorPos(1,38-3)
m.write("            S:::::S                 S:::::S       B::::B     B:::::B")
m.setCursorPos(1,39-3)
m.write("SSSSSSS     S:::::S     SSSSSSS     S:::::S     BB:::::BBBBBB::::::B")
m.setCursorPos(1,40-3)
m.write("S::::::SSSSSS:::::S     S::::::SSSSSS:::::S     B:::::::::::::::::B ")
m.setCursorPos(1,41-3)
m.write("S:::::::::::::::SS      S:::::::::::::::SS      B::::::::::::::::B  ")
m.setCursorPos(1,42-3)
m.write(" SSSSSSSSSSSSSSS         SSSSSSSSSSSSSSS        BBBBBBBBBBBBBBBBB   ")
--m.write("Computer has started.")
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