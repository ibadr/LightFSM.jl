
amap = Dict(
rs_st1_1 => [rs_state1=>rs_state1],
rs_st1_2 => [rs_state1=>rs_state2],
rs_st2_1 => [rs_state2=>rs_state1],
rs_st2_2 => [rs_state2=>rs_state2],
rs_st13_2 => [rs_state1=>rs_state2,rs_state3=>rs_state2],
rs_st1_3 => [rs_state1=>rs_state3],
rs_st2_3 => [rs_state2=>rs_state3],
rs_st3_3 => [rs_state3=>rs_state3],
rs_st123_3 => [rs_state1=>rs_state3,rs_state2=>rs_state3,rs_state3=>rs_state3],
)
fsmthreestate = FiniteStateMachine(amap,rs_state2,rs_state1)

@test !finished(fsmthreestate)

@test can(fsmthreestate,rs_st2_2)
@test can(fsmthreestate,rs_st2_3)
@test can(fsmthreestate,rs_st123_3)
@test !can(fsmthreestate,rs_st13_2)
@test !can(fsmthreestate,rs_st1_1)
@test !can(fsmthreestate,rs_st3_3)

@test fire!(fsmthreestate,rs_st2_2)
@test fsmthreestate.current == rs_state2
@test fire!(fsmthreestate,rs_st123_3)
@test fsmthreestate.current == rs_state3
@test fire!(fsmthreestate,rs_st13_2)
@test fsmthreestate.current == rs_state2
@test !finished(fsmthreestate)
@test fire!(fsmthreestate,rs_st2_1)
@test fsmthreestate.current == rs_state1
@test finished(fsmthreestate)
