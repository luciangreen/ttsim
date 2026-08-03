:- begin_tests(ethics).

:- use_module('../src/real_time_travel_simulation').
:- use_module('../src/compliance').

test(block_literal_time_travel) :-
    real_time_travel_simulation:ethical_check(perform_literal_time_travel(user), Findings),
    member(blocking(_), Findings).

test(prohibited_predicate_throws, [throws(error(prohibited_operation(literal_time_travel), _))]) :-
    compliance:perform_literal_time_travel(user).

:- end_tests(ethics).
