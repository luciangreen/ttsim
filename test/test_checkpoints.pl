:- begin_tests(checkpoints).

:- use_module('../src/real_time_travel_simulation').

test(checkpoint_and_return_creates_branch) :-
    real_time_travel_simulation:new_time_simulation(simulation_spec(name('x')), SimId),
    real_time_travel_simulation:create_checkpoint(SimId, 'cp1', CheckpointId),
    real_time_travel_simulation:return_to_checkpoint(SimId, CheckpointId, BranchId),
    sub_atom(BranchId, 0, 6, _, 'branch').

:- end_tests(checkpoints).
