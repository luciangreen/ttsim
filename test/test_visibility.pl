:- begin_tests(visibility).

:- use_module('../src/visibility_modes').

test(invisibility_is_simulation_mode) :-
    visibility_modes:visibility_mode(user_1, hidden_from_simulated_characters(user_1)).

:- end_tests(visibility).
