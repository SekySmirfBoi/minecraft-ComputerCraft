running = true

function turnLeft()
    turtle.turnLeft()

function turnRight()
    turtle.turnRight()

function getItemData()
    return turtle.getItemDetail()

while running do
    local osEvent, osArg1, osArg2, osArg3, osArg4, osArg5 = os.pullEventRaw()

    if osEvent == "rednet_message" then
        local sender = osArg1
        local message = osArg2
        local protocol = osArg3

        if message == "give" then
            looking = true
            while looking do
                turnRight()
                if turtle.detect() do
                    succ, lsd, eror = turtle.inspect()
                    if lsg.name == "computercraft:turtle" or lsg.name == "computercraft:turtle_advanced" then
                        looking = false

            for i = 1, 16, 1 do
                turtle.select(i)
                if getItemData().name == "minecraft:wheat" do
                    turtle.drop()
                else
                    turtle.dropUp()
        
    running = false
