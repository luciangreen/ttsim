:- module(temporal_planner, [
    build_temporal_plan/6
]).

:- use_module(priority_scheduler).

build_temporal_plan(RealAppointments, FlexibleTasks, SimulationGoals, Constraints, TemporalPlan, Findings) :-
    map_tasks_to_schedule(FlexibleTasks, RealAppointments, Constraints, RealSchedule, Explanation),
    build_simulated_schedule(FlexibleTasks, SimulationGoals, SimulatedSchedule),
    build_mappings(FlexibleTasks, Mappings),
    TemporalPlan = temporal_plan(
        real_schedule(RealSchedule),
        simulated_schedule(SimulatedSchedule),
        mappings(Mappings),
        branches([]),
        deferred_completions([]),
        warnings([])
    ),
    Findings = [info(Explanation)].

build_simulated_schedule(Tasks, SimulationGoals, Simulated) :-
    memberchk(simulate_days(Days), SimulationGoals),
    integer(Days),
    Days > 0,
    !,
    take_days(Tasks, 1, Days, Simulated).
build_simulated_schedule(Tasks, _, Simulated) :-
    maplist(task_to_simulated_day(1), Tasks, Simulated).

task_to_simulated_day(StartDay, task(Id, duration_hours(H), _), simulated_day(DayId, Id, H)) :-
    DayId is StartDay.
task_to_simulated_day(StartDay, task(Id, _, _), simulated_day(StartDay, Id, 1)).

take_days(_, Day, Max, []) :-
    Day > Max,
    !.
take_days([], _, _, []).
take_days([task(Id, duration_hours(H), _)|Rest], Day, Max, [simulated_day(Day, Id, H)|Out]) :-
    Next is Day + 1,
    take_days(Rest, Next, Max, Out).
take_days([task(Id, _, _)|Rest], Day, Max, [simulated_day(Day, Id, 1)|Out]) :-
    Next is Day + 1,
    take_days(Rest, Next, Max, Out).

build_mappings([], []).
build_mappings([task(Id, _, _)|Rest], [
    temporal_mapping(
        Id,
        represented_as_occurring_on(simulated_period),
        actually_scheduled_for(real_future_slot),
        status(planned),
        disclosure(explicit)
    )|Out
]) :-
    build_mappings(Rest, Out).
