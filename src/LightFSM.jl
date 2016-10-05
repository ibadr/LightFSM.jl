module LightFSM

export FiniteStateMachine,
  fire!,
  finished,
  can

type FiniteStateMachine{StateT<:Enum,EventT<:Enum}
  map::Vector{Pair{StateT,StateT}}
  current::StateT
  terminal::StateT
  FiniteStateMachine(map,current,terminal) =
    new(map,current,terminal)
end

FiniteStateMachine{StateT<:Enum,EventT<:Enum}(::Type{StateT},::Type{EventT}) =
  FiniteStateMachine{StateT,EventT}(Vector{Pair{StateT,StateT}}(),instances(StateT)[1],instances(StateT)[end])

function FiniteStateMachine{StateT<:Enum,EventT<:Enum}(map::Dict{EventT,Pair{StateT,StateT}},
  current::StateT,terminal::StateT)
  fsm = FiniteStateMachine(StateT,EventT)
  m = Vector{Pair{StateT,StateT}}(length(instances(EventT)))
  for kv in map
    m[Int(kv[1])] = kv[2]
  end
  fsm.map = m
  fsm.current = current
  fsm.terminal = terminal
  return fsm
end

function fire!{StateT<:Enum,EventT<:Enum}(fsm::FiniteStateMachine{StateT,EventT},
  event::EventT)
  if fsm.current == fsm.map[Int(event)][1]
    fsm.current = fsm.map[Int(event)][2]
    return true
  else
    return false
  end
end

finished{StateT<:Enum,EventT<:Enum}(fsm::FiniteStateMachine{StateT,EventT}) =
  fsm.current == fsm.terminal

can{StateT<:Enum,EventT<:Enum}(fsm::FiniteStateMachine{StateT,EventT},
  event::EventT) = fsm.current == fsm.map[Int(event)][1] ? true : false


end # module
