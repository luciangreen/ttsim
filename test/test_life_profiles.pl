:- begin_tests(life_profiles).

:- use_module('../src/life_profiles').

test(create_profile_term) :-
    life_profiles:create_life_profile(
        user_1,
        profile(
            id(life_1),
            role(student),
            home(home_a),
            schedule(schedule_1),
            resources([laptop]),
            financial_context(projected)
        ),
        life_profile(life_1, owner(user_1), role(student), home(home_a), schedule(schedule_1), resources([laptop]), financial_context(projected), reality_status(simulated))
    ).

:- end_tests(life_profiles).
