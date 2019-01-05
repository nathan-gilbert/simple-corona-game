-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- what (if any) devices are connected to the game?
local inputDevices = system.getInputDevices()
for i = 1,#inputDevices do
    local device = inputDevices[i]
    print("device: " .. device.descriptor )
end

local tapCount = 0

-- some boilerplate code to set up the environment of the game, what the
-- background is and what the image assests are
local background = display.newImageRect("background.png", 1280, 1024 )
background.x = display.contentCenterX
background.y = display.contentCenterY

-- display the number of "taps"
local tapText = display.newText(tapCount, 50, 50, native.systemFont, 40)
tapText:setFillColor( 255, 255, 255 )

-- the bottom platform
local platform = display.newImageRect("platform.png", 1280, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight-25

-- the balloon obviously
local balloon = display.newImageRect("balloon.png", 112, 112)
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8

-- makes the ground 'sticky', i.e. the balloon returns to it after elevated
local physics = require("physics")
physics.start()
physics.addBody(platform, "static")
physics.addBody(balloon, "dynamic", { radius=50, bounce=0.3 })

-- make the balloon move 'up'
local function pushBalloon()
	balloon:applyLinearImpulse(0, -0.75, balloon.x, balloon.y)
	tapCount = tapCount + 1
	tapText.text = tapCount
end

-- make the balloon move 'down'
local function pullBalloon()
	balloon:applyLinearImpulse(0, 0.75, balloon.x, balloon.y)
	tapCount = tapCount + 1
	tapText.text = tapCount
end

local function handleKey(press)
	local kp = press.phase
	print("Key Press: " .. kp)
	local k = press.keyName
	print("Key Name: " .. k)

	if kp == "down" and k == "up" then
		pushBalloon()
	end
	if kp == "down" and k == "down" then
		pullBalloon()
	end

	-- how would we handle left or right key presses?
end

-- what to do when you click on the balloon itself
balloon:addEventListener("tap", pushBalloon)

-- what to do when a key is pressed
Runtime:addEventListener("key", handleKey)
