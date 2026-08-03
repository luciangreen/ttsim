:- initialization(main, main).

main(_) :-
    load_files([
        'test/test_reality_model.pl',
        'test/test_simulation_clock.pl',
        'test/test_appointments.pl',
        'test/test_priority_scheduler.pl',
        'test/test_temporal_planner.pl',
        'test/test_streamlining.pl',
        'test/test_checkpoints.pl',
        'test/test_branches.pl',
        'test/test_causal_consistency.pl',
        'test/test_characters.pl',
        'test/test_bots.pl',
        'test/test_life_profiles.pl',
        'test/test_identity_continuity.pl',
        'test/test_provisional_specs.pl',
        'test/test_financial_continuity.pl',
        'test/test_creative_sessions.pl',
        'test/test_visibility.pl',
        'test/test_health_simulation.pl',
        'test/test_ethics.pl',
        'test/test_reality_dashboard.pl',
        'test/test_consent.pl',
        'test/test_persistence.pl',
        'test/test_scenarios.pl'
    ], [silent(true)]),
    run_tests.
