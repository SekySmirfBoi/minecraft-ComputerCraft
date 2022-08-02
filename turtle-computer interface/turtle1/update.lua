pcall(fs.delete, "code1Tur1.lua")

local function getFilename(sUrl)
    sUrl = sUrl:gsub("[#?].*" , ""):gsub("/+$" , "")
    return sUrl:match("/([^/]+)$")
end

local res = http.get("https://github.com/SekySmirfBoi/minecraft-ComputerCraft/blob/main/turtle-computer%20interface/turtle1/code1Tur1.lua" , nil , true).readAll()
print(res)

local tArgs = { ... }
print(tArgs)

if tArgs[1] == "run" then
    table.remove(tArgs, 1)
end
print(tArgs)

local url = table.remove(tArgs, 1)
print(url)

local sFile = tArgs[1] or getFilename(url) or url
print(sFile)
--local sPath = shell.resolve(sFile)
local file, err = fs.open(shell.resolve(sFile), "wb")
print(file)
print(err)


file.write(res)
file.close()

--https://github.com/SekySmirfBoi/minecraft-ComputerCraft/blob/main/turtle-computer%20interface/turtle1/code1Tur1.lua