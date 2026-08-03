:- module(simulation_clock, [
    default_clock/1,
    set_clock_ratio/3,
    set_time_mode/3
]).

default_clock(clock(
    mode(real_time),
    ratio(real_to_sim(1,1)),
    simulated_tick(0)
)).

set_clock_ratio(clock(mode(M), ratio(_), simulated_tick(Tick)), Ratio, clock(mode(M), ratio(Ratio), simulated_tick(Tick))) :-
    Ratio = real_to_sim(Real, Sim),
    integer(Real),
    integer(Sim),
    Real > 0,
    Sim > 0,
    !.
set_clock_ratio(_, Ratio, _) :-
    throw(error(invalid_clock_ratio(Ratio), simulation_clock/2)).

set_time_mode(clock(mode(_), ratio(R), simulated_tick(Tick)), Mode, clock(mode(Mode), ratio(R), simulated_tick(Tick))) :-
    memberchk(Mode, [real_time, simulation_time, narrative_time]),
    !.
set_time_mode(_, Mode, _) :-
    throw(error(invalid_time_mode(Mode), simulation_clock/2)).
