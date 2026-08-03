:- begin_tests(causal_consistency).

:- use_module('../src/causal_consistency').

test(detects_conflict) :-
    asserta(causal_consistency:conflicts_with(a, b)),
    causal_consistency:check_temporal_consistency(branch_1, Findings),
    retract(causal_consistency:conflicts_with(a, b)),
    member(conflict(a, b), Findings).

:- end_tests(causal_consistency).
