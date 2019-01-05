-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- what devices are connected to the game?
local inputDevices = system.getInputDevices()
for i = 1,#inputDevices do
    local device = inputDevices[i]
    print("device: " .. device.descriptor )
end

local tapCount = 0
local background = display.newImageRect("background.png", 1280, 1024 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local tapText = display.newText(tapCount, 50, 50, native.systemFont, 40)
tapText:setFillColor( 255, 255, 255 )

local platform = display.newImageRect("platform.png", 1280, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight-25

local balloon = display.newImageRect("balloon.png", 112, 112)
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8

local physics = require("physics")
physics.start()

physics.addBody(platform, "static")
physics.addBody(balloon, "dynamic", { radius=50, bounce=0.3 })

local function pushBalloon()
	balloon:applyLinearImpulse(0, -0.75, balloon.x, balloon.y)
	tapCount = tapCount + 1
	tapText.text = tapCount
end

local function pullBalloon()
	balloon:applyLinearImpulse(0, 0.75, balloon.x, balloon.y)
	tapCount = tapCount + 1
	tapText.text = tapCount
end

local function handleKey(press)
	local kp = press.phase
	print(kp)
	local k = press.keyName
	print(k)

	if kp == "down" and k == "up" then
		pushBalloon()
	end
	if kp == "down" and k == "down" then
		pullBalloon()
	end
end

balloon:addEventListener("tap", pushBalloon)
Runtime:addEventListener("key", handleKey)
