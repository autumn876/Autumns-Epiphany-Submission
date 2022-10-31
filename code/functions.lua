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
    if eventID == 1 then --anxiety attack
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

    if eventID==2 then       --blackouts
        if enums.badevents.BLACKOUT or not enums.EventUtility.EVENT_INIT then

            if not enums.EventUtility.EVENT_INIT then --event init
                print("event initialized")
                enums.badevents.BLACKOUT=true
                enums.EventUtility.EVENT_INIT = true
                enums.EventUtility.EVENT_ENDED=false
                enums.EventUtility.RESTORING_VISION=false
                enums.shaders.enabled=1
                enums.shaders.R=0
                enums.shaders.B=0
                enums.shaders.G=0
            end
            
            if not enums.EventUtility.EVENT_ENDED then
                enums.shaders.enabled=1
                local enemies = Isaac.FindInRadius(player.Position,1000,EntityPartition.ENEMY)
                for i=1,#enemies do 
                    local enemy = enemies[i]
                    if #enemies==0 then
                        print("no enemies")
                        --enums.shaders.enabled=0 
                        enums.badevents.BLACKOUT=false 
                        enums.EventUtility.EVENT_INIT=false 
                        enums.EventUtility.EVENT_ENDED=true
                        return
                    else 
                        print("enemies")
                        local enemypos = enemy.Position
                        enemy:Kill()
                        player.Position=enemypos
                        for i=0,5 do
                            Isaac.Spawn(EntityType.ENTITY_EFFECT,EffectVariant.CREEP_RED,-1,player.Position+Vector(i,0),Vector(0,0),player)
                        end
                    end
                end
            else 
                enums.EventUtility.RESTORING_VISION=true
            end
        end
    end
    --insanities 
        --75 TODO
        --60                                  anxiety
        --45 TODO  halucinations
        --25 TODO
        --15                                 blackout
        --10 TODO 
        --5  TODO be very scary
        --1  TODO break the 4th wall
        --0  TODO kill?
        --phantasm enemies without collision
        --
        -- negative 50 sanity: making the player code shaders

    --lowering sanity
        --hit 
        --mantle break as losts
        --minmaxing (taking too long on a stage)
        -- 1 every 10 seconds
        -- 5 every 10 if you take too long on the stage (see minmaxing)
        --low quality items trollface
        --bombing beggars (do this now Autumn)
    --raising sanity
        --beating bosses
        --healing (MAKE EXTRA SURE TO NERF)
        --quality 3+ items
        --beggars paying out
end

function functions.restoreVision(should)
    if should then
        local player = Game():GetPlayer(0)
        player.ControlsEnabled=false
        enums.shaders.R= enums.shaders.R+0.01
        enums.shaders.G=enums.shaders.R
        enums.shaders.B=enums.shaders.R
        if enums.shaders.R>=0.6 then
            player:AnimateSad()
            functions.reset()
        end
    end
end


function functions.reset()
    local player = Game():GetPlayer(0)
    print("resetting")
    enums.shaders.enabled=0
    enums.shaders.R=0
    enums.shaders.G=0
    enums.shaders.B=0
    enums.badevents.ANXIETY_ATTACK=false
    enums.badevents.BLACKOUT=false
    enums.EventUtility.EVENT_INIT=false
    enums.EventUtility.EVENT_ENDED=false
    enums.EventUtility.RESTORING_VISION=false
    player.ControlsEnabled=true
    enums.common.startedCounting=false
    print('reset')
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