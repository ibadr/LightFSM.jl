using LightFSM
using Base.Test

@enum SINGLESTATE ss_state1
@enum SINGLEEVENT stay=1

@enum TWOSTATE ts_state1 ts_state2
@enum TWOSTATEEVENTS startup=1 st1_1 st1_2 st2_1 st2_2

@enum THREESTATE rs_state1 rs_state2 rs_state3
@enum THREESTATEEVENTS rs_st1_1=1 rs_st1_2 rs_st2_1 rs_st13_2 rs_st2_2 rs_st1_3 rs_st2_3 rs_st3_3 rs_st123_3

include("Basics.jl")
include("Multistate.jl")
