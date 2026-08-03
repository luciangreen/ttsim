:- module(creative_work_sessions, [
    create_accelerated_work_session/5
]).

:- use_module(state_store).

create_accelerated_work_session(TaskId, RealWindow, SimulatedDuration, Method, SessionId) :-
    memberchk(Method, [
        staged_drafting,
        multi_agent_review,
        branch_comparison,
        compressed_timeline,
        simulated_sleep_and_review_cycles,
        perspective_switching,
        chapter_by_chapter_checkpoints
    ]),
    !,
    new_id(session, SessionId),
    _Session = accelerated_work_session(
        SessionId,
        task(TaskId),
        real_window(RealWindow),
        simulated_duration(SimulatedDuration),
        method(Method)
    ).
create_accelerated_work_session(_, _, _, Method, _) :-
    throw(error(invalid_accelerated_work_method(Method), creative_work_sessions/5)).
