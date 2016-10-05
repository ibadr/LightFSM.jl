
amap = Dict(stay=>(ss_state1=>ss_state1))
fsmsingle = FiniteStateMachine(amap,ss_state1,ss_state1)
@test fire!(fsmsingle,stay)
@test finished(fsmsingle)
@test can(fsmsingle,stay)


amap = Dict(
startup => (ts_state1=>ts_state1),
st1_1 => (ts_state1=>ts_state1),
st1_2 => (ts_state1=>ts_state2),
st2_2 => (ts_state2=>ts_state2)
)
fsmtwostate = FiniteStateMachine(amap,ts_state1,ts_state2)

@test !finished(fsmtwostate)

@test can(fsmtwostate,startup)
@test fire!(fsmtwostate,startup)
@test fsmtwostate.current == ts_state1
@test !finished(fsmtwostate)

@test can(fsmtwostate,st1_1)
@test fire!(fsmtwostate,st1_1)
@test fsmtwostate.current == ts_state1
@test !finished(fsmtwostate)

@test can(fsmtwostate,st1_2)
@test fire!(fsmtwostate,st1_2)
@test fsmtwostate.current == ts_state2
@test finished(fsmtwostate)

@test !can(fsmtwostate,st2_1)
@test !fire!(fsmtwostate,st2_1)
@test fsmtwostate.current == ts_state2
@test finished(fsmtwostate)

@test !can(fsmtwostate,st1_2)
@test !can(fsmtwostate,st1_1)
@test !can(fsmtwostate,startup)

@test can(fsmtwostate,st2_2)
@test fire!(fsmtwostate,st2_2)
@test fsmtwostate.current == ts_state2
@test finished(fsmtwostate)
