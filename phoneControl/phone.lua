while true do
    shell.run("clear")
    local x,y,z = gps.locate()
    print(x)
    print(y)
    print(z)
end 