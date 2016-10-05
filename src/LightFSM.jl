module LightFSM

export FiniteStateMachine,
  fire!,
  finished,
  can

type FiniteStateMachine{StateT<:Enum,EventT<:Enum}
  map::Vector{Vector{Pair{StateT,StateT}}}
  current::StateT
  terminal::StateT
  FiniteStateMachine(map,current,terminal) =
    new(map,current,terminal)
end

FiniteStateMachine{StateT<:Enum,EventT<:Enum}(::Type{StateT},::Type{EventT}) =
  FiniteStateMachine{StateT,EventT}(Vector{Vector{Pair{StateT,StateT}}}(),instances(StateT)[1],instances(StateT)[end])

function FiniteStateMachine{StateT<:Enum,EventT<:Enum}(map::Dict{EventT,Vector{Pair{StateT,StateT}}},
  current::StateT,terminal::StateT)
  fsm = FiniteStateMachine(StateT,EventT)
  m = Vector{Vector{Pair{StateT,StateT}}}(length(instances(EventT)))
  for kv in map
    m[Int(kv[1])] = copy(kv[2])
  end
  fsm.map = m
  fsm.current = current
  fsm.terminal = terminal
  return fsm
end

function fire!{StateT<:Enum,EventT<:Enum}(fsm::FiniteStateMachine{StateT,EventT},
  event::EventT)
  found = false
  if isdefined(fsm.map,Int(event))
    @inbounds for i in 1:length(fsm.map[Int(event)])
      if fsm.current == fsm.map[Int(event)][i][1]
        fsm.current = fsm.map[Int(event)][i][2]
        found = true
        break
      end
    end
  end
  return found
end

finished{StateT<:Enum,EventT<:Enum}(fsm::FiniteStateMachine{StateT,EventT}) =
  fsm.current == fsm.terminal

function can{StateT<:Enum,EventT<:Enum}(fsm::FiniteStateMachine{StateT,EventT},
  event::EventT)
  found = false
  if isdefined(fsm.map,Int(event))
    @inbounds for i in 1:length(fsm.map[Int(event)])
      if fsm.current == fsm.map[Int(event)][i][1]
        found = true
        break
      end
    end
  end
  return found
end


end # module
