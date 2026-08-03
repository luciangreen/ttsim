:- module(real_time_travel_simulation, [
    new_time_simulation/2,
    import_appointments/3,
    create_task/3,
    classify_appointment/3,
    build_temporal_plan/6,
    create_checkpoint/3,
    return_to_checkpoint/3,
    compare_branches/4,
    streamline_timeline/4,
    create_life_profile/3,
    try_life/5,
    begin_simulated_morning/4,
    create_accelerated_work_session/5,
    select_highlights/3,
    enter_separation_mode/2,
    reality_dashboard/2,
    promote_to_real_action/3,
    ethical_check/2,
    save_simulation/2,
    load_simulation/2,
    start_repl/0,
    run_demo/0
]).

:- use_module(state_store).
:- use_module(reality_model).
:- use_module(simulation_clock).
:- use_module(appointment_model).
:- use_module(temporal_planner, []).
:- use_module(checkpoint_manager).
:- use_module(branch_manager, []).
:- use_module(timeline_streamliner, []).
:- use_module(causal_consistency).
:- use_module(life_profiles, []).
:- use_module(virtual_locations, []).
:- use_module(creative_work_sessions, []).
:- use_module(highlight_selector, []).
:- use_module(separation_mode, []).
:- use_module(reality_dashboard, []).
:- use_module(ethics, []).
:- use_module(persistence, []).
:- use_module(repl, []).

new_time_simulation(simulation_spec(name(Name), timezone(Timezone), reality_labelling(always_visible)), SimulationId) :-
    !,
    new_id(simulation, SimulationId),
    default_clock(Clock),
    get_time(Now),
    State = _{
        id: SimulationId,
        metadata: _{
            name: Name,
            timezone: Timezone,
            reality_labelling: always_visible
        },
        reality_context: _{
            real_timestamp: Now,
            real_location: unknown,
            next_real_appointment: none,
            simulated_date: day_0,
            reality_warnings: [],
            pending_real_actions: []
        },
        simulation_clock: Clock,
        appointments: [],
        tasks: [],
        life_profiles: [],
        characters: [],
        bots: [],
        branches: [timeline_branch(branch_000001, parent_branch(none), origin_checkpoint(none), created_at(Now), status(active))],
        active_branch: branch_000001,
        checkpoints: [],
        artefacts: [],
        financial_records: [],
        consent_records: [],
        health_preferences: [],
        audit_log: [],
        deferred_completions: [],
        approvals: [],
        separation_mode: separation_mode(SimulationId, running, reason(not_requested)),
        bots_paused: false
    },
    put_state(SimulationId, State).
new_time_simulation(Spec, SimulationId) :-
    Spec = simulation_spec(name(Name)),
    !,
    new_time_simulation(
        simulation_spec(
            name(Name),
            timezone('UTC'),
            reality_labelling(always_visible)
        ),
        SimulationId
    ).

import_appointments(SimulationId, Appointments, ImportedCount) :-
    update_state(SimulationId, append_appointments(Appointments), State),
    length(State.appointments, ImportedCount),
    update_next_real_appointment(SimulationId).

append_appointments(Appointments, State0, State) :-
    append(State0.appointments, Appointments, Combined),
    State = State0.put(_{appointments: Combined}).

update_next_real_appointment(SimulationId) :-
    get_state(SimulationId, State0),
    next_non_movable(State0.appointments, Next),
    Reality0 = State0.reality_context,
    Reality = Reality0.put(_{next_real_appointment: Next}),
    put_state(SimulationId, State0.put(_{reality_context: Reality})).

next_non_movable(Appointments, Next) :-
    include(appointment_model:non_movable, Appointments, NonMovable),
    ( NonMovable = [appointment(Id, _, _, _, _, _, _, _)|_] ->
        Next = Id
    ; NonMovable = [appointment(Id, _, _, _)|_] ->
        Next = Id
    ; Next = none
    ).

create_task(SimulationId, task(Title, duration_hours(Hours), movable(Movable)), TaskId) :-
    integer(Hours),
    Hours > 0,
    !,
    new_id(task, TaskId),
    Task = task(TaskId, title(Title), duration_hours(Hours), movable(Movable)),
    update_state(SimulationId, append_task(Task), _).
create_task(_, TaskSpec, _) :-
    throw(error(invalid_task_spec(TaskSpec), create_task/3)).

append_task(Task, State0, State) :-
    append(State0.tasks, [Task], Tasks),
    State = State0.put(_{tasks: Tasks}).

classify_appointment(_SimulationId, Appointment, Class) :-
    appointment_model:classify_appointment(Appointment, Class).

build_temporal_plan(RealAppointments, FlexibleTasks, SimulationGoals, Constraints, TemporalPlan, Findings) :-
    temporal_planner:build_temporal_plan(
        RealAppointments,
        FlexibleTasks,
        SimulationGoals,
        Constraints,
        TemporalPlan,
        Findings
    ).

create_checkpoint(SimulationId, Label, CheckpointId) :-
    update_state(SimulationId, checkpoint_manager:create_checkpoint(SimulationId, Label), State),
    CheckpointId = State.last_checkpoint_id.

return_to_checkpoint(SimulationId, CheckpointId, BranchId) :-
    update_state(SimulationId, checkpoint_manager:return_to_checkpoint(SimulationId, CheckpointId), State),
    BranchId = State.active_branch.

compare_branches(BranchA, BranchB, Differences, OutcomeComparison) :-
    branch_manager:compare_branches(BranchA, BranchB, Differences, OutcomeComparison).

streamline_timeline(Timeline, Objectives, StreamlinedTimeline, RemovedSegments) :-
    timeline_streamliner:streamline_timeline(
        Timeline,
        Objectives,
        StreamlinedTimeline,
        RemovedSegments
    ).

create_life_profile(SimulationId, ProfileSpec, LifeId) :-
    new_id(life, LifeId),
    life_profiles:create_life_profile(user, profile(
        id(LifeId),
        role(ProfileSpec.role),
        home(ProfileSpec.home),
        schedule(ProfileSpec.schedule),
        resources(ProfileSpec.resources),
        financial_context(ProfileSpec.financial_context)
    ), Profile),
    update_state(SimulationId, append_life_profile(Profile), _).

append_life_profile(Profile, State0, State) :-
    append(State0.life_profiles, [Profile], Profiles),
    State = State0.put(_{life_profiles: Profiles}).

try_life(_BaseState, LifeProfile, Duration, BranchId, Outcome) :-
    new_id(branch, BranchId),
    Outcome = simulated_outcome(
        profile(LifeProfile),
        duration(Duration),
        status(completed)
    ).

begin_simulated_morning(LifeId, HomeId, Date, SceneId) :-
    virtual_locations:begin_simulated_morning(LifeId, HomeId, Date, SceneId).

create_accelerated_work_session(TaskId, RealWindow, SimulatedDuration, Method, SessionId) :-
    creative_work_sessions:create_accelerated_work_session(
        TaskId, RealWindow, SimulatedDuration, Method, SessionId
    ).

select_highlights(Timeline, SelectionCriteria, Highlights) :-
    highlight_selector:select_highlights(Timeline, SelectionCriteria, Highlights).

enter_separation_mode(SimulationId, paused) :-
    update_state(SimulationId, separation_mode:enter_separation_mode, _).

reality_dashboard(SimulationId, Dashboard) :-
    get_state(SimulationId, State),
    reality_dashboard:reality_dashboard(State, Dashboard).

promote_to_real_action(SimulatedActionId, approved, RealTaskId) :-
    !,
    atom_concat(real_action_, SimulatedActionId, RealTaskId).
promote_to_real_action(_, Status, _) :-
    throw(error(real_action_requires_approval(Status), promote_to_real_action/3)).

ethical_check(ProposedOperation, Findings) :-
    ethics:ethical_check(ProposedOperation, Findings).

save_simulation(SimulationId, Path) :-
    persistence:save_simulation(SimulationId, Path).

load_simulation(Path, SimulationId) :-
    persistence:load_simulation(Path, SimulationId).

start_repl :-
    repl:start_repl.

run_demo :-
    new_time_simulation(
        simulation_spec(
            name('Three Writing Days'),
            timezone('Australia/Melbourne'),
            reality_labelling(always_visible)
        ),
        SimulationId
    ),
    import_appointments(SimulationId, [
        appointment(
            uni_lecture,
            title('University lecture'),
            starts_at(datetime(2026,8,10,10,0,0)),
            ends_at(datetime(2026,8,10,12,0,0)),
            class(non_movable),
            source(calendar),
            location(campus),
            participants([user])
        )
    ], _),
    create_task(
        SimulationId,
        task('Write pedagogy chapter', duration_hours(12), movable(true)),
        _
    ),
    get_state(SimulationId, State),
    build_temporal_plan(
        State.appointments,
        [task(write_chapter, duration_hours(12), movable(true))],
        [simulate_days(3)],
        [],
        Plan,
        Findings
    ),
    create_checkpoint(SimulationId, 'Before accelerated writing', CheckpointId),
    return_to_checkpoint(SimulationId, CheckpointId, BranchId),
    causal_consistency:check_temporal_consistency(BranchId, _ConsistencyFindings),
    reality_dashboard(SimulationId, Dashboard),
    portray_clause(Plan),
    portray_clause(Findings),
    portray_clause(Dashboard).
