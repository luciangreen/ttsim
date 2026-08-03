:- begin_tests(simulation_clock).

:- use_module('../src/simulation_clock').

test(default_clock_modes) :-
    simulation_clock:default_clock(clock(mode(real_time), ratio(real_to_sim(1,1)), simulated_tick(0))).

test(set_ratio) :-
    simulation_clock:default_clock(Clock0),
    simulation_clock:set_clock_ratio(Clock0, real_to_sim(1, 24), Clock),
    Clock = clock(_, ratio(real_to_sim(1,24)), _).

:- end_tests(simulation_clock).
