local enums = require("code.enums")
local insane = {}
local functions = require("code.functions")
local game = Game()
local loop = false



function insane.main ()
    local player = Isaac.GetPlayer(0)
    insane.clearEffects()
    Isaac.RenderText(tostring(enums.states.SANITY),50,50,1,1,1,1)
    if Input.IsButtonPressed(Keyboard.KEY_K,0) then
        enums.common.reset=true
    end
    if Input.IsButtonPressed(Keyboard.KEY_L,0)then
        enums.common.reset=false
    end
    local sprite = player:GetSprite()
    if Input.IsButtonPressed(Keyboard.KEY_T,0) or enums.badevents.ANXIETY_ATTACK then
        functions.badevents(1,0)
    end
    if Input.IsButtonPressed(Keyboard.KEY_Y,0) or enums.badevents.BLACKOUT then
        if #Isaac.FindInRadius(player.Position,10000,EntityPartition.ENEMY)~=0 then
        functions.badevents(2,0)
        else print("no enemies sadge") enums.EventUtility.RESTORING_VISION=true end
    end
    
end

function insane.QOLPostPEEfectUpdate()
    functions.restoreVision(enums.EventUtility.RESTORING_VISION)
    if not enums.badevents.BLACKOUT and not enums.EventUtility.RESTORING_VISION then 
        enums.shaders.enabled=0
    end
end

function insane.clearEffects ()
    if enums.common.reset then
        local player = Isaac.GetPlayer(0)
        enums.badevents.ANXIETY_ATTACK=false
        enums.badevents.BLACKOUT=false
        enums.badevents.HALUCINATIONS=false
        player.ControlsEnabled=true
        enums.shaders.enabled=0

    end
end

function insane.init ()
    print("initialized")
    enums.player.PLAYER = enums.common.game:GetPlayer(enums.player.PLAYERINDEX)
    enums.player.PLAYER_SPRITE = enums.player.PLAYER:GetSprite()
    functions.reset()
end

function insane.preleavegame()
    print("uninitialized")
    functions.reset()
    enums.common.initialized=false
end

return insane