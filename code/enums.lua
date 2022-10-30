local Enums = {}

Enums.states = {
    SANITY = 100
}


Enums.common = {
    game = Game(),
    initialized = false,
    spam = false,
    startedCounting = false,
    reset = false
}

Enums.player ={
    PLAYERINDEX = 0,
    PLAYER = nil,
    PLAYER_SPRITE = nil,
    CONTROLS = true

}
Enums.badevents = {

    ANXIETY_ATTACK = false,
    BLACKOUT = false,
    HALUCINATIONS = false
}
Enums.shaders = {
    R = 0,
    G =0,
    B = 0,
    enabled = 0
}
return Enums