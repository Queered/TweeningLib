local TweenService = game:GetService("TweenService")

local TweeningLibrary = {}

function TweeningLibrary.tween(object, properties, duration, easingStyle, easingDirection, repeatCount, reverse, delay, callback)
   easingStyle = easingStyle or Enum.EasingStyle.Linear
   easingDirection = easingDirection or Enum.EasingDirection.Out
   repeatCount = repeatCount or 0
      reverse = reverse or false
      delay = delay or 0


      if not object or not object.Parent then
         warn("TweeningLibrary.tween() failed: Invalid object")
         return
      end

      if not properties or type(properties) ~= "table" then
         warn("TweeningLibrary.tween() failed: Invalid properties")
         return
      end

      if not duration or type(duration) ~= "number" or duration <= 0 then
         warn("TweeningLibrary.tween() failed: Invalid duration")
         return
      end

      if callback and type(callback) ~= "function" then
         warn("TweeningLibrary.tween() failed: Invalid callback")
         return
      end

      local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection, repeatCount, reverse, delay)

      local tween = TweenService:Create(object, tweenInfo, properties)
      tween:Play()

      if callback then
         tween.Completed:Connect(callback)
      end

      tween.pause = function()
      tween:Pause()
   end

   tween.resume = function()
   tween:Play()
end

tween.cancel = function()
tween:Cancel()
end

return tween
end

function TweeningLibrary.tweenMultiple(objects, propertiesList, duration, easingStyle, easingDirection, repeatCount, reverse, delay, callback)
easingStyle = easingStyle or Enum.EasingStyle.Linear
easingDirection = easingDirection or Enum.EasingDirection.Out
repeatCount = repeatCount or 0
reverse = reverse or false
delay = delay or 0

if not objects or type(objects) ~= "table" or #objects == 0 then
   warn("TweeningLibrary.tweenMultiple() failed: Invalid objects")
   return
end

if not propertiesList or type(propertiesList) ~= "table" or #propertiesList == 0 then
   warn("TweeningLibrary.tweenMultiple() failed: Invalid propertiesList")
   return
end

if #objects ~= #propertiesList then
   warn("TweeningLibrary.tweenMultiple() failed: objects and propertiesList must have the same number of elements")
   return
end

if not duration or type(duration) ~= "number" or duration <= 0 then
   warn("TweeningLibrary.tweenMultiple() failed: Invalid duration")
   return
end

if callback and type(callback) ~= "function" then
   warn("TweeningLibrary.tweenMultiple() failed: Invalid callback")
   return
end

local tweens = {}

local completedTweens = {}

for i, object in ipairs(objects) do
   local properties = propertiesList[i]

   if not object or not object.Parent then
      warn("TweeningLibrary.tweenMultiple() failed: Invalid object at index " .. i)
   else
      if not properties or type(properties) ~= "table" then
         warn("TweeningLibrary.tweenMultiple() failed: Invalid properties at index " .. i)
      else
         local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection, repeatCount, reverse, delay)

         local tween = TweenService:Create(object, tweenInfo, properties)
         tween:Play()

         tween.pause = function()
         tween:Pause()
      end

      tween.resume = function()
      tween:Play()
   end

   tween.cancel = function()
   tween:Cancel()
end

table.insert(tweens, tween)
end
end
end

local function checkCompletion()
for i, tween in ipairs(tweens) do
if not tween.Completed then
return false
end
end

return true
end

local function handleCompletion(tween)

table.insert(completedTweens, tween)

if checkCompletion() and callback then
callback(completedTweens)
end
end

for i, tween in ipairs(tweens) do
tween.Completed:Connect(function()
handleCompletion(tween)
end)
end

return {tweens = tweens, completedTweens = completedTweens}

end

return TweeningLibrary
