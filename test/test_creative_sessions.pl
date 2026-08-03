:- begin_tests(creative_sessions).

:- use_module('../src/creative_work_sessions').

test(session_created) :-
    creative_work_sessions:create_accelerated_work_session(
        task_1,
        sunday_afternoon,
        simulated_hours(12),
        compressed_timeline,
        SessionId
    ),
    sub_atom(SessionId, 0, 7, _, 'session').

:- end_tests(creative_sessions).
