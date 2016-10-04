using LightFSM
using Base.Test

@enum SINGLESTATE ss_state1
@enum SINGLEEVENT stay

@enum TWOSTATE ts_state1 ts_state2
@enum TWOSTATEEVENTS startup st1_1 st1_2 st2_1 st2_2

include("Basics.jl")
