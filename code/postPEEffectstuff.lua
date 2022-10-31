local sanity = require("code.sanity")
local functions = require("code.functions")

local function MC_POST_PEFFECT_UPDATE (_,player)
    sanity.QOLPostPEEfectUpdate()
    sanity.main()
    sanity.lowerSanityOverTime()
    sanity.checkInsanity()
    sanity.miscLowering()
end

return MC_POST_PEFFECT_UPDATE