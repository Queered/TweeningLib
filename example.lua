local TweeningLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Queered/TweeningLib/main/lib.lua"))()

-- find the Part object to move
local part = game.Workspace.Part

-- set up the properties to tween
local properties = {
    Position = part.Position + Vector3.new(0, 5, 0)
}

-- set up the reverse properties to tween
local reverseProperties = {
    Position = part.Position
}

-- set up the duration and repeat count
local duration = 1
local repeatCount = -1

-- set up the easing style and easing direction
local easingStyle = Enum.EasingStyle.Quint
local easingDirection = Enum.EasingDirection.Out

-- set up the callback function to reverse the tween
local function reverseTween()
    TweeningLibrary.tween(part, reverseProperties, duration, easingStyle, easingDirection)
end

-- set up the tween
local tween = TweeningLibrary.tween(part, properties, duration, easingStyle, easingDirection, repeatCount, true, 0, reverseTween)

-- pause and resume the tween after a delay
wait(5)
tween.pause()
wait(1)
tween.resume()

-- cancel the tween after another delay
wait(5)
tween.cancel()
