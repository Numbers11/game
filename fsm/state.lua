require("libs.lclass")

class "State"

function State:State(entity)
    self.ent = entity
end

function State:setFSM(newFSM)
    self.fsm = newFSM
end