:- begin_tests(reality_dashboard).

:- use_module('../src/real_time_travel_simulation').

test(dashboard_contains_real_and_simulated_context) :-
    real_time_travel_simulation:new_time_simulation(simulation_spec(name('dash')), SimId),
    real_time_travel_simulation:reality_dashboard(SimId, Dashboard),
    Dashboard = reality_dashboard(
        real_timestamp(_),
        real_location(_),
        next_real_appointment(_),
        active_simulation(SimId),
        active_branch(_),
        simulated_date(_),
        reality_warnings(_),
        pending_real_actions(_)
    ).

:- end_tests(reality_dashboard).
