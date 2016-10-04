module LightFSM

export FiniteStateMachine,
  fire!,
  finished,
  can

type FiniteStateMachine{StateT<:Enum,EventT<:Enum}
  map::Dict{EventT,Dict{StateT,StateT}}
  current::StateT
  terminal::StateT
end

function fire!{StateT<:Enum,EventT<:Enum}(fsm::FiniteStateMachine{StateT,EventT},
  event::EventT)
  if haskey(fsm.map,event)
    fsm.current = fsm.map[event][fsm.current]
    return true
  else
    return false
  end
end

finished{StateT<:Enum,EventT<:Enum}(fsm::FiniteStateMachine{StateT,EventT}) =
  fsm.current == fsm.terminal

can{StateT<:Enum,EventT<:Enum}(fsm::FiniteStateMachine{StateT,EventT},
  event::EventT) = if haskey(fsm.map,event)
    return haskey(fsm.map[event],fsm.current)
  else
    return false
  end


end # module
