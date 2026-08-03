:- begin_tests(appointments).

:- use_module('../src/appointment_model').

test(non_movable_classification) :-
    appointment_model:classify_appointment(
        appointment(a1, title('University class'), starts_at(t1), ends_at(t2), class(non_movable), source(calendar), location(campus), participants([user])),
        non_movable
    ).

:- end_tests(appointments).
