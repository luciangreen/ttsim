:- begin_tests(branches).

:- use_module('../src/real_time_travel_simulation').

test(compare_diverged) :-
    real_time_travel_simulation:compare_branches(
        branch_000001,
        branch_000002,
        Differences,
        diverged
    ),
    Differences \= [].

:- end_tests(branches).
