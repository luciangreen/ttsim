:- begin_tests(reality_model).

:- use_module('../src/reality_model').

test(valid_label) :-
    reality_model:ensure_reality_label(simulated).

test(invalid_label, [throws(error(invalid_reality_label(fake), _))]) :-
    reality_model:ensure_reality_label(fake).

:- end_tests(reality_model).
