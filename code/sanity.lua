local enums = require("code.enums")
local insane = {}
local functions = require("code.functions")
local game = Game()
local loop = false
local rng = RNG()


function insane.main ()
    local player = Isaac.GetPlayer(0)
    --insane.clearEffects()
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
    if Input.IsButtonPressed(Keyboard.KEY_3,0) or enums.badevents.HALUCINATIONS then 
        functions.badevents(3,0)
    end
end


function insane.checkInsanity()
    local player = Game():GetPlayer(0)
    local room = Game():GetRoom()
    local chosenseed = rng:RandomInt(10000)
    --print(chosenseed)
    if not enums.EventUtility.EVENT_INIT then 
        if enums.states.SANITY<=75 then
            if enums.states.SANITY<=60 then
                if enums.states.SANITY<=45 then
                    if enums.states.SANITY<=25 then
                        if enums.states.SANITY<=15 then
                            if enums.states.SANITY<=10 then
                                if enums.states.SANITY<=5 then
                                    if enums.states.SANITY==1 then
                                        if chosenseed==4 then
                                            Isaac.DebugString("run")
                                            player.SubType=-1 --we do a little trolling
                                        end
                                    end
                                    if enums.states.SANITY<1 then
                                        player:Die() --not sure if this works 
                                        --update it works
                                    end
                                end
                            end
                            if not room:IsClear() and chosenseed<500 then
                                functions.badevents(2,0)
                            end
                        end
                    end
                    if chosenseed<100 then
                        functions.badevents(3,0)
                    end
                end
                if chosenseed<50 then 
                    --print("Ah! anxiety attack!")
                    enums.badevents.ANXIETY_ATTACK=true
                    functions.badevents(1,0)
                    return
                end
            end


        end
    else
        --print("event initialized, skipping applying affects")
        if enums.states.SANITY<1 then
            player:Die()
        end
    end
end

function insane.phantasm(player,collider,low)
    --local player2 = player:ToPlayer()

    if enums.badevents.HALUCINATIONS then 
        
        low:ToNPC()
        print(low.Type)
        if low.Type~=10 then return end
        if low.EntityCollisionClass == EntityCollisionClass.ENTCOLL_PLAYERONLY and enums.EventUtility.DISCOVERED_HALUCINATION then low:Kill()end
        
        low.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
    end
end

function insane.lowerSanityOverTime()
    if functions.wait(10000) then
        if not enums.states.MinMaxing then
            enums.states.SANITY=enums.states.SANITY-1 --autumn remember to correct this later I'm doing this for testing
        else 
            if enums.states.SANITY>=3 then
                enums.states.SANITY=enums.states.SANITY-3
            else
                enums.states.SANITY=0
            end
        end
    end
end

function insane.miscLowering()
    local beggars = Isaac.FindByType(EntityType.ENTITY_SLOT--[[, whatever variants beggars are as opposed to real slots]])
    if #beggars == 0 then return end
    local explosions = Isaac.FindByType(EntityType.ENTITY_EFFECT,EffectVariant.BOMB_EXPLOSION)
    local mamaMega = Isaac.FindByType(EntityType.ENTITY_EFFECT,EffectVariant.MAMA_MEGA_EXPLOSION)
    for _, splosion in pairs(explosions) do
        local size = splosion.SpriteScale.X
        local tokill = Isaac.FindInRadius(splosion.Position,size*75)
        for _, ent in pairs(tokill) do
            if ent.Type==EntityType.ENTITY_SLOT then
                enums.states.SANITY= enums.states.SANITY-10
                ent:Kill()
            end
        end

    end
    if #mamaMega>0 then
        enums.states.SANITY=enums.states.SANITY-5
    end
end


function insane.QOLPostPEEfectUpdate()
    local player = Game():GetPlayer(0)
    functions.restoreVision(enums.EventUtility.RESTORING_VISION)
    if not enums.badevents.ANXIETY_ATTACK then player.ControlsEnabled=true end
    if not enums.badevents.BLACKOUT and not enums.EventUtility.RESTORING_VISION then 
        enums.shaders.enabled=0
    end
    if enums.badevents.HALUCINATIONS then
        if #Isaac.FindByType(EntityType.ENTITY_GAPER)~= 0 then
            for _,entity in pairs(Isaac.FindByType(EntityType.ENTITY_GAPER)) do
                entity.CollisionDamage=0
            end
        end
    end
    for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_GUSHER))do
        if entity.EntityCollisionClass==EntityCollisionClass.ENTCOLL_PLAYERONLY then
            entity:Kill()
        end
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
    enums.common.initialized=true
    functions.reset()
end

function insane.preleavegame()
    print("uninitialized")
    functions.reset()
    enums.common.initialized=false
end

return insane