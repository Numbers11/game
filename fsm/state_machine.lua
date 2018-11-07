require("libs.lclass")

class "FSM"

function FSM:FSM()
    self.states = {}
    self.currentState = nil
    self.currentStateName = ""
end

function FSM:getState()
    return self.currentState, self.currentStateName
end

function FSM:addState(name, state)
    --table.insert(self.states, newState)
    self.states[name] = state
    state:setFSM(self)
    return state
end

function FSM:removeState(name)
    local state = self.states[name]
    return state
end

function FSM:setState(name)
    if self.states[name] == self.currentState then return end

    local prevstatename = self.currentStateName

    if self.currentState ~= nil then
        self.currentState:onLeave(name) --to
    end
    self.currentState = self.states[name]
    self.currentStateName = name

    self.currentState:onEnter(prevstatename) --from
end
