:- begin_tests(temporal_planner).

:- use_module('../src/temporal_planner').

test(creates_real_and_simulated_schedules) :-
    Appointments = [
        appointment(uni_lecture, title('University class'), starts_at(t1), ends_at(t2), class(non_movable), source(calendar), location(campus), participants([user]))
    ],
    Tasks = [task(write_chapter, duration_hours(12), movable(true))],
    once(temporal_planner:build_temporal_plan(
        Appointments,
        Tasks,
        [simulate_days(3)],
        [],
        temporal_plan(real_schedule(Real), simulated_schedule(Sim), _, _, _, _),
        _
    )),
    once(Real \= []),
    once(Sim \= []).

:- end_tests(temporal_planner).
