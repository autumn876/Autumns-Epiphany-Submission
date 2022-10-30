local mod = RegisterMod("sanity and fish",1)

local sanity = require("code.sanity")
local functions = require("code.functions")
local shaders = require("code.shaders")

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE,sanity.main)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT,sanity.init)
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT,sanity.preleavegame)
mod:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS,shaders.GetShaderParams)
--mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD,functions.consoledebug)