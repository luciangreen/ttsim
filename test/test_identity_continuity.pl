:- begin_tests(identity_continuity).

:- use_module('../src/identity_continuity').

test(record_created) :-
    identity_continuity:identity_continuity(
        user_1,
        life_a,
        life_b,
        shared_memory_scope(projects),
        shared_assets([drafts]),
        transition_policy(manual),
        continuity_record(user_1, life_a, life_b, projects, [drafts], manual)
    ).

:- end_tests(identity_continuity).
