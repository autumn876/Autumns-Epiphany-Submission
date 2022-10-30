local sanity = require("code.sanity")
local functions = require("code.functions")

local function MC_POST_PEFFECT_UPDATE (_,player)
    sanity.QOLPostPEEfectUpdate()
    sanity.main()
end

return MC_POST_PEFFECT_UPDATE