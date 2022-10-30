--todo: kms
local enums = require("code.enums")

local shaders={}

function shaders:GetShaderParams(shadername)
    if shadername == "RandomColors" then
        local params = {
            R = enums.shaders.R,
            G = enums.shaders.G,
            B = enums.shaders.B,
            Enabled = enums.shaders.enabled
           
        }
        return params
    end
end
return shaders