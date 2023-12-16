--tyty

local slaveOwner = 5


rednet.open("left")

running = true

function turnLeft()
    turtle.turnLeft()
end

function turnRight()
    turtle.turnRight()
end

function getItemData()
    return turtle.getItemDetail()
end

function famr()
    looking = true
    while looking do
        turnRight()
        if turtle.detect() then
            succ, lsd, eror = turtle.inspect()
            if lsd.name == "computercraft:turtle" or lsd.name == "computercraft:turtle_advanced" then
                looking = false
            end
        end
    end

    turnRight()
    turnRight()

    for i = 1, 9, 1 do
        if turtle.detectDown() then
            succ, blockData, eror = turtle.inspectDown()
            if blockData.name = "minecraft:wheat" then
                if blockData.state.age = 7 then
                    turtle.digDown()
                end
            end
        end
    end
end

while running do
    local osEvent, osArg1, osArg2, osArg3, osArg4, osArg5 = os.pullEventRaw()

    if osEvent == "rednet_message" then

        local sender = osArg1
        local message = osArg2
        local protocol = osArg3

        rednet.send(sender, "recieved")

        if message == "give" then
            looking = true
            while looking do
                turnRight()
                if turtle.detect() then
                    succ, lsd, eror = turtle.inspect()
                    if lsd.name == "computercraft:turtle" or lsd.name == "computercraft:turtle_advanced" then
                        looking = false
                    end
                end
            end

            for i = 1, 16, 1 do
                turtle.select(i)
                if getItemData() == nil then
                elseif getItemData().name == "minecraft:wheat" then
                    turtle.drop()
                else
                    turtle.dropUp()
                end
            end
        elseif message == "farm" then
            famr()
        end
        running = false
    
    elseif osEvent == "terminate" then
        running = false
    
    else
        if turtle.detectDown() then
            local blockData = turtle.inspectDown()
            if blockData.name == "minecraft:wheat" then
                if blockData.age == 7 then
                    famr()
                end
            end
        end
    end
end            
