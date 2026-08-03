:- begin_tests(priority_scheduler).

:- use_module('../src/priority_scheduler').

test(university_event_preserved) :-
    Appointments = [
        appointment(uni_lecture, title('University class'), starts_at(t1), ends_at(t2), class(non_movable), source(calendar), location(campus), participants([user]))
    ],
    Tasks = [task(write_chapter, duration_hours(12), movable(true))],
    priority_scheduler:map_tasks_to_schedule(Tasks, Appointments, [], Schedule, _),
    once(member(attend(uni_lecture), Schedule)),
    once(member(work_session(write_chapter, evening, 12), Schedule)).

:- end_tests(priority_scheduler).
