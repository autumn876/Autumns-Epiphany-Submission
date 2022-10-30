local functions = {}
local enums = require("code.enums")
local start
local initseconds
local loop = false
local rng = RNG()
function functions.badevents(eventID,playerindex)
    local game = Game()
    local player = Game():GetPlayer(playerindex)
    local sprite = player:GetSprite()
    local room = Game():GetRoom()
    if eventID == 1 then
        if enums.common.initialized  then
            enums.badevents.ANXIETY_ATTACK=true
            if enums.badevents.ANXIETY_ATTACK then
                 if not loop then
                    
                    player:AnimateSad()
                    player.ControlsEnabled=false
                    loop = true
                else if loop then
                    if functions.wait(1000)then
                        player.ControlsEnabled=true
                        loop = false
                        enums.badevents.ANXIETY_ATTACK=false
                    end
                end
                end
                
            end
        end
    end

    if eventID==2 then
        enums.shaders.enabled=1
        enums.badevents.BLACKOUT=true
        if enums.badevents.BLACKOUT then
        --I hate you xml fuck your entire bloodline
            if not functions.wait(1000) then
                if not loop then
                    loop = true
                    local enemy = Isaac.FindInRadius(player.Position,1000,EntityPartition.ENEMY)[1]
                    if enemy == nil then enums.badevents.BLACKOUT=false else 
                        local enemypos = enemy.Position
                        enemy:Kill()
                        player.Position=enemypos
                        enums.shaders.enabled=0
                        Isaac.Spawn(EntityType.ENTITY_EFFECT,EffectVariant.BLOOD_GUSH,-1,player.Position,Vector(0,0))
                    end
                end
            else
                enums.shaders.enabled=1
                loop = false
            end
        end
    end

    --insanities to be implemented


    --phantasm enemies without collision

    --making the player code shaders
end


function functions.wait(seconds)
    
    
    if not enums.common.startedCounting then
        enums.common.startedCounting=true
        start = Isaac.GetTime()
        initseconds=seconds
    end
    if enums.common.startedCounting then
        if start == nil then start = Isaac.GetTime() end
        if initseconds== nil then initseconds=seconds end
        
        --print(Isaac.GetTime(),"is the current time",start,"is the initial timestamp",initseconds,"is the amount of time we're waiting")
        if tonumber (Isaac.GetTime()) > (start + initseconds) then
            --print("waited the time")
            enums.common.startedCounting=false
            return true
        end
    end
end

function functions.consoledebug(cmd)
    local string = tostring(string.lower(cmd))
    if string == "killsanity" then
        enums.states.SANITY=0
    end
    if string == "restoresanity" then 
        enums.states.SANITY=100
    end
    if string == "resetcount"then 
        enums.common.startedCounting=false
    end
end
return functions