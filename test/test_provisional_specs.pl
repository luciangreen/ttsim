:- begin_tests(provisional_specs).

:- use_module('../src/provisional_specification').

test(provisional_spec_contains_assumptions) :-
    provisional_specification:construct_provisional_spec(
        [fact(one)],
        [missing_input(history_file)],
        Spec,
        uncertainty_report(assumption_count(1), missing_inputs_detected(true))
    ),
    Spec = provisional_specification(_, _, label(provisional), requires_review(true)).

:- end_tests(provisional_specs).
