:- begin_tests(persistence).

:- use_module('../src/real_time_travel_simulation').

test(save_and_load_roundtrip) :-
    real_time_travel_simulation:new_time_simulation(simulation_spec(name('persist')), SimId),
    Path = 'test/tmp_simulation_dump.pl',
    real_time_travel_simulation:save_simulation(SimId, Path),
    real_time_travel_simulation:load_simulation(Path, NewId),
    atom(NewId),
    delete_file(Path).

:- end_tests(persistence).
