while true do
    shell.run("clear")
    sleep(0.5)
    local x,y,z = gps.locate()
    print(x)
    print(y)
    print(z)
end 

