-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

require "ssk2.loadSSK"
_G.ssk.init({ measure = false })

local layers = ssk.display.quickLayers(sceneGroup,  "underlay",  "world",
									   {  "background",  "content",  "foreground" },
									   "overlay")
ssk.easyInputs.twoTouch.create(layers.underlay, { debugEn = true, keyboardEn = true } )

local tapCount = 0

local background = display.newImageRect("background.png", 1280, 1024 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local tapText = display.newText(tapCount, display.contentCenterX, 80, native.systemFont, 40)
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

function balloon.onTwoTouchLeft( self, event )
	pushBalloon()
end; listen("onTwoTouchLeft", balloon)

balloon:addEventListener("tap", pushBalloon)
