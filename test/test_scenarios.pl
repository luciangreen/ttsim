:- begin_tests(scenarios).

:- use_module('../src/real_time_travel_simulation').

test(demo_runs) :-
    once(real_time_travel_simulation:run_demo).

:- end_tests(scenarios).
