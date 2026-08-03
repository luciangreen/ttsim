:- module(priority_scheduler, [
    map_tasks_to_schedule/5
]).

:- use_module(library(clpfd)).
:- use_module(appointment_model).

map_tasks_to_schedule(Tasks, Appointments, _Preferences, Schedule, Explanation) :-
    include(appointment_model:non_movable, Appointments, Fixed),
    maplist(attendance_entry, Fixed, FixedSchedule),
    maplist(task_duration_hours, Tasks, Durations),
    sum_list(Durations, TotalHours),
    WorkHours #= TotalHours,
    build_task_schedule(Tasks, TaskSchedule),
    append(FixedSchedule, TaskSchedule, Schedule),
    length(FixedSchedule, FixedCount),
    format(atom(Explanation),
        'Preserved ~d non-movable appointments and scheduled ~d hours of movable work.',
        [FixedCount, WorkHours]).

attendance_entry(appointment(Id, _, _, _, _, _, _, _), attend(Id)).
attendance_entry(appointment(Id, _, _, _), attend(Id)).

task_duration_hours(task(_, duration_hours(H), _), H) :-
    integer(H),
    !.
task_duration_hours(_, 1).

build_task_schedule([], []).
build_task_schedule([task(Id, duration_hours(H), _)|Rest], [work_session(Id, evening, H)|Out]) :-
    !,
    build_task_schedule(Rest, Out).
build_task_schedule([task(Id, _, _)|Rest], [work_session(Id, evening, 1)|Out]) :-
    build_task_schedule(Rest, Out).
